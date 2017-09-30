function [B]= ditri(C,max,min)
%function to check the distribution of the Dot-product in various bins

p=size(C);
q=p(1);
r=p(2);
maxn=0;
minn=0;
B=zeros(1,80);

%The shifting of bins would need to be adjusted as per the max and min values of the dot product
for i=1:r
    for j=1:q
        a=floor(C(j,i));
        b=a+21;                  
        B(1,b)=B(1,b)+1;
        if(C(j,i)>=max)
            maxn=maxn+1;
        end
        if(C(j,i)<=min)
            minn=minn-1;
        end
    end
end