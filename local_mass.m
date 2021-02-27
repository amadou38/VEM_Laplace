function Me = local_mass(D,B,Verts, Xe,p,np,prec)
% Fonction qui calcule la matrice de masse
%
% SYNOPSIS: Me = local_mass(D,B,Verts, Xe,p,np,prec);
% INPUT   : D   : matrice des dof        .B: second membre de la projection  
%           Verts: coordonees (x,y) de E .p: base des monomes            
%           Xe   : le centroide                     .np  : nbre de monomes
%           prec : precision pour la quadrature
% OUTPUT  : Me    : Matrice de masse
% AUTEUR : Diallo Amadou, 28/09/2020

H = zeros(np);
N = size(D,1);
for i = 1:np % Only need to loop over non-constant polynomials
    for j = 1:np
        if ((i == 1) && (j==1))
            prec1 = 1;
        else
            prec1 = prec;
        end
        f = @(x,y) p{i}(x,y).*p{j}(x,y);
        H(i, j) = integral_fct(f, Verts, Xe, prec1);
    end
end
P = (B*D) \ B; % Compute the local Ritz projector to polynomials
C = H*P;
P0 = H\C; % Compute the second local Ritz projector polynomials for the mass matrix 
st_term = H(1,1)*(eye(N) - D*P0)'*(eye(N) - D*P0); % for mass matrix
	
Me = P0'*H*P0 + st_term;

end