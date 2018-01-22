function [ arffInput ] = autoCutFFTinARFF( subjectDataSet,attribute,fs, numberOfBins, className,lower,upper )
    %caclulates fft of given dataset and provides ARFF data
    %Fs = 100;             Sampling frequency
    %numberOfBeans
    for itr=1:size(attribute)
        field = getfield(subjectDataSet, char(attribute(itr,1)));
        dataSet=field(lower:upper);
      
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
        end
    end
    arffInput = strcat (arffInput,',', className);
end

