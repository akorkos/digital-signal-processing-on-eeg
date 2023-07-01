function x = inverseGraphFourierTransform(S, xs)
    % Compute the eigenvalues and eigenvectors of the graph shift
    [V, D] = eig(S);
    eigenvalues = diag(D);
    
    % Sort the eigenvectors based on the absolute values of the eigenvalues
    [~, idx] = sort(abs(eigenvalues));
    V_sorted = V(:, idx);
    
    % Compute the inverse graph Fourier transform
    x = V_sorted * xs;
end
