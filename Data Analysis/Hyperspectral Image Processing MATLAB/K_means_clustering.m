%{
Washington Mall Data

1. Perform k-means clustering on the pixel intensity values with k=10
2. Replace all the pixels within a cluster by its mean value
3. Show the clustered image
%}

% Although, it is not specified, I have implemented the following algorithm
% after performing an averaging over the channels

function [arr_clusteredimg] = K_means_clustering(arr_img)

    arr_img = transpose(arr_img);

    k = 10;      % Setting k-value as provided in the specifications
    num_iterations = 5;    % Number of loop iterations to perform
    num_pixels = 1280 * 307;    % Size of image array
    
    threshold = 30000       % Setting an intensity threshold to classify a 
                            % pixel as part of the same cluster
                            % Set by trial and error and visual inspection
    
    %arr_clustered = zeros(k,4);	% Initialising an array to 
                                % contain clusters
                                % (k,1) = # of pixels
                                % (k,2) = sum of x coordinates
                                % (k,3) = sum of y coordinates
                                % (k,4) = sum of intensities
    cen_clustered = zeros(k,3); % Initialising an array to contain centroids
                                % of clusters (x=(k,1),y=(k,2) coordinates) and mean
                                % intensity (=(k,3))
    
    % Loop to randomly assign initial cluster centroids
    for i=1:k
        cen_clustered(i,1) = uint16(rand*306 + 1);      % X Coordinate
        cen_clustered(i,2) = uint16(rand*1279 + 1);     % Y Coordinate
        cen_clustered(i,3) = arr_img(cen_clustered(i,1), cen_clustered(i,2));
                                                    % Intensity Value
    end
    
    for i=1:(num_iterations - 1)
        [arr_clustered] = find_clusters(arr_img, cen_clustered, k, threshold);
        
        % Loop to update Each Cluster's Centroid values
        for j=1:k
            cen_clustered(j,1) = arr_clustered(j,2)/arr_clustered(j,1);
            cen_clustered(j,2) = arr_clustered(j,3)/arr_clustered(j,1);
            cen_clustered(j,3) = arr_clustered(j,4)/arr_clustered(j,1);
        end
    end
    
    arr_clusteredimg = calc_final_arr_clustered(arr_img, cen_clustered, k, threshold);
    arr_clusteredimg = transpose(arr_clusteredimg);
    
    figure(5);
    % Figure showing subtle differences between input image and clustered
    % image. (I suppose that the number of clusters is very small or the
    % set threshold is too small)
    
    % NOTE: No threshold bound was imposed. Considering, Part 2 of the
    % project was to implement a means of image segmentation using k-means
    % clustering, I self-imposed a threshold conditions to avoid pairing
    % vastly different objects
    
    imshowpair(transpose(arr_img),arr_clusteredimg,'montage');
        
end