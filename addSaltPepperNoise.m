function [ output_image ] = addSaltPepperNoise( input_image, noise_strength )
% addSaltPepperNoise - add Salt&Pepper Noise to image
%
% input:
% input_image:    grayscale image
%                 the orginal images without distortion to add noise
% noise_strength: floating number between 0 and 1
%                 0 => no noise; 1 => only nose
%
% ouput:          grayscale image
%                 input image with noise

    [row col]=size(input_image);

    output_image=input_image;

    % adding salt and pepper noise to image
    for i=1:row
        for j=1:col
            temp=rand;
            if (temp<noise_strength)
                temp=rand;
                if(temp<.5)
                    output_image(i,j)=255;
                else
                    output_image(i,j)=0;
                end
            end
        end
    end
end

