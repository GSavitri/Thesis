function [allFFTresult] = getAllFeaturesinARFF(subjectDataSet, attribute)
%attribute = {accMag accX accY accZ gyroMag gyroX gyroY gyroZ}
    
    allFFTresult = FeaturesinARFF(subjectDataSet,'give1', attribute, 'give,event','','');
    allFFTresult = strcat(allFFTresult,'\n',  FeaturesinARFF(subjectDataSet,'give2', attribute, 'give,event','',''));
    allFFTresult = strcat(allFFTresult,'\n',  FeaturesinARFF(subjectDataSet,'give3', attribute, 'give,event','',''));
    allFFTresult = strcat(allFFTresult,'\n',  FeaturesinARFF(subjectDataSet,'grab1', attribute, 'grab,event','',''));
    allFFTresult = strcat(allFFTresult,'\n',  FeaturesinARFF(subjectDataSet,'grab2', attribute, 'grab,event','',''));
  
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
        allFFTresult = strcat(allFFTresult,'\n',  FeaturesinARFF(subjectDataSet,'notEvent',attribute, 'none,notEvent',lower,upper));
    end
    
    allFFTresult = sprintf(allFFTresult);
end