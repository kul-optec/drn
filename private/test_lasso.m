% Lasso test

close all;
clear;

load('test_lasso_data.mat');

[m, n] = size(A);

f = LeastSquares(A, b);
g = NormL1(lam);

Lf = norm(A)^2;
gam = 0.95/Lf;
opt.tol = 1e-14;
opt.display = 0;

% Solve using DRN

[x_drn, out] = drn(f, g, zeros(n, 1), gam, opt);

assert(norm(x_drn - x_star)/(1+norm(x_star)) <= 1e-10);
