%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                           wheel_demo.m                          %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%                Sistemas de Percepción en Robótica               %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   wheel_demo.m
% @brief  Demonstration of operation of event camera
% @author Raúl Tapia

% This demo is inspired by "Event-based, 6-DOF pose tracking for high-speed
% maneuvers" by Elias Mueggler, Basil Huber and Davide Scaramuzza.

clc; clear; close all;

[imageData, eventsData] = getData("wheel-cte-vel");
eventsData = removeEventsNoise(eventsData);
showVideo(imageData);

figure('Color', [1,1,1]);
scatter3(eventsData.t, eventsData.x, eventsData.y, 1, eventsData.t);
title('Constant velocity'); xlabel('t'); ylabel('x'); zlabel('y');

pause(1);

[imageData, eventsData] = getData("wheel-var-vel");
eventsData = removeEventsNoise(eventsData);
showVideo(imageData)

figure('Color', [1,1,1]);
scatter3(eventsData.t, eventsData.x, eventsData.y, 1, eventsData.t);
title('Variable velocity'); xlabel('t'); ylabel('x'); zlabel('y');
