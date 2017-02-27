function[e] =func(k,th)
% funk for plot BER of SNR for any parameters of  my function detector
% do  experiment 100 times and  then averaging
s=[-20:1:20]; %   vector SNR
for j=1:length(s)
for i=1:100 
V=detector(1,64,31,1,1000,s(j),k,0);
x=find(V<th);
y(i)=length(x);
end
e(j)=mean(y);
end
hold on
%semilogy(s,e/1000,'r');
hold on
end