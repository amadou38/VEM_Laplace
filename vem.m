function [EV,V] = vem(ind,Neig,mesh)

% AUTEUR: Diallo Amadou, 28/09/2020

n_dofs = size(mesh.vertices, 1); 
n_polys = 3; % Method has 1 degree of freedom per vertex
K = sparse(n_dofs, n_dofs); % Stiffness matrix
M = sparse(n_dofs, n_dofs); % Mass matrix
F = zeros(n_dofs, 1); % Forcing vector
linear_polynomials = {[0,0], [1,0], [0,1]}; % Impose an ordering on the linear polynomials
prec = 3;
for el_id = 1:length(mesh.elements)
	vert_ids = mesh.elements{el_id}; % Global IDs of the vertices of this element
	verts = mesh.vertices(vert_ids, :); % Coordinates of the vertices of this element
	n_sides = length(vert_ids); % Start computing the geometric information
	area_components = verts(:,1) .* verts([2:end,1],2) - verts([2:end,1],1) .* verts(:,2);
	area = 0.5 * abs(sum(area_components));
	centroid = sum((verts + verts([2:end,1],:)) .* repmat(area_components,1,2)) / (6*area);
	diameter = 0; % Compute the diameter by looking at every pair of vertices
    for i = 1:(n_sides-1)
        for j = (i+1):n_sides
            diameter = max(diameter, norm(verts(i, :) - verts(j, :)));
        end
    end
    m = {@(x,y) 1, @(x,y) (x-centroid(:,1))/diameter, @(x,y) (y-centroid(:,2))/diameter};
    [B,D] = dof(verts,centroid,diameter,n_sides,n_polys,linear_polynomials);
	Me = local_mass(D,B,verts, centroid,m,n_polys,prec);
    K(vert_ids,vert_ids) = K(vert_ids,vert_ids) + local_stiffness(D,B); % Copy local to global
    M(vert_ids,vert_ids) = M(vert_ids,vert_ids) + Me; % Copy local to global for the mass matrix
    F_E = Source2(n_sides,verts,centroid,area); 
    F(vert_ids) = F(vert_ids) + F_E;
end

idofs = ~ismember(1:n_dofs, mesh.boundary); % Vertices which aren't on the boundary
K = K(idofs, idofs);
M = M(idofs,idofs);
tic
[V,EV] = eigs(K,M,Neig,'SM');
toc
EV = diag(EV);
for i = 1:ind    
    u = zeros(n_dofs,1);
    u(idofs) = V(:,i);
    % Normalisation
    u = u./(max(max(abs(u))));
    subplot(3,3,i)
    plot_solution(mesh,u);
    title(['lambda = ',num2str(EV(i))])
end

end