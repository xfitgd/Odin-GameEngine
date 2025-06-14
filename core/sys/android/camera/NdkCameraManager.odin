#+build linux
package camerandk

foreign import camerandk "system:camera2ndk"

/**
 * ACameraManager is opaque type that provides access to camera service.
 *
 * A pointer can be obtained using {@link ACameraManager_create} method.
 */
ACameraManager :: struct{}


/**
 * A listener for camera devices becoming available or unavailable to open.
 *
 * <p>Cameras become available when they are no longer in use, or when a new
 * removable camera is connected. They become unavailable when some
 * application or service starts using a camera, or when a removable camera
 * is disconnected.</p>
 *
 * @see ACameraManager_registerAvailabilityCallback
 */
ACameraManager_AvailabilityCallbacks :: struct {
    /// Optional application context.
	_context: rawptr,
    /// Called when a camera becomes available
    onCameraAvailable: ACameraManager_AvailabilityCallback,
    /// Called when a camera becomes unavailable
    onCameraUnavailable: ACameraManager_AvailabilityCallback,
}

/**
 * A listener for camera devices becoming available/unavailable to open or when
 * the camera access permissions change.
 *
 * <p>Cameras become available when they are no longer in use, or when a new
 * removable camera is connected. They become unavailable when some
 * application or service starts using a camera, or when a removable camera
 * is disconnected.</p>
 *
 * @see ACameraManager_registerExtendedAvailabilityCallback
 */
ACameraManager_ExtendedAvailabilityCallbacks :: struct {
    /// Called when a camera becomes available or unavailable
	availabilityCallbacks: ACameraManager_AvailabilityCallbacks,

    /// Called when there is camera access permission change
    onCameraAccessPrioritiesChanged: ACameraManager_AccessPrioritiesChangedCallback,

    /// Called when a physical camera becomes available
    onPhysicalCameraAvailable: ACameraManager_PhysicalCameraAvailabilityCallback,

    /// Called when a physical camera becomes unavailable
    onPhysicalCameraUnavailable: ACameraManager_PhysicalCameraAvailabilityCallback,

    /// Reserved for future use, please ensure that all entries are set to NULL
    reserved: [4]rawptr,
}

/**
 * Definition of camera availability callbacks.
 *
 * @param context The optional application context provided by user in
 *                {@link ACameraManager_AvailabilityCallbacks}.
 * @param cameraId The ID of the camera device whose availability is changing. The memory of this
 *                 argument is owned by camera framework and will become invalid immediately after
 *                 this callback returns.
 */
ACameraManager_AvailabilityCallback :: #type proc "c" (_context: rawptr, cameraId: cstring)

/**
 * Definition of physical camera availability callbacks.
 *
 * @param context The optional application context provided by user in
 *                {@link ACameraManager_AvailabilityCallbacks}.
 * @param cameraId The ID of the logical multi-camera device whose physical camera status is
 *                 changing. The memory of this argument is owned by camera framework and will
 *                 become invalid immediately after this callback returns.
 * @param physicalCameraId The ID of the physical camera device whose status is changing. The
 *                 memory of this argument is owned by camera framework and will become invalid
 *                 immediately after this callback returns.
 */
ACameraManager_PhysicalCameraAvailabilityCallback :: #type proc "c" (_context: rawptr, cameraId: cstring, physicalCameraId: cstring)

/**
 * Definition of camera access permission change callback.
 *
 * <p>Notification that camera access priorities have changed and the camera may
 * now be openable. An application that was previously denied camera access due to
 * a higher-priority user already using the camera, or that was disconnected from an
 * active camera session due to a higher-priority user trying to open the camera,
 * should try to open the camera again if it still wants to use it.  Note that
 * multiple applications may receive this callback at the same time, and only one of
 * them will succeed in opening the camera in practice, depending on exact access
 * priority levels and timing. This method is useful in cases where multiple
 * applications may be in the resumed state at the same time, and the user switches
 * focus between them, or if the current camera-using application moves between
 * full-screen and Picture-in-Picture (PiP) states. In such cases, the camera
 * available/unavailable callbacks will not be invoked, but another application may
 * now have higher priority for camera access than the current camera-using
 * application.</p>

 * @param context The optional application context provided by user in
 *                {@link ACameraManager_AvailabilityListener}.
 */
