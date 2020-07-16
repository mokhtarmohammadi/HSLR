function de_trace=denoised_stft_seismic2(in_trace,R,r,M,K,Nfft,k,lam1,lam2,mu,Nit,penalty_func)
N = length(in_trace);
[AH, A, normA] = MakeTransforms('STFT',N,[R M K Nfft]);
Ay = A(in_trace);
[Ax] = lrs_single_op(Ay,k,r,lam1,lam2,mu,penalty_func,Nit); 
de_trace = ipSTFT2(Ax,R,M,1,N);
de_trace=real(de_trace);
% dde_trace=(de_trace./max(max(de_trace))).*max(max(in_trace));
%% 
function [X] = lrs_single_op(Y, k,r, lam0, lam1, mu, pen, Nit,p)


switch pen
    case 'log'
        phi = @(x, a) (1/a) * log10(1 + a*abs(x));                    
    case 'atan'
        phi = @(x, a) 2./(a*sqrt(3)) .* (atan((2*a.*abs(x)+1)/sqrt(3)) - pi/6);
    case 'l1'
        phi = @(x,a) abs(x);
    case 'lp'
        phi = @(x,p) abs(x).^p;
    case 'firm'
        phi = @(x,a) zeros(size(x)) +...                                            
             (abs(x) < (1/a)).* (abs(x) - (a/2)*x.^2) + ...
             (abs(x) >= (1/a)) .* (1/(2*a));
end

if nargin < 9
    p = 0;
end

if lam0
    a0 = k/lam0;
else
    a0 = 0;
end

if lam1
    a1 = (1-a0*lam0)/(lam1);
else
    a1 = 0;
end

X = zeros(size(Y));
D = X;
U = X;
alpha = 1/(1+mu);
for i = 1:Nit
    %X-step
    if a1 == 0
        X = thresh(alpha * (Y + mu * (U + D)),(lam1*alpha),a1,'l1',1);
    else
        X = thresh(alpha * (Y + mu * (U + D)),(lam1*alpha),a1,pen,p);
    end
    X=optshrink(X,r);
end
if issparse(Y)
    X = sparse(X);
end

end
end


