function output_signal = compute_signal_through_channel( signal, carrier, Tin, Tout, Mtx, Mrx, num_of_rays, SNR_dB, angle_vector, delay_vector, amplitude_vector )
% computes signal through multipath rayleigh channel
% ver. 1: Mtx = Mrx = 1; num_of_rays = 2

%%% SAMPLING SIGNAL %%%
SNR = 10^(SNR_dB / 10);
sample_spreading = Tin / Tout;
sampled_signal = zeros(1, length(signal) * sample_spreading);
for i=1:length(signal)
    for j=1:sample_spreading
       sampled_signal((i - 1) * sample_spreading + j) = signal(i) * SNR;
    end
end
sampled_signal

%%% CREATING NORMALIZED IMPULSE CHARACTERISTIC VECTOR %%%
h = zeros(1, num_of_rays);
for i=1:num_of_rays
    h(i) = amplitude_vector(i) * exp(-1i * 2 * pi * carrier * delay_vector(i));
end
normalizing_coef = 0;
for i=1:num_of_rays
    normalizing_coef = normalizing_coef + h(i) * h(i);
end
if normalizing_coef ~= 0
    h = h / sqrt(normalizing_coef);
end
h

%%% GENERATING GAUSSIAN NOISE %%%
% create original signal scaled noise
noise = (randn(length(signal), 1) + 1i * randn(length(signal), 1)) / sqrt(2);
sampled_noise = zeros(1, length(noise) * sample_spreading);
% spread noise to the new scale just like the original signal
for i=1:length(noise)
    for j=1:sample_spreading
       sampled_noise((i - 1) * sample_spreading + j) = noise(i);
    end
end

%%% COMPUTING OUTPUT SIGNAL %%%
output_signal = (filter(h, [1, 0], sampled_signal) + sampled_noise) / SNR

end