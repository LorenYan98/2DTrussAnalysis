
function [S, K_members, deg_of_freedom, dof, trans_mat, mem_nodes] = stiffness(members, nodes, fixities)
% Find the # of members
size_input = size(members);
n_members = size_input(1);

%Find the # of nodes
size_input = size(nodes);
n_nodes = size_input(1);


% Elastic modulus
E = members.E;
% Moment of Inertia
I = members.I;
% Cross sectional area
A = members.A;
i = members.i_node;
j = members.j_node;


% To improve speed of code 
% Create the empty stiffness matrix and the corresponding matrix K for each beam member
% 6*6 matrix contains force P(parallel to the beam), shear force V(vertical force)
% and Bending Moments M 
S = zeros(n_nodes * 3);
K_members = zeros(6,6,n_members);
deg_of_freedom = zeros(1, 6, n_members);
trans_mat = zeros(6,6,n_members);
mem_nodes = zeros(1,2,n_members);

for n = 1:n_members
    % Get individual member properties
    % Temporary array that used to contain values 
    E_temp = E(n);
    I_temp = I(n);
    A_temp = A(n);
    i_temp = i(n);
    j_temp = j(n);
    

    % i is the starting point and j is the end point for each member
    i_dof = [1 , 2, 3] + (i_temp - 1) * 3;
    j_dof = [1 , 2, 3] + (j_temp - 1) * 3;
    
    % the degree of freedom for the current member
    dof = [i_dof, j_dof];
    
    % find length of beam for the current member
    i_end = table2array([nodes(i_temp, 5), nodes(i_temp, 6)]);
    j_end = table2array([nodes(j_temp, 5), nodes(j_temp, 6)]);
    [L, cos, sin] = position_bm(i_end, j_end);

    %Formula that used to calculate the local stiffness without transformation, eg. K1 K2 K3...Kn
    k = local_stiffness(L, E_temp, I_temp, A_temp);

    % For a structure with angles, use the transformation matrix 
    % to covert all oblique force on frames into x and y axis
    T = transformation_matrices (cos, sin);
    
    % Get member global stiffness, Reference textbook  (eq XXXX)
    K = T'* k * T;
    
    % store the global stiffness matrix Kn into the whole stiffness martix
    for K_c = 1:6
        S_c = dof(K_c);
        for K_r = 1:6
            S_r = dof(K_r);
            %if overlaped, add it on the original values
            S(S_r, S_c) = K(K_r, K_c) + S(S_r, S_c);
        end
    end
    
    K_members(:,:, n) = K;
    deg_of_freedom(:, :, n) = dof;
    trans_mat(:,:,n) = T;
    mem_nodes(:,:,n) = [i_temp, j_temp];

end

dof = reshape(deg_of_freedom, [n_members * 6,1]);
% cancel fixed conditions from dof
dof = unique(dof);
dof(fixities, :) = [];

% cancel fixed conditions from global stiffness#
S(fixities,:) = [];
S(:,fixities) = [];

