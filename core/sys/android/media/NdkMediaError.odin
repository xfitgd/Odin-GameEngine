```odin
#+build linux
package mediandk

/**
 * Media error message types returned from NDK media functions.
 */
media_status_t :: enum {
    /** The requested media operation completed successfully. */
    AMEDIA_OK = 0,

    /**
     * This indicates required resource was not able to be allocated.
     */
    AMEDIACODEC_ERROR_INSUFFICIENT_RESOURCE = 1100,

    /**
     * This indicates the resource manager reclaimed the media resource used by the codec.
     * With this error, the codec must be released, as it has moved to terminal state.
     */
    AMEDIACODEC_ERROR_RECLAIMED             = 1101,

    AMEDIA_ERROR_BASE                  = -10000,

    /** The called media function failed with an unknown error. */
    AMEDIA_ERROR_UNKNOWN               = AMEDIA_ERROR_BASE,

    /** The input media data is corrupt or incomplete. */
    AMEDIA_ERROR_MALFORMED             = AMEDIA_ERROR_BASE - 1,

    /** The required operation or media formats are not supported. */
    AMEDIA_ERROR_UNSUPPORTED           = AMEDIA_ERROR_BASE - 2,

    /** An invalid (or already closed) object is used in the function call. */
    AMEDIA_ERROR_INVALID_OBJECT        = AMEDIA_ERROR_BASE - 3,

    /** At least one of the invalid parameters is used. */
    AMEDIA_ERROR_INVALID_PARAMETER     = AMEDIA_ERROR_BASE - 4,

    /** The media object is not in the right state for the required operation. */
    AMEDIA_ERROR_INVALID_OPERATION     = AMEDIA_ERROR_BASE - 5,

    /** Media stream ends while processing the requested operation. */
    AMEDIA_ERROR_END_OF_STREAM         = AMEDIA_ERROR_BASE - 6,

    /** An Error occurred when the Media object is carrying IO operation. */
    AMEDIA_ERROR_IO                    = AMEDIA_ERROR_BASE - 7,

    /** The required operation would have to be blocked (on I/O or others),
     *   but blocking is not enabled.
     */
    AMEDIA_ERROR_WOULD_BLOCK           = AMEDIA_ERROR_BASE - 8,

    AMEDIA_DRM_ERROR_BASE              = -20000,
    AMEDIA_DRM_NOT_PROVISIONED         = AMEDIA_DRM_ERROR_BASE - 1,
    AMEDIA_DRM_RESOURCE_BUSY           = AMEDIA_DRM_ERROR_BASE - 2,
    AMEDIA_DRM_DEVICE_REVOKED          = AMEDIA_DRM_ERROR_BASE - 3,
    AMEDIA_DRM_SHORT_BUFFER            = AMEDIA_DRM_ERROR_BASE - 4,
    AMEDIA_DRM_SESSION_NOT_OPENED      = AMEDIA_DRM_ERROR_BASE - 5,
    AMEDIA_DRM_TAMPER_DETECTED         = AMEDIA_DRM_ERROR_BASE - 6,
    AMEDIA_DRM_VERIFY_FAILED           = AMEDIA_DRM_ERROR_BASE - 7,
    AMEDIA_DRM_NEED_KEY                = AMEDIA_DRM_ERROR_BASE - 8,
    AMEDIA_DRM_LICENSE_EXPIRED         = AMEDIA_DRM_ERROR_BASE - 9,

    AMEDIA_IMGREADER_ERROR_BASE          = -30000,

    /** There are no more image buffers to read/write image data. */
    AMEDIA_IMGREADER_NO_BUFFER_AVAILABLE = AMEDIA_IMGREADER_ERROR_BASE - 1,

    /** The AImage object has used up the allowed maximum image buffers. */
    AMEDIA_IMGREADER_MAX_IMAGES_ACQUIRED = AMEDIA_IMGREADER_ERROR_BASE - 2,

    /** The required image buffer could not be locked to read. */
    AMEDIA_IMGREADER_CANNOT_LOCK_IMAGE   = AMEDIA_IMGREADER_ERROR_BASE - 3,

    /** The media data or buffer could not be unlocked. */
    AMEDIA_IMGREADER_CANNOT_UNLOCK_IMAGE = AMEDIA_IMGREADER_ERROR_BASE - 4,

    /** The media/buffer needs to be locked to perform the required operation. */
    AMEDIA_IMGREADER_IMAGE_NOT_LOCKED    = AMEDIA_IMGREADER_ERROR_BASE - 5,
}
```

