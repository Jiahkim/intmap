%%%%%%%%%%% for single image
clear
fdir='file directory';

fname=['filename'];
%MAX_MAX_c-HCTGSHDJFX554_ctrl_2Andor13z_1.67sfo5min_1_MMStack_Default.ome_cmle.ome-1
%MAX_MAX_e-HCTGSHDJFX554_dATP1hr18m_2Andor13z_1.67sfo5min_1-1

clear I0
I0=double(imread([ fdir fname '.tif'],1 )); %modify image format

I=imgaussfilt(I0,1);
Ir=rescale(I)*10; %%Intensity is now between 0~10.
l=0.; h=l+4; %%%Adjust numbers low level, range to show map .
 high=num2str(h); low=num2str(l);
            Ir(Ir==h|Ir>h)=h;
            Ir(Ir<l)=l; 
            r=round(rescale(Ir)*10);
            
        % Create colormap 
        
        cmap = zeros(10, 3);

  cmap = [1,1,1;...   % wfor 1
    0.9, 0.9, 0.9; ...       % gr for 2
    0, 0.7, 1; ...  %1, 0.2, 0.8; ... pink
    1, 0.4, 1; ...
    % 0.5,0.4, 1; ...   % light purple for 5
    1, 0.9, 0; ...       % y =
    0, 0.5, 0; ...       % green for 6
    0, 0.6, 0; ...       % green for 7
    0, 0.7, 0; ...       % green for 8
    0, 1, 0; ...       % bright green for 9
    0., 0.2, 0.]   ;        % dark green for 10
   colormap(cmap)
     % Display the image with the colormap applied.
        rgbImage = ind2rgb(r, cmap);
       figure, imshow(r, cmap);

%%
       %%%%%%%%%%% for single image

howmanyfr=80;
for i=1:howmanyfr
I0=double(imread([ fdir fname ''],i));

I=imgaussfilt(I0,1);
Ir=rescale(I)*10;%
Ir=rescale(I)*10;
l=0; h=l+3;
 high=num2str(h); low=num2str(l);
            Ir(Ir==h|Ir>h)=h;
            Ir(Ir<l)=l; 
            r=round(rescale(Ir)*10);
        % Create colormap 
        
        cmap = zeros(10, 3);
   
    cmap = [1,1,1;...  
    0.9, 0.9, 0.9; ...       
    0, 0.7, 1; ...  
    1, 0.4, 1; ...
    1, 0.9, 0; ...       
    0, 0.5, 0; ...       
    0, 0.6, 0; ...       
    0, 0.7, 0; ...       
    0, 1, 0; ...       
    0., 0.2, 0.]   ;        
      
      colormap(cmap)
     % Display the image with the colormap applied.
%         figure,imshow(r, cmap);
       rgbImage = ind2rgb(r, cmap);
       imshow(r, cmap);

end
%%
%%%%%%%%%%% for adding frames

fname=['your file'];

%define
totalframenumb=50; % number of frame
images = cell(totalframenumb,1); 

for i=1:totalframenumb %i=10
    I00{i}=double(imread([ fdir fname '.tif'],i)); %modify image formate
    I0{i}=imgaussfilt(I00{i},0.5);
end


  Isum=zeros(size(I0{1}),'double');
for ii=1:totalframenumb
    Isum=Isum+I0{(totalframenumb-(totalframenumb-ii))}; %50-(50-k)
    %%%%%%setting range to be mapped
    %I=imgaussfilt(I0,1);
    Ir=rescale(Isum)*10;
    l=0.; h=l+3;%3.5; 
    high=num2str(h); low=num2str(l);
     
    Ir(Ir==h|Ir>h)=h;
    Ir(Ir<l)=l; %%4, 1.1 good start
    r=round(rescale(Ir)*10);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
         %   r=round(rescale(Isum)*10);
        %    
            cmap = zeros(10, 3);
  
          cmap = [1,1,1;...   
        0.9, 0.9, 0.9; ...      
        0, 0.7, 1; ...  
        1, 0.4, 1; ...
        1, 0.9, 0; ...      
        0, 0.5, 0; ...       
        0, 0.6, 0; ...       
        0, 0.7, 0; ...       
        0, 1, 0; ...       
        0., 0.2, 0.]   ;        
         % Display the image with the colormap applied.
             %figure,
       imshow(r, cmap);

        rgbImage = ind2rgb(r, cmap);
       % images{ii} = rgbImage;
        result=[rescale(cat(3,  Isum, Isum,  Isum)),rgbImage];
        images{ii} = result;
end
