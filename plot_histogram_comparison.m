function plot_histogram_comparison(original, clahe, clalhe)
    % Plot histogram comparison
    
    figure('Position', [100 100 1200 800]);
    
    % Original
    subplot(2,3,1);
    imshow(original, []);
    title('Original Image');
    
    subplot(2,3,4);
    imhist(im2uint8(original));
    title('Original Histogram');
    
    % CLAHE
    subplot(2,3,2);
    imshow(clahe, []);
    title('CLAHE');
    
    subplot(2,3,5);
    imhist(im2uint8(clahe));
    title('CLAHE Histogram');
    
    % CLALHE
    subplot(2,3,3);
    imshow(clalhe, []);
    title('CLALHE');
    
    subplot(2,3,6);
    imhist(im2uint8(clalhe));
    title('CLALHE Histogram');
end