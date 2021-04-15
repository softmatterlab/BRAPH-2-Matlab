%EXAMPLE_Classification
% Script example classification nn

clear variables

%% Load Data: Subjects info ST

% [st_gr, classes] = ImporterDataSTXLS(...
%     'FILE', [fileparts(which('example_classification')) filesep 'example data classification' filesep 'xls' filesep 'mr_adni.xlsx'], ...
%     'CLASSNAMESLABEL', 'DX' ...
%     );

%% Classification 

% c_ST = Classification_ST( ...
%     'GR', 'FILE', [fileparts(which('example_classification')) filesep 'example data classification' filesep 'xls' filesep 'mr_adni.xlsx'], ...
%     'CLASSNAMES', classes);

c_ST = Classification_ST( ...
    'FILE', ...
    [fileparts(which('example_classification')) filesep 'example data nn' filesep 'mr_adni.xlsx'] ...
    );