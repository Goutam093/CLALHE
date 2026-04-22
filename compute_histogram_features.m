function [peaks, valleys, num_peaks, num_valleys] = compute_histogram_features(hist_counts)
    % Detect peaks and valleys in histogram
    
    peaks = [];
    valleys = [];
    
    % Find peaks (local maxima)
    for i = 2:length(hist_counts)-1
        if hist_counts(i) > hist_counts(i-1) && hist_counts(i) > hist_counts(i+1)
            peaks = [peaks; hist_counts(i)];
        end
    end
    
    % Find valleys (local minima)
    for i = 2:length(hist_counts)-1
        if hist_counts(i) < hist_counts(i-1) && hist_counts(i) < hist_counts(i+1)
            valleys = [valleys; hist_counts(i)];
        end
    end
    
    % Handle edge cases
    if isempty(peaks)
        peaks = [max(hist_counts)];
    end
    
    if isempty(valleys)
        valleys = [min(hist_counts(hist_counts>0))];
    end
    
    num_peaks = length(peaks);
    num_valleys = length(valleys);
end