function fixities = fixities(nodes)
% Detect the level of the freedom of a structure

size_input = size(nodes);
% Output the number of nodes, which is 4 nodes in this case
n_nodes = size_input(1);

% Extract all values under column X, Y and R from the table 'nodes'
% 1 means fixed and 0 means the point is free to move
fixities = [nodes.X, nodes.Y, nodes.R];

% The for loop assigns all fixed nodes unique numbers with three directions respectively  
for r = 1:n_nodes
    for c = 1:3
        fixities(r,c) = (c + 3*(r-1))*fixities(r,c);
    end
end
fixities = reshape(fixities, 1, []);
fixities(fixities == 0) = [];
fixities = sort(fixities, 'descend');

end
