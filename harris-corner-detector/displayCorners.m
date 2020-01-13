%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                         displayCorners.m                        %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%                Sistemas de Percepción en Robótica               %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   displayCorners.m
% @brief  Function to display result of Harris corner detection
% @author Raúl Tapia

% @param  event               Struct of events after HCD processing
% @param  thresholdPercentage Normalized threshold (from 0 to 1)
function displayCorners(events, thresholdPercentage)    
    %%% Figure
    figure('Color', [1,1,1]);
    hold on;
    
    %%% Check if error
    if(thresholdPercentage < 0 || thresholdPercentage > 1)
        return
    end

    %%% Show events and corners
    STEP = 10000;
    for i = 1:STEP:events.n-STEP
        I = zeros(events.height, events.width, 3);

        %%% Compute threshold (general estimation)
        sortedScores = sort(events.score(i:i+STEP));
        threshold = sortedScores(round(thresholdPercentage*length(events.score(i:i+STEP))));

        for j = i:i+STEP
            if(I(events.y(j)+1, events.x(j)+1, 2) == 0)
                I(events.y(j)+1, events.x(j)+1, :) = [255*~events.p(j), 0, 255*events.p(j)];
            end

            if(events.score(j) > threshold && ...
                    events.x(j) > 3 && events.y(j) > 3 && ...
                    events.x(j) < events.width-3 && events.y(j) < events.width-3)
                I(events.y(j)-2:events.y(j)+2, events.x(j)-2:events.x(j)+2, 1) = 0;
                I(events.y(j)-2:events.y(j)+2, events.x(j)-2:events.x(j)+2, 2) = 255;
                I(events.y(j)-2:events.y(j)+2, events.x(j)-2:events.x(j)+2, 3) = 0;
            end
        end

        imshow(I);
    end
    
    close all;
end
