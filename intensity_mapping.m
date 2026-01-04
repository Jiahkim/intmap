% This script averages image frames over a specified time window
% Clear workspace
clear;;

%% ====== User-defined settings ======
fdir = 'file directory';    % Path to the folder containing your images
fname = 'file name';        % Base name of your image file(s)

totalframenumb = 50;        % Total number of frames to use
timewindow = 3;             % Number of frames for averaging
                             % Example: 3 means averaging previous (-1), current (0), and next (+1) frames
interval = 1.7;             % Time-lapse interval between frames (e.g., seconds)

l = 0;                      % Low intensity level for display/adjustment
h = l + 4;                  % High intensity level for display/adjustment
gamma = 1;                   % Gamma correction (non-linear intensity adjustment, 1 = no change)

%% ====== Notes ======
% - Make sure fdir points to the correct folder
% - Ensure fname matches your file naming pattern
% - Adjust 'totalframenumb' to the number of frames you actually have
% - 'timewindow' should be an odd number for symmetric averaging around current frame

images = cell(totalframenumb,1); 
for i=1:totalframenumb %i=10
    I00{i}=double(imread([fdir fname '.tif'],i )).^gamma;
   % I0{i}=imgaussfilt(I00{i});
end

for ii=floor(timewindow/2)+1%:totalframenumb-floor(timewindow/2)-1
 Isum=zeros(size(I00{1}),'double');
 tosum=I00(ii-floor(timewindow/2):ii+floor(timewindow/2));
   for iii=1:timewindow
       Isum=(Isum+tosum{iii}); %50-(50-k)
   end
   %%%%%%setting range to be mapped
    %I=imgaussfilt(I0,1);
    Ir0=rescale(imgaussfilt(Isum,1))*10;
      if ii ==floor(timewindow/2)+1
          ref = Ir0;
      end
      Ir= Ir0*mean(ref,"all")/mean(Ir0,"all");


    high=num2str(h); low=num2str(l);
     
    Ir(Ir==h|Ir>h)=h;
    Ir(Ir<l)=l; %%4, 1.1 good start
    r=round(rescale(Ir)*10);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
         %   r=round(rescale(Isum)*10);
        %    
            cmap = zeros(10, 3);
      %BPY
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
         % % Display the image with the colormap applied.
         %    figure,
         %       imshow(r, cmap);
           %     pause(1)
              % % 
rgbImage = ind2rgb(r, cmap);
           % images{ii} = rgbImage;
result=[rescale(cat(3,  Isum, Isum,  Isum)),rgbImage];
           % images{ii} = result;
           
%%Activate section below to save intensity map
%  Res = insertText(result, [0 0], [num2str(ii*interval) '±' num2str(floor(timewindow/2*interval)) 'sec'], 'AnchorPoint','LeftTop','TextColor' , 'white', 'fontsize', 10, 'BoxOpacity',0 );
%  %Res(163:164, 301:309,:)=255; % 9pix for scale bar.
%  Res(17:19, 3:14,:)=255; % 9pix for scale bar.
%  Res = insertText(Res, [0 19], '1um', 'AnchorPoint','LeftTop','TextColor' , 'white', 'fontsize', 10, 'BoxOpacity',0 );
%  images1{ii} = Res;
%     if ~exist([fdir 'sum' num2str(timewindow) 'frames' ])      
%     mkdir([fdir fname 'sum' num2str(timewindow) 'frames' ])   
%     end

%  imwrite(Res, [fdir  fname 'sum' num2str(timewindow) 'frames/' fname 'T' num2str(timewindow) 'sec_h' high 'l' low 'fr' num2str(ii) '.tif'], 'Resolution', 400);  
% % 
%imwrite(result, [fdir  fname 'sum' num2str(timewindow) 'frames/' fname 'T' num2str(timewindow) 'sec_h' high 'l' low 'fr' num2str(ii) '.tif'], 'Resolution', 400);  
% %     % f=gcf; exportgraphics(f,[fdir fname 'SON_h' high 'l' low 'fr' num2str(i) '.pdf'],'ContentType','vector',...
% %     %              'BackgroundColor','none','Resolution',400)



end
