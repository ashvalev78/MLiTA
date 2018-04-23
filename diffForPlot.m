function out = diffForPlot(func, d, index)
delta = abs(func - d);
alpha = -log(delta6)/log(index);

out = alpha;
