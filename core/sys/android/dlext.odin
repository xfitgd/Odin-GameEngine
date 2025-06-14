#+build linux
package android

foreign import android "system:android"

/**
 * \file
 * Advanced dynamic library opening support. Most users will want to use
 * the standard [dlopen(3)](http://man7.org/linux/man-pages/man3/dlopen.3.html)
 * functionality in `<dlfcn.h>` instead.
 */

/** Bitfield definitions for `android_dlextinfo::flags`. */
DLextFlagsBits :: enum u64 {
  /**
   * When set, the `reserved_addr` and `reserved_size` fields must point to an
   * already-reserved region of address space which will be used to load the
   * library if it fits.
   *
   * If the reserved region is not large enough, loading will fail.
   */
  RESERVED_ADDRESS      = 0,

  /**
   * Like `ANDROID_DLEXT_RESERVED_ADDRESS`, but if the reserved region is not large enough,
   * the linker will choose an available address instead.
   */
  RESERVED_ADDRESS_HINT = 1,

  /**
   * When set, write the GNU RELRO section of the mapped library to `relro_fd`
   * after relocation has been performed, to allow it to be reused by another
   * process loading the same library at the same address. This implies
   * `ANDROID_DLEXT_USE_RELRO`.
   *
   * This is mainly useful for the system WebView implementation.
   */
  WRITE_RELRO           = 2,

  /**
   * When set, compare the GNU RELRO section of the mapped library to `relro_fd`
   * after relocation has been performed, and replace any relocated pages that
   * are identical with a version mapped from the file.
   *
   * This is mainly useful for the system WebView implementation.
   */
  USE_RELRO             = 3,

  /**
   * Use `library_fd` instead of opening the file by name.
   * The filename parameter is still used to identify the library.
   */
  USE_LIBRARY_FD        = 4,

  /**
   * If opening a library using `library_fd` read it starting at `library_fd_offset`.
   * This is mainly useful for loading a library stored within another file (such as uncompressed
   * inside a ZIP archive).
   * This flag is only valid when `ANDROID_DLEXT_USE_LIBRARY_FD` is set.
   */
  USE_LIBRARY_FD_OFFSET    = 5,

  /**
   * When set, do not use `stat(2)` to check if the library has already been loaded.
   *
   * This flag allows forced loading of the library in the case when for some
   * reason multiple ELF files share the same filename (because the already-loaded
   * library has been removed and overwritten, for example).
   *
   * Note that if the library has the same `DT_SONAME` as an old one and some other
   * library has the soname in its `DT_NEEDED` list, the first one will be used to resolve any
   * dependencies.
   */
  FORCE_LOAD = 6,

  // Historically we had two other options for ART.
  // They were last available in Android P.
  // Reuse these bits last!
  // ANDROID_DLEXT_FORCE_FIXED_VADDR = 0x80
  // ANDROID_DLEXT_LOAD_AT_FIXED_ADDRESS = 0x100

  /**
   * This flag used to load library in a different namespace. The namespace is
   * specified in `library_namespace`.
   *
   * This flag is for internal use only (since there is no NDK API for namespaces).
   */
  USE_NAMESPACE = 9,

  /**
   * Instructs dlopen to apply `ANDROID_DLEXT_RESERVED_ADDRESS`,
   * `ANDROID_DLEXT_RESERVED_ADDRESS_HINT`, `ANDROID_DLEXT_WRITE_RELRO` and
   * `ANDROID_DLEXT_USE_RELRO` to any libraries loaded as dependencies of the
   * main library as well.
   *
   * This means that if the main library depends on one or more not-already-loaded libraries, they
   * will be loaded consecutively into the region starting at `reserved_addr`, and `reserved_size`
   * must be large enough to contain all of the libraries. The libraries will be loaded in the
   * deterministic order constructed from the DT_NEEDED entries, rather than the more secure random
   * order used by default.
   *
   * Each library's GNU RELRO sections will be written out to `relro_fd` in the same order they were
   * loaded. This will mean that the resulting file is dependent on which of the libraries were
   * already loaded, as only the newly loaded libraries will be included, not any already-loaded
   * dependencies. The caller should ensure that the set of libraries newly loaded is consistent
   * for this to be effective.
   *
   * This is mainly useful for the system WebView implementation.
   */
  RESERVED_ADDRESS_RECURSIVE = 10,
}

DLextFlags :: bit_set[DLextFlagsBits; u64]

AllDLextFlags :: DLextFlags{
	.RESERVED_ADDRESS,
	.RESERVED_ADDRESS_HINT,
	.WRITE_RELRO,
	.USE_RELRO,
	.USE_LIBRARY_FD,
	.USE_LIBRARY_FD_OFFSET,
	.FORCE_LOAD,
	.USE_NAMESPACE,
	.RESERVED_ADDRESS_RECURSIVE
}

android_namespace_t :: struct{}

/** Used to pass Android-specific arguments to `android_dlopen_ext`. */
android_dlextinfo :: struct {
  /** A bitmask of `ANDROID_DLEXT_` enum values. */
  flags: DLextFlags,

  /** Used by `ANDROID_DLEXT_RESERVED_ADDRESS` and `ANDROID_DLEXT_RESERVED_ADDRESS_HINT`. */
  reserved_addr: rawptr,
  /** Used by `ANDROID_DLEXT_RESERVED_ADDRESS` and `ANDROID_DLEXT_RESERVED_ADDRESS_HINT`. */
  reserved_size: uint,

  /** Used by `ANDROID_DLEXT_WRITE_RELRO` and `ANDROID_DLEXT_USE_RELRO`. */
  relro_fd: i32,

  /** Used by `ANDROID_DLEXT_USE_LIBRARY_FD`. */
  library_fd: i32,
  /** Used by `ANDROID_DLEXT_USE_LIBRARY_FD_OFFSET` */
  library_fd_offset: off64_t,

  /** Used by `ANDROID_DLEXT_USE_NAMESPACE`. */
  library_namespace: ^android_namespace_t,
}

foreign android {
	/**
	 * Opens the given library. The `__filename` and `__flags` arguments are
	 * the same as for [dlopen(3)](http://man7.org/linux/man-pages/man3/dlopen.3.html),
	 * with the Android-specific flags supplied via the `flags` member of `__info`.
	 *
	 * Available since API level 21.
	 */
	android_dlopen_ext :: proc(__filename: cstring, __flags: i32, __info: ^android_dlextinfo) -> rawptr ---
}

