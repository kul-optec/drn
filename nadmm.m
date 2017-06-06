% NADMM Newton-type ADMM (Alternating Direction Method of Multipliers) for
%
%       minimize f(x) + g(z)
%       subject to Ax + Bz = b
%

function out = nadmm(f, g, A, B, b, s0, rho, opt)

    if nargin < 8, opt = struct(); end

    % Transform problem into DRS form
    
    phi1 = EpiCompose(f, A);
    phi2 = ScaleTranslate(EpiCompose(g, B), -1, b);
    
    % Solve problem using DRN

    out.drn = drn(phi1, phi2, s0, 1/rho, opt);
    
    % Report solution to original problem
    
    out.x = phi1.x;
    out.z = phi2.f.x;
    
end
