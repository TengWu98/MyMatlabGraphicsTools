function [ret] = smoothsinglemodel(vectex, faces, label_name, neighbour_name, param)
% ������ģ�͵ķָ����߽����smooth,����Ľ��ֱ����ֱ���������Ƭ��
% dir��ģ�������ļ���Ŀ¼
% filename��ģ�ͷָ�������
% param.width��para.half_brush_width�����ڿ��ƿɱ�segmentָ�����Ƭ��Χ
% param.alpha_min�� param.alpha_max��alpha�ķ�Χ����˹ţ�ٷ��еĲ���
% param.iter����˹ţ�ٷ��еõ�������
% param.iter_all������refine_seg�Ĵ���
% param.S��segment֮������ƾ���
%param.sigma_angle 
%param.num_iterations
% ��Ϊ���ڽ���ʹ�����룬����ֱ�ӿ������н��������û�취ȷ��smooth�Ĵ�����
% ֻ�ܷ����޸ģ���������ԭ���Ľ����ֱ������Ϊ���д��һ������smooth_single_face����
% ����ͬ��Ҳֻ�ܴ���ֻsmooth��һ�ε�������Ҫԭ����smooth����Ǹ��ݲ���������

% ��ȡģ��
model = generate_mesh(vectex, faces);

% ��ȡface_segment�ļ�,face_patchids,��ÿ����Ƭ��Ӧ��segmentָ��
fid_fs = fopen(label_name, 'r');
X_temp = textscan(fid_fs, '%d');
fclose(fid_fs);
seg.face_patchids = X_temp{1}+1;

% patch_adj_mat: ��¼segment����������
fid_fs = fopen(neighbour_name, 'r');
X_temp = textscan(fid_fs, '%d %d');
fclose(fid_fs);

num_segments = max([X_temp{1}', X_temp{2}']) + 1;
idx = sub2ind([num_segments num_segments], X_temp{1}+1, X_temp{2}+1);
sc = zeros(num_segments, num_segments);
sc(idx) = 1;
seg.patch_adj_mat = sc' + sc;
% �������ǻ�������������Ϣ
%if nargin == 4
%    seg.patch_adj_mat = seg.patch_adj_mat + S / max(S(:));
%end

% refine_seg
l = 0;
for i = 1:param.iter_all
    [~, seg, len] = refine_seg(model, seg, param, i, l);
    if i == 1
        l = len;
    end
end
seg_refined = seg;

%���
ret = seg_refined.face_patchids;
