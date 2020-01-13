%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                       removeEventsNoise.m                       %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%                Sistemas de Percepción en Robótica               %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   removeEventsNoise.m
% @brief  Function to reduce noise in events
% @author Raúl Tapia

% @param  events Struct with events
% @return Events with noise reduction
function events = removeEventsNoise(events)
    centre = [346/2, 260/2];
    idx = vecnorm([events.x - centre(1), events.y - centre(2)]') > 65+3 | ...
          vecnorm([events.x - centre(1), events.y - centre(2)]') < 65-3;
    events.t(idx) = [];
    events.x(idx) = [];
    events.y(idx) = [];
end
