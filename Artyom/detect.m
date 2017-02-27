function [V]= detect(sequence,r1,N1,channel1,K1,SNRdb1)
tic
n=nargin;

if n<6
N=r1;
channel = N1;
K = channel1;
SNRdb=K1;
else
   r=r1;
   N=N1;
   channel=channel1;
   K=K1;
   SNRdb=SNRdb1;
end




if sequence==1
    Phase=zeros(1,N);
    x=zeros(1,N);

for i=1:N
Phase(i)=2*pi/N*r*(i-1)*((i-1)+1)/2;
end

x=exp(-1i.*Phase);

elseif sequence ==2
    
    switch N
        case 2
            x=[1 1];
            x1=[1 -1];
        case 4
            x=[1 1 1 -1];
            x1=[1 1 -1 1];
        case 8
            x=[1 1 1 -1 1 1 -1 1];
            x1=[1 1 1 -1 -1 -1 1 -1];
        case 10 
            x=[-1 1 1 -1 1 -1 1 1 1 -1];
            x1=[-1 1 1 1 1 1 1 -1 -1 1];
        case 16
            x=[1 1 1 -1 1 1 -1 1 1 1 1 -1 -1 -1 1 -1];
            x1=[1 1 1 -1 1 1 -1 1 -1 -1 -1 1 1 1 -1 1];
        case 20
             x=[-1 1 1 -1 1 -1 1 1 1 -1 -1 1 1 1 1 1 1 -1 -1 1];
             x1=[-1 1 1 -1 1 -1 1 1 1 -1 1 -1 -1 -1 -1 -1 -1 1 1 -1];
        case 26
            x=[1 -1 1 1 -1 -1 1 -1 -1 -1 -1 1 -1 1 -1 -1 -1 -1 1 1 -1 -1 -1 1 -1 1]
            x1=[-1 1 -1 -1 1 1 -1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1 1 1 -1 -1 -1 1 -1 1];
        case 32
            x=[1 1 1 -1 1 1 -1 1 1 1 1 -1 -1 -1 1 -1 1 1 1 -1 1 1 -1 1 -1 -1 -1 1 1 1 -1 1];
            x1=[1 1 1 -1 1 1 -1 1 1 1 1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 1 -1 1 1 1 -1 -1 -1 1 -1];
        case 40
            x=[-1 1 1 -1 1 -1 1 1 1 -1 -1 1 1 1 1 1 1 -1 -1 1 -1 1 1 -1 1 -1 1 1 1 -1 1 -1 -1 -1 -1 -1 -1 1 1 -1];
            x1=[-1 1 1 -1 1 -1 1 1 1 -1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 -1 1 -1 1 -1 -1 -1 1 -1 1 1 1 1 1 1 -1 -1 1];
        case 52
            x=[1 -1 1 1 -1 -1 1 -1 -1 -1 -1 1 -1 1 -1 -1 -1 -1 1 1 -1 -1 -1 1 -1 1 -1 1 -1 -1 1 1 -1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1 1 1 -1 -1 -1 1 -1 1];
            x1=[1 -1 1 1 -1 -1 1 -1 -1 -1 -1 1 -1 1 -1 -1 -1 -1 1 1 -1 -1 -1 1 -1 1 1 -1 1 1 -1 -1 1 -1 -1 -1 -1 1 1 1 1 1 1 1 -1 -1 1 1 1 -1 1 -1];
        case 64
            x=[1 1 1 -1 1 1 -1 1 1 1 1 -1 -1 -1 1 -1 1 1 1 -1 1 1 -1 1 -1 -1 -1 1 1 1 -1 1 1 1 1 -1 1 1 -1 1 1 1 1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 1 -1 1 1 1 -1 -1 -1 1 -1];
            x1=[1 1 1 -1 1 1 -1 1 1 1 1 -1 -1 -1 1 -1 1 1 1 -1 1 1 -1 1 -1 -1 -1 1 1 1 -1 1 -1 -1 -1 1 -1 -1 1 -1 -1 -1 -1 1 1 1 -1 1 1 1 1 -1 1 1 -1 1 -1 -1 -1 1 1 1 -1 1];
        case 80
            x=[-1 1 1 -1 1 -1 1 1 1 -1 -1 1 1 1 1 1 1 -1 -1 1 -1 1 1 -1 1 -1 1 1 1 -1 1 -1 -1 -1 -1 -1 -1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 -1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 -1 1 -1 1 -1 -1 -1 1 -1 1 1 1 1 1 1 -1 -1 1];
            x1=[-1 1 1 -1 1 -1 1 1 1 -1 -1 1 1 1 1 1 1 -1 -1 1 -1 1 1 -1 1 -1 1 1 1 -1 1 -1 -1 -1 -1 -1 -1 1 1 -1 1 -1 -1 1 -1 1 -1 -1 -1 1 1 -1 -1 -1 -1 -1 -1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 -1 1 -1 -1 -1 -1 -1 -1 1 1 -1];
        otherwise
            disp('GCPs exist only are: 1; 2; 4; 8; 10; 16; 20; 26; 32; 40; 52; 64; 80');
    end
    
elseif sequence==3
  
x=zeros(1,N);
Phase=zeros(1,N);
    ZC=zeros(1,N);

for i=1:N
Phase(i)=2*pi/N*r*(i-1)*((i-1)+1)/2;
end

ZC=exp(-1i.*Phase);
else
     disp('ONLY GL,ZC or Test sequences can be use in this program now');
end

V=zeros(1,K);

if (channel==1) && (sequence==3) 
    

for l=1:K
noise=(randn(1,length(x))+(1i*randn(1,length(x))));
y=sqrt(2).*x+noise;
 V(l)=(abs((sum(ZC.*conj(y)))))/N;
%V(l)=(sum(abs((ZC.*conj(y)).^2)))/N;


end


elseif (channel==1 && sequence ~=3) 
    
snr=10^(0.1*SNRdb);
for l=1:K
noise=(randn(1,length(x))+(1i*randn(1,length(x))));
y=sqrt(2*snr).*x+noise;
V(l)=abs(sum((x.*conj(y))))/N;
%V(l)=(sum(abs((x.*conj(y)).^2)))/N;

end

elseif channel ==2
    
snr=10^(0.1*SNRdb);
for k=1:K
noise=(randn(1,length(x))+(1i*randn(1,length(x))));
y=sqrt(snr*2).*(randn(1,length(x))+(1i*randn(1,length(x))))./sqrt(2).*x+noise;
V(k)=(abs((sum(x.*conj(y)))))/N;
end
else
    
disp('ONLY Gaus and Rayleigh channels can be use in this program now');
end

% dx=[min(V):0.01:max(V)];
% pdf=zeros(1,length(dx));
% for i=1:length(dx)
% count=find((V>=dx(i) & V<dx(i)+0.01));
% pdf(i)=length(count)/K/0.01;
% end
% plot(dx,pdf);
% 
% dx1=[min(V):0.001:max(V)];
% cdf=zeros(1,length(dx1));
% for i=1:length(dx1)
% count1=find((V<=dx1(i)));
% cdf(i)=length(count1)/K;
% end
% subplot(2,2,1)
% plot(dx1,cdf);
% grid on
% subplot(2,2,2)
% plot(dx,pdf);

% subplot(2,2,3)

%  C=0.305.*ones(1,K);
%  plot(C,'r');
%  hold on
%  plot(V);
 %grid on


% toc
% disp(toc);
end
