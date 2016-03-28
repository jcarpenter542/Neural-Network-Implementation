function [ f ] = f_prime( x )
% The deriative of activation_fn (the sigmoid function)

f = exp(-x)./(exp(-x) + 1).^2;

end

