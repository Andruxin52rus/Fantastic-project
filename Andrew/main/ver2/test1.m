input = generateZadoffChu(23, 5, 0);
antennas_signals = compute_signal_through_channel(input, 2.4e9, 10, 1, 1, 2, 1, 2, 10, [1 0], [0 1], [10 1]);
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