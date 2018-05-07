clc;
clear;

% strFunc = input('Enter your function: ', 's');
% func = str2func(strcat('@(x)', strFunc));

% Задаем функции
func = @(x) 1000/(x.^2 - 6 * x + 76);
dfunc = @(x) -(2000 * (x - 3))/(x.^2 - 6 * x + 76).^2;
d2func = @(x) (2000 * (3 * x.^2 - 18 * x - 40))/((x.^2 - 6 * x + 76).^3);

% Вводим количество точек для функции
num = 10;
points = linspace(0,2,num);

% Задаем точку, в которой будем высчитывать значение погрешности
pointNumber = 5;

% Задаем точки для последующих вычислений и построения графика
loop = num : 200;

% Создаем векторы для построения графиков

plot1 = zeros(1, length(loop) - 9);
plot2 = zeros(1, length(loop) - 9);
plot3 = zeros(1, length(loop) - 9);
plot4 = zeros(1, length(loop) - 9);
plot5 = zeros(1, length(loop) - 9);
plot6 = zeros(1, length(loop) - 9);

%  Высчитываем значения нашей функции и ее производных
for i = 1 : num
    values(i) = func(points(i));
    dValues(i) = dfunc(points(i));
    d2Values(i) = d2func(points(i));
end

% точка, которую мы выбрали для высчитывания погрешности
chosenPoint = points(pointNumber);

% Шумим значения нашей функции
for i = 1 : num
    noisedValues(i) = values(i);
end



% Вычисляем производную функции по первой формуле
for i = 3 : (num - 3)
   d1(i) = (noisedValues(i + 1) - noisedValues(i))/(points(i + 1) - points(i));
end
delta1 = abs(dfunc(chosenPoint) - d1(pointNumber));
alpha1 = -log(delta1)/log(pointNumber);
plot1(1) = alpha1;

% Вычисляем производную функции по второй формуле
for i = 3 : (num - 3)
   d2(i) = (-3 * noisedValues(i) + 4 * noisedValues(i + 1) - noisedValues(i + 2))/(points(i + 1) - points(i - 1));
end
delta2 = abs(dfunc(chosenPoint) - d2(pointNumber));
alpha2 = -log(delta2)/log(pointNumber);
plot2(1) = alpha2;

% Вычисляем производную функции по третьей формуле
for i = 3 : (num - 3)
   d3(i) = (-11 * noisedValues(i) + 18 * noisedValues(i + 1) - 9 * noisedValues(i + 2) + 2 * noisedValues(i + 3))/(6 *(points(i + 1) - points(i)));
end
delta3 = abs(dfunc(chosenPoint) - d3(pointNumber));
alpha3 = -log(delta3)/log(pointNumber);
plot3(1) = alpha3;

% Вычисляем производную функции по четвертой формуле
for i = 3 : (num - 3)
   d4(i) = (-3 * noisedValues(i) + 4 * noisedValues(i + 1) - noisedValues(i + 2))/(2 * (points(i + 1) - points(i)));
end
delta4 = abs(dfunc(chosenPoint) - d4(pointNumber));
alpha4 = -log(delta4)/log(pointNumber);
plot4(1) = alpha4;

% Вычисляем производную функции по пятой формуле
for i = 3 : (num - 3)
%  !!!Здесь формула была немного изменена, так как в политеховском учебнике в
%  знаменателе стоит h^2, в то время как на паре был дан просто h!!!
   d5(i) = (noisedValues(i + 1) - 2* noisedValues(i) + noisedValues(i - 1))/((points(i + 1) - points(i)).^2);
end
delta5 = abs(d2func(chosenPoint) - d5(pointNumber));
alpha5 = -log(delta5)/log(pointNumber);
plot5(1) = alpha5;

% Вычисляем производную функции по шестой формуле
for i = 3 : (num - 3)
   d6(i) = (2 * noisedValues(i) - 5 * noisedValues(i + 1) + 4 * noisedValues(i + 2) -  noisedValues(i + 3))/((points(i + 1) - points(i)).^2);
