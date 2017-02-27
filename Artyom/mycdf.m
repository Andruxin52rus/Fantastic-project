function[]=mycdf(V,K)
dx=[min(V):0.01:max(V)];
cdf=zeros(1,length(dx));
for i=1:length(dx)
count1=find((V<=dx(i)));
cdf(i)=length(count1)/K;
end
plot(dx,cdf);
grid on
end