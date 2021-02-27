% Main function
% AUTEUR : Diallo Amadou, 28/09/2020

clear; clc; close all;
addpath('meshes/');
addpath('maillages/');
addpath('../../Mesh/mesh_files/');

mesh_file = 'mesh213.mat';
mesh = load(mesh_file); % Load the mesh from a .mat file
mesh.vertices(:,2) = 1.1*mesh.vertices(:,2);
Neig = 15;
ind = 9;
[EV,V] = vem(ind,Neig,mesh);    % Calcul des valeurs et vecteurs propres
%[u, Uex] = vem_Laplace2(mesh); % Calcul des solutions u et uex
a = 1; b = 1.1; n = sqrt(Neig+1)-1; m = n;
% x = 1:Neig;
% figure,
% p = plot(x,lmbd, 'r',x,EV,'b-.');
% p(1).LineWidth = 2;
% p(2).LineWidth = 2;
%p(1).Marker = '*';
% xlabel('iterations'); ylabel('eigenvalues');
% legend('Analytical eigenvalues','Numerical eigenvalues');