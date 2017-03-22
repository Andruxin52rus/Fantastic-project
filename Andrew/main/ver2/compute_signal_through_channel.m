function antennas_signals = compute_signal_through_channel( signal, carrier, Tin, Tout, Mtx, Mrx, d, num_of_rays, SNR_dB, angle_rad_vector, delay_vector, amplitude_vector )
% computes signal through multipath rayleigh channel
% ver. 1: Mtx = Mrx = 1;
% ver. 2: Mrx != 1

%%% SAMPLING SIGNAL %%%
SNR = 10^(SNR_dB / 10);
sample_spreading = Tin / Tout;
sampled_signal = zeros(1, length(signal) * sample_spreading);
for i=1:length(signal)
    for j=1:sample_spreading
       sampled_signal((i - 1) * sample_spreading + j) = signal(i) * SNR;
    end
end

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

%%% COMPUTING PHASE SHIFTS ON RECEIVER ANTENNAS
path_delay = zeros(num_of_rays, Mrx);
for i=1:num_of_rays
    for j=1:Mrx
        path_delay(i, j) = d * sin(angle_rad_vector(i)) * (j - 1);        
    end
end
c = 3e8;
phase_shift = 2 * pi * carrier * path_delay / c;
phase_shifted_signal = zeros(num_of_rays, Mrx, length(output_signal));
for i=1:length(output_signal)
    phase_shifted_signal(1:num_of_rays, 1:Mrx, i) = output_signal(i) * exp(1i * phase_shift)
end
antennas_signals = zeros(length(output_signal), Mrx);
for j=1:Mrx
    for i=1:length(output_signal)
        antennas_signals(i, j) = sum(phase_shifted_signal(1:num_of_rays, j, i)) / num_of_rays;
    end
end
end