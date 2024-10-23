function x_pip_update(varargin)
%X_UPDATE internal function - do NOT use.

% Safe environment to evaluate the codes of the pipeline
% varargin consists of cell arrays with triplets:
%  varargin{n} = {moniker, code, codeline}
    
    while ~isempty(varargin)
        eval(varargin{1}{3})
        varargin = varargin(2:end);
    end
end