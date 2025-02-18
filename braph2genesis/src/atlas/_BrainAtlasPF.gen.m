%% ¡header!
BrainAtlasPF < BrainSurfacePF (pf, panel figure for brain atlas) is a panel to manage the plot of a brain atlas.

%%% ¡description!
A Panel Figure for Brain Atlas (BrainAtlasPF) manages the plot of the brain 
 regions symbols, spheres, ids and labels. 
BrainAtlasPF utilizes the surface created from BrainSurfacePF to integrate 
 the regions to a brain surface.

%%% ¡seealso!
BrainAtlas, BrainSurface

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.VIEW
%%%% ¡title!
3D VIEW

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.BRAIN
%%%% ¡title!
BRAIN ON/OFF

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.SURFFILE
%%%% ¡title!
BRAIN SURFACE

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.ST_SURFACE
%%%% ¡title!
BRAIN COLOR

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.ST_AMBIENT
%%%% ¡title!
MATERIAL & LIGHTNING

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.SPHS
%%%% ¡title!
Brain Region SPHERES ON/OFF

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.SPH_DICT
%%%% ¡title!
Brain Region SPHERES PROPERTIES

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.SYMS
%%%% ¡title!
Brain Region SYMBOLS ON/OFF

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.SYM_DICT
%%%% ¡title!
Brain Region SYMBOLS PROPERTIES

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.IDS
%%%% ¡title!
Brain Region IDs ON/OFF

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.ID_DICT
%%%% ¡title!
Brain Region IDs PROPERTIES

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.LABS
%%%% ¡title!
Brain Region LABELS ON/OFF

%%% ¡prop!
%%%% ¡id!
BrainAtlasPF.LAB_DICT
%%%% ¡title!
Brain Region LABELS PROPERTIES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the panel figure for brain atlas.
%%%% ¡default!
'BrainAtlasPF'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for brain atlas.
%%%% ¡default!
'Panel Figure for Brain Atlas'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for brain atlas.
%%%% ¡default!
'A Panel Figure for Brain Atlas (BrainAtlasPF) manages the plot of the brain regions symbols, spheres, ids and labels. BrainAtlasPF utilizes the surface created from BrainSurfacePF to integrate the regions to a brain surface.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for brain atlas.
%%%% ¡settings!
'BrainAtlasPF'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for brain atlas.
%%%% ¡default!
'BrainAtlasPF ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for brain atlas.
%%%% ¡default!
'BrainAtlasPF label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for brain atlas.
%%%% ¡default!
'BrainAtlasPF notes'

%%% ¡prop!
DRAW (query, logical) draws the panel figure for brain atlas.
%%%% ¡calculate!
value = calculateValue@BrainSurfacePF(pf, BrainSurfacePF.DRAW, varargin{:}); % also warning
if value
    pf.memorize('H_SPHS')
    pf.set('SPHS', pf.get('SPHS')) % sets also   SPH_DICT  

    pf.memorize('H_SYMS')
    pf.set('SYMS', pf.get('SYMS')) % sets also   SYM_DICT  

    pf.memorize('H_IDS')
    pf.set('SPHS', pf.get('SPHS')) % sets also   ID_DICT  

    pf.memorize('H_LABS')
    pf.set('LABS', pf.get('LABS')) % sets also   LAB_DICT  

    % reset the ambient lighting
    pf.get('ST_AMBIENT').get('SETUP')
end
%%%% ¡calculate_callbacks!
function cb_sphs(~, ~, sphs) % (src, event)
    pf.set('SPHS', sphs)
end
function cb_syms(~, ~, syms) % (src, event)
    pf.set('SYMS', syms)
end
function cb_ids(~, ~, ids) % (src, event)
    pf.set('IDS', ids)
end
function cb_labs(~, ~, labs) % (src, event)
    pf.set('LABS', labs)
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel figure for brain atlas is deleted.
%%%% ¡calculate!
value = calculateValue@BrainSurfacePF(pf, BrainSurfacePF.DELETE, varargin{:}); % also warning
if value
    pf.set('H_SPHS', Element.getNoValue())
    pf.set('H_SYMS', Element.getNoValue())
    pf.set('H_IDS', Element.getNoValue())
    pf.set('H_LABS', Element.getNoValue())
end

