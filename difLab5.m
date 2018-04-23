clc;
clear;

func = @(x) 100/(x.^2 - 6 * x + 70);
dfunc = @(x) -(1000 * (2 + x))/(x.^2 - 6 * x + 70).^2;
d2func = @(x) (3000 * (x.^2 - 6 * x + 70))/((x.^2 - 6 * x + 70).^3);

n = 10;
points = linspace(0, 2, n);

loop = n : 100;

plot1 = zeros(size(loop) - 9);
plot2 = zeros(size(loop) - 9);
plot3 = zeros(size(loop) - 9);
plot4 = zeros(size(loop) - 9);
plot5 = zeros(size(loop) - 9);
plot6 = zeros(size(loop) - 9);

for j = loop
    
    if (j == 10)
        for i = 1 : j
            values(i) = dfunc(points(i));
        end
        dfuncValues = values;
        mPoint = points(5);

        for i = 3 : (j - 3)
%             f12(i) = func(points(i - 2));
%             f11(i) = func(points(i - 1));
%             f0(i) = func(points(i));
%             f1(i) = func(points(i + 1));
%             f2(i) = func(points(i + 2));
%             f3(i) = func(points(i + 3));

            % немного шумим функции
            f12(i) = func(points(i - 2)) + (rand * 0.0001 - 0.00005);
            f11(i) = func(points(i - 1)) + (rand * 0.0001 - 0.00005);
            f0(i) = func(points(i)) + (rand * 0.0001 - 0.00005);
            f1(i) = func(points(i + 1)) + (rand * 0.0001 - 0.00005);
            f2(i) = func(points(i + 2)) + (rand * 0.0001 - 0.00005);
            f3(i) = func(points(i + 3)) + (rand * 0.0001 - 0.00005);
        end
        
% % % % % %       (1)
        for i = 3 : (j - 3)
            d1(i) = (f1(i) - f0(i))/(points(i + 1) - points(i));
        end
        delta1 = abs(dfunc(mPoint) - d1(5));
        alpha1 = -log(delta1)/log(5);
        plot1(j - 9) = alpha1;
        
% % % % % %       (2)  
        for i = 3 : (j - 3)
            d2(i) = (f1(i) - f11(i))/(points(i + 1) - points(i - 1));
        end 
        delta2 = abs(dfunc(mPoint) - d2(5));
        alpha2 = -log(delta2)/log(5);
        plot2(j - 9) = alpha2;
        
% % % % % %       (3)  
        for i = 3 : (j - 3)
            d3(i) = (- 3 * f0(i) + 4 * f1(i) - f2(i))/(points(i + 2) - points(i));
        end 
        delta3 = abs(dfunc(mPoint) - d3(5));
        alpha3 = -log(delta3)/log(5);
        plot3(j - 9) = alpha3;
        
% % % % % %       (4)  
        for i = 3 : (j - 3)
            d4(i) = (- 11 * f0(i) + 18 * f1(i) - 9 * f2(i) + 2 * f3(i))/(3 * (points(i + 2) - points(i)));
        end 
        delta4 = abs(dfunc(mPoint) - d4(5));
        alpha4 = -log(delta4)/log(5);
        plot4(j - 9) = alpha4;        
        
% % % % % %       (5)  
        for i = 3 : (j - 3)
            d5(i) = (f1(i) - 2 * f0(i) + f11(i))/((points(i + 1) - points(i)).^2);
        end 
        delta5 = abs(d2func(mPoint) - d5(5));
        alpha5 = -log(delta5)/log(5);
        plot5(j - 9) = alpha5;
        
% % % % % %       (6)  
        for i = 3 : (j - 3)
            d6(i) = (- f12(i) + 16 * f11(i) - 30 * f0(i) + 16 * f1(i) - f2(i))/(12 * (points(i + 1) - points(i)).^2);
        end 
        delta6 = abs(d2func(mPoint) - d6(5));
        alpha6 = -log(delta6)/log(5);
        plot6(j - 9) = alpha6;          
    else

        points = linspace(0, 2, j);
        [d, index] = min(abs(points - mPoint));
        
        mPoint12 = points(index - 2);
        mPoint11 = points(index - 1);
        mPoint0 = points(index);
        mPoint1 = points(index + 1);
        mPoint2 = points(index + 2);
        mPoint3 = points(index + 3);
        
        f12 = func(mPoint12) + (rand * 0.0001 - 0.00005);
        f11 = func(mPoint11) + (rand * 0.0001 - 0.00005);
        f0 = func(mPoint0) + (rand * 0.0001 - 0.00005);
        f1 = func(mPoint1) + (rand * 0.0001 - 0.00005);
        f2 = func(mPoint2) + (rand * 0.0001 - 0.00005);
        f3 = func(mPoint3) + (rand * 0.0001 - 0.00005);
        
%         f12 = func(mPoint12);
%         f11 = func(mPoint11);
%         f0 = func(mPoint0);
%         f1 = func(mPoint1);
%         f2 = func(mPoint2);
%         f3 = func(mPoint3);

% % % % % % % % %  (1) 
        d1 = (f1 - f0)/(mPoint1 - mPoint0);
        delta1 = abs(dfunc(mPoint0) - d1);
        alpha1 = -log(delta1)/log(index);
        plot1(j - 9) = alpha1;
        
% % % % % % % % %  (2)        
        d2 = (f1 - f11)/(mPoint1 - mPoint11);
        delta2 = abs(dfunc(mPoint0) - d2);
        alpha2 = -log(delta2)/log(index);
        plot2(j - 9) = alpha2;
        
% % % % % % % % %  (3)        
        d3 = (-3 * f0 + 4 * f1 - f2)/(mPoint2 - mPoint0);
        delta3 = abs(dfunc(mPoint0) - d2);
        alpha3 = -log(delta3)/log(index);
        plot3(j - 9) = alpha3;
        
% % % % % % % % %  (4)        
        d4 = (-11 * f0 + 18 * f1 - 9 * f2 + 2 * f3)/(3 * (mPoint2 - mPoint0));
        delta4 = abs(dfunc(mPoint0) - d4);
        alpha4 = -log(delta4)/log(index);
        plot4(j - 9) = alpha4; 
        
% % % % % % % % %  (5)        
        d5 = (f1 - 2 * f0 + f11)/((mPoint1 - mPoint0).^2);
        delta5 = abs(d2func(mPoint0) - d5);
        alpha5 = -log(delta5)/log(index);
        plot5(j - 9) = alpha5;
        
% % % % % % % % %  (6)        
        d6 = (- f12 + 16 * f11 - 30 * f0 + 16 * f1 - f2)/(12 * (mPoint1 - mPoint0).^2);
        delta6 = abs(d2func(mPoint0) - d6);
        alpha6 = -log(delta6)/log(index);
        plot6(j - 9) = alpha6;          
    end

end

plot (loop, plot1, 'm');
hold on 
plot (loop, plot2, 'b');
plot (loop, plot3, 'c');
plot (loop, plot4, 'k');
plot (loop, plot5, 'g');
plot (loop, plot6, 'y');
legend('alpha 1 - m', 'alpha 2 - b', 'alpha 3 - c', 'alpha 4 - k', 'alpha 5 - g', 'alpha 6 - y');
