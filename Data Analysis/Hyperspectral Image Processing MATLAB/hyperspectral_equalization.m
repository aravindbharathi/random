function [equalizedimg, avgimgdata] = hyperspectral_equalization()

    %{
    Washington Mall Data

    1. Perform an averaging over all the hyperspectral channels 
       to obtain an image with a single channel
    2. Perform an histogram equalization and show equalized images
    %}

    %{
    The sensor system used in this case measured pixel response in
    210 bands in the 0.4 to 2.4 µm region of the visible and
    infrared spectrum. Bands in the 0.9 and 1.4 µm region
    where the atmosphere is opaque have been omitted from
    the data set, leaving 191 bands. The data set contains 1208
    scan lines with 307 pixels in each scan line.
    %}

    % filename and location
    filename = 'dc.tif';

    % loading data
    t = Tiff(filename, 'r');
    imgdata = read(t);          % The value is 1280 (length) x 307 (width)
                                % x 191 (channels - t.numberOfStrips)
    t.disp;

    % Averaging over all the hyperspectral channels (bands)
    avgimgdata = uint16(mean(imgdata, 3));  % avgimgdata is a 1280 x 307 double array
                                    % image with a single channel
    % NOTE: I have converted the averaged-channel array to unsigned integer 
    % (16 bit) from double as pixel intensities are generally discretized
    % (although while performing histogram binning, this could have been
    % directly taken care of)

    % Histogram Processing
    %{
    The histogram of a digital image with gray levels from 0 to L-1 is a
    discrete function h(r_k)=n_k, where:
      - r_k is the kth gray level
      - n_k is the # pixels in the image with that gray level
      - n is the total number of pixels in the image
      - k = 0, 1, 2, …, L-1
    Here, L = 65536 as it is a 16 bit image

    Normalized histogram: p(r_k)=n_k/n, where sum of all components = 1
    %}
    figure(1)
    subplot(1,2,1);
    title('Histogram of Averaged Channels');
    prehist1 = histogram(avgimgdata, 'NumBins', 65536, 'BinLimits', [0,65536], 'Normalization', 'pdf')
    % Histogram with Binning
    subplot(1,2,2);
    title('Binned Histogram of Average Channels');
    prehist2 = histogram(avgimgdata, 'NumBins', 256, 'BinLimits', [0,65536], 'Normalization', 'pdf')

    % Histogram Equalization
    %{
    The results are similar to contrast
    stretching but offer the advantage of full automation, since
    HE automatically determines a transformation function to
    produce a new image with a uniform histogram.
    %}

    % The maximum intensity value in avgimgdata is 10827
    % maxintensity = max(max(avgimgdata));

    % Before Equalization
    % imshow(avgimgdata,[0,65536]);
    % After Equalization
    eqimgdata = histeq(avgimgdata);
    figure(2)
    eqhist = histogram(eqimgdata, 'NumBins', 65536, 'BinLimits', [0,65536], 'Normalization', 'pdf')

    figure(3)
    imshowpair(avgimgdata, eqimgdata, 'montage')
    % NOTE: Here, I have used the MATLAB add-on Image Processing Toolbox. I am
    % not sure if I am allowed to use that, so I have also added a self-written
    % code below. I will bin the histogram into 256 bins (=65536/4)
    % The code takes about 50 seconds to run because of line 89

    %%{
    num_pixels = 1280*307;
    arr_hist = uint16(zeros(256,1));    % Initialising an array with zeros
                                        % Intensities are binned with Bin Width
                                        % = 256

    for i=1:256
        for j=1:256
            arr_hist(i) = arr_hist(i) + sum(sum(avgimgdata == ((i-1)*256+j)));
        end
    end

    % Calculating PDF
    arr_pdf = double(arr_hist)/num_pixels;

    % Finding Bin Floor (with pdf <= 0.0001)
    for i=1:256
        if arr_pdf(i) <= 0.0001
            binfloor = i;
        else
            break;
        end
    end

    % Finding Bin Ceiling (with pdf <= 0.05)
    for i=256:-1:1
        if arr_pdf(i) <= 0.05
            binceiling = i;
        else
            break;
        end
    end

    % Scaling up floor and ceiling values (as they were scaled down before)
    actual_binfloor = binfloor*256;
    actual_binceiling = binceiling*256;

    % Performing Histogram Equalization
    equalizedimg = uint16((double(avgimgdata) - actual_binfloor)*65536/(actual_binceiling - actual_binfloor));

    % Final Output [MATLAB toolbox vs equalized average channel]
    figure(4)
    imshowpair(eqimgdata, equalizedimg, 'montage')

    %%}
    
end