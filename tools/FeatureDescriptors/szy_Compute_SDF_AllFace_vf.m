% SDF_Face = szy_Compute_SDF_AllFace_vf(vertex, face)
% isPostProcessing��true��false����ʾ�Ƿ���CGAL�Դ��ĺ��ô����ܽ��д���Ĭ��ֵ��true��
function SDF_Face = szy_Compute_SDF_AllFace_vf(vertex, face, isPostProcessing)
tempFileName = ['temp', szy_GUID(), '.off'];
write_mesh(tempFileName, vertex, face);
fileNameOfResult = ['Result', szy_GUID(), '.txt'];

if exist('isPostProcessing', 'var') ~= 1
    isPostProcessing = true;
end

if isPostProcessing 
    isProProcessing_ = '1';
else
    isProProcessing_ = '0';
end

[~,~] = dos(['szy_ComputeSDF.exe "', tempFileName, '" "', ...
    fileNameOfResult, '" ', isProProcessing_]);
SDF_Face = dlmread(fileNameOfResult);
delete(fileNameOfResult, tempFileName);
end
