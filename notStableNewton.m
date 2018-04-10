function yy = notStableNewton(xx, x, y)
Poly = zeros(size(xx));
n = length(x);
for i = 1:n 
    tale = ones(size(xx));
    for j = 1:(i - 1) 
        tale = tale.*(xx - x(j));
    end;
    Poly = Poly + tale.*dividedDiff(x, y, i);
end;

yy = Poly;