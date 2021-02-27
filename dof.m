function [B,D] = dof(Verts,Xe,he,ne,np,p)
% Function calculant la matrice des degres de liberte et le second membre 
% de la projection: D_ra = dof_r(grad(p_a))
% 
% SYNOPSIS: [B,D] = dof(Verts,Xe,he,ne,np,p);
% INPUT   : ne   : nbre de noeuds                  .np  : nbre de monomes  
%           Verts: coordonees (x,y) de l element E              
%           Xe   : le centroide                     .he  : diametre
% OUTPUT  : D    : Matrice de degre de liberte
%           B    : second membre de la projection
% AUTEUR : Diallo Amadou, 28/09/2020

D = zeros(ne, np); D(:, 1) = 1;
B = zeros(np, ne); B(1, :) = 1/ne;
mod_wrap = @(x, a) mod(x-1, a) + 1; % A utility function for wrapping around a vector
for l = 1:ne
    vert = Verts(l, :); % This vertex and its neighbours
    prev = Verts(mod_wrap(l - 1, ne), :);
    next = Verts(mod_wrap(l + 1, ne), :);
    vertex_normal = [next(2) - prev(2), prev(1) - next(1)]; % Average of edge normals
    for k = 2:np % Only need to loop over non-constant polynomials
        poly_degree = p{k};
        monomial_grad = poly_degree / he; % Gradient of a linear is constant
        D(l, k) = dot(vert - Xe, poly_degree) / he;
        B(k, l) = 0.5 * dot(monomial_grad, vertex_normal);
    end
end
   


end