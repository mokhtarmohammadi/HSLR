clc
close all
clear all
load data_n5.mat
% rng('default')
% dd=dd(1:1000,1:44);
% d=d./max(max(d));
Noise = randn(size(d));
dd=d+Noise/3.5;
snrint=snr(d,dd-d);
dt=0.002;
% dd=data;
%% 
lam_GMC=.8;
gamma=0.8;
rho=1;
% r_GMC=10;
x_part=4;
y_part=20;
Nfft=1024;
fcut=50;
sigma2=10;
sigma1=10;

tic
[den_data,data_sparse] = seis_den_gmc(dd,dt,lam_GMC,gamma,rho,x_part,y_part,sigma1,sigma2,Nfft,fcut);
tic_Gmc=toc;