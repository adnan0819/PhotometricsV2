function maxScore = frames_batch()
    
    pics = dir('TestImages/*.jpg');
    
for k = 1:numel(pics)
   img = imread(pics(k).name);
   normed=frames_json(img);
   normed2(k)=normed;
   
   %disp(normed);
   scoreTemp(k)=normed;
   

   %json='"id:';
   %disp(json);
end

maxScore=max(scoreTemp);



%---------------
    
    
for k = 1:numel(pics)
   img = imread(pics(k).name);
   normed=frames_json(img);
   normed2(k)=normed;
   disp('normed in batch');
   disp(normed);
   
   json = fopen('results.json','a'); 
   fprintf(json,'{');
   fprintf('{');
   fprintf(json,'"id": %d, "name": "%s" , "score:" %d', k, pics(k).name, ceil(normed/maxScore*100));
   fprintf('"id": %d, "name": "%s" , "score:" %d', k, pics(k).name, ceil(normed/maxScore*100));
 
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