%%% ¡prop!
H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the panel figure for brain atlas.
%%%% ¡calculate!
toolbar = pf.memorize(PanelFig.H_TOOLBAR);
if check_graphics(toolbar, 'uitoolbar')
	value = calculateValue@BrainSurfacePF(pf, BrainSurfacePF.H_TOOLS);
    
    tool_separator_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');

    % Spheres
    tool_sphs = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Sphs', ...
        'Separator', 'on', ...
        'State', pf.get('SPHS'), ...
        'Tooltip', 'Show Spheres', ...
        'CData', imread('icon_sphere.png'), ...
        'OnCallback', {@cb_sphs, true}, ...
        'OffCallback', {@cb_sphs, false});

    % Symbols
    tool_syms = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Syms', ...
        'Separator', 'on', ...
        'State', pf.get('SYMS'), ...
        'Tooltip', 'Show Symbols', ...
        'CData', imread('icon_symbol.png'), ...
        'OnCallback', {@cb_syms, true}, ...
        'OffCallback', {@cb_syms, false});

    % IDs
    tool_ids = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Ids', ...
        'Separator', 'on', ...
        'State', pf.get('IDS'), ...
        'Tooltip', 'Show IDs', ...
        'CData', imread('icon_id.png'), ...
        'OnCallback', {@cb_ids, true}, ...
        'OffCallback', {@cb_ids, false});

    % Labels
    tool_labs = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Labs', ...
        'Separator', 'on', ...
        'State', pf.get('LABS'), ...
        'Tooltip', 'Show Labels', ...
        'CData', imread('icon_label.png'), ...
        'OnCallback', {@cb_labs, true}, ...
        'OffCallback', {@cb_labs, false});
    
    value = {value{:}, ...
        tool_separator_1, ...
        tool_sphs, tool_syms, tool_ids, tool_labs ...
        };
else
	value = {};
end

%% ¡props!

%%% ¡prop!
BA (metadata, item) is the brain atlas with the brain regions.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
H_SPHS (evanescent, handlelist) is the set of handles for the spheres.
%%%% ¡calculate!
L = pf.memorize('BA').get('BR_DICT').get('LENGTH');
h_sphs = cell(1, L);
for i = 1:1:L
    h_sphs{i} = surf([], [], [], ...
        'Parent', pf.memorize('H_AXES'), ...
        'Tag', ['H_SPHS{' int2str(i) '}'], ...
        'Visible', false ...
        );
end
value = h_sphs;

%%% ¡prop!
SPHS (figure, logical) determines whether the spheres are shown.
%%%% ¡default!
true
%%%% ¡postset!
if ~pf.get('SPHS') % false
    h_sphs = pf.get('H_SPHS');
    for i = 1:1:length(h_sphs)
        set(h_sphs{i}, 'Visible', false)
    end
else % true
    % triggers the update of SPH_DICT
    pf.set('SPH_DICT', pf.get('SPH_DICT'))
end

% update state of toggle tool
toolbar = pf.get('H_TOOLBAR');
if check_graphics(toolbar, 'uitoolbar')
    set(findobj(toolbar, 'Tag', 'TOOL.Sphs'), 'State', pf.get('SPHS'))
end

%%% ¡prop!
SPH_DICT (figure, idict) contains the spheres of the brain regions.
%%%% ¡settings!
'SettingsSphere'
%%%% ¡postset!
if pf.get('SPHS') && ~isa(pf.getr('BA'), 'NoValue')
    
    br_dict = pf.get('BA').get('BR_DICT');
    
    if pf.get('SPH_DICT').get('LENGTH') == 0 && br_dict.get('LENGTH')
        for i = 1:1:br_dict.get('LENGTH')
            br = br_dict.get('IT', i);
            sphs{i} = SettingsSphere( ...
                'PANEL', pf, ...
                'PROP', BrainAtlasPF.H_SPHS, ...
                'I', i, ...
                'VISIBLE', true, ...
                'ID', br.get('ID'), ... % Callback('EL', br, 'TAG', 'ID'), ...
                'X', br.get('X'), ... % Callback('EL', br, 'TAG', 'X'), ...
                'Y', br.get('Y'), ... % Callback('EL', br, 'TAG', 'Y'), ...
                'Z', br.get('Z'), ... % Callback('EL', br, 'TAG', 'Z') ...
                'FACECOLOR', BRAPH2.COL, ...
                'FACEALPHA', 1 ...
                );
        end
        pf.get('SPH_DICT').set('IT_LIST', sphs)
    end
    
    for i = 1:1:br_dict.get('LENGTH')
        pf.get('SPH_DICT').get('IT', i).get('SETUP')
    end
    
    % reset the ambient lighting
    pf.get('ST_AMBIENT').get('SETUP')
