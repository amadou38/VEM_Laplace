
%Error = load('ErrorLap.mat');
clear; close all; clc;
L2 = [0.00455847356498157;0.000922685071123033;0.000528612173577428;0.000109798163869421;5.57099977426828e-05];
h = [ 100 500 1000 5000 10000];
loglog(h, L2, 'r--o',h, 1./h, 'k-')
legend('Erreur L2','Ordre 1')
xlabel('NELEM'); ylabel('ErreurL2');
title('Norme L2')