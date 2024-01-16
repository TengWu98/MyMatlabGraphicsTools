function szy_PlotMesh_Discrete_vf(vertex, face, LabelOfEachFace)
% szy_PlotMesh_Discrete_vf(vertex, face, LabelOfEachFace)
% ���Ʋ�ɫ����ģ�ͣ�LabelOfEachFace��һ������������������������ģ�͵���Ƭ��һ�£���ʾÿ��
% ��Ƭ�ϵı�ǩֵ����1��ʼ���������������ǩֵ�Ĳ�ͬ��ģ�͵���Ƭ���в�ͬ��ɫ��
mesh = makeMesh(vertex', face');
% ����readMeshֻ��֧��.obj�����Ը���Ϊread_mesh
% mesh = readMesh(fileName, 'nC');
Colors = [ 1,0,0; 0,1,0; 0,0,1; 1,0,1; 0,1,1; 1,1,0; 
            1,.3,.7; 1,.7,.3; .7,1,.3; .3,1,.7; .7,.3,1; .3,.7,1; 
            1,.5,.5; .5,1,.5; .5,.5,1; 1,.5,1; .5,1,1; 1,1,.5; 
            .5,0,0; 0,.5,0; 0,0,.5; .5,0,.5; 0,.5,.5; .5,.5,0];
if size(LabelOfEachFace, 1) == 1
    LabelOfEachFace = LabelOfEachFace';
end
% 24����ɫѭ�������㿴�壬˼·������Princeton Segmentation Benchmark�Դ��ĳ���mshView��
label = mod(LabelOfEachFace - 1, 24) + 1;
vC = Colors(label, :);
plotMesh(mesh, 'f', vC);
end