end
%%%% ¡gui!
pr = PanelPropIDictTable('EL', pf, 'PROP', BrainAtlasPF.SPH_DICT, ...
    'COLS', [PanelPropIDictTable.SELECTOR SettingsSphere.VISIBLE SettingsSphere.X SettingsSphere.Y SettingsSphere.Z SettingsSphere.SPHERESIZE SettingsSphere.FACECOLOR SettingsSphere.FACEALPHA SettingsSphere.EDGECOLOR SettingsSphere.EDGEALPHA], ...
    varargin{:});

%%% ¡prop!
H_SYMS (evanescent, handlelist) is the set of handles for the symbols.
%%%% ¡calculate!
L = pf.memorize('BA').get('BR_DICT').get('LENGTH');
h_syms = cell(1, L);
for i = 1:1:L
    h_syms{i} = plot3(0, 0, 0, ...
        'Parent', pf.get('H_AXES'), ...
        'Tag', ['H_SYMS{' int2str(i) '}'], ...
        'Visible', false ...
        );
end
value = h_syms;

%%% ¡prop!
SYMS (figure, logical) determines whether the symbols are shown.
%%%% ¡default!
false
%%%% ¡postset!
if ~pf.get('SYMS') % false
    h_syms = pf.get('H_SYMS');
    for i = 1:1:length(h_syms)
        set(h_syms{i}, 'Visible', false)
    end        
else % true
    % triggers the update of SYM_DICT
    pf.set('SYM_DICT', pf.get('SYM_DICT'))
end

% update state of toggle tool
toolbar = pf.get('H_TOOLBAR');
if check_graphics(toolbar, 'uitoolbar')
    set(findobj(toolbar, 'Tag', 'TOOL.Syms'), 'State', pf.get('SYMS'))
end

%%% ¡prop!
SYM_DICT (figure, idict) contains the symbols of the brain regions.
%%%% ¡settings!
'SettingsSymbol'
%%%% ¡postset!
if pf.get('SYMS') && ~isa(pf.getr('BA'), 'NoValue')
    
    br_dict = pf.get('BA').get('BR_DICT');

	if pf.get('SYM_DICT').get('LENGTH') == 0 && br_dict.get('LENGTH')
        for i = 1:1:br_dict.get('LENGTH')
            br = br_dict.get('IT', i);
            syms{i} = SettingsSymbol( ...
                'PANEL', pf, ...
                'PROP', BrainAtlasPF.H_SYMS, ...
                'I', i, ...
                'VISIBLE', true, ...
                'ID', br.get('ID'), ... % Callback('EL', br, 'TAG', 'ID'), ...
                'X', br.get('X'), ... % Callback('EL', br, 'TAG', 'X'), ...
                'Y', br.get('Y'), ... % Callback('EL', br, 'TAG', 'Y'), ...
                'Z', br.get('Z') ... % Callback('EL', br, 'TAG', 'Z') ...
                );
        end
        pf.get('SYM_DICT').set('IT_LIST', syms)
    end
    
    for i = 1:1:br_dict.get('LENGTH')
        pf.get('SYM_DICT').get('IT', i).get('SETUP')
    end
end
%%%% ¡gui!
pr = PanelPropIDictTable('EL', pf, 'PROP', BrainAtlasPF.SYM_DICT, ...
    'COLS', [PanelPropIDictTable.SELECTOR SettingsSymbol.VISIBLE SettingsSymbol.X SettingsSymbol.Y SettingsSymbol.Z SettingsSymbol.SYMBOL SettingsSymbol.SYMBOLSIZE SettingsSymbol.EDGECOLOR SettingsSymbol.FACECOLOR], ...
    varargin{:});

