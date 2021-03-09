function [den_data] = seis_den_gmc_real(data,dt,lam_GMC,gamma,rho,x_part,y_part,sigma1,sigma2,Nfft,fcut)
% warning off

for i=1:size(data,2)
    den_trace = Tp_non_covex_srls_GMC(data(:,i),size(data,1),lam_GMC,gamma,rho);
    den_trace=den_trace';
    data_sparse(:,i)=den_trace;
end
fN = 1/(2*dt);
f1 = (1/dt)*(0:Nfft-1)/Nfft;
[nt,nx]=size(data);
x_step = nx/x_part;
y_step = nt/y_part;
for i=1:y_part
    for j=1:x_part
        [i,j]
%         win_sec = data_sparse((i-1)*y_step+1:i*y_step,(j-1)*x_step+1:j*x_step);
win_sec=data;
        F=fft(win_sec,Nfft);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%conventional%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
    for k=1:size(F,1)
% vectr=F(k,:);
               vectr=real(F(k,:));
            vecti=imag(F(k,:));
            [hank_vectr]=my_hankel(vectr);
%             size(hank_vectr)
            [hank_vecti]=my_hankel(vecti);
            %% 
            [Ur Sr Vr]=svd(hank_vectr);
            [Ui Si Vi]=svd(hank_vecti);
%% 

             s = optimal_shrinkage(diag(Sr),1,'op',sigma1);
             si = optimal_shrinkage(diag(Si),1,'op',sigma2);
             hank_vectr_low=Ur*diag(s)*Vr';
            hank_vecti_low=Ui*diag(si)*Vi';
            [vectr_low]=inv_my_hankel(hank_vectr_low);
            [vecti_low]=inv_my_hankel(hank_vecti_low);
            FFF(k,:)=complex(vectr_low,vecti_low);
% FFF(k,:)=vectr_low;
        end
        tap_vec=zeros(1,Nfft);
        tap_vec(f1>=fcut & f1<=(2*fN-fcut))=1;
        sm=ones(1,5);
        tap_vec=conv(tap_vec,sm,'same');
        tap_vec=tap_vec/max(tap_vec);
        tap_mat=repmat(1-tap_vec(:),1,x_step);
        temp=real(ifft(FFF.*tap_mat));
        den_data((i-1)*y_step+1:i*y_step,(j-1)*x_step+1:j*x_step)=temp(1:y_step,:);
        den_data=temp(1:y_step,:);

    end
end


