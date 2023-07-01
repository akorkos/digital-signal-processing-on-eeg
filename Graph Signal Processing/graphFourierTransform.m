function x_tilde = graphFourierTransform(S, x)
    % Calculate the eigenvectors and eigenvalues of the graph shift matrix
    [V, D] = eig(S);
    
    % Sort the eigenvalues and eigenvectors in ascending order
    [~, index] = sort(diag(D));
    V = V(:, index);
    
    % Compute the graph Fourier representation x'
    x_tilde = V' * x;
end
