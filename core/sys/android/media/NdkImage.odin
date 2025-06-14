#+build linux
package mediandk

import "../"

foreign import mediandk "system:mediandk"

/**
 * AImage supported formats: AImageReader only guarantees the support for the formats
 * listed here.
 */
AImageFormats :: enum i32 {
    /**
     * 32 bits RGBA format, 8 bits for each of the four channels.
     *
     * <p>
     * Corresponding formats:
     * <ul>
     * <li>AHardwareBuffer: AHARDWAREBUFFER_FORMAT_R8G8B8A8_UNORM</li>
     * <li>Vulkan: VK_FORMAT_R8G8B8A8_UNORM</li>
     * <li>OpenGL ES: GL_RGBA8</li>
     * </ul>
     * </p>
     *
     * @see AImage
     * @see AImageReader
     * @see AHardwareBuffer
     */
    RGBA_8888         = 0x1,

    /**
     * 32 bits RGBX format, 8 bits for each of the four channels.  The values
     * of the alpha channel bits are ignored (image is assumed to be opaque).
     *
     * <p>
     * Corresponding formats:
     * <ul>
     * <li>AHardwareBuffer: AHARDWAREBUFFER_FORMAT_R8G8B8X8_UNORM</li>
     * <li>Vulkan: VK_FORMAT_R8G8B8A8_UNORM</li>
     * <li>OpenGL ES: GL_RGB8</li>
     * </ul>
     * </p>
     *
     * @see AImage
     * @see AImageReader
     * @see AHardwareBuffer
     */
    RGBX_8888         = 0x2,

    /**
     * 24 bits RGB format, 8 bits for each of the three channels.
     *
     * <p>
     * Corresponding formats:
     * <ul>
     * <li>AHardwareBuffer: AHARDWAREBUFFER_FORMAT_R8G8B8_UNORM</li>
     * <li>Vulkan: VK_FORMAT_R8G8B8_UNORM</li>
     * <li>OpenGL ES: GL_RGB8</li>
     * </ul>
     * </p>
     *
     * @see AImage
     * @see AImageReader
     * @see AHardwareBuffer
     */
    RGB_888           = 0x3,

    /**
     * 16 bits RGB format, 5 bits for Red channel, 6 bits for Green channel,
     * and 5 bits for Blue channel.
     *
     * <p>
     * Corresponding formats:
     * <ul>
     * <li>AHardwareBuffer: AHARDWAREBUFFER_FORMAT_R5G6B5_UNORM</li>
     * <li>Vulkan: VK_FORMAT_R5G6B5_UNORM_PACK16</li>
     * <li>OpenGL ES: GL_RGB565</li>
     * </ul>
     * </p>
     *
     * @see AImage
     * @see AImageReader
     * @see AHardwareBuffer
     */
    RGB_565           = 0x4,

    /**
     * 64 bits RGBA format, 16 bits for each of the four channels.
     *
     * <p>
     * Corresponding formats:
     * <ul>
     * <li>AHardwareBuffer: AHARDWAREBUFFER_FORMAT_R16G16B16A16_FLOAT</li>
     * <li>Vulkan: VK_FORMAT_R16G16B16A16_SFLOAT</li>
     * <li>OpenGL ES: GL_RGBA16F</li>
     * </ul>
     * </p>
     *
     * @see AImage
     * @see AImageReader
     * @see AHardwareBuffer
     */
    RGBA_FP16         = 0x16,

    /**
     * Multi-plane Android YUV 420 format.
     *
     * <p>This format is a generic YCbCr format, capable of describing any 4:2:0
     * chroma-subsampled planar or semiplanar buffer (but not fully interleaved),
     * with 8 bits per color sample.</p>
     *
     * <p>Images in this format are always represented by three separate buffers
     * of data, one for each color plane. Additional information always
     * accompanies the buffers, describing the row stride and the pixel stride
     * for each plane.</p>
     *
     * <p>The order of planes is guaranteed such that plane #0 is always Y, plane #1 is always
     * U (Cb), and plane #2 is always V (Cr).</p>
     *
     * <p>The Y-plane is guaranteed not to be interleaved with the U/V planes
     * (in particular, pixel stride is always 1 in {@link AImage_getPlanePixelStride}).</p>
     *
     * <p>The U/V planes are guaranteed to have the same row stride and pixel stride, that is, the
     * return value of {@link AImage_getPlaneRowStride} for the U/V plane are guaranteed to be the
     * same, and the return value of {@link AImage_getPlanePixelStride} for the U/V plane are also
     * guaranteed to be the same.</p>
     *
     * <p>For example, the {@link AImage} object can provide data
     * in this format from a {@link ACameraDevice} through an {@link AImageReader} object.</p>
     *
     * <p>This format is always supported as an output format for the android Camera2 NDK API.</p>
     *
     * @see AImage
     * @see AImageReader
     * @see ACameraDevice
     */
    YUV_420_888       = 0x23,

    /**
     * Compressed JPEG format.
     *
     * <p>This format is always supported as an output format for the android Camera2 NDK API.</p>
     */
    JPEG              = 0x100,

    /**
     * 16 bits per pixel raw camera sensor image format, usually representing a single-channel
     * Bayer-mosaic image.
     *
     * <p>The layout of the color mosaic, the maximum and minimum encoding
     * values of the raw pixel data, the color space of the image, and all other
     * needed information to interpret a raw sensor image must be queried from
     * the {@link ACameraDevice} which produced the image.</p>
     */
    RAW16             = 0x20,

    /**
     * Private raw camera sensor image format, a single channel image with implementation depedent
     * pixel layout.
     *
     * <p>RAW_PRIVATE is a format for unprocessed raw image buffers coming from an
     * image sensor. The actual structure of buffers of this format is implementation-dependent.</p>
     *
     */
    RAW_PRIVATE       = 0x24,

    /**
     * Android 10-bit raw format.
     *
     * <p>
     * This is a single-plane, 10-bit per pixel, densely packed (in each row),
     * unprocessed format, usually representing raw Bayer-pattern images coming
     * from an image sensor.
     * </p>
     * <p>
     * In an image buffer with this format, starting from the first pixel of
     * each row, each 4 consecutive pixels are packed into 5 bytes (40 bits).
     * Each one of the first 4 bytes contains the top 8 bits of each pixel, The
     * fifth byte contains the 2 least significant bits of the 4 pixels, the
     * exact layout data for each 4 consecutive pixels is illustrated below
     * (Pi[j] stands for the jth bit of the ith pixel):
     * </p>
     * <table>
     * <tr>
     * <th align="center"></th>
     * <th align="center">bit 7</th>
     * <th align="center">bit 6</th>
     * <th align="center">bit 5</th>
     * <th align="center">bit 4</th>
     * <th align="center">bit 3</th>
     * <th align="center">bit 2</th>
     * <th align="center">bit 1</th>
     * <th align="center">bit 0</th>
     * </tr>
     * <tr>
     * <td align="center">Byte 0:</td>
     * <td align="center">P0[9]</td>
     * <td align="center">P0[8]</td>
     * <td align="center">P0[7]</td>
     * <td align="center">P0[6]</td>
     * <td align="center">P0[5]</td>
     * <td align="center">P0[4]</td>
     * <td align="center">P0[3]</td>
     * <td align="center">P0[2]</td>
     * </tr>
     * <tr>
     * <td align="center">Byte 1:</td>
     * <td align="center">P1[9]</td>
     * <td align="center">P1[8]</td>
     * <td align="center">P1[7]</td>
     * <td align="center">P1[6]</td>
     * <td align="center">P1[5]</td>
     * <td align="center">P1[4]</td>
     * <td align="center">P1[3]</td>
     * <td align="center">P1[2]</td>
     * </tr>
     * <tr>
     * <td align="center">Byte 2:</td>
     * <td align="center">P2[9]</td>
     * <td align="center">P2[8]</td>
     * <td align="center">P2[7]</td>
     * <td align="center">P2[6]</td>
     * <td align="center">P2[5]</td>
     * <td align="center">P2[4]</td>
     * <td align="center">P2[3]</td>
     * <td align="center">P2[2]</td>
     * </tr>
     * <tr>
     * <td align="center">Byte 3:</td>
     * <td align="center">P3[9]</td>
     * <td align="center">P3[8]</td>
     * <td align="center">P3[7]</td>
     * <td align="center">P3[6]</td>
     * <td align="center">P3[5]</td>
     * <td align="center">P3[4]</td>
     * <td align="center">P3[3]</td>
     * <td align="center">P3[2]</td>
     * </tr>
     * <tr>
     * <td align="center">Byte 4:</td>
     * <td align="center">P3[1]</td>
     * <td align="center">P3[0]</td>
     * <td align="center">P2[1]</td>
     * <td align="center">P2[0]</td>
     * <td align="center">P1[1]</td>
     * <td align="center">P1[0]</td>
     * <td align="center">P0[1]</td>
     * <td align="center">P0[0]</td>
     * </tr>
     * </table>
     * <p>
     * This format assumes
     * <ul>
     * <li>a width multiple of 4 pixels</li>
     * <li>an even height</li>
     * </ul>
     * </p>
     *
     * <pre>size = row stride * height</pre> where the row stride is in <em>bytes</em>,
     * not pixels.
     *
     * <p>
     * Since this is a densely packed format, the pixel stride is always 0. The
     * application must use the pixel data layout defined in above table to
     * access each row data. When row stride is equal to (width * (10 / 8)), there
     * will be no padding bytes at the end of each row, the entire image data is
     * densely packed. When stride is larger than (width * (10 / 8)), padding
     * bytes will be present at the end of each row.
     * </p>
     * <p>
     * For example, the {@link AImage} object can provide data in this format from a
     * {@link ACameraDevice} (if supported) through a {@link AImageReader} object.
     * The number of planes returned by {@link AImage_getNumberOfPlanes} will always be 1.
     * The pixel stride is undefined ({@link AImage_getPlanePixelStride} will return
     * {@link AMEDIA_ERROR_UNSUPPORTED}), and the {@link AImage_getPlaneRowStride} described the
     * vertical neighboring pixel distance (in bytes) between adjacent rows.
     * </p>
     *
     * @see AImage
     * @see AImageReader
     * @see ACameraDevice
     */
    RAW10             = 0x25,

    /**
     * Android 12-bit raw format.
     *
     * <p>
     * This is a single-plane, 12-bit per pixel, densely packed (in each row),
     * unprocessed format, usually representing raw Bayer-pattern images coming
     * from an image sensor.
     * </p>
     * <p>
     * In an image buffer with this format, starting from the first pixel of each
     * row, each two consecutive pixels are packed into 3 bytes (24 bits). The first
     * and second byte contains the top 8 bits of first and second pixel. The third
     * byte contains the 4 least significant bits of the two pixels, the exact layout
     * data for each two consecutive pixels is illustrated below (Pi[j] stands for
     * the jth bit of the ith pixel):
     * </p>
     * <table>
     * <tr>
     * <th align="center"></th>
     * <th align="center">bit 7</th>
     * <th align="center">bit 6</th>
     * <th align="center">bit 5</th>
     * <th align="center">bit 4</th>
     * <th align="center">bit 3</th>
     * <th align="center">bit 2</th>
     * <th align="center">bit 1</th>
     * <th align="center">bit 0</th>
     * </tr>
     * <tr>
     * <td align="center">Byte 0:</td>
     * <td align="center">P0[11]</td>
     * <td align="center">P0[10]</td>
     * <td align="center">P0[ 9]</td>
     * <td align="center">P0[ 8]</td>
     * <td align="center">P0[ 7]</td>
     * <td align="center">P0[ 6]</td>
     * <td align="center">P0[ 5]</td>
     * <td align="center">P0[ 4]</td>
     * </tr>
     * <tr>
     * <td align="center">Byte 1:</td>
     * <td align="center">P1[11]</td>
     * <td align="center">P1[10]</td>
     * <td align="center">P1[ 9]</td>
     * <td align="center">P1[ 8]</td>
     * <td align="center">P1[ 7]</td>
     * <td align="center">P1[ 6]</td>
     * <td align="center">P1[ 5]</td>
     * <td align="center">P1[ 4]</td>
     * </tr>
     * <tr>
     * <td align="center">Byte 2:</td>
     * <td align="center">P1[ 3]</td>
     * <td align="center">P1[ 2]</td>
     * <td align="center">P1[ 1]</td>
     * <td align="center">P1[ 0]</td>
     * <td align="center">P0[ 3]</td>
     * <td align="center">P0[ 2]</td>
     * <td align="center">P0[ 1]</td>
     * <td align="center">P0[ 0]</td>
     * </tr>
     * </table>
     * <p>
     * This format assumes
     * <ul>
     * <li>a width multiple of 4 pixels</li>
     * <li>an even height</li>
     * </ul>
     * </p>
     *
     * <pre>size = row stride * height</pre> where the row stride is in <em>bytes</em>,
     * not pixels.
     *
     * <p>
     * Since this is a densely packed format, the pixel stride is always 0. The
     * application must use the pixel data layout defined in above table to
     * access each row data. When row stride is equal to (width * (12 / 8)), there
     * will be no padding bytes at the end of each row, the entire image data is
     * densely packed. When stride is larger than (width * (12 / 8)), padding
     * bytes will be present at the end of each row.
     * </p>
     * <p>
     * For example, the {@link AImage} object can provide data in this format from a
     * {@link ACameraDevice} (if supported) through a {@link AImageReader} object.
     * The number of planes returned by {@link AImage_getNumberOfPlanes} will always be 1.
     * The pixel stride is undefined ({@link AImage_getPlanePixelStride} will return
     * {@link AMEDIA_ERROR_UNSUPPORTED}), and the {@link AImage_getPlaneRowStride} described the
     * vertical neighboring pixel distance (in bytes) between adjacent rows.
     * </p>
     *
     * @see AImage
     * @see AImageReader
     * @see ACameraDevice
     */
    RAW12             = 0x26,

    /**
     * Android dense depth image format.
     *
     * <p>Each pixel is 16 bits, representing a depth ranging measurement from a depth camera or
     * similar sensor. The 16-bit sample consists of a confidence value and the actual ranging
     * measurement.</p>
     *
     * <p>The confidence value is an estimate of correctness for this sample.  It is encoded in the
     * 3 most significant bits of the sample, with a value of 0 representing 100% confidence, a
     * value of 1 representing 0% confidence, a value of 2 representing 1/7, a value of 3
     * representing 2/7, and so on.</p>
     *
     * <p>As an example, the following sample extracts the range and confidence from the first pixel
     * of a DEPTH16-format {@link AImage}, and converts the confidence to a floating-point value
     * between 0 and 1.f inclusive, with 1.f representing maximum confidence:
     *
     * <pre>
     *    uint16_t* data;
     *    int dataLength;
     *    AImage_getPlaneData(image, 0, (uint8_t**)&data, &dataLength);
     *    uint16_t depthSample = data[0];
     *    uint16_t depthRange = (depthSample & 0x1FFF);
     *    uint16_t depthConfidence = ((depthSample >> 13) & 0x7);
     *    float depthPercentage = depthConfidence == 0 ? 1.f : (depthConfidence - 1) / 7.f;
     * </pre>
     * </p>
     *
     * <p>This format assumes
     * <ul>
     * <li>an even width</li>
     * <li>an even height</li>
     * <li>a horizontal stride multiple of 16 pixels</li>
     * </ul>
     * </p>
     *
     * <pre> y_size = stride * height </pre>
     *
     * When produced by a camera, the units for the range are millimeters.
     */
    DEPTH16           = 0x44363159,

    /**
     * Android sparse depth point cloud format.
     *
     * <p>A variable-length list of 3D points plus a confidence value, with each point represented
     * by four floats; first the X, Y, Z position coordinates, and then the confidence value.</p>
     *
     * <p>The number of points is ((size of the buffer in bytes) / 16).
     *
     * <p>The coordinate system and units of the position values depend on the source of the point
     * cloud data. The confidence value is between 0.f and 1.f, inclusive, with 0 representing 0%
     * confidence and 1.f representing 100% confidence in the measured position values.</p>
     *
     * <p>As an example, the following code extracts the first depth point in a DEPTH_POINT_CLOUD
     * format {@link AImage}:
     * <pre>
     *    float* data;
     *    int dataLength;
     *    AImage_getPlaneData(image, 0, (uint8_t**)&data, &dataLength);
     *    float x = data[0];
     *    float y = data[1];
     *    float z = data[2];
     *    float confidence = data[3];
     * </pre>
     *
     */
    DEPTH_POINT_CLOUD = 0x101,

    /**
     * Android private opaque image format.
     *
     * <p>The choices of the actual format and pixel data layout are entirely up to the
     * device-specific and framework internal implementations, and may vary depending on use cases
     * even for the same device. Also note that the contents of these buffers are not directly
     * accessible to the application.</p>
     *
     * <p>When an {@link AImage} of this format is obtained from an {@link AImageReader} or
     * {@link AImage_getNumberOfPlanes()} method will return zero.</p>
     */
    PRIVATE           = 0x22,

    /**
     * Android Y8 format.
     *
     * <p>Y8 is a planar format comprised of a WxH Y plane only, with each pixel
     * being represented by 8 bits.</p>
     *
     * <p>This format assumes
     * <ul>
     * <li>an even width</li>
     * <li>an even height</li>
     * <li>a horizontal stride multiple of 16 pixels</li>
     * </ul>
     * </p>
     *
     * <pre> size = stride * height </pre>
     *
     * <p>For example, the {@link AImage} object can provide data
     * in this format from a {@link ACameraDevice} (if supported) through a
     * {@link AImageReader} object. The number of planes returned by
     * {@link AImage_getNumberOfPlanes} will always be 1. The pixel stride returned by
     * {@link AImage_getPlanePixelStride} will always be 1, and the
     * {@link AImage_getPlaneRowStride} described the vertical neighboring pixel distance
     * (in bytes) between adjacent rows.</p>
     *
     */
    Y8 = 0x20203859,

    /**
     * Compressed HEIC format.
     *
     * <p>This format defines the HEIC brand of High Efficiency Image File
     * Format as described in ISO/IEC 23008-12.</p>
     */
    HEIC = 0x48454946,

    /**
     * Depth augmented compressed JPEG format.
     *
     * <p>JPEG compressed main image along with XMP embedded depth metadata
     * following ISO 16684-1:2011(E).</p>
     */
    DEPTH_JPEG = 0x69656963,
}

