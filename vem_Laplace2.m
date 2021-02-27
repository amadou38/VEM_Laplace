function [u, Uex] = vem_Laplace2(mesh)

% AUTEUR: Diallo Amadou, 28/09/2020

nd = size(mesh.vertices, 1); 
np = 3; % Method has 1 degree of freedom per vertex
K = sparse(nd, nd); % Stiffness matrix
M = sparse(nd, nd); % Mass matrix
F = zeros(nd, 1); % Forcing vector
u = zeros(nd,1);
linear_polynomials = {[0,0], [1,0], [0,1]}; % Impose an ordering on the linear polynomials
prec = 3;
for el_id = 1:length(mesh.elements)
	vert_ids = mesh.elements{el_id}; % Global IDs of the vertices of this element
	verts = mesh.vertices(vert_ids, :); % Coordinates of the vertices of this element
	ne = length(vert_ids); % Start computing the geometric information
	area_components = verts(:,1) .* verts([2:end,1],2) - verts([2:end,1],1) .* verts(:,2);
	area = 0.5 * abs(sum(area_components));
	Xe = sum((verts + verts([2:end,1],:)) .* repmat(area_components,1,2)) / (6*area);
	diameter = 0; % Compute the diameter by looking at every pair of vertices
    for i = 1:(ne-1)
        for j = (i+1):ne
            diameter = max(diameter, norm(verts(i, :) - verts(j, :)));
        end
    end
    m = {@(x,y) 1, @(x,y) (x-Xe(:,1))/diameter, @(x,y) (y-Xe(:,2))/diameter};
    [B,D] = dof(verts,Xe,diameter,ne,np,linear_polynomials);
	Me = local_mass(D,B,verts, Xe,m,np,prec);
    K(vert_ids,vert_ids) = K(vert_ids,vert_ids) + local_stiffness(D,B); % Copy local to global
    M(vert_ids,vert_ids) = M(vert_ids,vert_ids) + Me; % Copy local to global for the mass matrix
    F_E = Source2(ne,verts,Xe,area); 
    F(vert_ids) = F(vert_ids) + F_E;
end

idofs = ~ismember(1:nd, mesh.boundary); % Vertices which aren't on the boundary
K = K(idofs, idofs);
M = M(idofs,idofs);
tic
u(idofs) = (K+M)\F(idofs);
toc
uex = SolEx(mesh.vertices); Uex = zeros(nd,1);
Uex(idofs) = uex(idofs);
E_inf = max(abs(u - Uex))/max(abs(Uex))   % Error E_inf
E_L2 = norm(u-Uex)/norm(Uex)              % Error E_L2

figure
plot_solut(mesh, Uex);
title('Solution - Uexacte ');
figure
plot_solut(mesh, u);
title('Solution - Uapp ');


end