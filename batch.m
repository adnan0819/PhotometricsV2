function maxScore = batch()
    
    pics = dir('TestImages/*.jpg');
    maxScore=0;
    
for k = 1:numel(pics)
   img = imread(pics(k).name);
    
   fullArea=size(img,1)*size(img,2);
%saliency=gbvs(img);
    saliency = ittikochmap(img);
    gridPoints=drawGrid(img);
    centroidOfSalientROI=labelROICentroid(saliency.master_map_resized);
    [dist, score]=distances(centroidOfSalientROI, gridPoints);
    maxDim=max(size(img,1),size(img,2));
    normed=ROT_Score(score, centroidOfSalientROI,fullArea, maxDim);
   
   
   normed2(k)=normed;
   disp(normed)
   if(normed>maxScore) 
       maxScore=normed;
   end
   %disp(normed);
   scoreTemp(k)=normed;
   

   %json='"id:';
   %disp(json);
end

maxScore=max(scoreTemp);



%---------------
    
    
for k = 1:numel(pics)
   img = imread(pics(k).name);
   fullArea=size(img,1)*size(img,2);
%saliency=gbvs(img);
    saliency = ittikochmap(img);
    gridPoints=drawGrid(img);
    centroidOfSalientROI=labelROICentroid(saliency.master_map_resized);
    [dist, score]=distances(centroidOfSalientROI, gridPoints);
    maxDim=max(size(img,1),size(img,2));
    normed=ROT_Score(score, centroidOfSalientROI,fullArea, maxDim);
   
   score=normed;
   %disp(normed);
   
   json = fopen('results_all.json','a'); 
   fprintf(json,'{');
   fprintf('{');
   
      fprintf(json,'"id": %d, "name": "%s" , "rule": "ROT", "score": %d', k, pics(k).name,ceil(score*100/maxScore));
   fprintf('"id": %d, "name": "%s" , "rule": "ROT": %d', k, pics(k).name,ceil(score*100/maxScore));
 
   
   if (k==numel(pics)) 
        fprintf(json,'}\n');
        fprintf('}\n');

    else
        fprintf(json,'},\n');
        fprintf('},\n');

    end
    fclose(json);
   
   

   %json='"id:';
   %disp(json);
end
