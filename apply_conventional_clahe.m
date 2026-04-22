function enhanced = apply_conventional_clahe(image, clip_limit, tile_size)
    % Apply standard CLAHE using MATLAB's built-in function
    
    % Convert to uint8 if needed
    if max(image(:)) <= 1
        img_uint8 = im2uint8(image);
    else
        img_uint8 = uint8(image);
    end
    
    % Apply CLAHE
    enhanced_uint8 = adapthisteq(img_uint8, ...
                                 'ClipLimit', clip_limit/100, ...
                                 'NumTiles', tile_size, ...
                                 'Distribution', 'uniform');
    
    % Convert back to double
    enhanced = im2double(enhanced_uint8);
end