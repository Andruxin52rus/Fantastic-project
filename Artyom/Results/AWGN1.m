function [y]= AWGN1(x,SNR)
snr=10^(0.1*SNR);
n=(1/sqrt(snr))*(randn(1,length(x))+(1i*randn(1,length(x))));
y=x+n;
end
