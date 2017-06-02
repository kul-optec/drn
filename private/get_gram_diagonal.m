function mu = get_gram_diagonal(M)
    mus = M'*(M*ones(size(M, 2), 1));
    if (max(mus)-min(mus))/(1+abs(min(mus))) > 1e-14
        mu = 0;
    else
        mu = 0.5*(max(mus)+min(mus));
    end
end
