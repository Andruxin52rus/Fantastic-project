% 1-ray channel with 'angle' and 'd' have been defined the way that turns 
% input '1' to '1i' to check if the result is correct. Test has been passed 

input = [1]
antennas_signals = compute_signal_through_channel(input, 2.4e9, 10, 1, 1, 2, 0.03125, 1, 100, [pi / 2], [0], [10]);
antenna1_output = antennas_signals(1:length(antennas_signals), 1);
antenna2_output = antennas_signals(1:length(antennas_signals), 2);

close all;
plot(real(input), imag(input), 'o');
hold on
plot(real(antenna2_output), imag(antenna2_output), '*');
grid on

figure
plot(real(antenna2_output),'ro-');
hold on;
inPlot=reshape(repmat(input,[10,1]),1,[]);
plot(real(inPlot),'b+-');
grid on;
