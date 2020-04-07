function [result] = computeWeighting(d, h, sigma, patchSize)
    %Implement weighting function from the slides
    %Be careful to normalise/scale correctly!
    [X Y] = size(d);
    x = [];
    for i = 1:X
        x = [x sigma];
    end
    x = transpose(x);
    d = rdivide(d,patchSize);
    %REPLACE THIS
    result = exp(-(max(d-2*(x.^2),2)/h^2));
end