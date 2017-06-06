% Box-QP test

close all;
clear;

load('test_boxqp_data.mat');

n = size(Q, 2);

f = Quadratic(Q, q);
g = IndBox(lb, ub);

Lf = norm(Q);

opt.tol = 1e-12;
opt.display = 0;
opt.maxit = 1000;

% Solve using DRN

gam = 0.95/Lf;
out_drn = drn(f, g, zeros(n, 1), gam, opt);
x_drn = out_drn.z;

assert(norm(x_drn - x_star)/(1+norm(x_star)) <= 1e-8);

% Solve using NADMM

rho = 1/gam;
out_nadmm = nadmm(f, g, 1, -1, 0, zeros(n, 1), rho, opt);
x_nadmm = out_nadmm.z;

assert(norm(x_nadmm - x_star)/(1+norm(x_star)) <= 1e-8);
