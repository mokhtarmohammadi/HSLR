% clc
% close all
% clear all
% load data_n4.mat
% load data_n3.mat
% addpath(genpath('./ISLR')); 
% rng('default')
%  dmax  = max(max(d));
%  op = hamming(9);
%  ops = sum(sum(op));
%  op = op/ops;
% d=cmp;
%  Noise = randn(size(d));
%  Noise = conv2(randn(size(d)),op,'same');
% % 
%  Noisemax  = max(max(Noise));
% % 
%  dd = d + (dmax/Noisemax)*Noise/-1;
% d=cmp;dd=cmpn;
% dd=m;
% clear m 
% d=m;
% d=d./max(max(d));
% dd=d+Noise/3.4;
% dd=dd./max(max(dd));
% dd=ds;
%  snrint=snr(d,dd-d)
%  data=dd;
 
 %% 
 tic
  sigma=est_noise(data);
 NLM_OUT=NLmeansfilter(data,1,1,sigma);
  snr_NLM_OUT=snr(d,NLM_OUT-d)
  tic_nlm=toc;
%% 
% fprintf('Runinng GMC...  0%%');
% dt=.002;
% lam_GMC=.4;gamma=.8;rho=1;r_GMC=25;
% tic
% 
% for i=1:size(data,2)
%     %i
% %     y=cwt(data(:,i));
% %     for j=1:size(y,2)
% den_trace = Tp_non_covex_srls_GMC(data(:,i),size(data,1),lam_GMC,gamma,rho);
% den_trace=den_trace';
% den_tracec(:,i)=den_trace; 
% 
% end
% % den_trace=den_tracec;
% i=sqrt(-1);
% d1=fftn(den_tracec);
% TempAbs = real( d1);
%     TempPhi = imag( d1) ;
% [S,relmse_hat,mse_hat]=optshrink(TempAbs,r_GMC);
% % L=S.*exp(i.*TempPhi);
% L=S+i*TempPhi;
% % L=TempAbs+i*S;
% % L=TempAbs.*exp(i.*S);
% t2=ifftn(L);
% t2=real(t2);
% % t2=t2./max(abs(t2));
% % % t2=t2.*max(max(d));
% den_trace=t2;
% tic_Gmc=toc;
%  snrou=snr(d,den_trace-d);
%  [snrint snrou]

%%
% fprintf('Runinng ISLR_opt...  0%%');
% 
R = 64; M =32; K =1; Nfft =64;r_OPTSLR=13;N=length(data(:,1));
k=1;mu=.002;Nit=10;penalty_func='atan';lam_1_op=0;lam_2_op=.02
tic
for l=1:size(data,2)
   l
opt_slr_opt(:,l)=denoised_stft_seismic2(data(:,l),R,r_OPTSLR,M,K,Nfft,k,lam_1_op,lam_2_op,mu,Nit,penalty_func);
end
tic_opt_slr=toc;
snr_optslr=snr(d,opt_slr_opt-d)
% %% 
% 
fprintf('Runinng ISLR...  0%%');
lam_1_ISR=0.2;lam_2_ISLR=.07;
k=1;mu=.02;Nit=10;
tic
for l=1:size(data,2)
    l
ISLR_out(:,l)=ISLR_stft_seismic(data(:,l),R,M,K,Nfft,k,lam_1_ISR,lam_2_ISLR,mu,Nit,penalty_func);
end
tic_slr_opt=toc;
snr_ISLR=snr(d,ISLR_out-d)
%% 
[m,n]=size(data);
t=(0:m-1)*dt;gamma=.08;
wav_type='bump';

tic
for i=1:n
    i
    optwsst_out(:,i) = opt_shrink_wsst_den(data(:,i),t,16,18,gamma,wav_type);
end
tic_optwsst=toc;
snr_optwsst=snr(d, optwsst_out-d)
% 
[snr_optwsst,snr_ISLR,snr_optslr,snrou,snr_NLM_OUT]
% 
%  mkdir('C:\Users\rasoul\Desktop\dd',['snr',num2str(round(snrint))])
% save(['C:\Users\rasoul\Desktop\dd\snr',num2str(round(snrint)),'\matlab'])