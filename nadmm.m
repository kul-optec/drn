% NADMM Newton-type ADMM (Alternating Direction Method of Multipliers) for
%
%       minimize f(x) + g(z)
%       subject to Ax + Bz = b
% 

function [x, z, out] = nadmm(f, g, A, B, b, s0, gam, opt)

    muA = get_gram_diagonal(A);
    if muA == 0
        error('A must be such that A''*A = mu*I, for some mu > 0');
    end
    
    muB = get_gram_diagonal(B);
    if muB == 0
        error('B must be such that B''*B = mu*I, for some mu > 0');
    end
    
    phi1 = Conjugate(Precompose(f, A', muA));
    phi2 = Prescale(Conjugate(Precompose(g, B', muB)), -1, b);
    
    [s, out_dual] = drn(phi1, phi2, s0, gam, opt);
    
    % TODO: get primal solution
end

function mu = get_gram_diagonal(M)
    mus = M'*(M*ones(size(M, 2)));
    if (max(mus)-min(mus))/(1+abs(min(mus))) > 1e-14
        mu = 0;
    else
        mu = 0.5*(max(mus)-min(mus));
    end
end