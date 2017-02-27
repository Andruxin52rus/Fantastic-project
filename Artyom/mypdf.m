function[]=mypdf(V,K)
dx=[min(V):0.01:max(V)];
pdf=zeros(1,length(dx));
for i=1:length(dx)
count=find((V>=dx(i) & V<dx(i)+0.01));
pdf(i)=length(count)/K/0.01;
end
plot(dx,pdf);
grid on
end