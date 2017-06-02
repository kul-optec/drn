% NADMM Newton-type ADMM (Alternating Direction Method of Multipliers) for
%
%       minimize f(x) + g(z)
%       subject to Ax + Bz = b
%

function [s, out] = nadmm(f, g, A, B, b, s0, gam, opt)

    muA = get_gram_diagonal(A');
    if muA == 0
        error('A must be such that A''*A = mu*I, for some mu > 0');
    end

    muB = get_gram_diagonal(B');
    if muB == 0
        error('B must be such that B''*B = mu*I, for some mu > 0');
    end

    phi1 = EpiCompose(f, A);
    phi2 = ScaleTranslate(EpiCompose(g, B), -1, b);

    [s, out] = drn(phi1, phi2, s0, gam, opt);

    % TODO: get primal solution
end
