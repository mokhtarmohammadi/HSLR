clc
close all
clear all
load ki.mat
rng('default')
ddn=d+randn(size(d))*.48;
%% 
lam_GMC=.5;
gamma=.7;
rho=1;
x_part=10;
y_part=25;
Nfft=512;
fcut=80;
sigma2=2.5;
sigma1=2;
beta1=1;
beta2=1;
dt=0.002;
u=2.7811;
snrint=snr(d,ddn-d)
[den_data,data_sparse] = seis_den_gmc(ddn,dt,lam_GMC,gamma,rho,x_part,y_part,sigma1,sigma2,beta1,beta2,Nfft,fcut);
den_data=den_data./max(max(den_data)).*max(max(ddn));
snrout=snr(d,den_data-d)
subplot 121
plotseis(den_data,(0:size(den_data,1)-1)*dt,1:size(den_data,2),[],[1.5 u],1,1,[.1,0,0]);
ax = gca;
ax.FontSize=20;
box on
xlabel('Trace No.','FontSize',20)
ylabel('Time (s) ','FontSize',20)
subplot 122
 plotseis(ddn-den_data,(0:size(den_data,1)-1)*dt,1:size(den_data,2),[],[1.5 u],1,1,[.1,0,0]);
 ax = gca;
ax.FontSize=20;
box on
xlabel('Trace No.','FontSize',20)
ylabel('Time (s) ','FontSize',20)
 figure
subplot 121
plotseis(data_sparse,(0:size(data_sparse,1)-1)*dt,1:size(data_sparse,2),[],[1.5 u],1,1,[.1,0,0]);
ax = gca;
ax.FontSize=20;
box on
xlabel('Trace No.','FontSize',20)
ylabel('Time (s) ','FontSize',20)
subplot 122
 plotseis(ddn-data_sparse,(0:size(data_sparse,1)-1)*dt,1:size(data_sparse,2),[],[1.5 u],1,1,[.1,0,0]);
 ax = gca;
ax.FontSize=20;
box on
xlabel('Trace No.','FontSize',20)
ylabel('Time (s) ','FontSize',20)

