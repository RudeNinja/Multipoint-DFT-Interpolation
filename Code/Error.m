N =1024;
n = 0:1:N-1; % index grid for sampling
fs = 44100;



x2 = sin(2*pi*1000*n/fs);
x2_hann = sin(2*pi*999.9875*n/fs);
x2_black = sin(2*pi*998.099*n/fs);
x2_rect = sin(2*pi*994.1966*n/fs);

Error_hann = abs(x2_hann - x2);
Error_black = abs(x2_black - x2);
Error_rect = abs(x2_rect - x2);

plot(n , Error_hann);
hold on
plot(n , Error_black);
hold on
plot(n , Error_rect);
hold off
title('Errors in signals of estimated frequency using 3 point Interpolation for Different Windows');
legend('Hanning Window' , 'Blackman Window' , 'Rectangular Window');
xlabel('Index of Samples');
ylabel('Error produced in case of each window');
xlim([0 1023]);