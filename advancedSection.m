%% Some parameters to set - make sure that your code works at image borders!
patchSize = 3;
sigma = 2.5; % standard deviation (different for each image!)
h = 0.55; %decay parameter
windowSize = 9;

%TODO - Read an image (note that we provide you with smaller ones for
%debug in the subfolder 'debug' int the 'image' folder);
%Also unless you are feeling adventurous, stick with non-colour
%images for now.
%NOTE: for each image, please also read its CORRESPONDING 'clean' or
%reference image. We will need this later to do some analysis
%NOTE2: the noise level is different for each image (it is 20, 10, and 5 as
%indicated in the image file names)

%REPLACE THIS
imageNoisy = imread('C:\shkim\Year3\Image processing\NLM_Skeleton\IntegralImagingDenoisingCoursework-19\images\alleyNoisy_sigma20.png');
imageNoisy = rgb2gray(imageNoisy);
imageReference = imread('C:\shkim\Year3\Image processing\NLM_Skeleton\IntegralImagingDenoisingCoursework-19\images\alleyReference.png');
imageReference = rgb2gray(imageReference);
tic;
%TODO - Implement the non-local means function
filtered = nonLocalMeans(imageNoisy, sigma, h, patchSize, windowSize);
%colour_Version
%filtered_Red = nonLocalMeans(imageNoisy(:,:,1), sigma, h, patchSize, windowSize);
%filtered_Green = nonLocalMeans(imageNoisy(:,:,2), sigma, h, patchSize, windowSize);
%filtered_Blue = nonLocalMeans(imageNoisy(:,:,3), sigma, h, patchSize, windowSize);
%filtered = cat(3, filtered_Red,filtered_Green,filtered_Blue);
toc

%% Let's show your results!

%Show the denoised image
figure('name', 'NL-Means Denoised Image');
imshow(filtered);
imwrite(filtered,'ccalleyDenoised_sigma2.5_h0.55_templatewidth_3.png')
figure('name','Unfiltered Image');
imshow(imageNoisy);


%Show difference image
diff_image = abs(imageNoisy - filtered);
figure('name', 'Difference Image');
imshow(diff_image / max(max((diff_image))));

%Print some statistics ((Peak) Signal-To-Noise Ratio)
disp('For Noisy Input');
[peakSNR, SNR] = psnr(imageNoisy, imageReference);
disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);

disp('For Denoised Result');
[peakSNR, SNR] = psnr(filtered, imageReference);
disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);

%Feel free (if you like only :)) to use some other metrics (Root
%Mean-Square Error (RMSE), Structural Similarity Index (SSI) etc.)