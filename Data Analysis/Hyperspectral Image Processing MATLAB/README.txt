Submission for Image Processing Project
Course: GNR 401: Remote Sensing and Image Processing

{
Author Name: Aravind Bharathi
Department: Physics
}

Additional sources have been cited based on use

{
Main Script contains only the sub-function calls and facilitating transfer of
input from Part 1 to Part 2
NOTE: I was unsure if the equalized image output should be used for
processing. Nevertheless, function for Part 1 returns both the averaged
image (over 191 bands) and the equalized image. The commented line needs to
be 'uncommented' to use the non-equalized image
}

TO RUN THE FULL PROJECT IMPLEMENTATION, PLEASE RUN THE FILE "mainscript_190260009.m" WITH ALL THE FILES IN THE .zip file IN THE SAME DIRECTORY. CONSIDERING THE SIZE OF FINAL SUBMISSION, I MAY NOT BE ABLE TO ATTACH THE DATASET 'dc.tif' file.

{
The final workspace variables include the arrays containing the averaged image, equalized image and the clustered image with threshold set at 30000 (more on this later)
}

PART 1

    {
    Washington Mall Data

    1. Perform an averaging over all the hyperspectral channels 
       to obtain an image with a single channel
    2. Perform an histogram equalization and show equalized images
    }

    {
    The sensor system used in this case measured pixel response in
    210 bands in the 0.4 to 2.4 µm region of the visible and
    infrared spectrum. Bands in the 0.9 and 1.4 µm region
    where the atmosphere is opaque have been omitted from
    the data set, leaving 191 bands. The data set contains 1208
    scan lines with 307 pixels in each scan line.
    }

PART 2

{
Washington Mall Data

1. Perform k-means clustering on the pixel intensity values with k=10
2. Replace all the pixels within a cluster by its mean value
3. Show the clustered image
}

 Although, it is not specified, I have implemented the following algorithm
 after performing an averaging over the channels

 'threshold' is a bound on intensity values to classify a pixel as part of the same cluster. Its value  was set by trial and error on the basis of visual inspection
