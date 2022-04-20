% two point interpolation

N =1024;
n = 0:1:N-1;
fs = 44100;

w1 = hann(N); %hanning window


x2 = sin(2*pi*1000*n/fs);% sampling of the signal

X1 = fft(x2,N);
X2 = fft(x2.*transpose(w1),N); %calculating DFT of the windowed samples -> Usually to locate the peak index



figure()
stem( abs(X2)); % to find the index of peak DFT magnitude

k = 24;% loaction of the found peak
s = sign(abs(angle(X2(k)) - angle(X2(k+1))) - pi/2); % used to calculate variable s that is used in calculation of correction term

yp1 = abs(X2(k+s));                   % bin2
yp2 = abs(X2(k));                     % bin1

d = s*(((2*yp1) - yp2)/(yp1 + yp2));    % slope of two largest magnitude bins

f_est = (k+d-1)*fs/N;      % frequency that we estimated using 2 point interpolation
x_obtained  = sin(2*pi*f_est*n/fs); % samples of sinal obtained of estimated frequency


f_est2 = fs/N * (k-1);     % frequency that we estimated without using the interpolation

f_actual = 1000;           % actual frequency

figure()
subplot(2,2,1);
stem(abs(fft(x_obtained)));
title('DFT magnitude of signal of estimated frequency using 2 point interpolation');
xlabel('index ');
ylabel('DFT Magnitude');
xlim([0 1023]);

subplot(2,2,2);
stem(abs(X1));
title('DFT magnitude of Actual Signal');
xlabel('index ');
ylabel('DFT Magnitude');
xlim([0 1023]);

subplot(2,2,3);
plot(n/fs , x2);
hold on
plot(n/fs , x_obtained);
xlabel('n/Fs where n = [0 , 1023]');
ylabel(' sin(2000pi*n/Fs)');
hold off
title('Original Signal vs Estimated frequency signal');
legend('Original Signal' , ' Estimated frequency Signal using 2 point interpolation');
% Notice that both the signals overlap

f_error = abs(f_est - f_actual);

Error = abs(x_obtained - x2);
figure()
plot(Error);
title('Error');
legend('For 2 point interp hanning window');
xlabel('index ');
ylabel('Error produced');
xlim([ 0 1023]);