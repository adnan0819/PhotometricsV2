function batch_both()
    
    pics = dir('TestImages/*.jpg');
    %maxScore=0;
    
for k = 1:numel(pics)
   img = imread(pics(k).name);
    normed=both_score(img);
   %json='"id:';
   %disp(json);
end

%maxScore=max(scoreTemp);



%---------------
    
    
for k = 1:numel(pics)
   img = imread(pics(k).name);
   normed=both_score(img);
   score=normed;
   %disp(normed);
   disp(score);
   disp('score up there to write');

   json = fopen('results_all.json','w'); 
   fprintf(json,'{');
   fprintf('{');
   
      fprintf(json,'"id": %d, "name": "%s" , "rule": "Both", "score": %d', k, pics(k).name,ceil(score*100));
   fprintf('"id": %d, "name": "%s" , "rule": "Both": %d', k, pics(k).name,ceil(score*100));
 
   
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
close all;