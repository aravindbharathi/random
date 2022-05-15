function [arr_clustered] = find_clusters(arr_img, cen_clustered, k, threshold)

    arr_clustered = zeros(k,4);	% Initialising an array to 
                                % contain clusters
                                % (k,1) = # of pixels
                                % (k,2) = sum of x coordinates
                                % (k,3) = sum of y coordinates
                                % (k,4) = sum of intensities
                                            
	% Loop to iterate over all pixels and find their distance from centroid
    for i=1:307
        for j=1:1280
            
            % Assigning min distance value to first cen_clustered centre
            % Is pixel intensity within threshold bounds?
            if (abs(arr_img(i,j) - cen_clustered(1,3)) < threshold)
                min_dist(2) = calc_distance(cen_clustered(1,1), cen_clustered(1,2), i, j);
                min_dist(1) = 1;    % Nearest Cluster
            else
                min_dist(2) = 1317; % sqrt(1280^2 + 307^2), ie, max possible distance
            end
            
            for l=2:k
                if (abs(arr_img(i,j) - cen_clustered(l,3)) < threshold)
                    % Calculating distance of current pixel from each
                    % cluster's centroid and finding the minimum distance
                    distance = sqrt((cen_clustered(l,1) - i)^2 + (cen_clustered(l,2) - j)^2);
                    if (min_dist(2) > distance)
                        min_dist(2) = distance;
                        min_dist(1) = l;
                    end
                end
            end
            
            if (min_dist(2) == 1317)
                continue;
            end
            
            arr_clustered(min_dist(1),1) = arr_clustered(min_dist(1),1) + 1;
            arr_clustered(min_dist(1),2) = arr_clustered(min_dist(1),2) + i;
            arr_clustered(min_dist(1),3) = arr_clustered(min_dist(1),3) + j;
            arr_clustered(min_dist(1),4) = arr_clustered(min_dist(1),4) + arr_img(i,j);
            
        end
    end
    
end