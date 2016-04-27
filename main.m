function [saliency, gridPoints, centroidOfSalientROI, dist, score, normed] = main(img)


fullArea=size(img,1)*size(img,2);
%saliency=gbvs(img);
saliency = ittikochmap(img);
gridPoints=drawGrid(img);
centroidOfSalientROI=labelROICentroid(saliency.master_map_resized);
imwrite(saliency.master_map_resized,'interim2.jpg');
[dist, score]=distances(centroidOfSalientROI, gridPoints);
maxDim=max(size(img,1),size(img,2));
normed=ROT_Score(score, centroidOfSalientROI,fullArea, maxDim);
   
   json = fopen('results.json','a'); 
   fprintf(json,'{');
   fprintf('{');
   maxScr=batch();
   fprintf(json,'"id": %d, "name": "%s" , "rule": "ROT", "score": %d', 1, 'Input image',ceil(normed/maxScr*100));
   fprintf('"id": %d, "name": "%s" , "rule": "ROT": %d', 1, 'Input image',ceil(normed/maxScr*100));
 
        fprintf(json,'}\n');
        fprintf('}\n');

  
    fclose(json);