load graph_sp_data.mat

% Understanding the data %%%

con_comp = countConnectedComponentsLaplacian(A)

figure(1);
subplot(3,1,1);stem(x1);title("x1");
subplot(3,1,2);stem(x2);title("x2");
subplot(3,1,3);stem(x3);title("x3");

% Finding the frequency representation of signals %%%

D = diag(sum(A, 2));    % Degree matrix
L = D - A;              % Laplacian matrix

% Set the graph shift matrix S as the Laplacian matrix L
S = L;

gft1 = graphFourierTransform(S, x1);
gft2 = graphFourierTransform(S, x2);
gft3 = graphFourierTransform(S, x3);

figure(2);
subplot(3,1,1);stem(gft1);title("x1'");
subplot(3,1,2);stem(gft2);title("x2'");
subplot(3,1,3);stem(gft3);title("x3'");

% Quantifying the variation of signals 

tvd1 = x1' * L * x1
tvd2 = x2' * L * x2
tvd3 = x3' * L * x3

% Compute the inverse Graph Fourier Transform of a graph signal

xx1 = inverseGraphFourierTransform(S, gft1);
xx2 = inverseGraphFourierTransform(S, gft2);
xx3 = inverseGraphFourierTransform(S, gft3);

rmse(x1, xx1)
rmse(x2, xx2)
rmse(x3, xx3)

% Denoising a graph signal.

y_gft = graphFourierTransform(S, y);

figure(3);
stem(y_gft);

% Set all frequency coefficients except the first 3 to zero
y_gft(4:end) = 0;

% Recover the graph signal z by taking the inverse graph Fourier transform
z = inverseGraphFourierTransform(S, y_gft);

% Plotting the recovered signal z, original signal y, and contaminated signal y
figure(4);
plot(z, 'r', 'LineWidth', 2);
hold on;
plot(y, 'b', 'LineWidth', 1);
plot(y_gft, 'g--', 'LineWidth', 1);
xlabel('Sample Index');
ylabel('Signal Value');
title('Recovery of Signal z');
legend('Recovered Signal z', 'Original Signal y', 'Graph Fourier Representation y''');
grid on;


