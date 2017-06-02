function [p, v] = prox(obj, x, gam)
    switch obj.flag
        case 1 % f = Quadratic
            if gam ~= obj.gam_prox % more robust test?
                % factor matrix when gam changes (or at first call)
                obj.gam_prox = gam;
                obj.L_prox = chol(obj.Q + (1/gam)*obj.A'*obj.A); % do differently for sparse?
            end
            p = obj.L_prox\(obj.L_prox'\((obj.A'*x)/gam - obj.q));
            v = 0.5*(p'*(obj.Q*p)) + obj.q'*p; % can we save something here?
        case 2 % f = QuadraticOverAffine
            error('not implemented');
        case 3 % f = Any proximable function and A is special
            error('not implemented');
        otherwise
            error('not implemented');
    end
end