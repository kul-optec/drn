% SEPARABLESUM Separable sum of functions

classdef SeparableSum < Proximable
    properties
        fs
        dims
        idx
        dimsum
    end
    methods
        function obj = SeparableSum(fs, dims, idx)
            l = length(fs);
            if nargin < 3
                idx = 1:l;
            end
            dimsum = zeros(length(idx), 1);
            dimsum(1) = dims{1};
            for i = 2:length(idx)
                dimsum(i) = dimsum(i-1) + dims{i};
            end
            obj.fs = fs;
            obj.dims = dims;
            obj.idx = idx;
            obj.dimsum = dimsum;
        end
    end
end
