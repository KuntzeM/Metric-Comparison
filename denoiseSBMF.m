function [ output_image ] = denoiseSBMF( input_image )
% SBMF
% denoising algorithm
% implementation: Ashutosh Singla
%
% input_image:   grayscale image
%
% ouput_image:   grayscale image 
%                denoised image

    [row col]=size(input_image);
    
    for i=2:row-1
        for j=2:col-1
            array=zeros(1,9);
            m=1;
            for k=i-1:i+1
                for l=j-1:j+1               
                    array(1,m)=input_image(k,l);                                
                    m=m+1;
                end                
            end
            check=array(1,5);
            array=sort(array);

            if((check==255)||(check==0))            
                for z=1:9                
                    if(array(1,z)==255)                    
                        if(array(1,z-2)==0)
                            array(1,z)=array(1,z-1);
                        else
                            array(1,z)=array(1,z-2);                        
                        end
                    end
                end

                for z=9:-1:1                
                    if(array(1,z)==0)                    
                        if(array(1,z+2)==255)
                            array(1,z)=array(1,z+1);
                        else
                            array(1,z)=array(1,z+2);                        
                        end
                    end
                end

                array=sort(array);
                med=array(1,5);
                input_image(i,j)=med;                                
            end
        end
    end

    output_image = input_image;
end

