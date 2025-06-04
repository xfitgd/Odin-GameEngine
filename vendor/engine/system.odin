package engine

import "base:intrinsics"
import "core:fmt"
import "core:math"
import "core:math/linalg"
import "core:os"
import "core:mem"
import "core:mem/virtual"
import "core:io"
import "core:time"
import "core:reflect"
import "core:thread"
import "core:sync"
import "core:strings"
import "base:runtime"
import "core:debug/trace"

import "vendor:android"

//@(private) render_th: ^thread.Thread

@(private) exiting := false
@(private) programStart := true
@(private) loopStart := false
@(private) maxFrame : f64
@(private) deltaTime : u64
@(private) processorCoreLen : int
@(private) gClearColor : [4]f32 = {0.0, 0.0, 0.0, 1.0}

Exiting :: #force_inline proc  "contextless"() -> bool {return exiting}
dt :: #force_inline proc "contextless" () -> f64 { return f64(deltaTime) / 1000000000.0 }
dt_u64 :: #force_inline proc "contextless" () -> u64 { return deltaTime }
GetProcessorCoreLen :: #force_inline proc "contextless" () -> int { return processorCoreLen }

Init: proc()
Update: proc()
Destroy: proc()
Size: proc() = proc () {}
Activate: proc "contextless" () = proc "contextless" () {}
Close: proc "contextless" () -> bool = proc "contextless" () -> bool{ return true }

AndroidAPILevel :: enum u32 {
	Nougat = 24,
	Nougat_MR1 = 25,
	Oreo = 26,
	Oreo_MR1 = 27,
	Pie = 28,
	Q = 29,
	R = 30,
	S = 31,
	S_V2 = 32,
	Tiramisu = 33,
	UpsideDownCake = 34,
	VanillaIceCream = 35,
	Baklava = 36,
	Unknown = 0,
}

WindowsVersion :: enum {
	Windows7,
	WindowsServer2008R2,
	Windows8,
	WindowsServer2012,
	Windows8Point1,
	WindowsServer2012R2,
	Windows10,
	WindowsServer2016,
	Windows11,
	WindowsServer2019,
	WindowsServer2022,
	Unknown,
}

WindowsPlatformVersion :: struct {
	version:WindowsVersion,
	buildNumber:u32,
	servicePack:u32,
}
AndroidPlatformVersion :: struct {
	apiLevel:AndroidAPILevel,
}
LinuxPlatformVersion :: struct {
	sysName:string,
	nodeName:string,
	release:string,
	version:string,
	machine:string,
}

when is_android {
	@(private) androidPlatform:AndroidPlatformVersion
	GetPlatformVersion :: #force_inline proc "contextless" () -> AndroidPlatformVersion {
		return androidPlatform
	}
} else when ODIN_OS == .Linux {
	@(private) linuxPlatform:LinuxPlatformVersion
	GetPlatformVersion :: #force_inline proc "contextless" () -> LinuxPlatformVersion {
		return linuxPlatform
	}
} else when ODIN_OS == .Windows {
	@(private) windowsPlatform:WindowsPlatformVersion
	GetPlatformVersion :: #force_inline proc "contextless" () -> WindowsPlatformVersion {
		return windowsPlatform
	}
}



is_android :: ODIN_PLATFORM_SUBTARGET == .Android
is_mobile :: is_android
is_log :: #config(__log__, true)


@(private="file") inited := false


@(private) engineDefAllocator : runtime.Allocator

defAllocator :: proc "contextless" () -> runtime.Allocator {
	return engineDefAllocator
}

engineMain :: proc(
	windowTitle:cstring = "xfit",
	windowX:Maybe(int) = nil,
	windowY:Maybe(int) = nil,
	windowWidth:Maybe(int) = nil,
	windowHeight:Maybe(int) = nil,
	vSync:VSync = .Double,
) {
	assert(!(windowWidth != nil && windowWidth.? <= 0))
	assert(!(windowHeight != nil && windowHeight.? <= 0))

	engineDefAllocator =  runtime.default_allocator()
	systemInit()
	systemStart()
	inited = true

	__windowTitle = windowTitle
	when is_android {
		__windowX = 0
		__windowY = 0

		__android_SetApp(auto_cast android.get_android_app())
	} else {
		__windowX = windowX
		__windowY = windowY
		__windowWidth = windowWidth
		__windowHeight = windowHeight
	}
	__vSync = vSync

	when is_android {
		androidStart()
	} else {
		windowStart()

		vkStart()

		Init()

		for !exiting {
			systemLoop()
		}

		vkWaitDeviceIdle()

		Destroy()

		vkDestory()

		systemDestroy()

		systemAfterDestroy()
	}
}

@(private) systemLoop :: proc() {
	when is_android {
		//TODO
	} else {
		glfwLoop()
	}
}

@(private) systemInit :: proc() {
	monitors = mem.make_non_zeroed([dynamic]MonitorInfo)
	when is_android {
		//TODO
	} else {
		glfwSystemInit()
	}
}

@(private) systemStart :: proc() {
	when is_android {
		//TODO
	} else {
		glfwSystemStart()
	}
}

@(private) windowStart :: proc() {
	when is_android {
		//TODO
	} else {
		glfwStart()
	}
}

@(private) systemDestroy :: proc() {
	when is_android {
		//TODO
	} else {
		glfwDestroy()
		glfwSystemDestroy()
	}
}
@(private) systemAfterDestroy :: proc() {
	delete(monitors)
}

@private @thread_local trackAllocator:mem.Tracking_Allocator

