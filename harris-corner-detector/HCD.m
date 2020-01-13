%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                              HCD.m                              %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%                Sistemas de Percepción en Robótica               %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   HCD.m
% @brief  Harris corner detection using event camera
% @author Raúl Tapia

% This code implements the algorithm presented by Valentina Vasco, Arren
% Glover, and Chiara Bartolozzi in the article "Fast event-based harris
% corner detection exploiting the advantages of event-driven cameras".

clc; clear; close all

%%% Load data
selection = questdlg('Load experiment', 'HCD', 'geometry', 'chessboard', 'geometry');
switch selection
    case 'chessboard'
        events = getData('chessboard');
        N = 5000; % depends on the scenario
        threshold = 0.99; % depends on the scenario
    case 'geometry'
        events = getData('geometry');
        N = 2000; % depends on the scenario
        threshold = 0.98; % depends on the scenario
    otherwise
        return
end

%%% Maps
map.positive = zeros(events.height, events.width);
map.negative = zeros(events.height, events.width);

%%% Sobel filter
sobelSize = 7;
pasc = @(k,n) ((k>=0) && (k<=n)) * (factorial(abs(n))/(factorial(abs(n-k))*factorial(abs(k))));
Sx = zeros(1,sobelSize);
Dx = zeros(1,sobelSize);
for i = 1:sobelSize
    Sx(i) = factorial((sobelSize-1))/((factorial((sobelSize-1) - (i-1)))*(factorial(i-1)));
    Dx(i) = pasc(i-1, sobelSize-2) - pasc(i-2, sobelSize-2);
end
Sy = Sx'; Dy = Dx';
Gx = Sy*Dx; Gy = Gx';
Gx = Gx/max(max(Gx));
Gy = Gy/max(max(Gy));

%%% Gaussian filter
padding = 7;
gaussianSize = 2*padding+1 - sobelSize+1;
[xw, yw] = meshgrid(-(gaussianSize-1)/2:(gaussianSize-1)/2, -(gaussianSize-1)/2:(gaussianSize-1)/2);
sigma = 1;
h = (1/(2*pi*sigma^2)) * exp(-(xw.^2 + yw.^2) / (2*sigma^2));
h = h/sum(sum(h));

fprintf('Running...');
for i = 1:events.n
    if(events.p(i))
        %%% Add event to map
        map.positive(events.y(i)+1, events.x(i)+1) = events.t(i);
        
        %%% Remove old events
        if(sum(sum(map.positive)) > N)
            map.positive(map.positive == min(map.positive(map.positive>0))) = 0;
        end
        
        %%% If event is out of limit, continue
        if(events.x(i) <= padding || events.x(i) >= events.width  - padding || ...
                events.y(i) <= padding || events.y(i) >= events.height - padding)
            continue;
        end
        
        %%% Compute window
        window = map.positive(events.y(i)+1-padding:events.y(i)+1+padding, events.x(i)+1-padding:events.x(i)+1+padding) > 0;
        
    else
        %%% Add event to map
        map.negative(events.y(i)+1, events.x(i)+1) = events.t(i);
        
        %%% Remove old events
        if(sum(sum(map.negative)) > N)
            map.negative(map.negative == min(map.negative(map.negative>0))) = 0;
        end
        
        %%% If event is out of limit, continue
        if(events.x(i) <= padding || events.x(i) >= events.width  - padding || ...
                events.y(i) <= padding || events.y(i) >= events.height - padding)
            continue;
        end
        
        %%% Compute window
        window = map.negative(events.y(i)+1-padding:events.y(i)+1+padding, events.x(i)+1-padding:events.x(i)+1+padding) > 0;
        
    end
    
    %%% Compute score
    dx = conv2(double(window), Gx, 'valid');
    dy = conv2(double(window), Gy, 'valid');
    
    M = [sum(sum(dx.^2.*h)), sum(sum(dx.*dy.*h)); sum(sum(dx.*dy.*h)), sum(sum(dy.^2.*h))];
    events.score(i) = det(M) - 0.04*trace(M)^2;
    
    %%% Still alive
    if(~mod(i,round(events.n/10)))
        fprintf('.');
    end
end

%%% Show result
clc;
displayCorners(events, threshold);
disp('Use displayCorners(events, threshold) to watch the result again');
