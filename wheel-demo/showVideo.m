%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                           showVideo.m                           %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%                Sistemas de Percepción en Robótica               %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   showVideo.m
% @brief  Function to show vectorized images as video
% @author Raúl Tapia

% @param  images Vectorized images
function showVideo(images)
    figure('Color', [1,1,1]);
    for i = 1:size(images,1)
        I = vec2mat(images(i,:), 346);
        imshow(imadjust(uint8(I)));
    end
end
