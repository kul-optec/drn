% PRESCALE Uniformly scales and translates a function input

classdef Prescale < Proximable
    properties
        f, a, b
    end
    methods
        function obj = Translate(f, a, b)
            obj.f = f;
            obj.a = a;
            obj.b = b;
        end
    end
end
