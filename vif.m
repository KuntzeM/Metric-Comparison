function [ vif_value ] = vif( ref, dist )
% VIF - visual information fidelity
% full reference objective metric
%
% input:
% ref:   grayscale image
%        the orginal images without distortion (reference)
% dist:  grayscale image array
%        distorted image
%
% ouput: float
%        VIF score

    sigma_nsq=2;
    eps = 1e-10;

    num = 0.0;
    den = 0.0;

    ref = double(ref);
    dist = double(dist);

    for scale = 1:5

        N = 2^(4-scale+1) + 1;
        sd = N/5.0;
        h = fspecial('gaussian', [3 3], sd);
        if (scale > 1)
            ref = imfilter(ref,h,'replicate');
            dist = imfilter(dist,h,'replicate');
            ref = ref(1:2:end, 1:2:end);
            dist = dist(1:2:end, 1:2:end);
        end

        mu1 = imfilter(ref,h,'replicate');
        mu2 = imfilter(dist,h,'replicate');
        mu1_sq = mu1 .* mu1;
        mu2_sq = mu2 .* mu2;
        mu1_mu2 = mu1 .* mu2;
        sigma1_sq = imfilter(ref.^2,h,'replicate') - mu1_sq;
        sigma2_sq = imfilter(dist.^2,h,'replicate') - mu2_sq;
        sigma12 = imfilter(dist .* ref,h,'replicate') - mu1_mu2;

        sigma1_sq(sigma1_sq<0) = 0;
        sigma2_sq(sigma2_sq<0) = 0;

        g = sigma12 ./ (sigma1_sq + eps);
        sv_sq = sigma2_sq - g .* sigma12;

        g(sigma1_sq<eps) = 0;
        sv_sq(sigma1_sq<eps) = sigma2_sq(sigma1_sq<eps);
        sigma1_sq(sigma1_sq<eps) = 0;

        g(sigma2_sq<eps) = 0;
        sv_sq(sigma2_sq<eps) = 0;

        sv_sq(g<0) = sigma2_sq(g<0);
        g(g<0) = 0;
        sv_sq(sv_sq<=eps) = eps;

        num = num + sum(sum(log10(1 + g .* g .* sigma1_sq ./ (sv_sq + sigma_nsq))));
        den = den + sum(sum(log10(1 + sigma1_sq ./ sigma_nsq)));

    end;

    vif_value = num/den;



end

