%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                            getData.m                            %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%                Sistemas de Percepción en Robótica               %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   getData.m
% @brief  Function to get event and image data from csv
% @author Raúl Tapia

% @param  filename Name of the dataset file
% @return Vectorized images as matrtix and struct with events parameters
function [images, events] = getData(filename)
    imageData = importdata(strcat('datasets/', filename, '-images_log.csv'));
    eventData = importdata(strcat('datasets/', filename, '-events_log.csv'));

    images = imageData.data;
    events.t = eventData(:,1) - eventData(1,1);
    events.x = eventData(:,2);
    events.y = eventData(:,3);
end
