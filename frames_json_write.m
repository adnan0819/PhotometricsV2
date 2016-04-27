function normed=frames_image_in_score_out(img)


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

if numberOfColorBands > 1 
	title('Original Color Image', 'FontSize', fontSize); 
	grayImage = rgbImage(:,:,1);
else 
	caption = sprintf('Original Indexed Image\n(converted to true color with its stored colormap)');
	title(caption, 'FontSize', fontSize);
	grayImage = rgbImage;
end

binaryImage = grayImage < 100;

binaryImage = bwareaopen(binaryImage, 300);

[labeledImage numberOfObjcts] = bwlabel(binaryImage);
blobMeasurements = regionprops(labeledImage, 'Perimeter','Area' , 'BoundingBox'); 

% for square ((a>17) && (a<20))
% for circle ((a>13) && (a<17))
% for triangle ((a>20) && (a<30))
circularities=[];
score=0;

for t = 1 : numberOfObjcts
   % if(blobMeasurements(t).Area>(size(rgbImage,1)*size(rgbImage,2)*10/100))
        q=(blobMeasurements(t).Perimeter.^2) ./ (4 * pi * blobMeasurements(t).Area);
        circularities=[circularities q];
        score=score+(blobMeasurements(t).Area);
        %disp(score);
    %end
end
score=(score/(size(rgbImage,1)*size(rgbImage,2)));
score=score*1000;
disp('total');
disp(score);
%circularities = [blobMeasurements.Perimeter.^2] ./ (4 * pi * [blobMeasurements.Area])

normed=score;
