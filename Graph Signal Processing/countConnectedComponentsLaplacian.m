function numComponents = countConnectedComponentsLaplacian(A)
    % Compute the Laplacian matrix
    L = diag(sum(A, 2)) - A;

    % Calculate the eigenvalues of the Laplacian matrix
    eigenvalues = eig(L);

    % Count the number of eigenvalues that are close to zero
    numComponents = sum(abs(eigenvalues) < 1e-10);
end