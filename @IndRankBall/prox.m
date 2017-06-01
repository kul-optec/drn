function [p, v] = prox(obj, x, gam)
    if obj.method == 1 % using svds
        [U, S, V] = svds(x, obj.r, 'largest', opt);
        p = U*(S*V');
    elseif obj.method == 2 % using lansvd
        [U, S, V] = lansvd(x, obj.r, 'L', opt);
        p = U*(S*V');
    end
    v = 0;
end
