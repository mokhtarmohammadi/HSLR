cormat=c_corr(noisy_data,denoised_data, 5);
imagesc(1:size(den_data,2),(0:size(den_data,1)-1)*dt,abs(cormat))
ax = gca;
ax.FontSize=20;
box on
xlabel('Trace No.','FontSize',20)
ylabel('Time (s) ','FontSize',20)
text(-8,0,'e)','FontSize',20)