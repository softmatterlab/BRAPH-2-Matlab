%% ¡header!
SubjectCON_FUN_MP < Subject (sub, subject with connectivity and functional multiplex data) is a subject with connectivity and functional multiplex data (e.g. DTI and fMRI).

%%% ¡description!
Subject with connectivity and functional data (e.g. obtained from DTI and fMRI).
The first layer contains a connectivity matrix and the second layer contains functional data.

%%% ¡seealso!
CombineGroups_CON_FUN_MP, SeparateGroups_CON_FUN_MP

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
SubjectCON_FUN_MP.ID
%%%% ¡title!
Subject ID

%%% ¡prop!
%%%% ¡id!
SubjectCON_FUN_MP.LABEL
%%%% ¡title!
Subject LABEL

%%% ¡prop!
%%%% ¡id!
SubjectCON_FUN_MP.BA
%%%% ¡title!
Brain Atlas

%%% ¡prop!
%%%% ¡id!
SubjectCON_FUN_MP.VOI_DICT
%%%% ¡title!
Variables of Interest

%%% ¡prop!
%%%% ¡id!
SubjectCON_FUN_MP.CON
%%%% ¡title!
Connectivity DATA

%%% ¡prop!
%%%% ¡id!
SubjectCON_FUN_MP.FUN
%%%% ¡title!
Functional DATA

%%% ¡prop!
%%%% ¡id!
SubjectCON_FUN_MP.NOTES
%%%% ¡title!
Subject NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the subject.
%%%% ¡default!
'SubjectCON_FUN_MP'

%%% ¡prop!
NAME (constant, string) is the name of the subject.
%%%% ¡default!
'Multiplex Connectivity-Functional Subject'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject.
%%%% ¡default!
'Subject with connectivity and functional data (e.g. obtained from DTI and fMRI). The first layer contains a connectivity matrix and the second layer contains functional data.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject.
%%% ¡settings!
'SubjectCON_FUN_MP'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject.
%%%% ¡default!
'SubjectCON_FUN_MP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject.
%%%% ¡default!
'SubjectCON_FUN_MP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject.
%%%% ¡default!
'SubjectCON_FUN_MP notes'

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
CON (data, smatrix) is an adjacency matrix.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').get('LENGTH');
check = isequal(size(value), [br_number, br_number]); % Format.checkFormat(Format.SMATRIX, value) already checked
if check
    msg = 'All ok!';
else   
    msg = ['CON must be a square matrix with the dimensiton equal to the number of brain regions (' int2str(br_number) ').'];
end
%%%% ¡gui!
pr = PanelPropMatrix('EL', sub, 'PROP', SubjectCON.CON, ...
    'ROWNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
    'COLUMNNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
    varargin{:});

%%% ¡prop!
FUN (data, matrix) is an adjacency matrix.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').get('LENGTH');
check = size(value, 2) == br_number; % Format.checkFormat(Format.MATRIX, value) already checked
if check
    msg = 'All ok!';
else   
    msg = ['FUN must be a matrix with the same number of columns as the brain regions (' int2str(br_number) ').'];
end
%%%% ¡gui!
pr = PanelPropMatrix('EL', sub, 'PROP', SubjectFUN.FUN, ...
    'ROWNAME', {'numbered'}, ...
    'COLUMNNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
    varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', 'desikan_atlas.xlsx');
ba = im_ba.get('BA');

gr = Group('SUB_CLASS', 'SubjectCON_FUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP'));
for i = 1:1:50
    sub = SubjectCON_FUN_MP( ...
        'ID', ['SUB CON ' int2str(i)], ...
        'LABEL', ['Subejct CON ' int2str(i)], ...
        'NOTES', ['Notes on subject CON ' int2str(i)], ...
        'BA', ba, ...
        'CON', rand(ba.get('BR_DICT').get('LENGTH')), ...
        'FUN', rand(10, ba.get('BR_DICT').get('LENGTH')) ...
        );
    sub.memorize('VOI_DICT').get('ADD', VOINumeric('ID', 'Age', 'V', 100 * rand()))
    sub.memorize('VOI_DICT').get('ADD', VOICategoric('ID', 'Sex', 'CATEGORIES', {'Female', 'Male'}, 'V', randi(2, 1)))
    gr.get('SUB_DICT').get('ADD', sub)
