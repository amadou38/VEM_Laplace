function V = AnalV(mesh,a,b,n,m)
% Vecteurs propres analytique
% AUTEUR : Diallo Amadou, 28/09/2020
%
X = mesh.vertices;
V = zeros(size(X,1),n*m);
k = 1;
for i = 0:n
    for j = 0:m
        if (i+j ~= 0)
            V(:,k) = (i/a)*cos(i*pi*X(:,1)/a).*cos(j*pi*X(:,2)/b);
            k = k + 1;
        end
    end
end
for i = 0:n
    for j = 0:m
        if (i+j ~= 0)
                if (V(l,k) == 0)
                    V(:,k) = (j/a)*cos(i*pi*X(:,1)/a).*sin(j*pi*X(:,2)/b);
                end
            k = k + 1;
        end
    end
end
end