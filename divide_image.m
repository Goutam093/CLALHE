function subimages = divide_image(image, num_subimages)
    % Divide image into vertical subimages
    
    [height, width] = size(image);
    subimage_width = floor(width / num_subimages);
    
    subimages = cell(1, num_subimages);
    
    for i = 1:num_subimages
        if i < num_subimages
            col_start = (i-1) * subimage_width + 1;
            col_end = i * subimage_width;
        else
            % Last subimage takes remaining columns
            col_start = (i-1) * subimage_width + 1;
            col_end = width;
        end
        
        subimages{i} = image(:, col_start:col_end);
    end
end