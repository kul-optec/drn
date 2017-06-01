% INDBALLL0 Indicator function the L0 pseudo-norm ball

classdef IndBallL0 < Proximable
    properties
        N % ball radius
        T % L-infinity threshold (to make the ball compact)
    end
    methods
        function obj = IndBallL0(N, T)
            if nargin < 2, T = Inf; end
            obj.N = N;
            obj.T = T;
        end
    end
end
