#+build linux
package android

/**
 * ADataSpace.
 */
ADataSpace :: enum i32 {
    /**
     * Default-assumption data space, when not explicitly specified.
     *
     * It is safest to assume the buffer is an image with sRGB primaries and
     * encoding ranges, but the consumer and/or the producer of the data may
     * simply be using defaults. No automatic gamma transform should be
     * expected, except for a possible display gamma transform when drawn to a
     * screen.
     */
    UNKNOWN = 0,

    /**
     * Color-description aspects
     *
     * The following aspects define various characteristics of the color
     * specification. These represent bitfields, so that a data space value
     * can specify each of them independently.
     */

    /**
     * Standard aspect
     *
     * Defines the chromaticity coordinates of the source primaries in terms of
     * the CIE 1931 definition of x and y specified in ISO 11664-1.
     */
    STANDARD_MASK = 63 << 16,

    /**
     * Chromacity coordinates are unknown or are determined by the application.
     * Implementations shall use the following suggested standards:
     *
     * All YCbCr formats: BT709 if size is 720p or larger (since most video
     *                    content is letterboxed this corresponds to width is
     *                    1280 or greater, or height is 720 or greater).
     *                    BT601_625 if size is smaller than 720p or is JPEG.
     * All RGB formats:   BT709.
     *
     * For all other formats standard is undefined, and implementations should use
     * an appropriate standard for the data represented.
     */
    STANDARD_UNSPECIFIED = 0 << 16,

    /**
     * Primaries:       x       y
     *  green           0.300   0.600
     *  blue            0.150   0.060
     *  red             0.640   0.330
     *  white (D65)     0.3127  0.3290
     *
     * Use the unadjusted KR = 0.2126, KB = 0.0722 luminance interpretation
     * for RGB conversion.
     */
    STANDARD_BT709 = 1 << 16,

    /**
     * Primaries:       x       y
     *  green           0.290   0.600
     *  blue            0.150   0.060
     *  red             0.640   0.330
     *  white (D65)     0.3127  0.3290
     *
     *  KR = 0.299, KB = 0.114. This adjusts the luminance interpretation
     *  for RGB conversion from the one purely determined by the primaries
     *  to minimize the color shift into RGB space that uses BT.709
     *  primaries.
     */
    STANDARD_BT601_625 = 2 << 16,

    /**
     * Primaries:       x       y
     *  green           0.290   0.600
     *  blue            0.150   0.060
     *  red             0.640   0.330
     *  white (D65)     0.3127  0.3290
     *
     * Use the unadjusted KR = 0.222, KB = 0.071 luminance interpretation
     * for RGB conversion.
     */
    STANDARD_BT601_625_UNADJUSTED = 3 << 16,

    /**
     * Primaries:       x       y
     *  green           0.310   0.595
     *  blue            0.155   0.070
     *  red             0.630   0.340
     *  white (D65)     0.3127  0.3290
     *
     *  KR = 0.299, KB = 0.114. This adjusts the luminance interpretation
     *  for RGB conversion from the one purely determined by the primaries
     *  to minimize the color shift into RGB space that uses BT.709
     *  primaries.
     */
    STANDARD_BT601_525 = 4 << 16,

    /**
     * Primaries:       x       y
     *  green           0.310   0.595
     *  blue            0.155   0.070
     *  red             0.630   0.340
     *  white (D65)     0.3127  0.3290
     *
     * Use the unadjusted KR = 0.212, KB = 0.087 luminance interpretation
     * for RGB conversion (as in SMPTE 240M).
     */
    STANDARD_BT601_525_UNADJUSTED = 5 << 16,

    /**
     * Primaries:       x       y
     *  green           0.170   0.797
     *  blue            0.131   0.046
     *  red             0.708   0.292
     *  white (D65)     0.3127  0.3290
     *
     * Use the unadjusted KR = 0.2627, KB = 0.0593 luminance interpretation
     * for RGB conversion.
     */
    STANDARD_BT2020 = 6 << 16,

    /**
     * Primaries:       x       y
     *  green           0.170   0.797
     *  blue            0.131   0.046
     *  red             0.708   0.292
     *  white (D65)     0.3127  0.3290
     *
     * Use the unadjusted KR = 0.2627, KB = 0.0593 luminance interpretation
     * for RGB conversion using the linear domain.
     */
    STANDARD_BT2020_CONSTANT_LUMINANCE = 7 << 16,

    /**
     * Primaries:       x      y
     *  green           0.21   0.71
     *  blue            0.14   0.08
     *  red             0.67   0.33
     *  white (C)       0.310  0.316
     *
     * Use the unadjusted KR = 0.30, KB = 0.11 luminance interpretation
     * for RGB conversion.
     */
    STANDARD_BT470M = 8 << 16,

    /**
     * Primaries:       x       y
     *  green           0.243   0.692
     *  blue            0.145   0.049
     *  red             0.681   0.319
     *  white (C)       0.310   0.316
     *
     * Use the unadjusted KR = 0.254, KB = 0.068 luminance interpretation
     * for RGB conversion.
     */
    STANDARD_FILM = 9 << 16,

    /**
     * SMPTE EG 432-1 and SMPTE RP 431-2. (DCI-P3)
     * Primaries:       x       y
     *  green           0.265   0.690
     *  blue            0.150   0.060
     *  red             0.680   0.320
     *  white (D65)     0.3127  0.3290
     */
    STANDARD_DCI_P3 = 10 << 16,

    /**
     * Adobe RGB
     * Primaries:       x       y
     *  green           0.210   0.710
     *  blue            0.150   0.060
     *  red             0.640   0.330
     *  white (D65)     0.3127  0.3290
     */
    STANDARD_ADOBE_RGB = 11 << 16,

    /**
     * Transfer aspect
     *
     * Transfer characteristics are the opto-electronic transfer characteristic
     * at the source as a function of linear optical intensity (luminance).
     *
     * For digital signals, E corresponds to the recorded value. Normally, the
     * transfer function is applied in RGB space to each of the R, G and B
     * components independently. This may result in color shift that can be
     * minized by applying the transfer function in Lab space only for the L
     * component. Implementation may apply the transfer function in RGB space
     * for all pixel formats if desired.
     */
    TRANSFER_MASK = 31 << 22,

    /**
     * Transfer characteristics are unknown or are determined by the
     * application.
     *
     * Implementations should use the following transfer functions:
     *
     * For YCbCr formats: use TRANSFER_SMPTE_170M
     * For RGB formats: use TRANSFER_SRGB
     *
     * For all other formats transfer function is undefined, and implementations
     * should use an appropriate standard for the data represented.
     */
    TRANSFER_UNSPECIFIED = 0 << 22,

    /**
     * Transfer characteristic curve:
     *  E = L
     *      L - luminance of image 0 <= L <= 1 for conventional colorimetry
     *      E - corresponding electrical signal
     */
    TRANSFER_LINEAR = 1 << 22,

    /**
     * Transfer characteristic curve:
     *
     * E = 1.055 * L^(1/2.4) - 0.055  for 0.0031308 <= L <= 1
     *   = 12.92 * L                  for 0 <= L < 0.0031308
     *     L - luminance of image 0 <= L <= 1 for conventional colorimetry
     *     E - corresponding electrical signal
     */
    TRANSFER_SRGB = 2 << 22,

    /**
     * BT.601 525, BT.601 625, BT.709, BT.2020
     *
     * Transfer characteristic curve:
     *  E = 1.099 * L ^ 0.45 - 0.099  for 0.018 <= L <= 1
     *    = 4.500 * L                 for 0 <= L < 0.018
     *      L - luminance of image 0 <= L <= 1 for conventional colorimetry
     *      E - corresponding electrical signal
     */
    TRANSFER_SMPTE_170M = 3 << 22,

    /**
     * Assumed display gamma 2.2.
     *
     * Transfer characteristic curve:
     *  E = L ^ (1/2.2)
     *      L - luminance of image 0 <= L <= 1 for conventional colorimetry
     *      E - corresponding electrical signal
     */
    TRANSFER_GAMMA2_2 = 4 << 22,

    /**
     *  display gamma 2.6.
     *
     * Transfer characteristic curve:
     *  E = L ^ (1/2.6)
     *      L - luminance of image 0 <= L <= 1 for conventional colorimetry
     *      E - corresponding electrical signal
     */
    TRANSFER_GAMMA2_6 = 5 << 22,

    /**
     *  display gamma 2.8.
     *
     * Transfer characteristic curve:
     *  E = L ^ (1/2.8)
     *      L - luminance of image 0 <= L <= 1 for conventional colorimetry
     *      E - corresponding electrical signal
     */
    TRANSFER_GAMMA2_8 = 6 << 22,

    /**
     * SMPTE ST 2084 (Dolby Perceptual Quantizer)
     *
     * Transfer characteristic curve:
     *  E = ((c1 + c2 * L^n) / (1 + c3 * L^n)) ^ m
     *  c1 = c3 - c2 + 1 = 3424 / 4096 = 0.8359375
     *  c2 = 32 * 2413 / 4096 = 18.8515625
     *  c3 = 32 * 2392 / 4096 = 18.6875
     *  m = 128 * 2523 / 4096 = 78.84375
     *  n = 0.25 * 2610 / 4096 = 0.1593017578125
     *      L - luminance of image 0 <= L <= 1 for HDR colorimetry.
     *          L = 1 corresponds to 10000 cd/m2
     *      E - corresponding electrical signal
     */
    TRANSFER_ST2084 = 7 << 22,

    /**
     * ARIB STD-B67 Hybrid Log Gamma
     *
     * Transfer characteristic curve:
     *  E = r * L^0.5                 for 0 <= L <= 1
     *    = a * ln(L - b) + c         for 1 < L
     *  a = 0.17883277
     *  b = 0.28466892
     *  c = 0.55991073
     *  r = 0.5
     *      L - luminance of image 0 <= L for HDR colorimetry. L = 1 corresponds
     *          to reference white level of 100 cd/m2
     *      E - corresponding electrical signal
     */
    TRANSFER_HLG = 8 << 22,

    /**
     * Range aspect
     *
     * Defines the range of values corresponding to the unit range of 0-1.
     * This is defined for YCbCr only, but can be expanded to RGB space.
     */
    RANGE_MASK = 7 << 27,

    /**
     * Range is unknown or are determined by the application.  Implementations
     * shall use the following suggested ranges:
     *
     * All YCbCr formats: limited range.
     * All RGB or RGBA formats (including RAW and Bayer): full range.
     * All Y formats: full range
     *
     * For all other formats range is undefined, and implementations should use
     * an appropriate range for the data represented.
     */
    RANGE_UNSPECIFIED = 0 << 27,

    /**
     * Full range uses all values for Y, Cb and Cr from
     * 0 to 2^b-1, where b is the bit depth of the color format.
     */
    RANGE_FULL = 1 << 27,

    /**
     * Limited range uses values 16/256*2^b to 235/256*2^b for Y, and
     * 1/16*2^b to 15/16*2^b for Cb, Cr, R, G and B, where b is the bit depth of
     * the color format.
     *
     * E.g. For 8-bit-depth formats:
     * Luma (Y) samples should range from 16 to 235, inclusive
     * Chroma (Cb, Cr) samples should range from 16 to 240, inclusive
     *
     * For 10-bit-depth formats:
     * Luma (Y) samples should range from 64 to 940, inclusive
     * Chroma (Cb, Cr) samples should range from 64 to 960, inclusive
     */
    RANGE_LIMITED = 2 << 27,

    /**
     * Extended range is used for scRGB. Intended for use with
     * floating point pixel formats. [0.0 - 1.0] is the standard
     * sRGB space. Values outside the range 0.0 - 1.0 can encode
     * color outside the sRGB gamut.
     * Used to blend / merge multiple dataspaces on a single display.
     */
    RANGE_EXTENDED = 3 << 27,

    /**
     * scRGB linear encoding:
     *
     * The red, green, and blue components are stored in extended sRGB space,
     * but are linear, not gamma-encoded.
     * The RGB primaries and the white point are the same as BT.709.
     *
     * The values are floating point.
     * A pixel value of 1.0, 1.0, 1.0 corresponds to sRGB white (D65) at 80 nits.
     * Values beyond the range [0.0 - 1.0] would correspond to other colors
     * spaces and/or HDR content.
     */
    SCRGB_LINEAR = 406913024, // STANDARD_BT709 | TRANSFER_LINEAR | RANGE_EXTENDED

    /**
     * sRGB gamma encoding:
     *
     * The red, green and blue components are stored in sRGB space, and
     * converted to linear space when read, using the SRGB transfer function
     * for each of the R, G and B components. When written, the inverse
     * transformation is performed.
     *
     * The alpha component, if present, is always stored in linear space and
     * is left unmodified when read or written.
     *
     * Use full range and BT.709 standard.
     */
    SRGB = 142671872, // STANDARD_BT709 | TRANSFER_SRGB | RANGE_FULL

    /**
     * scRGB:
     *
     * The red, green, and blue components are stored in extended sRGB space,
     * and gamma-encoded using the SRGB transfer function.
     * The RGB primaries and the white point are the same as BT.709.
     *
     * The values are floating point.
     * A pixel value of 1.0, 1.0, 1.0 corresponds to sRGB white (D65) at 80 nits.
     * Values beyond the range [0.0 - 1.0] would correspond to other colors
     * spaces and/or HDR content.
     */
    SCRGB = 411107328, // STANDARD_BT709 | TRANSFER_SRGB | RANGE_EXTENDED

    /**
     * Display P3
     *
     * Use same primaries and white-point as DCI-P3
     * but sRGB transfer function.
     */
    DISPLAY_P3 = 143261696, // STANDARD_DCI_P3 | TRANSFER_SRGB | RANGE_FULL

    /**
     * ITU-R Recommendation 2020 (BT.2020)
     *
     * Ultra High-definition television
     *
     * Use full range, SMPTE 2084 (PQ) transfer and BT2020 standard
     */
    BT2020_PQ = 163971072, // STANDARD_BT2020 | TRANSFER_ST2084 | RANGE_FULL

    /**
     * ITU-R Recommendation 2020 (BT.2020)
     *
     * Ultra High-definition television
     *
     * Use limited range, SMPTE 2084 (PQ) transfer and BT2020 standard
     */
    BT2020_ITU_PQ = 298188800,  // STANDARD_BT2020 | TRANSFER_ST2084 | RANGE_LIMITED

    /**
     * Adobe RGB
     *
     * Use full range, gamma 2.2 transfer and Adobe RGB primaries
     * Note: Application is responsible for gamma encoding the data as
     * a 2.2 gamma encoding is not supported in HW.
     */
    ADOBE_RGB = 151715840, // STANDARD_ADOBE_RGB | TRANSFER_GAMMA2_2 | RANGE_FULL

    /**
     * JPEG File Interchange Format (JFIF)
     *
     * Same model as BT.601-625, but all values (Y, Cb, Cr) range from 0 to 255
     *
     * Use full range, SMPTE 170M transfer and BT.601_625 standard.
     */
    JFIF = 146931712, // STANDARD_BT601_625 | TRANSFER_SMPTE_170M | RANGE_FULL

    /**
     * ITU-R Recommendation 601 (BT.601) - 525-line
     *
     * Standard-definition television, 525 Lines (NTSC)
     *
     * Use limited range, SMPTE 170M transfer and BT.601_525 standard.
     */
    BT601_625 = 281149440, // STANDARD_BT601_625 | TRANSFER_SMPTE_170M | RANGE_LIMITED

    /**
     * ITU-R Recommendation 709 (BT.709)
     *
     * High-definition television
     *
     * Use limited range, SMPTE 170M transfer and BT.709 standard.
     */
    BT601_525 = 281280512, // STANDARD_BT601_525 | TRANSFER_SMPTE_170M | RANGE_LIMITED

    /**
     * ITU-R Recommendation 2020 (BT.2020)
     *
     * Ultra High-definition television
     *
     * Use full range, BT.709 transfer and BT2020 standard
     */
    BT2020 = 147193856, // STANDARD_BT2020 | TRANSFER_SMPTE_170M | RANGE_FULL

    /**
     * ITU-R Recommendation 709 (BT.709)
     *
     * High-definition television
     *
     * Use limited range, BT.709 transfer and BT.709 standard.
     */
    BT709 = 281083904, // STANDARD_BT709 | TRANSFER_SMPTE_170M | RANGE_LIMITED

    /**
     * SMPTE EG 432-1 and SMPTE RP 431-2.
     *
     * Digital Cinema DCI-P3
     *
     * Use full range, gamma 2.6 transfer and D65 DCI-P3 standard
     * Note: Application is responsible for gamma encoding the data as
     * a 2.6 gamma encoding is not supported in HW.
     */
    DCI_P3 = 155844608, // STANDARD_DCI_P3 | TRANSFER_GAMMA2_6 | RANGE_FULL

    /**
     * sRGB linear encoding:
     *
     * The red, green, and blue components are stored in sRGB space, but
     * are linear, not gamma-encoded.
     * The RGB primaries and the white point are the same as BT.709.
     *
     * The values are encoded using the full range ([0,255] for 8-bit) for all
     * components.
     */
    SRGB_LINEAR = 138477568, // STANDARD_BT709 | TRANSFER_LINEAR | RANGE_FULL

    /**
     * Hybrid Log Gamma encoding:
     *
     * Use full range, hybrid log gamma transfer and BT2020 standard.
     */
    BT2020_HLG = 168165376, // STANDARD_BT2020 | TRANSFER_HLG | RANGE_FULL

    /**
     * ITU Hybrid Log Gamma encoding:
     *
     * Use limited range, hybrid log gamma transfer and BT2020 standard.
     */
    BT2020_ITU_HLG = 302383104, // STANDARD_BT2020 | TRANSFER_HLG | RANGE_LIMITED

    /**
     * Depth:
     *
     * This value is valid with formats HAL_PIXEL_FORMAT_Y16 and HAL_PIXEL_FORMAT_BLOB.
     */
    DEPTH = 4096,

    /**
     * ISO 16684-1:2011(E) Dynamic Depth:
     *
     * Embedded depth metadata following the dynamic depth specification.
     */
    DYNAMIC_DEPTH = 4098
}

