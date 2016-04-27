function normed=ROT_Score(score, centroidOfSalientROI,fullArea,maxDim)
    
    %rawScore=min(score(i,:));
    %maxScore=max(score(i,:));
    %temp=maxDim/3/2;
    
    
    sum=0;
    bench=0;
    for i=1:size(score,1)
        %disp(i);
        %disp(fullArea);
        %a=((maxDim/6)/(min(score(i,:))))/maxDim;
        %a=1/((max(score(i,:)))/(min(score(i,:))));
        %a=1/(maxDim/(min(score(i,:)))); THIS WORKS
        %a is the measure of alignment from grids
        a=((min(score(i,:)))/(maxDim*2/3))*0.5;
        b=(centroidOfSalientROI(i).Area/fullArea)*0.5;
        %disp(centroidOfSalientROI(i).Area);
        bench=max(score(i,:));
        bench=bench*fullArea;
        t(i)=b;
        %disp(max(score(i,:)));
        %disp(min(score(i,:)));
        
        normed=(b)/(a);
        %normed=((10*a)+(10*b))/2;
        %disp(normed);
        sum=(sum+(normed*1));
    end
    sum=sum/size(score,1); %size(score,1)is the number of ROIs
    
    
    normed=sum*100;
    
    