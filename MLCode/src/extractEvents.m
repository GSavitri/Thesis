
eventName = input('Enter name of the event[initialGive,grab1,grab3,genga1,gengaIncorrect1,give1,give2,genga2,gengaIncorrect2,give3,genga3,gengaIncorrect3,grab2,grab4,endEvent] : ','s');
allowedEvents = {'initialGive','grab1','grab3','genga1','gengaIncorrect1','give1','give2','genga2','gengaIncorrect2','give3','genga3','gengaIncorrect3','grab2','grab4','endEvent'};
while(~ismember(eventName,allowedEvents))
    eventName= input('Invalid Event!,Enter the name of the event[initialGive,grab1,grab3,genga1,gengaIncorrect1,give1,give2,genga2,gengaIncorrect2,give3,genga3,gengaIncorrect3,grab2,grab4,endEvent]','s');
end
switch(eventName)
    case 'initialGive'
        varName = 'initialGive';
    case 'grab1'
        varName = input('Enter name of variable [grab1,proctorgrabHold1,proctorGrabBack1] :', 's');
        allowedNames = {'grab1' 'proctorgrabHold1' 'proctorGrabBack1'};
        while (~ismember(varName,allowedNames))
            varName = input('Invalid Name! Enter name of variable [grab1,proctorgrabHold1,proctorGrabBack1]: ', 's');
        end 
    case 'grab3'
        varName = input('Enter name of variable [grab3,proctorgrabHold3,proctorGrabBack3] :', 's');
        allowedNames = {'grab3' 'proctorgrabHold3' 'proctorGrabBack3'};
        while (~ismember(varName,allowedNames))
            varName = input('Invalid Name! Enter name of variable [grab3,proctorgrabHold3,proctorGrabBack3]: ', 's');
        end
    case 'genga1'
        varName = input('Enter name of variable [genga1,gengaRest1,gengaPickup1] :', 's');
        allowedNames = {'genga1' 'gengaRest1' 'gengaPickup1'};
        while (~ismember(varName,allowedNames))
            varName = input('Invalid Name! Enter name of variable [genga1,gengaRest1,gengaPickup1]: ', 's');
        end
    case 'give1'
        varName = input('Enter name of variable [give1,proctorgiveHold1,proctorGiveBack1] :', 's');
        allowedNames = {'give1' 'proctorgiveHold1' 'proctorGiveBack1'};
        while (~ismember(varName,allowedNames))
            varName = input('Invalid Name! Enter name of variable [give1,proctorgiveHold1,proctorGiveBack1]: ', 's');
        end
    case 'give2'
        varName = input('Enter name of variable [give2,proctorgiveHold2,proctorGiveBack2] :', 's');
        allowedNames = {'give2' 'proctorgiveHold2' 'proctorGiveBack2'};
        while (~ismember(varName,allowedNames))
            varName = input('Invalid Name! Enter name of variable [give2,proctorgiveHold2,proctorGiveBack2]: ', 's');
        end
    case 'give3'
        varName = input('Enter name of variable [give3,proctorgiveHold3,proctorGiveBack3] :', 's');
        allowedNames = {'give3' 'proctorgiveHold3' 'proctorGiveBack3'};
        while (~ismember(varName,allowedNames))
            varName = input('Invalid Name! Enter name of variable [give3,proctorgiveHold3,proctorGiveBack3]: ', 's');
        end
    case 'genga2'
        varName = input('Enter name of variable [genga2,gengaRest2,gengaPickup2]:', 's');
        allowedNames = {'genga2' 'gengaRest2' 'gengaPickup2'};
        while (~ismember(varName,allowedNames))
            varName = input('Invalid Name! Enter name of variable [genga2,gengaRest2,gengaPickup2]: ', 's');
        end
    case 'genga3'
        varName = input('Enter name of variable [genga3,gengaRest3,gengaPickup3] :', 's');
        allowedNames = {'genga3' 'gengaRest3' 'gengaPickup3'};
        while (~ismember(varName,allowedNames))
            varName = input('Invalid Name! Enter name of variable [genga3,gengaRest3,gengaPickup3]: ', 's');
        end
    case 'grab2'
        varName='grab2';
    case 'grab4'
        varName='grab4';
    case 'endEvent'
        varName='endEvent';
    case 'gengaIncorrect1'
        varName = 'gengaIncorrect1';
    case 'gengaIncorrect2'
        varName = 'gengaIncorrect2';
    case 'gengaIncorrect3'
        varName = 'gengaIncorrect3';
end

lowerBond = input('Enter lower bond: ');
upperBond = input('Enter upper bond: ');

structName = genvarname (varName);
eval([structName '=struct( ''lowerBond'',lowerBond,''upperBond'',upperBond,''epochTime'', EpochTime(lowerBond:upperBond),''accMag'', accMag(lowerBond:upperBond),''accX'', AccX(lowerBond:upperBond) ,''accY'', AccY(lowerBond:upperBond),''accZ'', AccZ(lowerBond:upperBond),''gyroMag'', gyroMag(lowerBond:upperBond),''gyroX'', GyroX(lowerBond:upperBond),''gyroY'', GyroY(lowerBond:upperBond),''gyroZ'', Gyro(lowerBond:upperBond))']);
