function [P1, f ] = getFFT( dataSet, Fs, givenTitle, plotIt  )
%Fast Fourier transform
%Fs = 100;             Sampling frequency
%T = 1/Fs;              Sampling period
%L = 1430;              Length of signal
%t = (0:L-1)*T;         Time vector
% P1                    Single sided spectrum
if isempty(givenTitle)
    givenTitle = 'Single-Sided Amplitude Spectrum';
end
L=length (dataSet);
if mod(L,2) ~= 0
    L=L-1;
end
S=dataSet';
Y=fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
if (plotIt)
    figure()
    plot(f,P1)
    title(givenTitle)
    xlabel('f (Hz)')
    ylabel('|P1(f)|')
end

end

