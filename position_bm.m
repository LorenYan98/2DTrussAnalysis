
% This function calculates the length of a beam given the X and Y
% coordinates of the left and right side of the beam respectively. 

function [L, cos, sin] = position_bm(i, j)
    
    X1 = i(1);
    Y1 = i(2);
    X2 = j(1);
    Y2 = j(2);
    %find delta x and delta y, then use a^2+b^2 = c^ find the length of the
    %beam and the sin(thi) and cos(thi)
    L = sqrt((X2-X1)^2 + (Y2-Y1)^2);
    cos = (X2 - X1) / L;
    sin = (Y2- Y1) / L;

end

