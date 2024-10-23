%% ¡header!
Group < ConcreteElement (gr, group of subjects) is a group of subjects.

%%% ¡description!
A Group represents a group of subjects whose class is defined in the property SUB_CLASS.
 Group provides the methods necessary to handle groups of subjects. 
 It manages the subjects as an indexed dictionary of subjects SUB_DICT, 
 whose methods can be used to inspect, add or remove subjects.

%%% ¡seealso!
Subject, IndexedDictionary

%%% ¡build!
1

%% ¡gui!

%%% ¡menu_import!
eval([el.get('SUB_CLASS') '.getGUIMenuImport(el, menu_import, pe)']);
im_sub_menus = get(menu_import, 'Children');
delete(im_sub_menus(end)); % delete one sub menu to import JSON

%%% ¡menu_export!
eval([el.get('SUB_CLASS') '.getGUIMenuExport(el, menu_export, pe)']);
ex_sub_menus = get(menu_export, 'Children');
delete(ex_sub_menus(end)); % delete one sub menu to export JSON

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Group.ID
%%%% ¡title!
Group ID

%%% ¡prop!
%%%% ¡id!
Group.LABEL
%%%% ¡title!
Group NAME

%%% ¡prop!
%%%% ¡id!
Group.SUB_CLASS
%%%% ¡title!
Group SUBJECT CLASS

%%% ¡prop!
%%%% ¡id!
Group.SUB_DICT
%%%% ¡title!
Group SUBJECTS

%%% ¡prop!
%%%% ¡id!
Group.NOTES
%%%% ¡title!
Group NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the group of subjects.
%%%% ¡default!
'Group'

%%% ¡prop!
NAME (constant, string) is the name of the group of subjects.
%%%% ¡default!
'Group'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the group of subjects.
%%%% ¡default!
'A Group represents a group of subjects whose class is defined in the property SUB_CLASS. Group provides the methods necessary to handle groups of subjects. It manages the subjects as an indexed dictionary of subjects SUB_DICT, whose methods can be used to inspect, add or remove subjects.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the group of subjects.
%%% ¡settings!
'Group'

%%% ¡prop!
ID (data, string) is a few-letter code for the group of subjects.
%%%% ¡default!
'Group ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the group of subjects.
%%%% ¡default!
'Group label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the group of subjects.
%%%% ¡default!
'Group notes'

%% ¡props!

%%% ¡prop!
SUB_CLASS (parameter, class) is the class of the subjects of the group.
%%%% ¡settings!
'Subject'

%%% ¡prop!
SUB_DICT (data, idict) is an indexed dictionary containing the subjects of the group.
%%%% ¡settings!
'Subject'
%%%% ¡gui!
[order, title] = load_layout(gr.get(Group.SUB_DICT).get(IndexedDictionary.IT_CLASS));
cols(1) = PanelPropIDictTable.SELECTOR;
columnname = {''};
for i = 1:1:length(order)
    if isfinite(order(i))
        cols(order(i) + 1) = i;
        columnname{order(i) + 1} = title{i};
    end
end
pr = PanelPropIDictTable('EL', gr, 'PROP', Group.SUB_DICT, ... 
    'ROWNAME', 'numbered', ...
    'COLS', cols, ...
    'COLUMNNAME', columnname, ...
    'MENU_OPEN_ITEMS', true, ...
    'APPLY_TO_SELECTION', false, ...
    varargin{:});

%%% ¡prop!
VOIS (result, cell) contains the variables of interest, including {kind, categories, values}.
%%%% ¡calculate!
sub_dict = gr.get('SUB_DICT');

if sub_dict.get('LENGTH') ~= 0
    sub = sub_dict.get('IT', 1);
    voi_dict = sub.get('VOI_DICT');
    
    value = cell(voi_dict.get('LENGTH'), 3);
    for v = 1:1:voi_dict.get('LENGTH')
        voi = voi_dict.get('IT', v);
        
        value{v, 1} = voi.getClass();
        
        if isa(voi, 'VOICategoric')
            value{v, 2} = voi.get('CATEGORIES');
        end
        
        value{v, 3} = voi.get('V');
    end
    
    for s = 2:1:sub_dict.get('LENGTH')
        sub = sub_dict.get('IT', s);
        voi_dict = sub.get('VOI_DICT');
        
        for v = 1:1:voi_dict.get('LENGTH')
            voi = voi_dict.get('IT', v);
            
            % % % Add error/warning if voi kind or categories are different from first subject
            
            value{v, 3} = [value{v, 3}; voi.get('V')];
        end
    end
else
    value = {};
end

%%% ¡prop!
COVARIATES (result, matrix) contains the values of the covariates with the categorical ones one-hot encoded.
%%%% ¡calculate!
vois = gr.get('VOIS');

value = zeros(gr.get('SUB_DICT').get('LENGTH'), 0);
for v = 1:1:size(vois, 1)
    if strcmp(vois{v, 1}, 'VOICategoric')
        one_hot_encoding = dummyvar(vois{v, 3});
        value = [value, one_hot_encoding(:, 2:end)];
    else % 'VOINumeric'
        value = [value, vois{v, 3}];
    end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Instantiation
%%%% ¡code!
sub1 = Subject('ID','id1', 'LABEL', 'label1', 'NOTES', 'notes1');
sub2 = Subject('ID','id2', 'LABEL', 'label2', 'NOTES', 'notes2');
sub3 = Subject('ID','id3', 'LABEL', 'label3', 'NOTES', 'notes3');

subject_dict = IndexedDictionary( ...
    'ID', 'subject_idict', ...
    'IT_CLASS', 'Subject', ...
    'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'IT_LIST', {sub1, sub2, sub3} ...
    );

group = Group('ID', 'id', 'LABEL', 'label', 'NOTES', 'notes', 'SUB_DICT', subject_dict);
