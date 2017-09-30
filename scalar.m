function [P,C] = scalar (D,X,st)      
%P is the output similarity vector generated using method of Bhattacharya co-efficients
%C is the normalized dot -product matrix
%D is the input dictionary
%X is the input signal which we are trying to detect transitions in
%st is the bin size on the left and right side for which we are calculating co-relation


window = 10 ;   
s = st/window ;
p= size(D);
dsize=p(2);
f=p(1);
q=size(X);
m=q(2);
C=zeros(dsize,m);


%max = C(1,1);
%max=4;
%min=-4;
%min = C(1,1);


lf= zeros(dsize,m);
rf = zeros(dsize,m);
for i=1:m
    for l=1:dsize
        C(l,i)=dot(X(:,i),D(:,l));
        
        %if(C(l,i)<-4)   %this part is used when we want to remove the values of dot product coming at the extremities
        %    C(l,i)=-4;
        %elseif(C(l,i)>4)
        %    C(l,i)=4;
        %end
        
        
        %if(max < C(l,i))  % used for calculating extreme points
         %max=C(l,i);
          %  loc=l;
           % col=i;
        %end
        %if(min > C(l,i))
         %   min=C(l,i);
         %   loc2=l;
         %   loc3=i;
        %end
        
        
    end
    disp(i);
end


for i=1:m                             % Normalization of the dot-product
    for j=1:dsize
        C(j,i)=(C(j,i)-min)/(max-min);
    end
end


for i = 1:m                          %calculating the left and right correlation vectors
    if (i<=s) 
        for k=1:i
          lf(:,i) = lf(:,i) + C(:,k);
        end
        for j=i:2*i-1
            rf(:,i) = rf(:,i) + C(:,j);
        end    
    elseif i>s && m-i>=s
        for k=(i-s):i
            lf(:,i) = lf(:,i) + C(:,k);
        end    
        for j=i:(i+s)
            rf(:,i) = rf(:,i) + C(:,j);
        end
     elseif m-i < s
        for k=i-(m-i):i
            lf(:,i) = lf(:,i) + C(:,k);
        end
        for j=i:m
            rf(:,i) = rf(:,i)+ C(:,j);
        end
    end
end

%Calculating Bhattacharya Co-efficients
P=zeros(1,m); 
for i=1:m
    r=0;
    l=0;
    for j=1:dsize
        r=r+rf(j,i);
        l=l+lf(j,i);
    end
    RF(:,i)= rf(:,i)/r;
    LF(:,i)=lf(:,i)/l;
for l=1:dsize
    if(i>1)
    P(1,i) = P(1,i)+sqrt(RF(l,i)*LF(l,i));
    end
end
if(i>1)
P(1,i)= 1- P(1,i);
end
end


% Matrix for plotting
Y=zeros(1,m);
for i=2:m-1
    Y(1,i)=i;
    %S(1,i)=S(1,i)*10/(l*b);
end
plot(Y,P);


        

