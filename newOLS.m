clc;
clear;

a = input('Enter the left border: ');
b = input('Enter the right border: ');
num = input('Enter the number of points: ');

x = linspace(a, b, num);

strFunc = input('Enter the function: ', 's');
func = str2func(strcat('@(x)', strFunc));

y = func(x);

degree = 1 : num/2;

fault = zeros(1, length(degree));

px = linspace(a, b, 100);
fy = func(px);
alpha = zeros(1, length(degree));

for i = degree,

  LSMCoefs = getLSMCoefs(x, y, i);
  py = polyval(LSMCoefs, px);

  pause(0.1);
  figure(1);
  axis([a, b, -1.5, 1.5])
  plot(px, fy, px, py);

  fault(i) = max(abs(fy - py));
  alpha(i) = -log(fault(i))/log(i);

end;


figure(2);
plot (degree, alpha, 'r');
