%% Batch Processing Script
% Process all images in test_images folder

clear all; close all; clc;

% Get all images
image_files = dir('test_images/*.jpg');
if isempty(image_files)
    image_files = dir('test_images/*.png');
end

num_images = length(image_files);
fprintf('Found %d images to process\n\n', num_images);

% Store results
results_table = table();

for idx = 1:num_images
    fprintf('Processing image %d/%d: %s\n', idx, num_images, image_files(idx).name);
    
    % Load image
    img_path = fullfile('test_images', image_files(idx).name);
    img = imread(img_path);
    
    if size(img, 3) == 3
        gray_img = rgb2gray(img);
    else
        gray_img = img;
    end
    
    gray_img = im2double(gray_img);
    
    % Apply methods
    clahe_img = apply_conventional_clahe(gray_img, 2.0, [8 8]);
    clalhe_img = clalhe(gray_img);
    
    % Compute metrics
    metrics_clahe = compute_metrics(gray_img, clahe_img);
    metrics_clalhe = compute_metrics(gray_img, clalhe_img);
    
    % Store in table
    results_table = [results_table; {
        image_files(idx).name, ...
        metrics_clahe.psnr, metrics_clalhe.psnr, ...
        metrics_clahe.ssim, metrics_clalhe.ssim, ...
        metrics_clahe.entropy, metrics_clalhe.entropy, ...
        metrics_clahe.ambe, metrics_clalhe.ambe
    }];
    
    % Save results
    [~, name, ~] = fileparts(image_files(idx).name);
    imwrite(clahe_img, sprintf('results/%s_clahe.png', name));
    imwrite(clalhe_img, sprintf('results/%s_clalhe.png', name));
end

% Set table variable names
results_table.Properties.VariableNames = {'Image', 'PSNR_CLAHE', 'PSNR_CLALHE', ...
                                          'SSIM_CLAHE', 'SSIM_CLALHE', ...
                                          'Entropy_CLAHE', 'Entropy_CLALHE', ...
                                          'AMBE_CLAHE', 'AMBE_CLALHE'};

% Display results
disp(results_table);

% Save to CSV
writetable(results_table, 'results/comparison_results.csv');
fprintf('\nResults saved to results/comparison_results.csv\n');