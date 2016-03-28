function [ avgSSE ] = runPerceptron90x10( trainingScore, outputMatrix )

    totalSSE = 0;
    for i = 1:2:19 % Test set = start with every other paper
        test_i = [i:i+1]; % Test set, add the following paper = 2 total (10%)
        testing_indices = [test_i, test_i+20, test_i+40, test_i+60, test_i+80, test_i+100]; % Get test indices for all categories
        train_i = [];
        for j = 1:20 % Get train indices for all categories = the 18 papers not included in the test set for each category (90%)
            if j ~= i && j~= i+1
                train_i = [train_i j];
            end
            training_indices = [train_i, train_i+20, train_i+40, train_i+60, train_i+80, train_i+100];
        end
        
        
        trainingSet = trainingScore(:,training_indices); % Get training set from PCA Matrix
        outputSet = outputMatrix(:, training_indices); % Get appropriate classifications for training set
        
        testingSet = trainingScore(:,testing_indices); % Get testing set from PCA Matrix
        outputTestingSet = outputMatrix(:,testing_indices); % Get appropriate classifications for testing set
        
        [outputVector SSE] = perceptron(trainingSet, outputSet, testingSet, outputTestingSet);% Run perceptron w/ backprop
        categorizedArticles = articleCategorizationPerceptron(outputVector); % Convert output vector into classified article titles
        title = titles(); % Get titles from file
        articles = title(testing_indices); % Get real title names of testing set
        [categorizedArticles articles'] % Place categorized classifications next to title names
        totalSSE = totalSSE + SSE; % Add to total SSE
    end
    avgSSE = totalSSE / 10; % Get avg SSE by dividing by number of iterations ran of the 90% train, 10% test


end



