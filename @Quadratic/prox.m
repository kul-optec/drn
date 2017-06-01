function [p, v] = prox(obj, x, gam)
    if gam ~= obj.gam_prox % more robust test?
        % factor matrix when gam changes (or at first call)
        obj.gam_prox = gam;
        n = length(x);
        I = speye(n);
        obj.L_prox = chol(I + gam*obj.Q); % do differently for sparse?
    end
    p = obj.L_prox\(obj.L_prox'\(x - gam*obj.q));
    v = 0.5*(p'*(obj.Q*p)) + obj.q'*p; % can we save something here?
end
