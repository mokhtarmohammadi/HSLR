function den_trace = Tp_non_covex_srls_GMC(in_trace,N,lam_GMC,gamma,rho)
temp=max(in_trace);
% in_trace=in_trace/temp;
rmse = @(err) sqrt(mean(abs(err(:)).^2));
M = size(in_trace,1);    % M: signal length
% N = 256;    % N: transform length
truncate = @(x, M) x(1:M);
AH = @(x) fft(x, N)/sqrt(N);
A = @(x)truncate(ifft(x),M)*sqrt(N);
normA = sqrt(M/N);
err = A(AH(in_trace)) - in_trace;
% max(abs(err))
[c_GMC,v] = srls_GMC(in_trace, A, AH, rho, lam_GMC, gamma);
x_GMC = A(c_GMC);
den_trace=x_GMC;
% den_trace=den_trace./max(max(den_trace)).*temp;
end 

