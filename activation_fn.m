function [ f ] = activation_fn( x )
% The sigmoid function

f = 1./(1+exp(-x));

end

