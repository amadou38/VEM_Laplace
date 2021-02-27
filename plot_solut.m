function plot_solut(mesh, solution)
% AUTEUR : Diallo Amadou, 28/09/2020
title('Approximate Solution');
max_n_vertices = max(cellfun(@length, mesh.elements));
padding_function = @(vertex_list) [vertex_list' ...
			NaN(1,max_n_vertices-length(vertex_list))];
elements = cellfun(padding_function, mesh.elements, 'UniformOutput', false);
elements = vertcat(elements{:});
data = [mesh.vertices, solution];
patch('Faces', elements,...
	'Vertices', data,...
	'FaceColor', 'interp',... 
	'CData', solution);
axis('square')
xlim([min(mesh.vertices(:,1)) - 0.1, max(mesh.vertices(:,1)) + 0.1])
ylim([min(mesh.vertices(:,2)) - 0.1, max(mesh.vertices(:,2)) + 0.1])
zlim([min(solution) - 0.1, max(solution) + 0.1])
xlabel('x'); ylabel('y'); zlabel('u');
colormap('jet');
colorbar
end