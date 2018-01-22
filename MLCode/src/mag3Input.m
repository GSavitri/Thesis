function [ mag ] = mag3Input( input1, input2, input3 )
%This function calculates mamnitude 3d vector, row by row, and returns the set of value
mag=zeros (length(input1),1);
for i=1:length(input1)
    mag(i)= norm([input1(i,1) input2(i,1) input3(i,1)]);
end
end
