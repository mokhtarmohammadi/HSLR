function de_trace=ISLR_stft_den(in_trace,R,M,K,Nfft,k,lam1,lam2,mu,Nit,pen_type)
dB = @(x) 20 * log10(abs(x));
SNR = @(x,y) 10 * log10(sum(abs(x).^2)/sum(abs(x-y).^2));
y=in_trace;
y=y./max(max(y));
N = length(y); 
n = 0:N-1;
% [AH, A, normA] = MakeTransforms('STFT',N,[R M K Nfft]);
[AH, A, normA]=ST_transform(in_trace,N,dt);
% As = A(s);
Ay = A(y);
pen='pen_type';
[Ax, cost] = lrs_single(Ay,k,lam1,lam2,mu,pen,Nit); 
% de_trace = ipSTFT2(Ax,R,M,1,N);
de_trace=A=inv_S_transform(Ax,N)
de_trace=real(de_trace);
de_trace=(de_trace./max(max(de_trace))).*max(max(y));



