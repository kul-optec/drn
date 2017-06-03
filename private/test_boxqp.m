% Box-QP test

close all;
clear;

load('test_boxqp_data.mat');

n = size(Q, 2);

f = Quadratic(Q, q);
g = IndBox(lb, ub);

Lf = norm(Q);
gam = 0.95/Lf;
opt.tol = 1e-14;
opt.display = 0;

% Solve using DRN

[x_drn, out] = drn(f, g, zeros(n, 1), gam, opt);

assert(norm(x_drn - x_star)/(1+norm(x_star)) <= 1e-10);

% Solve using NADMM

[x_nadmm, out] = nadmm(f, g, 1, -1, 0, zeros(n, 1), gam, opt);

assert(norm(x_nadmm - x_star)/(1+norm(x_star)) <= 1e-10);
