function cormat=c_corr(data,out_put, wlen)
% wlen=5;
[m,n]=size(data);
temp1=zeros(m+wlen-1,n+wlen-1);
temp2=temp1;
temp1((wlen-1)/2+1:(wlen-1)/2+m,(wlen-1)/2+1:(wlen-1)/2+n)=out_put;
temp2((wlen-1)/2+1:(wlen-1)/2+m,(wlen-1)/2+1:(wlen-1)/2+n)=data-out_put;
p=zeros(size(temp1));
k1=0;
for i=((wlen-1)/2+1):((wlen-1)/2+m)
    k2=0;
    k1=k1+1;
    for j=((wlen-1)/2+1):((wlen-1)/2+n)
        k2=k2+1;
        w1 = oriented_window_2d(temp1,i,j,p,wlen);
        w2 = oriented_window_2d(temp2,i,j,p,wlen);
        rc = corr2(w1,w2);
        cormat(k1,k2)=rc;
    end
end
% imagesc(abs(cormat)); 
end