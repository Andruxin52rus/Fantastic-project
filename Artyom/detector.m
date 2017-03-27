function [V]= detector_new(sequence,N,root,K,SNRdb,M,coherent_or_not)
% Optimal detection of sequences Zadoff-Chu or Goley in white
% gausian noise 

% sequence:
% mode 1 - Zadoff-Chu ZC
% mode 2 - Goley
% mode 3 - test noise sequnce
% N - length of sequnce
% root - root of ZC sequnce (Use only in ZC)


% K- number of experimental realizations
% SNRdb - signal to noise ratio in Db
% M -  number of antenna array elements
% coherent_or_not:
% mode 0 - if you use non-coherent reciever




n=nargin; 
if n<7
    coherent_or_not=M;
    M=SNRdb;
    SNRdb=K;
    K=root;
end
len=0; 
x=zeros(M,N+len); % sequence on the transmitter
V=zeros(1,K); % matched filter output


% support vector:
noise=zeros(M,N+len);



% sequence genereation block:
 if (sequence==1 || sequence==3)   %ZC
        Phase=zeros(1,N); 
        
          for i=1:N
            if(mod(N,2==0))
              Phase(i)=2*pi/N*root*(i-1)*((i-1))/2;
            else
              Phase(i)=2*pi/N*root*(i-1)*((i-1)+1)/2;
            end
          end
          x1=exp(-1i.*Phase);
          E=abs(sum(x1.*conj(x1)));
          n=randn(1,len)+1i*randn(1,len);
          x1=[x1 n];
        for i=1:M
          x(i,:)=x1;
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
 

 %test gaus channel:
  if  (sequence==3) 
        for l=1:K
            noise=(randn(M,N+len)+1i*randn(M,N+len))/sqrt(2);

          if (coherent_or_not==0)
              V1=(sum(x'.*conj(noise')));
              V(l)=sum(abs(V1.^2))/E*2;
          else
             V(l)=abs(sum(sum((x.*conj(noise1))))); 
          end
        end

   
  % ZC or Goley
  elseif (sequence==1 || sequence==2) 
            snr=10^(0.1*SNRdb);
            %sigma=sqrt(E/snr);
         for l=1:K
                   noise=((randn(M,N+len)+(1i*randn(M,N+len))))/sqrt(2);      
                    y=sqrt(snr)*x+noise;
          if (coherent_or_not==0)
             V1=(sum(x'.*conj(y')));
              V(l)=sum(abs(V1.^2));
             
          else
             V(l)=sum(abs(sum((x.*conj(y))))); 
          end
           
         end
        
  else
           disp('ONLY Gaus and Rayleigh channels can be use in this program now');
  end
end
