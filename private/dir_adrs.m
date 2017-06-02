% DRS direction

function [dir, cache] = dir_adrs(cache, v, varargin)

dir = cache.lambda*v+cache.beta*(cache.sbar-cache.sbarp);

end
