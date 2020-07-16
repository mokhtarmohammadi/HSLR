clc
close all
clear all
load X1
M0=X1(1:512,201:275);
% d=zeros(700,512);
% M0=d(X1(:,:));
M0=M0/max(M0(:));
rng('default')
level=0.2;
noisy2=level*randn(size(M0));

% load noisy2
M= M0 + noisy2;
%options.sigm2=MAD(M(:));
SNR_noisy=snr(M0,M-M0)
% figure, imagesc(M0), colormap(seismic);
% figure, imagesc(M), colormap(seismic);
dd=M;
d=M0;
%% 
lam_GMC=.001;
gamma=0.05;
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
[den_data,data_sparse] = seis_den_gmc(dd,dt,lam_GMC,gamma,rho,x_part,y_part,sigma1,sigma2,Nfft,fcut);
tic_Gmc=toc;
% den_data=denn_data./max(max(denn_data)).*max(max(M0));
% u=   1.1643; 
% figure
% plotseis(d,(0:size(den_data,1)-1)*dt,1:size(den_data,2),[],[1.5 u],1,1,[.1,0,0]);
% figure
% plotseis(dd,(0:size(den_data,1)-1)*dt,1:size(den_data,2),[],[1.5 u],1,1,[.1,0,0]);
% figure
% plotseis(den_data,(0:size(den_data,1)-1)*dt,1:size(den_data,2),[],[1.5 u],1,1,[.1,0,0]);
% figure
%  plotseis(dd-den_data,(0:size(den_data,1)-1)*dt,1:size(den_data,2),[],[1.5 u],1,1,[.1,0,0]);
% 
snrou=snr(M0,den_data-M0)
% % snrou;
% figure;imagesc(d)
% title('data free noise')
% % caxis([-.5 1.5])
% colormap(seismic);
% figure;imagesc(dd)
% title('noisy data')
% % caxis([-.5 1.5])
% colormap(seismic);
% figure;imagesc(data_sparse)
% title('sparse noisy data')
% % caxis([-.5 1.5])
% colormap(seismic);
% figure;imagesc(dd-data_sparse)
% title('noisy data - sparse noisy data')
% % caxis([-.5 1.5])
% colormap(seismic);figure;imagesc(den_data)
% title('denoised data')
% % caxis([-.5 1.5])
% colormap(seismic);
% figure;imagesc(dd-den_data)
% title('noisy data - denoised data')
% % caxis([-.5 1.5])
% colormap(seismic);
% % 
% % [snrint snrou]
% %% 
addpath(genpath('./ISLR')); 
addpath(genpath('./opt_ISLR'))
tic
  sigma=est_noise(dd);
 NLM_OUT=NLmeansfilter(dd,1,1,sigma);
  snr_NLM_OUT=snr(d,NLM_OUT-d)
  tic_nlm=toc;
%   %% 
fprintf('Runinng ISLR_opt...  0%%');
% 
R = 64; M =32; K =1; Nfft =64;r_OPTSLR=25;N=length(dd(:,1));
k=1;mu=.002;Nit=10;penalty_func='atan';lam_1_op=0;lam_2_op=.06
tic
for l=1:size(dd,2)
   l
opt_slr_opt(:,l)=denoised_stft_seismic2(dd(:,l),R,r_OPTSLR,M,K,Nfft,k,lam_1_op,lam_2_op,mu,Nit,penalty_func);
end
tic_opt_slr=toc;
snr_optslr=snr(d,opt_slr_opt-d)
%% 

fprintf('Runinng ISLR...  0%%');
lam_1_ISR=0.1;lam_2_ISLR=.026;
k=.7;mu=.002;Nit=10;
tic
for l=1:size(dd,2)
    no=l
ISLR_out(:,l)=ISLR_stft_seismic(dd(:,l),R,M,K,Nfft,k,lam_1_ISR,lam_2_ISLR,mu,Nit,penalty_func);
end
tic_slr=toc;
snr_ISLR=snr(d,ISLR_out-d)
%% 
[m,n]=size(dd);
t=(0:m-1)*dt;gamma=.08;
wav_type='cmhat';

tic
for i=1:n
    i
    optwsst_out(:,i) = opt_shrink_wsst_den(dd(:,i),t,16,20,gamma,wav_type);
end
tic_optwsst=toc;
snr_optwsst=snr(d, optwsst_out-d)
% 
[snr_optwsst,snr_ISLR,snr_optslr,snrou,snr_NLM_OUT]
%  mkdir('C:\Users\rasoul\Desktop\dd',['snr',num2str(round(snrint))])
% save(['C:\Users\rasoul\Desktop\dd\snr',num2str(round(snrint)),'\matlab'])