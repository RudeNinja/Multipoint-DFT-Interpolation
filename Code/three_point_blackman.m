N =1024;
n = 0:1:N-1; % index grid for sampling
fs = 44100;

w1 = blackman(N); %window function (Hanning Window)


x2 = sin(2*pi*1000*n/fs); % sampling of signal
X_2  = fft(x2 , N);
X2_windowed = fft(x2.*transpose(w1),N); % DFT of the windowed samples

figure()
stem(abs(X2_windowed)); % plotting of Magnitude of DFT samples (used to obtain peak bin or 'k')

k = 24; % required index of the peak DFT sample -> Observed from the DFT magnitude plot (abcissa of the peak)




yp1 = abs(X2_windowed(k+1));                   % bin1
ym1 = abs(X2_windowed(k-1));                   % bin2
yl = abs(X2_windowed(k));                      % bin3

d = 2*((yp1-ym1)/(yp1+ym1+2*yl));    % calculation of the correction term used in estimation of signal

f_est = (k+d-1)*fs/N;      % frequency estimate with interpolation
f_est2 = (k-1)*fs/N;       % frequency estimate without interpolation

% DFT plots of signals for f_actual and f_estimate
x_obtained =  sin(2*pi*f_est*n/fs);

figure();
subplot(2,2,1);
stem(abs(X_2));
xlim([0 1023]);
xlabel('index ');
ylabel('DFT Magnitude');
title('DFT Magnitude Of Original Signal');

subplot(2,2,2);
stem(abs(fft(x_obtained,N)));
xlim([0 1023]);
xlabel('index ');
ylabel('DFT Magnitude');
title('DFT magnitude of signal using 3 point FFT interpolation to estimate frequecny');

%combined plots of actual signal and the estimated signal
subplot(2,2,3);
plot(n/fs , x2);
hold on
plot(n/fs , x_obtained);
xlabel('n/Fs where n = [0 , 1023]');
ylabel(' sin(2000pi*n/Fs)');
hold off
title('Original Signal vs Estimated frequency signal');
legend('Original Signal' , ' Estimated frequency Signal using 3 point interpolation');
% Notice that both the signals overlap


% Error calculation
figure();
Error = abs((x_obtained) - (x2));
E_max  = max(Error);
plot(Error);
title('absolute error in 2 signals');
xlim([ 0 1023]);
xlabel('N or index of the sample');
ylabel('Error produced by each sample');
title('Error in DFT magnitude');
legend('For 3 point interp');
xlim([ 0 1023]);