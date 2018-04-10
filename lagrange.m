function yy=lagrange(x,y,xx)

N=length(x);
% создаем нулевой массив значений интерполяционного полинома
yy=zeros(size(xx));
for k=1:N
    t=ones(size(xx));
    for j=[1:k-1, k+1:N]
        t=t.*(xx-x(j))/(x(k)-x(j));
    end;
    yy = yy + y(k)*t;
end;