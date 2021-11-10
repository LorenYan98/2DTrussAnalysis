function [members, nodes, loads] = format_input_file(file_name)
%Read the file 
input_file = readtable(file_name);
%Select values that under the column 'member'....'j_node'
members = input_file(:, {'member', 'E', 'I', 'A', 'i_node', 'j_node'});

% ismissing(members) detects all NaN values in the matrix
% ~any(ismissing(members),2) gives a 4*1 matrix --- detects all rows
% members(...) gives valid data
members =members(~any(ismissing(members),2),:);
nodes = input_file(:, {'node_num', 'X', 'Y', 'R', 'X1', 'Y1'});
% Select values that under the column 'member'....'j_node'
% Same idea
nodes =nodes(~any(ismissing(nodes),2),:);
loads = input_file(:, {'load_type', 'member', 'direction', 'magnitude', 'start_pos', 'length'});
loads = loads(~any(ismissing(loads),2),:);

end

% format_input_file('member_input_file.csv')