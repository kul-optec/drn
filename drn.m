% DRN Douglas-Rachford Newton-type method for solving
%
%       minimize f + g
%
%   DRN(f, g, s0, gam) runs the algorithm using s0 as initial iterate,
%   stepsize gam, and default options.
%
%   DRN(f, g, s0, gam, opt) same as above, but additionally specifies
%   a structure containing the options for the algorithm.
%
%   Function f (same for g) is an object having the method 'prox', with
%   two input arguments and two output arguments, such that if
%
%       [p, fp] = f.prox(x, gam);
%
%   then p is the proximal point of x wrt f and stepsize gam > 0, while
%   fp = f(p) is the value of f at p.

function [x, out] = drn(f, g, s0, gam, opt)

    % TODO: make gam optional (put it in opt)

    if nargin < 4
        error('Insufficient arguments: type ''help drn'' to access documentation');
    end

    if nargin < 5, opt = struct(); end
    opt = default_opt(opt);

    % initialize operations counters

    cnt_proxf = 0;
    cnt_proxg = 0;

    if opt.display
        fprintf('%8s%14s%14s%14s\n', 'iter', 'FPR', 'DRE', 'tau');
    end

    s = s0;
    tau = 0.0;

    p = [];
    q = [];
    normfpr = zeros(opt.maxit,1);
    dreval = zeros(opt.maxit,1);
    % initialize cache for QN methods

    cache.memory = opt.memory;
    cache.cnt_skip = 0;
    cache.lambda = opt.lambda;

    [x, fx] = f.prox(s, gam);
    cnt_proxf = cnt_proxf + 1;
    [z, gz] = g.prox(2*x - s, gam);
    cnt_proxg = cnt_proxg + 1;
    res = z-x;
    DRE_s = DRE(s, x, z, fx, gz, gam);
    for it = 1:opt.maxit

        normfpr(it,1) = vecnorm(x-z);
        dreval(it,1)  = DRE_s;

        % display

        if opt.display
            fprintf('%8d%14.4e%14.6e%14.4e\n', it, normfpr(it,1), DRE_s, tau);
        end

        % stopping criterion

        if normfpr(it,1) <= opt.tol
            break;
        end

        % choose direction

        [dir, cache] = opt.methodfun(cache, res, p, q, it == 1);

        % perform line-search over the DRE

        tau = 1.0;
        lsfail = true;

        for ls_it = 1:opt.maxls
            s1 = s + (1-tau)*opt.lambda*res + tau*dir;
            [x1, fx1] = f.prox(s1, gam);
            cnt_proxf = cnt_proxf + 1;
            [z1, gz1] = g.prox(2*x1 - s1, gam);
            cnt_proxg = cnt_proxg + 1;
            res1 = z1-x1;
            DRE_s1 = DRE(s1, x1, z1, fx1, gz1, gam);
            if DRE_s1 <= DRE_s - opt.sigma*vecnorm(z-x)^2
                lsfail = false;
                break;
            end
            tau = opt.alpha*tau;
        end
        
        if lsfail
            s1 = s + opt.lambda*res;
            [x1, fx1] = f.prox(s1, gam);
            cnt_proxf = cnt_proxf + 1;
            [z1, gz1] = g.prox(2*x1 - s1, gam);
            cnt_proxg = cnt_proxg + 1;
            res1 = z1-x1;
            DRE_s1 = DRE(s1, x1, z1, fx1, gz1, gam);
        end

        % store pair for QN directions

        p = s1 - s;
        q = res - res1;

        % update iterates

        s = s1; x = x1; z = z1;
        fx = fx1; gz = gz1; % not really needed, but just in case
        res = res1;
        DRE_s = DRE_s1;
    end

    out.x = x;
    out.z = z;
    out.iterations = it;
    out.fpr = normfpr(1:it,1);
    out.dreval = dreval(1:it,1);
    out.cnt_proxf = cnt_proxf;
    out.cnt_proxg = cnt_proxg;

end

function v = DRE(s, x, z, fx, gz, gam)
    v = fx + gz + (0.5/gam)*(vecnorm(2*x-s-z)^2 - vecnorm(x-s)^2);
end

function n = vecnorm(x)
    % this function is to treat matrices as-if-they-were-vectors
    % not sure which way is the fastest, so we use vecnorm as a proxy
    n = norm(x, 'fro');
end

function opt = default_opt(opt)
    % over-relaxation parameter
    if ~isfield(opt, 'lambda'), opt.lambda = 1.0; end
    % sufficient decrease parameter
    if ~isfield(opt, 'sigma'), opt.sigma = 1e-4; end
    % line-search stepsize decrease factor
    if ~isfield(opt, 'alpha'), opt.alpha = 0.5; end
    % tolerance (on fixed point residual?)
    if ~isfield(opt, 'tol'), opt.tol = 1e-6; end
    % max number of iters
    if ~isfield(opt, 'maxit'), opt.maxit = 10000; end
    % max number of line-search iters
    if ~isfield(opt, 'maxls'), opt.maxls = 10; end
    % verbosity
    if ~isfield(opt, 'display'), opt.display = 1; end
    % direction
    if ~isfield(opt, 'method'), opt.method = 'lbfgs'; end
    opt.methodfun = str2func(strcat('dir_', lower(opt.method)));
    % memory
    if ~isfield(opt, 'memory'), opt.memory = 10; end
end
