%% Some parameters to set - make sure that your code works at image borders!

% Row and column of the pixel for which we wish to find all similar patches 
% NOTE: For this section, we pick only one patch
row = 50;
col = 50;

% Patchsize - make sure your code works for different values
patchSize = 13;

% Search window size - make sure your code works for different values
searchWindowSize = 15;


%% Implementation of work required in your basic section-------------------

% TODO - Load Image
image = imread('C:\shkim\Year3\Image processing\NLM_Skeleton\IntegralImagingDenoisingCoursework-19\images/alleyReference.png');
image = double(rgb2gray(image))/255;


% TODO - Template matching for naive SSD (i.e. just loop and sum)
[offsetsRows_naive, offsetsCols_naive, distances_naive] = templateMatchingNaive(row, col,image,...
    patchSize, searchWindowSize);



%% Let's print out your results--------------------------------------------

for i=1:length(offsetsRows_naive)
    disp(['offset rows: ', num2str(offsetsRows_naive(i)), '; offset cols: ',...
        num2str(offsetsCols_naive(i)), '; Naive Distance = ', num2str(distances_naive(i),10)]);
end
