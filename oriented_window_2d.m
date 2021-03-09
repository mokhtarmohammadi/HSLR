function w = oriented_window_2d(A,pixel_row,pixel_column,p,op_length)

% input parameters:
% A = input image or matrix
% pixel_row,pixel_column = row and column of origin of window
% p = local dip in (pixel/column or sample/trace)
% op_length = size of window (must be odd integer value)
% output parameter:
% w = oriented window
x0=pixel_row;
y0=pixel_column;
if numel(op_length)==2
    m=op_length(1);
    n=op_length(2);
else
    m=op_length;
    n=op_length;
end
w=zeros(m,n);
i=1;
tempx=(m-1)/2;
tempy=(n-1)/2;
for j=y0-tempy:y0+tempy
    w(:,i)=A(((x0+(j-y0)*p)-tempx):((x0+(j-y0)*p)+tempx),j);
    i=i+1;
end