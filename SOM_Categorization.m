function [ categoryIndex ] = SOM_Categorization( dataMatrix )
    %% Initialize variables
    [num_Neurons num_Articles]= size(dataMatrix);
    output_Attention = zeros(num_Neurons,1);
    output_Memory = zeros(num_Neurons,1);
    output_Language = zeros(num_Neurons,1);
    output_Perception = zeros(num_Neurons,1);
    output_Reasoning = zeros(num_Neurons,1);
    output_Sleep = zeros(num_Neurons,1);
    articlesPerCategory = num_Articles / 6;
    
    %% Calculate average output for each category 
    % For as many articles there are per category, take the data from that
    % article number for every category
    for i = 1:articlesPerCategory
        output_Attention = output_Attention + dataMatrix(:,i);
        output_Memory = output_Memory + dataMatrix(:,i+20);
        output_Language = output_Language + dataMatrix(:,i+40);
        output_Perception = output_Perception + dataMatrix(:,i+60);
        output_Reasoning = output_Reasoning + dataMatrix(:,i+80);
        output_Sleep = output_Sleep + dataMatrix(:,i+100);
    end
    
    % Divide the outputs by the number of articles per category
    output_Attention = output_Attention/articlesPerCategory;
    output_Memory = output_Memory/articlesPerCategory;
    output_Language = output_Language/articlesPerCategory;
    output_Perception = output_Perception/articlesPerCategory;
    output_Reasoning = output_Reasoning/articlesPerCategory;
    output_Sleep = output_Sleep/articlesPerCategory;
        
    %% Calculate differences in order to find the category index for each article
    differences = [];
    categoryIndex = [];
    for i = 1:num_Articles % For each article
       % Find the summed squared difference between the current article and 
       % the average output for each category
       diff_Attention =  sum((output_Attention - dataMatrix(:,i)).^2);
       diff_Memory =  sum((output_Memory - dataMatrix(:,i)).^2);
       diff_Language =  sum((output_Language - dataMatrix(:,i)).^2);
       diff_Perception =  sum((output_Perception - dataMatrix(:,i)).^2);
       diff_Reasoning =  sum((output_Reasoning - dataMatrix(:,i)).^2);
       diff_Sleep =  sum((output_Sleep - dataMatrix(:,i)).^2);
       % Take all the differences and find the one which has the minimum
       % difference
       differences = [diff_Attention, diff_Memory, diff_Language, diff_Perception, diff_Reasoning, diff_Sleep];
       [val index] = min(differences);
       % The category index for article i is then specified to the be
       % category with the minimum difference to the average
       categoryIndex(i) = index;
    end
       
end

