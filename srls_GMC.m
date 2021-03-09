function [x, v] = srls_GMC(y, A, AH, rho, lam, gamma)
%srls_GMC Sparse-regularized least squares (srls) using the proposed GMC penalty.
% [x, v] = srls_GMC(y, A, AH, rho, lam, gamma)
%
% srls_GMC: Sparse-Regularized Least Squares with generalized MC (GMC) penalty
%
% Saddle point problem:
%
% argmin_x  argmax_v { F(x,v) =
%  1/2 ||y - A x||^2 + lam ||x||_1 - gamma/2 ||A(x-v)||_2^2 - lam ||v||_1 }
%
% INPUT
%   y 	    data
%   A, AH   operators for A and A^H
%   rho     rho >= maximum eigenvalue of A^H A
%   lam     regularization parameter, lam > 0
%   gamma   0 <= gamma < 1
%
% OUTPUT
%   x, v
%
% Ivan Selesnick
% May 2016
% Revised: July 2016
% 
% Reference:
% I. Selesnick, 'Sparse Regularization via Convex Analysis'
% IEEE Transactions on Signal Processing, 2017.

% Algorithm: Forward-backward, Theorem 25.8 in Bauschke and Combettes (2004)

MAX_ITER = 10000;
TOL_STOP = 1e-4;

% soft thresholding for complex data
soft = @(x, T) max(1 - T./abs(x), 0) .* x;

% soft thresholding for real data
% soft = @(t, T) max(t - T, 0) + min(t + T, 0);

% rho = max(eig(A'*A));
mu = 1.9 / ( rho * max( 1,  gamma / (1-gamma) ) );
% mu = 1.9 / ( rho * max( 1,  gamma / (1-gamma) ) );
AHy = AH(y);

% initialization
x = zeros(size(AHy));
v = zeros(size(AHy));

iter = 0;
old_x = x;
delta_x = inf;

while (delta_x > TOL_STOP) && (iter < MAX_ITER)    
    iter = iter + 1;
    
    % update x
    zx = x - mu * ( AH(A(x + gamma*(v-x))) - AHy );
    zv = v - mu * ( gamma * AH(A(v-x)) );
    
    % update v
    x = soft(zx, mu * lam);
    v = soft(zv, mu * lam);
    
    delta_x = max(abs( x(:) - old_x(:) )) / max(abs(old_x(:)));
    old_x = x;    
end
