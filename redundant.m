function[E]= redundant(W,D)  
%E is the optimized dictionary variable
%W is the sparsity vector for the given dictionary
%D is the Dictionary generated from K-SVD
% This function removes the dictionary vectors not being utilized for the
%representation of the input signal X 

q=size(W);
r=q(1);
e=q(2);
N=zeros(1,e);
i=1;
nor=0;

for j=1:r
    if(W(j,:)==N)        
        nor=nor+1;
        disp(j);
    else
    E(:,i)=D(:,j);
    i=i+1;
    disp(j);
    end
end   
disp(nor);
 
        