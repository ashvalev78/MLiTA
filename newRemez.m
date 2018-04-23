clc;
clear;

leftB = input('Enter the left border: ');
rightB = input('Enter the right border: ');
num = input('Enter the degree of polynome: ');
strFunc = input('Enter the function: ', 's');
% func = str2func(strcat('@(x)', strFunc));
% 
% leftB = -2;
% rightB = 7;
% % func = @(x)sin(x);
% func = @(x)1000/(x.^2-6*x+76);

% func = @(x) 1000/(x.^2-6*x+76);
func = @(x) 1000/(x.^2-3*x+56);

% num = 5;
% num = 10;


% ����� ��� ���������� ��������
nodesT = linspace(leftB, rightB, num + 2);
lengthT = length(nodesT);

delta = 1;

while delta > 10^(-2)
    
    % %     ������ �������� �������
    for i = 1 : lengthT
        valuesT(i) = func(nodesT(i));
    end
    B = valuesT;
    
    % %     ���������� ����� � �����
    A = ones(lengthT, lengthT);
    for i = 1 : (lengthT / 2)
        A(2 * i, 1) = -1;
    end
    for i = 1 : lengthT
        for j = 3 : lengthT
            A(i, j) = nodesT(i) ^ (j - 2);
        end
    end
    
    x = linsolve(A, B');
    sygma = x(1);
    
    % %     ���������� �������� ����������������� ��������

    p = zeros(1, num + 1);
    for i = 1 : (num + 1)
        p(i) = x(num + 2 - i + 1);
    end
    
    % %     ������� ����� ��� ���������� �������

%     ����� ��� "��������" ������� � ������� ��������
    nodesF = linspace(leftB, rightB, 10000);
    lengthF = length(nodesF);
    polynom = polyval(p, nodesF); 
    
    % %     ����� ����������� �������� ��������

    max = 0;
    index = 0;
    for i = 1 : lengthF
        valuesF(i) = func(nodesF(i));
        m(i) = abs(valuesF(i) - polyval(p, nodesF(i)));
        if m(i) > max
%             % �������� ������� � ����� ���� ��������
            vm = func(nodesF(i));
%             % �����, � ������� ��� ���������
            index = i;
% %             ������������ ������ �������� ����� ���������� �������
            max = m(i);
            indexMax = nodesF(index);
        end
    end
%     check = nodesT;
    length(nodesF);
    
    t = 1;
    for i = 1 : lengthT
        if and(nodesT(i) > indexMax, i > 1)
            t = i - 1;
            break;
        end
    end
    if(nodesT(end) < indexMax)
        t = lengthT;
    end
    a = t;
    pMax = polyval(p, indexMax);
    
    plotVec = [leftB, rightB, -15, 15];
    
    % %     ����� �������� �� �����
%     plot(nodesF, valuesF, 'b');
    axis(plotVec)
    grid on
    hold on
    plot(nodesF, polynom, 'g');
    plot(nodesT, B, 'ko');
    
    plot(indexMax, pMax, 'r.');
    plot(indexMax, func(indexMax), 'y.');
    legend('function', 'polynom')
    hold off
    
% %     ��������� ��������� ����� � ����� ���� ��� ������ ����

    ptLeft = polyval(p, nodesT(t));
    valueMax = pMax - vm;
    signLeft = ptLeft - func(nodesT(t));
    if and (valueMax < 0, signLeft < 0)
        nodesT(t) = indexMax;
        b = 1;
    elseif and(valueMax > 0, signLeft > 0)
        nodesT(t) = indexMax;
        b =1;
    else
        nodesT(t+1) = indexMax;
    end
    
    delta = max - sygma;
end