clc
close all
clear all
load real_data2.mat
%% 
lam_GMC=.8;
gamma=0.8;
rho=1;
% r_GMC=10;
x_part=4;
y_part=20;
Nfft=1024;
fcut=80;
sigma2=10;
sigma1=10;
dt=.002;beta1=1;beta2=1;
tic
[den_data] = seis_den_gmc(dd,dt,lam_GMC,gamma,rho,x_part,y_part,sigma1,sigma2,beta1,beta2,Nfft,fcut);
tic_Gmc=toc;
% figure;imagesc(den_data)
% title('denoised data')
% colormap(gray);
% figure;imagesc(data-den_data)
% title('noisy data - denoised data')
% colormap(gray);
u=7.3191;data=dd;
plotseis(data,(0:size(den_data,1)-1)*dt,1:size(den_data,2),[],[1.5 u],1,1,[.1,0,0]);
figure
% subplot 121
plotseis(den_data,(0:size(den_data,1)-1)*dt,1:size(den_data,2),[],[1.5 u],1,1,[.1,0,0]);
ax = gca;
ax.FontSize=20;
box on
xlabel('Trace No.','FontSize',20)
ylabel('Time (s) ','FontSize',20)
% subplot 122
figure
 plotseis(data-den_data,(0:size(den_data,1)-1)*dt,1:size(den_data,2),[],[1.5 u],1,1,[.1,0,0]);
 ax = gca;
ax.FontSize=20;
box on
xlabel('Trace No.','FontSize',20)
ylabel('Time (s) ','FontSize',20)