%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                            getData.m                            %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%                Sistemas de Percepción en Robótica               %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   getData.m
% @brief  Function to get event data from csv
% @author Raúl Tapia

% @param  filename Name of the dataset file
% @return Struct with events parameters
function events = getData(filename)
    %%% Import data
    eventData = importdata(strcat('datasets/', filename, '-events_log.csv'));
    events.t = eventData(:,1) - eventData(1,1);
    events.x = eventData(:,2);
    events.y = eventData(:,3);
    events.p = eventData(:,4);
    
    %%% Get the first seconds (the algorithm has a very high temporal cost)
    idx = (events.t < 1);
    events.t = events.t(idx);
    events.x = events.x(idx);
    events.y = events.y(idx);
    events.p = events.p(idx);
    
    %%% Set constants and score
    events.width = 346;
    events.height = 260;
    events.n = length(events.t);
    events.score = zeros(1,events.n);
end