end

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')

%%% ¡test!
%%%% ¡name!
Create example files XLS
%%%% ¡code!
create_data_CON_FUN_MP_XLS() % only creates files if the example folder doesn't already exist

%%% ¡test!
%%%% ¡name!
Create example files TXT
%%%% ¡code!
create_data_CON_FUN_MP_TXT() % only creates files if the example folder doesn't already exist

%%% ¡test_functions!
function h = WattsStrogatz(N,K,beta)
% H = WattsStrogatz(N,K,beta) returns a Watts-Strogatz model graph with N
% nodes, N*K edges, mean node degree 2*K, and rewiring probability beta.
%
% beta = 0 is a ring lattice, and beta = 1 is a random graph.

% Connect each node to its K next and previous neighbors. This constructs
% indices for a ring lattice.
s = repelem((1:N)',1,K);
t = s + repmat(1:K,N,1);
t = mod(t-1,N)+1;

% Rewire the target node of each edge with probability beta
for source=1:N
    switchEdge = rand(K, 1) < beta;
    
    newTargets = rand(N, 1);
    newTargets(source) = 0;
    newTargets(s(t==source)) = 0;
    newTargets(t(source, ~switchEdge)) = 0;
    
    [~, ind] = sort(newTargets, 'descend');
    t(source, switchEdge) = ind(1:nnz(switchEdge));
end

h = graph(s,t);
end

%%% ¡test!
%%%% ¡name!
GUI XLS
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP XLS' filesep 'atlas.xlsx']);
ba = im_ba.get('BA');

im_gr_CON = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP XLS' filesep 'CON_FUN_MP_Group_1_XLS.CON'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr_CON = im_gr_CON.get('GR');

gui_CON = GUIElement('PE', gr_CON, 'CLOSEREQ', false);
gui_CON.get('DRAW')
gui_CON.get('SHOW')

gui_CON.get('CLOSE')

im_gr_FUN = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP XLS' filesep 'CON_FUN_MP_Group_1_XLS.FUN'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr_FUN = im_gr_FUN.get('GR');

gui_FUN = GUIElement('PE', gr_FUN, 'CLOSEREQ', false);
gui_FUN.get('DRAW')
gui_FUN.get('SHOW')

gui_FUN.get('CLOSE')

%%% ¡test!
%%%% ¡name!
GUI TXT
%%%% ¡probability!
.01
%%%% ¡code!
im_ba = ImporterBrainAtlasTXT('FILE', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP TXT' filesep 'atlas.txt']);
ba = im_ba.get('BA');

im_gr_CON = ImporterGroupSubjectCON_TXT( ...
    'DIRECTORY', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP TXT' filesep 'CON_FUN_MP_Group_1_TXT.CON'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr_CON = im_gr_CON.get('GR');

gui_CON = GUIElement('PE', gr_CON, 'CLOSEREQ', false);
gui_CON.get('DRAW')
gui_CON.get('SHOW')

gui_CON.get('CLOSE')

im_gr_FUN = ImporterGroupSubjectFUN_TXT( ...
    'DIRECTORY', [fileparts(which('SubjectCON_FUN_MP')) filesep 'Example data CON_FUN_MP TXT' filesep 'CON_FUN_MP_Group_1_TXT.FUN'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr_FUN = im_gr_FUN.get('GR');

gui_FUN = GUIElement('PE', gr_FUN, 'CLOSEREQ', false);
gui_FUN.get('DRAW')
gui_FUN.get('SHOW')

gui_FUN.get('CLOSE')