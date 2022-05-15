% Submission for Image Processing Project
% Course: GNR 401: Remote Sensing and Image Processing

%{
Author Name: Aravind Bharathi
Roll Number: 190260009
Department: Physics
%}

% Additional sources have been cited based on use

%{
Main Script only containing the function calls and facilitating transfer of
input from Part 1 to Part 2
NOTE: I was unsure if the equalized image output should be used for
processing. Nevertheless, function for Part 1 returns both the averaged
image (over 191 bands) and the equalized image. The commented line needs to
be 'uncommented' to use the non-equalized image
%}

% Calling Part 1 of the Project
[arr_eqimg, arr_avgimg] = hyperspectral_equalization();
% Figures 1 to 4 correspond to Part 1

% Calling Part 2 of the Project
[arr_clustered] = K_means_clustering(arr_eqimg);
% [arr_clustered] = K_means_clustering(arr_avgimg); % Please 'uncomment'
% this line to use the non-equalized image
% Figure 5 corresponds to Part 2