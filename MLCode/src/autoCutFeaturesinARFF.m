function [ arffInput ] = autoCutFeaturesinARFF( subjectDataSet,attribute, className,lower,upper )
    %caclulates fft of given dataset and provides ARFF data
    %Fs = 100;             Sampling frequency
    %numberOfBean
    for itr=1:size(attribute)
        field = getfield(subjectDataSet, char(attribute(itr,1)));
        dataSet=field(lower:upper);

        arffFeatures = CalculateFeatures(dataSet);
        if(itr==1)
                arffInput= arffFeatures;
        else
                arffInput= strcat(arffInput,',',arffFeatures);
        end
    
    end
    arffInput = strcat (arffInput,',', className);
end

