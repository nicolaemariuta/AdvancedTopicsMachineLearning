function output = my_normalize( data, means, stds, start_col,end_col,last_col)
%NORMALIZE Summary of this function goes here
%   Detailed explanation goes here
    output = data(:,start_col:end_col) - repmat(means, size(data,1), 1);
    output = output ./ repmat(stds, size(data,1), 1);
    output = [ output data(:,last_col) ];
end