function [h]=inv_my_hankel(H)
H2=rot90(H);
[nt,nx]=size(H2);
k=1;
for j=-(nt-1):(nx-1)
    h(k)=mean(diag(H2,j));
    k=k+1;
end