%EXAMPLE_ST_BUT
% Script example pipeline ST BUT

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('SubjectST')) filesep 'Example data ST XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectST
im_gr1 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('SubjectST')) filesep 'Example data ST XLS' filesep 'ST_Group_1.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('SubjectST')) filesep 'Example data ST XLS' filesep 'ST_Group_2.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis BUT
thresholds = .4:.2:1;

a_BUT1 = AnalyzeGroup_ST_BUT( ...
    'GR', gr1, ...
    'THRESHOLDS', thresholds ...
    );

a_BUT2 = AnalyzeGroup_ST_BUT( ...
    'TEMPLATE', a_BUT1, ...
    'GR', gr2 ...
    );

% measure calculation
g_BUT1 = a_BUT1.memorize('G'); % essential to memorize in case there are measures with non-default rules
degree_BUT1 = g_BUT1.get('MEASURE', 'Degree').get('M');
degree_av_BUT1 = g_BUT1.get('MEASURE', 'DegreeAv').get('M');
distance_BUT1 = g_BUT1.get('MEASURE', 'Distance').get('M');

g_BUT2 = a_BUT2.get('G');
degree_BUT1 = g_BUT2.get('MEASURE', 'Degree').get('M');
degree_av_BUT1 = g_BUT2.get('MEASURE', 'DegreeAv').get('M');
distance_BUT1 = g_BUT2.get('MEASURE', 'Distance').get('M');

% comparison
c_BUT = CompareGroup( ...
    'P', 10, ...
    'A1', a_BUT1, ...
    'A2', a_BUT2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

degree_BUT_diff = c_BUT.get('COMPARISON', 'Degree').get('DIFF');
degree_BUT_p1 = c_BUT.get('COMPARISON', 'Degree').get('P1');
degree_BUT_p2 = c_BUT.get('COMPARISON', 'Degree').get('P2');
degree_BUT_cil = c_BUT.get('COMPARISON', 'Degree').get('CIL');
degree_BUT_ciu = c_BUT.get('COMPARISON', 'Degree').get('CIU');

degree_av_BUT_diff = c_BUT.get('COMPARISON', 'DegreeAv').get('DIFF');
degree_av_BUT_p1 = c_BUT.get('COMPARISON', 'DegreeAv').get('P1');
degree_av_BUT_p2 = c_BUT.get('COMPARISON', 'DegreeAv').get('P2');
degree_av_BUT_cil = c_BUT.get('COMPARISON', 'DegreeAv').get('CIL');
degree_av_BUT_ciu = c_BUT.get('COMPARISON', 'DegreeAv').get('CIU');

distance_BUT_diff = c_BUT.get('COMPARISON', 'Distance').get('DIFF');
distance_BUT_p1 = c_BUT.get('COMPARISON', 'Distance').get('P1');
distance_BUT_p2 = c_BUT.get('COMPARISON', 'Distance').get('P2');
distance_BUT_cil = c_BUT.get('COMPARISON', 'Distance').get('CIL');
distance_BUT_ciu = c_BUT.get('COMPARISON', 'Distance').get('CIU');