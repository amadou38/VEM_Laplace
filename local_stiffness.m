function Ke = local_stiffness(D,B)
% Fonction qui calcule la matrice de rigidite 
%
% SYNOPSIS: Ke = local_stiffness(D,B);
% INPUT   : D   : matrice des dof        .B: second membre de la projection 
% OUTPUT  : Ke    : Matrice de rigidite
% AUTEUR : Diallo Amadou, 28/09/2020

N = size(D,1);
P = (B*D) \ B;
st_term = (eye(N) - D * P)' * (eye(N) - D * P);
G = B*D; G(1, :) = 0;
Ke = P' * G * P + st_term;
   

end