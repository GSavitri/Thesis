function [ arffInput ] = FFTPlusTimeinARFF( subjectDataSet,event,attribute,fs, numberOfBins, className,lower,upper)
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

        [p1, f] = getFFT(dataSet, fs, '', false);
        beanFrequencyLength = f(length(f))/numberOfBins;
        i=1;
        for j=1:numberOfBins
            lowerFrequency  = (j-1)*beanFrequencyLength;
            upperFrequency = j*beanFrequencyLength;
            sum = 0;
            counter = 0;
            while (f(i)>= lowerFrequency) && (f(i) < upperFrequency) && (i < length(f))
                counter = counter+1;
                sum = sum + p1(i);
                i = i+1;
            end

            if j==1 && itr==1
                arffInput = mat2str(sum/counter);
            else
                arffInput = strcat(arffInput,',',mat2str(sum/counter));
            end
        end % end of frewuncy features loop
  
        %insert time doamain features
        arffFeatures = CalculateFeatures(dataSet);
        arffInput = strcat(arffInput,',',arffFeatures);    
    end % end of attribute loop
    arffInput = strcat (arffInput,',', className);
end

