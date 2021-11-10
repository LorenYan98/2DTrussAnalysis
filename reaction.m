function R = reaction(u, K_members, m_deg_of_freedom, u_dof, trans_mat, fixities, mem_nodes)

% count members in analysis
n_members = size(K_members);
n_members = n_members(3);

% get degrees of freedom for total truss
u_tot = reshape(m_deg_of_freedom, [n_members * 6,1]);
u_tot = unique(u_tot);

% set 0 for fixed ends
u_tot(fixities,:) = 0;

% count potential degrees of freedom
t_dof = length(u_tot);
n_tot = t_dof / 3;

for n = 1:length(u_dof)
    
    u_tot(u_dof(n)) = u(n);
    
end
disp = num2str(u_tot);
node = zeros(t_dof, 1);
forces = zeros(t_dof, 1);
reactions = zeros(t_dof, 1);
dir_disp = cell(t_dof, 1);
dir_forces = cell(t_dof, 1);
dir_reactions = cell(t_dof, 1);

for n = 1:n_tot
    
    dir_disp{3*n-2,1} = 'X';
    dir_disp{3*n-1,1} = 'Y';
    dir_disp{3*n,1} = 'R';
    
    dir_forces{3*n-2,1} = 'X';
    dir_forces{3*n-1,1} = 'Y';
    dir_forces{3*n,1} = 'M';
    
    dir_reactions{3*n-2,1} = 'P';
    dir_reactions{3*n-1,1} = 'V';
    dir_reactions{3*n,1} = 'M';
    
end


for n = 1:n_members

u_m = zeros(6, 1);
dof = reshape(m_deg_of_freedom(:,:,n),[6,1]);

node_i = mem_nodes(1,1,n);
node_j = mem_nodes(1,2,n);

node(3*node_i-2, 1) = node_i;
node(3*node_j-2, 1) = node_j;

% build the displacements for each end 

   for n_dof = 1:6
       
       u_m(n_dof, 1) = u_tot(dof(n_dof), 1);
       
   end 
K = K_members(:,:,n);
global_reactions = K * u_m ;
local_reactions = trans_mat(:,:,n) * global_reactions;

        
forces(3*node_i-2,1) = global_reactions(1);
forces(3*node_i-1,1) = global_reactions(2);
forces(3*node_i,1) = global_reactions(3);
forces(3*node_j-2,1) = global_reactions(4);
forces(3*node_j-1,1) = global_reactions(5);
forces(3*node_j,1) = global_reactions(6);

reactions(3*node_i-2,1) = local_reactions(1);
reactions(3*node_i-1,1) = local_reactions(2);
reactions(3*node_i,1) = local_reactions(3);
reactions(3*node_j-2,1) = local_reactions(4);
reactions(3*node_j-1,1) = local_reactions(5);
reactions(3*node_j,1) = local_reactions(6);

end

node = num2str(node);
dir_disp = strrep(dir_disp,char(91),'');
dir_forces = strrep(dir_forces,char(91),'');
forces = num2str(forces);
dir_reactions = strrep(dir_reactions,char(91),'');
reactions = num2str(reactions);

R = table(node, dir_disp, disp, dir_forces, forces, dir_reactions, reactions); 
R.Properties.VariableNames{1} = 'Node'; 
R.Properties.VariableNames{2} = 'DD';
R.Properties.VariableNames{3} = 'Displacement';
R.Properties.VariableNames{4} = 'DG' ;
R.Properties.VariableNames{5} = 'Global_Forces'; 
R.Properties.VariableNames{6} = 'DL' ;
R.Properties.VariableNames{7} = 'Local_Forces';
