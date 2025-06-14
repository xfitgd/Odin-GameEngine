#+build linux
package android

/**
 * For {@link ANeuralNetworksModel_setOperandValue}, values with a
 * length smaller or equal to this will be immediately copied into
 * the model. The size is in bytes.
 *
 * Available since NNAPI feature level 1.
 */
ANEURALNETWORKS_MAX_SIZE_OF_IMMEDIATELY_COPIED_VALUES :: 128

/**
 * For {@link ANeuralNetworksCompilation_setCaching}, specify the size
 * of the cache token required from the application. The size is in bytes.
 *
 * Available since NNAPI feature level 3.
 */
ANEURALNETWORKS_BYTE_SIZE_OF_CACHE_TOKEN :: 32

/**
 * Aliasing to {@link OperationCode}, used in function
 * {@link ANeuralNetworksModel_addOperation}.
 */
ANeuralNetworksOperationType :: OperationCode

/**
 * Operand types.
 *
 * The type of an operand in a model.
 *
 * Types prefaced with ANEURALNETWORKS_TENSOR_* must be used for tensor data (i.e., tensors
 * with at least one dimension). Types not prefaced by ANEURALNETWORKS_TENSOR_* represent
 * scalar values and must have no dimensions.
 *
 * Although we define many types, most operators accept just a few
 * types. Most used are {@link ANEURALNETWORKS_TENSOR_FLOAT32},
 * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM},
 * and {@link ANEURALNETWORKS_INT32}.
 *
 * Available since NNAPI feature level 1.
 */
OperandCode :: enum i32 {
    /** A 32 bit floating point scalar value. */
    FLOAT32 = 0,
    /** A signed 32 bit integer scalar value. */
    INT32 = 1,
    /** An unsigned 32 bit integer scalar value. */
    UINT32 = 2,
    /** A tensor of 32 bit floating point values. */
    TENSOR_FLOAT32 = 3,
    /** A tensor of 32 bit integer values. */
    TENSOR_INT32 = 4,
    /**
     * A tensor of 8 bit unsigned integers that represent real numbers.
     *
     * Attached to this tensor are two numbers that can be used to convert the
     * 8 bit integer to the real value and vice versa. These two numbers are:
     * - scale: a 32 bit floating point value greater than zero.
     * - zeroPoint: a 32 bit integer, in range [0, 255].
     *
     * The formula is:
     *   real_value = (integer_value - zeroPoint) * scale.
     */
    TENSOR_QUANT8_ASYMM = 5,
    /**
     * An 8 bit boolean scalar value.
     *
     * Values of this operand type are either true or false. A zero value
     * represents false; any other value represents true.
     *
     * Available since NNAPI feature level 3.
     */
    BOOL = 6,
    /**
     * A tensor of 16 bit signed integers that represent real numbers.
     *
     * Attached to this tensor is a number representing real value scale that is
     * used to convert the 16 bit number to a real value in the following way:
     * realValue = integerValue * scale.
     *
     * scale is a 32 bit floating point with value greater than zero.
     *
     * Available since NNAPI feature level 3.
     */
    TENSOR_QUANT16_SYMM = 7,
    /**
     * A tensor of IEEE 754 16 bit floating point values.
     *
     * Available since NNAPI feature level 3.
     */
    TENSOR_FLOAT16 = 8,
    /**
     * A tensor of 8 bit boolean values.
     *
     * Values of this operand type are either true or false. A zero value
     * represents false; any other value represents true.
     *
     * Available since NNAPI feature level 3.
     */
    TENSOR_BOOL8 = 9,
    /**
     * An IEEE 754 16 bit floating point scalar value.
     *
     * Available since NNAPI feature level 3.
     */
    FLOAT16 = 10,
    /**
     * A tensor of 8 bit signed integers that represent real numbers.
     *
     * This tensor is associated with additional fields that can
     * be used to convert the 8 bit signed integer to the real value and vice versa.
     * These fields are:
     * - channelDim: a 32 bit unsigned integer indicating channel dimension.
     * - scales: an array of positive 32 bit floating point values.
     * The size of the scales array must be equal to dimensions[channelDim].
     *
     * {@link ANeuralNetworksModel_setOperandSymmPerChannelQuantParams} must be used
     * to set the parameters for an Operand of this type.
     *
     * The channel dimension of this tensor must not be unknown (dimensions[channelDim] != 0).
     *
     * The formula is:
     * realValue[..., C, ...] =
     *     integerValue[..., C, ...] * scales[C]
     * where C is an index in the Channel dimension.
     *
     * Available since NNAPI feature level 3.
     */
    TENSOR_QUANT8_SYMM_PER_CHANNEL = 11,
    /**
     * A tensor of 16 bit unsigned integers that represent real numbers.
     *
     * Attached to this tensor are two numbers that can be used to convert the
     * 16 bit integer to the real value and vice versa. These two numbers are:
     * - scale: a 32 bit floating point value greater than zero.
     * - zeroPoint: a 32 bit integer, in range [0, 65535].
     *
     * The formula is:
     * real_value = (integer_value - zeroPoint) * scale.
     *
     * Available since NNAPI feature level 3.
     */
    TENSOR_QUANT16_ASYMM = 12,
    /**
     * A tensor of 8 bit signed integers that represent real numbers.
     *
     * Attached to this tensor is a number representing real value scale that is
     * used to convert the 8 bit number to a real value in the following way:
     * realValue = integerValue * scale.
     *
     * scale is a 32 bit floating point with value greater than zero.
     *
     * Available since NNAPI feature level 3.
     */
    TENSOR_QUANT8_SYMM = 13,
    /**
     * A tensor of 8 bit signed integers that represent real numbers.
     *
     * Attached to this tensor are two numbers that can be used to convert the
     * 8 bit integer to the real value and vice versa. These two numbers are:
     * - scale: a 32 bit floating point value greater than zero.
     * - zeroPoint: a 32 bit integer, in range [-128, 127].
     *
     * The formula is:
     * real_value = (integer_value - zeroPoint) * scale.
     *
     * Available since NNAPI feature level 4.
     */
    TENSOR_QUANT8_ASYMM_SIGNED = 14,
    /**
     * A reference to a model.
     *
     * {@link ANeuralNetworksModel_setOperandValueFromModel} must be used to set
     * the value for an Operand of this type.
     *
     * Available since NNAPI feature level 4.
     */
    MODEL = 15,
}

/**
 * Operation types.
 *
 * The type of an operation in a model.
 *
 * Available since NNAPI feature level 1.
 */
