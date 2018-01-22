% Training '2396'
%Trainingsubjects = {'2396' '3968' '3968_2' '2396_2'  '5663' '5663_2' '9449' '9449_2' '8963' '8963_2' '9041' '9041_2' '5221' '5221_2' '7562' '7562_2' '2631' '2631_2' '8457' '8457_2' '3991' '3991_2' '4024' '4024_2' '8101' '8101_2' '7249' '7249_2' '8253' '8253_2' '8907' '8907_2' '4886' '4886_2' '6149' '6149_2'};
Trainingsubjects = {'1025'};
%Testing
%Testingsubjects = {'9115' '2073' '4831' '9795' '9137' '2307' '2307_2' '6462' '6462_2' '2147_2' '1025' '1025_2' '8985' '8565' '8565_2' };
Testingsubjects={'1025_2'};
% % Training '2396'
% Trainingsubjects = {'3968' '9115' '2396_2' '2073' '5663_2' '2307_2' '9449'  '8963' '6462_2' '9041_2' '9795' '5221' '1025_2'  '8985' '7562_2' '2631' '2631_2' '8457' '8457_2' '9041' '3991_2' '4024' '4024_2' '8101' '8101_2' '7249' '7249_2' '8253' '8253_2' '8907' '8907_2' '4886' '4886_2' '6149' '6149_2'};
% 
% %Testing
% Testingsubjects = { '3968_2' '5663' '4831'  '9137' '2307' '3991' '9449_2' '8963_2' '6462' '2147_2' '1025' '5221_2' '7562' '8565' '8565_2' };

featureType = input('Select the type of features?(Time,Frequency,Time+Frequency):','s');
allowedFeatures = {'Time','Frequency','Time+Frequency'};

 while (~ismember(featureType,allowedFeatures))
        featureType =input('Invalid Feature type! Enter the type of features?(Time,Frequency,Time+Frequency): ', 's');
 end

isAutoCut = input ('Is this testing file? (1=yes, 0=no): ');
N=input('Enter number of attributes : ');
attribute = strings(N,1);
i=1;
while(i<=N)
    attribute(i,1) = input('Enter attribute for FFT (accMag, accX, accY, accZ, gyroMag, gyroX, gyroY, gyroZ): ', 's');
    allowedAttributes = {'accMag' 'accX' 'accY' 'accZ' 'gyroMag' 'gyroX' 'gyroY' 'gyroZ'};
    while (~ismember(attribute(i,1),allowedAttributes))
        attribute(i,1) =input('Invalid Attribute! Enter attribute for FFT (E.g accMag accX accY accZ gyroMag): ', 's');
    end
    i=i+1;
end

attribute=cellstr(attribute);
switch(featureType)
    case 'Time'
        numberOfBins=0;
        numberofFeatures = 5*N;
    case 'Frequency'
        numberOfBins = input ('Enter the number of bins for FFT: ');
        numberofFeatures = numberOfBins*N;
    case 'Time+Frequency'
        numberOfBins = input ('Enter the number of bins for FFT: ');
        numberofFeatures = numberOfBins*N+5*N;
end

outFileName = input ('Enter name of output file: ', 's');
%number of features will be N*number of Bins
result=arffHeader(numberofFeatures);
resultOfSliceEventPortion = 'sessionName,eventType,portionOfSlice \n';

if (isAutoCut)
    for i=1:length(Testingsubjects)
        subjectName = char(Testingsubjects(i));
        loadedsubject = load (subjectName);
        [fftResult, scliceEventsPortion] = eventHierarchy_Testing(loadedsubject,subjectName, attribute, numberOfBins,featureType);
        result = strcat(result,'\n',fftResult);
        resultOfSliceEventPortion = strcat(resultOfSliceEventPortion,scliceEventsPortion);
    end
else
    for i=1:length(Trainingsubjects)
        subjectName = char(Trainingsubjects(i));
        loadedsubject = load (subjectName);
%         [fftResult, scliceEventsPortion] = autoCutTesting(loadedsubject,subjectName, attribute, numberOfBins,featureType);
        [fftResult, scliceEventsPortion]  = eventHierarchy_Training(loadedsubject,subjectName,attribute, numberOfBins,featureType);
        result = strcat(result,'\n',fftResult);
        resultOfSliceEventPortion = strcat(resultOfSliceEventPortion,scliceEventsPortion);
    end
end
    

result = sprintf(result);
outFileDir = strcat(pwd(), '/dataset/ARFF/new/20/',outFileName,'.arff');
fid=fopen(outFileDir,'w');
fprintf(fid,result);
fclose(fid);
disp(strcat('File is storred in: ', outFileDir));

resultOfSliceEventPortion = sprintf(resultOfSliceEventPortion);
outFileDir = strcat(pwd(), '/dataset/ARFF/new/20/',outFileName,' sliceEventPortion.csv');
fid=fopen(outFileDir,'w');
fprintf(fid,resultOfSliceEventPortion);
fclose(fid);
disp(strcat('File is storred in: ', outFileDir));

