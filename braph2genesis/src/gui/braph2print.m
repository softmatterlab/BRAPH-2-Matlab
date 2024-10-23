function printed_out = braph2print(h, filename, varargin)
%BRAPH2PRINT saves BRAPH2 figure in a graphics format.
%
% BRAPH2PRINT(H, FILEMANE) saves the graphical object H in the file FILENAME. 
%
% BRAPH2PRINT(H) opens a dialog box to select the file.
%
% BRAPH2PRINT(H, [], 'Name', Value, ...) specifies the Name-Value pairs. 
%  All Name-Value arguments of <a href="matlab:help exportgraphics">exportgraphics</a> can be used.
%
% PRINTED = BRAPH2PRINT(H) returns whether the figure file has been saved.
%
% See also exportgraphics, uiputfile, GUIFig, GUIPanel.

if nargin < 2 || isempty(filename)
    % select file
    filter = {'*.jpg';'*.png';'*.tif';'*.gif';'*.pdf';'*.eps'};
    [file, path, filterindex] = uiputfile(filter, 'Select the figure file.');
    % save file
    if filterindex
        filename = fullfile(path, file);
    else
        filename = '';
    end
end

if ~isempty(filename)
    exportgraphics(h, filename, ...
        'BackgroundColor', 'current', ...
        varargin{:});
    
    saved = true;
else
    saved = false;
end

if nargout
    printed_out = saved;
end

end