OperationCode :: enum i32 {
    // Operations below are available since NNAPI feature level 1.

    /**
     * Adds two tensors, element-wise.
     *
     * Takes two input tensors of identical {@link OperandCode} and compatible
     * dimensions. The output is the sum of both input tensors, optionally
     * modified by an activation function.
     *
     * Two dimensions are compatible when:
     *     1. they are equal, or
     *     2. one of them is 1
     *
     * The size of the output is the maximum size along each dimension of the
     * input operands. It starts with the trailing dimensions, and works its
     * way forward.
     *
     * Example:
     *
     *     input1.dimension = {4, 1, 2}
     *     input2.dimension = {5, 4, 3, 1}
     *     output.dimension = {5, 4, 3, 2}
     *
     * Since NNAPI feature level 3, generic zero-sized input tensor is supported. Zero
     * dimension is only compatible with 0 or 1. The size of the output
     * dimension is zero if either of corresponding input dimension is zero.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     * * {@link ANEURALNETWORKS_TENSOR_INT32} (since NNAPI feature level 4)
     *
	 * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: A tensor.
     * * 1: A tensor of the same {@link OperandCode}, and compatible dimensions
     *      as input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scales and zeroPoint can be different from input0 scale and zeroPoint.
     * * 2: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *      {@link FuseCode} values. Specifies the activation to
     *      invoke on the result.
     *      For a {@link ANEURALNETWORKS_TENSOR_INT32} tensor,
     *      the {@link FuseCode} must be "NONE".
     *
     * Outputs:
     * * 0: The sum, a tensor of the same {@link OperandCode} as input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint can be different from inputs' scale and zeroPoint.
     *
     * Available since NNAPI feature level 1.
     */
    ADD = 0,

    /**
     * Performs a 2-D average pooling operation.
     *
     * The output dimensions are functions of the filter dimensions, stride, and
     * padding.
     *
     * The values in the output tensor are computed as:
     *
     *     output[b, i, j, channel] =
     *         sum_{di, dj}(
     *             input[b, strides[1] * i + di, strides[2] * j + dj, channel]
     *         ) / sum(1)
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: 4, with "NHWC" or "NCHW" data layout.
     * With the default data layout NHWC, the data is stored in the order of:
     * [batch, height, width, channels]. Alternatively, the data layout could
     * be NCHW, the data storage order of: [batch, channels, height, width].
     * NCHW is supported since NNAPI feature level 3.
     *
     * Both explicit padding and implicit padding are supported.
     *
     * Inputs (explicit padding):
     * * 0: A 4-D tensor, of shape [batches, height, width, depth], specifying
     *      the input.
     *      Since NNAPI feature level 3, zero batches is supported for this tensor.
     * * 1: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the left, in the ‘width’ dimension.
     * * 2: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the right, in the ‘width’ dimension.
     * * 3: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the top, in the ‘height’ dimension.
     * * 4: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the bottom, in the ‘height’ dimension.
     * * 5: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘width’ dimension.
     * * 6: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘height’ dimension.
     * * 7: An {@link ANEURALNETWORKS_INT32} scalar, specifying the filter
     *      width.
     * * 8: An {@link ANEURALNETWORKS_INT32} scalar, specifying the filter
     *      height.
     * * 9: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *      {@link FuseCode} values. Specifies the activation to
     *      invoke on the result.
     * * 10: An optional {@link ANEURALNETWORKS_BOOL} scalar, default to false.
     *       Set to true to specify NCHW data layout for input0 and output0.
     *       Available since NNAPI feature level 3.
     *
     * Inputs (implicit padding):
     * * 0: A 4-D tensor, of shape [batches, height, width, depth], specifying
     *      the input.
     *      Since NNAPI feature level 3, zero batches is supported for this tensor.
     * * 1: An {@link ANEURALNETWORKS_INT32} scalar, specifying the implicit
     *      padding scheme, has to be one of the
     *      {@link PaddingCode} values.
     * * 2: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘width’ dimension.
     * * 3: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘height’ dimension.
     * * 4: An {@link ANEURALNETWORKS_INT32} scalar, specifying the filter
     *      width.
     * * 5: An {@link ANEURALNETWORKS_INT32} scalar, specifying the filter
     *      height.
     * * 6: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *      {@link FuseCode} values. Specifies the activation to
     *      invoke on the result.
     * * 7: An optional {@link ANEURALNETWORKS_BOOL} scalar, default to false.
     *      Set to true to specify NCHW data layout for input0 and output0.
     *      Available since NNAPI feature level 3.
     *
     * Outputs:
     * * 0: The output 4-D tensor, of shape
     *      [batches, out_height, out_width, depth].
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 1.
     */
    AVERAGE_POOL_2D = 1,

    /**
     * Concatenates the input tensors along the given dimension.
     *
     * The input tensors must have identical {@link OperandCode} and the same
     * dimensions except the dimension along the concatenation axis.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *   (full support since NNAPI feature level 3, see the input section)
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0 ~ n-1: The list of n input tensors, of shape
     *            [D0, D1, ..., Daxis(i), ..., Dm].
     *            Before NNAPI feature level 3, all input tensors of
     *            {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *            must have the same scale and zeroPoint as the output tensor.
     *            Input tensors of
     *            {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}
     *            are allowed to have different scale and zeroPoint.
     *            Since NNAPI feature level 3, zero-sized tensors are supported.
     * * n: An {@link ANEURALNETWORKS_INT32} scalar, specifying the
     *      concatenation axis.
     *
     * Outputs:
     * * 0: The output, a tensor of the same {@link OperandCode} as the input
     *      tensors. The output shape is [D0, D1, ..., sum(Daxis(i)), ..., Dm].
     *      Since NNAPI feature level 3, for a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} tensor,
     *      the scale and zeroPoint values can be different from
     *      input tensors. Before NNAPI feature level 3 they have to be the same as for the
     *      input tensors.
     *
     * Available since NNAPI feature level 1.
     */
    CONCATENATION = 2,

    /**
     * Performs a 2-D convolution operation.
     *
     * The CONV_2D op sweeps a 2-D filter that can mix channels together over a
     * batch of images, applying the filter to each window of each image of the
     * appropriate size.
     *
     * The output dimensions are functions of the filter dimensions, stride, and
     * padding.
     *
     * The values in the output tensor are computed as:
     *
     *     output[b, i, j, channel] =
     *         sum_{di, dj, k} (
     *             input[b, strides[1] * i + di, strides[2] * j + dj, k] *
     *             filter[channel, di, dj, k]
     *         ) + bias[channel]
     *
     * Supported tensor {@link OperandCode} configurations:
     * * 32 bit floating point:
     * * * {@link ANEURALNETWORKS_TENSOR_FLOAT32} for input, filter, output, and bias.
     *
     * * Quantized:
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} for input, filter, and output.
     * * * {@link ANEURALNETWORKS_TENSOR_INT32} for bias (with scale set to
     * * * input.scale * filter.scale).
     *
     * Available since NNAPI feature level 3:
     * * 16 bit floating point:
     * * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} for input, filter, output, and bias.
     *
     * * Quantized with symmetric per channel quantization for the filter:
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} for input, and output.
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL} for filter.
     * * * {@link ANEURALNETWORKS_TENSOR_INT32} for bias (scale set to 0.0,
     * * * each value scaling is separate and equal to input.scale * filter.scales[channel]).
     *
     * Available since NNAPI feature level 4:
     * * Quantized signed (since NNAPI feature level 4):
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} for input, filter, and output.
     * * * {@link ANEURALNETWORKS_TENSOR_INT32} for bias (with scale set to
     * * * input.scale * filter.scale).
     *
     * * Quantized signed with filter symmetric per channel quantization
     *   (since NNAPI feature level 4):
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} for input, and output.
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL} for filter.
     * * * {@link ANEURALNETWORKS_TENSOR_INT32} for bias (scale set to 0.0,
     * * * each value scaling is separate and equal to input.scale * filter.scales[channel]).
     *
     * Supported tensor rank: 4, with "NHWC" or "NCHW" data layout.
     * With the default data layout NHWC, the data is stored in the order of:
     * [batch, height, width, channels]. Alternatively, the data layout could
     * be NCHW, the data storage order of: [batch, channels, height, width].
     * NCHW is supported since NNAPI feature level 3.
     *
     * Both explicit padding and implicit padding are supported.
     *
     * Inputs (explicit padding):
     * * 0: A 4-D tensor, of shape [batches, height, width, depth_in],
     *      specifying the input.
     *      Since NNAPI feature level 3, zero batches is supported for this tensor.
     * * 1: A 4-D tensor, of shape
     *      [depth_out, filter_height, filter_width, depth_in], specifying the
     *      filter.
     *      For tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL}
     *      the channel dimension (ANeuralNetworksSymmPerChannelQuantParams::channelDim)
     *      must be set to 0.
     * * 2: A 1-D tensor, of shape [depth_out], specifying the bias. For input
     *      tensor of type {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *      or {@link ANEURALNETWORKS_TENSOR_FLOAT16} the bias must be of the same type.
     *      For filter tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED},
     *      the bias should be of {@link ANEURALNETWORKS_TENSOR_INT32}, with zeroPoint
     *      of 0 and bias_scale == input_scale * filter_scale.
     *      For filter tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL},
     *      the bias should be of {@link ANEURALNETWORKS_TENSOR_INT32}, with zeroPoint of 0
     *      and bias_scale of 0. The actual scale of each value 'i' is equal to
     *      bias_scale[i] = input_scale * filter_scale[i].
     * * 3: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the left, in the ‘width’ dimension.
     * * 4: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the right, in the ‘width’ dimension.
     * * 5: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the top, in the ‘height’ dimension.
     * * 6: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the bottom, in the ‘height’ dimension.
     * * 7: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘width’ dimension.
     * * 8: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘height’ dimension.
     * * 9: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *      {@link FuseCode} values. Specifies the activation to
     *      invoke on the result.
     * * 10: An optional {@link ANEURALNETWORKS_BOOL} scalar, default to false.
     *      Set to true to specify NCHW data layout for input0 and output0.
     *      Available since NNAPI feature level 3.
     * * 11: An optional {@link ANEURALNETWORKS_INT32} scalar, specifying the dilation
     *      factor for width. Defaults to 1. If set to k > 1, there will be k-1 skipped
     *      cells between each filter element on width dimension. If this input is set,
     *      input 12 (dilation factor for height) must be specified as well.
     *      Available since NNAPI feature level 3.
     * * 12: An optional {@link ANEURALNETWORKS_INT32} scalar, specifying the dilation
     *      factor for height. Defaults to 1. If set to k > 1, there will be k-1 skipped
     *      cells between each filter element on height dimension. If this input is set,
     *      input 11 (dilation factor for width) must be specified as well.
     *      Available since NNAPI feature level 3.
     *
     * Inputs (implicit padding):
     * * 0: A 4-D tensor, of shape [batches, height, width, depth_in],
     *      specifying the input.
     *      Since NNAPI feature level 3, zero batches is supported for this tensor.
     * * 1: A 4-D tensor, of shape
     *      [depth_out, filter_height, filter_width, depth_in], specifying the
     *      filter.
     *      For tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL}
     *      the channel dimension (ANeuralNetworksSymmPerChannelQuantParams::channelDim)
     *      must be set to 0.
     * * 2: A 1-D tensor, of shape [depth_out], specifying the bias. For input
     *      tensor of type {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *      or {@link ANEURALNETWORKS_TENSOR_FLOAT16} the bias must be of the same
     *      type.
     *      For filter tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED},
     *      the bias should be of {@link ANEURALNETWORKS_TENSOR_INT32}, with zeroPoint
     *      of 0 and bias_scale == input_scale * filter_scale.
     *      For filter tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL},
     *      the bias should be of {@link ANEURALNETWORKS_TENSOR_INT32}, with zeroPoint of 0
     *      and bias_scale of 0. The actual scale of each value 'i' is equal to
     *      bias_scale[i] = input_scale * filter_scale[i].
     * * 3: An {@link ANEURALNETWORKS_INT32} scalar, specifying the implicit
     *      padding scheme, has to be one of the
     *      {@link PaddingCode} values.
     * * 4: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘width’ dimension.
     * * 5: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘height’ dimension.
     * * 6: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *      {@link FuseCode} values. Specifies the activation to
     *      invoke on the result.
     * * 7: An optional {@link ANEURALNETWORKS_BOOL} scalar, default to false.
     *      Set to true to specify NCHW data layout for input0 and output0.
     *      Available since NNAPI feature level 3.
     * * 8: An optional {@link ANEURALNETWORKS_INT32} scalar, specifying the dilation
     *      factor for width. Defaults to 1. If set to k > 1, there will be k-1 skipped
     *      cells between each filter element on width dimension. If this input is set,
     *      input 9 (dilation factor for height) must be specified as well.
     *      Available since NNAPI feature level 3.
     * * 9: An optional {@link ANEURALNETWORKS_INT32} scalar, specifying the dilation
     *      factor for height. Defaults to 1. If set to k > 1, there will be k-1 skipped
     *      cells between each filter element on height dimension. If this input is set,
     *      input 8 (dilation factor for width) must be specified as well.
     *      Available since NNAPI feature level 3.
     *
     * Outputs:
     * * 0: The output 4-D tensor, of shape
     *      [batches, out_height, out_width, depth_out].
     *      Before NNAPI feature level 3, for output tensor of
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}, the following condition must
     *      be satisfied: output_scale > input_scale * filter_scale
     *
     * Available since NNAPI feature level 1.
     */
    CONV_2D = 3,

    /**
     * Performs a depthwise 2-D convolution operation.
     *
     * Given an input tensor of shape [batches, height, width, depth_in] and a
     * filter tensor of shape [1, filter_height, filter_width, depth_out]
     * containing depth_out convolutional filters of depth 1, DEPTHWISE_CONV
     * applies a different filter to each input channel (expanding from 1
     * channel to channel_multiplier channels for each), then concatenates the
     * results together.
     *
     * The output has depth_out = depth_in * depth_multiplier channels.
     * The output dimensions are functions of the filter dimensions, stride, and
     * padding.
     *
     * The values in the output tensor are computed as:
     *
     *     output[b, i, j, k * channel_multiplier + q] =
     *         sum_{di, dj} (
     *             input[b, strides[1] * i + di, strides[2] * j + dj, k] *
     *             filter[1, di, dj, k * channel_multiplier + q]
     *         ) + bias[k * channel_multiplier + q]
     *
     * Supported tensor {@link OperandCode} configurations:
     * * 32 bit floating point:
     * * * {@link ANEURALNETWORKS_TENSOR_FLOAT32} for input, filter, output, and bias.
     *
     * * Quantized:
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} for input, filter, and output.
     * * * {@link ANEURALNETWORKS_TENSOR_INT32} for bias (with scale set to
     * * * input.scale * filter.scale).
     *
     * Available since NNAPI feature level 3:
     * * 16 bit floating point:
     * * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} for input, filter, output, and bias.
     *
     * * Quantized with symmetric per channel quantization for the filter:
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} for input, and output.
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL} for filter.
     * * * {@link ANEURALNETWORKS_TENSOR_INT32} for bias (scale set to 0.0,
     * * * each value scaling is separate and equal to input.scale * filter.scales[channel]).
     *
     * Available since NNAPI feature level 4:
     * * Quantized signed (since NNAPI feature level 4):
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} for input, filter, and output.
     * * * {@link ANEURALNETWORKS_TENSOR_INT32} for bias (with scale set to
     * * * input.scale * filter.scale).
     *
     * * Quantized signed with filter symmetric per channel quantization
     *   (since NNAPI feature level 4):
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} for input, and output.
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL} for filter.
     * * * {@link ANEURALNETWORKS_TENSOR_INT32} for bias (scale set to 0.0,
     * * * each value scaling is separate and equal to input.scale * filter.scales[channel]).
     *
     * Supported tensor rank: 4, with "NHWC" or "NCHW" data layout.
     * With the default data layout NHWC, the data is stored in the order of:
     * [batch, height, width, channels]. Alternatively, the data layout could
     * be NCHW, the data storage order of: [batch, channels, height, width].
     * NCHW is supported since NNAPI feature level 3.
     *
     * Both explicit padding and implicit padding are supported.
     *
     * Inputs (explicit padding):
     * * 0: A 4-D tensor, of shape [batches, height, width, depth_in],
     *      specifying the input.
     * * 1: A 4-D tensor, of shape [1, filter_height, filter_width, depth_out],
     *      specifying the filter.
     *      For tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL}
     *      the channel dimension (ANeuralNetworksSymmPerChannelQuantParams::channelDim)
     *      must be set to 3.
     * * 2: A 1-D tensor, of shape [depth_out], specifying the bias. For input
     *      tensor of type {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *      or {@link ANEURALNETWORKS_TENSOR_FLOAT16} the bias must be of the same type.
     *      For filter tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED},
     *      the bias should be of {@link ANEURALNETWORKS_TENSOR_INT32}, with zeroPoint
     *      of 0 and bias_scale == input_scale * filter_scale.
     *      For filter tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL},
     *      the bias should be of {@link ANEURALNETWORKS_TENSOR_INT32}, with zeroPoint of 0
     *      and bias_scale of 0. The actual scale of each value 'i' is equal to
     *      bias_scale[i] = input_scale * filter_scale[i].
     * * 3: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the left, in the ‘width’ dimension.
     * * 4: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the right, in the ‘width’ dimension.
     * * 5: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the top, in the ‘height’ dimension.
     * * 6: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the bottom, in the ‘height’ dimension.
     * * 7: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘width’ dimension.
     * * 8: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘height’ dimension.
     * * 9: An {@link ANEURALNETWORKS_INT32} scalar, specifying the depthwise
     *      multiplier.
     * * 10: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *       {@link FuseCode} values. Specifies the activation to
     *       invoke on the result.
     * * 11: An optional {@link ANEURALNETWORKS_BOOL} scalar, default to false.
     *       Set to true to specify NCHW data layout for input0 and output0.
     *       Available since NNAPI feature level 3.
     * * 12: An optional {@link ANEURALNETWORKS_INT32} scalar, specifying the dilation
     *      factor for width. Defaults to 1. If set to k > 1, there will be k-1 skipped
     *      cells between each filter element on width dimension. If this input is set,
     *      input 13 (dilation factor for height) must be specified as well.
     *      Available since NNAPI feature level 3.
     * * 13: An optional {@link ANEURALNETWORKS_INT32} scalar, specifying the dilation
     *      factor for height. Defaults to 1. If set to k > 1, there will be k-1 skipped
     *      cells between each filter element on height dimension. If this input is set,
     *      input 12 (dilation factor for width) must be specified as well.
     *      Available since NNAPI feature level 3.
     *
     * Inputs (implicit padding):
     * * 0: A 4-D tensor, of shape [batches, height, width, depth_in],
     *      specifying the input.
     * * 1: A 4-D tensor, of shape [1, filter_height, filter_width, depth_out],
     *      specifying the filter.
     * * 2: A 1-D tensor, of shape [depth_out], specifying the bias. For input
     *      tensor of type {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *      or {@link ANEURALNETWORKS_TENSOR_FLOAT16} the bias must be of the same type.
     *      For filter tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED},
     *      the bias should be of {@link ANEURALNETWORKS_TENSOR_INT32}, with zeroPoint
     *      of 0 and bias_scale == input_scale * filter_scale.
     *      For filter tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL},
     *      the bias should be of {@link ANEURALNETWORKS_TENSOR_INT32}, with zeroPoint of 0
     *      and bias_scale of 0. The actual scale of each value 'i' is equal to
     *      bias_scale[i] = input_scale * filter_scale[i].
     * * 3: An {@link ANEURALNETWORKS_INT32} scalar, specifying the implicit
     *      padding scheme, has to be one of the
     *      {@link PaddingCode} values.
     * * 4: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘width’ dimension.
     * * 5: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘height’ dimension.
     * * 6: An {@link ANEURALNETWORKS_INT32} scalar, specifying the depthwise
     *      multiplier.
     * * 7: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *      {@link FuseCode} values. Specifies the activation to
     *      invoke on the result.
     * * 8: An optional {@link ANEURALNETWORKS_BOOL} scalar, default to false.
     *      Set to true to specify NCHW data layout for input0 and output0.
     *      Available since NNAPI feature level 3.
     * * 9: An optional {@link ANEURALNETWORKS_INT32} scalar, specifying the dilation
     *      factor for width. Defaults to 1. If set to k > 1, there will be k-1 skipped
     *      cells between each filter element on width dimension. If this input is set,
     *      input 10 (dilation factor for height) must be specified as well.
     *      Available since NNAPI feature level 3.
     * * 10: An optional {@link ANEURALNETWORKS_INT32} scalar, specifying the dilation
     *      factor for height. Defaults to 1. If set to k > 1, there will be k-1 skipped
     *      cells between each filter element on height dimension. If this input is set,
     *      input 9 (dilation factor for width) must be specified as well.
     *      Available since NNAPI feature level 3.
     *
     * Outputs:
     * * 0: The output 4-D tensor, of shape
     *      [batches, out_height, out_width, depth_out]. Before NNAPI feature level 3, for
     *      output tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM},
     *      the following condition must be satisfied:
     *      output_scale > input_scale * filter_scale
     *
     * Available since NNAPI feature level 1.
     */
    DEPTHWISE_CONV_2D = 4,

    /**
     * Rearranges data from depth into blocks of spatial data.
     *
     * More specifically, this op outputs a copy of the input tensor where
     * values from the depth dimension are moved in spatial blocks to the height
     * and width dimensions. The value block_size indicates the input block size
     * and how the data is moved.
     *
     * Chunks of data of size block_size * block_size from depth are rearranged
     * into non-overlapping blocks of size block_size x block_size.
     *
     * The width of the output tensor is input_depth * block_size, whereas the
     * height is input_height * block_size. The depth of the input tensor must
     * be divisible by block_size * block_size
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: 4, with "NHWC" or "NCHW" data layout.
     * With the default data layout NHWC, the data is stored in the order of:
     * [batch, height, width, channels]. Alternatively, the data layout could
     * be NCHW, the data storage order of: [batch, channels, height, width].
     * NCHW is supported since NNAPI feature level 3.
     *
     * Inputs:
     * * 0: A 4-D tensor, of shape [batches, height, width, depth_in],
     *      specifying the input.
     * * 1: An {@link ANEURALNETWORKS_INT32} scalar, specifying the block_size.
     *      block_size must be >=1 and block_size * block_size must be a divisor
     *      of the input depth.
     * * 2: An optional {@link ANEURALNETWORKS_BOOL} scalar, default to false.
     *      Set to true to specify NCHW data layout for input0 and output0.
     *      Available since NNAPI feature level 3.
     *
     * Outputs:
     * * 0: The output 4-D tensor, of shape [batch, height*block_size,
     *      width*block_size, depth/(block_size*block_size)].
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 1.
     */
    DEPTH_TO_SPACE = 5,

    /**
     * Dequantizes the input tensor.
     *
     * The formula is:
     *
     *     output = (input - zeroPoint) * scale.
     *
     * Supported input tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported output tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}.
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: A tensor.
     *      Since NNAPI feature level 3, this tensor may be zero-sized.
     *
     * Outputs:
     * * 0: A tensor with the same shape as input0.
     *
     * Available since NNAPI feature level 1.
     */
    DEQUANTIZE = 6,

    /**
     * Looks up sub-tensors in the input tensor.
     *
     * This operator takes for input a tensor of values (Values) and
     * a one-dimensional tensor of selection indices (Lookups).
     * The output tensor is the concatenation of sub-tensors of Values as
     * selected by Lookups.
     *
     * Think of Values as being sliced along its first dimension:
     * The entries in Lookups select which slices are concatenated together
     * to create the output tensor.
     *
     * For example, if Values has shape of [40, 200, 300] and
     * Lookups has shape of [3], all three values found in Lookups are
     * expected to be between 0 and 39. The resulting tensor must
     * have shape of [3, 200, 300].
     *
     * If a value in Lookups is out of bounds, the operation must fail
     * and an error must be reported.
     *
     * Supported value tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 4)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported value tensor rank: from 2
     *
     * Inputs:
     * * 0: Lookups. A 1-D tensor of {@link ANEURALNETWORKS_TENSOR_INT32}.
     *      The values are indices into the first dimension of Values.
     * * 1: Values. An n-D tensor, where n >= 2, from which sub-tensors are
     *      extracted.
     *
     * Output:
     * * 0: A n-D tensor with the same rank and shape as the Values
     *      tensor, except for the first dimension which has the same size
     *      as Lookups' only dimension.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input1.
     *
     * Available since NNAPI feature level 1.
     */
    EMBEDDING_LOOKUP = 7,

    /**
     * Computes element-wise floor() on the input tensor.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: A tensor.
     *
     * Outputs:
     * * 0: The output tensor, of the same {@link OperandCode} and dimensions as
     *      the input tensor.
     *
     * Available since NNAPI feature level 1.
     */
    FLOOR = 8,

    /**
     * Denotes a fully (densely) connected layer, which connects all elements
     * in the input tensor with each element in the output tensor.
     *
     * This layer implements the operation:
     *
     *     outputs = activation(inputs * weights’ + bias)
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4.
     *
     * Inputs:
     * * 0: A tensor of at least rank 2, specifying the input. If rank is
     *      greater than 2, then it gets flattened to a 2-D Tensor. The
     *      (flattened) 2-D Tensor is reshaped (if necessary) to
     *      [batch_size, input_size], where "input_size" corresponds to the
     *      number of inputs to the layer, matching the second dimension of
     *      weights, and "batch_size" is calculated by dividing the number of
     *      elements by "input_size".
     *      Since NNAPI feature level 3, zero batch_size is supported for this tensor.
     * * 1: A 2-D tensor, specifying the weights, of shape
     *      [num_units, input_size], where "num_units" corresponds to the number
     *      of output nodes.
     * * 2: A 1-D tensor, of shape [num_units], specifying the bias. For input
     *      tensor of {@link ANEURALNETWORKS_TENSOR_FLOAT32}, the bias should
     *      also be of {@link ANEURALNETWORKS_TENSOR_FLOAT32}.
     *      For input tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED},
     *      the bias should be of {@link ANEURALNETWORKS_TENSOR_INT32},
     *      with zeroPoint of 0 and bias_scale == input_scale * filter_scale.
     * * 3: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *      {@link FuseCode} values. Specifies the activation to
     *      invoke on the result.
     *
     * Outputs:
     * * 0: The output tensor, of shape [batch_size, num_units]. Before NNAPI feature level 3, for
     *      output tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}, the following
     *      condition must be satisfied: output_scale > input_scale * filter_scale.
     *
     * Available since NNAPI feature level 1.
     */
    FULLY_CONNECTED = 9,

    /**
     * Looks up sub-tensors in the input tensor using a key-value map.
     *
     * This operator takes for input a tensor of values (Values),
     * a one-dimensional tensor of selection values (Lookups) and
     * a one-dimensional tensor that maps these values to Values
     * indexes. The output tensor is the concatenation of sub-tensors of
     * Values as selected by Lookups via Keys.
     *
     * Think of Values as being sliced along its outer-most dimension.
     * The output is a concatenation of selected slices, with one slice
     * for each entry of Lookups. The slice selected is the one at the
     * same index as the Maps entry that matches the value in Lookups.
     *
     * For a hit, the corresponding sub-tensor of Values is included
     * in the Output tensor. For a miss, the corresponding sub-tensor in
     * Output must have zero values.
     *
     * For example, if Values has shape of [40, 200, 300],
     * Keys should have a shape of [40]. If Lookups tensor has shape
     * of [3], three slices are being concatenated, so the resulting tensor
     * must have the shape of [3, 200, 300]. If the first entry in Lookups
     * has the value 123456, that value must be located in Keys tensor.
     * If the sixth entry of Keys contains 123456, the sixth slice of Values
     * must be selected. If no entry in Keys has 123456, a slice of zeroes
     * must be concatenated.
     *
     * Supported value tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *
     * Supported value tensor rank: from 2
     *
     * Inputs:
     * * 0: Lookups. A 1-D {@link ANEURALNETWORKS_TENSOR_INT32} tensor with
     *      shape [ k ].
     * * 1: Keys. A 1-D {@link ANEURALNETWORKS_TENSOR_INT32} tensor with shape
     *      [ n ]; Keys and Values pair represent a map, i.e., the ith element
     *      in Keys (Keys[i]) is the key to select the ith sub-tensor in Values
     *      (Values[i]), where 0 <= i <= n-1. Keys tensor *MUST* be sorted in
     *      ascending order.
     * * 2: Values. A tensor with shape of [ n, … ]; i.e., the first dimension
     *      must be n.
     *
     * Outputs:
     * * 0: Output. A tensor with shape [ k …].
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} tensor,
     *      the scale and zeroPoint must be the same as input2.
     * * 1: Hits. A boolean tensor with shape [ k ] indicates whether the lookup
     *      hits (True) or not (False).
     *      Stored as {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} with offset 0
     *      and scale 1.0f.
     *      A non-zero byte represents True, a hit. A zero indicates otherwise.
     *
     * Available since NNAPI feature level 1.
     */
    HASHTABLE_LOOKUP = 10,

    /**
     * Applies L2 normalization along the axis dimension.
     *
     * The values in the output tensor are computed as:
     *
     *     output[batch, row, col, channel] =
     *         input[batch, row, col, channel] /
     *         sqrt(sum_{c} pow(input[batch, row, col, c], 2))
     *
     * By default the axis dimension is the last dimension of the input tensor.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4
     * Tensors with rank less than 4 are only supported since NNAPI feature level 3.
     *
     * Inputs:
     * * 0: An n-D tensor, specifying the tensor to be normalized.
     * * 1: An optional {@link ANEURALNETWORKS_INT32} scalar, default to -1,
     *      specifying the dimension normalization would be performed on.
     *      Negative index is used to specify axis from the end (e.g. -1 for
     *      the last axis). Must be in the range [-n, n).
     *      Available since NNAPI feature level 3.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} and same shape as input0.
     *      For {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM},
     *      the scale must be 1.f / 128 and the zeroPoint must be 128.
     *      For {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED},
     *      the scale must be 1.f / 128 and the zeroPoint must be 0.
     *
     *      NOTE: Before NNAPI feature level 4, if the elements along an axis are all zeros,
     *      the result is undefined. Since NNAPI feature level 4, if the elements along an axis
     *      are all zeros, the result is logical zero.
     *
     * Available since NNAPI feature level 1.
     */
    L2_NORMALIZATION = 11,

    /**
     * Performs an 2-D L2 pooling operation.
     *
     * The output dimensions are functions of the filter dimensions, stride, and
     * padding.
     *
     * The values in the output tensor are computed as:
     *
     *     output[b, i, j, c] =
     *         sqrt(sum_{di, dj} pow(input[b, strides[1] * i + di, strides[2] * j + dj, c], 2) /
     *              sum(1))
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * Supported tensor rank: 4, with "NHWC" or "NCHW" data layout.
     * With the default data layout NHWC, the data is stored in the order of:
     * [batch, height, width, channels]. Alternatively, the data layout could
     * be NCHW, the data storage order of: [batch, channels, height, width].
     * NCHW is supported since NNAPI feature level 3.
     *
     * Both explicit padding and implicit padding are supported.
     *
     * Inputs (explicit padding):
     * * 0: A 4-D tensor, of shape [batches, height, width, depth], specifying
     *      the input.
     *      Since NNAPI feature level 3, zero batches is supported for this tensor.
     * * 1: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the left, in the ‘width’ dimension.
     * * 2: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the right, in the ‘width’ dimension.
     * * 3: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the top, in the ‘height’ dimension.
     * * 4: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the bottom, in the ‘height’ dimension.
     * * 5: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘width’ dimension.
     * * 6: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘height’ dimension.
     * * 7: An {@link ANEURALNETWORKS_INT32} scalar, specifying the filter
     *      width.
     * * 8: An {@link ANEURALNETWORKS_INT32} scalar, specifying the filter
     *      height.
     * * 9: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *      {@link FuseCode} values. Specifies the activation to
     *      invoke on the result.
     * * 10: An optional {@link ANEURALNETWORKS_BOOL} scalar, default to false.
     *       Set to true to specify NCHW data layout for input0 and output0.
     *       Available since NNAPI feature level 3.
     *
     * Inputs (implicit padding):
     * * 0: A 4-D tensor, of shape [batches, height, width, depth], specifying
     *      the input.
     *      Since NNAPI feature level 3, zero batches is supported for this tensor.
     * * 1: An {@link ANEURALNETWORKS_INT32} scalar, specifying the implicit
     *      padding scheme, has to be one of the
     *      {@link PaddingCode} values.
     * * 2: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘width’ dimension.
     * * 3: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘height’ dimension.
     * * 4: An {@link ANEURALNETWORKS_INT32} scalar, specifying the filter
     *      width.
     * * 5: An {@link ANEURALNETWORKS_INT32} scalar, specifying the filter
     *      height.
     * * 6: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *      {@link FuseCode} values. Specifies the activation to
     *      invoke on the result.
     * * 7: An optional {@link ANEURALNETWORKS_BOOL} scalar, default to false.
     *      Set to true to specify NCHW data layout for input0 and output0.
     *      Available since NNAPI feature level 3.
     *
     * Outputs:
     * * 0: The output 4-D tensor, of shape
     *      [batches, out_height, out_width, depth].
     *
     * Available since NNAPI feature level 1.
     */
    L2_POOL_2D = 12,

    /**
     * Applies Local Response Normalization along the depth dimension.
     *
     * The 4-D input tensor is treated as a 3-D array of 1-D vectors (along the
     * last dimension), and each vector is normalized independently. Within a
     * given vector, each component is divided by the weighted, squared sum of
     * inputs within depth_radius.
     *
     * The output is calculated using this formula:
     *
     *     sqr_sum[a, b, c, d] = sum(
     *         pow(input[a, b, c, d - depth_radius : d + depth_radius + 1], 2))
     *     output = input / pow((bias + alpha * sqr_sum), beta)
     *
     * For input tensor with rank less than 4, independently normalizes each
     * 1-D slice along specified dimension.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * Supported tensor rank: up to 4
     * Tensors with rank less than 4 are only supported since NNAPI feature level 3.
     *
     * Inputs:
     * * 0: A 4-D tensor, of shape [batches, height, width, depth], specifying
     *      the input.
     * * 1: An {@link ANEURALNETWORKS_INT32} scalar, specifying the radius of
     *      the normalization window.
     * * 2: A scalar, specifying the bias, must not be zero.
     *      For input tensor of {@link ANEURALNETWORKS_TENSOR_FLOAT16}, the bias
     *      value must be of {@link ANEURALNETWORKS_FLOAT16}.
     *      For input tensor of {@link ANEURALNETWORKS_TENSOR_FLOAT32}, the bias
     *      value must be of {@link ANEURALNETWORKS_FLOAT32}.
     * * 3: A scalar, specifying the scale factor, alpha.
     *      For input tensor of {@link ANEURALNETWORKS_TENSOR_FLOAT16}, the
     *      alpha value must be of {@link ANEURALNETWORKS_FLOAT16}.
     *      For input tensor of {@link ANEURALNETWORKS_TENSOR_FLOAT32}, the
     *      alpha value must be of {@link ANEURALNETWORKS_FLOAT32}.
     * * 4: A scalar, specifying the exponent, beta.
     *      For input tensor of {@link ANEURALNETWORKS_TENSOR_FLOAT16}, the beta
     *      value must be of {@link ANEURALNETWORKS_FLOAT16}.
     *      For input tensor of {@link ANEURALNETWORKS_TENSOR_FLOAT32}, the beta
     *      value must be of {@link ANEURALNETWORKS_FLOAT32}.
     * * 5: An optional {@link ANEURALNETWORKS_INT32} scalar, default to -1,
     *      specifying the dimension normalization would be performed on.
     *      Negative index is used to specify axis from the end (e.g. -1 for
     *      the last axis). Must be in the range [-n, n).
     *      Available since NNAPI feature level 3.
     *
     * Outputs:
     * * 0: The output tensor of same shape as input0.
     *
     * Available since NNAPI feature level 1.
     */
    LOCAL_RESPONSE_NORMALIZATION = 13,

    /**
     * Computes sigmoid activation on the input tensor element-wise.
     *
     * The output is calculated using this formula:
     *
     *     output = 1 / (1 + exp(-input))
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4.
     *
     * Inputs:
     * * 0: A tensor, specifying the input.
     *      Since NNAPI feature level 3, this tensor may be zero-sized.
     *
     * Outputs:
     * * 0: The output tensor of same shape as input0.
     *      For {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM},
     *      the scale must be 1.f / 256 and the zeroPoint must be 0.
     *      For {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED},
     *      the scale must be 1.f / 256 and the zeroPoint must be -128.
     *
     * Available since NNAPI feature level 1.
     */
    LOGISTIC = 14,

    /**
     * Projects an input to a bit vector via locality senstive hashing.
     *
     * Supported input tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *
     * Supported input tensor rank: from 1
     *
     * Inputs:
     * * 0: Hash functions. Dim.size == 2, DataType: Float.
     *      Tensor[0].Dim[0]: Number of hash functions.
     *      Tensor[0].Dim[1]: Number of projected output bits generated by each
     *      hash function.
     *      If the projection type is Sparse:
     *      Tensor[0].Dim[1] + ceil(log2(Tensor[0].Dim[0])) <= 32
     *
     * * 1: Input. Dim.size >= 1, no restriction on DataType.
     * * 2: Weight. Optional. Dim.size == 1, DataType: Float.
     *      If not set, each input element is considered to have the same weight
     *      of 1.0.
     *      Tensor[1].Dim[0] == Tensor[2].Dim[0]
     * * 3: Type:
     *        Sparse:
     *          Value LSHProjectionType_SPARSE(=3) (since NNAPI feature level 3).
     *          Computed bit vector is considered to be sparse.
     *          Each output element is an int32 made up of multiple bits
     *          computed from hash functions.
     *
     *          NOTE: To avoid collisions across hash functions, an offset value
     *          of k * (1 << Tensor[0].Dim[1]) will be added to each signature,
     *          where k is the index of the hash function.
     *
     *          Value LSHProjectionType_SPARSE_DEPRECATED(=1).
     *          Legacy behavior that does not include the offset value.
     *
     *        Dense:
     *          Value LSHProjectionType_DENSE(=2).
     *          Computed bit vector is considered to be dense. Each output
     *          element represents a bit and can take the value of either
     *          0 or 1.
     *
     * Outputs:
     * * 0: If the projection type is Sparse:
     *      Output.Dim == { Tensor[0].Dim[0] }
     *      A tensor of int32 that represents hash signatures.
     *
     *      If the projection type is Dense:
     *      Output.Dim == { Tensor[0].Dim[0] * Tensor[0].Dim[1] }
     *      A flattened tensor that represents projected bit vectors.
     *
     * Available since NNAPI feature level 1.
     * The offset value for sparse projections was added in NNAPI feature level 3.
     */
    LSH_PROJECTION = 15,

    /**
     * Performs a single time step in a Long Short-Term Memory (LSTM) layer
     *
     * The LSTM operation is described by the following equations.
     *
     * \f{eqnarray*}{
     * i_t =& \sigma(W_{xi}x_t+W_{hi}h_{t-1}+W_{ci}C_{t-1}+b_i) & \\
     * f_t =& \sigma(W_{xf}x_t+W_{hf}h_{t-1}+W_{cf}C_{t-1}+b_f) & \\
     * C_t =& clip(f_t \odot C_{t-1} + i_t \odot
     *        g(W_{xc}x_t+W_{hc}h_{t-1}+b_c),\ t_{cell}) & \\
     * o_t =& \sigma(W_{xo}x_t+W_{ho}h_{t-1}+W_{co}C_t+b_o) & \\
     *      & & \\
     *      & clip(W_{proj}(o_t \odot g(C_t))+b_{proj},\ t_{proj})
     *      & if\ there\ is\ a\ projection; \\
     * h_t =& & \\
     *      & o_t \odot g(C_t) & otherwise. \\
     * \f}
     * Where:
     * * \f$x_t\f$ is the input,
     * * \f$i_t\f$ is the input gate,
     * * \f$f_t\f$ is the forget gate,
     * * \f$C_t\f$ is the cell state,
     * * \f$o_t\f$ is the output,
     * * \f$h_t\f$ is the output state,
     * * \f$\sigma\f$ is the logistic sigmoid function,
     * * \f$g\f$ is the cell input and cell output activation function, usually
     *   \f$tahn\f$,
     * * \f$W_{xi}\f$ is the input-to-input weight matrix,
     * * \f$W_{hi}\f$ is the recurrent to input weight matrix,
     * * \f$W_{ci}\f$ is the cell-to-input weight matrix,
     * * \f$b_i\f$ is the input gate bias,
     * * \f$W_{xf}\f$ is the input-to-forget weight matrix,
     * * \f$W_{hf}\f$ is the recurrent-to-forget weight matrix,
     * * \f$W_{cf}\f$ is the cell-to-forget weight matrix,
     * * \f$b_f\f$ is the forget gate bias,
     * * \f$W_{xc}\f$ is the input-to-cell weight matrix,
     * * \f$W_{hc}\f$ is the recurrent-to-cell weight matrix,
     * * \f$b_c\f$ is the cell bias,
     * * \f$W_{xo}\f$ is the input-to-output weight matrix,
     * * \f$W_{ho}\f$ is the recurrent-to-output weight matrix,
     * * \f$W_{co}\f$ is the cell-to-output weight matrix,
     * * \f$b_o\f$ is the output gate bias,
     * * \f$W_{proj}\f$ is the projection weight matrix,
     * * \f$b_{proj}\f$ is the projection bias,
     * * \f$t_{cell}\f$ is the threshold for clipping the cell state, and
     * * \f$t_{proj}\f$ is the threshold for clipping the projected output.
     * * \f$\odot\f$ is the
     *   <a href="https://en.wikipedia.org/wiki/Hadamard_product_(matrices)">
     *   Hadamard product</a> that takes two matrices and produces another
     *   matrix, each element of which is the product of the corresponding
     *   elements of the input matrices.
     *
     * Since NNAPI feature level 3 LSTM supports layer normalization.
     * In case layer normalization is used, the inputs to internal activation
     * functions (sigmoid and \f$g\f$) are normalized, rescaled and recentered
     * following an approach from section 3.1 from
     * https://arxiv.org/pdf/1607.06450.pdf
     *
     * The operation has the following independently optional inputs:
     * * The cell-to-input weights (\f$W_{ci}\f$), cell-to-forget weights
     *   (\f$W_{cf}\f$) and cell-to-output weights (\f$W_{co}\f$) either all
     *   have values or neither of them have values (i.e., all set to null). If
     *   they have values, the peephole optimization is used.
     * * The input-to-input weights (\f$W_{xi}\f$), recurrent-to-input weights
     *   (\f$W_{hi}\f$) and input gate bias (\f$b_i\f$) either all have values,
     *   or none of them have values. If they have no values, coupling of input
     *   and forget gates (CIFG) is used, in which case the input gate
     *   (\f$i_t\f$) is calculated using the following equation instead.
     *   \f{eqnarray*}{
     *   i_t = 1 - f_t
     *   \f}
     *   In case peephole optimization is used and CIFG is not used
     *   cell-to-input (\f$W_{ci}\f$) weights must be present. Otherwise, the
     *   cell-to-input weights must have no value.
     * * The projection weights (\f$W_{proj}\f$) is required only for the
     *   recurrent projection layer, and should otherwise have no value.
     * * The projection bias (\f$b_{proj}\f$) may (but not required to) have a
     *   value if the recurrent projection layer exists, and should otherwise
     *   have no value.
     * * (NNAPI feature level 3 or later) The four layer normalization weights either all have
     *   values or none of them have values. Additionally, if CIFG is used,
     *   input layer normalization weights tensor is omitted and the other layer
     *   normalization weights either all have values or none of them have
     *   values. Layer normalization is used when the values of all the layer
     *   normalization weights are present.
     *
     * References:
     *
     * The default non-peephole non-CIFG implementation is based on:
     * http://www.bioinf.jku.at/publications/older/2604.pdf
     * S. Hochreiter and J. Schmidhuber. "Long Short-Term Memory". Neural
     * Computation, 9(8):1735-1780, 1997.
     *
     * The peephole implementation and projection layer is based on:
     * https://research.google.com/pubs/archive/43905.pdf
     * Hasim Sak, Andrew Senior, and Francoise Beaufays. "Long short-term memory
     * recurrent neural network architectures for large scale acoustic
     * modeling." INTERSPEECH, 2014.
     * (However, the concept of peephole optimization was introduced in work
     * prior to this paper.)
     *
     * The coupling of input and forget gate (CIFG) is based on:
     * http://arxiv.org/pdf/1503.04069.pdf
     * Greff et al. "LSTM: A Search Space Odyssey"
     *
     * The layer normalization is based on:
     * https://arxiv.org/pdf/1607.06450.pdf
     * Jimmy Ba et al. "Layer Normalization"
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * All input and output tensors must be of the same type.
     *
     * Inputs:
     * * 0: The input (\f$x_t\f$).
     *      A 2-D tensor of shape [batch_size, input_size], where “batch_size”
     *      corresponds to the batching dimension, and “input_size” is the size
     *      of the input.
     * * 1: The input-to-input weights (\f$W_{xi}\f$). Optional.
     *      A 2-D tensor of shape [num_units, input_size], where “num_units”
     *      corresponds to the number of cell units.
     * * 2: The input-to-forget weights (\f$W_{xf}\f$).
     *      A 2-D tensor of shape [num_units, input_size].
     * * 3: The input-to-cell weights (\f$W_{xc}\f$).
     *      A 2-D tensor of shape [num_units, input_size].
     * * 4: The input-to-output weights (\f$W_{xo}\f$).
     *      A 2-D tensor of shape [num_units, input_size].
     * * 5: The recurrent-to-input weights (\f$W_{hi}\f$). Optional.
     *      A 2-D tensor of shape [num_units, output_size], where “output_size”
     *      corresponds to either the number of cell units (i.e., “num_units”),
     *      or the second dimension of the “projection_weights”, if defined.
     * * 6: The recurrent-to-forget weights (\f$W_{hf}\f$).
     *      A 2-D tensor of shape [num_units, output_size].
     * * 7: The recurrent-to-cell weights (\f$W_{hc}\f$).
     *      A 2-D tensor of shape [num_units, output_size].
     * * 8: The recurrent-to-output weights (\f$W_{ho}\f$).
     *      A 2-D tensor of shape [num_units, output_size].
     * * 9: The cell-to-input weights (\f$W_{ci}\f$). Optional.
     *      A 1-D tensor of shape [num_units].
     * * 10:The cell-to-forget weights (\f$W_{cf}\f$). Optional.
     *      A 1-D tensor of shape [num_units].
     * * 11:The cell-to-output weights (\f$W_{co}\f$). Optional.
     *      A 1-D tensor of shape [num_units].
     * * 12:The input gate bias (\f$b_i\f$). Optional.
     *      A 1-D tensor of shape [num_units].
     * * 13:The forget gate bias (\f$b_f\f$).
     *      A 1-D tensor of shape [num_units].
     * * 14:The cell bias (\f$b_c\f$).
     *      A 1-D tensor of shape [num_units].
     * * 15:The output gate bias (\f$b_o\f$).
     *      A 1-D tensor of shape [num_units].
     * * 16:The projection weights (\f$W_{proj}\f$). Optional.
     *      A 2-D tensor of shape [output_size, num_units].
     * * 17:The projection bias (\f$b_{proj}\f$). Optional.
     *      A 1-D tensor of shape [output_size].
     * * 18:The output state (in) (\f$h_{t-1}\f$).
     *      A 2-D tensor of shape [batch_size, output_size].
     * * 19:The cell state (in) (\f$C_{t-1}\f$).
     *      A 2-D tensor of shape [batch_size, num_units].
     * * 20:The activation function (\f$g\f$).
     *      A value indicating the activation function:
     *      <ul>
     *      <li>0: None;
     *      <li>1: Relu;
     *      <li>3: Relu6;
     *      <li>4: Tanh;
     *      <li>6: Sigmoid.
     *      </ul>
     * * 21:The clipping threshold (\f$t_{cell}\f$) for the cell state, such
     *      that values are bound within [-cell_clip, cell_clip]. If set to 0.0
     *      then clipping is disabled.
     *      Until NNAPI feature level 3 this scalar must be of type {@link
     *      ANEURALNETWORKS_FLOAT32}. Since NNAPI feature level 3, if all the input
     *      tensors have type {@link ANEURALNETWORKS_TENSOR_FLOAT32}, this
     *      scalar must be of the type {@link ANEURALNETWORKS_FLOAT32},
     *      otherwise if all the input tensors have the type {@link
     *      ANEURALNETWORKS_TENSOR_FLOAT16}, this scalar must be of type {@link
     *      ANEURALNETWORKS_FLOAT16}.
     * * 22:The clipping threshold (\f$t_{proj}\f$) for the output from the
     *      projection layer, such that values are bound within
     *      [-proj_clip, proj_clip]. If set to 0.0 then clipping is disabled.
     *      Until NNAPI feature level 3 this scalar must be of type {@link
     *      ANEURALNETWORKS_FLOAT32}. Since NNAPI feature level 3, if all the input
     *      tensors have type {@link ANEURALNETWORKS_TENSOR_FLOAT32}, this
     *      scalar must be of the type {@link ANEURALNETWORKS_FLOAT32},
     *      otherwise if all the input tensors have the type {@link
     *      ANEURALNETWORKS_TENSOR_FLOAT16}, this scalar must be of type {@link
     *      ANEURALNETWORKS_FLOAT16}.
     * Since NNAPI feature level 3 there are additional inputs to this op:
     * * 23:The input layer normalization weights.
     *      A 1-D tensor of shape [num_units]. Used to rescale normalized inputs
     *      to activation at input gate.
     * * 24:The forget layer normalization weights.
     *      A 1-D tensor of shape [num_units]. Used to rescale normalized inputs
     *      to activation at forget gate.
     * * 25:The cell layer normalization weights.
     *      A 1-D tensor of shape [num_units]. Used to rescale normalized inputs
     *      to activation at cell gate.
     * * 26:The output layer normalization weights.
     *      A 1-D tensor of shape [num_units]. Used to rescale normalized inputs
     *      to activation at output gate.
     *
     * Outputs:
     * * 0: The scratch buffer.
     *      A 2-D tensor of shape [batch_size, num_units * 3] with CIFG, or
     *      [batch_size, num_units * 4] without CIFG.
     * * 1: The output state (out) (\f$h_t\f$).
     *      A 2-D tensor of shape [batch_size, output_size].
     * * 2: The cell state (out) (\f$C_t\f$).
     *      A 2-D tensor of shape [batch_size, num_units].
     * * 3: The output (\f$o_t\f$).
     *      A 2-D tensor of shape [batch_size, output_size]. This is effectively
     *      the same as the current “output state (out)” value.
     *
     * Available since NNAPI feature level 1.
     */
    LSTM = 16,

    /**
     * Performs an 2-D max pooling operation.
     *
     * The output dimensions are functions of the filter dimensions, stride, and
     * padding.
     *
     * The values in the output tensor are computed as:
     *
     *     output[b, i, j, channel] =
     *         max_{di, dj} (
     *             input[b, strides[1] * i + di, strides[2] * j + dj, channel]
     *         )
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: 4, with "NHWC" or "NCHW" data layout.
     * With the default data layout NHWC, the data is stored in the order of:
     * [batch, height, width, channels]. Alternatively, the data layout could
     * be NCHW, the data storage order of: [batch, channels, height, width].
     * NCHW is supported since NNAPI feature level 3.
     *
     * Both explicit padding and implicit padding are supported.
     *
     * Inputs (explicit padding):
     * * 0: A 4-D tensor, of shape [batches, height, width, depth], specifying
     *      the input.
     *      Since NNAPI feature level 3, zero batches is supported for this tensor.
     * * 1: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the left, in the ‘width’ dimension.
     * * 2: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the right, in the ‘width’ dimension.
     * * 3: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the top, in the ‘height’ dimension.
     * * 4: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the bottom, in the ‘height’ dimension.
     * * 5: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘width’ dimension.
     * * 6: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘height’ dimension.
     * * 7: An {@link ANEURALNETWORKS_INT32} scalar, specifying the filter
     *      width.
     * * 8: An {@link ANEURALNETWORKS_INT32} scalar, specifying the filter
     *      height.
     * * 9: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *      {@link FuseCode} values. Specifies the activation to
     *      invoke on the result.
     * * 10: An optional {@link ANEURALNETWORKS_BOOL} scalar, default to false.
     *       Set to true to specify NCHW data layout for input0 and output0.
     *       Available since NNAPI feature level 3.
     *
     * Inputs (implicit padding):
     * * 0: A 4-D tensor, of shape [batches, height, width, depth], specifying
     *      the input.
     *      Since NNAPI feature level 3, zero batches is supported for this tensor.
     * * 1: An {@link ANEURALNETWORKS_INT32} scalar, specifying the implicit
     *      padding scheme, has to be one of the
     *      {@link PaddingCode} values.
     * * 2: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘width’ dimension.
     * * 3: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘height’ dimension.
     * * 4: An {@link ANEURALNETWORKS_INT32} scalar, specifying the filter
     *      width.
     * * 5: An {@link ANEURALNETWORKS_INT32} scalar, specifying the filter
     *      height.
     * * 6: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *      {@link FuseCode} values. Specifies the activation to
     *      invoke on the result.
     * * 7: An optional {@link ANEURALNETWORKS_BOOL} scalar, default to false.
     *      Set to true to specify NCHW data layout for input0 and output0.
     *      Available since NNAPI feature level 3.
     *
     * Outputs:
     * * 0: The output 4-D tensor, of shape
     *      [batches, out_height, out_width, depth].
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 1.
     */
    MAX_POOL_2D = 17,

    /**
     * Multiplies two tensors, element-wise.
     *
     * Takes two input tensors of identical {@link OperandCode} and compatible
     * dimensions. The output is the product of both input tensors, optionally
     * modified by an activation function.
     *
     * Two dimensions are compatible when:
     *     1. they are equal, or
     *     2. one of them is 1
     *
     * The size of the resulting output is the maximum size along each dimension
     * of the input operands. It starts with the trailing dimensions, and works
     * its way forward.
     *
     * Since NNAPI feature level 3, generic zero-sized input tensor is supported. Zero
     * dimension is only compatible with 0 or 1. The size of the output
     * dimension is zero if either of corresponding input dimension is zero.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     * * {@link ANEURALNETWORKS_TENSOR_INT32} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: A tensor.
     * * 1: A tensor of the same {@link OperandCode}, and compatible dimensions
     *      as input0.
     * * 2: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *      {@link FuseCode} values. Specifies the activation to
     *      invoke on the result.
     *      For a {@link ANEURALNETWORKS_TENSOR_INT32} tensor,
     *      the {@link FuseCode} must be "NONE".
     *
     * Outputs:
     * * 0: The product, a tensor of the same {@link OperandCode} as input0.
     *      For output tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED},
     *      the following condition must be satisfied:
     *      output_scale > input1_scale * input2_scale.
     *
     * Available since NNAPI feature level 1.
     */
    MUL = 18,

    /**
     * Computes rectified linear activation on the input tensor element-wise.
     *
     * The output is calculated using this formula:
     *
     *     output = max(0, input)
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4.
     *
     * Inputs:
     * * 0: A tensor, specifying the input.
     *      Since NNAPI feature level 3, this tensor may be zero-sized.
     *
     * Outputs:
     * * 0: The output tensor of same shape as input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 1.
     */
    RELU = 19,

    /**
     * Computes rectified linear 1 activation on the input tensor element-wise.
     *
     * The output is calculated using this formula:
     *
     *     output = min(1.f, max(-1.f, input))
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4.
     *
     * Inputs:
     * * 0: A tensor, specifying the input.
     *      Since NNAPI feature level 3, this tensor may be zero-sized.
     *
     * Outputs:
     * * 0: The output tensor of the same shape as input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 1.
     */
    RELU1 = 20,

    /**
     * Computes rectified linear 6 activation on the input tensor element-wise.
     *
     * The output is calculated using this formula:
     *
     *     output = min(6, max(0, input))
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4.
     *
     * Inputs:
     * * 0: A tensor, specifying the input.
     *      Since NNAPI feature level 3, this tensor may be zero-sized.
     *
     * Outputs:
     * * 0: The output tensor of same shape as input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 1.
     */
    RELU6 = 21,

    /**
     * Reshapes a tensor.
     *
     * Given tensor, this operation returns a tensor that has the same values as
     * tensor, but with a newly specified shape.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     * * {@link ANEURALNETWORKS_TENSOR_INT32} (since NNAPI feature level 6)
     *
     * Supported tensor rank: up to 4.
     *
     * Inputs:
     * * 0: A tensor, specifying the tensor to be reshaped.
     * * 1: A 1-D tensor of {@link ANEURALNETWORKS_TENSOR_INT32}, defining the
     *      shape of the output tensor. The number of elements implied by shape
     *      must be the same as the number of elements in the input tensor.
     *
     *      If one component of shape is the special value -1, the size of that
     *      dimension is computed so that the total size remains constant. In
     *      particular, a shape of [-1] flattens into 1-D. At most one component
     *      of shape can be -1.
     *
     * Outputs:
     * * 0: The output tensor, of shape specified by the input shape.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 1.
     */
    RESHAPE = 22,

    /**
     * Resizes images to given size using the bilinear interpretation.
     *
     * Resized images must be distorted if their output aspect ratio is not the
     * same as input aspect ratio. The corner pixels of output may not be the
     * same as corner pixels of input.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: 4, with "NHWC" or "NCHW" data layout.
     * With the default data layout NHWC, the data is stored in the order of:
     * [batch, height, width, channels]. Alternatively, the data layout could
     * be NCHW, the data storage order of: [batch, channels, height, width].
     * NCHW is supported since NNAPI feature level 3.
     *
     * Both resizing by shape and resizing by scale are supported.
     *
     * Inputs (resizing by shape):
     * * 0: A 4-D tensor, of shape [batches, height, width, depth], specifying
     *      the input.
     *      Since NNAPI feature level 3, zero batches is supported for this tensor.
     * * 1: An {@link ANEURALNETWORKS_INT32} scalar, specifying the output
     *      width of the output tensor.
     * * 2: An {@link ANEURALNETWORKS_INT32} scalar, specifying the output
     *      height of the output tensor.
     * * 3: An optional {@link ANEURALNETWORKS_BOOL} scalar, default to false.
     *      Set to true to specify NCHW data layout for input0 and output0.
     *      Available since NNAPI feature level 3.
     * * 4: Align corners. An optional {@link ANEURALNETWORKS_BOOL}
     *      scalar, default to false.  If True, the centers of the 4 corner
     *      pixels of the input and output tensors are aligned, preserving the
     *      values at the corner pixels.
     *      Available since NNAPI feature level 4.
     * * 5: Half pixel centers. An optional {@link ANEURALNETWORKS_BOOL}
     *      scalar, default to false. If True, the pixel centers are assumed to
     *      be at (0.5, 0.5). This is the default behavior of image.resize in
     *      TF 2.0. If this parameter is True, then align_corners parameter
     *      must be False.
     *      Available since NNAPI feature level 4.
     *
     * Inputs (resizing by scale, since NNAPI feature level 3):
     * * 0: A 4-D tensor, of shape [batches, height, width, depth], specifying
     *      the input. Zero batches is supported for this tensor.
     * * 1: A scalar, specifying width_scale, the scaling factor of the width
     *      dimension from the input tensor to the output tensor. The output
     *      width is calculated as new_width = floor(width * width_scale).
     *      The scalar must be of {@link ANEURALNETWORKS_FLOAT16} if input0 is
     *      of {@link ANEURALNETWORKS_TENSOR_FLOAT16} and of
     *      {@link ANEURALNETWORKS_FLOAT32} otherwise.
     * * 2: A scalar, specifying height_scale, the scaling factor of the height
     *      dimension from the input tensor to the output tensor. The output
     *      height is calculated as new_height = floor(height * height_scale).
     *      The scalar must be of {@link ANEURALNETWORKS_FLOAT16} if input0 is
     *      of {@link ANEURALNETWORKS_TENSOR_FLOAT16} and of
     *      {@link ANEURALNETWORKS_FLOAT32} otherwise.
     * * 3: An optional {@link ANEURALNETWORKS_BOOL} scalar, default to false.
     *      Set to true to specify NCHW data layout for input0 and output0.
     * * 4: Align corners. An optional {@link ANEURALNETWORKS_BOOL}
     *      scalar, default to false.  If True, the centers of the 4 corner
     *      pixels of the input and output tensors are aligned, preserving the
     *      values at the corner pixels.
     *      Available since NNAPI feature level 4.
     * * 5: Half pixel centers. An optional {@link ANEURALNETWORKS_BOOL}
     *      scalar, default to false. If True, the pixel centers are assumed to
     *      be at (0.5, 0.5). This is the default behavior of image.resize in
     *      TF 2.0. If this parameter is True, then align_corners parameter
     *      must be False.
     *      Available since NNAPI feature level 4.
     *
     * Outputs:
     * * 0: The output 4-D tensor, of shape
     *      [batches, new_height, new_width, depth].
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 1.
     */
    RESIZE_BILINEAR = 23,

    /**
     * A basic recurrent neural network layer.
     *
     * This layer implements the operation:
     * outputs = state = activation(inputs * input_weights +
     *                              state * recurrent_weights + bias)
     *
     * Where:
     * * “input_weights” is a weight matrix that multiplies the inputs;
     * * “recurrent_weights” is a weight matrix that multiplies the current
     *    “state” which itself is the output from the previous time step
     *    computation;
     * * “bias” is a bias vector (added to each output vector in the batch);
     * * “activation” is the function passed as the “fused_activation_function”
     *   argument (if not “NONE”).
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * The input tensors must all be the same type.
     *
     * Inputs:
     * * 0: input.
     *      A 2-D tensor of shape [batch_size, input_size], where “batch_size”
     *      corresponds to the batching dimension, and “input_size” is the size
     *      of the input.
     * * 1: weights.
     *      A 2-D tensor of shape [num_units, input_size], where “num_units”
     *      corresponds to the number of units.
     * * 2: recurrent_weights.
     *      A 2-D tensor of shape [num_units, num_units], with columns
     *      corresponding to the weights from each unit.
     * * 3: bias.
     *      A 1-D tensor of shape [num_units].
     * * 4: hidden state (in).
     *      A 2-D tensor of shape [batch_size, num_units].
     * * 5: fused_activation_function.
     *      An optional {@link FuseCode} value indicating the
     *      activation function. If “NONE” is specified then it results in a
     *      linear activation.
     *
     * Outputs:
     * * 0: hidden state (out).
     *      A 2-D tensor of shape [batch_size, num_units].
     *
     * * 1: output.
     *      A 2-D tensor of shape [batch_size, num_units]. This is effectively
     *      the same as the current state value.
     *
     * Available since NNAPI feature level 1.
     */
    RNN = 24,

    /**
     * Computes the softmax activation on the input tensor element-wise, per
     * batch, by normalizing the input vector so the maximum coefficient is
     * zero.
     *
     * The output is calculated using this formula:
     *
     *     output[batch, i] =
     *         exp((input[batch, i] - max(input[batch, :])) * beta) /
     *         sum_{k}{exp((input[batch, k] - max(input[batch, :])) * beta)}
     *
     * For input tensor with rank other than 2, the activation will be applied
     * independently on each 1-D slice along specified dimension.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4.
     * Tensors with rank other than 2 or 4 are only supported since NNAPI feature level 3.
     *
     * Inputs:
     * * 0: A 2-D or 4-D tensor, specifying the tensor to be reshaped.
     *      Since NNAPI feature level 3, this tensor may be zero-sized.
     * * 1: A scalar, specifying the positive scaling factor for the exponent,
     *      beta. If input0 is of {@link ANEURALNETWORKS_TENSOR_FLOAT32},
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} or
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}, the scalar
     *      must be of {@link ANEURALNETWORKS_FLOAT32}.
     *      If input0 is of {@link ANEURALNETWORKS_TENSOR_FLOAT16}, then the
     *      scalar must be of {@link ANEURALNETWORKS_FLOAT16}.
     * * 2: An optional {@link ANEURALNETWORKS_INT32} scalar, default to -1,
     *      specifying the dimension the activation would be performed on.
     *      Negative index is used to specify axis from the end (e.g. -1 for
     *      the last axis). Must be in the range [-n, n).
     *      Available since NNAPI feature level 3.
     *
     * Outputs:
     * * 0: The output tensor of same shape as input0.
     *      For {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM},
     *      the scale must be 1.f / 256 and the zeroPoint must be 0.
     *      For {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED},
     *      the scale must be 1.f / 256 and the zeroPoint must be -128.
     *
     * Available since NNAPI feature level 1.
     */
    SOFTMAX = 25,

    /**
     * Rearranges blocks of spatial data, into depth.
     *
     * More specifically, this op outputs a copy of the input tensor where
     * values from the height and width dimensions are moved to the depth
     * dimension. The value block_size indicates the input block size and how
     * the data is moved.
     *
     * Chunks of data of size block_size * block_size from depth are rearranged
     * into non-overlapping blocks of size block_size x block_size.
     *
     * The depth of the output tensor is input_depth * block_size * block_size.
     * The input tensor's height and width must be divisible by block_size.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: 4, with "NHWC" or "NCHW" data layout.
     * With the default data layout NHWC, the data is stored in the order of:
     * [batch, height, width, channels]. Alternatively, the data layout could
     * be NCHW, the data storage order of: [batch, channels, height, width].
     * NCHW is supported since NNAPI feature level 3.
     *
     * Inputs:
     * * 0: A 4-D tensor, of shape [batches, height, width, depth_in],
     *      specifying the input.
     * * 1: An {@link ANEURALNETWORKS_INT32} scalar, specifying the block_size.
     *      block_size must be >=1 and block_size must be a divisor of both the
     *      input height and width.
     * * 2: An optional {@link ANEURALNETWORKS_BOOL} scalar, default to false.
     *      Set to true to specify NCHW data layout for input0 and output0.
     *      Available since NNAPI feature level 3.
     *
     * Outputs:
     * * 0: The output 4-D tensor, of shape [batches, height/block_size,
     *      width/block_size, depth_in*block_size*block_size].
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 1.
     */
    SPACE_TO_DEPTH = 26,

    /**
     * SVDF op is a kind of stateful layer derived from the notion that a
     * densely connected layer that's processing a sequence of input frames can
     * be approximated by using a singular value decomposition of each of its
     * nodes. The implementation is based on:
     *
     * https://research.google.com/pubs/archive/43813.pdf
     *
     * P. Nakkiran, R. Alvarez, R. Prabhavalkar, C. Parada.
     * “Compressing Deep Neural Networks using a Rank-Constrained Topology”.
     * INTERSPEECH, 2015.
     *
     * It processes the incoming input using a 2-stage filtering mechanism:
     * * stage 1 performs filtering on the "features" dimension, whose outputs
     *   get pushed into a memory of fixed-size memory_size.
     * * stage 2 performs filtering on the "time" dimension of the memory_size
     *   memoized outputs of stage 1.
     *
     * Specifically, for rank 1, this layer implements the operation:
     *
     *     memory = push(conv1d(inputs, weights_feature, feature_dim,
     *                          "ANEURALNETWORKS_PADDING_VALID"));
     *     outputs = activation(memory * weights_time + bias);
     *
     * Where:
     * * “weights_feature” is a weights matrix that processes the inputs (by
     *   convolving the input with every “feature filter”), and whose outputs
     *   get pushed, stacked in order, into the fixed-size “memory” (the oldest
     *   entry gets dropped);
     * * “weights_time” is a weights matrix that processes the “memory” (by a
     *   batched matrix multiplication on the num_units);
     * * “bias” is an optional bias vector (added to each output vector in the
     *   batch); and
     * * “activation” is the function passed as the “fused_activation_function”
     *   argument (if not “NONE”).
     *
     * Each rank adds a dimension to the weights matrices by means of stacking
     * the filters.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * All input tensors must be the same type.
     *
     * Inputs:
     * * 0: input.
     *      A 2-D tensor of shape [batch_size, input_size], where “batch_size”
     *      corresponds to the batching dimension, and “input_size” is the size
     *      of the input.
     * * 1: weights_feature.
     *      A 2-D tensor of shape [num_units, input_size], where “num_units”
     *      corresponds to the number of units.
     * * 2: weights_time.
     *      A 2-D tensor of shape [num_units, memory_size], where “memory_size”
     *      corresponds to the fixed-size of the memory.
     * * 3: bias.
     *      An optional 1-D tensor of shape [num_units].
     * * 4: state (in).
     *      A 2-D tensor of shape [batch_size, (memory_size - 1) * num_units * rank].
     * * 5: rank.
     *      The rank of the SVD approximation.
     * * 6: fused_activation_function.
     *      An optional {@link FuseCode} value indicating the
     *      activation function. If “NONE” is specified then it results in a
     *      linear activation.
     *
     * Outputs:
     * * 0: state (out).
     *      A 2-D tensor of the same {@link OperandCode} as the inputs, with shape
     *      [batch_size, (memory_size - 1) * num_units * rank].
     * * 1: output.
     *      A 2-D tensor of the same {@link OperandCode} as the inputs, with shape
     *      [batch_size, num_units].
     *
     * Available since NNAPI feature level 1.
     */
    SVDF = 27,

    /**
     * Computes hyperbolic tangent of input tensor element-wise.
     *
     * The output is calculated using this formula:
     *
     *     output = tanh(input)
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4.
     *
     * Inputs:
     * * 0: A tensor, specifying the input.
     *      Since NNAPI feature level 3, this tensor may be zero-sized.
     *
     * Outputs:
     * * 0: The output tensor of same shape as input0.
     *      For {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM},
     *      the scale must be 1.f / 128 and the zeroPoint must be 128.
     *      For {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED},
     *      the scale must be 1.f / 128 and the zeroPoint must be 0.
     *
     * Available since NNAPI feature level 1.
     */
    TANH = 28,

    // Operations below are available since NNAPI feature level 2.

    /**
     * BatchToSpace for N-dimensional tensors.
     *
     * This operation reshapes the batch dimension (dimension 0) into M + 1
     * dimensions of shape block_shape + [batch], interleaves these blocks back
     * into the grid defined by the spatial dimensions [1, ..., M], to obtain a
     * result with the same rank as the input.
     *
     * This is the reverse of SpaceToBatch.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: 4, with "NHWC" or "NCHW" data layout.
     * With the default data layout NHWC, the data is stored in the order of:
     * [batch, height, width, channels]. Alternatively, the data layout could
     * be NCHW, the data storage order of: [batch, channels, height, width].
     * NCHW is supported since NNAPI feature level 3.
     *
     * Inputs:
     * * 0: An n-D tensor, specifying the tensor to be reshaped
     * * 1: A 1-D Tensor of {@link ANEURALNETWORKS_TENSOR_INT32}, the block
     *      sizes for each spatial dimension of the input tensor. All values
     *      must be >= 1.
     * * 2: An optional {@link ANEURALNETWORKS_BOOL} scalar, default to false.
     *      Set to true to specify NCHW data layout for input0 and output0.
     *      Available since API level 29.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 2.
     */
    BATCH_TO_SPACE_ND = 29,

    /**
     * Element-wise division of two tensors.
     *
     * Takes two input tensors of identical {@link OperandCode} and compatible
     * dimensions. The output is the result of dividing the first input tensor
     * by the second, optionally modified by an activation function.
     *
     * For inputs of {@link ANEURALNETWORKS_TENSOR_INT32}, performs
     * "floor division" ("//" in Python). For example,
     *     5 // 2 = 2
     *    -5 // 2 = -3
     *
     * Two dimensions are compatible when:
     *     1. they are equal, or
     *     2. one of them is 1
     *
     * The size of the output is the maximum size along each dimension of the
     * input operands. It starts with the trailing dimensions, and works its way
     * forward.
     *
     * Example:
     *     input1.dimension =    {4, 1, 2}
     *     input2.dimension = {5, 4, 3, 1}
     *     output.dimension = {5, 4, 3, 2}
     *
     * Since NNAPI feature level 3, generic zero-sized input tensor is supported. Zero
     * dimension is only compatible with 0 or 1. The size of the output
     * dimension is zero if either of corresponding input dimension is zero.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: An n-D tensor, specifying the first input.
     * * 1: A tensor of the same {@link OperandCode}, and compatible dimensions
     *      as input0.
     * * 2: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *      {@link FuseCode} values. Specifies the activation to
     *      invoke on the result.
     *      For a {@link ANEURALNETWORKS_TENSOR_INT32} tensor,
     *      the {@link FuseCode} must be "NONE".
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0.
     *
     * Available since NNAPI feature level 2.
     */
    DIV = 30,

    /**
     * Computes the mean of elements across dimensions of a tensor.
     *
     * Reduces the input tensor along the given dimensions to reduce. Unless
     * keep_dims is true, the rank of the tensor is reduced by 1 for each entry
     * in axis. If keep_dims is true, the reduced dimensions are retained with
     * length 1.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: A tensor, specifying the input.
     * * 1: A 1-D Tensor of {@link ANEURALNETWORKS_TENSOR_INT32}. The dimensions
     *      to reduce. Must be in the range
     *      [-rank(input_tensor), rank(input_tensor)).
     *
     *      NOTE: When the operation was introduced, the documentation
     *      incorrectly stated that if dimensions were empty, the operation
     *      would reduce across all dimensions. This behavior was never
     *      implemented.
     *
     * * 2: An {@link ANEURALNETWORKS_INT32} scalar, keep_dims. If positive,
     *      retains reduced dimensions with length 1.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *      If all dimensions are reduced and keep_dims is false, the output
     *      shape is [1].
     *
     * Available since NNAPI feature level 2.
     */
    MEAN = 31,

    /**
     * Pads a tensor.
     *
     * This operation pads a tensor according to the specified paddings.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *   (full support since NNAPI feature level 3, see the output section)
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: An n-D tensor, specifying the tensor to be padded.
     * * 1: A 2-D Tensor of {@link ANEURALNETWORKS_TENSOR_INT32}, the paddings
     *      for each spatial dimension of the input tensor. The shape of the
     *      tensor must be {rank(input0), 2}.
     *      padding[i, 0] specifies the number of elements to be padded in the
     *      front of dimension i.
     *      padding[i, 1] specifies the number of elements to be padded after the
     *      end of dimension i.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0. The
     *      output tensor has the same rank as input0, and each
     *      dimension of the output tensor has the same size as the
     *      corresponding dimension of the input tensor plus the size
     *      of the padding:
     *          output0.dimension[i] =
     *              padding[i, 0] + input0.dimension[i] + padding[i, 1]
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     *      NOTE: Before NNAPI feature level 3, the pad value for
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} is undefined.
     *      Since NNAPI feature level 3, the pad value is always the logical zero.
     *
     * Available since NNAPI feature level 2.
     */
    PAD = 32,

    /**
     * SpaceToBatch for N-Dimensional tensors.
     *
     * This operation divides "spatial" dimensions [1, ..., M] of the input into
     * a grid of blocks of shape block_shape, and interleaves these blocks with
     * the "batch" dimension (0) such that in the output, the spatial dimensions
     * [1, ..., M] correspond to the position within the grid, and the batch
     * dimension combines both the position within a spatial block and the
     * original batch position. Prior to division into blocks, the spatial
     * dimensions of the input are optionally zero padded according to paddings.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *   (full support since NNAPI feature level 3, see the output section)
     *
     * Supported tensor rank: 4, with "NHWC" or "NCHW" data layout.
     * With the default data layout NHWC, the data is stored in the order of:
     * [batch, height, width, channels]. Alternatively, the data layout could
     * be NCHW, the data storage order of: [batch, channels, height, width].
     * NCHW is supported since NNAPI feature level 3.
     *
     * Inputs:
     * * 0: An n-D tensor, specifying the input.
     * * 1: A 1-D Tensor of {@link ANEURALNETWORKS_TENSOR_INT32}, the block
     *      sizes for each spatial dimension of the input tensor. All values
     *      must be >= 1.
     * * 2: A 2-D Tensor of {@link ANEURALNETWORKS_TENSOR_INT32}, the paddings
     *      for each spatial dimension of the input tensor. All values must be
     *      >= 0. The shape of the tensor must be {M, 2}, where M is the number
     *      of spatial dimensions.
     *      padding[i, 0] specifies the number of element to be padded in the
     *      front of dimension i.
     *      padding[i, 1] specifies the number of element to be padded after the
     *      end of dimension i.
     * * 3: An optional {@link ANEURALNETWORKS_BOOL} scalar, default to false.
     *      Set to true to specify NCHW data layout for input0 and output0.
     *      Available since NNAPI feature level 3.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     *      NOTE: Before NNAPI feature level 3, the pad value for
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} is undefined.
     *      Since NNAPI feature level 3, the pad value is always the logical zero.
     *
     * Available since NNAPI feature level 2.
     */
    SPACE_TO_BATCH_ND = 33,

    /**
     * Removes dimensions of size 1 from the shape of a tensor.
     *
     * Given a tensor input, this operation returns a tensor of the same
     * {@link OperandCode} with all dimensions of size 1 removed. If you don't
     * want to remove all size 1 dimensions, you can remove specific size 1
     * dimensions by specifying the axes (input1).
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: An n-D tensor, the tensor to be squeezed.
     * * 1: An optional 1-D tensor of {@link ANEURALNETWORKS_TENSOR_INT32}. The
     *      dimensions to squeeze. If specified only squeezes the dimensions
     *      listed. Otherwise, squeezes all dimensions. The dimension index
     *      starts at 0. An error must be reported if squeezing a dimension that
     *      is not 1.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0. Contains the
     *      same data as input, but has one or more dimensions of size 1
     *      removed.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *      If all input dimensions are equal to 1 and are to be squeezed, the
     *      output shape is [1].
     *
     * Available since NNAPI feature level 2.
     */
    SQUEEZE = 34,

    /**
     * Extracts a strided slice of a tensor.
     *
     * Roughly speaking, this op extracts a slice of size (end - begin) / stride
     * from the given input tensor. Starting at the location specified by begin
     * the slice continues by adding stride to the index until all dimensions
     * are not less than end. Note that a stride can be negative, which causes a
     * reverse slice.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: An n-D tensor, specifying the tensor to be sliced.
     * * 1: begin, a 1-D tensor of {@link ANEURALNETWORKS_TENSOR_INT32}. The
     *      starts of the dimensions of the input tensor to be sliced. The
     *      length must be of rank(input0).
     * * 2: end, a 1-D tensor of {@link ANEURALNETWORKS_TENSOR_INT32}. The
     *      ends of the dimensions of the input tensor to be sliced. The length
     *      must be of rank(input0).
     * * 3: strides, a 1-D tensor of {@link ANEURALNETWORKS_TENSOR_INT32}. The
     *      strides of the dimensions of the input tensor to be sliced. The
     *      length must be of rank(input0). The entries must be non-zero.
     * * 4: begin_mask, an {@link ANEURALNETWORKS_INT32} scalar. If the ith bit
     *      of begin_mask is set, begin[i] is ignored and the fullest possible
     *      range in that dimension is used instead.
     * * 5: end_mask, an {@link ANEURALNETWORKS_INT32} scalar. If the ith bit of
     *      end_mask is set, end[i] is ignored and the fullest possible range in
     *      that dimension is used instead.
     * * 6: shrink_axis_mask, an {@link ANEURALNETWORKS_INT32} scalar. If the
     *      ith bit of shrink_axis_mask is set, the ith dimension specification
     *      shrinks the dimensionality by 1, taking on the value at index
     *      begin[i]. In this case, the ith specification must define a
     *      slice of size 1, e.g. begin[i] = x, end[i] = x + 1.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0 and rank (n - k),
     *      where k is the number of bits set in shrink_axis_mask.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *      If shrink_axis_mask is true for all input dimensions, the output
     *      shape is [1].
     *
     * Available since NNAPI feature level 2.
     */
    STRIDED_SLICE = 35,

    /**
     * Element-wise subtraction of two tensors.
     *
     * Takes two input tensors of identical {@link OperandCode} and compatible
     * dimensions. The output is the result of subtracting the second input
     * tensor from the first one, optionally modified by an activation function.
     *
     * Two dimensions are compatible when:
     *     1. they are equal, or
     *     2. one of them is 1
     *
     * The size of the output is the maximum size along each dimension of the
     * input operands. It starts with the trailing dimensions, and works its way
     * forward.
     *
     * Example:
     *     input1.dimension =    {4, 1, 2}
     *     input2.dimension = {5, 4, 3, 1}
     *     output.dimension = {5, 4, 3, 2}
     *
     * Since NNAPI feature level 3, generic zero-sized input tensor is supported. Zero
     * dimension is only compatible with 0 or 1. The size of the output
     * dimension is zero if either of corresponding input dimension is zero.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     * * {@link ANEURALNETWORKS_TENSOR_INT32} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: An n-D tensor, specifying the first input.
     * * 1: A tensor of the same {@link OperandCode}, and compatible dimensions
     *      as input0.
     * * 2: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *      {@link FuseCode} values. Specifies the activation to
     *      invoke on the result.
     *      For a {@link ANEURALNETWORKS_TENSOR_INT32} tensor,
     *      the {@link FuseCode} must be "NONE".
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint can be different from inputs' scale and zeroPoint.
     *
     * Available since NNAPI feature level 2.
     */
    SUB = 36,

    /**
     * Transposes the input tensor, permuting the dimensions according to the
     * perm tensor.
     *
     * The returned tensor's dimension i corresponds to the input dimension
     * perm[i]. If perm is not given, it is set to (n-1...0), where n is the
     * rank of the input tensor. Hence by default, this operation performs a
     * regular matrix transpose on 2-D input Tensors.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} (since NNAPI feature level 3)
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: An n-D tensor, specifying the tensor to be transposed.
     *      Since NNAPI feature level 3, this tensor may be zero-sized.
     * * 1: An optional 1-D Tensor of {@link ANEURALNETWORKS_TENSOR_INT32},
     *      the permutation of the dimensions of the input tensor.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 2.
     */
    TRANSPOSE = 37,

    // Operations below are available since NNAPI feature level 3.

    /**
     * Computes the absolute value of a tensor, element-wise.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1.
     *
     * Inputs:
     * * 0: A tensor.
     *
     * Outputs:
     * * 0: The output tensor of same shape as input0.
     *
     * Available since NNAPI feature level 3.
     */
    ABS = 38,

    /**
     * Returns the index of the largest element along an axis.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1
     *
     * Inputs:
     * * 0: An n-D tensor specifying the input. Must be non-empty.
     * * 1: An {@link ANEURALNETWORKS_INT32} scalar specifying the axis to
     *      reduce across. Negative index is used to specify axis from the
     *      end (e.g. -1 for the last axis). Must be in the range [-n, n).
     *
     * Outputs:
     * * 0: An (n - 1)-D {@link ANEURALNETWORKS_TENSOR_INT32} tensor.
     *      If input is 1-dimensional, the output shape is [1].
     *
     * Available since NNAPI feature level 3.
     */
    // There is no underscore in ARG_MAX to avoid name conflict with
    // the macro defined in libc/kernel/uapi/linux/limits.h.
    ARGMAX = 39,

    /**
     * Returns the index of the smallest element along an axis.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1
     *
     * Inputs:
     * * 0: An n-D tensor specifying the input. Must be non-empty.
     * * 1: An {@link ANEURALNETWORKS_INT32} scalar specifying the axis to
     *      reduce across. Negative index is used to specify axis from the
     *      end (e.g. -1 for the last axis). Must be in the range [-n, n).
     *
     * Outputs:
     * * 0: An (n - 1)-D {@link ANEURALNETWORKS_TENSOR_INT32} tensor.
     *      If input is 1-dimensional, the output shape is [1].
     *
     * Available since NNAPI feature level 3.
     */
    ARGMIN = 40,  // See ARGMAX for naming discussion.

    /**
     * Transform axis-aligned bounding box proposals using bounding box deltas.
     *
     * Given the positions of bounding box proposals and the corresponding
     * bounding box deltas for each class, return the refined bounding box
     * regions. The resulting bounding boxes are cliped against the edges of
     * the image.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT16_ASYMM}
     *
     * Inputs:
     * * 0: A 2-D Tensor of shape [num_rois, 4], specifying the locations of the
     *      bounding box proposals, each line with format [x1, y1, x2, y2].
     *      For tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT16_ASYMM},
     *      the zeroPoint must be 0 and the scale must be 0.125. Zero num_rois
     *      is supported for this tensor.
     * * 1: A 2-D Tensor of shape [num_rois, num_classes * 4], specifying the
     *      bounding box delta for each region of interest and each class. The
     *      bounding box deltas are organized in the following order
     *      [dx, dy, dw, dh], where dx and dy is the relative correction factor
     *      for the center position of the bounding box with respect to the width
     *      and height, dw and dh is the log-scale relative correction factor
     *      for the width and height. For input0 of type
     *      {@link ANEURALNETWORKS_TENSOR_QUANT16_ASYMM}, this tensor should be
     *      of {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} or
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}. Zero num_rois is
     *      supported for this tensor.
     * * 2: An 1-D {@link ANEURALNETWORKS_TENSOR_INT32} tensor, of shape
     *      [num_rois], specifying the batch index of each box. Boxes with
     *      the same batch index are grouped together. Zero num_rois is
     *      supported for this tensor.
     * * 3: A 2-D Tensor of shape [batches, 2], specifying the information of
     *      each image in the batch, each line with format
     *      [image_height, image_width].
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0, with shape
     *      [num_rois, num_classes * 4], specifying the coordinates of each
     *      output bounding box for each class, with format [x1, y1, x2, y2].
     *      For type of {@link ANEURALNETWORKS_TENSOR_QUANT16_ASYMM}, the
     *      scale must be 0.125 and the zero point must be 0.
     *
     * Available since NNAPI feature level 3.
     */
    AXIS_ALIGNED_BBOX_TRANSFORM = 41,

    /**
     * A recurrent neural network layer that applies an LSTM cell to a
     * sequence of inputs in forward and backward directions.
     *
     * The op supports cross-linking via an auxiliary input. Regular cell feeds
     * one input into the two RNN cells in the following way:
     *
     *       INPUT  (INPUT_REVERSED)
     *         |         |
     *    ---------------------
     *    | FW_LSTM   BW_LSTM |
     *    ---------------------
     *         |         |
     *      FW_OUT     BW_OUT
     *
     * An op with cross-linking takes two inputs and feeds them into the RNN
     * cells in the following way:
     *
     *       AUX_INPUT   (AUX_INPUT_REVERSED)
     *           |             |
     *     INPUT | (INPUT_R'D.)|
     *       |   |       |     |
     *    -----------------------
     *    |  \  /        \    / |
     *    | FW_LSTM     BW_LSTM |
     *    -----------------------
     *         |           |
     *      FW_OUT      BW_OUT
     *
     * The cross-linking mode is enabled iff auxiliary input and auxiliary
     * weights are present. While stacking this op on top of itself, this
     * allows to connect both forward and backward outputs from previous cell
     * to the next cell's input.
     *
     * Since NNAPI feature level 4 parallel linking mode is supported. The mode is
     * enabled if auxiliary input is present but auxiliary weights are omitted.
     * In this case, the cell feeds inputs into the RNN in the following way:
     *
     *       INPUT (AUX_INPUT_REVERSED)
     *         |         |
     *    ---------------------
     *    | FW_LSTM   BW_LSTM |
     *    ---------------------
     *         |         |
     *      FW_OUT     BW_OUT
     *
     * While stacking this op on top of itself, this allows to connect both
     * forward and backward outputs from previous cell to the next cell's
     * corresponding inputs.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * Supported tensor rank: 3, either time-major or batch-major.
     *
     * All input and output tensors must be of the same type.
     *
     * Inputs:
     * * 0: The input.
     *      A 3-D tensor of shape:
     *        If time-major: [max_time, batch_size, input_size]
     *        If batch-major: [batch_size, max_time, input_size]
     *      where "max_time" is the number of timesteps (sequence length),
     *      "batch_size" corresponds to the batching dimension, and
     *      "input_size" is the size of the input.
     * * 1: The forward input-to-input weights. Optional.
     *      A 2-D tensor of shape [fw_num_units, input_size], where “fw_num_units”
     *      corresponds to the number of forward cell units.
     * * 2: The forward input-to-forget weights.
     *      A 2-D tensor of shape [fw_num_units, input_size].
     * * 3: The forward input-to-cell weights.
     *      A 2-D tensor of shape [fw_num_units, input_size].
     * * 4: The forward input-to-output weights.
     *      A 2-D tensor of shape [fw_num_units, input_size].
     * * 5: The forward recurrent-to-input weights. Optional.
     *      A 2-D tensor of shape [fw_num_units, fw_output_size], where “fw_output_size”
     *      corresponds to either the number of cell units (i.e., fw_num_units),
     *      or the second dimension of the “fw_projection_weights”, if defined.
     * * 6: The forward recurrent-to-forget weights.
     *      A 2-D tensor of shape [fw_num_units, fw_output_size].
     * * 7: The forward recurrent-to-cell weights.
     *      A 2-D tensor of shape [fw_num_units, fw_output_size].
     * * 8: The forward recurrent-to-output weights.
     *      A 2-D tensor of shape [fw_num_units, fw_output_size].
     * * 9: The forward cell-to-input weights. Optional.
     *      A 1-D tensor of shape [fw_num_units].
     * * 10: The forward cell-to-forget weights. Optional.
     *       A 1-D tensor of shape [fw_num_units].
     * * 11: The forward cell-to-output weights. Optional.
     *       A 1-D tensor of shape [fw_num_units].
     * * 12: The forward input gate bias. Optional.
     *       A 1-D tensor of shape [fw_num_units].
     * * 13: The forward forget gate bias.
     *       A 1-D tensor of shape [fw_num_units].
     * * 14: The forward cell gate bias.
     *       A 1-D tensor of shape [fw_num_units].
     * * 15: The forward output gate bias.
     *       A 1-D tensor of shape [fw_num_units].
     * * 16: The forward projection weights. Optional.
     *       A 2-D tensor of shape [fw_output_size, fw_num_units].
     * * 17: The forward projection bias. Optional.
     *       A 1-D tensor of shape [fw_output_size].
     * * 18: The backward input-to-input weights. Optional.
     *       A 2-D tensor of shape [bw_num_units, input_size], where “bw_num_units”
     *       corresponds to the number of backward cell units.
     * * 19: The backward input-to-forget weights.
     *       A 2-D tensor of shape [bw_num_units, input_size].
     * * 20: The backward input-to-cell weights.
     *       A 2-D tensor of shape [bw_num_units, input_size].
     * * 21: The backward input-to-output weights.
     *       A 2-D tensor of shape [bw_num_units, input_size].
     * * 22: The backward recurrent-to-input weights. Optional.
     *       A 2-D tensor of shape [bw_num_units, bw_output_size], where “bw_output_size”
     *       corresponds to either the number of cell units (i.e., “bw_num_units”),
     *       or the second dimension of the “bw_projection_weights”, if defined.
     * * 23: The backward recurrent-to-forget weights.
     *       A 2-D tensor of shape [bw_num_units, bw_output_size].
     * * 24: The backward recurrent-to-cell weights.
     *       A 2-D tensor of shape [bw_num_units, bw_output_size].
     * * 25: The backward recurrent-to-output weights.
     *       A 2-D tensor of shape [bw_num_units, bw_output_size].
     * * 26: The backward cell-to-input weights. Optional.
     *       A 1-D tensor of shape [bw_num_units].
     * * 27: The backward cell-to-forget weights. Optional.
     *       A 1-D tensor of shape [bw_num_units].
     * * 28: The backward cell-to-output weights. Optional.
     *       A 1-D tensor of shape [bw_num_units].
     * * 29: The backward input gate bias. Optional.
     *       A 1-D tensor of shape [bw_num_units].
     * * 30: The backward forget gate bias.
     *       A 1-D tensor of shape [bw_num_units].
     * * 31: The backward cell gate bias.
     *       A 1-D tensor of shape [bw_num_units].
     * * 32: The backward output gate bias.
     *       A 1-D tensor of shape [bw_num_units].
     * * 33: The backward projection weights. Optional.
     *       A 2-D tensor of shape [bw_output_size, bw_num_units].
     * * 34: The backward projection bias. Optional.
     *       A 1-D tensor of shape [bw_output_size].
     * * 35: The forward input activation state.
     *       A 2-D tensor of shape [batch_size, bw_output_size].
     * * 36: The forward input cell state.
     *       A 2-D tensor of shape [batch_size, bw_num_units].
     * * 37: The backward input activation state.
     *       A 2-D tensor of shape [batch_size, bw_output_size].
     * * 38: The backward input cell state.
     *       A 2-D tensor of shape [batch_size, bw_num_units].
     * * 39: The auxiliary input. Optional.
     *       A 3-D tensor of shape [max_time, batch_size, aux_input_size],
     *       where “batch_size” corresponds to the batching dimension, and
     *       “aux_input_size” is the size of the auxiliary input. Optional. See
     *       the docs above for the usage modes explanation.
     * * 40: The forward auxiliary input-to-input weights.
     *       Optional. See the docs above for the usage modes explanation.
     *       A 2-D tensor of shape [fw_num_units, aux_input_size].
     * * 41: The forward auxiliary input-to-forget weights.
     *       Optional. See the docs above for the usage modes explanation.
     *       A 2-D tensor of shape [fw_num_units, aux_input_size].
     * * 42: The forward auxiliary input-to-cell weights.
     *       Optional. See the docs above for the usage modes explanation.
     *       A 2-D tensor of shape [fw_num_units, aux_input_size].
     * * 43: The forward auxiliary input-to-output weights.
     *       Optional. See the docs above for the usage modes explanation.
     *       A 2-D tensor of shape [fw_num_units, aux_input_size].
     * * 44: The backward auxiliary input-to-input weights.
     *       Optional. See the docs above for the usage modes explanation.
     *       A 2-D tensor of shape [bw_num_units, aux_input_size].
     * * 45: The backward auxiliary input-to-forget weights.
     *       Optional. See the docs above for the usage modes explanation.
     *       A 2-D tensor of shape [bw_num_units, aux_input_size].
     * * 46: The backward auxiliary input-to-cell weights.
     *       Optional. See the docs above for the usage modes explanation.
     *       A 2-D tensor of shape [bw_num_units, aux_input_size].
     * * 47: The backward auxiliary input-to-output weights.
     *       Optional. See the docs above for the usage modes explanation.
     *       A 2-D tensor of shape [bw_num_units, aux_input_size].
     * * 48: The activation function.
     *       A value indicating the activation function:
     *       <ul>
     *       <li>0: None;
     *       <li>1: Relu;
     *       <li>3: Relu6;
     *       <li>4: Tanh;
     *       <li>6: Sigmoid.
     *       </ul>
     * * 49: The clipping threshold for the cell state, such
     *       that values are bound within [-cell_clip, cell_clip]. If set to 0.0
     *       then clipping is disabled.
     *       If all the input tensors have type {@link ANEURALNETWORKS_TENSOR_FLOAT32},
     *       this scalar must be of the type {@link ANEURALNETWORKS_FLOAT32},
     *       otherwise if all the input tensors have the type
     *       {@link ANEURALNETWORKS_TENSOR_FLOAT16}, this scalar must be
     *       of type {@link ANEURALNETWORKS_FLOAT16}.
     * * 50: The clipping threshold for the output from the
     *       projection layer, such that values are bound within
     *       [-proj_clip, proj_clip]. If set to 0.0 then clipping is disabled.
     *       If all the input tensors have type {@link ANEURALNETWORKS_TENSOR_FLOAT32},
     *       this scalar must be of the type {@link ANEURALNETWORKS_FLOAT32},
     *       otherwise if all the input tensors have the type
     *       {@link ANEURALNETWORKS_TENSOR_FLOAT16}, this scalar must be
     *       of type {@link ANEURALNETWORKS_FLOAT16}.
     * * 51: merge_outputs
     *       An {@link ANEURALNETWORKS_BOOL} scalar specifying if the outputs
     *       from forward and backward cells should be merged.
     * * 52: time_major
     *       An {@link ANEURALNETWORKS_BOOL} scalar specifying the shape format
     *       of input and output tensors.
     * * 53: The forward input layer normalization weights. Optional.
     *       A 1-D tensor of shape [fw_num_units]. Used to rescale normalized inputs
     *       to activation at input gate.
     * * 54: The forward forget layer normalization weights. Optional.
     *       A 1-D tensor of shape [fw_num_units]. Used to rescale normalized inputs
     *       to activation at forget gate.
     * * 55: The forward cell layer normalization weights. Optional.
     *       A 1-D tensor of shape [fw_num_units]. Used to rescale normalized inputs
     *       to activation at cell gate.
     * * 56: The forward output layer normalization weights. Optional.
     *       A 1-D tensor of shape [fw_num_units]. Used to rescale normalized inputs
     *       to activation at output gate.
     * * 57: The backward input layer normalization weights. Optional.
     *       A 1-D tensor of shape [bw_num_units]. Used to rescale normalized inputs
     *       to activation at input gate.
     * * 58: The backward forget layer normalization weights. Optional.
     *       A 1-D tensor of shape [bw_num_units]. Used to rescale normalized inputs
     *       to activation at forget gate.
     * * 59: The backward cell layer normalization weights. Optional.
     *       A 1-D tensor of shape [bw_num_units]. Used to rescale normalized inputs
     *       to activation at cell gate.
     * * 60: The backward output layer normalization weights. Optional.
     *       A 1-D tensor of shape [bw_num_units]. Used to rescale normalized inputs
     *       to activation at output gate.
     *
     * Outputs:
     * * 0: The forward output.
     *      A 3-D tensor of shape:
     *        If time-major and not merge_outputs:
     *          [max_time, batch_size, fw_output_size]
     *        If time-major and merge_outputs:
     *          [max_time, batch_size, fw_output_size + bw_output_size]
     *        If batch-major and not merge_outputs:
     *          [batch_size, max_time, fw_output_size]
     *        If batch-major and merge_outputs:
     *          [batch_size, max_time, fw_output_size + bw_output_size]
     * * 1: The backward output.  Unused if merge_outputs is true.
     *      A 3-D tensor of shape:
     *        If time-major: [max_time, batch_size, bw_output_size]
     *        If batch-major: [batch_size, max_time, bw_output_size]
     * * 2: The forward activation state output.
     *      A 2-D tensor of shape [batch_size, fw_output_size] containing an
     *      activation state from the last time step in the sequence. This
     *      output is optional and can be omitted. If this output is present
     *      then outputs 3-5 must be present as well.
     *      Available since NNAPI feature level 4.
     * * 3: The forward cell state output.
     *      A tensor of shape [batch_size, fw_cell_size] containing a cell state
     *      from the last time step in the sequence. This output is optional
     *      and can be omitted. If this output is present
     *      then outputs 2, 4, 5 must be present as well.
     *      Available since NNAPI feature level 4.
     * * 4: The backward activation state output.
     *      A 2-D tensor of shape [batch_size, bw_output_size] containing an
     *      activation state from the last time step in the sequence. This
     *      output is optional and can be omitted. If this output is present
     *      then outputs 2, 3, 5 must be present as well.
     *      Available since NNAPI feature level 4.
     * * 5: The backward cell state output.
     *      A tensor of shape [batch_size, bw_cell_size] containing a cell state
     *      from the last time step in the sequence. This output is optional
     *      and can be omitted. If this output is present
     *      then outputs 2-4 must be present as well.
     *      Available since NNAPI feature level 4.
     *
     * Available since NNAPI feature level 3.
     *
     * Important: As of NNAPI feature level 3, there is no way to get the output state tensors out
     * and NNAPI does not maintain internal states. This operator does not support the usage pattern
     * in which multiple cells are chained and state tensors are propagated.
     */
    BIDIRECTIONAL_SEQUENCE_LSTM = 42,

    /**
     * A recurrent neural network layer that applies a basic RNN cell to a
     * sequence of inputs in forward and backward directions.
     *
     * This Op unrolls the input along the sequence dimension, and implements
     * the following operation for each element in the sequence s =
     * 1...sequence_length:
     *   fw_outputs[s] = fw_state = activation(inputs[s] * fw_input_weights’ +
     *          fw_state * fw_recurrent_weights’ + fw_bias)
     *
     * And for each element in sequence t = sequence_length : 1
     *   bw_outputs[t] = bw_state = activation(inputs[t] * bw_input_weights’ +
     *          bw_state * bw_recurrent_weights’ + bw_bias)
     *
     * Where:
     * * “{fw,bw}_input_weights” is a weight matrix that multiplies the inputs;
     * * “{fw,bw}_recurrent_weights” is a weight matrix that multiplies the
     *    current “state” which itself is the output from the previous time step
     *    computation;
     * * “{fw,bw}_bias” is a bias vector (added to each output vector in the
     *    batch);
     * * “activation” is the function passed as the “fused_activation_function”
     *   argument (if not “NONE”).
     *
     * The op supports cross-linking via an auxiliary input. Regular cell feeds
     * one input into the two RNN cells in the following way:
     *
     *       INPUT  (INPUT_REVERSED)
     *         |         |
     *    ---------------------
     *    | FW_RNN     BW_RNN |
     *    ---------------------
     *         |         |
     *      FW_OUT     BW_OUT
     *
     * An op with cross-linking takes two inputs and feeds them into the RNN
     * cells in the following way:
     *
     *       AUX_INPUT   (AUX_INPUT_REVERSED)
     *           |             |
     *     INPUT | (INPUT_R'D.)|
     *       |   |       |     |
     *    -----------------------
     *    |  \  /        \    / |
     *    | FW_RNN       BW_RNN |
     *    -----------------------
     *         |           |
     *      FW_OUT      BW_OUT
     *
     * The cross-linking mode is enabled iff auxiliary input and auxiliary
     * weights are present. While stacking this op on top of itself, this
     * allows to connect both forward and backward outputs from previous cell
     * to the next cell's input.
     *
     * Since NNAPI feature level 4 parallel linking mode is supported. The mode is
     * enabled if auxiliary input is present but auxiliary weights are omitted.
     * In this case, the cell feeds inputs into the RNN in the following way:
     *
     *       INPUT (AUX_INPUT_REVERSED)
     *         |         |
     *    ---------------------
     *    | FW_RNN     BW_RNN |
     *    ---------------------
     *         |         |
     *      FW_OUT     BW_OUT
     *
     * While stacking this op on top of itself, this allows to connect both
     * forward and backward outputs from previous cell to the next cell's
     * corresponding inputs.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * The input tensors must all be the same type.
     *
     * Inputs:
     * * 0: input.
     *      A 3-D tensor. The shape is defined by the input 6 (timeMajor). If
     *      it is set to true, then the input has a shape [maxTime, batchSize,
     *      inputSize], otherwise the input has a shape [batchSize, maxTime,
     *      inputSize].
     * * 1: fwWeights.
     *      A 2-D tensor of shape [fwNumUnits, inputSize].
     * * 2: fwRecurrentWeights.
     *      A 2-D tensor of shape [fwNumUnits, fwNumUnits].
     * * 3: fwBias.
     *      A 1-D tensor of shape [fwNumUnits].
     * * 4: fwHiddenState.
     *      A 2-D tensor of shape [batchSize, fwNumUnits]. Specifies a hidden
     *      state input for the first time step of the computation.
     * * 5: bwWeights.
     *      A 2-D tensor of shape [bwNumUnits, inputSize].
     * * 6: bwRecurrentWeights.
     *      A 2-D tensor of shape [bwNumUnits, bwNumUnits].
     * * 7: bwBias.
     *      A 1-D tensor of shape [bwNumUnits].
     * * 8: bwHiddenState
     *      A 2-D tensor of shape [batchSize, bwNumUnits]. Specifies a hidden
     *      state input for the first time step of the computation.
     * * 9: auxInput.
     *      A 3-D tensor. The shape is defined by the input 6 (timeMajor). If
     *      it is set to true, then the input has a shape [maxTime, batchSize,
     *      auxInputSize], otherwise the input has a shape [batchSize, maxTime,
     *      auxInputSize]. Can be omitted. See the docs above for the usage
     *      modes explanation.
     * * 10:fwAuxWeights.
     *      A 2-D tensor of shape [fwNumUnits, auxInputSize]. Can be omitted.
     *      See the docs above for the usage modes explanation.
     * * 11:bwAuxWeights.
     *      A 2-D tensor of shape [bwNumUnits, auxInputSize]. Can be omitted.
     *      See the docs above for the usage modes explanation.
     * * 12:fusedActivationFunction.
     *      A {@link FuseCode} value indicating the activation function. If
     *      “NONE” is specified then it results in a linear activation.
     * * 13:timeMajor
     *      An {@link ANEURALNETWORKS_BOOL} scalar specifying the shape format
     *      of input and output tensors.
     * * 14:mergeOutputs
     *      An {@link ANEURALNETWORKS_BOOL} scalar specifying if the outputs
     *      from forward and backward cells are separate (if set to false) or
     *      concatenated (if set to true).
     * Outputs:
     * * 0: fwOutput.
     *      A 3-D tensor. The first two dimensions of the shape are defined by
     *      the input 6 (timeMajor) and the third dimension is defined by the
     *      input 14 (mergeOutputs). If timeMajor is set to true, then the first
     *      two dimensions are [maxTime, batchSize], otherwise they are set to
     *      [batchSize, maxTime]. If mergeOutputs is set to true, then the third
     *      dimension is equal to (fwNumUnits + bwNumUnits), otherwise it is set
     *      to fwNumUnits.
     * * 1: bwOutput.
     *      A 3-D tensor. If the input 14 (mergeOutputs) is set to true, then
     *      this tensor is not produced. The shape is defined by the input 6
     *      (timeMajor). If it is set to true, then the shape is set to
     *      [maxTime, batchSize, bwNumUnits], otherwise the shape is set to
     *      [batchSize, maxTime, bwNumUnits].
     * * 2: The forward hidden state output.
     *      A 2-D tensor of shape [batchSize, fwNumUnits] containing a hidden
     *      state from the last time step in the sequence. This output is
     *      optional and can be omitted. If this output is present then output
     *      3 must be present as well.
     *      Available since NNAPI feature level 4.
     * * 3: The backward hidden state output.
     *      A 2-D tensor of shape [batchSize, bwNumUnits] containing a hidden
     *      state from the last time step in the sequence. This output is
     *      optional and can be omitted. If this output is present then output
     *      2 must be present as well.
     *      Available since NNAPI feature level 4.
     *
     * Available since NNAPI feature level 3.
     *
     * Important: As of NNAPI feature level 3, there is no way to get the output state tensors out
     * and NNAPI does not maintain internal states. This operator does not support the usage pattern
     * in which multiple cells are chained and state tensors are propagated.
     */
    BIDIRECTIONAL_SEQUENCE_RNN = 43,

    /**
     * Greedily selects a subset of bounding boxes in descending order of score.
     *
     * This op applies NMS algorithm to each class. In each loop of execution,
     * the box with maximum score gets selected and removed from the pending set.
     * The scores of the rest of boxes are lowered according to the
     * intersection-over-union (IOU) overlapping with the previously selected
     * boxes and a specified NMS kernel method. Any boxes with score less
     * than a threshold are removed from the pending set.
     *
     * Three NMS kernels are supported:
     * * Hard:     score_new = score_old * (1 if IoU < threshold else 0)
     * * Linear:   score_new = score_old * (1 if IoU < threshold else 1 - IoU)
     * * Gaussian: score_new = score_old * exp(- IoU^2 / sigma)
     *
     * Axis-aligned bounding boxes are represented by its upper-left corner
     * coordinate (x1,y1) and lower-right corner coordinate (x2,y2). A valid
     * bounding box should satisfy x1 <= x2 and y1 <= y2.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Inputs:
     * * 0: A 2-D Tensor of shape [num_rois, num_classes], specifying the score
     *      of each bounding box proposal. The boxes are grouped by batches in the
     *      first dimension. Zero num_rois is supported for this tensor.
     * * 1: A 2-D Tensor specifying the bounding boxes of shape
     *      [num_rois, num_classes * 4], organized in the order [x1, y1, x2, y2].
     *      The boxes are grouped by batches in the first dimension. The sequential
     *      order of the boxes corresponds with input0. For input0 of type
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}, this tensor should be of
     *      {@link ANEURALNETWORKS_TENSOR_QUANT16_ASYMM}, with zeroPoint of 0 and
     *      scale of 0.125.
     *      For input0 of type {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED},
     *      this tensor should be of {@link ANEURALNETWORKS_TENSOR_QUANT16_ASYMM},
     *      with zeroPoint of -128 and scale of 0.125.
     *      Zero num_rois is supported for this tensor.
     * * 2: A 1-D {@link ANEURALNETWORKS_TENSOR_INT32} tensor, of shape
     *      [num_rois], specifying the batch index of each box. Boxes with
     *      the same batch index are grouped together.
     * * 3: An {@link ANEURALNETWORKS_FLOAT32} scalar, score_threshold. Boxes
     *      with scores lower than the threshold are filtered before sending
     *      to the NMS algorithm.
     * * 4: An {@link ANEURALNETWORKS_INT32} scalar, specifying the maximum
     *      number of selected bounding boxes for each image. Set to a negative
     *      value for unlimited number of output bounding boxes.
     * * 5: An {@link ANEURALNETWORKS_INT32} scalar, specifying the NMS
     *      kernel method, options are 0:hard, 1:linear, 2:gaussian.
     * * 6: An {@link ANEURALNETWORKS_FLOAT32} scalar, specifying the IoU
     *      threshold in hard and linear NMS kernel. This field is ignored if
     *      gaussian kernel is selected.
     * * 7: An {@link ANEURALNETWORKS_FLOAT32} scalar, specifying the sigma in
     *      gaussian NMS kernel. This field is ignored if gaussian kernel is
     *      not selected.
     * * 8: An {@link ANEURALNETWORKS_FLOAT32} scalar, nms_score_threshold.
     *      Boxes with scores lower than the threshold are dropped during the
     *      score updating phase in soft NMS.
     *
     * Outputs:
     * * 0: A 1-D Tensor of the same {@link OperandCode} as input0, with shape
     *      [num_output_rois], specifying the score of each output box. The boxes
     *      are grouped by batches, but the sequential order in each batch is not
     *      guaranteed. For type of {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM},
     *      guaranteed. For type of {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      or {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED},
     *      the scale and zero point must be the same as input0.
     * * 1: A 2-D Tensor of the same {@link OperandCode} as input1, with shape
     *      [num_output_rois, 4], specifying the coordinates of each
     *      output bounding box with the same format as input1. The sequential
     *      order of the boxes corresponds with output0. For type of
     *      {@link ANEURALNETWORKS_TENSOR_QUANT16_ASYMM}, the scale must be
     *      0.125 and the zero point must be 0.
     * * 2: A 1-D {@link ANEURALNETWORKS_TENSOR_INT32} tensor, of shape
     *      [num_output_rois], specifying the class of each output box. The
     *      sequential order of the boxes corresponds with output0.
     * * 3: A 1-D {@link ANEURALNETWORKS_TENSOR_INT32} tensor, of shape
     *      [num_output_rois], specifying the batch index of each box. Boxes
     *      with the same batch index are grouped together.
     *
     * Available since NNAPI feature level 3.
     */
    BOX_WITH_NMS_LIMIT = 44,

    /**
     * Casts a tensor to a type.
     *
     * This operation ignores the scale and zeroPoint of quanized tensors,
     * e.g. it treats a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} input
     * as a tensor of uint8 values.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * Since NNAPI feature level 4, casting tensors of the following
     * {@link OperandCode} to the same {@link OperandCode} is supported:
     * * {@link ANEURALNETWORKS_TENSOR_BOOL8}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT16_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT16_SYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM}
     *
     * Supported tensor rank: from 1
     *
     * Inputs:
     * * 0: A tensor.
     *
     * Outputs:
     * * 0: A tensor with the same shape as input0.
     *
     * Available since NNAPI feature level 3.
     */
    CAST = 45,

    /**
     * Shuffle the channels of the input tensor.
     *
     * Given an input tensor and a integer value of num_groups, CHANNEL_SHUFFLE
     * divide the channel dimension into num_groups groups, and reorganize the
     * channels by grouping channels with the same index in each group.
     *
     * Along the channel dimension, the output is calculated using this formula:
     *
     *     output_channel[k * num_groups + g] = input_channel[g * group_size + k]
     *
     * where group_size = num_channels / num_groups
     *
     * The number of channels must be divisible by num_groups.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: An n-D tensor, specifying the tensor to be shuffled.
     * * 1: An {@link ANEURALNETWORKS_INT32} scalar, specifying the number of
     *      groups.
     * * 2: An {@link ANEURALNETWORKS_INT32} scalar, specifying the dimension
     *      channel shuffle would be performed on. Negative index is used to
     *      specify axis from the end (e.g. -1 for the last axis). Must be in
     *      the range [-n, n).
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} and same shape as input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 3.
     */
    CHANNEL_SHUFFLE = 46,

    /**
     * Apply postprocessing steps to bounding box detections.
     *
     * Bounding box detections are generated by applying transformation on a set
     * of predefined anchors with the bounding box deltas from bounding box
     * regression. A final step of hard NMS is applied to limit the number of
     * returned boxes.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * Inputs:
     * * 0: A 3-D Tensor of shape [batches, num_anchors, num_classes], specifying
     *      the score of each anchor with each class. Class 0 for each
     *      [batches, num_anchors, 0] is background and will be ignored.
     * * 1: A 3-D Tensor of shape [batches, num_anchors, length_box_encoding], with
     *      the first four values in length_box_encoding specifying the bounding
     *      box deltas. The box deltas are encoded in the order of [dy, dx, dh, dw],
     *      where dy and dx is the linear-scale relative correction factor for the
     *      center position of the bounding box with respect to the width and height,
     *      dh and dw is the log-scale relative correction factor for the width and
     *      height. All the entries in length_box_encoding beyond the first four
     *      values are ignored in this operation.
     * * 2: A 2-D Tensor of shape [num_anchors, 4], specifying the shape of each
     *      predefined anchor, with format [ctr_y, ctr_x, h, w], where ctr_y and
     *      ctr_x are the center position of the box, and h and w are the height
     *      and the width.
     * * 3: An {@link ANEURALNETWORKS_FLOAT32} scalar, specifying the scaling
     *      factor for dy in bounding box deltas.
     * * 4: An {@link ANEURALNETWORKS_FLOAT32} scalar, specifying the scaling
     *      factor for dx in bounding box deltas.
     * * 5: An {@link ANEURALNETWORKS_FLOAT32} scalar, specifying the scaling
     *      factor for dh in bounding box deltas.
     * * 6: An {@link ANEURALNETWORKS_FLOAT32} scalar, specifying the scaling
     *      factor for dw in bounding box deltas.
     * * 7: An {@link ANEURALNETWORKS_BOOL} scalar, set to true to use regular
     *      multi-class NMS algorithm that do NMS separately for each class,
     *      set to false for a faster algorithm that only do one single NMS
     *      using the highest class score..
     * * 8: An {@link ANEURALNETWORKS_INT32} scalar, max_num_detections, specifying
     *      the maximum number of boxes for the output. Boxes with the lowest
     *      scores are discarded to meet the limit.
     * * 9: An {@link ANEURALNETWORKS_INT32} scalar, only used when input7 is
     *      set to false, specifying the maximum number of classes per detection.
     * * 10: An {@link ANEURALNETWORKS_INT32} scalar, only used when input7 is
     *       set to true, specifying the maximum number of detections when
     *       applying NMS algorithm for each single class.
     * * 11: A scalar, score_threshold. Boxes with scores lower than the
     *       threshold are filtered before sending to the NMS algorithm. The
     *       scalar must be of {@link ANEURALNETWORKS_FLOAT16} if input0 is of
     *       {@link ANEURALNETWORKS_TENSOR_FLOAT16} and of
     *       {@link ANEURALNETWORKS_FLOAT32} if input0 is of
     *       {@link ANEURALNETWORKS_TENSOR_FLOAT32}.
     * * 12: A scalar, specifying the IoU threshold for hard NMS. The scalar
     *       must be of {@link ANEURALNETWORKS_FLOAT16} if input0 is of
     *       {@link ANEURALNETWORKS_TENSOR_FLOAT16} and of
     *       {@link ANEURALNETWORKS_FLOAT32} if input0 is of
     *       {@link ANEURALNETWORKS_TENSOR_FLOAT32}.
     * * 13: An {@link ANEURALNETWORKS_BOOL} scalar, set to true to include
     *       background class in the list of label map for the output, set
     *       to false to not include the background. When the background
     *       class is included, it has label 0 and the output classes start
     *       at 1 in the label map, otherwise, the output classes start at 0.
     *
     * Outputs:
     * * 0: A 2-D tensor of the same {@link OperandCode} as input0, with shape
     *      [batches, max_num_detections], specifying the score of each output
     *      detections.
     * * 1: A 3-D tensor of shape [batches, max_num_detections, 4], specifying the
     *      coordinates of each output bounding box, with format
     *      [y1, x1, y2, x2].
     * * 2: A 2-D {@link ANEURALNETWORKS_TENSOR_INT32} tensor, of shape
     *      [batches, max_num_detections], specifying the class label for each
     *      output detection.
     * * 3: An 1-D {@link ANEURALNETWORKS_TENSOR_INT32} tensor, of shape [batches],
     *      specifying the number of valid output detections for each batch.
     *
     * Available since NNAPI feature level 3.
     */
    DETECTION_POSTPROCESSING = 47,

    /**
     * For input tensors x and y, computes x == y elementwise.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_BOOL8}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1
     *
     * This operation supports broadcasting.
     *
     * Inputs:
     * * 0: A tensor.
     * * 1: A tensor of the same {@link OperandCode} and dimensions compatible
     *      with input0.
     *
     * Outputs:
     * * 0: A tensor of {@link ANEURALNETWORKS_TENSOR_BOOL8}.
     *
     * Available since NNAPI feature level 3.
     */
    EQUAL = 48,

    /**
     * Computes exponential of x element-wise.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * Supported tensor rank: from 1.
     *
     * Inputs:
     * * 0: A tensor.
     *
     * Outputs:
     * * 0: The output tensor of same shape as input0.
     *
     * Available since NNAPI feature level 3.
     */
    EXP = 49,

    /**
     * Inserts a dimension of 1 into a tensor's shape.
     *
     * Given a tensor input, this operation inserts a dimension of 1 at the
     * given dimension index of input's shape. The dimension index starts at
     * zero; if you specify a negative dimension index, it is counted backward
     * from the end.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1
     *
     * Inputs:
     * * 0: An n-D tensor.
     * * 1: An {@link ANEURALNETWORKS_INT32} scalar specifying the dimension
     *      index to expand. Must be in the range [-(n + 1), (n + 1)).
     *
     * Outputs:
     * * 0: An (n + 1)-D tensor with the same {@link OperandCode} and data as
     *      input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 3.
     */
    EXPAND_DIMS = 50,

    /**
     * Gathers values along an axis.
     *
     * Produces an output tensor with shape
     *     input0.dimension[:axis] + indices.dimension + input0.dimension[axis + 1:]
     * where:
     *     # Vector indices (output is rank(input0)).
     *     output[a_0, ..., a_n, i, b_0, ..., b_n] =
     *       input0[a_0, ..., a_n, indices[i], b_0, ..., b_n]
     *
     *     # Higher rank indices (output is rank(input0) + rank(indices) - 1).
     *     output[a_0, ..., a_n, i, ..., j, b_0, ... b_n] =
     *       input0[a_0, ..., a_n, indices[i, ..., j], b_0, ..., b_n]
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1
     *
     * Inputs:
     * * 0: An n-D tensor from which to gather values.
     * * 1: An {@link ANEURALNETWORKS_INT32} scalar specifying the axis.
     *      Negative index is used to specify axis from the end
     *      (e.g. -1 for the last axis). Must be in the range [-n, n).
     * * 2: A k-D tensor {@link ANEURALNETWORKS_TENSOR_INT32} of indices.
     *      The values must be in the bounds of the corresponding dimensions
     *      of input0.
     *
     * Outputs:
     * * 0: An (n + k - 1)-D tensor with the same {@link OperandCode} as input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 3.
     */
    GATHER = 51,

    /**
     * Generate aixs-aligned bounding box proposals.
     *
     * Bounding box proposals are generated by applying transformation on a set
     * of predefined anchors with the bounding box deltas from bounding box
     * regression. A final step of hard NMS is applied to limit the number of
     * returned boxes.
     *
     * Axis-aligned bounding boxes are represented by its upper-left corner
     * coordinate (x1,y1) and lower-right corner coordinate (x2,y2). A valid
     * bounding box should satisfy x1 <= x2 and y1 <= y2.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Inputs:
     * * 0: A 4-D Tensor specifying the score of each anchor at each
     *      location. With "NHWC" data layout, the tensor shape is
     *      [batches, height, width, num_anchors]. With "NCHW" data layout,
     *      the tensor shape is [batches, num_anchors, height, width].
     * * 1: A 4-D Tensor specifying the bounding box deltas. With "NHWC" data
     *      layout, the tensor shape is [batches, height, width, num_anchors * 4].
     *      With "NCHW" data layout, the tensor shape is
     *      [batches, num_anchors * 4, height, width]. The box deltas are encoded
     *      in the order of [dx, dy, dw, dh], where dx and dy is the linear-scale
     *      relative correction factor for the center position of the bounding box
     *      with respect to the width and height, dw and dh is the log-scale
     *      relative correction factor for the width and height. The last
     *      dimensions is the channel dimension.
     * * 2: A 2-D Tensor of shape [num_anchors, 4], specifying the shape of each
     *      predefined anchor, with format [x1, y1, x2, y2]. For input0 of type
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} or
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}, this tensor should be of
     *      {@link ANEURALNETWORKS_TENSOR_QUANT16_SYMM}, with scale of 0.125.
     * * 3: A 2-D Tensor of shape [batches, 2], specifying the size of
     *      each image in the batch, with format [image_height, image_width].
     *      For input0 of type {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} or
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}, this
     *      tensor should be of {@link ANEURALNETWORKS_TENSOR_QUANT16_SYMM}, with
     *      scale of 0.125.
     * * 4: An {@link ANEURALNETWORKS_FLOAT32} scalar, specifying the ratio
     *      from the height of original image to the height of feature map.
     * * 5: An {@link ANEURALNETWORKS_FLOAT32} scalar, specifying the ratio
     *      from the width of original image to the width of feature map.
     * * 6: An {@link ANEURALNETWORKS_INT32} scalar, specifying the maximum
     *      number of boxes before going into the hard NMS algorithm. Boxes
     *      with the lowest scores are discarded to meet the limit. Set to
     *      a non-positive value for unlimited number.
     * * 7: An {@link ANEURALNETWORKS_INT32} scalar, specifying the maximum
     *      number of boxes returning from the hard NMS algorithm. Boxes
     *      with the lowest scores are discarded to meet the limit. Set to
     *      a non-positive value for unlimited number.
     * * 8: An {@link ANEURALNETWORKS_FLOAT32} scalar, specifying the IoU
     *      threshold for hard NMS.
     * * 9: An {@link ANEURALNETWORKS_FLOAT32} scalar, min_size. Boxes with
     *      height or width lower than the absolute threshold are filtered out.
     * * 10: An {@link ANEURALNETWORKS_BOOL} scalar, set to true to specify
     *       NCHW data layout for input0 and input1. Set to false for NHWC.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0, of shape
     *      [num_output_rois], specifying the score of each output box.
     *      The boxes are grouped by batches, but the sequential order in
     *      each batch is not guaranteed. For type of
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} or
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}, the scale and zero
     *      point must be the same as input0.
     * * 1: A tensor of the same {@link OperandCode} as input3, of shape
     *      [num_output_rois, 4], specifying the coordinates of each output
     *      bounding box for each class, with format [x1, y1, x2, y2].
     *      The sequential order of the boxes corresponds with output0.
     *      For type of {@link ANEURALNETWORKS_TENSOR_QUANT16_ASYMM}, the
     *      scale must be 0.125 and the zero point must be 0.
     * * 2: A 1-D {@link ANEURALNETWORKS_TENSOR_INT32} tensor, of shape
     *      [num_output_rois], specifying the batch index of each box. Boxes
     *      with the same batch index are grouped together.
     *
     * Available since NNAPI feature level 3.
     */
    GENERATE_PROPOSALS = 52,

    /**
     * For input tensors x and y, computes x > y elementwise.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_BOOL8}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1
     *
     * This operation supports broadcasting.
     *
     * Inputs:
     * * 0: A tensor.
     * * 1: A tensor of the same {@link OperandCode} and dimensions compatible
     *      with input0.
     *
     * Outputs:
     * * 0: A tensor of {@link ANEURALNETWORKS_TENSOR_BOOL8}.
     *
     * Available since NNAPI feature level 3.
     */
    ANEURALNETWORKS_GREATER = 53,
    /**
     * For input tensors x and y, computes x >= y elementwise.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_BOOL8}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1
     *
     * This operation supports broadcasting.
     *
     * Inputs:
     * * 0: A tensor.
     * * 1: A tensor of the same {@link OperandCode} and dimensions compatible
     *      with input0.
     *
     * Outputs:
     * * 0: A tensor of {@link ANEURALNETWORKS_TENSOR_BOOL8}.
     *
     * Available since NNAPI feature level 3.
     */
    GREATER_EQUAL = 54,

    /**
     * Performs a grouped 2-D convolution operation.
     *
     * Given an input tensor of shape [batches, height, width, depth_in] and a
     * filter tensor of shape [depth_out, filter_height, filter_width, depth_group]
     * containing depth_out convolutional filters of depth depth_group, GROUPED_CONV
     * applies a group of different filters to each input channel group, then
     * concatenates the results together.
     *
     * Specifically, the input channels are divided into num_groups groups, each with
     * depth depth_group, i.e. depth_in = num_groups * depth_group. The convolutional
     * filters are also divided into num_groups groups, i.e. depth_out is divisible
     * by num_groups. GROUPED_CONV applies each group of filters to the corresponding
     * input channel group, and the result are concatenated together.
     *
     * The output dimensions are functions of the filter dimensions, stride, and
     * padding.
     *
     * The values in the output tensor are computed as:
     *
     *     output[b, i, j, g * channel_multiplier + q] =
     *         sum_{di, dj, dk} (
     *             input[b, strides[1] * i + di, strides[2] * j + dj,
     *                   g * depth_group + dk] *
     *             filter[g * channel_multiplier + q, di, dj, dk]
     *         ) + bias[channel]
     *
     * where channel_multiplier = depth_out / num_groups
     *
     * Supported tensor {@link OperandCode} configurations:
     * * 16 bit floating point:
     * * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} for input, filter, output, and bias.
     *
     * * 32 bit floating point:
     * * * {@link ANEURALNETWORKS_TENSOR_FLOAT32} for input, filter, output, and bias.
     *
     * * Quantized:
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} for input, filter, and output.
     * * * {@link ANEURALNETWORKS_TENSOR_INT32} for bias (with scale set to
     * * * input.scale * filter.scale).
     *
     * * Quantized signed (since NNAPI feature level 4):
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} for input, filter, and output.
     * * * {@link ANEURALNETWORKS_TENSOR_INT32} for bias (with scale set to
     * * * input.scale * filter.scale).
     *
     * * Quantized with symmetric per channel quantization for the filter:
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} for input, and output.
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL} for filter.
     * * * {@link ANEURALNETWORKS_TENSOR_INT32} for bias (scale set to 0.0,
     * * * each value scaling is separate and equal to input.scale * filter.scales[channel]).
     *
     * * Quantized signed with filter symmetric per channel quantization
     *   (since NNAPI feature level 4):
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} for input, and output.
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL} for filter.
     * * * {@link ANEURALNETWORKS_TENSOR_INT32} for bias (scale set to 0.0,
     * * * each value scaling is separate and equal to input.scale * filter.scales[channel]).
     *
     * Supported tensor rank: 4, with "NHWC" or "NCHW" data layout.
     * With the default data layout NHWC, the data is stored in the order of:
     * [batch, height, width, channels]. Alternatively, the data layout could
     * be NCHW, the data storage order of: [batch, channels, height, width].
     *
     * Both explicit padding and implicit padding are supported.
     *
     * Inputs (explicit padding):
     * * 0: A 4-D tensor, of shape [batches, height, width, depth_in],
     *      specifying the input, where depth_in = num_groups * depth_group.
     * * 1: A 4-D tensor, of shape
     *      [depth_out, filter_height, filter_width, depth_group], specifying
     *      the filter, where depth_out must be divisible by num_groups.  For
     *      tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL}
     *      the channel dimension (channelDim at
     *      {@link ANeuralNetworksSymmPerChannelQuantParams}) must be set to 0.
     * * 2: A 1-D tensor, of shape [depth_out], specifying the bias. For input
     *      tensor of type {@link ANEURALNETWORKS_TENSOR_FLOAT32} or
     *      {@link ANEURALNETWORKS_TENSOR_FLOAT16}, the bias must be of the same type.
     *      For filter tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}
     *      the bias should be of {@link ANEURALNETWORKS_TENSOR_INT32}, with zeroPoint
     *      of 0 and bias_scale == input_scale * filter_scale. For filter tensor
     *      of {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL}, the bias
     *      should be of {@link ANEURALNETWORKS_TENSOR_INT32}, with zeroPoint of
     *      0 and bias_scale of 0. The actual scale of each value 'i' is equal to
     *      bias_scale[i] = input_scale * filter_scale[i].
     * * 3: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the left, in the ‘width’ dimension.
     * * 4: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the right, in the ‘width’ dimension.
     * * 5: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the top, in the ‘height’ dimension.
     * * 6: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the bottom, in the ‘height’ dimension.
     * * 7: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘width’ dimension.
     * * 8: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘height’ dimension.
     * * 9: An {@link ANEURALNETWORKS_INT32} scalar, specifying the number of
     *      groups.
     * * 10: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *       {@link FuseCode} values. Specifies the activation to
     *       invoke on the result.
     * * 11: An {@link ANEURALNETWORKS_BOOL} scalar, set to true to specify
     *       NCHW data layout for input0 and output0. Set to false for NHWC.
     *
     * Inputs (implicit padding):
     * * 0: A 4-D tensor, of shape [batches, height, width, depth_in],
     *      specifying the input, where depth_in = num_groups * depth_group.
     * * 1: A 4-D tensor, of shape
     *      [depth_out, filter_height, filter_width, depth_group], specifying
     *      the filter, where depth_out must be divisible by num_groups.  For
     *      tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL}
     *      the channel dimension (ANeuralNetworksSymmPerChannelQuantParams::channelDim)
     *      must be set to 0.
     * * 2: A 1-D tensor, of shape [depth_out], specifying the bias. For input
     *      tensor of type {@link ANEURALNETWORKS_TENSOR_FLOAT32} or
     *      {@link ANEURALNETWORKS_TENSOR_FLOAT16}, the bias must be of the same
     *      {@link ANEURALNETWORKS_TENSOR_FLOAT16}, the bias must be of the same type.
     *      For filter tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}
     *      the bias should be of {@link ANEURALNETWORKS_TENSOR_INT32}, with zeroPoint
     *      of 0 and bias_scale == input_scale * filter_scale. For filter tensor
     *      of {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL}, the bias
     *      should be of {@link ANEURALNETWORKS_TENSOR_INT32}, with zeroPoint of
     *      0 and bias_scale of 0. The actual scale of each value 'i' is equal to
     *      bias_scale[i] = input_scale * filter_scale[i].
     * * 3: An {@link ANEURALNETWORKS_INT32} scalar, specifying the implicit
     *      padding scheme, has to be one of the
     *      {@link PaddingCode} values.
     * * 4: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘width’ dimension.
     * * 5: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘height’ dimension.
     * * 6: An {@link ANEURALNETWORKS_INT32} scalar, specifying the number of
     *      groups.
     * * 7: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *      {@link FuseCode} values. Specifies the activation to
     *      invoke on the result.
     * * 8: An {@link ANEURALNETWORKS_BOOL} scalar, set to true to specify
     *      NCHW data layout for input0 and output0. Set to false for NHWC.
     *
     * Outputs:
     * * 0: The output 4-D tensor, of shape
     *      [batches, out_height, out_width, depth_out].
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint can be different from inputs' scale and zeroPoint.
     *
     * Available since NNAPI feature level 3.
     */
    GROUPED_CONV_2D = 55,

    /**
     * Localize the maximum keypoints from heatmaps.
     *
     * This operation approximates the accurate maximum keypoint scores and
     * indices after bicubic upscaling by using Taylor expansion up to the
     * quadratic term.
     *
     * The bounding box is represented by its upper-left corner coordinate
     * (x1,y1) and lower-right corner coordinate (x2,y2) in the original image.
     * A valid bounding box should satisfy x1 <= x2 and y1 <= y2.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: 4, with "NHWC" or "NCHW" data layout.
     * With the default data layout NHWC, the data is stored in the order of:
     * [batch, height, width, channels]. Alternatively, the data layout could
     * be NCHW, the data storage order of: [batch, channels, height, width].
     *
     * Inputs:
     * * 0: A 4-D Tensor of shape
     *      [num_boxes, heatmap_size, heatmap_size, num_keypoints],
     *      specifying the heatmaps, the height and width of heatmaps should
     *      be the same, and must be greater than or equal to 2.
     * * 1: A 2-D Tensor of shape [num_boxes, 4], specifying the bounding boxes,
     *      each with format [x1, y1, x2, y2]. For input0 of type
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}, this tensor should
     *      be of {@link ANEURALNETWORKS_TENSOR_QUANT16_ASYMM}, with zeroPoint
     *      of 0 and scale of 0.125.
     *      For input0 of type
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}, this tensor
     *      should be of {@link ANEURALNETWORKS_TENSOR_QUANT16_ASYMM}, with
     *      zeroPoint of -128 and scale of 0.125.
     * * 2: An {@link ANEURALNETWORKS_BOOL} scalar, set to true to specify
     *      NCHW data layout for input0. Set to false for NHWC.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0, with shape
     *      [num_boxes, num_keypoints], specifying score of the keypoints.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} or
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint can be different from input0 scale and zeroPoint.
     * * 1: A tensor of the same {@link OperandCode} as input1, with shape
     *      [num_boxes, num_keypoints, 2], specifying the location of
     *      the keypoints, the second dimension is organized as
     *      [keypoint_x, keypoint_y].
     *      For type of {@link ANEURALNETWORKS_TENSOR_QUANT16_ASYMM}, the
     *      scale must be 0.125 and the zero point must be 0.
     *
     * Available since NNAPI feature level 3.
     */
    HEATMAP_MAX_KEYPOINT = 56,

    /**
     * Applies instance normalization to the input tensor.
     *
     * The values in the output tensor are computed as:
     *
     *     output[b, h, w, c] =
     *         (input[b, h, w, c] - mean[b, c]) * gamma /
     *         sqrt(var[b, c] + epsilon) + beta
     *
     * Where the mean and variance are computed across the spatial dimensions:
     *
     *     mean[b, c] =
     *         sum_{h, w}(input[b, h, w, c]) / sum(1)
     *
     *     var[b, c] =
     *         sum_{h, w}(pow(input[b, h, w, c] - mean[b, c], 2)) / sum(1)
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * Supported tensor rank: 4, with "NHWC" or "NCHW" data layout.
     * With the default data layout NHWC, the data is stored in the order of:
     * [batch, height, width, channels]. Alternatively, the data layout could
     * be NCHW, the data storage order of: [batch, channels, height, width].
     *
     * Inputs:
     * * 0: An n-D tensor, specifying the tensor to be normalized.
     * * 1: A scalar, specifying gamma, the scale applied to the normalized
     *      tensor. The scalar must be of {@link ANEURALNETWORKS_FLOAT16} if
     *      input0 is of {@link ANEURALNETWORKS_TENSOR_FLOAT16} and of
     *      {@link ANEURALNETWORKS_FLOAT32} if input0 is of
     *      {@link ANEURALNETWORKS_TENSOR_FLOAT32}.
     * * 2: A scalar, specifying beta, the offset applied to the normalized
     *      tensor. The scalar must be of {@link ANEURALNETWORKS_FLOAT16} if
     *      input0 is of {@link ANEURALNETWORKS_TENSOR_FLOAT16} and of
     *      {@link ANEURALNETWORKS_FLOAT32} if input0 is of
     *      {@link ANEURALNETWORKS_TENSOR_FLOAT32}.
     * * 3: A scalar, specifying epsilon, the small value added to variance to
     *      avoid dividing by zero. The scalar must be of {@link ANEURALNETWORKS_FLOAT16} if
     *      input0 is of {@link ANEURALNETWORKS_TENSOR_FLOAT16} and of
     *      {@link ANEURALNETWORKS_FLOAT32} if input0 is of
     *      {@link ANEURALNETWORKS_TENSOR_FLOAT32}.
     * * 4: An {@link ANEURALNETWORKS_BOOL} scalar, set to true to specify
     *      NCHW data layout for input0 and output0. Set to false for NHWC.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} and same shape as input0.
     *
     * Available since NNAPI feature level 3.
     */
    INSTANCE_NORMALIZATION = 57,

    /**
     * For input tensors x and y, computes x < y elementwise.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_BOOL8}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1
     *
     * This operation supports broadcasting.
     *
     * Inputs:
     * * 0: A tensor.
     * * 1: A tensor of the same {@link OperandCode} and dimensions compatible
     *      with input0.
     *
     * Outputs:
     * * 0: A tensor of {@link ANEURALNETWORKS_TENSOR_BOOL8}.
     *
     * Available since NNAPI feature level 3.
     */
    LESS = 58,

    /**
     * For input tensors x and y, computes x <= y elementwise.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_BOOL8}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1
     *
     * This operation supports broadcasting.
     *
     * Inputs:
     * * 0: A tensor.
     * * 1: A tensor of the same {@link OperandCode} and dimensions compatible
     *      with input0.
     *
     * Outputs:
     * * 0: A tensor of {@link ANEURALNETWORKS_TENSOR_BOOL8}.
     *
     * Available since NNAPI feature level 3.
     */
    LESS_EQUAL = 59,

    /**
     * Computes natural logarithm of x element-wise.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * Supported tensor rank: from 1.
     *
     * Inputs:
     * * 0: A tensor.
     *
     * Outputs:
     * * 0: The output tensor of same shape as input0.
     *
     * Available since NNAPI feature level 3.
     */
    LOG = 60,

    /**
     * Returns the truth value of x AND y element-wise.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_BOOL8}
     *
     * Supported tensor rank: from 1
     *
     * This operation supports broadcasting.
     *
     * Inputs:
     * * 0: A tensor of {@link ANEURALNETWORKS_TENSOR_BOOL8}.
     * * 1: A tensor of {@link ANEURALNETWORKS_TENSOR_BOOL8} and dimensions
     *      compatible with input0.
     *
     * Outputs:
     * * 0: A tensor of {@link ANEURALNETWORKS_TENSOR_BOOL8}.
     *
     * Available since NNAPI feature level 3.
     */
    LOGICAL_AND = 61,

    /**
     * Computes the truth value of NOT x element-wise.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_BOOL8}
     *
     * Supported tensor rank: from 1.
     *
     * Inputs:
     * * 0: A tensor.
     *
     * Outputs:
     * * 0: The output tensor of same shape as input0.
     *
     * Available since NNAPI feature level 3.
     */
    LOGICAL_NOT = 62,

    /**
     * Returns the truth value of x OR y element-wise.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_BOOL8}
     *
     * Supported tensor rank: from 1
     *
     * This operation supports broadcasting.
     *
     * Inputs:
     * * 0: A tensor of {@link ANEURALNETWORKS_TENSOR_BOOL8}.
     * * 1: A tensor of {@link ANEURALNETWORKS_TENSOR_BOOL8} and dimensions
     *      compatible with input0.
     *
     * Outputs:
     * * 0: A tensor of {@link ANEURALNETWORKS_TENSOR_BOOL8}.
     *
     * Available since NNAPI feature level 3.
     */
    LOGICAL_OR = 63,

    /**
     * Computes the log softmax activations given logits.
     *
     * The output is calculated using this formula:
     *
     *     output = logits * beta - log(reduce_sum(exp(logits * beta), axis))
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * Supported tensor rank: from 1.
     *
     * Inputs:
     * * 0: A tensor specifying the input logits.
     * * 1: A scalar, specifying the positive scaling factor for the exponent,
     *      beta.
     *      For input tensor of {@link ANEURALNETWORKS_TENSOR_FLOAT16}, the beta
     *      value must be of {@link ANEURALNETWORKS_FLOAT16}.
     *      For input tensor of {@link ANEURALNETWORKS_TENSOR_FLOAT32}, the beta
     *      value must be of {@link ANEURALNETWORKS_FLOAT32}.
     * * 2: An {@link ANEURALNETWORKS_INT32} scalar specifying the axis to
     *      reduce across. Negative index is used to specify axis from the
     *      end (e.g. -1 for the last axis). Must be in the range [-n, n).
     *
     * Outputs:
     * * 0: The output tensor of the same {@link OperandCode} and shape as
     *      input0.
     *
     * Available since NNAPI feature level 3.
     */
    LOG_SOFTMAX = 64,

    /**
     * Returns the element-wise maximum of two tensors.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1.
     *
     * Inputs:
     * * 0: A tensor.
     * * 1: A tensor of the same {@link OperandCode} and compatible dimensions
     *      with input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} tensor,
     *      the scales and zeroPoint can be different from input0 scale and zeroPoint.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} tensor,
     *      the scale and zeroPoint can be different from inputs' scale and zeroPoint.
     *
     * Available since NNAPI feature level 3.
     */
    MAXIMUM = 65,

    /**
     * Returns the element-wise minimum of two tensors.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1.
     *
     * Inputs:
     * * 0: A tensor.
     * * 1: A tensor of the same {@link OperandCode} and compatible dimensions
     *      with input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} tensor,
     *      the scales and zeroPoint can be different from input0 scale and zeroPoint.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} tensor,
     *      the scale and zeroPoint can be different from inputs' scale and zeroPoint.
     *
     * Available since NNAPI feature level 3.
     */
    MINIMUM = 66,

    /**
     * Computes numerical negative value element-wise.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     *
     * Supported tensor rank: from 1.
     *
     * Inputs:
     * * 0: A tensor.
     *
     * Outputs:
     * * 0: The output tensor of same shape as input0.
     *
     * Available since NNAPI feature level 3.
     */
    NEG = 67,

    /**
     * For input tensors x and y, computes x != y elementwise.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_BOOL8}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1
     *
     * This operation supports broadcasting.
     *
     * Inputs:
     * * 0: A tensor.
     * * 1: A tensor of the same {@link OperandCode} and dimensions compatible
     *      with input0.
     *
     * Outputs:
     * * 0: A tensor of {@link ANEURALNETWORKS_TENSOR_BOOL8}.
     *
     * Available since NNAPI feature level 3.
     */
    NOT_EQUAL = 68,

    /**
     * Pads a tensor with the given constant value according to the specified
     * paddings.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: An n-D tensor, specifying the tensor to be padded.
     * * 1: A 2-D Tensor of {@link ANEURALNETWORKS_TENSOR_INT32}, the paddings
     *      for each spatial dimension of the input tensor. The shape of the
     *      tensor must be {rank(input0), 2}.
     *      padding[i, 0] specifies the number of elements to be padded in the
     *      front of dimension i.
     *      padding[i, 1] specifies the number of elements to be padded after
     *      the end of dimension i.
     * * 2: A scalar specifying the value to use for padding input0.
     *      For input tensor of {@link ANEURALNETWORKS_TENSOR_FLOAT16}, the
     *      pad value must be of {@link ANEURALNETWORKS_FLOAT16}.
     *      For input tensor of {@link ANEURALNETWORKS_TENSOR_FLOAT32}, the
     *      pad value must be of {@link ANEURALNETWORKS_FLOAT32}.
     *      For input tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED},
     *      the pad value must be of {@link ANEURALNETWORKS_INT32}. The
     *      scale and zeroPoint are assumed to be the same as in input0.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0. The
     *      output tensor has the same rank as input0, and each
     *      dimension of the output tensor has the same size as the
     *      corresponding dimension of the input tensor plus the size
     *      of the padding:
     *          output0.dimension[i] =
     *              padding[i, 0] + input0.dimension[i] + padding[i, 1]
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 3.
     */
    PAD_V2 = 69,

    /**
     * Computes the power of one value to another.
     *
     * Given a tensor base and a tensor exponent, this operation computes
     * base^exponent elementwise.
     *
     * This operations supports broadcasting. The size of the output is the
     * maximum size along each dimension of the input operands. It starts with
     * the trailing dimensions, and works its way forward.
     *
     * For example:
     *     base.dimension     =    {4, 1, 2}
     *     exponent.dimension = {5, 4, 3, 1}
     *     output.dimension   = {5, 4, 3, 2}
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * Supported tensor rank: from 1
     *
     * Inputs:
     * * 0: A tensor specifying the base.
     * * 1: A tensor specifying the exponent.
     *
     * Outputs:
     * * 0: An output tensor.
     *
     * Available since NNAPI feature level 3.
     */
    POW = 70,

    /**
     * Parametric Rectified Linear Unit.
     *
     * It follows: f(x) = alpha * x for x < 0, f(x) = x for x >= 0, where alpha
     * is a learned array with the same {@link OperandCode} and compatible
     * dimensions as input x.
     *
     * Two dimensions are compatible when:
     *     1. they are equal, or
     *     2. one of them is 1
     *
     * The size of the output is the maximum size along each dimension of the
     * input operands. It starts with the trailing dimensions, and works its way
     * forward.
     *
     * Example:
     *     input.dimension  =    {4, 1, 2}
     *     alpha.dimension  = {5, 4, 3, 1}
     *     output.dimension = {5, 4, 3, 2}
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1
     *
     * Inputs:
     * * 0: A tensor, specifying the input.
     * * 1: A tensor of the same {@link OperandCode}, and compatible dimensions
     *      as input0, specifying the alpha.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scales and zeroPoint can be different from input0 scale and zeroPoint.
     *
     * Available since NNAPI feature level 3.
     */
    PRELU = 71,

    /**
     * Quantizes the input tensor.
     *
     * The formula for {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} output tensor is:
     *
     *     output = max(0, min(255, round(input / scale) + zeroPoint)
     *
     * The formula for {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} output
     * tensor is:
     *
     *     output = max(-128, min(127, round(input / scale) + zeroPoint)
     *
     * Supported input tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * Supported output tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1
     *
     * Inputs:
     * * 0: A tensor, may be zero-sized.
     *
     * Outputs:
     * * 0: The output tensor of same shape as input0, but with
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} or.
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}.
     *
     * Available since NNAPI feature level 3.
     */
    QUANTIZE = 72,

    /**
     * A version of quantized LSTM, using 16 bit quantization for internal
     * state.
     *
     * There is no projection layer, so cell state size is equal to the output
     * size.
     *
     * Inputs:
     * * 0: A 2-D tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and shape [numBatches, inputSize] specifying the input to the LSTM
     *      cell. Tensor is quantized with a fixed quantization range of
     *      [-1, 127/128] (scale = 1/128, zeroPoint = 128).
     * * 1: The input-to-input weights.
     *      A 2-D tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and shape [outputSize, inputSize] specifying input-to-input part of
     *      weights for fully-connected layer inside the LSTM cell.
     *      Quantization zero point and scale must be the same across all the
     *      weights.
     * * 2: The input-to-forget weights.
     *      A 2-D tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and shape [outputSize, inputSize] specifying input-to-forget part of
     *      weights for fully-connected layer inside the LSTM cell.
     *      Quantization zero point and scale must be the same across all the
     *      weights.
     * * 3: The input-to-cell weights.
     *      A 2-D tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and shape [outputSize, inputSize] specifying input-to-cell part of
     *      weights for fully-connected layer inside the LSTM cell.
     *      Quantization zero point and scale must be the same across all the
     *      weights.
     * * 4: The input-to-output weights.
     *      A 2-D tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and shape [outputSize, inputSize] specifying input-to-output part of
     *      weights for fully-connected layer inside the LSTM cell.
     *      Quantization zero point and scale must be the same across all the
     *      weights.
     * * 5: The recurrent-to-input weights.
     *      A 2-D tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and shape [outputSize, outputSize] specifying recurrent-to-input part
     *      of weights for fully-connected layer inside the LSTM cell.
     *      Quantization zero point and scale must be the same across all the
     *      weights.
     * * 6: The recurrent-to-forget weights.
     *      A 2-D tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and shape [outputSize, outputSize] specifying recurrent-to-forget
     *      part of weights for fully-connected layer inside the LSTM cell.
     *      Quantization zero point and scale must be the same across all the
     *      weights.
     * * 7: The recurrent-to-cell weights.
     *      A 2-D tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and shape [outputSize, outputSize] specifying recurrent-to-cell part
     *      of weights for fully-connected layer inside the LSTM cell.
     *      Quantization zero point and scale must be the same across all the
     *      weights.
     * * 8: The recurrent-to-output weights.
     *      A 2-D tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and shape [outputSize, outputSize] specifying recurrent-to-output
     *      part of weights for fully-connected layer inside the LSTM cell.
     *      Quantization zero point and scale must be the same across all the
     *      weights.
     * * 9: The input gate bias.
     *      A 1-D tensor of type {@link ANEURALNETWORKS_TENSOR_INT32} and shape
     *      [outputSize] specifying the bias for the fully-connected layer
     *      inside the LSTM cell. Bias is quantized with scale being a product
     *      of input and weights scales and zeroPoint equal to 0.
     * * 10:The forget gate bias.
     *      A 1-D tensor of type {@link ANEURALNETWORKS_TENSOR_INT32} and shape
     *      [outputSize] specifying the bias for the fully-connected layer
     *      inside the LSTM cell. Bias is quantized with scale being a product
     *      of input and weights scales and zeroPoint equal to 0.
     * * 11:The cell bias.
     *      A 1-D tensor of type {@link ANEURALNETWORKS_TENSOR_INT32} and shape
     *      [outputSize] specifying the bias for the fully-connected layer
     *      inside the LSTM cell. Bias is quantized with scale being a product
     *      of input and weights scales and zeroPoint equal to 0.
     * * 12:The output gate bias.
     *      A 1-D tensor of type {@link ANEURALNETWORKS_TENSOR_INT32} and shape
     *      [outputSize] specifying the bias for the fully-connected layer
     *      inside the LSTM cell. Bias is quantized with scale being a product
     *      of input and weights scales and zeroPoint equal to 0.
     * * 13: A 2-D tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT16_SYMM}
     *       and shape [numBatches, outputSize] specifying the cell state from the
     *       previous time step of the LSTM cell. It is quantized using a
     *       quantization range of [-2^4, 2^4 * 32767/32768] (scale = 2^4 /
     *       32768, zeroPoint = 0).
     * * 14: A 2-D tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *       and shape [numBathes, outputSize] specifying the output of the LSTM
     *       cell from previous time-step. Tensor is quantized with a fixed
     *       quantization range of [-1, 127/128] (scale = 1/128, zeroPoint =
     *       128).
     *
     *
     * Outputs:
     * * 0: A 2-D tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT16_SYMM}
     *      and shape [numBatches, outputSize] which contains a cell state from
     *      the current time step. Tensor is quantized using a quantization
     *      range of [-2^4, 2^4 * 32767/32768] (scale = 2^4 / 32768, zeroPoint =
     *      0).
     * * 1: A 2-D tensor of type {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and shape [numBathes, outputSize] which contains the output value.
     *      Tensor is quantized with a fixed quantization range of [-1, 127/128]
     *      (scale = 1/128, zeroPoint = 128).
     */
    QUANTIZED_16BIT_LSTM = 73,

    /**
     * Draws samples from a multinomial distribution.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * Inputs:
     * * 0: A 2-D tensor with shape [batches, classes], specifying the
     *      unnormalized log-probabilities for all classes.
     * * 1: A scalar {@link ANEURALNETWORKS_INT32}, specifying the number of
     *      independent samples to draw for each row slice.
     * * 2: A 1-D {@link ANEURALNETWORKS_TENSOR_INT32} tensor with shape [2],
     *      specifying seeds used to initialize the random distribution. If both
     *      provided seeds are 0, both will be randomly generated.
     * Outputs:
     * * 0: A 2-D {@link ANEURALNETWORKS_TENSOR_INT32} tensor with shape
     *      [batches, samples], containing the drawn samples.
     *
     * Available since NNAPI feature level 3.
     */
    RANDOM_MULTINOMIAL = 74,

    /**
     * Reduces a tensor by computing the "logical and" of elements along given
     * dimensions.
     *
     * If keep_dims is true, the reduced dimensions are
     * retained with length 1. Otherwise, the rank of the tensor is reduced by
     * 1 for each entry in dimensions.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_BOOL8}
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: An n-D tensor.
     * * 1: A 1-D tensor of {@link ANEURALNETWORKS_TENSOR_INT32}. The dimensions
     *      to reduce. Dimension values must be in the range [-n, n).
     * * 2: An {@link ANEURALNETWORKS_BOOL} scalar, keep_dims. If true,
     *      retains reduced dimensions with length 1.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0.
     *      If all dimensions are reduced and keep_dims is false, the output
     *      shape is [1].
     *
     * Available since NNAPI feature level 3.
     */
    REDUCE_ALL = 75,

    /**
     * Reduces a tensor by computing the "logical or" of elements along given
     * dimensions.
     *
     * If keep_dims is true, the reduced dimensions are
     * retained with length 1. Otherwise, the rank of the tensor is reduced by
     * 1 for each entry in dimensions.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_BOOL8}
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: An n-D tensor.
     * * 1: A 1-D tensor of {@link ANEURALNETWORKS_TENSOR_INT32}. The dimensions
     *      to reduce. Dimension values must be in the range [-n, n).
     * * 2: An {@link ANEURALNETWORKS_BOOL} scalar, keep_dims. If true,
     *      retains reduced dimensions with length 1.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0.
     *      If all dimensions are reduced and keep_dims is false, the output
     *      shape is [1].
     *
     * Available since NNAPI feature level 3.
     */
    REDUCE_ANY = 76,

    /**
     * Reduces a tensor by computing the maximum of elements along given
     * dimensions.
     *
     * If keep_dims is true, the reduced dimensions are
     * retained with length 1. Otherwise, the rank of the tensor is reduced by
     * 1 for each entry in dimensions.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: An n-D tensor.
     * * 1: A 1-D tensor of {@link ANEURALNETWORKS_TENSOR_INT32}. The dimensions
     *      to reduce. Dimension values must be in the range [-n, n).
     * * 2: An {@link ANEURALNETWORKS_BOOL} scalar, keep_dims. If true,
     *      retains reduced dimensions with length 1.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0.
     *      If all dimensions are reduced and keep_dims is false, the output
     *      shape is [1].
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 3.
     */
    REDUCE_MAX = 77,

    /**
     * Reduces a tensor by computing the minimum of elements along given
     * dimensions.
     *
     * If keep_dims is true, the reduced dimensions are
     * retained with length 1. Otherwise, the rank of the tensor is reduced by
     * 1 for each entry in dimensions.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: An n-D tensor.
     * * 1: A 1-D tensor of {@link ANEURALNETWORKS_TENSOR_INT32}. The dimensions
     *      to reduce. Dimension values must be in the range [-n, n).
     * * 2: An {@link ANEURALNETWORKS_BOOL} scalar, keep_dims. If true,
     *      retains reduced dimensions with length 1.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0.
     *      If all dimensions are reduced and keep_dims is false, the output
     *      shape is [1].
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 3.
     */
    REDUCE_MIN = 78,

    /**
     * Reduces a tensor by multiplying elements along given dimensions.
     *
     * If keep_dims is true, the reduced dimensions are
     * retained with length 1. Otherwise, the rank of the tensor is reduced by
     * 1 for each entry in dimensions.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: An n-D tensor.
     * * 1: A 1-D tensor of {@link ANEURALNETWORKS_TENSOR_INT32}. The dimensions
     *      to reduce. Dimension values must be in the range [-n, n).
     * * 2: An {@link ANEURALNETWORKS_BOOL} scalar, keep_dims. If true,
     *      retains reduced dimensions with length 1.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0.
     *      If all dimensions are reduced and keep_dims is false, the output
     *      shape is [1].
     *
     * Available since NNAPI feature level 3.
     */
    REDUCE_PROD = 79,

    /**
     * Reduces a tensor by summing elements along given dimensions.
     *
     * If keep_dims is true, the reduced dimensions are
     * retained with length 1. Otherwise, the rank of the tensor is reduced by
     * 1 for each entry in dimensions.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * Supported tensor rank: up to 4
     *
     * Inputs:
     * * 0: An n-D tensor.
     * * 1: A 1-D tensor of {@link ANEURALNETWORKS_TENSOR_INT32}. The dimensions
     *      to reduce. Dimension values must be in the range [-n, n).
     * * 2: An {@link ANEURALNETWORKS_BOOL} scalar, keep_dims. If true,
     *      retains reduced dimensions with length 1.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0.
     *      If all dimensions are reduced and keep_dims is false, the output
     *      shape is [1].
     *
     * Available since NNAPI feature level 3.
     */
    REDUCE_SUM = 80,

    /**
     * Select and scale the feature map of each region of interest to a unified
     * output size by average pooling sampling points from bilinear interpolation.
     *
     * The region of interest is represented by its upper-left corner coordinate
     * (x1,y1) and lower-right corner coordinate (x2,y2) in the original image.
     * A spatial scaling factor is applied to map into feature map coordinate.
     * A valid region of interest should satisfy x1 <= x2 and y1 <= y2.
     *
     * No rounding is applied in this operation. The sampling points are unified
     * distributed in the pooling bin and their values are calculated by bilinear
     * interpolation.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: 4, with "NHWC" or "NCHW" data layout.
     * With the default data layout NHWC, the data is stored in the order of:
     * [batch, height, width, channels]. Alternatively, the data layout could
     * be NCHW, the data storage order of: [batch, channels, height, width].
     *
     * Inputs:
     * * 0: A 4-D tensor, specifying the feature map.
     * * 1: A 2-D Tensor of shape [num_rois, 4], specifying the locations of
     *      the regions of interest, each line with format [x1, y1, x2, y2].
     *      For input0 of type {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM},
     *      this tensor should be of {@link ANEURALNETWORKS_TENSOR_QUANT16_ASYMM},
     *      with zeroPoint of 0 and scale of 0.125. Zero num_rois is
     *      supported for this tensor.
     * * 2: An 1-D {@link ANEURALNETWORKS_TENSOR_INT32} tensor, of shape
     *      [num_rois], specifying the batch index of each box. Boxes with
     *      the same batch index are grouped together. Zero num_rois is
     *      supported for this tensor.
     * * 3: An {@link ANEURALNETWORKS_INT32} scalar, specifying the output
     *      height of the output tensor.
     * * 4: An {@link ANEURALNETWORKS_INT32} scalar, specifying the output
     *      width of the output tensor.
     * * 5: An {@link ANEURALNETWORKS_FLOAT32} scalar, specifying the ratio
     *      from the height of original image to the height of feature map.
     * * 6: An {@link ANEURALNETWORKS_FLOAT32} scalar, specifying the ratio
     *      from the width of original image to the width of feature map.
     * * 7: An {@link ANEURALNETWORKS_INT32} scalar, specifying the number of
     *      sampling points in height dimension used to compute the output.
     *      Set to 0 for adaptive value of ceil(roi_height/out_height).
     * * 8: An {@link ANEURALNETWORKS_INT32} scalar, specifying the number of
     *      sampling points in width dimension used to compute the output.
     *      Set to 0 for adaptive value of ceil(roi_width/out_width).
     * * 9: An {@link ANEURALNETWORKS_BOOL} scalar, set to true to specify
     *      NCHW data layout for input0 and output0. Set to false for NHWC.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0. The output
     *      shape is [num_rois, out_height, out_width, depth].
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint can be different from the input0 scale and zeroPoint.
     *
     * Available since NNAPI feature level 3.
     */
    ROI_ALIGN = 81,

    /**
     * Select and scale the feature map of each region of interest to a unified
     * output size by max-pooling.
     *
     * The region of interest is represented by its upper-left corner coordinate
     * (x1,y1) and lower-right corner coordinate (x2,y2) in the original image.
     * A spatial scaling factor is applied to map into feature map coordinate.
     * A valid region of interest should satisfy x1 <= x2 and y1 <= y2.
     *
     * Rounding is applied in this operation to ensure integer boundary for
     * regions of interest and pooling bins.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: 4, with "NHWC" or "NCHW" data layout.
     * With the default data layout NHWC, the data is stored in the order of:
     * [batch, height, width, channels]. Alternatively, the data layout could
     * be NCHW, the data storage order of: [batch, channels, height, width].
     *
     * Inputs:
     * * 0: A 4-D tensor, specifying the feature map.
     * * 1: A 2-D Tensor of shape [num_rois, 4], specifying the locations of
     *      the regions of interest, each line with format [x1, y1, x2, y2].
     *      For input0 of type {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      this tensor should be of {@link ANEURALNETWORKS_TENSOR_QUANT16_ASYMM},
     *      with zeroPoint of 0 and scale of 0.125.
     * * 2: An 1-D {@link ANEURALNETWORKS_TENSOR_INT32} tensor, of shape
     *      [num_rois], specifying the batch index of each box. Boxes with
     *      the same batch index are grouped together.
     * * 3: An {@link ANEURALNETWORKS_INT32} scalar, specifying the output
     *      height of the output tensor.
     * * 4: An {@link ANEURALNETWORKS_INT32} scalar, specifying the output
     *      width of the output tensor.
     * * 5: An {@link ANEURALNETWORKS_FLOAT32} scalar, specifying the ratio
     *      from the height of original image to the height of feature map.
     * * 6: An {@link ANEURALNETWORKS_FLOAT32} scalar, specifying the ratio
     *      from the width of original image to the width of feature map.
     * * 7: An {@link ANEURALNETWORKS_BOOL} scalar, set to true to specify
     *      NCHW data layout for input0 and output0. Set to false for NHWC.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0. The output
     *      shape is [num_rois, out_height, out_width, depth].
     *      For input0 of type {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 3.
     */
    ROI_POOLING = 82,

    /**
     * Computes reciprocal of square root of x element-wise.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} (since NNAPI feature level 7)
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 7)
     *
     * Supported tensor rank: from 1.
     *
     * Inputs:
     * * 0: A tensor.
     *
     * Outputs:
     * * 0: The output tensor of same shape as input0.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint can be different from inputs' scale and zeroPoint.
     *
     * Available since NNAPI feature level 3.
     */
    RSQRT = 83,

    /**
     * Using a tensor of booleans c and input tensors x and y select values
     * elementwise from both input tensors:
     *
     * O[i] = C[i] ? x[i] : y[i].
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1
     *
     * Inputs:
     * * 0: A tensor of type {@link ANEURALNETWORKS_TENSOR_BOOL8} acting as a
     *      mask that chooses, based on the value at each element, whether the
     *      corresponding element in the output should be taken from input1 (if
     *      true) or input2 (if false).
     * * 1: An input tensor of the same shape as input0.
     * * 2: An input tensor of the same shape and type as input1.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scales and zeroPoint can be different from input1 scale and zeroPoint.
     *
     * Outputs:
     * * 0: A tensor of the same type and shape as input1 and input2.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} tensor,
     *      the scale and zeroPoint can be different from inputs' scale and zeroPoint.
     *
     * Available since NNAPI feature level 3.
     */
    SELECT = 84,

    /**
     * Computes sin of x element-wise.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * Supported tensor rank: from 1.
     *
     * Inputs:
     * * 0: A tensor.
     *
     * Outputs:
     * * 0: The output tensor of same shape as input0.
     *
     * Available since NNAPI feature level 3.
     */
    SIN = 85,

    /**
     * Extracts a slice of specified size from the input tensor starting at a
     * specified location.
     *
     * The starting location is specified as a 1-D tensor containing offsets
     * for each dimension. The size is specified as a 1-D tensor containing
     * either size of a slice along corresponding dimension or -1. In the latter
     * case, all the remaining elements in dimension are included in the slice.
     *
     * A sum of begin offset and a size of a slice must not exceed size of a
     * corresponding dimension.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1
     *
     * Inputs:
     * * 0: An n-D tensor to take slice from, may be zero-sized.
     * * 1: A 1-D tensor of type {@link ANEURALNETWORKS_TENSOR_INT32} specifying
     *      the beginning indices of the slice in each dimension.
     * * 2: A 1-D tensor of type {@link ANEURALNETWORKS_TENSOR_INT32} specifying
     *      the size of the slice in each dimension.
     *
     * Outputs:
     * * 0: An n-D tensor of the same type as the input containing the slice.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      its scale and zeroPoint has to be same as the input0 scale and zeroPoint.
     *
     * Available since NNAPI feature level 3.
     */
    SLICE = 86,

    /**
     * Splits a tensor along a given axis into num_splits subtensors.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1
     *
     * Inputs:
     * * 0: An n-D tensor to split.
     * * 1: An {@link ANEURALNETWORKS_INT32} scalar specifying the axis along
     *      which to split.
     * * 2: An {@link ANEURALNETWORKS_INT32} scalar indicating the number of
     *      splits along given axis. Must evenly divide axis size.
     *
     * Outputs:
     * * 0 ~ (num_splits - 1): Resulting subtensors.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 3.
     */
    SPLIT = 87,

    /**
     * Computes square root of x element-wise.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * Supported tensor rank: from 1.
     *
     * Inputs:
     * * 0: A tensor.
     *
     * Outputs:
     * * 0: The output tensor of same shape as input0.
     *
     * Available since NNAPI feature level 3.
     */
    SQRT = 88,

    /**
     * Constructs a tensor by tiling a given tensor.
     *
     * This operation creates a new tensor by replicating `input` `multiples`
     * times. The output tensor's i-th dimension has `input.dims(i) * multiples[i]`
     * elements, and the values of `input` are replicated `multiples[i]` times
     * along the i-th dimension.
     * For example, tiling `[a b c d]` by `[2]` produces `[a b c d a b c d]`.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1
     *
     * Inputs:
     * * 0: input, an n-D tensor specifying the input.
     * * 1: multiples, a 1-D tensor of {@link ANEURALNETWORKS_TENSOR_INT32}.
     *      The length of multiples must be n.
     *
     * Outputs:
     * * 0: A tiled tensor of the same {@link OperandCode} and rank as `input`.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 3.
     */
    TILE = 89,

    /**
     * Finds values and indices of the k largest entries for the last dimension.
     *
     * Resulting values in each dimensions are sorted in descending order. If
     * two values are equal, the one with larger index appears first.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: from 1
     *
     * Inputs:
     * * 0: input, an n-D tensor specifying the input.
     * * 1: k, an {@link ANEURALNETWORKS_INT32} scalar, specifying the number of
     *      top elements to look for along the last dimension.
     *
     * Outputs:
     * * 0: An n-D tensor of the same type as the input, containing the k
     *      largest elements along each last dimensional slice.
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     * * 1: An n-D tensor of type {@link ANEURALNETWORKS_TENSOR_INT32}
     *      containing the indices of values within the last dimension of input.
     *
     * Available since NNAPI feature level 3.
     */
    TOPK_V2 = 90,

    /**
     * Performs the transpose of 2-D convolution operation.
     *
     * This operation is sometimes called "deconvolution" after Deconvolutional
     * Networks, but is actually the transpose (gradient) of
     * {@link ANEURALNETWORKS_CONV_2D} rather than an actual deconvolution.
     *
     * The output dimensions are functions of the filter dimensions, stride, and
     * padding.
     *
     * Supported tensor {@link OperandCode} configurations:
     * * 16 bit floating point:
     * * * {@link ANEURALNETWORKS_TENSOR_FLOAT16} for input, filter, output, and bias.
     *
     * * 32 bit floating point:
     * * * {@link ANEURALNETWORKS_TENSOR_FLOAT32} for input, filter, output, and bias.
     *
     * * Quantized:
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} for input, filter, and output.
     * * * {@link ANEURALNETWORKS_TENSOR_INT32} for bias (with scale set to
     * * * input.scale * filter.scale).
     *
     * * Quantized with symmetric per channel quantization for the filter:
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} for input, and output.
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL} for filter.
     * * * {@link ANEURALNETWORKS_TENSOR_INT32} for bias (scale set to 0.0,
     * * * each value scaling is separate and equal to input.scale * filter.scales[channel]).
     *
     * Available since NNAPI feature level 4:
     * * Quantized signed (since NNAPI feature level 4):
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} for input, filter, and output.
     * * * {@link ANEURALNETWORKS_TENSOR_INT32} for bias (with scale set to
     * * * input.scale * filter.scale).
     *
     * * Quantized signed with filter symmetric per channel quantization
     *   (since NNAPI feature level 4):
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} for input, and output.
     * * * {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL} for filter.
     * * * {@link ANEURALNETWORKS_TENSOR_INT32} for bias (scale set to 0.0,
     * * * each value scaling is separate and equal to input.scale * filter.scales[channel]).
     *
     * Supported tensor rank: 4, with "NHWC" or "NCHW" data layout.
     * With the default data layout NHWC, the data is stored in the order of:
     * [batch, height, width, channels]. Alternatively, the data layout could
     * be NCHW, the data storage order of: [batch, channels, height, width].
     *
     * Both explicit padding and implicit padding are supported.
     *
     * Inputs (explicit padding):
     * * 0: A 4-D tensor, of shape [batches, height, width, depth_in],
     *      specifying the input.
     *      Since API level 29, zero batches is supported for this tensor.
     * * 1: A 4-D tensor, of shape
     *      [depth_out, filter_height, filter_width, depth_in], specifying the
     *      filter. For tensor of type
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL} the channel
     *      dimension (ANeuralNetworksSymmPerChannelQuantParams::channelDim) must be set to 0.
     * * 2: A 1-D tensor, of shape [depth_out], specifying the bias. For input
     *      tensor of type {@link ANEURALNETWORKS_TENSOR_FLOAT32} or
     *      {@link ANEURALNETWORKS_TENSOR_FLOAT16}, the bias must be of the
     *      same type.
     *      For filter tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED},
     *      the bias should be of {@link ANEURALNETWORKS_TENSOR_INT32},
     *      with zeroPoint of 0 and bias_scale == input_scale * filter_scale.
     *      For filter tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL},
     *      the bias must be of {@link ANEURALNETWORKS_TENSOR_INT32}, with zeroPoint of 0
     *      and bias_scale of 0. The actual scale of each value 'i' is equal to
     *      bias_scale[i] = input_scale * filter_scale[i].
     * * 3: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the left, in the ‘width’ dimension.
     * * 4: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the right, in the ‘width’ dimension.
     * * 5: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the top, in the ‘height’ dimension.
     * * 6: An {@link ANEURALNETWORKS_INT32} scalar, specifying the padding on
     *      the bottom, in the ‘height’ dimension.
     * * 7: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘width’ dimension.
     * * 8: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘height’ dimension.
     * * 9: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *      {@link FuseCode} values. Specifies the activation to
     *      invoke on the result.
     * * 10: An {@link ANEURALNETWORKS_BOOL} scalar, set to true to specify
     *       NCHW data layout for input0 and output0. Set to false for NHWC.
     *
     * Inputs (implicit padding):
     * * 0: A 4-D tensor, of shape [batches, height, width, depth_in],
     *      specifying the input.
     *      Since API level 29, zero batches is supported for this tensor.
     * * 1: A 4-D tensor, of shape
     *      [depth_out, filter_height, filter_width, depth_in], specifying the
     *      filter. For tensor of type
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL} the channel
     *      dimension (ANeuralNetworksSymmPerChannelQuantParams::channelDim) must be set to 0.
     * * 2: A 1-D tensor, of shape [depth_out], specifying the bias. For input
     *      tensor of type {@link ANEURALNETWORKS_TENSOR_FLOAT32} or
     *      {@link ANEURALNETWORKS_TENSOR_FLOAT16}, the bias should be of the
     *      same type.
     *      For filter tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     *      and {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED},
     *      the bias should be of {@link ANEURALNETWORKS_TENSOR_INT32},
     *      with zeroPoint of 0 and bias_scale == input_scale * filter_scale.
     *      For filter tensor of {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL},
     *      the bias must be of {@link ANEURALNETWORKS_TENSOR_INT32}, with zeroPoint of 0
     *      and bias_scale of 0. The actual scale of each value 'i' is equal to
     *      bias_scale[i] = input_scale * filter_scale[i].
     * * 3: An {@link ANEURALNETWORKS_TENSOR_INT32} tensor, specifying the output
     *      tensor shape.
     * * 4: An {@link ANEURALNETWORKS_INT32} scalar, specifying the implicit
     *      padding scheme, has to be one of the
     *      {@link PaddingCode} values.
     * * 5: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘width’ dimension.
     * * 6: An {@link ANEURALNETWORKS_INT32} scalar, specifying the stride when
     *      walking through input in the ‘height’ dimension.
     * * 7: An {@link ANEURALNETWORKS_INT32} scalar, and has to be one of the
     *      {@link FuseCode} values. Specifies the activation to
     *      invoke on the result.
     * * 8: An {@link ANEURALNETWORKS_BOOL} scalar, set to true to specify
     *      NCHW data layout for input0 and output0. Set to false for NHWC.
     *
     * Outputs:
     * * 0: The output 4-D tensor, of shape
     *      [batches, out_height, out_width, depth_out].
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint can be different from inputs' scale and zeroPoint.
     *
     * Available since NNAPI feature level 3.
     */
    TRANSPOSE_CONV_2D = 91,

    /**
     * A recurrent neural network specified by an LSTM cell.
     *
     * Performs (fully) dynamic unrolling of input.
     *
     * This Op unrolls the input along the time dimension, and implements the
     * following operation for each element in the sequence
     * s = 1...sequence_length:
     *   outputs[s] = projection(state = activation(LSTMOp(inputs[s])))
     *
     * Where LSTMOp is the LSTM op as in {@link ANEURALNETWORKS_LSTM},
     * the "projection" is an optional projection layer from state and output
     * and the “activation” is the function passed as the
     * “fused_activation_function” argument (if not “NONE”).
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * Supported tensor rank: 3, either time-major or batch-major.
     *
     * All input and output tensors must be of the same type.
     *
     * Inputs:
     * * 0: The input (\f$x_t\f$).
     *      A 3-D tensor of shape:
     *        If time-major: [max_time, batch_size, input_size]
     *        If batch-major: [batch_size, max_time, input_size]
     *      where “max_time” is the number of timesteps (sequence length),
     *      “batch_size” corresponds to the batching dimension, and
     *      “input_size” is the size of the input.
     * * 1: The input-to-input weights (\f$W_{xi}\f$). Optional.
     *      A 2-D tensor of shape [num_units, input_size], where “num_units”
     *      corresponds to the number of cell units.
     * * 2: The input-to-forget weights (\f$W_{xf}\f$).
     *      A 2-D tensor of shape [num_units, input_size].
     * * 3: The input-to-cell weights (\f$W_{xc}\f$).
     *      A 2-D tensor of shape [num_units, input_size].
     * * 4: The input-to-output weights (\f$W_{xo}\f$).
     *      A 2-D tensor of shape [num_units, input_size].
     * * 5: The recurrent-to-input weights (\f$W_{hi}\f$). Optional.
     *      A 2-D tensor of shape [num_units, output_size], where “output_size”
     *      corresponds to either the number of cell units (i.e., “num_units”),
     *      or the second dimension of the “projection_weights”, if defined.
     * * 6: The recurrent-to-forget weights (\f$W_{hf}\f$).
     *      A 2-D tensor of shape [num_units, output_size].
     * * 7: The recurrent-to-cell weights (\f$W_{hc}\f$).
     *      A 2-D tensor of shape [num_units, output_size].
     * * 8: The recurrent-to-output weights (\f$W_{ho}\f$).
     *      A 2-D tensor of shape [num_units, output_size].
     * * 9: The cell-to-input weights (\f$W_{ci}\f$). Optional.
     *      A 1-D tensor of shape [num_units].
     * * 10:The cell-to-forget weights (\f$W_{cf}\f$). Optional.
     *      A 1-D tensor of shape [num_units].
     * * 11:The cell-to-output weights (\f$W_{co}\f$). Optional.
     *      A 1-D tensor of shape [num_units].
     * * 12:The input gate bias (\f$b_i\f$). Optional.
     *      A 1-D tensor of shape [num_units].
     * * 13:The forget gate bias (\f$b_f\f$).
     *      A 1-D tensor of shape [num_units].
     * * 14:The cell bias (\f$b_c\f$).
     *      A 1-D tensor of shape [num_units].
     * * 15:The output gate bias (\f$b_o\f$).
     *      A 1-D tensor of shape [num_units].
     * * 16:The projection weights (\f$W_{proj}\f$). Optional.
     *      A 2-D tensor of shape [output_size, num_units].
     * * 17:The projection bias (\f$b_{proj}\f$). Optional.
     *      A 1-D tensor of shape [output_size].
     * * 18:The output state (in) (\f$h_{t-1}\f$).
     *      A 2-D tensor of shape [batch_size, output_size].
     * * 19:The cell state (in) (\f$C_{t-1}\f$).
     *      A 2-D tensor of shape [batch_size, num_units].
     * * 20:The activation function (\f$g\f$).
     *      A value indicating the activation function:
     *      <ul>
     *      <li>0: None;
     *      <li>1: Relu;
     *      <li>3: Relu6;
     *      <li>4: Tanh;
     *      <li>6: Sigmoid.
     *      </ul>
     * * 21:The clipping threshold (\f$t_{cell}\f$) for the cell state, such
     *      that values are bound within [-cell_clip, cell_clip]. If set to 0.0
     *      then clipping is disabled.
     * * 22:The clipping threshold (\f$t_{proj}\f$) for the output from the
     *      projection layer, such that values are bound within
     *      [-proj_clip, proj_clip]. If set to 0.0 then clipping is disabled.
     * * 23:Time-major if true, batch-major if false.
     * * 24:The input layer normalization weights. Optional.
     *      A 1-D tensor of shape [num_units]. Used to rescale normalized inputs
     *      to activation at input gate.
     * * 25:The forget layer normalization weights. Optional.
     *      A 1-D tensor of shape [num_units]. Used to rescale normalized inputs
     *      to activation at forget gate.
     * * 26:The cell layer normalization weights. Optional.
     *      A 1-D tensor of shape [num_units]. Used to rescale normalized inputs
     *      to activation at cell gate.
     * * 27:The output layer normalization weights. Optional.
     *      A 1-D tensor of shape [num_units]. Used to rescale normalized inputs
     *      to activation at output gate.
     *
     * Outputs:
     * * 0: The output (\f$o_t\f$).
     *      A 3-D tensor of shape:
     *        If time-major: [max_time, batch_size, output_size]
     *        If batch-major: [batch_size, max_time, output_size]
     * * 1: A tensor of shape [batch_size, output_size] containing a hidden
     *      state from the last time step in the sequence. This output is
     *      optional and can be omitted. If this output is present then
     *      output #2 must be present as well.
     *      Available since NNAPI feature level 4.
     * * 2: A tensor of shape [batch_size, cell_size] containing a cell state
     *      from the last time step in the sequence. This output is optional
     *      and can be omitted.
     *      Available since NNAPI feature level 4.
     *
     * Available since NNAPI feature level 3.
     *
     * Important: As of NNAPI feature level 3, there is no way to get the output state tensors out
     * and NNAPI does not maintain internal states. This operator does not support the usage pattern
     * in which multiple cells are chained and state tensors are propagated.
     */
    UNIDIRECTIONAL_SEQUENCE_LSTM = 92,

    /**
     * A recurrent neural network layer that applies a basic RNN cell to a
     * sequence of inputs.
     *
     * This layer unrolls the input along the sequence dimension, and implements
     * the following operation
     * for each element in the sequence s = 1...sequence_length:
     *   outputs[s] = state = activation(inputs[s] * input_weights’ + state *
     *   recurrent_weights’ + bias)
     *
     * Where:
     * * “input_weights” is a weight matrix that multiplies the inputs;
     * * “recurrent_weights” is a weight matrix that multiplies the current
     *    “state” which itself is the output from the previous time step
     *    computation;
     * * “bias” is a bias vector (added to each output vector in the batch);
     * * “activation” is the function passed as the “fused_activation_function”
     *   argument (if not “NONE”).
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * The input tensors must all be the same type.
     *
     * Inputs:
     * * 0: input.
     *      A 3-D tensor. The shape is defined by the input 6 (timeMajor). If
     *      it is set to 1, then the input has a shape [maxTime, batchSize,
     *      inputSize], otherwise the input has a shape [batchSize, maxTime,
     *      inputSize].
     * * 1: weights.
     *      A 2-D tensor of shape [numUnits, inputSize].
     * * 2: recurrent_weights.
     *      A 2-D tensor of shape [numUnits, numUnits].
     * * 3: bias.
     *      A 1-D tensor of shape [numUnits].
     * * 4: hidden state
     *      A 2-D tensor of shape [batchSize, numUnits]. Specifies a hidden
     *      state input for the first time step of the computation.
     * * 5: fusedActivationFunction.
     *      A {@link FuseCode} value indicating the activation function. If
     *      “NONE” is specified then it results in a linear activation.
     * * 6: timeMajor
     *      An {@link ANEURALNETWORKS_INT32} scalar specifying the shape format
     *      of input and output tensors. Must be set to either 0 or 1.
     * Outputs:
     * * 0: output.
     *      A 3-D tensor. The shape is defined by the input 6 (timeMajor). If
     *      it is set to 1, then the output has a shape [maxTime, batchSize,
     *      numUnits], otherwise the output has a shape [batchSize, maxTime,
     *      numUnits].
     * * 1: A tensor of shape [batchSize, numUnits] containing hidden state
     *      from the last time step in the sequence. This output is optional
     *      and can be omitted.
     *      Available since NNAPI feature level 4.
     *
     * Available since NNAPI feature level 3.
     *
     * Important: As of NNAPI feature level 3, there is no way to get the output state tensors out
     * and NNAPI does not maintain internal states. This operator does not support the usage pattern
     * in which multiple cells are chained and state tensors are propagated.
     */
    UNIDIRECTIONAL_SEQUENCE_RNN = 93,

    /**
     * Resizes images to given size using the nearest neighbor interpretation.
     *
     * Resized images must be distorted if their output aspect ratio is not the
     * same as input aspect ratio. The corner pixels of output may not be the
     * same as corner pixels of input.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} (since NNAPI feature level 4)
     *
     * Supported tensor rank: 4, with "NHWC" or "NCHW" data layout.
     * With the default data layout NHWC, the data is stored in the order of:
     * [batch, height, width, channels]. Alternatively, the data layout could
     * be NCHW, the data storage order of: [batch, channels, height, width].
     *
     * Both resizing by shape and resizing by scale are supported.
     *
     * Inputs (resizing by shape):
     * * 0: A 4-D tensor, of shape [batches, height, width, depth], specifying
     *      the input. Zero batches is supported for this tensor.
     * * 1: An {@link ANEURALNETWORKS_INT32} scalar, specifying the output
     *      width of the output tensor.
     * * 2: An {@link ANEURALNETWORKS_INT32} scalar, specifying the output
     *      height of the output tensor.
     * * 3: An {@link ANEURALNETWORKS_BOOL} scalar, default to false.
     *      Set to true to specify NCHW data layout for input0 and output0.
     * * 4: Align corners. An optional {@link ANEURALNETWORKS_BOOL}
     *      scalar, default to false.  If True, the centers of the 4 corner
     *      pixels of the input and output tensors are aligned, preserving the
     *      values at the corner pixels.
     *      Available since NNAPI feature level 4.
     * * 5: Half pixel centers. An optional {@link ANEURALNETWORKS_BOOL}
     *      scalar, default to false. If True, the pixel centers are assumed to
     *      be at (0.5, 0.5). This is the default behavior of image.resize in
     *      TF 2.0. If this parameter is True, then align_corners parameter
     *      must be False.
     *      Available since NNAPI feature level 4.
     *
     * Inputs (resizing by scale):
     * * 0: A 4-D tensor, of shape [batches, height, width, depth], specifying
     *      the input. Zero batches is supported for this tensor.
     * * 1: A scalar, specifying width_scale, the scaling factor of the width
     *      dimension from the input tensor to the output tensor. The output
     *      width is calculated as new_width = floor(width * width_scale).
     *      The scalar must be of {@link ANEURALNETWORKS_FLOAT16} if input0 is
     *      of {@link ANEURALNETWORKS_TENSOR_FLOAT16} and of
     *      {@link ANEURALNETWORKS_FLOAT32} otherwise.
     * * 2: A scalar, specifying height_scale, the scaling factor of the height
     *      dimension from the input tensor to the output tensor. The output
     *      height is calculated as new_height = floor(height * height_scale).
     *      The scalar must be of {@link ANEURALNETWORKS_FLOAT16} if input0 is
     *      of {@link ANEURALNETWORKS_TENSOR_FLOAT16} and of
     *      {@link ANEURALNETWORKS_FLOAT32} otherwise.
     * * 3: An {@link ANEURALNETWORKS_BOOL} scalar, default to false.
     *      Set to true to specify NCHW data layout for input0 and output0.
     * * 4: Align corners. An optional {@link ANEURALNETWORKS_BOOL}
     *      scalar, default to false.  If True, the centers of the 4 corner
     *      pixels of the input and output tensors are aligned, preserving the
     *      values at the corner pixels.
     *      Available since NNAPI feature level 4.
     * * 5: Half pixel centers. An optional {@link ANEURALNETWORKS_BOOL}
     *      scalar, default to false. If True, the pixel centers are assumed to
     *      be at (0.5, 0.5). This is the default behavior of image.resize in
     *      TF 2.0. If this parameter is True, then align_corners parameter
     *      must be False.
     *      Available since NNAPI feature level 4.
     *
     * Outputs:
     * * 0: The output 4-D tensor, of shape
     *      [batches, new_height, new_width, depth].
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 3.
     */
    RESIZE_NEAREST_NEIGHBOR = 94,

    // Operations below are available since NNAPI feature level 4.

    /**
     * Quantized version of {@link ANEURALNETWORKS_LSTM}.
     *
     * The input and the output use asymmetric quantized types, while the rest
     * use symmetric ones.
     *
     * Inputs:
     * * 0: The input to the LSTM cell.
     *      Type: {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}
     *      Shape: [batchSize, inputSize]
     * * 1: The input-to-input weights. Optional.
     *      Type: {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM}
     *      Shape: [numUnits, inputSize]
     * * 2: The input-to-forget weights.
     *      Type: {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM}
     *      Shape: [numUnits, inputSize]
     * * 3: The input-to-cell weights.
     *      Type: {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM}
     *      Shape: [numUnits, inputSize]
     * * 4: The input-to-output weights.
     *      Type: {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM}
     *      Shape: [numUnits, inputSize]
     * * 5: The recurrent-to-input weights. Optional.
     *      Type: {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM}
     *      Shape: [numUnits, outputSize]
     * * 6: The recurrent-to-forget weights.
     *      Type: {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM}
     *      Shape: [numUnits, outputSize]
     * * 7: The recurrent-to-cell weights.
     *      Type: {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM}
     *      Shape: [numUnits, outputSize]
     * * 8: The recurrent-to-output weights.
     *      Type: {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM}
     *      Shape: [numUnits, outputSize]
     * * 9: The cell-to-input weights (for peephole). Optional.
     *      Type: {@link ANEURALNETWORKS_TENSOR_QUANT16_SYMM}
     *      Shape: [numUnits]
     * * 10: The cell-to-forget weights (for peephole). Optional.
     *       Type: {@link ANEURALNETWORKS_TENSOR_QUANT16_SYMM}
     *       Shape: [numUnits]
     * * 11: The cell-to-output weights (for peephole). Optional.
     *       Type: {@link ANEURALNETWORKS_TENSOR_QUANT16_SYMM}
     *       Shape: [numUnits]
     * * 12: The input gate bias. Quantized with scale being the
     *       product of input and weights scales and zeroPoint equal to 0.
     *       Optional.
     *       Type: {@link ANEURALNETWORKS_TENSOR_INT32}
     *       Shape: [numUnits]
     * * 13: The forget gate bias. Quantized with scale being the
     *       product of input and weights scales and zeroPoint equal to 0.
     *       Type: {@link ANEURALNETWORKS_TENSOR_INT32}
     *       Shape: [numUnits]
     * * 14: The cell bias. Quantized with scale being the
     *       product of input and weights scales and zeroPoint equal to 0.
     *       Type: {@link ANEURALNETWORKS_TENSOR_INT32}
     *       Shape: [numUnits]
     * * 15: The output gate bias. Quantized with scale being the
     *       product of input and weights scales and zeroPoint equal to 0.
     *       Type: {@link ANEURALNETWORKS_TENSOR_INT32}
     *       Shape: [numUnits]
     * * 16: The projection weights. Optional.
     *       Type: {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM}
     *       Shape: [outputSize, numUnits]
     * * 17: The projection bias. Quantized with scale being the
     *       product of input and weights scales and zeroPoint equal to 0.
     *       Optional.
     *       Type: {@link ANEURALNETWORKS_TENSOR_INT32}
     *       Shape: [outputSize]
     * * 18: The output from the previous time step.
     *       Type: {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}
     *       Shape: [batchSize, outputSize]
     * * 19: The cell state from the previous time step.
     *       Type: {@link ANEURALNETWORKS_TENSOR_QUANT16_SYMM}
     *       Shape: [batchSize, numUnits]
     * * 20: The input layer normalization weights. Used to rescale
     *       normalized inputs to activation at input gate. Optional.
     *       Type: {@link ANEURALNETWORKS_TENSOR_QUANT16_SYMM}
     *       Shape: [numUnits]
     * * 21: The forget layer normalization weights. Used to
     *       rescale normalized inputs to activation at forget gate. Optional.
     *       Type: {@link ANEURALNETWORKS_TENSOR_QUANT16_SYMM}
     *       Shape: [numUnits]
     * * 22: The cell layer normalization weights. Used to rescale
     *       normalized inputs to activation at cell gate. Optional.
     *       Type: {@link ANEURALNETWORKS_TENSOR_QUANT16_SYMM}
     *       Shape: [numUnits]
     * * 23: The output layer normalization weights. Used to
     *       rescale normalized inputs to activation at output gate. Optional.
     *       Type: {@link ANEURALNETWORKS_TENSOR_QUANT16_SYMM}
     *       Shape: [numUnits]
     * * 24: The cell clip. If provided the cell state is clipped
     *       by this value prior to the cell output activation. Optional.
     *       Type: {@link ANEURALNETWORKS_FLOAT32}.
     * * 25: The projection clip. If provided and projection is enabled,
     *       this is used for clipping the projected values. Optional.
     *       Type: {@link ANEURALNETWORKS_FLOAT32}.
     * * 26: The scale of the intermediate result of matmul,
     *       i.e. input to layer normalization, at input gate.
     *       Type: {@link ANEURALNETWORKS_FLOAT32}.
     * * 27: The scale of the intermediate result of matmul,
     *       i.e. input to layer normalization, at forget gate.
     *       Type: {@link ANEURALNETWORKS_FLOAT32}.
     * * 28: The scale of the intermediate result of matmul,
     *       i.e. input to layer normalization, at cell gate.
     *       Type: {@link ANEURALNETWORKS_FLOAT32}.
     * * 29: The scale of the intermediate result of matmul,
     *       i.e. input to layer normalization, at output gate.
     *       Type: {@link ANEURALNETWORKS_FLOAT32}.
     * * 30: The zero point of the hidden state, i.e. input to
     *       projection.
     *       Type: {@link ANEURALNETWORKS_INT32}.
     * * 31: The scale of the hidden state, i.e. input to
     *       projection.
     *       Type: {@link ANEURALNETWORKS_FLOAT32}.
     *
     * Outputs:
     * * 0: The output state (out).
     *      Type: {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}
     *      Shape: [batchSize, outputSize]
     * * 1: The cell state (out).
     *      Type: {@link ANEURALNETWORKS_TENSOR_QUANT16_SYMM}
     *      Shape: [batchSize, numUnits]
     * * 2: The output. This is effectively the same as the current
     *      "output state (out)" value.
     *      Type: {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}
     *      Shape: [batchSize, outputSize]
     *
     * Available since NNAPI feature level 4.
     */
    QUANTIZED_LSTM = 95,

    /**
     * Executes one of the two referenced models as determined by a boolean
     * value.
     *
     * The inputs and outputs of the two referenced models must agree with the
     * signature of this operation. That is, if the operation has (3 + n) inputs
     * and m outputs, both models must have n inputs and m outputs with the same
     * types, ranks (if specified), dimensions (if specified), scales,
     * zeroPoints, and other operand parameters as the corresponding operation
     * inputs and outputs.
     *
     * Inputs:
     * * 0: A value of type {@link ANEURALNETWORKS_TENSOR_BOOL8} and shape [1]
     *      that determines which of the two referenced models to execute.
     *      The operand must have fully specified dimensions.
     * * 1: A {@link ANEURALNETWORKS_MODEL} reference to the model to be
     *      executed if the condition is true.
     * * 2: A {@link ANEURALNETWORKS_MODEL} reference to the model to be
     *      executed if the condition is false.
     * * 3 ~ (n + 2): Inputs to be passed to the model selected for execution.
     *
     * Outputs:
     * * 0 ~ (m - 1): Outputs produced by the selected model.
     *
     * Available since NNAPI feature level 4.
     */
    IF = 96,

    /**
     * Executes the body model until the condition model outputs false.
     *
     * The inputs to this operation are the condition model, the body model,
     * and operand values for the first iteration of the loop. The values are
     * implicitly split into three groups of input-output, state-only, and
     * input-only values, as described below.
     *
     * The outputs of this operation are the final values of input-output
     * operands.
     *
     * Both the condition and body model receive (m + k + n) inputs.
     * * The first m (m >= 1) inputs are input-output operands. For the first
     *   iteration, these are initialized from the corresponding inputs of the
     *   WHILE operation. In subsequent iterations, their values come from the
     *   corresponding outputs of the body model produced during the previous
     *   iteration.
     * * The next k (k >= 0) inputs are state-only operands. They are similar to
     *   the input-output operands, except that their values are no longer
     *   available after the loop terminates.
     * * The last n (n >= 0) inputs are input-only operands. Their values come
     *   from the corresponding inputs of the WHILE operation.
     *
     * The body model produces (m + k) outputs.
     * * The first m outputs are input-output operands. They become the outputs
     *   of the WHILE operation when a termination condition is reached.
     * * The last k outputs are state-only operands. Their values are no longer
     *   available after the loop terminates.
     *
     * The numbers m, k, and n are inferred by the runtime as follows:
     *     m = (WHILE operation output count)
     *     k = (body model output count) - m
     *     n = (body model input count) - m - k
     *
     * The pseudo-code below illustrates the flow of a WHILE operation with
     * inputs condition, body, initial_input_output, initial_state, input_only
     * (m = 1, k = 1, n = 1):
     *
     *     input_output = initial_input_output
     *     state = initial_state
     *     while condition(input_output, state, input_only):
     *         input_output, state = body(input_output, state, input_only)
     *     return input_output
     *
     * To prevent infinite loops, there is an implicit execution timeout
     * associated with each loop ("loop timeout duration"). See {@link
     * ANeuralNetworksExecution_setLoopTimeout}.
     *
     * Inputs:
     * * 0: A {@link ANEURALNETWORKS_MODEL} reference to the condition
     *      model. The model must have (m + k + n) inputs with
     *      the same types, ranks (if specified), dimensions (if specified),
     *      scales, zeroPoints, and other operand parameters as the
     *      corresponding inputs of the WHILE operation and exactly one output
     *      of {@link ANEURALNETWORKS_TENSOR_BOOL8} and shape [1].
     *      The output operand must have fully specified dimensions.
     * * 1: A {@link ANEURALNETWORKS_MODEL} reference to the body model.
     *      The model must have (m + k + n) inputs and (m + k) outputs with
     *      the same types, ranks (if specified), dimensions (if specified),
     *      scales, zeroPoints, and other operand parameters as the
     *      corresponding inputs and outputs of the WHILE operation.
     * * (m inputs): Initial values for input-output operands.
     * * (k inputs): Initial values for state-only operands.
     * * (n inputs): Values for input-only operands.
     *
     * Outputs:
     * * 0 ~ (m - 1): Outputs produced by the loop.
     *
     * Available since NNAPI feature level 4.
     */
    WHILE = 97,

    /**
     * Computes exponential linear activation on the input tensor element-wise.
     *
     * The output is calculated using the following formula:
     *
     *     ELU(x) = max(0, x) + min(0, alpha * (exp(x) - 1))
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     *
     * Supported tensor rank: from 1.
     *
     * Inputs:
     * * 0: A tensor, specifying the input. May be zero-sized.
     * * 1: A scalar, specifying the alpha parameter.
     *      For input tensor of {@link ANEURALNETWORKS_TENSOR_FLOAT16},
     *      the alpha value must be of {@link ANEURALNETWORKS_FLOAT16}.
     *      For input tensor of {@link ANEURALNETWORKS_TENSOR_FLOAT32},
     *      the alpha value must be of {@link ANEURALNETWORKS_FLOAT32}.
     *
     * Outputs:
     * * 0: The output tensor of same shape and type as input0.
     *
     * Available since NNAPI feature level 4.
     */
    ELU = 98,

    /**
     * Computes hard-swish activation on the input tensor element-wise.
     *
     * Hard swish activation is introduced in
     * https://arxiv.org/pdf/1905.02244.pdf
     *
     * The output is calculated using the following formula:
     *
     *     h-swish(x) = x * max(0, min(6, (x + 3))) / 6
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}
     *
     * Supported tensor rank: from 1.
     *
     * Inputs:
     * * 0: A tensor, specifying the input. May be zero-sized.
     *
     * Outputs:
     * * 0: The output tensor of same shape and type as input0.
     *      Scale and zero point of this tensor may be different from the input
     *      tensor's parameters.
     *
     * Available since NNAPI feature level 4.
     */
    HARD_SWISH = 99,

    /**
     * Creates a tensor filled with a scalar value.
     *
     * Supported output tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     *
     * Supported tensor rank: from 1.
     *
     * Inputs:
     * * 0: A 1-D tensor, specifying the desired output tensor shape.
     * * 1: A scalar, specifying the value to fill the output tensors with.
     *      For output tensor of {@link ANEURALNETWORKS_TENSOR_FLOAT16},
     *      the scalar must be of {@link ANEURALNETWORKS_FLOAT16}.
     *      For output tensor of {@link ANEURALNETWORKS_TENSOR_FLOAT32},
     *      the scalar must be of {@link ANEURALNETWORKS_FLOAT32}.
     *      For output tensor of {@link ANEURALNETWORKS_TENSOR_INT32},
     *      the scalar must be of {@link ANEURALNETWORKS_INT32}.
     *
     * Outputs:
     * * 0: The output tensor.
     *
     * Available since NNAPI feature level 4.
     */
    FILL = 100,

    /**
     * Returns the rank of a tensor.
     *
     * The rank of a tensor is the number of dimensions in it. Also known as
     * "order", "degree", "ndims".
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT16_SYMM}
     * * {@link ANEURALNETWORKS_TENSOR_BOOL8}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT16_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}
     *
     * Supported tensor rank: from 1.
     *
     * Inputs:
     * * 0: The input tensor.
     *
     * Outputs:
     * * 0: A scalar of {@link ANEURALNETWORKS_INT32}, specifying the rank
     *      of the input tensor.
     *
     * Available since NNAPI feature level 4.
     */
    RANK = 101,

    // Operations below are available since NNAPI feature level 6.

    /**
     * Performs multiplication of two tensors in batches.
     *
     * Multiplies all slices of two input tensors and arranges the individual
     * results in a single output tensor of the same batch size. Each pair of
     * slices in the same batch have identical {@link OperandCode}. Each
     * slice can optionally be adjointed (transpose and conjugate) before
     * multiplication.
     *
     * The two input tensors and the output tensor must be 2-D or higher and
     * have the same batch size.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     *
     * Supported tensor rank: at least 2 and up to 4
     *
     * Inputs:
     * * 0: A tensor with 2-D or higher shape [..., r_x, c_x].
     * * 1: A tensor with 2-D or higher shape [..., r_y, c_y]. It has the same
     *      {@link OperandCode} and batch size as input0.
     * * 2: An optional {@link ANEURALNETWORKS_BOOL} scalar adj_x, default
     *      to false. Set to true to adjoint the slices of input0.
     * * 3: An optional {@link ANEURALNETWORKS_BOOL} scalar adj_y, default
     *      to false. Set to true to adjoint the slices of input1.
     *
     * Outputs:
     * * 0: A tensor with 2-D or higher shape [..., r_o, c_o], where
     *      r_o = c_x if adj_x else r_x
     *      c_o = r_y if adj_y else c_y
     *
     * Available since NNAPI feature level 6.
     */
    BATCH_MATMUL = 102,

    /**
     * Packs N input tensors (N >= 1) of rank R into one output tensor of rank R+1.
     * The tensors are packed along a given axis.
     *
     * The input tensors must have identical {@link OperandCode} and dimensions.
     *
     * For example, suppose there are N input tensors of shape (A, B, C).
     * If axis is 0, the output tensor will have shape (N, A, B, C).
     * If axis is 1, the output tensor will have shape (A, N, B, C).
     *
     * All dimensions through the axis dimension determine the output tile count;
     * the remaining dimensions determine the tile shape.
     *
     * Return to the example of N input tensors of shape (A, B, C).
     * If axis is 0, there are N tiles in the output, each of shape (A, B, C).
     * If axis is 1, there are A*N tiles in the output, each of shape (B, C).
     *
     * The coordinates of a tile within the output tensor are (t[0],...,t[axis]).
     * The coordinates of a tile within an input tensor are (t[0],...,t[axis-1]).
     * (If axis is 0, an input tensor consists of a single tile.)
     * If we index input tensors starting with 0 (rather than by operand number),
     * then output_tile[t[0],...,t[axis]] = input_tile[t[axis]][t[0],...,t[axis-1]].
     * That is, all output tile coordinates except for the axis coordinate select
     * the corresponding location within some input tensor; and the axis coordinate
     * selects the input tensor.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     *
     * Supported input tensor rank: from 1
     *
     * Inputs:
     * * 0: A scalar of type {@link ANEURALNETWORKS_INT32}, specifying
     *      the axis along which to pack.  The valid range is [0, R+1).
     * * 1 ~ N: Input tensors to be packed together.
     *          For {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *          {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensors,
     *          the scales and zeroPoint must be the same for all input tensors,
     *          and will be the same for the output tensor.
     *
     * Outputs:
     * * 0: The packed tensor.
     *
     * Available since NNAPI feature level 6.
     */
    PACK = 103,

    // Operations below are available since NNAPI feature level 7.

    /**
     * Pads a tensor with mirrored values.
     *
     * This operator specifies one of two padding modes: REFLECT or SYMMETRIC.
     * In the case of REFLECT mode, the mirroring excludes the border element
     * on the padding side.
     * In the case of SYMMETRIC mode, the mirroring includes the border element
     * on the padding side.
     *
     * For example, if the input is the 1-D tensor `[1, 2, 3]` and the padding
     * is `[0, 2]` (i.e., pad no elements before the first (and only) dimension,
     * and two elements after the first (and only) dimension), then:
     *     - REFLECT mode produces the output `[1, 2, 3, 2, 1]`
     *     - SYMMETRIC mode produces the output `[1, 2, 3, 3, 2]`
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     *
     * Supported tensor rank: from 1.
     *
     * Inputs:
     * * 0: An n-D tensor, specifying the tensor to be padded.
     * * 1: A 2-D tensor of {@link ANEURALNETWORKS_TENSOR_INT32}, the paddings
     *      for each spatial dimension of the input tensor. The shape of the
     *      tensor must be {rank(input0), 2}.
     *      padding[i, 0] specifies the number of elements to be padded in the
     *      front of dimension i.
     *      padding[i, 1] specifies the number of elements to be padded after the
     *      end of dimension i.
     *      Each padding value must be nonnegative.
     *      In the case of REFLECT mode, each padding value must be less than the
     *      corresponding dimension.
     *      In the case of SYMMETRIC mode, each padding value must be less than or
     *      equal to the corresponding dimension.
     * * 2: An {@link ANEURALNETWORKS_INT32} scalar, specifying the mode.
     *      Options are 0:REFLECT and 1:SYMMETRIC.
     *
     * Outputs:
     * * 0: A tensor of the same {@link OperandCode} as input0. The
     *      output tensor has the same rank as input0, and each
     *      dimension of the output tensor has the same size as the
     *      corresponding dimension of the input tensor plus the size
     *      of the padding:
     *          output0.dimension[i] =
     *              padding[i, 0] + input0.dimension[i] + padding[i, 1]
     *      For a {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensor,
     *      the scale and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 7.
     */
    MIRROR_PAD = 104,

    /**
     * Reverses a specified dimension of a tensor.
     *
     * Supported tensor {@link OperandCode}:
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT16}
     * * {@link ANEURALNETWORKS_TENSOR_FLOAT32}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM}
     * * {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED}
     * * {@link ANEURALNETWORKS_TENSOR_INT32}
     *
     * Supported tensor rank: up to 8.
     *
     * Inputs:
     * * 0: Input tensor of rank n.
     * * 1: Axis tensor of type {@link ANEURALNETWORKS_TENSOR_INT32} and shape [1],
     *      specifying which dimension of the input tensor is to be reversed. The dimension
     *      must be in the range [0, n).
     *
     * Outputs:
     * * 0: The reversed tensor of the same shape as the input tensor.
     *      For {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM} and
     *      {@link ANEURALNETWORKS_TENSOR_QUANT8_ASYMM_SIGNED} tensors,
     *      the scales and zeroPoint must be the same as input0.
     *
     * Available since NNAPI feature level 7.
     */
    REVERSE = 105,
}

