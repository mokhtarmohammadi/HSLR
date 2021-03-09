function seismic_plot_3D(data3d,attrib,a,b,c)
% a = cross-section perpendicular to y-axis
% b = cross-section perpendicular to x-axis
% c = cross-section perpendicular to z-axis
% data3d = 3D data with (inline x crossline x time)
% attrib = 3D attrib with (inline x crossline x time)
[m,n,k]=size(data3d);
data3d2=data3d;
data3d2(1:a,1:b,1:c)=nan;
slice(data3d2,[1 b+1 n],[1 a+1 m],[1 c+1 k])
% colormap(seismic(2))
% freezeColors
hold on
slice(attrib,[],[],[c+1])
% colormap(seismic(2))
% colormap jet
shading interp
set(gca,'ZDir','reverse')
xlim([1 n]),ylim([1 m]),zlim([1 k])
hold on

if a>=m
    a=m-1;
end
if b>=n
    b=n-1;
end
if c>=k
    c=k-1;
end

plot3([1 n],[1 1],[k k],'linewidth',2,'color','k')
plot3([1 n],[m m],[k k],'linewidth',2,'color','k')
plot3([1 n],[m m],[1 1],'linewidth',2,'color','k')
plot3([b+1 n],[1 1],[1 1],'linewidth',2,'color','k')
plot3([1 b],[1 1],[1 1],'linewidth',1,'color','k','linestyle','--')
plot3([1 b+1],[1 1],[c+1 c+1],'linewidth',2,'color','k')
plot3([1 b+1],[a+1 a+1],[c+1 c+1],'linewidth',2,'color','k')
plot3([1 b+1],[a+1 a+1],[1 1],'linewidth',2,'color','k')

plot3([1 1],[1 m],[k k],'linewidth',2,'color','k')
plot3([n n],[1 m],[k k],'linewidth',2,'color','k')
plot3([n n],[1 m],[1 1],'linewidth',2,'color','k')
plot3([1 1],[1 a+1],[c+1 c+1],'linewidth',2,'color','k')
plot3([1 1],[a+1 m],[1 1],'linewidth',2,'color','k')
plot3([1 1],[1 a],[1 1],'linewidth',1,'color','k','linestyle','--')
plot3([b+1 b+1],[1 a+1],[1 1],'linewidth',2,'color','k')
plot3([b+1 b+1],[1 a+1],[c+1 c+1],'linewidth',2,'color','k')

plot3([1 1],[m m],[1 k],'linewidth',2,'color','k')
plot3([1 1],[a+1 a+1],[1 c+1],'linewidth',2,'color','k')
plot3([b+1 b+1],[a+1 a+1],[1 c+1],'linewidth',2,'color','k')
plot3([b+1 b+1],[1 1],[1 c+1],'linewidth',2,'color','k')
plot3([n n],[m m],[1 k],'linewidth',2,'color','k')
plot3([n n],[1 1],[1 k],'linewidth',2,'color','k')
plot3([1 1],[1 1],[c+1 k],'linewidth',2,'color','k')
plot3([1 1],[1 1],[1 c],'linewidth',1,'color','k','linestyle','--')
