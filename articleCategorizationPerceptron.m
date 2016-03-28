function [ articleCategorizationVect ] = articleCategorization( output )

    articleCategorizationVect = {};
    titles = testingTitles();
    [rows cols] = size(output);
    
    for i = 1:cols
        [~, index] = max(output(:,i)); % Read in the index of the highest value in the output column vector
        if (index == 1)
            articleCategorizationVect(i,1) = cellstr('Attention');
        end
        if (index == 2) 
            articleCategorizationVect(i,1) = cellstr('Memory');
        end
        if (index == 3) 
            articleCategorizationVect(i,1) = cellstr('Language');
        end
        if (index == 4)
            articleCategorizationVect(i,1) = cellstr('Perception');
        end
        if (index == 5)
            articleCategorizationVect(i,1) = cellstr('Reasoning');
        end
        if (index == 6) 
            articleCategorizationVect(i,1) = cellstr('Sleep & Dreams');
        end
%         articleCategorizationVect(i,2) = titles(i);
    end
    

end