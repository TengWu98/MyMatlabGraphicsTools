function GaussianCurvatures = szy_Compute_GaussianCurvatureAllVertex_vf(vertex, face)
% ��������
options.curvature_smoothing = 10;
options.verb = 0;
[~, ~, ~, ~, ~, GaussianCurvatures, ~] = compute_curvature(vertex,face,options);
GaussianCurvatures = GaussianCurvatures';
end
