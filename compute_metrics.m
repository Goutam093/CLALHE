function metrics = compute_metrics(original, enhanced)
    % Compute all performance metrics
    
    % PSNR
    metrics.psnr = psnr(enhanced, original);
    
    % SSIM
    metrics.ssim = ssim(enhanced, original);
    
    % Entropy
    metrics.entropy = entropy(im2uint8(enhanced));
    
    % AMBE (Absolute Mean Brightness Error)
    metrics.ambe = abs(mean(original(:)) - mean(enhanced(:)));
    
    % RMSE
    metrics.rmse = sqrt(mean((original(:) - enhanced(:)).^2));
    
    % CII (Contrast Improvement Index)
    contrast_orig = std(original(:));
    contrast_enh = std(enhanced(:));
    
    if contrast_orig > 0
        metrics.cii = contrast_enh / contrast_orig;
    else
        metrics.cii = 1;
    end
end