/**
 * Fused activation function types.
 *
 * Available since NNAPI feature level 1.
 */
FuseCode :: enum {
    /** NO fused activation function. */
    NONE = 0,
    /** Fused ReLU activation function. */
    RELU = 1,
    /** Fused ReLU1 activation function. */
    RELU1 = 2,
    /** Fused ReLU6 activation function. */
    RELU6 = 3,
}

/**
 * Implicit padding algorithms.
 *
 *
 * Available since NNAPI feature level 1.
 */
PaddingCode :: enum {
    /**
     * SAME padding.
     * Padding on both ends are the "same":
     *     padding_to_beginning =  total_padding / 2
     *     padding_to_end       = (total_padding + 1)/2.
     * i.e., for even number of padding, padding to both ends are exactly
     * the same; for odd number of padding, padding to the ending is bigger
     * than the padding to the beginning by 1.
     *
     * total_padding is a function of input, stride, dilation and filter size.
     * It could be computed as follows:
     *    out_size = (input + stride - 1) / stride
     *    effective_filter_size = (filter_size - 1) * dilation + 1
     *    needed_input = (out_size - 1) * stride + effective_filter_size
     *    total_padding = max(0, needed_input - input_size)
     *  The computation is the same for the horizontal and vertical directions.
     */
    SAME = 1,

    /**
     * VALID padding.
     * No padding. When the input size is not evenly divisible by
     * the filter size, the input at the end that could not fill
     * the whole filter tile will simply be ignored.
     */
    VALID = 2,
}

