% SEPARABLESUM Separable sum of functions

classdef SeparableSum < Proximable
    properties
        objs
        dims
        idx
        dimsum
    end
    methods
        function obj = SeparableSum(objs, dims, idx)
            l = length(objs);
            if nargin < 3
                idx = 1:l;
            end
            dimsum = zeros(length(idx), 1);
            dimsum(1) = dims{1};
            for i = 2:length(idx)
                dimsum(i) = dimsum(i-1) + dims{i};
            end
            obj.objs = objs;
            obj.dims = dims;
            obj.idx = idx;
            obj.dimsum = dimsum;
        end
    end
end
