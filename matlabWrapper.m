 %WRITE INTERIM IMAGES

 function matlabWrapper(image, category, rule)
 		
 		%path = strcat('Mir/', category,'/',image);

 		%img = dir('TestImages/*.jpg');
 		
 		img=imread(image); %ASSUMING "image" is a filename like im1234.jpg uploaded in the working directory
 		score_final=1;
 		
 		if(strcmp(rule,'ROT')){
			[saliency, gridPoints, centroidOfSalientROI, dist, score, normed] = main(img);
			fullArea=size(img,1)*size(img,2);
			%saliency=gbvs(img);
			saliency = ittikochmap(img);
			gridPoints=drawGrid(img);
			centroidOfSalientROI=labelROICentroid(saliency.master_map_resized);
			[dist, score]=distances(centroidOfSalientROI, gridPoints);
			maxDim=max(size(img,1),size(img,2));
			normed=ROT_Score(score, centroidOfSalientROI,fullArea, maxDim);
			score_final=normed;
			   
			   json = fopen('result.json','w'); 
			   fprintf(json,'{');
			   fprintf('{');
			   maxScr=300; %ONLY THIS DEPENDS ON CATEGORY
			   
			   fprintf(json,'"category": %s, "imageName": "%s", "rule": "ROT", "score": %d', category, image,ceil(normed/maxScr*100));
			   
			   %The block below is not needed
			   fprintf('"category": %s, "imageName": "%s", "rule": "ROT", "score": %d', category, image,ceil(score_final));

			        fprintf(json,'}\n');
			        fprintf('}\n');
	    	   fclose(json);
		}

		else if(strcmp(rule,'frame')){

			   normed=frames_json(img);
			   score_final=normed;

			   json = fopen('result.json','w'); 
			   fprintf(json,'{');
			   fprintf('{');
			   maxScr=300; %ONLY THIS DEPENDS ON CATEGORY
			   
			   fprintf(json,'"category": %s, "imageName": "%s", "rule": "frame", "score": %d', category, image,ceil(score_final));
			   
			   %The block below is not needed
			   fprintf('"category": %s, "imageName": "%s", "rule": "frame", "score": %d', category, image,ceil(score_final));

			        fprintf(json,'}\n');
			        fprintf('}\n');
	    	   fclose(json);

		}
		else if(strcmp(rule,'both')){

			   normed=both_score(img);
			   score_final=normed;

			   json = fopen('result.json','w'); 
			   fprintf(json,'{');
			   fprintf('{');
			   maxScr=300; %ONLY THIS DEPENDS ON CATEGORY
			   
			   fprintf(json,'"category": %s, "imageName": "%s", "rule": "both", "score": %d', category, image,ceil(score_final/maxScr*100));
			   
			   %The block below is not needed
			   fprintf('"category": %s, "imageName": "%s", "rule": "both", "score": %d', category, image,ceil(score_final/maxScr*100));

			        fprintf(json,'}\n');
			        fprintf('}\n');
	    	   fclose(json);


		}
