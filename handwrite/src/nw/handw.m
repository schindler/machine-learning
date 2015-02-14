%% Initialization
clear ; close all; clc

% Load Training Data
fprintf('Loading train data ...\n')
fflush(stdout);

root_data = "../../data";

tic();
X=get_pixels(sprintf("%s/train-images-idx3-ubyte",root_data));
y=get_labels(sprintf("%s/train-labels-idx1-ubyte",root_data));
y(find(y==0))=10;  % (note that we have mapped "0" to label 10)

toc();
fprintf('Setup ...\n');
fflush(stdout);

%% Setup the parameters you will use for this exercise
input_layer_size  = numel(X(1,:));  % Input Images of Digits
hidden_layer_size = 45;             % 45 hidden units
num_labels        = 10;             % 10 labels, from 1 to 10   
                                                                 
input  = rand_layer(input_layer_size, hidden_layer_size);
output = rand_layer(hidden_layer_size, num_labels);

% Unroll parameters
nn_params = [input(:); output(:)];

fprintf('\nTraining Neural Network... \n');
fflush(stdout);

tic();

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.
options = optimset('MaxIter', 100);


%  You should also try different values of lambda
lambda = 10;

% Create "short hand" for the cost function to be minimized
cost_function = @(p) get_cost(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);
                                   
% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(cost_function, nn_params, options);


% Obtain Theta1 and Theta2 back from nn_params
input  = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

output = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

toc();
[p, s] = predict(input, output, X);
fprintf('\nTraining set accuracy: %f\n', mean(double(p == y)) * 100);

fprintf('Loading test data ...\n')
fflush(stdout);

tic();
X=get_pixels(sprintf("%s/t10k-images.idx3-ubyte",root_data));
y=get_labels(sprintf("%s/t10k-labels-idx1-ubyte",root_data));
y(find(y==0))=10;
toc();

[p, s] = predict(input, output, X);
fprintf('\nTesting set accuracy: %f\n', mean(double(p == y)) * 100);
fflush(stdout);

% save net
save("-z", sprintf("../../net/handw%2dhh%2dlambda.data",hidden_layer_size, lambda), "input", "output"); 
