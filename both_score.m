function normed=both_score(img)

gridPoints=drawGrid(img);
%maxScore=frames_getMaxScore();
rgbImage=img;
fontSize=20;
% Read in image into an array.
storedColorMap=3;
[rows columns numberOfColorBands] = size(rgbImage); 
% If it's monochrome (indexed), convert it to color. 
% Check to see if it's an 8-bit image needed later for scaling).
if strcmpi(class(rgbImage), 'uint8')
	% Flag for 256 gray levels.
	eightBit = true;
else
	eightBit = false;
end
if numberOfColorBands == 1
	if isempty(storedColorMap)
		% Just a simple gray level image, not indexed with a stored color map.
		% Create a 3D true color image where we copy the monochrome image into all 3 (R, G, & B) color planes.
		rgbImage = cat(3, rgbImage, rgbImage, rgbImage);
	else
		% It's an indexed image.
		rgbImage = ind2rgb(rgbImage, storedColorMap);
		% ind2rgb() will convert it to double and normalize it to the range 0-1.
		% Convert back to uint8 in the range 0-255, if needed.
		if eightBit
			rgbImage = uint8(255 * rgbImage);
		end
	end
end 
% Display the original image.
%subplot(2, 2, 1);
%imshow(rgbImage);
%set(gcf, 'Position', get(0,'Screensize')); % Enlarge figure to full screen.
%set(gcf,'name','Find frames (squares, rectangles, triangles and circles)','numbertitle','off') 
%drawnow; % Make it display immediately. 
if numberOfColorBands > 1 
	title('Original Color Image', 'FontSize', fontSize); 
	grayImage = rgbImage(:,:,1);
else 
	caption = sprintf('Original Indexed Image\n(converted to true color with its stored colormap)');
	title(caption, 'FontSize', fontSize);
	grayImage = rgbImage;
end
% Display it.
%subplot(2, 2, 2);
%imshow(grayImage, []);
%title('Grayscale Image', 'FontSize', fontSize);
% Binarize the image.
binaryImage = grayImage < 100;
% Display it.
%subplot(2, 2, 3);
%imshow(binaryImage, []);
%title('Binary Image', 'FontSize', fontSize);
% Remove small objects.
binaryImage = bwareaopen(binaryImage, 300);
%se = strel('disk',5);
%binaryImage = imdilate(binaryImage,se);
% Display it.
%subplot(2, 2, 4);
%imshow(binaryImage, []);
%title('Cleaned Binary Image', 'FontSize', fontSize);
[labeledImage numberOfObjcts] = bwlabel(binaryImage);
%figure;
%imshow(binaryImage);
imwrite(binaryImage,'Input_Image_Binary_Map.jpg');

blobMeasurements = regionprops(labeledImage); 
% for square ((a>17) && (a<20))
% for circle ((a>13) && (a<17))
% for triangle ((a>20) && (a<30))
circularities=[];

fullArea=(size(rgbImage,1)*size(rgbImage,2));
maxDim=max(size(rgbImage,1),size(rgbImage,2));
[dist, score]=distances(blobMeasurements, gridPoints);

normed=ROT_Score(score, blobMeasurements,fullArea,maxDim);

%score=(score/(size(rgbImage,1)*size(rgbImage,2)))*1000;
%score=score./maxScore*100;
%disp('total');
%disp(score);
%circularities = [blobMeasurements.Perimeter.^2] ./ (4 * pi * [blobMeasurements.Area])
im=rgbImage;
hold on;

imshow(rgbImage);
for k = 1 : length(blobMeasurements)
  thisBB = blobMeasurements(k).BoundingBox;
  rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
  'EdgeColor','r','LineWidth',2 )
end

f = getframe(gca);
im = frame2im(f);

imwrite(im,'Input_Image_Salient_Salient_Regions.jpg');
score=normed*4; %LOOK AT THIS 4 LATER TO ADJUST

json = fopen('results.json','w'); 
   fprintf(json,'{');
   fprintf('{');
   fprintf(json,'"id": %d, "name": "%s" , "rule": "both1", "score": %d', 1, 'input image',ceil(score));
   fprintf('"id": %d, "name": "%s" , "rule": "both1","score": %d', 1, 'input image',ceil(score));
 
  
        fprintf(json,'}\n');
       
    fclose(json);
    
    disp(normed);
%    disp(maxScore);