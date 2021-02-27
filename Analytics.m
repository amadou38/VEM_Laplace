function lmbd = Analytics(a,b,n,m)
% valeurs propres analytique analytique
% AUTEUR : Diallo Amadou, 28/09/2020
lmbd = zeros(1,n*m);
k = 1;
for i = 0:n
    for j = 0:m
        if (i+j ~= 0)
            lmbd(k) = (pi^2)*((i/a)^2 + (j/b)^2);
            k = k + 1;
        end
    end
end
%lmbd = sort(lmbd);
end