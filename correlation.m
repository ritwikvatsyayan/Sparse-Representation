function [lf,rf] = correlation (D,X,st) 

% This function is a part of the scalr.m function previously designed. This
% just focusses on calculating the correlation matrices lf and rf for each
% point. Used in KL method for dissimilarity


window = 10 ; 
s = st/window ;
p= size(D);
dsize=p(2);
f=p(1);
q=size(X);
m=q(2);
C=zeros(dsize,m);
max = C(1,1);
min = C(1,1);




lf= zeros(dsize,m);
rf = zeros(dsize,m);
for i=1:m
    for l=1:dsize
        C(l,i)=dot(X(:,i),D(:,l));
        if(max < C(l,i))
            max=C(l,i);
            loc=l;
            col=i;
        end
        if(min > C(l,i))
            min=C(l,i);
            loc2=l;
            loc3=i;
        end
    end
    disp(i);
end
K=C;
for i=1:m
    for j=1:dsize
        C(j,i)=(C(j,i)-min);
        %/(max-min);
    end
end
for i = 1:m
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
     elseif m-i < 99
        for k=i-(m-i):i
            lf(:,i) = lf(:,i) + C(:,k);
        end
        for j=i:m
            rf(:,i) = rf(:,i)+ C(:,j);
        end
    end
end
