% convert to txt
clear all
close all

filename = "squares";
load(strcat(filename, ".mat"));

fid = fopen(strcat(filename, ".txt"), "w");
% vertices
fprintf(fid, '%d\n', size(vertices, 1));
fprintf(fid, '%32.16f %32.16f\n', vertices');
% elements
fprintf(fid, '%d\n', length(elements));
for i=1:length(elements)
    ne = length(elements{i});
    fprintf(fid, [repmat('%d ', 1, ne), '\n'], elements{i});
end
%boundary
fprintf(fid, '%d\n', length(boundary));
fprintf(fid, '%d\n', boundary);
fclose(fid);