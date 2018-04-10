dif = 0;
stringLimit = 1;
columnLimit = 1;
plotDif = dif;
plotLimit = columnLimit;
while dif < 0.01
    A = zeros(stringLimit, columnLimit);
    for i = 1:stringLimit
        for j = 1:columnLimit 
            A(i,j) = i^j;
        end;
    end;
    B = eye(stringLimit, columnLimit);
    stringLimit = stringLimit + 1;
    columnLimit = columnLimit + 1;
    invA = inv(A);
    dif = max(max(A*invA - B));
    plotDif = [plotDif, dif];
    plotLimit = [plotLimit, columnLimit];
end;
plot(plotLimit, plotDif);