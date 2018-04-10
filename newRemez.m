% clc;
% clear;
% 
% % leftB = input('Enter the left border: ');
% % rightB = input('Enter the right border: ');
% % num = input('Enter the number of points: ');
% % strFunc = input('Enter the function: ', 's');
% % func = str2func(strcat('@(x)', strFunc));
% 
% leftB = -2;
% rightB = 7;
% % func = @(x)sin(x);
% func = @(x)1000/(x.^2-6*x+76);
% num = 5;
% 
% nodesT = linspace(leftB, rightB, num + 2);
% lengthT = length(nodesT);
% 
% delta = 1;
% 
% while delta > 10^(-1)
%     
%     fig = 1;
%     
% %     Расчет значений функции
%     for i = 1 : lengthT
%         valuesT(i) = func(nodesT(i));
%     end
%     B = valuesT;
%     
% %     Нахождение альфа и сигма
%     A = ones(lengthT, lengthT);
%     for i = 1 : (lengthT / 2)
%         A(2 * i, 1) = -1;
%     end
%     for i = 1 : lengthT
%         for j = 3 : lengthT
%             A(i, j) = nodesT(i) ^ (j - 2);
%         end
%     end
% %     x - альфа, sygma - сигма
%     x = linsolve(A, B');
%     sygma = x(1);
%     
% %     Нахождение значений интерполяционного полинома
%     p = zeros(1, num + 1);
%     for i = 1 : (num + 1)
%         p(i) = x(num + 2 - i + 1);
%     end
%     
% %     Задание точек для построения графика
%     nodesF = linspace(leftB, rightB, 1000);
%     lengthF = length(nodesF);
%     polynom = polyval(p, nodesF);
%     
% %     Поиск наибольшего значения полинома
%     max = 0;
%     index = 1;
%     vm = 0;
%     for i = 1 : lengthF
%         valuesF(i) = func(nodesF(i));
%         m(i) = abs(valuesF(i) - polyval(p, nodesF(i)));
%         if m(i) > max
%             % значение функции в точке макс разности
%             vm = func(nodesF(i));
%             % точка, в которой оно находится
%             index = i;
% %             максимальный модуль разности между значениями функции
%             max = m(i);
%         end
%     end
% %     check = nodesT;
%     indexMax = nodesF(index);
%     
%     t = 1;
%     for i = 1 : lengthT
%         if and(nodesT(i) > indexMax, i > 1)
%             t = i - 1;
%             break;
%         end
%     end
%     if(nodesT(end) < indexMax)
%         t = lengthT;
%     end
%     a = t;
%     pMax = polyval(p, indexMax);
%     
%     plotVec = [leftB, rightB, -15, 15];
%     
% %     Вывод графиков на экран
%     figure(fig);
%     fig = fig + 1;
%     plot(nodesF, valuesF, 'b');
%     axis(plotVec)
%     grid on
%     hold on
%     plot(nodesF, polynom, 'm');
%     plot(nodesT, B, 'ko');
%     
% %     Отмечаем точки кружками
%     plot(indexMax, pMax, 'r.');
%     plot(indexMax, func(indexMax), 'r.');
%     legend('function', 'polynom')
%     hold off
% %     Обработка попадания точки в левый край или правый край
%     ptLeft = polyval(p, nodesT(t));
%     valueMax = pMax - vm;
%     signLeft = ptLeft - func(nodesT(t));
%     if and (valueMax < 0, signLeft < 0)
%         nodesT(t) = indexMax;
%         b = 1;
%     elseif and(valueMax > 0, signLeft > 0)
%         nodesT(t) = indexMax;
%         b =1;
%     else
%         nodesT(t+1) = indexMax;
%     end
% %     sygma
%     delta = max - sygma;
% end

clc;
clear;

func = @(x) 1000/(x.^2-6*x+76);

degree = 5;
% degree = 10;

nodesT = linspace(-3, 5, degree + 2);
lengthT = length(nodesT);

delta = 1;

while delta > 10^(-6)
    
    % %     Расчет значений функции
    for i = 1 : lengthT
        valuesT(i) = func(nodesT(i));
    end
    B = valuesT;
    
    % %     Нахождение альфа и сигма
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
    
    % %     Нахождение значений интерполяционного полинома

    p = zeros(1, degree + 1);
    for i = 1 : (degree + 1)
        p(i) = x(degree + 2 - i + 1);
    end
    
    % %     Задание точек для построения графика

    nodesF = linspace(-3, 5, 10000);
    lengthF = length(nodesF);
    polynom = polyval(p, nodesF); 
    
    % %     Поиск наибольшего значения полинома

    max = 0;
    index = 0;
    for i = 1 : lengthF
        valuesF(i) = func(nodesF(i));
        m(i) = abs(valuesF(i) - polyval(p, nodesF(i)));
        if m(i) > max
%             % значение функции в точке макс разности
            vm = func(nodesF(i));
%             % точка, в которой оно находится
            index = i;
% %             максимальный модуль разности между значениями функции
            max = m(i);
            indexMax = nodesF(index);
        end
    end
    check = nodesT;
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
    
    % %     Вывод графиков на экран
%     plot(nodesF, valuesF, 'b');
    axis([-3, 5, 6, 22])
    grid on
    hold on
    plot(nodesF, polynom, 'm');
    plot(nodesT, B, 'ko');
    
    plot(indexMax, pMax, 'r.');
    plot(indexMax, func(indexMax), 'r.');
    legend('function', 'polynom')
    hold off
    
% %     Обработка попадания точки в левый край или правый край

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