ACameraManager_AccessPrioritiesChangedCallback :: #type proc "c" (_context: rawptr)


foreign camerandk {
	/**
	 * Create ACameraManager instance.
	 *
	 * <p>The ACameraManager is responsible for
	 * detecting, characterizing, and connecting to {@link ACameraDevice}s.</p>
	 *
	 * <p>The caller must call {@link ACameraManager_delete} to free the resources once it is done
	 * using the ACameraManager instance.</p>
	 *
	 * @return a {@link ACameraManager} instance.
	 *
	 */
	ACameraManager_create :: proc() -> ^ACameraManager ---

	/**
	* <p>Delete the {@link ACameraManager} instance and free its resources. </p>
	*
	* @param manager the {@link ACameraManager} instance to be deleted.
	*/
	ACameraManager_delete :: proc(manager: ^ACameraManager) ---

	/**
	* Create a list of currently connected camera devices, including
	* cameras that may be in use by other camera API clients.
	*
	* <p>Non-removable cameras use integers starting at 0 for their
	* identifiers, while removable cameras have a unique identifier for each
	* individual device, even if they are the same model.</p>
	*
	* <p>ACameraManager_getCameraIdList will allocate and return an {@link ACameraIdList}.
	* The caller must call {@link ACameraManager_deleteCameraIdList} to free the memory</p>
	*
	* <p>Note: the returned camera list might be a subset to the output of <a href=
	* "https://developer.android.com/reference/android/hardware/camera2/CameraManager.html#getCameraIdList()">
	* SDK CameraManager#getCameraIdList API</a> as the NDK API does not support some legacy camera
	* hardware.</p>
	*
	* @param manager the {@link ACameraManager} of interest
	* @param cameraIdList the output {@link ACameraIdList} will be filled in here if the method call
	*        succeeds.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if manager or cameraIdList is NULL.</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_DISCONNECTED} if connection to camera service fails.</li>
	*         <li>{@link ACAMERA_ERROR_NOT_ENOUGH_MEMORY} if allocating memory fails.</li></ul>
	*/
	ACameraManager_getCameraIdList :: proc(manager: ^ACameraManager, cameraIdList: ^^ACameraIdList) -> CameraStatus ---

	/**
	* Delete a list of camera devices allocated via {@link ACameraManager_getCameraIdList}.
	*
	* @param cameraIdList the {@link ACameraIdList} to be deleted.
	*/
	ACameraManager_deleteCameraIdList :: proc(cameraIdList: ^ACameraIdList) ---

	/**
	* Register camera availability callbacks.
	*
	* <p>onCameraUnavailable will be called whenever a camera device is opened by any camera API client.
	* Other camera API clients may still be able to open such a camera device, evicting the existing
	* client if they have higher priority than the existing client of a camera device.
	* See {@link ACameraManager_openCamera} for more details.</p>
	*
	* <p>The callbacks will be called on a dedicated thread shared among all ACameraManager
	* instances.</p>
	*
	* <p>Since this callback will be registered with the camera service, remember to unregister it
	* once it is no longer needed otherwise the callback will continue to receive events
	* indefinitely and it may prevent other resources from being released. Specifically, the
	* callbacks will be invoked independently of the general activity lifecycle and independently
	* of the state of individual ACameraManager instances.</p>
	*
	* @param manager the {@link ACameraManager} of interest.
	* @param callback the {@link ACameraManager_AvailabilityCallbacks} to be registered.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if manager or callback is NULL, or
	*                  {ACameraManager_AvailabilityCallbacks#onCameraAvailable} or
	*                  {ACameraManager_AvailabilityCallbacks#onCameraUnavailable} is NULL.</li></ul>
	*/
	ACameraManager_registerAvailabilityCallback :: proc(manager: ^ACameraManager, callback: ^ACameraManager_AvailabilityCallbacks) -> CameraStatus ---

	/**
	* Unregister camera availability callbacks.
	*
	* <p>Removing a callback that isn't registered has no effect.</p>
	*
	* <p>This function must not be called with a mutex lock also held by
	* the availability callbacks.</p>
	*
	* @param manager the {@link ACameraManager} of interest.
	* @param callback the {@link ACameraManager_AvailabilityCallbacks} to be unregistered.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if callback,
	*                  {ACameraManager_AvailabilityCallbacks#onCameraAvailable} or
	*                  {ACameraManager_AvailabilityCallbacks#onCameraUnavailable} is NULL.</li></ul>
	*/
	ACameraManager_unregisterAvailabilityCallback :: proc(manager: ^ACameraManager, callback: ^ACameraManager_AvailabilityCallbacks) -> CameraStatus ---

	/**
	* Query the capabilities of a camera device. These capabilities are
	* immutable for a given camera.
	*
	* <p>See {@link ACameraMetadata} document and {@link NdkCameraMetadataTags.h} for more details.</p>
	*
	* <p>The caller must call {@link ACameraMetadata_free} to free the memory of the output
	* characteristics.</p>
	*
	* @param manager the {@link ACameraManager} of interest.
	* @param cameraId the ID string of the camera device of interest.
	* @param characteristics the output {@link ACameraMetadata} will be filled here if the method call
	*        succeeeds.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if manager, cameraId, or characteristics
	*                  is NULL, or cameraId does not match any camera devices connected.</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_DISCONNECTED} if connection to camera service fails.</li>
	*         <li>{@link ACAMERA_ERROR_NOT_ENOUGH_MEMORY} if allocating memory fails.</li>
	*         <li>{@link ACAMERA_ERROR_UNKNOWN} if the method fails for some other reasons.</li></ul>
	*/
	ACameraManager_getCameraCharacteristics :: proc(manager: ^ACameraManager, cameraId: cstring, characteristics: ^^ACameraMetadata) -> CameraStatus ---

	/**
	* Open a connection to a camera with the given ID. The opened camera device will be
	* returned in the `device` parameter.
	*
	* <p>Use {@link ACameraManager_getCameraIdList} to get the list of available camera
	* devices. Note that even if an id is listed, open may fail if the device
	* is disconnected between the calls to {@link ACameraManager_getCameraIdList} and
	* {@link ACameraManager_openCamera}, or if a higher-priority camera API client begins using the
	* camera device.</p>
	*
	* <p>Devices for which the
	* {@link ACameraManager_AvailabilityCallbacks#onCameraUnavailable} callback has been called due to
	* the device being in use by a lower-priority, background camera API client can still potentially
	* be opened by calling this method when the calling camera API client has a higher priority
	* than the current camera API client using this device.  In general, if the top, foreground
	* activity is running within your application process, your process will be given the highest
	* priority when accessing the camera, and this method will succeed even if the camera device is
	* in use by another camera API client. Any lower-priority application that loses control of the
	* camera in this way will receive an
	* {@link ACameraDevice_StateCallbacks#onDisconnected} callback.</p>
	*
	* <p>Once the camera is successfully opened,the ACameraDevice can then be set up
	* for operation by calling {@link ACameraDevice_createCaptureSession} and
	* {@link ACameraDevice_createCaptureRequest}.</p>
	*
	* <p>If the camera becomes disconnected after this function call returns,
	* {@link ACameraDevice_StateCallbacks#onDisconnected} with a
	* ACameraDevice in the disconnected state will be called.</p>
	*
	* <p>If the camera runs into error after this function call returns,
	* {@link ACameraDevice_StateCallbacks#onError} with a
	* ACameraDevice in the error state will be called.</p>
	*
	* @param manager the {@link ACameraManager} of interest.
	* @param cameraId the ID string of the camera device to be opened.
	* @param callback the {@link ACameraDevice_StateCallbacks} associated with the opened camera device.
	* @param device the opened {@link ACameraDevice} will be filled here if the method call succeeds.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if manager, cameraId, callback, or device
	*                  is NULL, or cameraId does not match any camera devices connected.</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_DISCONNECTED} if connection to camera service fails.</li>
	*         <li>{@link ACAMERA_ERROR_NOT_ENOUGH_MEMORY} if allocating memory fails.</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_IN_USE} if camera device is being used by a higher
	*                   priority camera API client.</li>
	*         <li>{@link ACAMERA_ERROR_MAX_CAMERA_IN_USE} if the system-wide limit for number of open
	*                   cameras or camera resources has been reached, and more camera devices cannot be
	*                   opened until previous instances are closed.</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_DISABLED} if the camera is disabled due to a device
	*                   policy, and cannot be opened.</li>
	*         <li>{@link ACAMERA_ERROR_PERMISSION_DENIED} if the application does not have permission
	*                   to open camera.</li>
	*         <li>{@link ACAMERA_ERROR_UNKNOWN} if the method fails for some other reasons.</li></ul>
	*/
	ACameraManager_openCamera :: proc(manager: ^ACameraManager, cameraId: cstring, callback: ^ACameraDevice_StateCallbacks, device: ^^ACameraDevice) -> CameraStatus ---


	/**
	* Register camera extended availability callbacks.
	*
	* <p>onCameraUnavailable will be called whenever a camera device is opened by any camera API
	* client. Other camera API clients may still be able to open such a camera device, evicting the
	* existing client if they have higher priority than the existing client of a camera device.
	* See {@link ACameraManager_openCamera} for more details.</p>
	*
	* <p>The callbacks will be called on a dedicated thread shared among all ACameraManager
	* instances.</p>
	*
	* <p>Since this callback will be registered with the camera service, remember to unregister it
	* once it is no longer needed otherwise the callback will continue to receive events
	* indefinitely and it may prevent other resources from being released. Specifically, the
	* callbacks will be invoked independently of the general activity lifecycle and independently
	* of the state of individual ACameraManager instances.</p>
	*
	* @param manager the {@link ACameraManager} of interest.
	* @param callback the {@link ACameraManager_ExtendedAvailabilityCallbacks} to be registered.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if manager or callback is NULL, or
	*                  {ACameraManager_ExtendedAvailabilityCallbacks#onCameraAccessPrioritiesChanged}
	*                  or {ACameraManager_AvailabilityCallbacks#onCameraAvailable} or
	*                  {ACameraManager_AvailabilityCallbacks#onCameraUnavailable} is NULL.</li></ul>
	*/
	ACameraManager_registerExtendedAvailabilityCallback :: proc(manager: ^ACameraManager, callback: ^ACameraManager_ExtendedAvailabilityCallbacks) -> CameraStatus ---

	/**
	* Unregister camera extended availability callbacks.
	*
	* <p>Removing a callback that isn't registered has no effect.</p>
	*
	* <p>This function must not be called with a mutex lock also held by
	* the extended availability callbacks.</p>
	*
	* @param manager the {@link ACameraManager} of interest.
	* @param callback the {@link ACameraManager_ExtendedAvailabilityCallbacks} to be unregistered.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if callback,
	*                  {ACameraManager_ExtendedAvailabilityCallbacks#onCameraAccessPrioritiesChanged}
	*                  or {ACameraManager_AvailabilityCallbacks#onCameraAvailable} or
	*                  {ACameraManager_AvailabilityCallbacks#onCameraUnavailable} is NULL.</li></ul>
	*/
	ACameraManager_unregisterExtendedAvailabilityCallback :: proc(manager: ^ACameraManager, callback: ^ACameraManager_ExtendedAvailabilityCallbacks) -> CameraStatus ---
}
