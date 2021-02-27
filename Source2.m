function F = Source2(ne,X,Xe,Area)
% AUTEUR : Diallo Amadou, 28/09/2020

% Uex(x,y) = (u1,u1) = (sin(pi*x)sin(pi*y), sin(pi*x)sin(pi*y))
F = zeros(ne,1);
x = Xe(1); y = Xe(2);
f = (2*pi*pi+1)*sin(pi*x).*sin(pi*y);
for i = 1:ne
    F(i) = f*Area/ne;
end

end