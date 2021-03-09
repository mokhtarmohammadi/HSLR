clc
close all
clear all
load X1
M0=X1(1:512,201:275);
M0=M0/max(M0(:));
rng('default')
level=0.2;
noisy2=level*randn(size(M0));
M= M0 + noisy2;
SNR_noisy=snr(M0,M-M0)
% figure, imagesc(M0), colormap(seismic);
% figure, imagesc(M), colormap(seismic);
dd=M;
d=M0;
%% 
lam_GMC=.8;
gamma=0.8;
rho=1;
% r_GMC=10;
x_part=1;
y_part=1;
Nfft=2056;
fcut=80;
sigma2=18;
sigma1=19;
dt=.002;
tic
[den_data,data_sparse] = seis_den_gmc_real(dd,dt,lam_GMC,gamma,rho,x_part,y_part,sigma1,sigma2,Nfft,fcut);
tic_Gmc=toc;
figure;imagesc(den_data)
title('denoised data')
colormap(gray);
figure;imagesc(dd-den_data)
title('noisy data - denoised data')
colormap(gray);