function [ arffFeatures ] = CalculateFeatures( dataset)
%UNTITLED3 Summary of this function goes here
%   Dataset is the array vector ,ex:x Accmag for give event.
Max = mat2str(max(dataset));
Average = mat2str(mean(dataset));
StandardDeviation = mat2str(std(dataset));
Skewness= mat2str(skewness(dataset));
Kurtosis = mat2str(kurtosis(dataset));
% acc = mat2str(Mean_Velocity(dataset));
arffFeatures = strcat(Max,',',Average,',',StandardDeviation,',',Skewness,',',Kurtosis);
end


