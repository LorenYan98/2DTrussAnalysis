function F = global_end_forces(members, nodes, loads)

size_input = size(nodes);
n_nodes = size_input(1,1);

F = zeros(n_nodes * 3, 1);

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
i = members.i_node;
j = members.j_node;

% Extract all values under column X, Y and R from the table 'nodes'
% 1 means fixed and 0 means the point is free to move
fixities = [nodes.X, nodes.Y, nodes.R];

for r = 1:n_nodes
    for c = 1:3
        fixities(r,c) = (c + 3*(r-1))*fixities(r,c);
    end
end
fixities = reshape(fixities, 1, []);
fixities(fixities == 0) = [];
fixities = sort(fixities, 'descend');


% Load in all information for all members
load_type = loads.load_type;
members = loads.member;
direction = loads.direction;
magnitude = loads.magnitude;
start_location = loads.start_pos;
load_length = loads.length;

for n = 1:length(members)
    
    % get information for each member
    member = members(n);
    i_temp = i(member);
    j_temp = j(member);
    start_loc = start_location(n);
    l_type = load_type(n);
    l_magnitude = magnitude(n);
    l_direction = direction(n);
    l_length = load_length(n);
    
   % i is the starting point and j is the end point for each member
    i_dof = [1 , 2, 3] + (i_temp - 1) * 3;
    j_dof = [1 , 2, 3] + (j_temp - 1) * 3;
    dof = [i_dof, j_dof];
    
   % find length of beam
    i_end = table2array([nodes(i_temp, 5), nodes(i_temp, 6)]);
    j_end = table2array([nodes(j_temp, 5), nodes(j_temp, 6)]);
    [beam_length, ~, ~] = position_bm(i_end, j_end);
    
    % get global forces on each member
    f = b_glob_end_forces(start_loc, l_type, l_magnitude, l_direction, l_length, beam_length);
   
    % add to matrix
    for f_r = 1:6   
        F_r = dof(f_r);
        F(F_r, 1) = f(f_r, 1) + F(F_r, 1);   
    end
end

F(fixities,:) = [];

