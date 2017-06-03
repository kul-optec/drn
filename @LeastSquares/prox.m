function [p, v] = prox(obj, x, gam)
    lamgam = obj.lam*gam;
    if gam ~= obj.gam_prox % more robust test?
        % factor matrix when gam changes (or at first call)
        obj.gam_prox = gam;
        I = speye(size(obj.S));
        obj.L_prox = chol(obj.S + I/lamgam);
    end
    q = obj.Atb + x/lamgam;
    if size(obj.A, 1) <= size(obj.A, 2)
        s = obj.L_prox\(obj.L_prox'\(obj.A*q));
        p = lamgam*(q - obj.A'*s);
    else
        p = obj.L_prox\(obj.L_prox'\q);
    end
    v = (obj.lam/2)*norm(obj.A*p-obj.b, 2)^2;
end
