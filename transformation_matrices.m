% For a structure with angles, use the transformation matrix 
% to transfer all oblique frame or truss into x and y axis
function T = transformation_matrices (cos, sin)

T = [cos,  sin, 0, 0,    0,   0;
     -sin, cos, 0, 0,    0,   0;
     0,    0,   1, 0,    0,   0;
     0,    0,   0, cos,  sin, 0;
     0,    0,   0, -sin, cos, 0;
     0,    0,   0, 0,    0,   1];
 
end
