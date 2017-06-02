% NADMM Newton-type ADMM (Alternating Direction Method of Multipliers) for
%
%       minimize f(x) + g(z)
%       subject to Ax + Bz = b
%

function [s, out] = nadmm(f, g, A, B, b, s0, gam, opt)

    phi1 = EpiCompose(f, A);
    phi2 = ScaleTranslate(EpiCompose(g, B), -1, b);

    [s, out] = drn(phi1, phi2, s0, gam, opt);

    % TODO: get primal solution
end
