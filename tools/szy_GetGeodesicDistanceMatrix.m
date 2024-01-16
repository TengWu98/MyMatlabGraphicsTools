% GD = szy_GetGeodesicDistanceMatrix(modelFileName, saveMatFileName)
% ������άģ������������֮��Ĳ�ؾ��룬���saveMatFileName�������ڣ�
% �򻹽����������GD�����ֱ��浽�ļ�saveMatFileName�С�
function GD = szy_GetGeodesicDistanceMatrix(modelFileName, saveMatFileName)
% 		GeoTest.exe eight.obj -l
tempFileName = ['temp', szy_GUID(), '.obj'];
szy_ConvertModelFormat(modelFileName, tempFileName);
command = ['GeoTest.exe "', tempFileName, '" -l'];
dos(command);
% 		alien-1.obj.dist
GD = dlmread([tempFileName, '.dist'], ' ');
delete([tempFileName, '.dist']);
for p=1:size(GD,1)
    for q=1:p
        if GD(q,p) < 1.0e+10
            GD(p,q) = GD(q,p);
        else
            GD(q,p) = GD(p,q);
        end
    end
end
if exist('saveMatFileName', 'var') == 1
    save(saveMatFileName, 'GD');
end
end