function normed=normed(score, centroidOfSalientROI,fullArea)
    
    sum=0;
    disp(sum);
    
    for i=1:size(score,1)
        
        normed=(1/min(score(i,:)))*centroidOfSalientROI(i).Area/fullArea;
        sum=sum+normed;
    end
    normed=sum;