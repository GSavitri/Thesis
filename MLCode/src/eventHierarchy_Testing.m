function [allFFTresult, allSliceEventPortion] = eventHierarchy_Testing(subjectDataSet,subjectName, attribute, numberOfBins,featureType)
%attribute = {accMag accX accY accZ gyroMag gyroX gyroY gyroZ}

sliceLength = 200;%round((length(getfield(subjectDataSet.give1,attribute))+length(getfield(subjectDataSet.give2,attribute))+length(getfield(subjectDataSet.give3,attribute))+length(getfield(subjectDataSet.grab1,attribute))+length(getfield(subjectDataSet.grab2,attribute)))/5);
% sliceLength 200 means 2 seconeds
giveCount=0;grabCount=0;noneCount=0;
allFFTresult = '';
allSliceEventPortion = '';
listOfnotEvents={};
listOfnotEventsIndex = 0;
eventCounter = 0;
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
   
field = getfield(subjectDataSet, char(attribute(1)));
lower = 1;upper = sliceLength;
eventBounds = getEventsBounds(subjectDataSet);
while upper+(sliceLength/2) <= length(field) %loop until last row in subject data set
    response = checkIsEvents(subjectDataSet, eventBounds, lower, upper);
        if strcmp(response.event,'notEvent')||strcmp(response.event,'give1')||strcmp(response.event,'give2')||strcmp(response.event,'give3')||strcmp(response.event,'grab1')||strcmp(response.event,'grab3')||strcmp(response.event,'grab2')||strcmp(response.event,'grab4')
            if strcmp(response.class,'give')&&(response.isEvent==1)
                giveCount=giveCount+1; 
            elseif strcmp(response.class,'grab')&&(response.isEvent==1)
                grabCount=grabCount+1; 
            else           
                noneCount= noneCount+1;
            end
            
            cnteventWindow=giveCount+grabCount+noneCount;
            if cnteventWindow==1
                wndlower=lower;
                wndupper = upper;
            else %For 2nd and 3rd window,if consecutinve use new upper limit,else use previously retsined upper bound
                if(lower-wndlower)<= (sliceLength) %Consecutinv windows are, at max  slice length apaprt 
                    wndupper = upper;  
                else
                    wndupper = wndupper;
                end    
            end
            
            if(cnteventWindow==3)
                if grabCount~=0
                    responseClass='grab';
                elseif giveCount ~=0
                    responseClass='give';
                else
                    responseClass='none';
                end
       
                if strcmp(responseClass,'none') 
                    listOfnotEventsIndex = listOfnotEventsIndex +1;
                       switch featureType
                            case 'Time'
                                allFFTresult = strcat(allFFTresult,'\n', autoCutFeaturesinARFF(subjectDataSet,attribute, 'none,notEvent',wndlower,wndupper));
                            case 'Frequency'
                                allFFTresult = strcat(allFFTresult,'\n', autoCutFFTinARFF(subjectDataSet,attribute,100, numberOfBins , 'none,notEvent',wndlower,wndupper));
                            case 'Time+Frequency'
                                allFFTresult = strcat(allFFTresult,'\n', autoCutFFT_TimeinARFF(subjectDataSet,attribute,100, numberOfBins , 'none,notEvent',wndlower,wndupper));
                       end 
%                     allSliceEventPortion = strcat(allSliceEventPortion,subjectName,',',response.event,',',num2str(cnteventWindow),',',response.class,',',num2str(response.portion),'\n');        
                else
                    switch featureType
                        case 'Time'
                            allFFTresult = strcat(allFFTresult,'\n',  autoCutFeaturesinARFF(subjectDataSet,attribute, strcat(responseClass,',event'),wndlower,wndupper));
                        case 'Frequency'
                            allFFTresult = strcat(allFFTresult,'\n',  autoCutFFTinARFF(subjectDataSet,attribute,100, numberOfBins , strcat(responseClass,',event'),wndlower,wndupper));
                        case 'Time+Frequency'
                            allFFTresult = strcat(allFFTresult,'\n',  autoCutFFT_TimeinARFF(subjectDataSet,attribute,100, numberOfBins ,strcat(responseClass,',event'),wndlower,wndupper));
                     end  
                     eventCounter = eventCounter+1;
                end
%                 allSliceEventPortion = strcat(allSliceEventPortion,subjectName,',',response.event,',',num2str(cnteventWindow),',',response.class,',',num2str(response.portion),',',num2str(wndlower),',',num2str(wndupper),'\n');
                giveCount=0;
                grabCount=0;
                noneCount=0;
                cnteventWindow=0;
            end  
            allSliceEventPortion = strcat(allSliceEventPortion,subjectName,',',response.event,',',num2str(cnteventWindow),',',response.class,',',num2str(response.portion),',',num2str(wndlower),',',num2str(wndupper),'\n');
        end 
    lower = round(lower+(sliceLength/2));% next slice/window starts before first window is completed,at 100th second.
    upper = lower+sliceLength;
end

allFFTresult = sprintf(allFFTresult);
end