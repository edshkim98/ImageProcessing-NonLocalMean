function [offsetsRows, offsetsCols, distances] = templateMatchingNaive(row, col,image,...
    patchSize, searchWindowSize)
% This function should for each possible offset in the search window
% centred at the current row and col, save a value for the offsets and
% patch distances, e.g. for the offset (-1,-1)
% offsetsRows(1) = -1;
% offsetsCols(1) = -1;
% distances(1) = 0.125;
% padding borders
window1 = (searchWindowSize -1)/2; %to calculate the center pixel
patch1 = (patchSize-1)/2;
image_pad = padarray(image, [patch1+window1, patch1+window1], 'replicate'); %padding around 
%the image because the edge pixels of the window will go out of bounds of
%the image

%co-ordinates of reference patch and window
center_patch = image_pad(row+window1 : row+patch1+patch1+window1, col+window1 : col+patch1+patch1+window1); %patch size
window = image_pad(row : row+ 2*(window1+patch1), col : col+2*(window1+patch1)); %inludes padding

%variables
[col_posi, row_posi] = deal(-window1);
offsetsRows = zeros(searchWindowSize^2,1); %It is squared to put values of each pixel in the window
offsetsCols = zeros(searchWindowSize^2,1);
distances = zeros(searchWindowSize^2, 1);
dist = [];
x = 1;
%dist = zeros(searchWindowSize^2, 1);
% The distance is simply the SSD over patches of size patchSize between
% 'template' patch centred at row and col and a patch shifted by the
% current offset
for i = 1:searchWindowSize
    col_posi = -window1;
    for j = 1:searchWindowSize
        patch_now = window(i : i + patch1 + patch1, j : patch1 + patch1 +j); %current patch
        ssd = power(patch_now - center_patch,2); %calculate ssd
        
        %offset values
        distances(x,1) = sum(sum(ssd,'all'),'all');%substitue every ssd values for each pixel into dist and sum it all
        offsetsRows(x,1) = row_posi;
        offsetsCols(x,1) = col_posi;
        col_posi = col_posi+1;
        x = x+1;
    end
    row_posi = row_posi + 1;
end
        
end