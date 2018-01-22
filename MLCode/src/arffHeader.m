function [ header ] = arffHeader( numberOfAttribute )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

header  = "@relation events_classification\n\n";

for i=1:numberOfAttribute
    header = strcat (header, '@attribute f',num2str(i),' numeric\n');
end

header = strcat (header, '@attribute class {give, grab, none}\n@attribute type {event, notEvent}\n\n@data');
header = sprintf(header);
end

