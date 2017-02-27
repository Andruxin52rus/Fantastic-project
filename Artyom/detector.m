function [V]= detector(sequence,N,root,channel,K,SNRdb,M,coherent_or_not)
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
% M -  number of antenna array elements
% coherent_or_not:
% mode 0 - if you use non-coherent reciever

% parameters of the antenna array:
lambda=0.11; % [meter] MTS
d=0.5; % [meter] the distance between the antenna elements that the correlation coefficient is 0.4 
phi=0.5236; % [radian] angle of incidence wave = 30 degrees


n=nargin; 
if n<8
    coherent_or_not=M;
    M=SNRdb;
    SNRdb=K;
    K=channel;
    channel=root;
end

x=zeros(M,N); % sequence on the transmitter
V=zeros(1,K); % matched filter output
S=zeros(M,1); % vector of antenna array

% support vector:
noise=zeros(M,N);
noiseray=zeros(M,N);
s1=zeros(M,N);

%generate vector of antenna array
    for i=1:M
        S(i)=exp(1i*2*pi/lambda*d*sin(phi)*(i-1));
    end

% sequence genereation block:
 if sequence==1 || sequence==3 %ZC
        Phase=zeros(1,N); 
      for i=1:N
        Phase(i)=2*pi/N*root*(i-1)*((i-1)+1)/2;
      end
      for i=1:M
      x(i,:)=exp(-1i.*Phase);
      end
 elseif sequence==2 %Goley
         switch N
        case 2 %complimentary pairs
            x1=[1 1];  
            x2=[1 -1];
        case 4
            x1=[1 1 1 -1];
            x2=[1 1 -1 1];
        case 8
            x1=[1 1 1 -1 1 1 -1 1];
            x2=[1 1 1 -1 -1 -1 1 -1];
        case 10 
            x1=[-1 1 1 -1 1 -1 1 1 1 -1];
            x2=[-1 1 1 1 1 1 1 -1 -1 1];
        case 16
            x1=[1 1 1 -1 1 1 -1 1 1 1 1 -1 -1 -1 1 -1];
            x2=[1 1 1 -1 1 1 -1 1 -1 -1 -1 1 1 1 -1 1];
        case 20
             x1=[-1 1 1 -1 1 -1 1 1 1 -1 -1 1 1 1 1 1 1 -1 -1 1];
             x2=[-1 1 1 -1 1 -1 1 1 1 -1 1 -1 -1 -1 -1 -1 -1 1 1 -1];
        case 26
            x1=[1 -1 1 1 -1 -1 1 -1 -1 -1 -1 1 -1 1 -1 -1 -1 -1 1 1 -1 -1 -1 1 -1 1]
            x2=[-1 1 -1 -1 1 1 -1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1 1 1 -1 -1 -1 1 -1 1];
        case 32
            x1=[1 1 1 -1 1 1 -1 1 1 1 1 -1 -1 -1 1 -1 1 1 1 -1 1 1 -1 1 -1 -1 -1 1 1 1 -1 1];
            x2=[1 1 1 -1 1 1 -1 1 1 1 1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 1 -1 1 1 1 -1 -1 -1 1 -1];
        case 40
            x1=[-1 1 1 -1 1 -1 1 1 1 -1 -1 1 1 1 1 1 1 -1 -1 1 -1 1 1 -1 1 -1 1 1 1 -1 1 -1 -1 -1 -1 -1 -1 1 1 -1];
            x2=[-1 1 1 -1 1 -1 1 1 1 -1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 -1 1 -1 1 -1 -1 -1 1 -1 1 1 1 1 1 1 -1 -1 1];
        case 52
            x1=[1 -1 1 1 -1 -1 1 -1 -1 -1 -1 1 -1 1 -1 -1 -1 -1 1 1 -1 -1 -1 1 -1 1 -1 1 -1 -1 1 1 -1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1 1 1 -1 -1 -1 1 -1 1];
            x2=[1 -1 1 1 -1 -1 1 -1 -1 -1 -1 1 -1 1 -1 -1 -1 -1 1 1 -1 -1 -1 1 -1 1 1 -1 1 1 -1 -1 1 -1 -1 -1 -1 1 1 1 1 1 1 1 -1 -1 1 1 1 -1 1 -1];
        case 64
            x1=[1 1 1 -1 1 1 -1 1 1 1 1 -1 -1 -1 1 -1 1 1 1 -1 1 1 -1 1 -1 -1 -1 1 1 1 -1 1 1 1 1 -1 1 1 -1 1 1 1 1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 1 -1 1 1 1 -1 -1 -1 1 -1];
            x2=[1 1 1 -1 1 1 -1 1 1 1 1 -1 -1 -1 1 -1 1 1 1 -1 1 1 -1 1 -1 -1 -1 1 1 1 -1 1 -1 -1 -1 1 -1 -1 1 -1 -1 -1 -1 1 1 1 -1 1 1 1 1 -1 1 1 -1 1 -1 -1 -1 1 1 1 -1 1];
        case 80
            x1=[-1 1 1 -1 1 -1 1 1 1 -1 -1 1 1 1 1 1 1 -1 -1 1 -1 1 1 -1 1 -1 1 1 1 -1 1 -1 -1 -1 -1 -1 -1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 -1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 -1 1 -1 1 -1 -1 -1 1 -1 1 1 1 1 1 1 -1 -1 1];
            x2=[-1 1 1 -1 1 -1 1 1 1 -1 -1 1 1 1 1 1 1 -1 -1 1 -1 1 1 -1 1 -1 1 1 1 -1 1 -1 -1 -1 -1 -1 -1 1 1 -1 1 -1 -1 1 -1 1 -1 -1 -1 1 1 -1 -1 -1 -1 -1 -1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 -1 1 -1 -1 -1 -1 -1 -1 1 1 -1];
        otherwise
            disp('GCPs exist only are: 1; 2; 4; 8; 10; 16; 20; 26; 32; 40; 52; 64; 80');
         end
         for i=1:M
            x(i,:)=x1;
         end
    else  
     disp('ONLY GL,ZC or Test sequences can be use in this program now');
 end
 
 %channel:
 %test gaus channel:
  if (channel==1) && (sequence==3) 
        for l=1:K
