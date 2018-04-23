function out = getLSMCoefs(x, y, n)
  
  % Vandermonde matrix
  x = x(:);
  y = y(:);
  V = ones(length(x), n + 1);
  for j = n:-1:1
    V(:, j) = V(:, j + 1) .* x;
  end
  
  % calculate coeffs
  out = (V \ y)';
  