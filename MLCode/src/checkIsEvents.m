function [ result ] = checkIsEvents(subjectDataSet, eventsBounds, lower, upper)
result = struct();

fields = fieldnames(eventsBounds);
for index=1:length(fields)
    eventBound = getfield(eventsBounds, char(fields(index)));
    %eventField = getfield(subjectDataSet,char(fields(index)));
    
    eventLower = eventBound.lower;
    eventUpper  = eventBound.upper;

    if (lower >= eventLower && lower < eventUpper) || (upper > eventLower && upper <= eventUpper)
        eventName = char(fields(index));
        if strcmp(eventName, 'give1') || strcmp (eventName, 'give2') || strcmp(eventName , 'give3')
            className = 'give';
        elseif strcmp(eventName, 'initialGive')
            className = 'initialGive';
        elseif strcmp (eventName, 'grab1')||strcmp (eventName, 'grab3')||strcmp(eventName , 'grab2')|| strcmp(eventName , 'grab4')
            className = 'grab';
%         elseif  strcmp(eventName , 'grab2')|| strcmp(eventName , 'grab4')||strcmp (eventName, 'grab3')
%             className = 'grab2_4';
        elseif strcmp(eventName, 'genga1') || strcmp (eventName, 'genga2') || strcmp(eventName , 'genga3')
            className = 'genga';
        elseif strcmp(eventName, 'proctorgrabHold1') || strcmp (eventName, 'proctorgrabHold2') || strcmp(eventName , 'proctorgrabHold3')
            className = 'proctorgrabHold';
        elseif strcmp(eventName, 'proctorGrabBack1') || strcmp (eventName, 'proctorGrabBack2') || strcmp(eventName , 'proctorGrabBack3')
            className = 'proctorGrabBack';
        elseif strcmp(eventName, 'gengaRest1') || strcmp (eventName, 'gengaRest2') || strcmp(eventName , 'gengaRest3')
            className = 'gengaRest';
        elseif strcmp(eventName, 'gengaPickup1') || strcmp (eventName, 'gengaPickup2') || strcmp(eventName , 'gengaPickup3')
            className = 'gengaPickup';
        elseif strcmp(eventName, 'proctorGiveBack1') || strcmp (eventName, 'proctorGiveBack2') || strcmp(eventName , 'proctorGiveBack3')
            className = 'proctorGiveBack'; 
        elseif strcmp(eventName, 'gengaIncorrect1') || strcmp (eventName, 'gengaIncorrect2') || strcmp(eventName , 'gengaIncorrect3')
            className = 'gengaIncorrect';
        elseif strcmp(eventName, 'endEvent') 
            className = 'endEvent';
        elseif strcmp(eventName, 'proctorgiveHold1') || strcmp (eventName, 'proctorgiveHold2') || strcmp(eventName , 'proctorgiveHold3')
            className = 'proctorGiveHold'; 
        end
        
        if (lower >= eventLower && lower <= eventUpper) && (upper >= eventLower && upper <= eventUpper)
            result.portion = 100;
        else
            if lower >= eventLower && lower <= eventUpper
                result.portion = ((eventUpper-lower)/(upper-lower))*100;
            else
                result.portion = ((upper-eventLower)/(upper-lower))*100;
            end
        end
        
        
        if result.portion >=60
            result.isEvent = 1; % event
            result.event= eventName;
            result.class = className;
        else
            result.isEvent = 0; %partial event
            result.event= eventName;
            result.class = 'none';
        end
        
        break;
    else
        result.isEvent = 0;
        result.event= 'notEvent';
        result.portion = 0;
        result.class='none';
    end
end

end

