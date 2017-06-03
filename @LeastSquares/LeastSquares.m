% LEASTSQUARES Construct a linear least-squares cost function

classdef LeastSquares < Proximable
    properties
        A, b, lam
        Atb
        S % to store square matrix, i.e., A'A or AA' depending on size
        L_prox % to store Cholesky factor for prox computation
        gam_prox
    end
    methods
        function obj = LeastSquares(A, b, lam)
            if nargin < 2, b = 0; end
            if nargin < 3, lam = 1.0; end
            obj.A = A;
            obj.b = b;
            obj.lam = lam;
            obj.Atb = A'*b;
            if size(A, 1) <= size(A, 2)
                obj.S = A*A'; % do differently for sparse?
            else
                obj.S = A'*A; % do differently for sparse?
            end
            obj.gam_prox = 0;
        end
    end
end
