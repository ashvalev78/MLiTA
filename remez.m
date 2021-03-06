a = input('Enter the left border: ');
		num = input('Enter the number of points: ');
% 		if (num <= 3) error('Incorrect number'); end;
		h = input('Enter the distance between points: ');
% 		if or(h <= 0) error('Incorrect distance'); end;
		strFunc = input('Enter the function: ', 's');
		f = str2func(strcat('@(x)', strFunc));
		b = a + h*num;

		x = a:h:b;
		px = a:0.1:b;

		A = zeros(num, num);
		for i = 1:num,
			for j = 1:num - 2,
				A(i, j) = x(i).^(num-2 + 1 - j); 
			end;
			A(i, num - 1) = 1;
			A(i, num) = (-1).^(i);
		end;
		A
		fvect = zeros(num, 1);
		for i = 1:num,
			fvect(i) = f(x(i));
		end;
		fvect
		alph = linsolve(A, fvect)
		x = a:h:b;
 		Q = zeros(length(x), 1);
 		for i = 1:length(x)
			for j = 2:num,
				Q(i) = Q(i) + alph(j) * (x(i).^(j - 2));
			end;
		end;
		Q
		plot(x, Q)