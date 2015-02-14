function [J grad] = get_cost(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));


m  = size(X, 1);
X  = [ ones(m, 1), X ];
a2 = [ ones(m, 1), sigmoid(X * Theta1') ];
a3 = sigmoid(a2 * Theta2');
k  = size(a3, 2);
y  = repmat(1:k, m, 1)==repmat(y, 1, k);

Theta1(:,1) = 0;
Theta2(:,1) = 0;

J  = sum(sum(-y.*log(a3)-(1.-y).*log((1.-a3))))/m;
J  = J + (lambda / (2 * m)) * (sum(Theta1(:).^2) + sum(Theta2(:).^2));

g3 = a3 - y;
g2 = (g3*Theta2) .* (a2 .* (1 - a2));

Theta1_grad = [(g2' *  X) / m ](2:end,:);
Theta2_grad = [(g3' * a2) / m ];

Theta1_grad = Theta1_grad + (Theta1 * (lambda / m));
Theta2_grad = Theta2_grad + (Theta2 * (lambda / m));

% =========================================================================
% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];

end
