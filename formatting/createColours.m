% Create n colours in the RGB format

function colourMat = createColours (n)
    unitJump = round(1000/(n+1));
    colourMat = zeros(n,3);
    colourVec = (1:n)' * unitJump;
    colourMat(:,1) = floor(colourVec/100);
    colourMat(:,2) = floor((colourVec-colourMat(:,1)*100)/10);
    colourMat(:,3) = colourVec-colourMat(:,1)*100-colourMat(:,2)*10;
    colourMat = colourMat/10;
    
    
    
    
    
