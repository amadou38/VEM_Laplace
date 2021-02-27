function uex = SolEx(X)
% AUTEUR : Diallo Amadou, 28/09/2020

x = X(:,1); y = X(:,2);
u1 = sin(pi*x).*sin(pi*y);
uex = u1;

end