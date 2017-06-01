% QUADRATIC Quadratic function

classdef Quadratic < Proximable
    properties
        Q, q % Hessian and linear term
        L_prox % stores Cholesky factor for prox
        gam_prox % stores most recently used parameter for prox
    end
    methods
        function obj = Quadratic(Q, q)
            obj.Q = Q;
            obj.q = q;
            obj.gam_prox = 0;
        end
    end
end
