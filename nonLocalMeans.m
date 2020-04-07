function [result] = nonLocalMeans(image, sigma, h, patchSize, windowSize)

%REPLACE THIS
%padding and intialisation
result = zeros(size(image));
%result = double(result);
padding_for_win = (windowSize-1)/2;
image_padding = padarray(image, [padding_for_win padding_for_win], 'replicate');

for i = 1:size(image,1)
    for j = 1:size(image,2)
    
        window = image_padding(i:windowSize-1+i, j:windowSize-1+j);
        [X,Y] = size(window);
        [a,b,distances] = templateMatchingNaive(X,Y,image,patchSize,windowSize); %returns the (,1)of distances,offsets row and col
        image2 = transpose(window); %transpose the window for correct indexing
        % x(i,j) = templateMatchingNaive(row, col, image2, patchSize,windowSize);
        window = reshape(image2, [windowSize^2,1]); %reshape into x*1 matrix to make it easier to compute
       
        %Calculate weighting
        weight = computeWeighting(distances, h , sigma, patchSize);
        result(i,j) = sum(times(double(window),weight)/sum(weight));
    end
end

result = uint8(result); %type(imageNoisy) should equal to type(result) to calculate the difference

end