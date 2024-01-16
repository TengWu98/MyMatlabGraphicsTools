function [seg_cpp, seg_refined, len] = refine_seg(model, seg, para, flag, l)
%
%
np = max(seg.face_patchids);
if np > 2
   % �����face��=0��patch����ɾ����id_map��ԭ����patchָ��ӳ�䵽�µ�patchָ��   
   count = zeros(1, np); % ��¼ÿ��patch��Ӧ��face��
   for i = 1:np
       count(i) = length(find(seg.face_patchids == i));
   end
   id_trans = find(count); 
   id_map = -ones(1, np); 
   id_map(id_trans) = 1:length(id_trans); 
   seg.face_patchids = id_map(seg.face_patchids);
   
   % segments �����Ӿ��󣬴洢Ϊϡ����ʽ
   adj_mat = seg.patch_adj_mat;
   [rows, cols, vals] = find(adj_mat);
   idx1 = find(or(id_map(rows)<0,id_map(cols)<0));
   tmp1 = id_map(rows);
   tmp2 = id_map(cols);
   if flag == 1
       len1 = max(tmp1);
       len2 = max(tmp2);
       len = max(len1,len2);
   else
       len = l;
   end
   tmp1(idx1) = 500;
   tmp2(idx1) = 500;
   tmp1 = [tmp1,500];
   tmp2 = [tmp2,500];
   vals = [vals;0];
   vals(idx1) = 0;
   seg.patch_adj_mat = full(sparse(tmp1, tmp2, vals));
   seg.patch_adj_mat = seg.patch_adj_mat(1:len,1:len);
   
   % refine�������򣬼�����ÿ��face��Ӧ��segmentָ��
   seg.face_patchids = refine_partition(model, seg, para);
   
   seg_cpp{1} = seg;
   seg_cpp{1}.type = 8;
   seg_refined = seg;
   seg_refined.face_patchids = id_trans(seg_refined.face_patchids);
   seg_refined.adj_mat = adj_mat;
else
    seg_cpp{1} = seg;
    seg_cpp{1}.type = 8;
    seg_refined = seg;
end

