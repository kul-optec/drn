% INDPOINT Indicator function of a singleton

classdef IndPoint < Proximable
    properties
        p
    end
    methods
        function obj = IndPoint(p)
            obj.p = p;
        end
    end
end
