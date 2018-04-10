a = input('Enter the first border of the interpolation ');
b = input('Enter the second border of the interpolation ');
numberOfKnots = input('Enter the number of interpolation knots ');
% ��������� ������ ����
syms x;
f(x) = sin(x) + cos(x);
stepSize = (b - a)/numberOfKnots;
% ������ ����� ��� ���������� �������� �������
functionLimits = a:0.01:b;
LfunctionLimits = a:stepSize:b;
mainFunctionPlot = vpa(f(functionLimits));
LmainFunctionPlot = sin(LfunctionLimits) + cos(LfunctionLimits);
% ����� ����������� �� ������� �� ������
Num = numberOfKnots + 1;
Function(x) = diff(f(x), Num)
% �������� ����� ��� ���������� �����������
e = input('Enter the point for the difference count ');
% ����������� ������� w(x)
w = 1;
for i = 1:length(LfunctionLimits) 
    w = abs(w*(e - LfunctionLimits(i)));
end;
% ������� ���������� ���� ����������� �������
difference = max(abs(vpa(Function(functionLimits))));
fault = (difference/factorial(Num))*w
% ������� ������� ��������
polinome = lagrange(LfunctionLimits,LmainFunctionPlot,functionLimits);
% ���������� ��������
plot(functionLimits, mainFunctionPlot, 'r');
hold on;
plot(functionLimits, polinome, 'b');
% ������������ �����������
practDiff = abs(vpa(f(e)) - lagrange(LfunctionLimits,LmainFunctionPlot,e))

% ���������� ���������� ����������� �� ���� ��������� ab
biggestDiff = 0;
j = 1;
for i = functionLimits(1):0.01:b 
    diff1 = abs(mainFunctionPlot(j) - polinome(j));
    if (diff1 >= biggestDiff)
        biggestDiff = diff1;
    end;
    j = j + 1;
end;
biggestDiff