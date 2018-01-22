function [allFFTresult] = getAllFFTinARFF(subjectDataSet, attribute, numberOfBins)
%attribute = {accMag accX accY accZ gyroMag gyroX gyroY gyroZ}
    
    allFFTresult = FFTinARFF(subjectDataSet,'give1', attribute, 100, numberOfBins , 'give,event','','');
    allFFTresult = strcat(allFFTresult,'\n',  FFTinARFF(subjectDataSet,'give2', attribute, 100, numberOfBins , 'give,event','',''));
    allFFTresult = strcat(allFFTresult,'\n',  FFTinARFF(subjectDataSet,'give3', attribute, 100, numberOfBins , 'give,event','',''));
    allFFTresult = strcat(allFFTresult,'\n',  FFTinARFF(subjectDataSet,'grab1', attribute, 100, numberOfBins , 'grab,event','',''));
    allFFTresult = strcat(allFFTresult,'\n',  FFTinARFF(subjectDataSet,'grab2', attribute, 100, numberOfBins , 'grab,event','',''));
  
    for itr=1:size(attribute)
        subAttribute = char(attribute(itr));
        switch subAttribute
        case 'accX'
            attribute(itr) = cellstr('AccX');
        case 'accY'
            attribute(itr) = cellstr('AccY');
        case 'accZ'
            attribute(itr) = cellstr('AccZ');
        case 'gyroX'
            attribute(itr) = cellstr('GyroX');
        case 'gyroY'
            attribute(itr) = cellstr('GyroY');
        case 'gyroZ'
            attribute(itr) = cellstr('Gyro');
        end
    
    end
    
    for i=0:5
        lower = 2000+(i*250);
        upper = 2000+((i+1)*250);      
        allFFTresult = strcat(allFFTresult,'\n',  FFTinARFF(subjectDataSet,'notEvent',attribute, 100, numberOfBins , 'none,notEvent',lower,upper));
    end
    
    allFFTresult = sprintf(allFFTresult);
end