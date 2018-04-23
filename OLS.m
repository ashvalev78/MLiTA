clc;
clear;

leftB = input('Enter the left border: ');
rightB = input('Enter the right border: ');
nodes = input('Enter the number of nodes: ');

% nodes = 20;
x = linspace(leftB, rightB, nodes);
func = @(a) sin(a);
y = func(x);

degree = 1 : 10;
% degree = 1 : 25;
% degree = 1 : 100;
plotError = zeros(size(degree));

for i = degree
    polyCoefficients = polyfit(x, y, i);
    points = linspace(x(1), x(end), 100);
    funcInPoints = func(points);
    polInPoints = polyval(polyCoefficients, points);
    
    figure(1);
    grid on
    plot(x, y, 'ko', points, polInPoints, 'b')
    axis([leftB, rightB, -1.5, 1.5])
    pause(0.25);
%     pause(0.001);
    
    plotError(i) = max(abs(polInPoints-funcInPoints));
end

figure(2);
plot (degree, plotError, 'm');
