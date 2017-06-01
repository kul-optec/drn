% NORML1 L1 norm

classdef NormL1 < Proximable
    properties
        lam % coefficient
    end
    methods
        function obj = NormL1(lam)
            if nargin < 1, lam = 1.0; end
            obj.lam = lam;
        end
    end
end
