if (exist('subjectNum') ~= 1)
    subjectNum = input('Enter Subject number: ', 's');
end
gyroMag = mag3Input(GyroX, GyroY, Gyro);
accMag = mag3Input(AccX, AccY, AccZ);
MagMag = mag3Input(MagX, MagY, MagZ);
time = elapsedTimeInSec(EpochTime);

maxAccMag = max (accMag);
maxGyroMag = max(gyroMag);

accMagThreshold = zeros(length(time), 1);
accMagThreshold(1:end)= prctile(accMag, 99.9);

gyroMagThreshold = zeros(length(time), 1);
gyroMagThreshold(1:end)= prctile(gyroMag, 99.9);

% figure('name', strcat(num2str(subjectNum), ': AccMag'));
% plot(time, accMag, time, accMagThreshold);
% title('Accelometer Magnitude in sec');
% xlabel('time in second');
% 
% figure('name', strcat(num2str(subjectNum), ': GyroMag'));
% plot(time, gyroMag, time, gyroMagThreshold);
% title('Gyroscope Magnitude in sec');
% xlabel('time in second');

%frames = video.NumberOfFrames
%frameRate = video.FrameRate
subDir = strcat( pwd(), '/dataset/',subjectNum);
if (exist(strcat(subDir, '.mat'), 'file')~=2)
    save(subDir);
    clear;
else 
    disp('File Exists');
end