/**
 * AImage is an opaque type that provides access to image generated by {@link AImageReader}.
 */
AImage :: struct{}

/**
 * Data type describing an cropped rectangle returned by {@link AImage_getCropRect}.
 *
 * <p>Note that the right and bottom coordinates are exclusive, so the width of the rectangle is
 * (right - left) and the height of the rectangle is (bottom - top).</p>
 */
AImageCropRect :: struct {
	left: i32,
    top: i32,
    right: i32,
    bottom: i32,
}

foreign mediandk {
	/**
	 * Return the image back the the system and delete the AImage object from memory.
	 *
	 * <p>Do NOT use the image pointer after this method returns.
	 * Note that if the parent {@link AImageReader} is closed, all the {@link AImage} objects acquired
	 * from the parent reader will be returned to system. All AImage_* methods except this method will
	 * return {@link AMEDIA_ERROR_INVALID_OBJECT}. Application still needs to call this method on those
	 * {@link AImage} objects to fully delete the {@link AImage} object from memory.</p>
	 *
	 * Available since API level 24.
	 *
	 * @param image The {@link AImage} to be deleted.
	 */
	AImage_delete :: proc(image: ^AImage) ---

	/**
	* Query the width of the input {@link AImage}.
	*
	* Available since API level 24.
	*
	* @param image the {@link AImage} of interest.
	* @param width the width of the image will be filled here if the method call succeeeds.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if image or width is NULL.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_OBJECT} if the {@link AImageReader} generated this
	*                 image has been deleted.</li></ul>
	*/
	AImage_getWidth :: proc(image: ^AImage, width: ^i32) -> media_status_t ---

	/**
	* Query the height of the input {@link AImage}.
	*
	* Available since API level 24.
	*
	* @param image the {@link AImage} of interest.
	* @param height the height of the image will be filled here if the method call succeeeds.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if image or height is NULL.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_OBJECT} if the {@link AImageReader} generated this
	*                 image has been deleted.</li></ul>
	*/
	AImage_getHeight :: proc(image: ^AImage, height: ^i32) -> media_status_t ---

	/**
	* Query the format of the input {@link AImage}.
	*
	* <p>The format value will be one of AIMAGE_FORMAT_* enum value.</p>
	*
	* Available since API level 24.
	*
	* @param image the {@link AImage} of interest.
	* @param format the format of the image will be filled here if the method call succeeeds.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if image or format is NULL.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_OBJECT} if the {@link AImageReader} generated this
	*                 image has been deleted.</li></ul>
	*/
	AImage_getFormat :: proc(image: ^AImage, format: ^AImageFormats) -> media_status_t ---

	/**
	* Query the cropped rectangle of the input {@link AImage}.
	*
	* <p>The crop rectangle specifies the region of valid pixels in the image, using coordinates in the
	* largest-resolution plane.</p>
	*
	* Available since API level 24.
	*
	* @param image the {@link AImage} of interest.
	* @param rect the cropped rectangle of the image will be filled here if the method call succeeeds.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if image or rect is NULL.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_OBJECT} if the {@link AImageReader} generated this
	*                 image has been deleted.</li></ul>
	*/
	AImage_getCropRect :: proc(image: ^AImage, rect: ^AImageCropRect) -> media_status_t ---

	/**
	* Query the timestamp of the input {@link AImage}.
	*
	* <p>
	* The timestamp is measured in nanoseconds, and is normally monotonically increasing. The
	* timestamps for the images from different sources may have different timebases therefore may not
	* be comparable. The specific meaning and timebase of the timestamp depend on the source providing
	* images. For images generated by camera, the timestamp value will match
	* {@link ACAMERA_SENSOR_TIMESTAMP} of the {@link ACameraMetadata} in
	* {@link ACameraCaptureSession_captureCallbacks#onCaptureStarted} and
	* {@link ACameraCaptureSession_captureCallbacks#onCaptureCompleted} callback.
	* </p>
	*
	* Available since API level 24.
	*
	* @param image the {@link AImage} of interest.
	* @param timestampNs the timestamp of the image will be filled here if the method call succeeeds.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if image or timestampNs is NULL.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_OBJECT} if the {@link AImageReader} generated this
	*                 image has been deleted.</li></ul>
	*/
	AImage_getTimestamp :: proc(image: ^AImage, timestampNs: ^i64) -> media_status_t ---

	/**
	* Query the number of planes of the input {@link AImage}.
	*
	* <p>The number of plane of an {@link AImage} is determined by its format, which can be queried by
	* {@link AImage_getFormat} method.</p>
	*
	* Available since API level 24.
	*
	* @param image the {@link AImage} of interest.
	* @param numPlanes the number of planes of the image will be filled here if the method call
	*         succeeeds.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if image or numPlanes is NULL.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_OBJECT} if the {@link AImageReader} generated this
	*                 image has been deleted.</li></ul>
	*/
	AImage_getNumberOfPlanes :: proc(image: ^AImage, numPlanes: ^i32) -> media_status_t ---

	/**
	* Query the pixel stride of the input {@link AImage}.
	*
	* <p>This is the distance between two consecutive pixel values in a row of pixels. It may be
	* larger than the size of a single pixel to account for interleaved image data or padded formats.
	* Note that pixel stride is undefined for some formats such as {@link AIMAGE_FORMAT_RAW_PRIVATE},
	* and calling this method on images of these formats will cause {@link AMEDIA_ERROR_UNSUPPORTED}
	* being returned.
	* For formats where pixel stride is well defined, the pixel stride is always greater than 0.</p>
	*
	* Available since API level 24.
	*
	* @param image the {@link AImage} of interest.
	* @param planeIdx the index of the plane. Must be less than the number of planes of input image.
	* @param pixelStride the pixel stride of the image will be filled here if the method call succeeeds.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if image or pixelStride is NULL, or planeIdx
	*                 is out of the range of [0, numOfPlanes - 1].</li>
	*         <li>{@link AMEDIA_ERROR_UNSUPPORTED} if pixel stride is undefined for the format of input
	*                 image.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_OBJECT} if the {@link AImageReader} generated this
	*                 image has been deleted.</li>
	*         <li>{@link AMEDIA_IMGREADER_CANNOT_LOCK_IMAGE} if the {@link AImage} cannot be locked
	*                 for CPU access.</li></ul>
	*/
	AImage_getPlanePixelStride :: proc(image: ^AImage, planeIdx: i32, pixelStride: ^i32) -> media_status_t ---

	/**
	* Query the row stride of the input {@link AImage}.
	*
	* <p>This is the distance between the start of two consecutive rows of pixels in the image. Note
	* that row stried is undefined for some formats such as {@link AIMAGE_FORMAT_RAW_PRIVATE}, and
	* calling this method on images of these formats will cause {@link AMEDIA_ERROR_UNSUPPORTED}
	* being returned.
	* For formats where row stride is well defined, the row stride is always greater than 0.</p>
	*
	* Available since API level 24.
	*
	* @param image the {@link AImage} of interest.
	* @param planeIdx the index of the plane. Must be less than the number of planes of input image.
	* @param rowStride the row stride of the image will be filled here if the method call succeeeds.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if image or rowStride is NULL, or planeIdx
	*                 is out of the range of [0, numOfPlanes - 1].</li>
	*         <li>{@link AMEDIA_ERROR_UNSUPPORTED} if row stride is undefined for the format of input
	*                 image.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_OBJECT} if the {@link AImageReader} generated this
	*                 image has been deleted.</li>
	*         <li>{@link AMEDIA_IMGREADER_CANNOT_LOCK_IMAGE} if the {@link AImage} cannot be locked
	*                 for CPU access.</li></ul>
	*/
	AImage_getPlaneRowStride :: proc(image: ^AImage, planeIdx: i32, rowStride: ^i32) -> media_status_t ---

	/**
	* Get the data pointer of the input image for direct application access.
	*
	* <p>Note that once the {@link AImage} or the parent {@link AImageReader} is deleted, the data
	* pointer from previous AImage_getPlaneData call becomes invalid. Do NOT use it after the
	* {@link AImage} or the parent {@link AImageReader} is deleted.</p>
	*
	* Available since API level 24.
	*
	* @param image the {@link AImage} of interest.
	* @param planeIdx the index of the plane. Must be less than the number of planes of input image.
	* @param data the data pointer of the image will be filled here if the method call succeeeds.
	* @param dataLength the valid length of data will be filled here if the method call succeeeds.
	*
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if image, data or dataLength is NULL, or
	*                 planeIdx is out of the range of [0, numOfPlanes - 1].</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_OBJECT} if the {@link AImageReader} generated this
	*                 image has been deleted.</li>
	*         <li>{@link AMEDIA_IMGREADER_CANNOT_LOCK_IMAGE} if the {@link AImage} cannot be locked
	*                 for CPU access.</li></ul>
	*/
	AImage_getPlaneData :: proc(image: ^AImage, planeIdx: i32, data: ^[^]u8, dataLength: ^i32) -> media_status_t ---

	/**
	* Return the image back the the system and delete the AImage object from memory asynchronously.
	*
	* <p>Similar to {@link AImage_delete}, do NOT use the image pointer after this method returns.
	* However, the caller can still hold on to the {@link AHardwareBuffer} returned from this image and
	* signal the release of the hardware buffer back to the {@link AImageReader}'s queue using
	* releaseFenceFd.</p>
	*
	* Available since API level 26.
	*
	* @param image The {@link AImage} to be deleted.
	* @param releaseFenceFd A sync fence fd defined in {@link sync.h}, which signals the release of
	*         underlying {@link AHardwareBuffer}.
	*
	* @see sync.h
	*/
	AImage_deleteAsync :: proc(image: ^AImage, releaseFenceFd: i32) ---

	/**
	* Get the hardware buffer handle of the input image intended for GPU and/or hardware access.
	*
	* <p>Note that no reference on the returned {@link AHardwareBuffer} handle is acquired
	* automatically. Once the {@link AImage} or the parent {@link AImageReader} is deleted, the
	* {@link AHardwareBuffer} handle from previous {@link AImage_getHardwareBuffer} becomes
	* invalid.</p>
	*
	* <p>If the caller ever needs to hold on a reference to the {@link AHardwareBuffer} handle after
	* the {@link AImage} or the parent {@link AImageReader} is deleted, it must call {@link
	* AHardwareBuffer_acquire} to acquire an extra reference, and call {@link AHardwareBuffer_release}
	* once it has finished using it in order to properly deallocate the underlying memory managed by
	* {@link AHardwareBuffer}. If the caller has acquired extra reference on an {@link AHardwareBuffer}
	* returned from this function, it must also register a listener using the function
	* {@link AImageReader_setBufferRemovedListener} to be notified when the buffer is no longer used
	* by {@link AImageReader}.</p>
	*
	* Available since API level 26.
	*
	* @param image the {@link AImage} of interest.
	* @param buffer The memory area pointed to by buffer will contain the acquired AHardwareBuffer
	*         handle.
	* @return <ul>
	*         <li>{@link AMEDIA_OK} if the method call succeeds.</li>
	*         <li>{@link AMEDIA_ERROR_INVALID_PARAMETER} if image or buffer is NULL</li></ul>
	*
	* @see AImageReader_ImageCallback
	*/
	AImage_getHardwareBuffer :: proc(image: ^AImage, buffer: ^^android.AHardwareBuffer) -> media_status_t ---
}
