function [ arffInput ] = FeaturesinARFF( subjectDataSet,event,attribute, className,lower,upper )
    %caclulates fft of given dataset and provides ARFF data
    %Fs = 100;             Sampling frequency
    %numberOfBeans
   
    for itr=1:size(attribute)
        switch event
            case 'give1'
                dataSet=getfield(subjectDataSet.give1,char(attribute(itr,1)));
            case 'give2'
                dataSet=getfield(subjectDataSet.give2,char(attribute(itr,1)));
            case 'give3'
                dataSet=getfield(subjectDataSet.give3,char(attribute(itr,1)));
            case 'grab1'
                dataSet=getfield(subjectDataSet.grab1,char(attribute(itr,1)));
            case 'grab2'
                dataSet=getfield(subjectDataSet.grab2,char(attribute(itr,1)));
            case 'grab3'
                dataSet=getfield(subjectDataSet.grab3,char(attribute(itr,1)));
            case 'grab4'
                dataSet=getfield(subjectDataSet.grab4,char(attribute(itr,1)));
            case 'notEvent'
                field = getfield(subjectDataSet, char(attribute(itr,1)));
                dataSet=field(lower:upper);
            case 'testevent'
                field = getfield(subjectDataSet, char(attribute(itr,1)));
                dataSet=field(lower:upper);
        end
        
        arffFeatures = CalculateFeatures(dataSet);
        if(itr==1)
                arffInput= arffFeatures;
        else
                arffInput= strcat(arffInput,',',arffFeatures);
        end
    
    end
    arffInput = strcat (arffInput,',', className);
end

