% NADMM Newton-type ADMM (Alternating Direction Method of Multipliers) for
%
%       minimize f(x) + g(z)
%       subject to Ax + Bz = b
%

function [s, out] = nadmm(f, g, A, B, b, s0, rho, opt)

    if nargin < 8, opt = struct(); end

    phi1 = EpiCompose(f, A);
    phi2 = ScaleTranslate(EpiCompose(g, B), -1, b);

    [s, out] = drn(phi1, phi2, s0, 1/rho, opt);

    % TODO: get primal solution (x, z)
end
