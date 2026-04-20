%% CLALHE - Contrast Limited Adaptive Local Histogram Equalization
% Main Script for Image Enhancement
% Based on: Mohammed & Isa (2025) - IEEE Access

clear all; close all; clc;

%% Step 1: Load Image
fprintf('Loading input image...\n');
input_image = imread('test_images/test1.jpg');

% Convert to grayscale if color
if size(input_image, 3) == 3
    gray_image = rgb2gray(input_image);
else
    gray_image = input_image;
end

gray_image = im2double(gray_image); % Normalize to [0,1]

fprintf('Image loaded successfully. Size: %dx%d\n', size(gray_image,1), size(gray_image,2));

%% Step 2: Apply Conventional CLAHE
fprintf('\nApplying Conventional CLAHE...\n');
clahe_result = apply_conventional_clahe(gray_image, 2.0, [8 8]);

%% Step 3: Apply Proposed CLALHE
fprintf('\nApplying Proposed CLALHE...\n');
clalhe_result = clalhe(gray_image);

%% Step 4: Compute Metrics
fprintf('\n========== PERFORMANCE METRICS ==========\n');

% For CLAHE
metrics_clahe = compute_metrics(gray_image, clahe_result);
fprintf('\nConventional CLAHE:\n');
fprintf('  PSNR:    %.4f dB\n', metrics_clahe.psnr);
fprintf('  SSIM:    %.4f\n', metrics_clahe.ssim);
fprintf('  Entropy: %.4f\n', metrics_clahe.entropy);
fprintf('  AMBE:    %.4f\n', metrics_clahe.ambe);

% For CLALHE
metrics_clalhe = compute_metrics(gray_image, clalhe_result);
fprintf('\nProposed CLALHE:\n');
fprintf('  PSNR:    %.4f dB\n', metrics_clalhe.psnr);
fprintf('  SSIM:    %.4f\n', metrics_clalhe.ssim);
fprintf('  Entropy: %.4f\n', metrics_clalhe.entropy);
fprintf('  AMBE:    %.4f\n', metrics_clalhe.ambe);

%% Step 5: Display Results
figure('Position', [100 100 1200 400]);

subplot(1,3,1);
imshow(gray_image, []);
title('Original Image');

subplot(1,3,2);
imshow(clahe_result, []);
title('Conventional CLAHE');

subplot(1,3,3);
imshow(clalhe_result, []);
title('Proposed CLALHE');

%% Step 6: Save Results
fprintf('\nSaving results...\n');
if ~exist('results', 'dir')
    mkdir('results');
end

imwrite(clahe_result, 'results/clahe_result.png');
imwrite(clalhe_result, 'results/clalhe_result.png');

fprintf('Results saved to results/ folder\n');
fprintf('\n========== PROCESS COMPLETED ==========\n');