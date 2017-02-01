function [ psnr_value ] = psnr( ref, dist )
% PSNR - peak signal noise ratio
% full reference objective metric
%
% input:
% ref:   grayscale image
%        the orginal images without distortion (reference)
% dist:  grayscale image array
%        distorted image
%
% ouput: float
%        PSNR Score in dB

    MSE = (1/(size(ref,1)*size(ref,2))) * sum(sum((ref-dist).^2));
    psnr_value = 10 * log((((2^8)-1)^2)/MSE);

end

