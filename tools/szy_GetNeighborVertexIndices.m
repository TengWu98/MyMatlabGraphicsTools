% �õ�����Vertex�У���QueryVertex��ÿһ���㼸��λ����ӽ���NeighborCount���㡣
% Vertexÿһ�д���һ���㣬QueryVertex��ÿһ�д���һ���㡣
% NeighborVertexIndices��i�б�ʾ��QueryVertex��i������ڽ�����ż��ϡ�
% Distances��i�б�ʾ��QueryVertex��i������ڽ�����뼯�ϡ�
function [NeighborVertexIndices, Distances] = szy_GetNeighborVertexIndices(Vertex, QueryVertex, NeighborCount)
	NS = KDTreeSearcher(Vertex');
	[NeighborVertexIndices, Distances] = knnsearch(NS, QueryVertex', 'k', NeighborCount);
	NeighborVertexIndices = NeighborVertexIndices';
	Distances = Distances';
end