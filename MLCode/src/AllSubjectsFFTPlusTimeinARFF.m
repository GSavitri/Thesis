%'9115' '8457' '8457_2'  '3968' '3968_2' '6752' '2396' '5663' '2631' '2631_2'   
%'2073' '9137' '9795' '3991' '3991_2'  '8963' '8963_2' '9449' '8372' '4831'
%'9449_2' '5221' '5221_2' '7562' '7562_2' '9041' '9041_2' '4024' '7249' '8101'
%'8253'

%training
% subjects = {'9115' '8457' '8457_2'  '3968' '3968_2' '6752' '2396' '5663' '2631' '2631_2' '2073' '9137' '9795' '3991' '3991_2'  '8963' '8963_2' '9449' '8372' '4831' '9449_2' };

%test sets
 subjects = { '5221' '5221_2' '7562' '7562_2' '9041' '9041_2' '4024' '7249' '8101' '8253'}; 

load subjectEvents;
isAutoCut = input ('Do you want auto cutting? (1=yes, 0=no): ');
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
numberOfBins = input ('Enter the number of bins for FFT: ');
outFileName = input ('Enter name of output file: ', 's');


numberofFeatures = numberOfBins*N+5*N;
%number of features will be N*number of Bins
result=arffHeader(numberofFeatures);
resultOfSliceEventPortion = 'sessionName,eventType,portionOfSlice \n';
for i=1:length(subjects)
    subjectName = char(subjects(i));
    loadedsubject = load (subjectName);
    if (isAutoCut)
        index = find(ismember(name, subjectName));
        if (~isempty(index))
            %eventsTimesSec = struct ('give1', give1(index),'give2', give2(index),'give3', give3(index),'grab1', grab1(index),'grab2', grab2(index));
            [fftResult, scliceEventsPortion] = autoCutFFTPlusTimeinARFF(loadedsubject,subjectName, attribute, numberOfBins);
            result = strcat(result,'\n',fftResult);
            resultOfSliceEventPortion = strcat(resultOfSliceEventPortion,scliceEventsPortion);
        else 
            disp(strcat('subject ', subjectName, 'does not exist in the subjectEvents list'))
        end 
    else
        result = strcat(result,'\n',getAllFTTPlusTimeinARFF(loadedsubject, attribute, numberOfBins));
        
    end
end 
result = sprintf(result);
outFileDir = strcat(pwd(), '/dataset/ARFF/new/20/',outFileName,'.arff');
fid=fopen(outFileDir,'w');
fprintf(fid,result);
fclose(fid);
disp(strcat('File is storred in: ', outFileDir));

if (isAutoCut)
    resultOfSliceEventPortion = sprintf(resultOfSliceEventPortion);
    outFileDir = strcat(pwd(), '/dataset/ARFF/new/20/',outFileName,' sliceEventPortion.csv');
    fid=fopen(outFileDir,'w');
    fprintf(fid,resultOfSliceEventPortion);
    fclose(fid);
    disp(strcat('File is storred in: ', outFileDir));
end
