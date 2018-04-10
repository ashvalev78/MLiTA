x = 1:0.1:10;
p = 1:10;
y = sin(x);
otvet = notStableNewton(p, x, y)
lagr = lagrange(x, y, p)