clc
close all
clear all
load data_n5.mat
rng('default')
snrint=snr(d,dd-d);
%% 
lam_GMC=.25;
gamma=0.8;
rho=1;
% r_GMC=10;
x_part=4;
y_part=20;
Nfft=1024;
fcut=80;
sigma2=3.5;
sigma1=5;
beta1=1;
beta2=1;

tic
[den_data] = seis_den_gmc(dd,dt,lam_GMC,gamma,rho,x_part,y_part,sigma1,sigma2,beta1,beta2,Nfft,fcut);
tic_Gmc=toc;
snr_proposed=snr(d,den_data-d);
subplot 121
plotseis(den_data,(0:size(den_data,1)-1)*dt,1:size(den_data,2),[],[1.5 1.4445],1,1,[.1,0,0]);
subplot 122
 plotseis(dd-den_data,(0:size(den_data,1)-1)*dt,1:size(den_data,2),[],[1.5 1.4445],1,1,[.1,0,0]);