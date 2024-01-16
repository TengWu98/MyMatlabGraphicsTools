% HISTCWC  Weighted histogram count given number of bins
% ���������޸�Ϊ����ָ��ͳ�����䣡
%
% This function generates a vector of cumulative weights for data
% histogram. Equal number of bins will be considered using minimum and 
% maximum values of the data. Weights will be summed in the given bin.
%
% Usage: [histw, vinterval] = histwc(vv, ww, nbins)
%
% Arguments:
%       vv    - values as a vector ��������
%       ww    - weights as a vector ��������
%       vinterval - ָ��ͳ���������˵㡣
%
% Returns:
%       histw     - weighted histogram
%       
%
%
% See also: HISTC, HISTWCV

% Author:
% mehmet.suzen physics org
% BSD License
% July 2013

function histw = histcwc(vv, ww, vinterval)
%   minV  = min(vv);
%   maxV  = max(vv);
  nbins = length(vinterval);
%   delta = (maxV-minV)/nbins;
%   vinterval = linspace(minV, maxV, nbins)-delta/2.0;
  histw = zeros(nbins, 1);
  for i=1:length(vv)
    ind = find(vinterval < vv(i), 1, 'last' );
    if ~isempty(ind)
      histw(ind) = histw(ind) + ww(i);
    end
  end
end