%%% ¡prop!
H_IDS (evanescent, handlelist) is the set of handles for the ids.
%%%% ¡calculate!
L = pf.memorize('BA').get('BR_DICT').get('LENGTH');
h_ids = cell(1, L);
for i = 1:1:L
    h_ids{i} = text(0, 0, 0, '', ...
        'Parent', pf.get('H_AXES'), ...
        'Tag', ['H_IDS{' int2str(i) '}'], ...
        'Visible', false ...
        );
end
value = h_ids;

%%% ¡prop!
IDS (figure, logical) determines whether the ids are shown.
%%%% ¡default!
false
%%%% ¡postset!
if ~pf.get('IDS') % false
    h_ids = pf.get('H_IDS');
    for i = 1:1:length(h_ids)
        set(h_ids{i}, 'Visible', false)
    end        
else % true
    % triggers the update of ID_DICT
    pf.set('ID_DICT', pf.get('ID_DICT'))
end

% update state of toggle tool
toolbar = pf.get('H_TOOLBAR');
if check_graphics(toolbar, 'uitoolbar')
    set(findobj(toolbar, 'Tag', 'TOOL.Ids'), 'State', pf.get('IDS'))
end

%%% ¡prop!
ID_DICT (figure, idict) contains the ids of the brain regions.
%%%% ¡settings!
'SettingsText'
%%%% ¡postset!
if pf.get('IDS') && ~isa(pf.getr('BA'), 'NoValue')

    br_dict = pf.get('BA').get('BR_DICT');

    if pf.get('ID_DICT').get('LENGTH') == 0 && br_dict.get('LENGTH')
        for i = 1:1:br_dict.get('LENGTH')
            br = br_dict.get('IT', i);
            ids{i} = SettingsText( ...
                'PANEL', pf, ...
                'PROP', BrainAtlasPF.H_IDS, ...
                'I', i, ...
                'VISIBLE', true, ...
                'ID', br.get('ID'), ... % Callback('EL', br, 'TAG', 'ID'), ...
                'X', br.get('X'), ... % Callback('EL', br, 'TAG', 'X'), ...
                'Y', br.get('Y'), ... % Callback('EL', br, 'TAG', 'Y'), ...
                'Z', br.get('Z'), ... % Callback('EL', br, 'TAG', 'Z'), ...
                'TXT', br.get('ID') ... % Callback('EL', br, 'TAG', 'ID') ...
                );
        end
        pf.get('ID_DICT').set('IT_LIST', ids)
    end
    
    for i = 1:1:br_dict.get('LENGTH')
        pf.get('ID_DICT').get('IT', i).get('SETUP')
    end
end
%%%% ¡gui!
pr = PanelPropIDictTable('EL', pf, 'PROP', BrainAtlasPF.ID_DICT, ...
    'COLS', [PanelPropIDictTable.SELECTOR SettingsText.VISIBLE SettingsText.X SettingsText.Y SettingsText.Z SettingsText.ROTATION SettingsText.TXT SettingsText.FONTNAME SettingsText.FONTSIZE SettingsText.FONTCOLOR SettingsText.INTERPRETER], ...
    varargin{:});

%%% ¡prop!
H_LABS (evanescent, handlelist) is the set of handles for the labels.
%%%% ¡calculate!
L = pf.memorize('BA').get('BR_DICT').get('LENGTH');
h_labs = cell(1, L);
for i = 1:1:L
    h_labs{i} = text(0, 0, 0, '', ...
        'Parent', pf.get('H_AXES'), ...
        'Tag', ['H_LABS{' int2str(i) '}'], ...
        'Visible', false ...
        );
end
value = h_labs;

%%% ¡prop!
LABS (figure, logical) determines whether the labels are shown.
%%%% ¡default!
false
%%%% ¡postset!
if ~pf.get('LABS') % false
    h_labs = pf.get('H_LABS');
    for i = 1:1:length(h_labs)
        set(h_labs{i}, 'Visible', false)
    end        
else % true
	% triggers the update of LAB_DICT
	pf.set('LAB_DICT', pf.get('LAB_DICT'))
end

% update state of toggle tool
toolbar = pf.get('H_TOOLBAR');
if check_graphics(toolbar, 'uitoolbar')
    set(findobj(toolbar, 'Tag', 'TOOL.Labs'), 'State', pf.get('LABS'))
end