/**
 * Execution preferences.
 *
 * Available since NNAPI feature level 1.
 */
PreferenceCode :: enum i32 {
    /**
     * Prefer executing in a way that minimizes battery drain.
     * This is desirable for compilations that will be executed often.
     */
    PREFER_LOW_POWER = 0,
    /**
     * Prefer returning a single answer as fast as possible, even if this causes
     * more power consumption.
     */
    PREFER_FAST_SINGLE_ANSWER = 1,
    /**
     * Prefer maximizing the throughput of successive frames, for example when
     * processing successive frames coming from the camera.
     */
    PREFER_SUSTAINED_SPEED = 2,
}

/**
 * Device types.
 *
 * The type of NNAPI device.
 */
DeviceTypeCode :: enum i32 {
    /** The device type cannot be provided. */
    UNKNOWN = 0,
    /** The device does not fall into any category below. */
    OTHER = 1,
    /** The device runs NNAPI models on single or multi-core CPU. */
    CPU = 2,
    /** The device can run NNAPI models and also accelerate graphics APIs such
     * as OpenGL ES and Vulkan. */
    GPU = 3,
    /** Dedicated accelerator for Machine Learning workloads. */
    ACCELERATOR = 4,
}

/**
 * NNAPI feature levels.
 *
 * Each update of the NNAPI specification yields a new NNAPI feature level enum value.
 * NNAPI feature level corrseponds to an NNAPI specification version that a driver
 * and/or the NNAPI runtime can implement.
 *
 * A feature level up to and including "FEATURE_LEVEL_5" maps directly to
 * the Android API level that introduced the corresponding update of the NNAPI
 * specification. Feature levels after Android API level 31 have no association with
 * API level because the NNAPI specification can be updated between Android API
 * releases. Outputs of {@link ANeuralNetworksDevice_getFeatureLevel} and
 * {@link ANeuralNetworks_getRuntimeFeatureLevel} must be compared against
 * these enum values instead of the Android API level.
 */
