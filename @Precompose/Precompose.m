% PRECOMPOSE Precomposition with a linear operator

classdef Precompose < Proximable
    properties
        f, L, mu
    end
    methods
        function obj = Precompose(f, L, mu)
% Here L is a Gram-diagonal operator
% i.e. such that L*L' = mu*I, mu > 0
            obj.f = f;
            obj.L = L;
            obj.mu = mu;
        end
    end
end
