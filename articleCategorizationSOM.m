function [ articleCategorizationVect ] = articleCategorizationSOM( categoryIndex )

    articleCategorizationVect = {};
    title = titles();
    [rows cols] = size(categoryIndex);
    
    for i = 1:cols
        if (categoryIndex(i) == 1)
            articleCategorizationVect(i,1) = cellstr('Attention');
        end
        if (categoryIndex(i) == 2) 
            articleCategorizationVect(i,1) = cellstr('Memory');
        end
        if (categoryIndex(i) == 3) 
            articleCategorizationVect(i,1) = cellstr('Language');
        end
        if (categoryIndex(i) == 4)
            articleCategorizationVect(i,1) = cellstr('Perception');
        end
        if (categoryIndex(i) == 5)
            articleCategorizationVect(i,1) = cellstr('Reasoning');
        end
        if (categoryIndex(i) == 6) 
            articleCategorizationVect(i,1) = cellstr('Sleep & Dreams');
        end
        articleCategorizationVect(i,2) = title(i);
    end
    

end