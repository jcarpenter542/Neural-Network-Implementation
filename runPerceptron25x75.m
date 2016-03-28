function [ avgSSE ] = runPerceptron25x75( trainingScore, outputMatrix )

    totalSSE = 0;
     for i = 1:5:16 % Test set = start with every 5th paper
        test_i = [i:i+14]; % Test set, add the subsequent 14 papers = 15 total (75%)
        for k = 1:length(test_i) % Wrap around values greater than 20 (since there are 20 papers in each category)
            if test_i(k) > 20
                test_i(k) = test_i(k) - 20;
            end
        end
        testing_indices = [test_i, test_i+20, test_i+40, test_i+60, test_i+80, test_i+100]; % Get test indices for all categories
        train_i = [];
        for j = 1:20 % Get train indices for all categories = the 5 papers not included in the test set for each category (25%)
            if j ~= test_i
                train_i = [train_i j];
            end
            training_indices = [train_i, train_i+20, train_i+40, train_i+60, train_i+80, train_i+100];
        end
        
        
        trainingSet = trainingScore(:,training_indices); % Get training set from PCA Matrix
        outputSet = outputMatrix(:, training_indices); % Get appropriate classifications for training set
        
        testingSet = trainingScore(:,testing_indices); % Get testing set from PCA Matrix
        outputTestingSet = outputMatrix(:,testing_indices); % Get appropriate classifications for testing set
        [outputVector SSE] = perceptron(trainingSet, outputSet, testingSet, outputTestingSet); % Run perceptron w/ backprop
        categorizedArticles = articleCategorizationPerceptron(outputVector); % Convert output vector into classified article titles
        title = titles(); % Get titles from file
        articles = title(testing_indices); % Get real title names of testing set
        [categorizedArticles articles'] % Place categorized classifications next to title names
        totalSSE = totalSSE + SSE; % Add to total SSE
    end
    avgSSE = totalSSE / 4; % Get avg SSE by dividing by number of iterations ran of the 25% train, 75% test


end



