function maxScore = frames_getMaxScore()
    
    pics = dir('TestImages/*.jpg');
    scoreTemp=[];

for k = 1:numel(pics)
   img = imread(pics(k).name);
   normed11=frames_image_in_score_out(img);
   normed22(k)=normed11;
   
   %disp(normed);

   scoreTemp(k)=normed11;
   
   %json='"id:';
   %disp(json);
end

maxScore=max(scoreTemp);
disp(maxScore);
disp('MaxScore Above');


for k = 1:numel(pics)
   img = imread(pics(k).name);
   normed11=frames_image_in_score_out(img);
   normed22(k)=normed11;
   score=normed11;
      score=score./maxScore*100;
   
   
   %disp(normed);
   json2 = fopen('results_all.json','a'); 

   scoreTemp(k)=normed11;
   fprintf(json2,'{');
   fprintf('{');
   fprintf(json2,'"id": %d, "name": "%s" , "rule": "frames", "score": %d', k, pics(k).name,ceil(score));
   fprintf('"id": %d, "name": "%s" , "rule": "frames","score": %d', k, pics(k).name,ceil(score));
 
   if (k==numel(pics)) 
        fprintf(json2,'}\n');
        fprintf('}\n');

    else
        fprintf(json2,'},\n');
        fprintf('},\n');

    end
    fclose(json2);

   %json='"id:';
   %disp(json);
end

