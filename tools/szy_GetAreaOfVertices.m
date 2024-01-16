% AreaOfVertex = szy_GetAreaOfVertices(modelFileName)
% �õ����ж����ϵ�Voronoi�����
function AreaOfVertex = szy_GetAreaOfVertices(modelFileName)
    [vertex, face] = read_mesh(modelFileName);
    AreaOfVertex = szy_GetAreaOfVertices_vf(vertex, face);
end