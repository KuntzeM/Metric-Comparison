function [ output_image ] = denoiseMDBUTMF( input_image )
% MDBUTMF
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
            sum=0;        
            for k=i-1:i+1
                for l=j-1:j+1               
                    array(1,m)=input_image(k,l);                                
                    sum=sum+array(1,m);
                    m=m+1;
                end                
            end
            avg=round(sum/9);

            if((array(1,5)==255)||(array(1,5)==0))
                count=0;
                for z=1:9                
                    if((array(1,z)==255)||(array(1,z)==0))
                        count=count+1;
                    end
                end

                index=9-count;
                temp=zeros(1,index);

                x=0;

                if(count==9)
                    input_image(i,j)=avg;
                else
                    for z=1:9                
                        if((array(1,z)==255)||(array(1,z)==0))
                            array(1,z)=array(1,z);
                        else
                            x=x+1;
                            temp(1,x)=array(1,z);
                        end
                    end

                    temp=sort(temp);
                    med=round(index/2);
                    qw=mod(med,2);
                    if(qw==0)
                        value=temp(1,med);
                        value1=temp(1,med+1);
                        input_image(i,j)=round((value+value1)/2);
                    else
                        value=temp(1,med);
                        input_image(i,j)=value;
                    end
                end
            end
        end
    end

    output_image = input_image;
end



