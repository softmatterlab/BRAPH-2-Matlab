%EXAMPLE_ST_BUD
% Script example pipeline ST BUD

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

%% Analysis BUD
densities = 5:10:35;

a_BUD1 = AnalyzeGroup_ST_BUD( ...
    'GR', gr1, ...
    'DENSITIES', densities ...
    );

a_BUD2 = AnalyzeGroup_ST_BUD(...
    'TEMPLATE', a_BUD1, ...
    'GR', gr2 ...
    );

% measure calculation
g_BUD1 = a_BUD1.memorize('G'); % essential to memorize in case there are measures with non-default rules
degree_BUD_1 = g_BUD1.get('MEASURE', 'Degree').get('M');
degree_av_BUD_1 = g_BUD1.get('MEASURE', 'DegreeAv').get('M');
distance_BUD_1 = g_BUD1.get('MEASURE', 'Distance').get('M');

g_BUD2 = a_BUD2.get('G');
degree_BUD_2 = g_BUD2.get('MEASURE', 'Degree').get('M');
degree_av_BUD_2 = g_BUD2.get('MEASURE', 'DegreeAv').get('M');
distance_BUD_2 = g_BUD2.get('MEASURE', 'Distance').get('M');

% comparison
c_BUD = CompareGroup( ...
    'P', 10, ...
    'A1', a_BUD1, ...
    'A2', a_BUD2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

degree_BUD_diff = c_BUD.get('COMPARISON', 'Degree').get('DIFF');
degree_BUD_p1 = c_BUD.get('COMPARISON', 'Degree').get('P1');
degree_BUD_p2 = c_BUD.get('COMPARISON', 'Degree').get('P2');
degree_BUD_cil = c_BUD.get('COMPARISON', 'Degree').get('CIL');
degree_BUD_ciu = c_BUD.get('COMPARISON', 'Degree').get('CIU');

degree_av_BUD_diff = c_BUD.get('COMPARISON', 'DegreeAv').get('DIFF');
degree_av_BUD_p1 = c_BUD.get('COMPARISON', 'DegreeAv').get('P1');
degree_av_BUD_p2 = c_BUD.get('COMPARISON', 'DegreeAv').get('P2');
degree_av_BUD_cil = c_BUD.get('COMPARISON', 'DegreeAv').get('CIL');
degree_av_BUD_ciu = c_BUD.get('COMPARISON', 'DegreeAv').get('CIU');

distance_BUD_diff = c_BUD.get('COMPARISON', 'Distance').get('DIFF');
distance_BUD_p1 = c_BUD.get('COMPARISON', 'Distance').get('P1');
distance_BUD_p2 = c_BUD.get('COMPARISON', 'Distance').get('P2');
distance_BUD_cil = c_BUD.get('COMPARISON', 'Distance').get('CIL');
distance_BUD_ciu = c_BUD.get('COMPARISON', 'Distance').get('CIU');