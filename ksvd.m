function [D,W] = ksvd ( X, s,factor, noIt)   
% X is the FFT of the input signal, as calculated by the calculatefft.m function
%s is the sparsity taken, in absolute value
%factor is the number of times the size of the input signal column(features) which is taken as dictionary size. In general it is more than 4
%noIt: No of iterations of K-SVD algorithm to run. More iterations increase accuracy


p=size(X);   %Calculating size of sparsity vector
nof=p(1);
m=p(2);

dsize=factor*nof;       %Dictionary size

k=2/(dsize^(0.5));      %code for initializing the dictionary using the Discrete Cosine Transform basis
co=(2*pi)/dsize;
for i=1:nof
   for j= 1:dsize
       D(i,j)=k*cos(co*(i+0.5)*(j+0.5));
    end
end


%for(e=1:dsize)                    %code for chosing a random basis for dictionary
  %D(:,e)=X(:,floor((m*e)/dsize));
  %D(:,e)=D(:,e)/norm(D(:,e));
%end
%D=X(:,[1:dsize]);


W=zeros(dsize,m);                 %initialize W to reduce time complexity
for it = 1:noIt
    % find weights, using dictionary D
    for(j=1:m)
        W(:,j) = OMP(D, X(:,j), s); % generalized implementation of OMP, hence data is sent column-wise
        disp(it);  
        disp(j);   
    end
    
    
    
    R = X - D*W;     %error
    
    
    for k=1:dsize    % Dictionaru updating using K-SVD from the sparse code generated from OMP   
        disp(k);
        I = find(W(k,:));
       if isempty(I)
          %D(:,k)=ones(nof,1);
       else
        Ri = R(:,I) + D(:,k)*W(k,I);
        [U,S,V] = svds(Ri,1,'L');
        D(:,k) = U;
        W(k,I) = S*V';
        R(:,I) = Ri - D(:,k)*W(k,I);
       end;
    end
 end