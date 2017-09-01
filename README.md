# DRN

This repository contains the MATLAB implementation of Douglas-Rachford Newton-type methods (DRN) and Newton-type ADMM (NADMM).

### Installation

To install the package, run the following from the MATLAB console:
```
>> cd <PATH-TO-DRN>
>> drn_setup
```
To run the test scripts and verify correct functioning of the package, run:
```
>> drn_test
```
The commands
```
>> help drn
>> help nadmm
```
print out the docstrings for the DRN and NADMM respectively.

### Example: the lasso

```
% Set up problem and options
f = LeastSquares(A, b);
g = NormL1(lam);
Lf = norm(A)^2;
gam = 0.95/Lf;
opt.tol = 1e-12;
opt.display = 0;
opt.maxit = 1000;

% Invoke the solver
out = drn(f, g, zeros(n, 1), gam, opt);

% Get the solution
x_drn = out.z;
```
