function [H]=my_hankel(h)
lx=floor(length(h)/2)+1;
kx=length(h)-lx+1;
temp=hankel(h);
H=temp(1:lx,1:kx);