input = generateZadoffChu(23, 5, 0);
output = compute_signal_through_channel(input, 2.4e9, 10, 1, 1, 1, 2, 10, [0 0], [0 1], [10 1]);

close all;
plot(real(input), imag(input), 'o');
hold on
plot(real(output), imag(output), '*');
grid on

figure
plot(real(output),'ro-');
hold on;
inPlot=reshape(repmat(input,[10,1]),1,[]);
plot(real(inPlot),'b+-');
grid on;