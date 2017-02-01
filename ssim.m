function ssim_value = ssim( ref, dist )
% SSIM - structural similarity
% full reference objective metric
%
% input:
% ref:   grayscale image
%        the orginal images without distortion (reference)
% dist:  grayscale image array
%        distorted image
%
% ouput: float
%        SSIM score

    ref = double(ref);
    dist = double(dist);
    
    sd = 1.5;
    C1 = 0.01^2;
    C2 = 0.03^2;

    hRef = fspecial('gaussian',[11 11],sd);
    hDis = fspecial('gaussian',[11 11],sd);
   
    muRef = imfilter(ref,hRef,'conv','replicate');
    muDis = imfilter(dist,hDis,'conv','replicate');
    
    mux2 = muRef.^2;
    muy2 = muDis.^2;
    muxy = muRef.*muDis;
          
    sigma01 = imfilter((ref.^2), hRef,'conv','replicate') - (mux2);
    sigma02 = imfilter((dist.^2), hDis,'conv','replicate') - (muy2);    
    sigma12 = imfilter((ref.*dist), hRef,'conv','replicate') - (muxy);
    
    ssimNum = ((2*muxy) + C1).*((2*sigma12) + C2);
    
    ssimDen = ((mux2) + (muy2) + C1).*(sigma01 + sigma02 + C2);
    
    ssim_value = mean(mean(ssimNum./ssimDen));
    
end
