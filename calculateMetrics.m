clear all, close all,  clc;

%% define variables
path_to_images = 'images';
input_image=imread('lena.png');

% define output struct
result = struct();
result.quality = [];
result.noise = struct;
result.noise.psnr = [];
result.noise.vif = [];
result.noise.ssim = [];


result.SBMF = struct;
result.SBMF.psnr = [];
result.SBMF.vif = [];
result.SBMF.ssim = [];

result.MDBUTMF = struct;
result.MDBUTMF.psnr = [];
result.MDBUTMF.vif = [];
result.MDBUTMF.ssim = [];


for q=0.01:0.01:0.5
    
    disp(sprintf('calculating for q= %f', q));
    result.quality = [result.quality q];
    
    %% add noise
    image_noise = addSaltPepperNoise(input_image, q); 
    
    % show noisy image
    figure(1);
    imshow(image_noise);    
    title('NOISE');
    
    imwrite(image_noise, sprintf(['images' filesep 'noise' filesep 'noise_%u.png'], uint16(q*100)));
    
    %% denoising    
    image_denoise_SBMF = denoiseSBMF(image_noise);
    image_denoise_MDBUTMF = denoiseMDBUTMF(image_noise);
    
    % show denoised images
    figure(2);
    imshow(image_denoise_SBMF);
    title('SBMF');
    figure(3);
    imshow(image_denoise_MDBUTMF);
    title('MDBUTMF');
    
    imwrite(image_denoise_SBMF, sprintf(['images' filesep 'SBMF' filesep 'SBMF_%d.png'], uint16(q*100)));
    imwrite(image_denoise_MDBUTMF, sprintf(['images' filesep 'MDBUTMF' filesep 'MDBUTMF_%d.png'], uint16(q*100)));
    
    %% save results from metrics in struct
    result.noise.psnr = [result.noise.psnr psnr(image_noise, input_image)];
    result.noise.vif = [result.noise.vif vif(image_noise, input_image)];
    result.noise.ssim = [result.noise.ssim ssim(image_noise, input_image)];
    
    result.SBMF.psnr = [result.SBMF.psnr psnr(image_denoise_SBMF, input_image)];
    result.SBMF.vif = [result.SBMF.vif vif(image_denoise_SBMF, input_image)];
    result.SBMF.ssim = [result.SBMF.ssim ssim(image_denoise_SBMF, input_image)];
    
    result.MDBUTMF.psnr = [result.MDBUTMF.psnr psnr(image_denoise_MDBUTMF, input_image)];
    result.MDBUTMF.vif = [result.MDBUTMF.vif vif(image_denoise_MDBUTMF, input_image)];
    result.MDBUTMF.ssim = [result.MDBUTMF.ssim ssim(image_denoise_MDBUTMF, input_image)];
end;

% save result struct for evaluation
save('results_metrics.mat', 'result');

