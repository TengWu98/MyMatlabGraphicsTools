% ����άģ�ͽ���MDS�任����άģ�Ͷ���������̫�࣬
% 10000����ʱ��ǳ������������Сʱ��������1000����࣬�ܿ졣
% ����ʹ��ǰ��ö���άģ���ȼ�һ�¡�
function [newVertex, face] = szy_MeshMDS(vertex, face)
DistanceMatrix = szy_GetGeodesicDistanceMatrix_dijkstra_vf(vertex, face);
Y = mdscale(DistanceMatrix, 3);
newVertex = Y';
end
