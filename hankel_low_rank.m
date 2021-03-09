function [s] = hankel_low_rank (d,R,Nitr,l)

[D]=my_hankel(d);
[u,s,v]=svds(D,R);
L0=u*s*v.';
for k=1:Nitr
    H=(1/(1+l))*my_hankel(inv_my_hankel(D+l*L0));
    [u,s,v]=svds(H,R);
    L0=u*s*v.';
%     [L0,relmse_hat,mse_hat] = optshrink(H,R);
end
s=inv_my_hankel(H);