% INDBOX Indicator function of a box

classdef IndBox < Proximable
    properties
        lo, hi % box boundaries
    end
    methods
        function obj = IndBox(lo, hi)
            obj.lo = lo;
            obj.hi = hi;
        end
    end
end
