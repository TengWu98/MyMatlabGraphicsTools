% szy_ScreenedPoissonReconstruction(in_xyz_file_name, out_model_file_name)
% Screened Poisson�ع���Ч��Ҫ�ȴ�ͳ��Poisson�ع��ã����޷���֤���ɵ�ģ��һ�������Ρ����ܻ���Ҫ�޸���
function szy_ScreenedPoissonReconstruction(in_xyz_file_name, out_model_file_name)
dos(['ScreenedPoissonReconstruction.exe --in "', in_xyz_file_name, '" --out "', ...
    out_model_file_name, '"']);
szy_ConvertPlyFromBinToAsc([out_model_file_name, '.ply'], [out_model_file_name, '.ply']);
szy_ConvertModelFormat([out_model_file_name, '.ply'], out_model_file_name);
delete([out_model_file_name, '.ply']);
end