%                noise=(randn(M,N)+(1i*randn(M,N)))./sqrt(2);
            noise1=(randn(M,N)+(1i*randn(M,N)))./sqrt(2);
                    for k=1:N
                     noise(:,k)=S.*noise1(:,k);
                    end
          if (coherent_or_not==0)
            V(l)=sum(sum((abs(x.*conj(noise))).^2));
          else
             V(l)=abs(sum(sum((x.*conj(noise))))); 
          end
        end
  % test rayleigh channel
  elseif (channel==2) && (sequence==3)
        for l=1:K
            noise=(randn(M,N)+(1i*randn(M,N)))./sqrt(2);
            H=(randn(M,N)+(1i*randn(M,N)));
        
                % weighting coefficients obtained by the SVD technique:
            L=svd(H);
            L=L.^2;
            
              
          if (coherent_or_not==0)
               for k=1:N
                   noiseray(:,k)=S.*H(:,k).*noise(:,k)+S.*noise(:,k); 
               end
            V(l)=sum(sum((abs(x.*conj(noiseray))).^2));
          else
               for k=1:N
                    noiseray(:,k)=L.*S.*H(:,k).*noise(:,k)+L.*S.*noise(:,k);
               end
            V(l)=abs(sum(sum((x.*conj(noiseray))))); 
          end
        end
  % gaus channel
  elseif (channel==1)
          snr=10^(0.1*SNRdb);
%           for k=1:N
%                     s1(:,k)=S.*x(:,k);
%           end
         for l=1:K
                   noise=(randn(M,N)+(1i*randn(M,N)));
                      %y=s1+noise;
                    y=x+noise./sqrt(2*snr);
          if (coherent_or_not==0)
            V(l)=sum(sum((abs(x.*conj(y))).^2));
%             a=(abs(x.*conj(y)));
%             a=sort(a);
%             f=chi2pdf(a,20);
%            
%             plot(a,f);
          else
             V(l)=abs(sum(sum((x.*conj(y))))); 
          end
        end
   % rayleigh channel
  elseif (channel==2) 
       snr=10^(0.1*SNRdb);
      for l=1:K
            noise=(randn(M,N)+(1i*randn(M,N)))./sqrt(2*snr);
            H=sqrt(snr).*(randn(M,N)+(1i*randn(M,N)));
            L=svd(H);
            L=L.^2;    
          if (coherent_or_not==0)
               for k=1:N 
                   s1(:,k)=S.*H(:,k).*x(:,k)+S.*noise(:,k);
               end
            V(l)=sum(sum((abs(x.*conj(s1))).^2));
          else
               for k=1:N
                    s1(:,k)=L.*S.*H(:,k).*x(:,k)+L.*S.*noise(:,k);
               end
            V(l)=abs(sum(sum((x.*conj(s1))))); 
          end
      end
  else
           disp('ONLY Gaus and Rayleigh channels can be use in this program now');
  end
end
