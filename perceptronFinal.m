% Runs Perceptron at 3 different combinations of training versus testing set sizes
% Comment out the appropriate lines if you wish to only see certain outputs

load('variables20.mat')

disp('Running perceptron on 90% training set, 10% testing set for 10 iterations');
avgSSE90x10 = runPerceptron90x10(trainingScore, outputMatrix)

disp('Running perceptron on 50% training set, 50% testing set for 2 iterations');
avgSSE50x50 = runPerceptron50x50(trainingScore, outputMatrix)

disp('Running perceptron on 25% training set, 75% testing set for 4 iterations');
avgSSE25x75 = runPerceptron25x75(trainingScore, outputMatrix)