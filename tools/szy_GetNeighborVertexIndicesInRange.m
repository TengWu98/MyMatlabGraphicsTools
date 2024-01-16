% �õ�����Vertex�У���QueryVertex��ÿһ������Range��Χ�ڵĵ㡣
% Vertexÿһ�д���һ���㣬QueryVertex��ÿһ�д���һ���㡣
% NeighborVertexIndices{i}��ʾ��QueryVertex��i������ڽ�����ż���(Ϊһ��������)��
% Distances{i}��ʾ��QueryVertex��i������ڽ�����뼯��(Ϊһ��������)��
function [NeighborVertexIndices, Distances] = szy_GetNeighborVertexIndicesInRange(Vertex, QueryVertex, Range)
	NS = KDTreeSearcher(Vertex');
	[NeighborVertexIndices, Distances] = rangesearch(NS, QueryVertex', Range);
	NeighborVertexIndices = NeighborVertexIndices';
	Distances = Distances';
end