#+build linux
package mediandk

import "../"

foreign import mediandk "system:mediandk"

/**
 * AImage is an opaque type that allows direct application access to image data rendered into a
 * {@link ANativeWindow}.
 */
AImageReader :: struct{}

AImageReader_ImageListener :: struct {
	/// Optional application context passed as the first parameter of the callback.
	_context: rawptr,

	/**
	* This callback is called when there is a new image available in the image reader's queue.
	*
	* <p>The callback happens on one dedicated thread per {@link AImageReader} instance. It is okay
	* to use AImageReader_* and AImage_* methods within the callback. Note that it is possible that
	* calling {@link AImageReader_acquireNextImage} or {@link AImageReader_acquireLatestImage}
	* returns {@link AMEDIA_IMGREADER_NO_BUFFER_AVAILABLE} within this callback. For example, when
	* there are multiple images and callbacks queued, if application called
	* {@link AImageReader_acquireLatestImage}, some images will be returned to system before their
	* corresponding callback is executed.</p>
	*/
	onImageAvailable: AImageReader_ImageCallback,
}

/**
* A listener to the AHardwareBuffer removal event, use
* {@link AImageReader_setBufferRemovedListener} to register the listener object to AImageReader.
*/
AImageReader_BufferRemovedListener :: struct {
	/// Optional application context passed as the first parameter of the callback.
	_context: rawptr,

	/**
	* This callback is called when an old {@link AHardwareBuffer} is about to be removed from the
	* image reader.
	*
	* <p>Note that registering this callback is optional unless the user holds on extra reference
	* to {@link AHardwareBuffer} returned from {@link AImage_getHardwareBuffer} by calling {@link
	* AHardwareBuffer_acquire} or creating external graphic objects, such as EglImage, from it.</p>
	*
	* <p>If the callback is registered, the {@link AImageReader} will hold on the last of its
	* references to the {@link AHardwareBuffer} until this callback returns. User can use the
	* callback to get notified that it becomes the last owner of the buffer. It is up to the user
	* to decide to either 1) immediately release all of its references to the buffer or 2) keep
	* using the buffer and release it in future. Note that, if option 2 if used, user of this API
	* is responsible to deallocate the buffer properly by calling {@link AHardwareBuffer_release}.
	* </p>
	*
	* @see AHardwareBuffer_release
	* @see AImage_getHardwareBuffer
	*/
	onBufferRemoved: AImageReader_BufferRemovedCallback,
}

/**
* Signature of the callback which is called when a new image is available from {@link AImageReader}.
*
* @param context The optional application context provided by user in
*                {@link AImageReader_setImageListener}.
* @param session The camera capture session whose state is changing.
*/
AImageReader_ImageCallback :: #type proc "c" (_context: rawptr, reader: ^AImageReader)

/**
* Signature of the callback which is called when {@link AImageReader} is about to remove a buffer.
*
* @param context The optional application context provided by user in
*                {@link AImageReader_setBufferRemovedListener}.
* @param reader The {@link AImageReader} of interest.
* @param buffer The {@link AHardwareBuffer} that is being removed from this image reader.
*/
AImageReader_BufferRemovedCallback :: #type proc "c" (_context: rawptr, reader: ^AImageReader, buffer: ^android.AHardwareBuffer)