StartTrackingAllocator :: proc() {
	when ODIN_DEBUG {
		mem.tracking_allocator_init(&trackAllocator, context.allocator)
		context.allocator = mem.tracking_allocator(&trackAllocator)
	}
}

DestroyTrackAllocator :: proc() {
	when ODIN_DEBUG {
		if len(trackAllocator.allocation_map) > 0 {
			fmt.eprintf("=== %v allocations not freed: ===\n", len(trackAllocator.allocation_map))
			for _, entry in trackAllocator.allocation_map {
				fmt.eprintf("- %v bytes @ %v\n", entry.size, entry.location)
			}
		}
		if len(trackAllocator.bad_free_array) > 0 {
			fmt.eprintf("=== %v incorrect frees: ===\n", len(trackAllocator.bad_free_array))
			for entry in trackAllocator.bad_free_array {
				fmt.eprintf("- %p @ %v\n", entry.memory, entry.location)
			}
		}
		mem.tracking_allocator_destroy(&trackAllocator)
	}
}


when is_android {
	print :: proc(args: ..any, sep := " ", flush := true) -> int {
		_ = flush
		cstr := fmt.caprint(..args, sep=sep)
		defer delete(cstr)
		return auto_cast android.__android_log_write(android.LogPriority.INFO, ODIN_BUILD_PROJECT_NAME, cstr)
	}
	println  :: print
	printf   :: proc(_fmt: string, args: ..any, flush := true) -> int {
		_ = flush
		cstr := fmt.caprintf(_fmt, ..args)
		defer delete(cstr)
		return auto_cast android.__android_log_write(android.LogPriority.INFO, ODIN_BUILD_PROJECT_NAME, cstr)
	}
	printfln :: printf
	printCustomAndroid :: proc(args: ..any, logPriority: android.LogPriority = .INFO, sep := " ") -> int {
		cstr := fmt.caprint(..args, sep=sep)
		defer delete(cstr)
		return auto_cast android.__android_log_write(logPriority, ODIN_BUILD_PROJECT_NAME, cstr)
	}
} else {
	println :: fmt.println
	printfln :: fmt.printfln
	printf :: fmt.printf
	print :: fmt.print
	printCustomAndroid :: proc(args: ..any, logPriority: android.LogPriority = .INFO, sep := " ") -> int {
		_ = logPriority
		return print(..args, sep = sep)
	}
}

// @(private) CreateRenderFuncThread :: proc() {
// 	render_th = thread.create_and_start(RenderFunc)
// }

// @(private) RenderFunc :: proc() {
// 	vkStart()

// 	Init()

// 	for !exiting {
// 		RenderLoop()
// 	}

// 	vkWaitDeviceIdle()

// 	Destroy()

// 	vkDestory()
// }

@(private) RenderLoop :: proc() {
	@static start:time.Time
	@static now:time.Time
	Paused_ := Paused()

	if !loopStart {
		loopStart = true
		start = time.now()
		now = start
	} else {
		maxFrame_ := GetMaxFrame()
		if Paused_ && maxFrame_ == 0 {
			maxFrame_ = 60
		}
		n := time.now()
		delta := n._nsec - now._nsec

		if maxFrame_ > 0 {
			maxF := u64(1 * (1 / maxFrame_)) * 1000000000
			if maxF > auto_cast delta {
				time.sleep(auto_cast (i64(maxF) - delta))
				n = time.now()
				delta = n._nsec - now._nsec
			}
		}
		now = n
		deltaTime = auto_cast delta
	}
	Update()

	if !Paused_ {
		vkDrawFrame()
	}
}

GetMaxFrame :: #force_inline proc "contextless" () -> f64 {
	return intrinsics.atomic_load_explicit(&maxFrame,.Relaxed)
}


GetFPS :: #force_inline proc "contextless" () -> f64 {
	if deltaTime == 0 do return 0
	return 1.0 / dt()
}

SetMaxFrame :: #force_inline proc "contextless" (_maxframe: f64) {
	intrinsics.atomic_store_explicit(&maxFrame, _maxframe, .Relaxed)
}

//_int * 1000000000 + _dec
SecondToNanoSecond :: #force_inline proc "contextless" (_int: $T, _dec: T) -> T where intrinsics.type_is_integer(T) {
    return _int * 1000000000 + _dec
}

SecondToNanoSecond2 :: #force_inline proc "contextless" (_sec: $T, _milisec: T, _usec: T, _nsec: T) -> T where intrinsics.type_is_integer(T) {
    return _sec * 1000000000 + _milisec * 1000000 + _usec * 1000 + _nsec
}

Android_AssetFileError :: enum {
	None,
	Err
}

when is_android {
	Android_AssetReadFile :: proc(path:string, allocator := context.allocator) -> (data:[]u8, err:Android_AssetFileError = .None) {
		pathT := strings.clone_to_cstring(path, context.temp_allocator)
		defer delete(pathT, context.temp_allocator)
		
		asset := android.AAssetManager_open(android_GetAssetManager(), pathT, .BUFFER)
		__size := android.AAsset_getLength64(asset)

		data = mem.make_non_zeroed_slice([]u8, auto_cast __size, allocator)

		__read : type_of(__size) = 0
		for __read < __size {
			i := android.AAsset_read(asset, auto_cast &data[__read], auto_cast(__size - __read))
			if i < 0 {
				delete(data)
				err = .Err
				break
			} else if i == 0 {
				break
			}
			__read += auto_cast i
		}
		android.AAsset_close(asset)
		return
	}
}

IsInMainThread :: #force_inline proc "contextless" () -> bool {
	return sync.current_thread_id() == vkThreadId
}