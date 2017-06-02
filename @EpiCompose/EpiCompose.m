% EPICOMPOSE Epi-composition
%
%   EPICOMPOSE(f, A) returns the function g(y) = inf {f(x) : Ax = y}.

classdef EpiCompose < Proximable
    properties
        f, A
        mu
        flag
        Q, q, C, d
        gam_prox, L_prox % to store Cholesky factor
    end
    methods
        function obj = EpiCompose(f, A)
            if isa(f, 'Quadratic')
                obj.flag = 1;
                obj.Q = f.Q;
                obj.q = f.q;
            else
                error('only f of type Quadratic is supported');
            end
            obj.f = f;
            obj.A = A;
        end
    end
end
