function merged = merge_subimages(subimages, target_size)
    % Merge subimages horizontally
    
    num_subimages = length(subimages);
    
    % Concatenate horizontally
    merged = subimages{1};
    
    for i = 2:num_subimages
        merged = [merged, subimages{i}];
    end
    
    % Ensure output matches target size
    merged = imresize(merged, target_size);
end