%%% ¡prop!
LAB_DICT (figure, idict) contains the labels of the brain regions.
%%%% ¡settings!
'SettingsText'
%%%% ¡postset!
if pf.get('LABS') && ~isa(pf.getr('BA'), 'NoValue')

    br_dict = pf.get('BA').get('BR_DICT');

    if pf.get('LAB_DICT').get('LENGTH') == 0 && br_dict.get('LENGTH')
        for i = 1:1:br_dict.get('LENGTH')
            br = br_dict.get('IT', i);
            labs{i} = SettingsText( ...
                'PANEL', pf, ...
                'PROP', BrainAtlasPF.H_LABS, ...
                'I', i, ...
                'VISIBLE', true, ...
                'ID', br.get('ID'), ... % Callback('EL', br, 'TAG', 'ID'), ...
                'X', br.get('X'), ... % Callback('EL', br, 'TAG', 'X'), ...
                'Y', br.get('Y'), ... % Callback('EL', br, 'TAG', 'Y'), ...
                'Z', br.get('Z'), ... % Callback('EL', br, 'TAG', 'Z'), ...
                'TXT', br.get('LABEL') ... % Callback('EL', br, 'TAG', 'LABEL') ...
                );
        end
        pf.get('LAB_DICT').set('IT_LIST', labs)
    end
    
    for i = 1:1:br_dict.get('LENGTH')
        pf.get('LAB_DICT').get('IT', i).get('SETUP')
    end
end
%%%% ¡gui!
pr = PanelPropIDictTable('EL', pf, 'PROP', BrainAtlasPF.LAB_DICT, ...
    'COLS', [PanelPropIDictTable.SELECTOR SettingsText.VISIBLE SettingsText.X SettingsText.Y SettingsText.Z SettingsText.ROTATION SettingsText.TXT SettingsText.FONTNAME SettingsText.FONTSIZE SettingsText.FONTCOLOR SettingsText.INTERPRETER], ...
    varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[BrainAtlasPF.PARENT BrainAtlasPF.H BrainAtlasPF.ST_POSITION BrainAtlasPF.ST_AXIS BrainAtlasPF.ST_SURFACE BrainAtlasPF.ST_AMBIENT]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':BrainAtlasPF'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':BrainAtlasPF'])

%%% ¡test!
%%%% ¡name!
Basics 1
%%%% ¡probability!
.01
%%%% ¡code!
br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
br6 = BrainRegion('ID', 'id6', 'LABEL', 'label6', 'NOTES', 'notes6', 'X', 6, 'Y', 6, 'Z', 6);
items = {br1, br2, br3, br4, br5, br6};
idict = IndexedDictionary( ...
    'ID', 'idict', ...
    'IT_CLASS', 'BrainRegion', ...
    'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'IT_LIST', items ...
    );
ba0 = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'NOTES', 'Notes on brain atlas.', 'BR_DICT', idict);
pf0 = BrainAtlasPF(...
    'SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'), ...
    'BA', ba0 ...
    );
gui0 = GUIFig('PF', pf0, 'FILE', 'xxx sss', 'POSITION', [.1 .1 .4 .8], 'WAITBAR', true, 'CLOSEREQ', false);
gui0.get('DRAW')
gui0.get('SHOW')

gui0_settings = gui0.memorize('GUI_SETTINGS');
gui0_settings.set('POSITION', [0 0 .3 .5])
gui0_settings.get('DRAW')
gui0_settings.get('SHOW')

gui0.get('CLOSE')

%%% ¡test!
%%%% ¡name!
Basics 2
%%%% ¡probability!
.01
%%%% ¡code!
ba1 = ImporterBrainAtlasXLS('FILE', [fileparts(which(BRAPH2.LAUNCHER)) filesep() 'atlases' filesep() 'aal90_atlas.xlsx']).get('BA');
pf1 = BrainAtlasPF(...
    'SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'), ...
    'BA', ba1 ...
    );
gui1 = GUIFig('PF', pf1, 'FILE', 'xxx sss', 'POSITION', [.1 .1 .4 .8], 'WAITBAR', false, 'CLOSEREQ', false);
gui1.get('DRAW')
gui1.get('SHOW')

gui1_settings = gui1.memorize('GUI_SETTINGS');
gui1_settings.set('POSITION', [0 0 .3 .5])
gui1_settings.get('DRAW')
gui1_settings.get('SHOW')

gui1.get('CLOSE')