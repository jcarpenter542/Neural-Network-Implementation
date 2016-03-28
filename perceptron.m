function [ test_H_vector, sse_MatrixB ] = perceptron( inputMatrix , outputMatrix, testingMatrix, testingOutputMatrix)

% Initialize Parameters
lrate = 1;
[numInputUnits numArticles] = size(inputMatrix);
[rows numTestArticles] = size(testingMatrix);
numHiddenUnits = int8(numInputUnits/2);
numOutputUnits = 6;

sse = 1; % Initial value for sse
while sse > 0.01 % Until sse is <= 0.01 (in case epochs reaches 1000 on first time through, must run again)

    w_fg = rand(numHiddenUnits, numInputUnits) - .5; % Generate fg weight matrix
    w_gh = rand(numOutputUnits, numHiddenUnits) - .5; % Generate gh weight matrix

    sse = 1; % Initial value for sse
    sseDisp = []; % Creating vector for later use to display sse as it changes over epochs
    output_vector_Disp = []; % Creating matrix for later use to display output_vector (h_vector) as it changes over epochs
    epochs = 0; % Initialize epochs to 0
    while epochs < 1000 && sse > 0.01 % Until epochs reaches 1000 or sse <= 0.01
        output_errors = []; % Creating vector to store all output_errors for each set of patterns
        h_vector = []; % Initialize h_vector
        for i = 1:numArticles % For all patterns in matrixA
            f_vector = inputMatrix(:,i); % Set f_vector to each pattern

            input_to_hidden = w_fg * f_vector; % Apply weighted matrix fg
            hidden_activation = activation_fn(input_to_hidden); % Apply sigmoidal function
            g_vector = hidden_activation; % g_vector is the result

            input_to_output = w_gh * hidden_activation; % Apply weighted matrix gh
            output_activation = activation_fn(input_to_output); % Apply sigmoidal function
            h = output_activation; % h is the result
            h_vector = [h_vector h]; % Add h to h_vector for later use to display output as it changes over epochs
            
            t = outputMatrix(:,i); % Set t to output at current pattern (for use in dw_gh calculations)

            output_error = outputMatrix(:,i) - output_activation; % Calculate output_error (t-h)
            output_errors = horzcat(output_errors, output_error); % Concatenate output_error into output_errors matrix for use in calculating sse

            dw_fg = lrate*diag(f_prime(w_fg*f_vector))*w_gh'*diag(output_error)*f_prime(w_gh*g_vector)*f_vector'; % Calculate dw_fg using formula from slides
            dw_gh = lrate*(diag(f_prime(w_gh*g_vector))*(t-h))*g_vector'; % Calculate dw_gh using formula from slides

            w_fg = w_fg + dw_fg; % Add dw_fg to w_fg
            w_gh = w_gh + dw_gh; % Add dw_gh to w_gh
        end
        output_vector_Disp = [output_vector_Disp; h_vector]; % Concatenate h_vector vertically with output_vector_Disp for use in displaying the output as it changes over epochs
        sse = trace(output_errors'*output_errors);
        sseDisp = [sseDisp sse]; % Concatenate sse with sseDisp for later use in displaying sse as it changes over epochs
        if(mod(epochs,10) == 0) % Every 10 epochs
            epochs; % Display number of epochs
            sse; % Display sse
        end
        epochs = epochs + 1; % Add 1 to epochs counter
    end
    if sse > 0.01 % If after reaching 1000 epochs, sse is still > 0.01 
        disp('Failure to converge -- trying again!'); % Display warning -- Will run through while loop again
    end
end
% % Plot SSE over Epochs
% figure;
% epochs % After sse has converged to 0.01, display total number of epochs required
% epochsDisp = linspace(1,epochs,length(sseDisp)); % Create x-axis for epochs vs SSE display
% plot(epochsDisp,sseDisp); % Plot sse over epochs
% xlabel('Epochs');
% ylabel('SSE');
% title('SSE as it changes over Epochs');

test_H_vector = [];
output_errors_MatrixB = []; % Re-initialize output_errors vector for use in calculating sse

for i = 1:numTestArticles % For all patterns in the new matrixB
    f_vector = testingMatrix(:,i); % Set f_vector to each pattern

    input_to_hidden = w_fg * f_vector; % Apply weighted matrix fg
    hidden_activation = activation_fn(input_to_hidden); % Apply sigmoidal function (result g)

    input_to_output = w_gh * hidden_activation; % Apply weighted matrix gh
    output_activation = activation_fn(input_to_output); % Apply sigmoidal function (result h)
    h = output_activation; % h is the result
    test_H_vector = [test_H_vector h]; % Add h to h_vector for later use to display output as it changes over epochs

    output_error = testingOutputMatrix(:,i) - output_activation; % Calculate output error (t-h)
    output_errors_MatrixB = horzcat(output_errors_MatrixB, output_error); % Concatenate output_error into output_errors matrix for use in calculating sse
end
output_errors_MatrixB; % Display output_errors of new matrixB
sse_MatrixB = trace(output_errors_MatrixB'*output_errors_MatrixB) % Display sse of new matrixB

% Plot output vectors over epochs
figure;
subplot(1,2,1), imagesc(test_H_vector); % Plot h_vector (actual output) as it changes over epochs
xlabel('Actual Output');
title('Actual Output of Testing Set');
subplot(1,2,2), imagesc(testingOutputMatrix); % Plot desired output (doesn't change)
xlabel('Desired Output');
title('Desired Output of Testing Set');

axes('position',[0,0,1,1],'visible','off');
txt(1) = text(0,6/7,'Attention');
txt(2) = text(0,5/7,'Memory');
txt(3) = text(0,4/7,'Language');
txt(4) = text(0,3/7,'Perception');
txt(5) = text(0,2/7,'Reasoning');
txt(6) = text(0,1/7,sprintf('Sleep &\nDreams'));
set(txt,'fontweight','bold');
end

