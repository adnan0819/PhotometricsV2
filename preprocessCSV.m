 % NOTE TO SELF WRITE INTERIM IMAGES - ALL DONE EXCEPT GRID
function preprocessCSV(rule)
                    files = dir('MirFlickrSubsetByCategory/');   % assume starting from current directory
                    filenames = {files.name};
                    subdirs = filenames([files.isdir]);
                    max=0;
                    categories=[];
                    for s = 3:length(subdirs)
                      subdir = subdirs{s};
                      categories=[categories subdir];
                      path = strcat('MirFlickrSubsetByCategory/', 'others/');
                      disp(path);
                      %img = dir('TestImages/*.jpg');
                      files2 = dir(path);  
                      filenames2 = {files2.name};
                      picPath=strcat(path,'/', '*.jpg');
                      picFiles=dir(picPath);
                      pictureNames={picFiles.name};
                      for q=3:length(pictureNames)
                         close all;
                         piksar= strcat('MirFlickrSubsetByCategory/', 'others','/',pictureNames(q));
                         piksarTemp=pictureNames(q);
                         disp(piksar{1});
                         class(piksar{1})
                         disp(piksar{1});
                         score_final2=batchProcessor(piksar{1},subdir,rule);
                         
                         name=strcat('allCSV','.csv');
                         writepath=strcat('scores/',name);
                         if exist(writepath, 'file')
                             
                             json = fopen(writepath,'a');
                             disp('NEW')
                         
                         else
                             json = fopen(writepath,'w');
                         end
			  
               
			   
			   fprintf(json,'%s,%s,%d,\n', piksarTemp{1},rule,ceil(score_final2));
			   
                     
	    	   fclose(json);
               
                         %disp(pictureNames(q));
                         %if(score_final2>max) max=score_final2;
                         %end
                      %end
                     % disp(picPath);
                     %disp('Max');
                     % disp(max);
                        %disp(subdir);   % for example
                      end
                    end
 	
