function enhanced_image = clalhe(input_image)
    % CLALHE - Contrast Limited Adaptive Local Histogram Equalization
    % Based on: Mohammed & Isa (2025)
    
    fprintf('  Step 1: Computing histogram features...\n');
    
    %% PART 1: DETERMINE OPTIMAL PARAMETERS
    
    % Convert to uint8 for histogram computation
    img_uint8 = im2uint8(input_image);
    
    % Compute histogram
    [hist_counts, ~] = imhist(img_uint8);
    
    % Find peaks and valleys
    [peaks, valleys, num_peaks, num_valleys] = compute_histogram_features(hist_counts);
    
    fprintf('    Found %d peaks and %d valleys\n', num_peaks, num_valleys);
    
    % Compute N-parameter
    N_param = sum(valleys) / num_valleys;
    
    % Compute Context Block Dimension (CBD)
    CBD_height = ceil(log(num_peaks));
    CBD_width = ceil(log(num_peaks));
    
    if CBD_height < 2
        CBD_height = 8; % Default
        CBD_width = 8;
    end
    
    fprintf('    CBD: [%d x %d]\n', CBD_height, CBD_width);
    
    % Compute Ideal Clip Limit (I_CL) for each peak
    fprintf('  Step 2: Finding optimal clip limit...\n');
    
    max_valley = max(valleys);
    best_ciqi = -inf;
    best_clip_limit = 2.0;
    
    for i = 1:length(peaks)
        % Calculate I_CL for this peak
        I_CL = (peaks(i) + N_param) / max_valley;
        
        % Limit to reasonable range
        I_CL = max(0.5, min(I_CL, 10.0));
        
        % Apply CLAHE with this clip limit
        temp_result = apply_conventional_clahe(input_image, I_CL, [CBD_height CBD_width]);
        
        % Compute CIQI
        ciqi_value = compute_ciqi(input_image, temp_result);
        
        % Update best parameters
        if ciqi_value > best_ciqi
            best_ciqi = ciqi_value;
            best_clip_limit = I_CL;
        end
    end
    
    fprintf('    Optimal Clip Limit: %.4f\n', best_clip_limit);
    fprintf('    Best CIQI: %.4f\n', best_ciqi);
    
    %% PART 2: OBTAIN RESULTANT IMAGE
    
    fprintf('  Step 3: Computing optimal number of subimages...\n');
    
    % Compute Optimal Number of Subimages (ONS)
    ONS = ceil(log2(num_valleys));
    if mod(ONS, 2) ~= 0  % Ensure even number
        ONS = ONS + 1;
    end
    
    if ONS < 2
        ONS = 2;
    end
    
    fprintf('    Number of subimages: %d\n', ONS);
    
    % Divide image into subimages
    fprintf('  Step 4: Dividing and processing subimages...\n');
    subimages = divide_image(input_image, ONS);
    
    % Enhance each subimage
    enhanced_subimages = cell(1, ONS);
    for i = 1:ONS
        enhanced_subimages{i} = apply_conventional_clahe(subimages{i}, ...
                                                         best_clip_limit, ...
                                                         [CBD_height CBD_width]);
    end
    
    % Merge enhanced subimages
    fprintf('  Step 5: Merging subimages...\n');
    enhanced_image = merge_subimages(enhanced_subimages, size(input_image));
    
    fprintf('  CLALHE processing complete!\n');
end