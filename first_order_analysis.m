% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % FIRST ORDER ANALYSIS OF FRAMES AND TRUSSES  % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

clc
clearvars

file_name = 'member_input_file.csv';
% format_input_file clears all NaN values and return three tables of
% members,nodes and loads respectively 
[members, nodes, loads] = format_input_file(file_name);

% Details in the 'fixities.m' function
fixities = fixities(nodes);
[S, K_members, deg_of_freedom, dof, trans_mat, mem_nodes] = stiffness(members, nodes, fixities);
F = global_end_forces(members, nodes, loads);

u = S \ F;

R = reaction(u, K_members, deg_of_freedom, dof, trans_mat, fixities, mem_nodes);

disp(R)
