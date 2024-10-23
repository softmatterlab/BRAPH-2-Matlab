%EXAMPLE_ST_MP_BUT
% Script example pipeline ST MP BUT

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('SubjectST_MP')) filesep 'Example data ST_MP XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectST_MP
im_gr1 = ImporterGroupSubjectST_MP_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectST_MP')) filesep 'Example data ST_MP XLS' filesep 'ST_MP_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectST_MP_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectST_MP')) filesep 'Example data ST_MP XLS' filesep 'ST_MP_Group_2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis ST MP BUT
thresholds = .7:.1:.9;
a_BUT1 = AnalyzeGroup_ST_MP_BUT( ...
    'GR', gr1, ...
    'THRESHOLDS', thresholds ...
    );

a_BUT2 = AnalyzeGroup_ST_MP_BUT( ...
    'TEMPLATE', a_BUT1, ...
    'GR', gr2 ...
    );

% measure calculation
g_BUT1 = a_BUT1.memorize('G'); % essential to memorize in case there are measures with non-default rules
ovdegree_BUT1 = g_BUT1.get('MEASURE', 'OverlappingDeg').get('M');
ovdegree_av_BUT1 = g_BUT1.get('MEASURE', 'OverlappingDegAv').get('M');
edgeov_BUT1 = g_BUT1.get('MEASURE', 'EdgeOverlap').get('M');

g_BUT2 = a_BUT2.get('G');
ovdegree_BUT2 = g_BUT2.get('MEASURE', 'OverlappingDeg').get('M');
ovdegree_av_BUT2 = g_BUT2.get('MEASURE', 'OverlappingDegAv').get('M');
edgeov_BUT2 = g_BUT2.get('MEASURE', 'EdgeOverlap').get('M');

% comparison
c_BUT = CompareGroup( ...
    'P', 10, ...
    'A1', a_BUT1, ...
    'A2', a_BUT2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

ovdegree_BUT_diff = c_BUT.get('COMPARISON', 'OverlappingDeg').get('DIFF');
ovdegree_BUT_p1 = c_BUT.get('COMPARISON', 'OverlappingDeg').get('P1');
ovdegree_BUT_p2 = c_BUT.get('COMPARISON', 'OverlappingDeg').get('P2');
ovdegree_BUT_cil = c_BUT.get('COMPARISON', 'OverlappingDeg').get('CIL');
ovdegree_BUT_ciu = c_BUT.get('COMPARISON', 'OverlappingDeg').get('CIU');

ovdegree_av_BUT_diff = c_BUT.get('COMPARISON', 'OverlappingDegAv').get('DIFF');
ovdegree_av_BUT_p1 = c_BUT.get('COMPARISON', 'OverlappingDegAv').get('P1');
ovdegree_av_BUT_p2 = c_BUT.get('COMPARISON', 'OverlappingDegAv').get('P2');
ovdegree_av_BUT_cil = c_BUT.get('COMPARISON', 'OverlappingDegAv').get('CIL');
ovdegree_av_BUT_ciu = c_BUT.get('COMPARISON', 'OverlappingDegAv').get('CIU');

edgeov_BUT_diff = c_BUT.get('COMPARISON', 'EdgeOverlap').get('DIFF');
edgeov_BUT_p1 = c_BUT.get('COMPARISON', 'EdgeOverlap').get('P1');
edgeov_BUT_p2 = c_BUT.get('COMPARISON', 'EdgeOverlap').get('P2');
edgeov_BUT_cil = c_BUT.get('COMPARISON', 'EdgeOverlap').get('CIL');
edgeov_BUT_ciu = c_BUT.get('COMPARISON', 'EdgeOverlap').get('CIU');