FeatureLevelCode :: enum i64 {
    /** NNAPI specification available in Android O-MR1, Android NNAPI feature level 1 */
    LEVEL_1 = 27,
    /** NNAPI specification available in Android P, Android NNAPI feature level 2 */
    LEVEL_2 = 28,
    /** NNAPI specification available in Android Q, Android NNAPI feature level 3 */
    LEVEL_3 = 29,
    /** NNAPI specification available in Android R, Android NNAPI feature level 4 */
    LEVEL_4 = 30,
    /**
     * NNAPI specification available in Android S, Android NNAPI feature level 5.
     * After Android S, the NNAPI specification can be updated between Android
     * API releases.
     */
    LEVEL_5 = 31,
    /** Android NNAPI feature level 6 */
    LEVEL_6 = 1000006,
    /** Android NNAPI feature level 7 */
    LEVEL_7 = 1000007,
    /** Android NNAPI feature level 8 */
    LEVEL_8 = 1000008,
}

/**
 * Result codes.
 *
 * <p>Any NNAPI function can return any result code, including result codes not
 * currently documented. Any value other than {@link ANEURALNETWORKS_NO_ERROR}
 * indicates a failure of some kind.</p>
 *
 * <p>Additional information about the nature of a failure can be obtained from
 * the device log after enabling NNAPI debugging by setting the debug.nn.vlog
 * property to 1, e.g., by calling "adb shell setprop debug.nn.vlog 1".</p>
 *
 * Available since NNAPI feature level 1.
 */
