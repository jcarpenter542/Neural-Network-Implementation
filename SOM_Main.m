% SOM Function
% // All code written with comments starting as such % // were written by
% // Jason Yu-Tseh Chi. The original code can be accessed at 
% // https://chi3x10.wordpress.com/2008/05/08/som-self-organizing-map-code-in-matlab/
function [categoryName] = SOM_Main(trainingScore, latticeDimension)
    %//-- 15 x 15 map

    %// toal number of nodes
    totalW = latticeDimension^2;
    %//initialization of weights
    [feats, num_articles] = size(trainingScore);
    w = rand(feats, totalW);
    %// the initial learning rate
    eta0 = 0.1;
    %// the current learning rate (updated every epoch)
    etaN = eta0;
    %// the constant for calculating learning rate
    tau2 = 1000;

    %//map index
    [I,J] = ind2sub([latticeDimension, latticeDimension], 1:totalW);


    alpha = 0.5;
    %// the size of neighbor
    sig0 = 200;

    sigN = sig0;
    %// tau 1 for updateing sigma
    tau1 = 1000/log(sigN);

    %i is number of epoch
    for i=1:1000
        %// j is index of each article.
        %// it should iterate through data in a random order rewrite!!
        for j=1:num_articles  
            x = trainingScore(:,j);
            dist = sum( sqrt((w - repmat(x,1,totalW)).^2),1); 
            %// find the winner
            [v ind] = min(dist);
            %// the 2-D index
            ri = [I(ind), J(ind)];

            %// distance between this node and the winner node.
            dist = 1/(sqrt(2*pi)*sigN).*exp( sum(( ([I( : ), J( : )] - repmat(ri, totalW,1)) .^2) ,2)/(-2*sigN)) * etaN;

            %// updating weights
            for rr = 1:totalW
                w(:,rr) = w(:,rr) + dist(rr).*( x - w(:,rr));
            end
        end

        %// update learning rate
        etaN = eta0 * exp(-i/tau2);
        %// update sigma
        %sigN = sigN/2;
        sigN = sig0*exp(-i/tau1);
    end
    
    categoryLabels = {'Attention', 'Memory', 'Language', 'Perception', 'Reasoning', 'Sleep & Dreams'};
    
    % Display the first 10 papers from each category (10x6=60 papers)
    figure;
    annotation('textbox', [0 0.9 1 0.1], ...
                'String', 'First 10 papers from each category', ...
                'EdgeColor', 'none', ...
                'HorizontalAlignment', 'center')
    hold on;
    count = 1;
    for ii = [1:10,21:30,41:50,61:70,81:90,101:110]
            subplot(6,10,count);
            output = trainingScore(:,ii)'*w;     
            
            imagesc(reshape(output,latticeDimension,latticeDimension));
            count = count+1;
            if mod(ii,20) == 1
                ylabel(categoryLabels{floor(ii/20)+1});
            end
    end
    
    % Display the second 10 papers from each category (10x6=60 papers)
    figure;
    annotation('textbox', [0 0.9 1 0.1], ...
                'String', 'Second 10 papers from each category', ...
                'EdgeColor', 'none', ...
                'HorizontalAlignment', 'center')
    hold on;
    count = 1;
    for ii = [11:20,31:40,51:60,71:80,91:100,111:120]
            subplot(6,10,count);
            output = trainingScore(:,ii)'*w;
            
            imagesc(reshape(output,latticeDimension,latticeDimension));
            count = count+1;
            if mod(ii,20) == 11
                ylabel(categoryLabels{floor(ii/20)+1});
            end
    end      
    
    % Get indices of maximum output for each article, used in maximum
    % activity plot
    output_data = [];
    indices = [];
    for ii = 1:num_articles
        output = trainingScore(:,ii)'*w;
        output_data = [output_data, output'];
        output_data_2 = reshape(output,latticeDimension,latticeDimension);
        [val, location] = max(output_data_2(:));
        [R,C] = find(output_data_2 == max(max(output_data_2)));    
        indices = [indices; [R,C]];        
    end
        
    % Maximum activity plot
    x = indices(:,1);
    y = indices(:,2);
    figure;
    hold on;    
    plot(x(1:20),y(1:20),'cv'); % Attention Papers
    plot(x(21:40),y(21:40),'rx'); % Memory
    plot(x(41:60),y(41:60),'y*'); % Language
    plot(x(61:80),y(61:80),'go'); % Perception
    plot(x(81:100),y(81:100),'md'); % Reasoning
    plot(x(101:120),y(101:120),'bs'); % Sleep & Dreams 
    title('Positions of Max Activity by Article');
    legend('Attention', 'Memory', 'Language', 'Perception', 'Reasoning', 'Sleep & Dreams');
    axis([0 (latticeDimension+1) 0 (latticeDimension+1)]);
    
    % Find the 30 most similar articles 
    outputSleep5 = output_data(:,105); % To sleep5.txt
    diffSleep5 = [];
    for ii = 1:num_articles % Calcualte the summed difference between the output for sleep 5 and the output for each article
        diffSleep5 = [diffSleep5 sum((outputSleep5 - output_data(:,ii)).^2)];
    end
    % Sort the differences by most similar and find their indices
    [values index] = sort(diffSleep5);
    top30 = index(1:30);
    % Print the 30 titles most similar to sleep5.txt
    TITLES = titles();
    top30titles = TITLES(top30)
    
    % Output of SOM classification
    categoryIndex = SOM_Categorization(output_data);
    categoryName = articleCategorizationSOM(categoryIndex)
    
end