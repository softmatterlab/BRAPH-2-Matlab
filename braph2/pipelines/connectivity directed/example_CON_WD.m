%EXAMPLE_CON_WD
% Script example pipeline CON WD

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('AnalyzeEnsemble_CON_WD')) filesep 'Example data CON D XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectCON
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('AnalyzeEnsemble_CON_WD')) filesep 'Example data CON D XLS' filesep 'COND_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('AnalyzeEnsemble_CON_WD')) filesep 'Example data CON D XLS' filesep 'COND_Group_2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis CON WD
a_WD1 = AnalyzeEnsemble_CON_WD( ...
    'GR', gr1 ...
    );

a_WD2 = AnalyzeEnsemble_CON_WD( ...
    'TEMPLATE', a_WD1, ...
    'GR', gr2 ...
    );

% measure calculation
% % % strength_WD1 = a_WD1.get('MEASUREENSEMBLE', 'Strength').get('M');
% % % strength_av_WD1 = a_WD1.get('MEASUREENSEMBLE', 'StrengthAv').get('M');
degree_WD1 = a_WD1.get('MEASUREENSEMBLE', 'DegreeIn').get('M');
degreeav_WD1 = a_WD1.get('MEASUREENSEMBLE', 'DegreeInAv').get('M');
distance_WD1 = a_WD1.get('MEASUREENSEMBLE', 'Distance').get('M');

% % % strength_WD2 = a_WD2.get('MEASUREENSEMBLE', 'Strength').get('M');
% % % strength_av_WD2 = a_WD2.get('MEASUREENSEMBLE', 'StrengthAv').get('M');
degree_WD2 = a_WD2.get('MEASUREENSEMBLE', 'DegreeIn').get('M');
degreeav_WD2 = a_WD2.get('MEASUREENSEMBLE', 'DegreeInAv').get('M');
distance_WD2 = a_WD2.get('MEASUREENSEMBLE', 'Distance').get('M');

% comparison
c_WD = CompareEnsemble( ...
    'P', 10, ...
    'A1', a_WD1, ...
    'A2', a_WD2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );


degree_WD_diff = c_WD.get('COMPARISON', 'DegreeIn').get('DIFF');
degree_WD_p1 = c_WD.get('COMPARISON', 'DegreeIn').get('P1');
degree_WD_p2 = c_WD.get('COMPARISON', 'DegreeIn').get('P2');
degree_WD_cil = c_WD.get('COMPARISON', 'DegreeIn').get('CIL');
degree_WD_ciu = c_WD.get('COMPARISON', 'DegreeIn').get('CIU');

degreeav_WD_diff = c_WD.get('COMPARISON', 'DegreeInAv').get('DIFF');
degreeav_WD_p1 = c_WD.get('COMPARISON', 'DegreeInAv').get('P1');
degreeav_WD_p2 = c_WD.get('COMPARISON', 'DegreeInAv').get('P2');
degreeav_WD_cil = c_WD.get('COMPARISON', 'DegreeInAv').get('CIL');
degreeav_WD_ciu = c_WD.get('COMPARISON', 'DegreeInAv').get('CIU');

distance_WD_diff = c_WD.get('COMPARISON', 'Distance').get('DIFF');
distance_WD_p1 = c_WD.get('COMPARISON', 'Distance').get('P1');
distance_WD_p2 = c_WD.get('COMPARISON', 'Distance').get('P2');
distance_WD_cil = c_WD.get('COMPARISON', 'Distance').get('CIL');
distance_WD_ciu = c_WD.get('COMPARISON', 'Distance').get('CIU');
