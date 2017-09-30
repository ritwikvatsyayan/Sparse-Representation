function [ spectrogram1 ] = calculatefft( sig,starttime,endtime,windowtime,steptime )
%signal is retrieved from the .wav file which is being considered
%start: start time of the audio file from where we want fft. By default, we take 0
%end: end time of the audio file. We take it as final time-1.
%window: Size of window for our sample
%step: step size considered
%X: output FFT of the waveform


fs=8000;
ts=starttime;  % % We choose the frequency of sampling at 8000 Hz, as we are taking 160 samples in each window of 20ms, which leads to 50*160 samples per second
te=endtime*fs/1000;  %%end time
window=windowtime*fs/1000;
step=steptime*fs/1000;
spectre=zeros(window,1000);
traverse=starttime*fs/1000;
i=1;
tic
while traverse<te
    sample=sig(traverse:traverse+window-1);
    temp=abs(fft(sample));
    spectre(:,i)=temp;
    traverse=traverse+step;
    i=i+1;
    
end
i=i-1;

spectrogram1=spectre(:,1:i);




end