NNResultCode :: enum i32 {
    /**
     * Operation was successful.
     */
    NO_ERROR = 0,

    /**
     * Failure caused by not enough available memory.
     */
    OUT_OF_MEMORY = 1,

    INCOMPLETE = 2,

    /**
     * Failure caused by unexpected null argument.
     */
    UNEXPECTED_NULL = 3,

    /**
     * Failure caused by invalid function arguments, invalid model definition,
     * invalid execution definition or invalid data at execution time.
     */
    BAD_DATA = 4,

    /**
     * Failure caused by failed model execution.
     */
    OP_FAILED = 5,

    /**
     * Failure caused by object being in the wrong state.
     */
    BAD_STATE = 6,

    /**
     * Failure caused by not being able to map a file into memory.
     * This may be caused by a file descriptor not being mappable, or an AHardwareBuffer
     * not supported by the device.
     * Mitigate by reading its content into memory.
     */
    UNMAPPABLE = 7,

    /**
     * Failure caused by insufficient buffer size provided to a model output.
     */
    OUTPUT_INSUFFICIENT_SIZE = 8,

    /**
     * Failure caused by a device not being available.
     */
    UNAVAILABLE_DEVICE = 9,

    /**
     * Failure because a deadline could not be met for a task, but future
     * deadlines may still be met for the same task after a short delay.
     *
     * Available since NNAPI feature level 4.
     */
    MISSED_DEADLINE_TRANSIENT = 10,

    /**
     * Failure because a deadline could not be met for a task, and future
     * deadlines will likely also not be met for the same task even after a
     * short delay.
     *
     * Available since NNAPI feature level 4.
     */
    MISSED_DEADLINE_PERSISTENT = 11,

    /**
     * Failure because of a resource limitation within the driver, but future
     * calls for the same task may still succeed after a short delay.
     *
     * Available since NNAPI feature level 4.
     */
    RESOURCE_EXHAUSTED_TRANSIENT = 12,

    /**
     * Failure because of a resource limitation within the driver, and future
     * calls for the same task will likely also fail even after a short
     * delay.
     *
     * Available since NNAPI feature level 4.
     */
    RESOURCE_EXHAUSTED_PERSISTENT = 13,

    /**
     * Failure indicating an object is in a dead state.
     *
     * Available since NNAPI feature level 4.
     */
    DEAD_OBJECT = 14,
}

