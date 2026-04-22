function ciqi = compute_ciqi(original, enhanced)
    % Compute CIQI = (PSNR + Entropy) / AMBE
    
    % Compute PSNR
    psnr_value = psnr(enhanced, original);
    
    % Compute Entropy
    entropy_value = entropy(im2uint8(enhanced));
    
    % Compute AMBE
    ambe_value = abs(mean(original(:)) - mean(enhanced(:)));
    
    % Avoid division by zero
    if ambe_value < 1e-6
        ambe_value = 1e-6;
    end
    
    % Calculate CIQI
    ciqi = (psnr_value + entropy_value) / ambe_value;
end