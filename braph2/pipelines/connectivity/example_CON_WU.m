%EXAMPLE_CON_WU
% Script example pipeline CON WU

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('SubjectCON')) filesep 'Example data CON XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectCON
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectCON')) filesep 'Example data CON XLS' filesep 'CON_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectCON')) filesep 'Example data CON XLS' filesep 'CON_Group_2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis CON WU
a_WU1 = AnalyzeEnsemble_CON_WU( ...
    'GR', gr1 ...
    );

a_WU2 = AnalyzeEnsemble_CON_WU( ...
    'TEMPLATE', a_WU1, ...
    'GR', gr2 ...
    );

% measure calculation
% % % strength_WU1 = a_WU1.get('MEASUREENSEMBLE', 'Strength').get('M');
% % % strength_av_WU1 = a_WU1.get('MEASUREENSEMBLE', 'StrengthAv').get('M');
degree_WU1 = a_WU1.get('MEASUREENSEMBLE', 'Degree').get('M');
degreeav_WU1 = a_WU1.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
distance_WU1 = a_WU1.get('MEASUREENSEMBLE', 'Distance').get('M');

% % % strength_WU2 = a_WU2.get('MEASUREENSEMBLE', 'Strength').get('M');
% % % strength_av_WU2 = a_WU2.get('MEASUREENSEMBLE', 'StrengthAv').get('M');
degree_WU2 = a_WU2.get('MEASUREENSEMBLE', 'Degree').get('M');
degreeav_WU2 = a_WU2.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
distance_WU2 = a_WU2.get('MEASUREENSEMBLE', 'Distance').get('M');

% comparison
c_WU = CompareEnsemble( ...
    'P', 10, ...
    'A1', a_WU1, ...
    'A2', a_WU2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

% % % strength_WU_diff = c_WU.get('COMPARISON', 'Strength').get('DIFF');
% % % strength_WU_p1 = c_WU.get('COMPARISON', 'Strength').get('P1');
% % % strength_WU_p2 = c_WU.get('COMPARISON', 'Strength').get('P2');
% % % strength_WU_cil = c_WU.get('COMPARISON', 'Strength').get('CIL');
% % % strength_WU_ciu = c_WU.get('COMPARISON', 'Strength').get('CIU');

% % % strength_av_WU_diff = c_WU.get('COMPARISON', 'StrengthAv').get('DIFF');
% % % strength_av_WU_p1 = c_WU.get('COMPARISON', 'StrengthAv').get('P1');
% % % strength_av_WU_p2 = c_WU.get('COMPARISON', 'StrengthAv').get('P2');
% % % strength_av_WU_cil = c_WU.get('COMPARISON', 'StrengthAv').get('CIL');
% % % strength_av_WU_ciu = c_WU.get('COMPARISON', 'StrengthAv').get('CIU');

degree_WU_diff = c_WU.get('COMPARISON', 'Degree').get('DIFF');
degree_WU_p1 = c_WU.get('COMPARISON', 'Degree').get('P1');
degree_WU_p2 = c_WU.get('COMPARISON', 'Degree').get('P2');
degree_WU_cil = c_WU.get('COMPARISON', 'Degree').get('CIL');
degree_WU_ciu = c_WU.get('COMPARISON', 'Degree').get('CIU');

degreeav_WU_diff = c_WU.get('COMPARISON', 'DegreeAv').get('DIFF');
degreeav_WU_p1 = c_WU.get('COMPARISON', 'DegreeAv').get('P1');
degreeav_WU_p2 = c_WU.get('COMPARISON', 'DegreeAv').get('P2');
degreeav_WU_cil = c_WU.get('COMPARISON', 'DegreeAv').get('CIL');
degreeav_WU_ciu = c_WU.get('COMPARISON', 'DegreeAv').get('CIU');

distance_WU_diff = c_WU.get('COMPARISON', 'Distance').get('DIFF');
distance_WU_p1 = c_WU.get('COMPARISON', 'Distance').get('P1');
distance_WU_p2 = c_WU.get('COMPARISON', 'Distance').get('P2');
distance_WU_cil = c_WU.get('COMPARISON', 'Distance').get('CIL');
distance_WU_ciu = c_WU.get('COMPARISON', 'Distance').get('CIU');