/**
 * Different duration measurements.
 *
 * Durations are measured in nanoseconds.
 *
 * Available since NNAPI feature level 3.
 */
DurationCode :: enum i32 {
    // Execution time on hardware (not driver, which runs on host processor).
    DURATION_ON_HARDWARE = 0,
    // Execution time in driver (including time on hardware).  Excludes overhead
    // such as that of the runtime itself and the IPC needed for the runtime to
    // communicate with the driver.
    DURATION_IN_DRIVER = 1,
    // Execution time on hardware, after all dependencies have been signaled.
    // If no dependencies specified (for example, if the execution was scheduled other
    // than with {@link ANeuralNetworksExecution_startComputeWithDependencies}), the
    // reported time will be the same as ANEURALNETWORKS_DURATION_ON_HARDWARE.
    // Available since NNAPI feature level 4.
    FENCED_DURATION_ON_HARDWARE = 2,
    // Execution time in driver, after all dependencies have been signaled. Excludes
    // overhead such as that of the runtime itself and the IPC needed for the runtime
    // to communicate with the driver.
    // If no dependencies specified (for example, if the execution was scheduled other
    // than with {@link ANeuralNetworksExecution_startComputeWithDependencies}), the
    // reported time will be the same as ANEURALNETWORKS_DURATION_IN_DRIVER.
    // Available since NNAPI feature level 4.
    FENCED_DURATION_IN_DRIVER = 3,
}

