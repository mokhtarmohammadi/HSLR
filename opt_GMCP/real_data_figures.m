subplot(2,2,1)
imagesc(d(156:end,:))
colormap(gray);
text(35,370,'(a)','FontSize',20)
ax = gca;
ax.FontSize=14;
box on
xlabel('Trace No.','FontSize',14)
ylabel('Time sampling number','FontSize',14)
subplot(2,2,2)
% figure
imagesc(dd(156:end,:))
colormap(gray);
text(35,370,'(b)','FontSize',20)
ax = gca;
ax.FontSize=14;
box on
xlabel('Trace No.','FontSize',14)
ylabel('Time sampling number','FontSize',14)
% figure
subplot(2,2,1)
imagesc(den_data(156:end,:))
colormap(gray);
text(35,360,'(a)','FontSize',20)
ax = gca;
ax.FontSize=14;
box on
xlabel('Trace No.','FontSize',14)
ylabel('Time sampling number','FontSize',14)
% subplot(2,2,2)
% imagesc(dd(156:end,:))
% colormap(gray);
% text(-3.5,3,'a)','FontSize',14)
% ax = gca;
% ax.FontSize=14;
% box on
% xlabel('Trace No.','FontSize',14)
% ylabel('Time sampling number','FontSize',14)
subplot(2,2,2)
% figure
imagesc(NLM_OUT(156:end,:))
colormap(gray);
text(35,370,'(b)','FontSize',20)
ax = gca;
ax.FontSize=14;
box on
xlabel('Trace No.','FontSize',14)
ylabel('Time sampling number','FontSize',14)
subplot(2,2,3)
% figure
imagesc(opt_slr_opt(156:end,:))
colormap(gray);
text(35,370,'(c)','FontSize',20)
ax = gca;
ax.FontSize=20;
box on
xlabel('Trace No.','FontSize',20)
ylabel('Time sampling number','FontSize',20)
subplot(2,2,4)
% figure
imagesc(optwsst_out(156:end,:))
colormap(gray);
text(35,370,'(d)','FontSize',20)
ax = gca;
ax.FontSize=20;
box on
xlabel('Trace No.','FontSize',20)
ylabel('Time sampling number','FontSize',20)
% close all
figure;
subplot(2,2,1)
imagesc(dd(156:end,:)-den_data(156:end,:))
colormap(gray);
text(35,370,'(a)','FontSize',20)
ax = gca;
ax.FontSize=20;
box on
xlabel('Trace No.','FontSize',20)
ylabel('Time sampling number','FontSize',20)
subplot(2,2,2)
% figure
imagesc(dd(156:end,:)-NLM_OUT(156:end,:))
colormap(gray);
text(35,370,'(b)','FontSize',20)
ax = gca;
ax.FontSize=14;
box on
xlabel('Trace No.','FontSize',20)
ylabel('Time sampling number','FontSize',20)
subplot(2,2,3)
% figure
imagesc(dd(156:end,:)-opt_slr_opt(156:end,:))
colormap(gray);
text(35,370,'(c)','FontSize',20)
ax = gca;
ax.FontSize=20;
box on
xlabel('Trace No.','FontSize',20)
ylabel('Time sampling number','FontSize',20)
subplot(2,2,4)
% figure
imagesc(dd(156:end,:)-optwsst_out(156:end,:))
colormap(gray);
text(35,370,'(d)','FontSize',20)
ax = gca;
ax.FontSize=20;
box on
xlabel('Trace No.','FontSize',20)
ylabel('Time sampling number','FontSize',20)
%% 
wlen=5;
cormat1=c_corr(dd(156:end,:),den_data(156:end,:), wlen)
cormat2=c_corr(dd(156:end,:),NLM_OUT(156:end,:), wlen)
cormat3=c_corr(dd(156:end,:),opt_slr_opt(156:end,:), wlen)
cormat4=c_corr(dd(156:end,:),optwsst_out(156:end,:), wlen)
figure
subplot(2,2,1)
imagesc(cormat1)
imagesc((1:75),1:357,abs(cormat1)); 
% colormap(gray);
text(-3.5,3,'a)','FontSize',14)
ax = gca;
ax.FontSize=14;
box on
xlabel('Trace No.','FontSize',14)
ylabel('Time sampling number','FontSize',14)
subplot(2,2,2)
imagesc((1:75),1:357,abs(cormat2)); 

text(-3.5,3,'b)','FontSize',14)
ax = gca;
ax.FontSize=14;
box on
xlabel('Trace No.','FontSize',14)
ylabel('Time sampling number','FontSize',14)
subplot(2,2,3)
imagesc((1:75),1:357,abs(cormat3)); 

text(-3.5,3,'c)','FontSize',14)
ax = gca;
ax.FontSize=14;
box on
xlabel('Trace No.','FontSize',14)
ylabel('Time sampling number','FontSize',14)
subplot(2,2,4)
imagesc((1:75),1:357,abs(cormat4)); 

text(-3.5,3,'d)','FontSize',14)
ax = gca;
ax.FontSize=14;
box on
xlabel('Trace No.','FontSize',14)
ylabel('Time sampling number','FontSize',14)