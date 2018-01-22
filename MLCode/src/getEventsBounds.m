function [ result ] = getEventsBounds(subjectDataSet)

events = {'give1' 'give2' 'give3' 'grab1' 'grab2' 'grab3' 'grab4' 'genga1' 'genga2' 'genga3' 'endEvent' 'initialGive' 'proctorgrabHold1' 'proctorGrabBack1' 'proctorgrabHold3' 'proctorGrabBack3' 'gengaRest1' 'gengaPickup1' 'gengaRest2' 'gengaPickup2' 'gengaRest3' 'gengaPickup3' 'proctorgiveHold1' 'proctorGiveBack1' 'proctorgiveHold2' 'proctorGiveBack2' 'proctorgiveHold3' 'proctorGiveBack3' 'gengaIncorrect1' 'gengaIncorrect2' 'gengaIncorrect3'};
result=struct();
% i=1;
for e=1:length(events)
    if(isfield(subjectDataSet, char(events(e))))
        event = getfield (subjectDataSet, char(events(e)));
%         char(events(e))
       result=setfield(result,char(events(e)),struct('lower',event.lowerBond,'upper',event.upperBond));
%         structureIDs = 'structure';
%     
%         requestID(i,:) = [structureIDs '_' num2str(i,'%02d')];        % Character Array
%     
%          requestID(i,:)= struct(char(events(e)),struct('lower',event.lowerBond,'upper',event.upperBond));     
    end
%     i=i+1; 
end

% result = struct ('give1', structEvent(1),'give2', struct('lower',eventsBounds(3) ,'upper',eventsBounds(4)),'give3', struct('lower',eventsBounds(5) ,'upper',eventsBounds(6)),'grab1', struct('lower',eventsBounds(7) ,'upper',eventsBounds(8)),'grab2', struct('lower',eventsBounds(9) ,'upper',eventsBounds(10)));

end