end
delta6 = abs(d2func(chosenPoint) - d6(pointNumber));
alpha6 = -log(delta6)/log(pointNumber);
plot6(1) = alpha6;


% Начинаем в цикле смотреть на изменение погрешности при увеличении
% количества точек
for k = (num + 1):(length(loop) + num - 1)
    newPoints = linspace(0,2,k);
%     Находим наиболее приближенную точку к той, которую мы брали
    [d, index] = min(abs(points - chosenPoint));
    newChosenPoint = newPoints(index);
        
    %  Высчитываем значения нашей функции и ее производных
    for i = 1 : k
        values(i) = func(newPoints(i));
        dValues(i) = dfunc(newPoints(i));
        d2Values(i) = d2func(newPoints(i));
    end

    % Шумим значения нашей функции
    for i = 1 : k
        noisedValues(i) = values(i);
    end



    % Вычисляем производную функции по первой формуле
    for i = 3 : (k - 3)
       d1(i) = (noisedValues(i + 1) - noisedValues(i))/(newPoints(i + 1) - newPoints(i));
    end
    delta1 = abs(dfunc(newChosenPoint) - d1(index));
    alpha1 = -log(delta1)/log(k);
    plot1(k - 9) = alpha1;

    % Вычисляем производную функции по второй формуле
    for i = 3 : (k - 3)
       d2(i) = (-3 * noisedValues(i) + 4 * noisedValues(i + 1) - noisedValues(i + 2))/(newPoints(i + 1) - newPoints(i - 1));
    end
    delta2 = abs(dfunc(newChosenPoint) - d2(index));
    alpha2 = -log(delta2)/log(k);
    plot2(k - 9) = alpha2;

    % Вычисляем производную функции по третьей формуле
    for i = 3 : (k - 3)
       d3(i) = (-11 * noisedValues(i) + 18 * noisedValues(i + 1) - 9 * noisedValues(i + 2) + 2 * noisedValues(i + 3))/(6 *(newPoints(i + 1) - newPoints(i)));
    end
    delta3 = abs(dfunc(newChosenPoint) - d3(index));
    alpha3 = -log(delta3)/log(k);
    plot3(k - 9) = alpha3;

    % Вычисляем производную функции по четвертой формуле
    for i = 3 : (k - 3)
       d4(i) = (-3 * noisedValues(i) + 4 * noisedValues(i + 1) - noisedValues(i + 2))/(2 * (newPoints(i + 1) - newPoints(i)));
    end
    delta4 = abs(dfunc(newChosenPoint) - d4(index));
    alpha4 = -log(delta4)/log(k);
    plot4(k - 9) = alpha4;

    % Вычисляем производную функции по пятой формуле
    for i = 3 : (k - 3)
    %  !!!Здесь формула была немного изменена, так как в политеховском учебнике в
    %  знаменателе стоит h^2, в то время как на паре был дан просто h!!!
       d5(i) = (noisedValues(i + 1) - 2* noisedValues(i) + noisedValues(i - 1))/((newPoints(i + 1) - newPoints(i)).^2);
    end
    delta5 = abs(d2func(newChosenPoint) - d5(index));
    alpha5 = -log(delta5)/log(k);
    plot5(k - 9) = alpha5;

    % Вычисляем производную функции по шестой формуле
    for i = 3 : (k - 3)
       d6(i) = (2 * noisedValues(i) - 5 * noisedValues(i + 1) + 4 * noisedValues(i + 2) -  noisedValues(i + 3))/((newPoints(i + 1) - newPoints(i)).^2);
    end
    delta6 = abs(d2func(newChosenPoint) - d6(index));
    alpha6 = -log(delta6)/log(k);
    plot6(k - 9) = alpha6;
end

plot (loop, plot1, 'm');
hold on 
plot (loop, plot2, 'b');
plot (loop, plot3, 'c');
plot (loop, plot4, 'k');
plot (loop, plot5, 'g');
plot (loop, plot6, 'y');
legend('alpha 1 - m', 'alpha 2 - b', 'alpha 3 - c', 'alpha 4 - k', 'alpha 5 - g', 'alpha 6 - y');