/**
 * Relative execution priority.
 *
 * Available since NNAPI feature level 4.
 */
PriorityCode :: enum i32 {
    LOW = 90,
    MEDIUM = 100,
    HIGH = 110,
    DEFAULT = MEDIUM,
}

/**
 * ANeuralNetworksMemory is an opaque type that represents memory.
 *
 * This type is used to represent shared memory, memory mapped files,
 * and similar memories.
 *
 * By using shared memory, a program can efficiently communicate to the
 * runtime and drivers the tensors that define a model. See
 * {@link ANeuralNetworksModel_setOperandValueFromMemory}. An application
 * should typically create one shared memory object that contains every constant tensor
 * needed to define a model. {@link ANeuralNetworksMemory_createFromFd} can be used to
 * create shared memory from a file handle.
 * {@link ANeuralNetworksMemory_createFromAHardwareBuffer} can be used to
 * create shared memory from an AHardwareBuffer handle.
 *
 * Memory objects can also be used to specify the input and output arguments of
 * an execution. See {@link ANeuralNetworksExecution_setInputFromMemory}
 * and {@link ANeuralNetworksExecution_setOutputFromMemory}.
 *
 * When calling {@link ANeuralNetworksModel_setOperandValueFromMemory},
 * {@link ANeuralNetworksExecution_setInputFromMemory} and
 * {@link ANeuralNetworksExecution_setOutputFromMemory}, each operand in the shared
 * memory object must be aligned on a boundary of a byte size that is a multiple
 * of the element type byte size, e.g., a tensor with
 * {@link ANEURALNETWORKS_TENSOR_FLOAT32} type must be aligned on 4-byte boundary.
 *
 * It is the application's responsibility to ensure that there are no uses of
 * the memory after calling {@link ANeuralNetworksMemory_free}. This includes
 * any model which references this memory because of a call to
 * {@link ANeuralNetworksModel_setOperandValueFromMemory}, any compilation
 * created using such a model, any execution object or burst object created
 * using such a compilation, or any execution which references this memory
 * because of a call to {@link ANeuralNetworksExecution_setInputFromMemory} or
 * {@link ANeuralNetworksExecution_setOutputFromMemory}.
 *
 * Available since NNAPI feature level 1.
 *
 * Starting at NNAPI feature level 4, the application may request creation of device native memory
 * from {@link ANeuralNetworksMemoryDesc} to avoid potential memory copying and transformation
 * overhead between executions. See also {@link ANeuralNetworksMemoryDesc} and
 * {@link ANeuralNetworksMemory_createFromDesc}.
 */
ANeuralNetworksMemory :: struct{}

/**
 * ANeuralNetworksModel is an opaque type that contains a description of the
 * mathematical operations that constitute the model.
 *
 * <p>Build the model by calling<ul>
 * <li>{@link ANeuralNetworksModel_create}</li>
 * <li>{@link ANeuralNetworksModel_addOperation}</li>
 * <li>{@link ANeuralNetworksModel_addOperand}</li>
 * </ul>
 *
 * This forms a graph in which each operation and operand is a node, a
 * directed edge from an operand to an operation indicates that the
 * operand is an input to the operation, and a directed edge from an
 * operation to an operand indicates that the operand is an output
 * from the operation. This graph must be acyclic.
 *
 * A model is completed by calling {@link ANeuralNetworksModel_finish}.
 * A model is destroyed by calling {@link ANeuralNetworksModel_free}.
 *
 * <p>A model cannot be modified once {@link ANeuralNetworksModel_finish}
 * has been called on it.</p>
 *
 * <p>It is the application's responsibility to make sure that only one thread
 * modifies a model at a given time. It is however safe for more than one
 * thread to use the model once {@link ANeuralNetworksModel_finish} has returned.</p>
 *
 * <p>It is also the application's responsibility to ensure that there are no
 * other uses of the model after calling {@link ANeuralNetworksModel_free}.
 * This includes any compilation, execution object or burst object created using
 * the model.</p>
 *
 * Available since NNAPI feature level 1.
 */
ANeuralNetworksModel :: struct{}

/**
 * ANeuralNetworksCompilation is an opaque type that can be used to compile
 * a machine learning model.
 *
 * <p>To use:<ul>
 *    <li>Create a new compilation instance by calling the
 *        {@link ANeuralNetworksCompilation_create} function or
 *        {@link ANeuralNetworksCompilation_createForDevices}.</li>
 *    <li>Set any desired properties on the compilation (for example,
 *        {@link ANeuralNetworksCompilation_setPreference}).</li>
 *    <li>Optionally, set the caching signature and the cache directory on the
 *        compilation by calling {@link ANeuralNetworksCompilation_setCaching}.</li>
 *    <li>Complete the compilation with {@link ANeuralNetworksCompilation_finish}.</li>
 *    <li>Use the compilation as many times as needed
 *        with {@link ANeuralNetworksExecution_create} and
 *        {@link ANeuralNetworksBurst_create}.</li>
 *    <li>Destroy the compilation with {@link ANeuralNetworksCompilation_free}
 *        once all executions using the compilation have completed.</li></ul></p>
 *
 * A compilation is completed by calling {@link ANeuralNetworksCompilation_finish}.
 * A compilation is destroyed by calling {@link ANeuralNetworksCompilation_free}.
 *
 * <p>A compilation cannot be modified once {@link ANeuralNetworksCompilation_finish}
 * has been called on it.</p>
 *
 * <p>It is the application's responsibility to make sure that only
 * one thread modifies a compilation at a given time. It is however
 * safe for more than one thread to use the compilation once
 * {@link ANeuralNetworksCompilation_finish} has returned.</p>
 *
 * <p>It is also the application's responsibility to ensure that there are no other
 * uses of the compilation after calling {@link ANeuralNetworksCompilation_free}.
 * This includes any execution object or burst object created using the compilation,
 * or any memory descriptor with the compilation as part of one of the roles specified by
 * {@link ANeuralNetworksMemoryDesc_addInputRole} or
 * {@link ANeuralNetworksMemoryDesc_addOutputRole}.</p>
 *
 * Available since NNAPI feature level 1.
 */
ANeuralNetworksCompilation :: struct{}

/**
 * ANeuralNetworksExecution is an opaque type that can be used to apply a machine
 * learning model to a set of inputs.
 *
 * <p>To use:<ul>
 *    <li>Create a new execution instance by calling the
 *        {@link ANeuralNetworksExecution_create} function.</li>
 *    <li>Associate input buffers or memory regions to the model inputs with
 *        {@link ANeuralNetworksExecution_setInput} or
 *        {@link ANeuralNetworksExecution_setInputFromMemory}.</li>
 *    <li>Associate output buffers or memory regions to the model outputs with
 *        {@link ANeuralNetworksExecution_setOutput} or
 *        {@link ANeuralNetworksExecution_setOutputFromMemory}.</li>
 *    <li>Optionally, configure the execution with
 *        {@link ANeuralNetworksExecution_setLoopTimeout},
 *        {@link ANeuralNetworksExecution_setMeasureTiming},
 *        {@link ANeuralNetworksExecution_setReusable}, or
 *        {@link ANeuralNetworksExecution_setTimeout}.
 *    <li>Apply the model with one of the following:</li><ul>
 *        <li>Asynchronously with {@link ANeuralNetworksExecution_startCompute}
 *            or with {@link ANeuralNetworksExecution_startComputeWithDependencies},
 *            waiting for the execution to complete with
 *            {@link ANeuralNetworksEvent_wait}.</li>
 *        <li>Synchronously with {@link ANeuralNetworksExecution_compute}.</li>
 *        <li>Synchronously as part of an execution burst with
 *            {@link ANeuralNetworksExecution_burstCompute}.</li></ul>
 *        If the execution has been marked as reusable, then you can
 *        apply the model more than once.
 *    <li>Destroy the execution with
 *        {@link ANeuralNetworksExecution_free}.</li></ul></p>
 *
 * <p>An output buffer or memory region must not overlap with any
 * other output buffer or memory region, with an input buffer or
 * memory region, or with an operand value in a memory object
 * ({@link ANeuralNetworksModel_setOperandValueFromMemory}).</p>
 *
 * <p>An execution is in the preparation state after it is created by
 * {@link ANeuralNetworksExecution_create}. An execution may only be modified in the preparation
 * state. Scheduling a computation by calling {@link ANeuralNetworksExecution_burstCompute},
 * {@link ANeuralNetworksExecution_compute}, {@link ANeuralNetworksExecution_startCompute},
 * or {@link ANeuralNetworksExecution_startComputeWithDependencies} will change the state of
 * the execution object to the computation state. When the computation completes, the state of
 * the execution object will change from the computation state to the completed state.
 * The computation is completed when {@link ANeuralNetworksExecution_compute},
 * {@link ANeuralNetworksExecution_burstCompute}, or {@link ANeuralNetworksEvent_wait}
 * has returned.</p>
 *
 * <p>An execution can be applied to a model with
 * {@link ANeuralNetworksExecution_burstCompute},
 * {@link ANeuralNetworksExecution_compute},
 * {@link ANeuralNetworksExecution_startCompute} or
 * {@link ANeuralNetworksExecution_startComputeWithDependencies} only once. Create new
 * executions to do new evaluations of the model.</p>
 *
 * <p>Starting at NNAPI feature level 5, the application may call
 * {@link ANeuralNetworksExecution_setReusable} to set an execution to be reusable for multiple
 * computations. The application may schedule and evaluate a computation again from the completed
 * state of a reusable execution. The execution cannot be modified between computations.</p>
 *
 * <p>It is the application's responsibility to make sure that only one thread
 * modifies an execution at a given time. It is however safe for more than one
 * thread to use {@link ANeuralNetworksEvent_wait} at the same time.</p>
 *
 * <p>It is also the application's responsibility to ensure that the execution
 * either has never been scheduled or has completed (i.e., that
 * {@link ANeuralNetworksExecution_burstCompute},
 * {@link ANeuralNetworksExecution_compute}, or
 * {@link ANeuralNetworksEvent_wait} has returned) before calling
 * {@link ANeuralNetworksExecution_free}.</p>.
 *
 * <p>It is also the application's responsibility to ensure that there are no other
 * uses of the execution after calling {@link ANeuralNetworksExecution_free}.</p>
 *
 * <p>It is the application's responsibility to ensure that there are no concurrent computations
 * scheduled and evaluated on the same execution, either by means of
 * {@link ANeuralNetworksExecution_compute} or
 * {@link ANeuralNetworksExecution_burstCompute} (which are synchronous)
 * in different threads, or by means of
 * {@link ANeuralNetworksExecution_startCompute} or
 * {@link ANeuralNetworksExecution_startComputeWithDependencies} (which are asynchronous).
 * It is however safe to schedule and evaluate multiple computations on different executions
 * concurrently. (Concurrent uses of {@link ANeuralNetworksExecution_burstCompute} must be on
 * different burst objects.) The runtime makes no guarantee on the ordering of
 * completion of executions. If it's important to the application, the
 * application should enforce the ordering by ensuring that one execution
 * completes before the next is scheduled (for example, by scheduling all
 * executions synchronously within a single thread, or by scheduling all
 * executions asynchronously and using {@link ANeuralNetworksEvent_wait} between
 * calls to {@link ANeuralNetworksExecution_startCompute}); or by using
 * {@link ANeuralNetworksExecution_startComputeWithDependencies} to make the execution wait for a
 * list of events to be signaled before starting the actual evaluation.</p>
 *
 * Available since NNAPI feature level 1.
 */
ANeuralNetworksExecution :: struct{}

/**
 * Parameters for ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL operand.
 */
ANeuralNetworksSymmPerChannelQuantParams :: struct {
    /** The index of the channel dimension. */
	channelDim: u32,
    /** The size of the scale array. Should be equal to dimension[channelDim] of the Operand. */
    scaleCount: u32,
    /** The array of scaling values for each channel. Each value must be greater than zero. */
    scales: [^]f32,
}

/**
 * ANeuralNetworksBurst is an opaque type that can be used to reduce the latency
 * of a rapid sequence of executions. It will likely cause overhead if only used
 * for a single execution.
 *
 * ANeuralNetworksBurst serves as a context object for any number of inferences
 * using {@link ANeuralNetworksExecution} objects. An ANeuralNetworksBurst
 * object and the {@link ANeuralNetworksExecution} objects used with it must all
 * have been created from the same {@link ANeuralNetworksCompilation} object.
 *
 * This object is also used as a hint to drivers, providing insight to the
 * lifetime of a rapid sequence of executions. For example, a driver may choose
 * to increase the clock frequency of its accelerator for the lifetime of a
 * burst object.
 *
 * <p>To use:<ul>
 *    <li>Create a new burst object by calling the
 *        {@link ANeuralNetworksBurst_create} function.</li>
 *    <li>For each execution:</li><ul>
 *        <li>Create {@link ANeuralNetworksExecution} and configure its
 *            properties (see {@link ANeuralNetworksExecution} for details).</li>
 *        <li>Apply the model synchronously with
 *            {@link ANeuralNetworksExecution_burstCompute}, reusing the same
 *            {@link ANeuralNetworksBurst} with the new
 *            {@link ANeuralNetworksExecution}.</li>
 *        <li>Use and free the {@link ANeuralNetworksExecution}.</li></ul>
 *    <li>Destroy the burst with
 *        {@link ANeuralNetworksBurst_free}.</li></ul></p>
 *
 * Available since NNAPI feature level 3.
 */
ANeuralNetworksBurst :: struct{}

/**
 * ANeuralNetworksOperandType describes the type of an operand.
 *
 * This structure is used to describe both scalars and tensors.
 *
 * A tensor operand type with all dimensions specified is "fully
 * specified".  Whenever possible (i.e., whenever the dimensions are
 * known at model construction time), a tensor operand type should be
 * (but is not required to be) fully specified, in order to enable the
 * best possible performance.
 *
 * If a tensor operand's type is not fully specified, the dimensions
 * of the operand are deduced from the operand types and values of the
 * operation for which that operand is an output or from the corresponding
 * {@link ANEURALNETWORKS_IF} or {@link ANEURALNETWORKS_WHILE} operation input
 * operand type in the case of referenced model input operands.
 *
 * <p>In the following situations, a tensor operand type must be fully
 * specified:<ul>
 *     <li>The operand has a constant value, set by
 *         {@link ANeuralNetworksModel_setOperandValue} (with a
 *         non-nullptr buffer) or
 *         {@link ANeuralNetworksModel_setOperandValueFromMemory}.</li>
 *     <li>The operand is a model input (see
 *         {@link ANeuralNetworksModel_identifyInputsAndOutputs}) of the main
 *         model within a compilation.  A fully specified tensor operand type
 *         must either be provided to {@link ANeuralNetworksModel_addOperand};
 *         or it must be provided to the corresponding
 *         {@link ANeuralNetworksExecution_setInput}, or
 *         {@link ANeuralNetworksExecution_setInputFromMemory}.
 *         EXCEPTION: If the input is optional and omitted
 *         (by passing nullptr for buffer to
 *         {@link ANeuralNetworksExecution_setInput}) then it need
 *         not have a fully specified tensor operand type.</li>
 *     <li>The operand is a model output (see
 *         {@link ANeuralNetworksModel_identifyInputsAndOutputs}) of the main
 *         model within a compilation and is to be used with {@link
 *         ANeuralNetworksExecution_startComputeWithDependencies}.
 *         A fully specified tensor operand type must either be provided
 *         to {@link ANeuralNetworksModel_addOperand}; or it must be
 *         provided to the corresponding
 *         {@link ANeuralNetworksExecution_setOutput}, or
 *         {@link ANeuralNetworksExecution_setOutputFromMemory}.</li></ul>
 *
 * A tensor operand type of specified rank but some number of
 * unspecified dimensions is represented by setting dimensionCount to
 * the rank and each unspecified dimension to 0.
 *
 * Available since NNAPI feature level 1.
 *
 * Starting at NNAPI feature level 3, a tensor operand type of unspecified rank is
 * represented by setting dimensionCount to 0 and dimensions to NULL (just as if
 * it were a scalar operand type).
 */
ANeuralNetworksOperandType :: struct {
    /**
     * The data type, e.g ANEURALNETWORKS_FLOAT32.
     */
	type: OperandCode,

    /**
     * The number of dimensions (rank).
     *
     * Must be 0 for scalars.
     */
    dimensionCount: u32,

    /**
     * The dimensions of the tensor.
     *
     * Must be nullptr for scalars.
     */
    dimensions: [^]u32,

    /**
     * The quantization scale.
     *
     * Must be 0 when not applicable to an operand type.
     *
     * See {@link OperandCode}.
     */
    scale: f32,

    /**
     * The quantization zero point.
     *
     * Must be 0 when not applicable to an operand type.
     *
     * See {@link OperandCode}.
     */
    zeroPoint: i32,
}

/**
 * ANeuralNetworksEvent is an opaque type that represents an event
 * that will be signaled once an execution completes.
 *
 * Available since NNAPI feature level 1.
 */
ANeuralNetworksEvent :: struct{}

/**
 * ANeuralNetworksDevice is an opaque type that represents a device.
 *
 * This type is used to query basic properties and supported operations of the corresponding
 * device, and control which device(s) a model is to be run on.
 *
 * Available since NNAPI feature level 3.
 */
ANeuralNetworksDevice :: struct{}

/**
 * ANeuralNetworksMemoryDesc is an opaque type that represents a memory descriptor.
 *
 * A memory descriptor describes the properties of a memory object, and is used by
 * {@link ANeuralNetworksMemory_createFromDesc}.
 *
 * To use:
 *   - Create a new memory descriptor by calling {@link ANeuralNetworksMemoryDesc_create}.
 *   - Specify all of the intended input and output roles by calling
 *     {@link ANeuralNetworksMemoryDesc_addInputRole} and
 *     {@link ANeuralNetworksMemoryDesc_addOutputRole}.
 *   - Optionally, specify the memory dimensions by calling
 *     {@link ANeuralNetworksMemoryDesc_setDimensions}.
 *   - Complete the memory descriptor with {@link ANeuralNetworksMemoryDesc_finish}.
 *   - Use the memory descriptor as many times as needed with
 *     {@link ANeuralNetworksMemory_createFromDesc}.
 *   - Destroy the memory descriptor with {@link ANeuralNetworksMemoryDesc_free}.
 *
 * A memory descriptor is completed by calling {@link ANeuralNetworksMemoryDesc_finish}.
 * A memory descriptor is destroyed by calling {@link ANeuralNetworksMemoryDesc_free}.
 *
 * A memory descriptor must not be modified once {@link ANeuralNetworksMemoryDesc_finish}
 * has been called on it.
 *
 * It is the application's responsibility to make sure that only
 * one thread modifies a memory descriptor at a given time. It is however
 * safe for more than one thread to use the memory descriptor once
 * {@link ANeuralNetworksMemoryDesc_finish} has returned.
 *
 * It is also the application's responsibility to ensure that there are no other
 * uses of the memory descriptor after calling {@link ANeuralNetworksMemoryDesc_free}.
 * It is however safe to continue using a {@link ANeuralNetworksMemory} object created
 * from the memory descriptor.
 *
 * Available since NNAPI feature level 4.
 */
ANeuralNetworksMemoryDesc :: struct{}

