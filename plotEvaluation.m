close all, clear all, clc;

% load result struct fom caluclateMetrics.m
load('results_metrics.mat');

%% show diagram from VIF
figure(1);
plot(result.quality, result.noise.vif)
hold on;
plot(result.quality, result.SBMF.vif, 'r')
plot(result.quality, result.MDBUTMF.vif, 'g')
legend('distorted', 'SBMF', 'MDBUTMS')
xlabel('strength of noise')
ylabel('vif')
title('VIF');
xlim([0.01 0.5]);

%% show diagrm from PSNR
figure(2);

plot(result.quality, result.noise.psnr)
hold on;
plot(result.quality, result.SBMF.psnr, 'r')
plot(result.quality, result.MDBUTMF.psnr, 'g')
legend('distorted', 'SBMF', 'MDBUTMS')
xlabel('strength of noise')
ylabel('PSNR in dB')
title('PSNR');
xlim([0.01 0.5]);

%% show diagram from SSIM
figure(3);
plot(result.quality, result.noise.ssim)
hold on;
plot(result.quality, result.SBMF.ssim, 'r')
plot(result.quality, result.MDBUTMF.ssim, 'g')
legend('distorted', 'SBMF', 'MDBUTMS')
xlabel('strength of noise')
ylabel('SSIM')
title('SSIM');
xlim([0.01 0.5]);
