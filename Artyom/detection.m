function [V]= detection(sequence,N,root,channel,K,SNRdb)
% Optimal detection of sequences Zadoff-Chu or Goley in white
% gausian noise or rayleighchan

% sequence:
% mode 1 - Zadoff-Chu ZC
% mode 2 - Goley
% mode 3 - test noise sequnce
% N - length of sequnce
% root - root of ZC sequnce (Use only in ZC)
% channel:
% mode 1 - gaus channel
% mode 2 - rayleigh channel
% K- number of experimental realizations
% SNRdb - signal to noise ratio in Db

tic %start a timer 

n=nargin; 
if n<6
    SNRdb=K;
    K=channel;
    channel=root;
end


 V=zeros(1,K);  %matched filter output
 if sequence==1 %ZC
      Phase=zeros(1,N); 
      for i=1:N
        Phase(i)=2*pi/N*root*(i-1)*((i-1)+1)/2;
      end
      x=exp(-1i.*Phase);

   if channel ==1 %Gaus
         snr=10^(0.1*SNRdb);
         for l=1:K
             noise=(randn(1,length(x))+(1i*randn(1,length(x))))./sqrt(2*snr); 
             y=x+noise;              %signal after channel
             V(l)=abs(sum((x.*conj(y))))/N;   %matched filter output
         end
   elseif channel ==2 %Reyleigh
         snr=10^(0.1*SNRdb);
         for k=1:K
            noise=(randn(1,length(x))+(1i*randn(1,length(x))));
            y=sqrt(2*snr).*(randn(1,length(x))+(1i*randn(1,length(x))))./sqrt(2).*x+noise;   %signal after channel
            V(k)=(sum((abs(x.*conj(y)))))/N; %matched filter output
         end
   else
           disp('ONLY Gaus and Rayleigh channels can be use in this program now');
   end
 elseif sequence==2 %Goley
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
    if channel ==1
           snr=10^(0.1*SNRdb);
           for l=1:K
               noise=(randn(1,length(x))+(1i*randn(1,length(x))))./sqrt(2*snr);
               y=x+noise;
               V(l)=abs(sum((x.*conj(y)).^2))/N;
           end
    elseif channel ==2
         snr=10^(0.1*SNRdb);
           for k=1:K
              noise=(randn(1,length(x))+(1i*randn(1,length(x))));
              y=sqrt(2*snr).*(randn(1,length(x))+(1i*randn(1,length(x)))).*x+noise;
              V(k)=(sum((abs(x.*conj(y))).^2))/N;
           end
       else
           disp('ONLY Gaus and Rayleigh channels can be use in this program now');
 end
       elseif sequence==3 % Test noise sequnce
           Phase=zeros(1,N);
            for i=1:N
             Phase(i)=2*pi/N*root*(i-1)*((i-1)+1)/2;
            end
             x=exp(-1i.*Phase);

               if channel ==1
                  for l=1:K
                   noise=(randn(1,length(x))+(1i*randn(1,length(x))))./sqrt(2);
                   V(l)=abs(sum((x.*conj(noise)).^2))/N;
                  end
              elseif channel ==2
     
                  for k=1:K
                   noise=(randn(1,length(x))+(1i*randn(1,length(x))));
                   V(k)=(sum((abs(x.*conj(noise))).^2))/N;
                  end
              else
                  disp('ONLY Gaus and Rayleigh channels can be use in this program now');
               end
           
 end
 %Äàëåå èäóò êóñêè êîäà äëÿ ãðàôè÷åñêîãî ïðåäñòàâëåíèÿ äàííûõ
%  dx1=[min(V):0.001:max(V)];
% cdf=zeros(1,length(dx1));
% for i=1:length(dx1)
% count1=find((V<=dx1(i)));
% cdf(i)=length(count1)/K;
% end
% plot(dx1,cdf);
 
%  grid on
% dx=[min(V):0.01:max(V)];
% pdf=zeros(1,length(dx));
% for i=1:length(dx)
% count=find((V>=dx(i) & V<dx(i)+0.01));
% pdf(i)=length(count)/K/0.01;
% end
% plot(dx,pdf);
%  
%   C=0.31.*ones(1,K);
% plot(C,'r');
toc
disp(toc);
 end
