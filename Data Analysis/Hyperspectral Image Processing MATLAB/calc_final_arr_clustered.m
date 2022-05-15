% This function is similar to find_clusters with a few modifications to
% find the positions of all pixels in a cluster

function [arr_img] = calc_final_arr_clustered (arr_img, cen_clustered, k, threshold)
    
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
            
            arr_img(i,j) = cen_clustered(min_dist(1),3);
            
        end
    end

end