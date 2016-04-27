function s=labelROICentroid(gbvsmap)
% This function takes gbvs map and labels the salient regions
% More importantly, it returns the centroids of those regions 


bw=im2bw(gbvsmap,0.5);

%may need closing here
%se=strel('disk',40);
%bw=imerode(bw,se);
L = bwlabel(bw);


s = regionprops(L);
distance=[];


%UNCOMMENT BELOW FOR DEMO

%figure;
%imshow(bw);
%figure;
%hold on
%for k = 1:numel(s)
%    c = s(k).Centroid;
%    text(c(1), c(2), sprintf('%d', k), ...
%        'HorizontalAlignment', 'center', ...
%        'VerticalAlignment', 'middle');
%end
%hold off