foreign mediandk {
	/**
	 * Create a new reader for images of the desired size and format.
	 *
	 * <p>
	 * The maxImages parameter determines the maximum number of {@link AImage} objects that can be
	 * acquired from the {@link AImageReader} simultaneously. Requesting more buffers will use up
	 * more memory, so it is important to use only the minimum number necessary for the use case.
	 * </p>
	 * <p>
	 * The valid sizes and formats depend on the source of the image data.
	 * </p>
	 *
	 * Available since API level 24.
	 *
	 * @param width The default width in pixels of the Images that this reader will produce.
	 * @param height The default height in pixels of the Images that this reader will produce.
	 * @param format The format of the Image that this reader will produce. This must be one of the
	 *            AIMAGE_FORMAT_* enum value defined in {@link AIMAGE_FORMATS}. Note that not all
	 *            formats are supported. One example is {@link AIMAGE_FORMAT_PRIVATE}, as it is not
	 *            intended to be read by applications directly. That format is supported by
	 *            {@link AImageReader_newWithUsage} introduced in API 26.
	 * @param maxImages The maximum number of images the user will want to access simultaneously. This
	 *            should be as small as possible to limit memory use. Once maxImages Images are obtained
	 *            by the user, one of them has to be released before a new {@link AImage} will become
	 *            available for access through {@link AImageReader_acquireLatestImage} or
	 *            {@link AImageReader_acquireNextImage}. Must be greater than 0.
	 * @param reader The created image reader will be filled here if the method call succeeeds.
	 *
	 * @return <ul>
	 *         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	 *         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if reader is NULL, or one or more of width,
	 *                 height, format, maxImages arguments is not supported.</li>
	 *         <li>{@link AMEDIA_ERROR_UNKNOWN} if the method fails for some other reasons.</li></ul>
	 *
	 * @see AImage
	 */
	AImageReader_new :: proc(width: i32, height: i32, format: AImageFormats, maxImages: i32, reader: ^^AImageReader) -> media_status_t ---

	/**
	* Delete an {@link AImageReader} and return all images generated by this reader to system.
	*
	* <p>This method will return all {@link AImage} objects acquired by this reader (via
	* {@link AImageReader_acquireNextImage} or {@link AImageReader_acquireLatestImage}) to system,
	* making any of data pointers obtained from {@link AImage_getPlaneData} invalid. Do NOT access
	* the reader object or any of those data pointers after this method returns.</p>
	*
	* Available since API level 24.
	*
	* @param reader The image reader to be deleted.
	*/
	AImageReader_delete :: proc(reader: ^AImageReader) ---

	/**
	* Get a {@link ANativeWindow} that can be used to produce {@link AImage} for this image reader.
	*
	* Available since API level 24.
	*
	* @param reader The image reader of interest.
	* @param window The output {@link ANativeWindow} will be filled here if the method call succeeds.
	*                The {@link ANativeWindow} is managed by this image reader. Do NOT call
	*                {@link ANativeWindow_release} on it. Instead, use {@link AImageReader_delete}.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if reader or window is NULL.</li></ul>
	*/
	AImageReader_getWindow :: proc(reader: ^AImageReader, window: ^^android.ANativeWindow) -> media_status_t ---

	/**
	* Query the default width of the {@link AImage} generated by this reader, in pixels.
	*
	* <p>The width may be overridden by the producer sending buffers to this reader's
	* {@link ANativeWindow}. If so, the actual width of the images can be found using
	* {@link AImage_getWidth}.</p>
	*
	* Available since API level 24.
	*
	* @param reader The image reader of interest.
	* @param width the default width of the reader will be filled here if the method call succeeeds.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if reader or width is NULL.</li></ul>
	*/
	AImageReader_getWidth :: proc(reader: ^AImageReader, width: ^i32) -> media_status_t ---

	/**
	* Query the default height of the {@link AImage} generated by this reader, in pixels.
	*
	* <p>The height may be overridden by the producer sending buffers to this reader's
	* {@link ANativeWindow}. If so, the actual height of the images can be found using
	* {@link AImage_getHeight}.</p>
	*
	* Available since API level 24.
	*
	* @param reader The image reader of interest.
	* @param height the default height of the reader will be filled here if the method call succeeeds.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if reader or height is NULL.</li></ul>
	*/
	AImageReader_getHeight :: proc(reader: ^AImageReader, height: ^i32) -> media_status_t ---

	/**
	* Query the format of the {@link AImage} generated by this reader.
	*
	* Available since API level 24.
	*
	* @param reader The image reader of interest.
	* @param format the fromat of the reader will be filled here if the method call succeeeds. The
	*                value will be one of the AIMAGE_FORMAT_* enum value defiend in {@link NdkImage.h}.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if reader or format is NULL.</li></ul>
	*/
	AImageReader_getFormat :: proc(reader: ^AImageReader, format: ^AImageFormats) -> media_status_t ---

	/**
	* Query the maximum number of concurrently acquired {@link AImage}s of this reader.
	*
	* Available since API level 24.
	*
	* @param reader The image reader of interest.
	* @param maxImages the maximum number of concurrently acquired images of the reader will be filled
	*                here if the method call succeeeds.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if reader or maxImages is NULL.</li></ul>
	*/
	AImageReader_getMaxImages :: proc(reader: ^AImageReader, maxImages: ^i32) -> media_status_t ---

	/**
	* Acquire the next {@link AImage} from the image reader's queue.
	*
	* <p>Warning: Consider using {@link AImageReader_acquireLatestImage} instead, as it will
	* automatically release older images, and allow slower-running processing routines to catch
	* up to the newest frame. Usage of {@link AImageReader_acquireNextImage} is recommended for
	* batch/background processing. Incorrectly using this method can cause images to appear
	* with an ever-increasing delay, followed by a complete stall where no new images seem to appear.
	* </p>
	*
	* <p>
	* This method will fail if {@link AImageReader_getMaxImages maxImages} have been acquired with
	* {@link AImageReader_acquireNextImage} or {@link AImageReader_acquireLatestImage}. In particular
	* a sequence of {@link AImageReader_acquireNextImage} or {@link AImageReader_acquireLatestImage}
	* calls greater than {@link AImageReader_getMaxImages maxImages} without calling
	* {@link AImage_delete} in-between will exhaust the underlying queue. At such a time,
	* {@link AMEDIA_IMGREADER_MAX_IMAGES_ACQUIRED} will be returned until more images are released with
	* {@link AImage_delete}.
	* </p>
	*
	* Available since API level 24.
	*
	* @param reader The image reader of interest.
	* @param image the acquired {@link AImage} will be filled here if the method call succeeeds.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if reader or image is NULL.</li>
	*         <li>{@link AMEDIA_IMGREADER_MAX_IMAGES_ACQUIRED} if the number of concurrently acquired
	*                 images has reached the limit.</li>
	*         <li>{@link AMEDIA_IMGREADER_NO_BUFFER_AVAILABLE} if there is no buffers currently
	*                 available in the reader queue.</li>
	*         <li>{@link AMEDIA_ERROR_UNKNOWN} if the method fails for some other reasons.</li></ul>
	*
	* @see AImageReader_acquireLatestImage
	*/
	AImageReader_acquireNextImage :: proc(reader: ^AImageReader, image: ^^AImage) -> media_status_t ---

	/**
	* Acquire the latest {@link AImage} from the image reader's queue, dropping older images.
	*
	* <p>
	* This operation will acquire all the images possible from the image reader, but
	* {@link AImage_delete} all images that aren't the latest. This function is recommended to use over
	* {@link AImageReader_acquireNextImage} for most use-cases, as it's more suited for real-time
	* processing.
	* </p>
	* <p>
	* Note that {@link AImageReader_getMaxImages maxImages} should be at least 2 for
	* {@link AImageReader_acquireLatestImage} to be any different than
	* {@link AImageReader_acquireNextImage} - discarding all-but-the-newest {@link AImage} requires
	* temporarily acquiring two {@link AImage}s at once. Or more generally, calling
	* {@link AImageReader_acquireLatestImage} with less than two images of margin, that is
	* (maxImages - currentAcquiredImages < 2) will not discard as expected.
	* </p>
	* <p>
	* This method will fail if {@link AImageReader_getMaxImages maxImages} have been acquired with
	* {@link AImageReader_acquireNextImage} or {@link AImageReader_acquireLatestImage}. In particular
	* a sequence of {@link AImageReader_acquireNextImage} or {@link AImageReader_acquireLatestImage}
	* calls greater than {@link AImageReader_getMaxImages maxImages} without calling
	* {@link AImage_delete} in-between will exhaust the underlying queue. At such a time,
	* {@link AMEDIA_IMGREADER_MAX_IMAGES_ACQUIRED} will be returned until more images are released with
	* {@link AImage_delete}.
	* </p>
	*
	* Available since API level 24.
	*
	* @param reader The image reader of interest.
	* @param image the acquired {@link AImage} will be filled here if the method call succeeeds.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if reader or image is NULL.</li>
	*         <li>{@link AMEDIA_IMGREADER_MAX_IMAGES_ACQUIRED} if the number of concurrently acquired
	*                 images has reached the limit.</li>
	*         <li>{@link AMEDIA_IMGREADER_NO_BUFFER_AVAILABLE} if there is no buffers currently
	*                 available in the reader queue.</li>
	*         <li>{@link AMEDIA_ERROR_UNKNOWN} if the method fails for some other reasons.</li></ul>
	*
	* @see AImageReader_acquireNextImage
	*/
	AImageReader_acquireLatestImage :: proc(reader: ^AImageReader, image: ^^AImage) -> media_status_t ---


	/**
	* Set the onImageAvailable listener of this image reader.
	*
	* Calling this method will replace previously registered listeners.
	*
	* Available since API level 24.
	*
	* @param reader The image reader of interest.
	* @param listener The {@link AImageReader_ImageListener} to be registered. Set this to NULL if
	*                 the application no longer needs to listen to new images.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if reader is NULL.</li></ul>
	*/
	AImageReader_setImageListener :: proc(reader: ^AImageReader, listener: ^AImageReader_ImageListener) -> media_status_t ---

	/**
	* AImageReader constructor similar to {@link AImageReader_new} that takes an additional parameter
	* for the consumer usage. All other parameters and the return values are identical to those passed
	* to {@link AImageReader_new}.
	*
	* <p>If the \c format is {@link AIMAGE_FORMAT_PRIVATE}, the created {@link AImageReader}
	* will produce images whose contents are not directly accessible by the application. The application can
	* still acquire images from this {@link AImageReader} and access {@link AHardwareBuffer} via
	* {@link AImage_getHardwareBuffer()}. The {@link AHardwareBuffer} gained this way can then
	* be passed back to hardware (such as GPU or hardware encoder if supported) for future processing.
	* For example, you can obtain an EGLClientBuffer from the {@link AHardwareBuffer} by using
	* eglGetNativeClientBufferANDROID extension and pass that EGLClientBuffer to
	* eglCreateImageKHR to create an EGLImage resource type, which may then be bound to a
	* texture via glEGLImageTargetTexture2DOES on supported devices. This can be useful for
	* transporting textures that may be shared cross-process.</p>
	* <p>In general, when software access to image data is not necessary, an {@link AImageReader}
	* created with {@link AIMAGE_FORMAT_PRIVATE} format is more efficient, compared with {@link
	* AImageReader}s using other format such as {@link AIMAGE_FORMAT_YUV_420_888}.</p>
	*
	* <p>Note that not all format and usage flag combination is supported by the {@link AImageReader},
	* especially if \c format is {@link AIMAGE_FORMAT_PRIVATE}, \c usage must not include either
	* {@link AHARDWAREBUFFER_USAGE_CPU_READ_RARELY} or {@link AHARDWAREBUFFER_USAGE_CPU_READ_OFTEN}</p>
	*
	* @param width The default width in pixels of the Images that this reader will produce.
	* @param height The default height in pixels of the Images that this reader will produce.
	* @param format The format of the Image that this reader will produce. This must be one of the
	*            AIMAGE_FORMAT_* enum value defined in {@link AIMAGE_FORMATS}.
	* @param usage specifies how the consumer will access the AImage, using combination of the
	*            AHARDWAREBUFFER_USAGE flags described in {@link hardware_buffer.h}.
	*            Passing {@link AHARDWAREBUFFER_USAGE_CPU_READ_OFTEN} is equivalent to calling
	*            {@link AImageReader_new} with the same parameters.
	*
	* Note that not all format and usage flag combination is supported by the {@link AImageReader}.
	* Below are the combinations supported by the {@link AImageReader}.
	* <table>
	* <tr>
	*   <th>Format</th>
	*   <th>Compatible usage flags</th>
	* </tr>
	* <tr>
	*   <td>non-{@link AIMAGE_FORMAT_PRIVATE} formats defined in {@link NdkImage.h}
	* </td>
	*   <td>{@link AHARDWAREBUFFER_USAGE_CPU_READ_RARELY} or
	*   {@link AHARDWAREBUFFER_USAGE_CPU_READ_OFTEN}</td>
	* </tr>
	* <tr>
	*   <td>{@link AIMAGE_FORMAT_RGBA_8888}</td>
	*   <td>{@link AHARDWAREBUFFER_USAGE_VIDEO_ENCODE} or
	*   {@link AHARDWAREBUFFER_USAGE_GPU_SAMPLED_IMAGE}, or combined</td>
	* </tr>
	* </table>
	*
	* Available since API level 26.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if reader is NULL, or one or more of width,
	*                 height, format, maxImages, or usage arguments is not supported.</li>
	*         <li>{@link AMEDIA_ERROR_UNKNOWN} if the method fails for some other reasons.</li></ul>
	*
	* @see AImage
	* @see AImageReader_new
	* @see AHardwareBuffer
	*/
	AImageReader_newWithUsage :: proc(width: i32, height: i32, format: AImageFormats, usage: u64, maxImages: i32, reader: ^^AImageReader) -> media_status_t ---

	/**
	* Acquire the next {@link AImage} from the image reader's queue asynchronously.
	*
	* <p>AImageReader acquire method similar to {@link AImageReader_acquireNextImage} that takes an
	* additional parameter for the sync fence. All other parameters and the return values are
	* identical to those passed to {@link AImageReader_acquireNextImage}.</p>
	*
	* Available since API level 26.
	*
	* @param acquireFenceFd A sync fence fd defined in {@link sync.h}, which is used to signal when the
	*         buffer is ready to consume. When synchronization fence is not needed, fence will be set
	*         to -1 and the {@link AImage} returned is ready for use immediately. Otherwise, user shall
	*         use syscalls such as \c poll(), \c epoll(), \c select() to wait for the
	*         fence fd to change status before attempting to access the {@link AImage} returned.
	*
	* @see sync.h
	* @see sync_get_fence_info
	*/
	AImageReader_acquireNextImageAsync :: proc(reader: ^AImageReader, image: ^^AImage, acquireFenceFd: ^i32) -> media_status_t ---

	/**
	* Acquire the latest {@link AImage} from the image reader's queue asynchronously, dropping older
	* images.
	*
	* <p>AImageReader acquire method similar to {@link AImageReader_acquireLatestImage} that takes an
	* additional parameter for the sync fence. All other parameters and the return values are
	* identical to those passed to {@link AImageReader_acquireLatestImage}.</p>
	*
	* Available since API level 26.
	*
	* @param acquireFenceFd A sync fence fd defined in {@link sync.h}, which is used to signal when the
	*         buffer is ready to consume. When synchronization fence is not needed, fence will be set
	*         to -1 and the {@link AImage} returned is ready for use immediately. Otherwise, user shall
	*         use syscalls such as \c poll(), \c epoll(), \c select() to wait for the
	*         fence fd to change status before attempting to access the {@link AImage} returned.
	*
	* @see sync.h
	* @see sync_get_fence_info
	*/
	AImageReader_acquireLatestImageAsync :: proc(reader: ^AImageReader, image: ^^AImage, acquireFenceFd: ^i32) -> media_status_t ---


	/**
	* Set the onBufferRemoved listener of this image reader.
	*
	* <p>Note that calling this method will replace previously registered listeners.</p>
	*
	* Available since API level 26.
	*
	* @param reader The image reader of interest.
	* @param listener the {@link AImageReader_BufferRemovedListener} to be registered. Set this to
	* NULL if application no longer needs to listen to buffer removed events.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if reader is NULL.</li></ul>
	*
	* @see AImage_getHardwareBuffer
	*/
	AImageReader_setBufferRemovedListener :: proc(reader: ^AImageReader, listener: ^AImageReader_BufferRemovedListener) -> media_status_t ---
}
