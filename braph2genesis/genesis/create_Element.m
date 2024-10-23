function create_Element(generator_file, target_dir)
%CREATE_ELEMENT creates an element.
%
% CREATE_ELEMENT(FILE, DIR) creates the m-file of an Element from its
%  generator file FILE (with ending '.gen.m') and saves it in the target
%  directory DIR.
%
% A generator file (whose name must end with '.gen.m', and tipically
%  starts with '_') has the following structure (the token ¡header! is
%  required, while the rest is optional):
%
% ----------
%
%<strong>%% ¡header!</strong>
% <class_name> < <superclass_name> (<moniker>, <descriptive_name>) <header_description>.
% <strong>%%% ¡class_attributes!</strong>
%  Class attributes is a single line, e.g. Abstract = true, Sealed = true.
% <strong>%%% ¡description!</strong>
%  This is a plain description of the element.
%  It can occupy several lines.
% <strong>%%% ¡seealso!</strong>
%  Related functions and classes in a single line, coma-separated and without fullstop.
% <strong>%%% ¡build!</strong>
%  Number of the build of the element starting from 1.
%
%<strong>%% ¡layout!</strong>
% <strong>%%% ¡prop!</strong>
%  <strong>%%% ¡id!</strong>
%   Prop id, e.g., Element.TAG, ordered as they should appead.
%  <strong>%%% ¡title!</strong>
%   String containing the title of the prop panel.
% <strong>%%% ¡prop!</strong>
%  ...
%
%<strong>%% ¡gui!</strong>
% <strong>%%% ¡menu_import!</strong>
%  Menu Import for the GUI figure. 
%  The element is el.
%  The menu is menu_import.
%  The plot element is pe.
% <strong>%%% ¡menu_export!</strong>
%  Menu Export for the GUI figure. 
%  The element is el.
%  The menu is menu_export.
%  The plot element is pe.
%
%<strong>%% ¡constants!</strong>
% Constants.
%
%<strong>%% ¡props!</strong>
% <strong>%%% ¡prop!</strong>
%  <tag1> (<category>, <format>) <description>.
%  <strong>%%%% ¡settings!</strong>
%   Prop settings, depending on format.
%  <strong>%%%% ¡default!</strong>
%   Prop default value (seldom needed).
%  <strong>%%%% ¡conditioning!</strong>
%   Code to condition value (before checks and calculation).
%   Can be on multiple lines.
%   The prop value is in the variable 'value', 
%   where also the conditioned prop value is returned.
%  <strong>%%%% ¡preset!</strong>
%   Code to preset element (before checks and calculation).
%   Can be on multiple lines.
%   The prop value is in the variable 'value', 
%   where also the preset prop value is returned.
%  <strong>%%%% ¡check_prop!</strong>
%   Code to check prop format (before calculation).
%   Can be on multiple lines.
%   The prop value is in the variable 'value'.
%   The outcome should be in variable 'check'.
%  <strong>%%%% ¡postset!</strong>
%   Postset code (executed after setting, but before checking, value),
%   executed on ONLY the set property.
%   Can be on multiple lines.
%   Does not return anything.
%  <strong>%%%% ¡postprocessing!</strong>
%   Postprocessing code (executed after setting, but before checking,
%   value), executed on ALL unlocked props after each set operation.
%   Can be on multiple lines.
%   Does not return anything.
%  <strong>%%%% ¡check_value!</strong>
%   Code to check prop value (after calculation).
%   Can be on multiple lines.
%   The prop value is in the variable 'value'.
%   The outcome should be in variable 'check' and the message in 'msg'.
%  <strong>%%%% ¡calculate!</strong>
%   Code to calculate prop results 
%   (only for categories RESULT, QUERY and EVANESCENT).
%   Can be on multiple lines.
%   Can include callbacks as {@cb_get, 'TAG', varargin} and 
%   {@cb_set, 'TAG1', value1, ...}.
%   The result should be in variable 'value'.
%  <strong>%%%% ¡calculate_callbacks!</strong>
%   Callbacks to be used in calculate, typically as functions 
%   cb_name(src, event).
%   Can be on multiple lines.
%  <strong>%%%% ¡gui!</strong>
%   GUI code for representing the panel of the prop.
%   Can be on multiple lines.
%   Should return a PanelProp object in 'pr'.
% <strong>%%% ¡prop!</strong>
%   <tag2> ...
% 
%<strong>%% ¡props_update!</strong>
% <strong>%%% ¡prop!</strong>
%  <tag1> (<category>, <format>) <description>. [Only description can be different from original prop]
%  <strong>%%%% ¡settings!</strong>
%   Updated settings.
%  <strong>%%%% ¡default!</strong>
%   Updated default.
%  <strong>%%%% ¡conditioning!</strong>
%   Update value conditioning (before checks and calculation).
%  <strong>%%%% ¡preset!</strong>
%   Update element value preset (before checks and calculation).
%  <strong>%%%% ¡check_prop!</strong>
%   Updated check prop format (before calculation).
%  <strong>%%%% ¡postset!</strong>
%   Update postset (after setting, but before checking, value).
%  <strong>%%%% ¡postprocessing!</strong>
%   Update value postprocessing (after setting, but before checking, value).
%  <strong>%%%% ¡check_value!</strong>
%   Updated check prop value (after calculation).
%  <strong>%%%% ¡calculate!</strong>
%   Updated calculation.
%  <strong>%%%% ¡calculate_callbacks!</strong>
%   Updated calculate callbacks.
%  <strong>%%%% ¡gui!</strong>
%   Updated GUI.
% <strong>%%% ¡prop!</strong>
%  <tag2> ...
% 
%<strong>%% ¡tests!</strong>
% <strong>%%% ¡excluded_props!</strong>
%  Row vector with list of props to be excluded from standard tests.
% <strong>%%% ¡warning_off!</strong>
%  Switches off the warnings regarding the element.
% <strong>%%% ¡test!</strong>
%  <strong>%%%% ¡name!</strong>
%  Name of the text on a single line.
%  <strong>%%%% ¡probability!</strong>
%  Probability with which this test is performed. By default it is 1.
%  <strong>%%%% ¡code!</strong>
%  Code of the test.
%  Can be on multiple lines.
% <strong>%%% ¡test!</strong>
%  ...
% <strong>%%% ¡test_functions!</strong>
% Functions used in the test.
% Can be on multiple lines.
% 
% ----------
% 
% See also genesis, create_Layout, create_test_Element, hard_code_constants.

txt = fileread(generator_file);

disp(['¡ source file: ' generator_file])
disp(['¡ target dir: ' target_dir])
disp('¡! generator file read')

%% Analysis
[class_name, superclass_name, moniker, descriptive_name, header_description, ...
    class_attributes, description, seealso, build] = analyze_header();
    function [class_name, superclass_name, moniker, descriptive_name, header_description, ...
            class_attributes, description, seealso, build] = analyze_header()
        header = getToken(txt, 'header');
        res = regexp(header, ...
            ['^\s*(?<class_name>\w*)\s*<\s*(?<superclass_name>\w*)' ...
            '\s*\(\s*(?<moniker>\w*)\s*,\s*(?<descriptive_name>[^)]*)\)' ...
            '\s*(?<header_description>[^.]*)\.'], ...
            'names' ...
            );
        class_name = res.class_name;
        superclass_name = res.superclass_name;
        moniker = res.moniker;
        descriptive_name = res.descriptive_name;
        header_description = res.header_description;
        
        class_attributes = getToken(txt, 'header', 'class_attributes');
        
        description = splitlines(getToken(txt, 'header', 'description'));
        
        seealso = getToken(txt, 'header', 'seealso');

        build = getToken(txt, 'header', 'build');
    end

element_created = exist(class_name, 'class') == 8;

[gui_menu_import, gui_menu_export] = analyze_gui();
    function [gui_menu_import, gui_menu_export] = analyze_gui()
        gui_menu_import = splitlines(getToken(txt, 'gui', 'menu_import'));
        gui_menu_export = splitlines(getToken(txt, 'gui', 'menu_export'));
    end

constants = splitlines(getToken(txt, 'constants'));

[props, props_update] = analyze_props();
    function [props, props_update] = analyze_props()
        props = getTokens(txt, 'props', 'prop');
        for i = 1:1:numel(props)
            res = regexp(props{i}.token, ...
                '^(\s*)(?<tag>\w*)\s*\((?<category>\w*),\s*(?<format>\w*)\)\.*', ...
                'names' ...
                );
            props{i}.TAG = upper(res.tag);
            props{i}.CATEGORY = upper(res.category);
            props{i}.FORMAT = upper(res.format);
            
            lines = splitlines(props{i}.token);
            props{i}.description = lines{1};
            
            props{i}.settings = getToken(props{i}.token, 'settings');
            props{i}.default = getToken(props{i}.token, 'default');
            props{i}.conditioning = splitlines(getToken(props{i}.token, 'conditioning'));
            props{i}.preset= splitlines(getToken(props{i}.token, 'preset'));
            props{i}.check_prop = splitlines(getToken(props{i}.token, 'check_prop'));
            props{i}.postset = splitlines(getToken(props{i}.token, 'postset'));
            props{i}.postprocessing = splitlines(getToken(props{i}.token, 'postprocessing'));
            props{i}.calculate = splitlines(getToken(props{i}.token, 'calculate'));
            props{i}.calculate_callbacks = splitlines(getToken(props{i}.token, 'calculate_callbacks'));
            props{i}.check_value = splitlines(getToken(props{i}.token, 'check_value'));
            props{i}.gui = splitlines(getToken(props{i}.token, 'gui'));
            
            % sanity checks
            if element_created
                % default not checked because can be used for all categories
                
                % conditioning
                if any(Element.getPropCategory(class_name, props{i}.TAG) == [Category.CONSTANT Category.RESULT Category.QUERY Category.EVANESCENT]) ...
                        && ~isequal(props{i}.conditioning, {''})
                    warning( ...
                        [BRAPH2.STR ':create_Element'], ...
                        [BRAPH2.STR ':create_Element\n' ...
                        '¡conditioning! should not be used with props of category ' props{i}.CATEGORY '.\n' ...
                        'This code might give rise to unpredictable behavior.\n' ...
                        'Element: ' class_name '. Prop: ' props{i}.TAG '.' ...
                        ] ...
                        )
                end
                
                % preset
                if any(Element.getPropCategory(class_name, props{i}.TAG) == [Category.CONSTANT Category.RESULT Category.QUERY Category.EVANESCENT]) ...
                        && ~isequal(props{i}.preset, {''})
                    warning( ...
                        [BRAPH2.STR ':create_Element'], ...
                        [BRAPH2.STR ':create_Element\n' ...
                        '¡preset! should not be used with props of category ' props{i}.CATEGORY '.\n' ...
                        'This code might give rise to unpredictable behavior.\n' ...
                        'Element: ' class_name '. Prop: ' props{i}.TAG '.' ...
                        ] ...
                        )
                end
                
                % check_prop
                if any(Element.getPropCategory(class_name, props{i}.TAG) == [Category.CONSTANT, Category.RESULT, Category.QUERY, Category.EVANESCENT]) ...
                        && ~isequal(props{i}.check_prop, {''})
                    warning( ...
                        [BRAPH2.STR ':create_Element'], ...
                        [BRAPH2.STR ':create_Element\n' ...
                        '¡check_prop! should not be used with props of category ' props{i}.CATEGORY '.\n' ...
                        'This code might give rise to unpredictable behavior.\n' ...
                        'Element: ' class_name '. Prop: ' props{i}.TAG '.' ...
                        ] ...
                        )
                end
                
                % postset
                if any(Element.getPropCategory(class_name, props{i}.TAG) == [Category.CONSTANT, Category.RESULT, Category.QUERY, Category.EVANESCENT]) ...
                        && ~isequal(props{i}.postset, {''})
                    warning( ...
                        [BRAPH2.STR ':create_Element'], ...
                        [BRAPH2.STR ':create_Element\n' ...
                        '¡postset! should not be used with props of category ' props{i}.CATEGORY '.\n' ...
                        'This code might give rise to unpredictable behavior.\n' ...
                        'Element: ' class_name '. Prop: ' props{i}.TAG '.' ...
                        ] ...
                        )
                end
                
                % postprocessing not checked because can be used for all categories
                
                % calculate
                if any(Element.getPropCategory(class_name, props{i}.TAG) == [Category.CONSTANT Category.METADATA Category.PARAMETER Category.DATA Category.FIGURE Category.GUI]) ...
                        && ~isequal(props{i}.calculate, {''})
                    warning( ...
                        [BRAPH2.STR ':create_Element'], ...
                        [BRAPH2.STR ':create_Element\n' ...
                        '¡calculate! should not be used with props of category ' props{i}.CATEGORY '.\n' ...
                        'This code might give rise to unpredictable behavior.\n' ...
                        'Element: ' class_name '. Prop: ' props{i}.TAG '.' ...
                        ] ...
                        )
                end
                
                % check_value
                if any(Element.getPropCategory(class_name, props{i}.TAG) == [Category.CONSTANT]) ...
                        && ~isequal(props{i}.check_value, {''})
                    warning( ...
                        [BRAPH2.STR ':create_Element'], ...
                        [BRAPH2.STR ':create_Element\n' ...
                        '¡check_value! should not be used with props of category ' props{i}.CATEGORY '.\n' ...
                        'This code might give rise to unpredictable behavior.\n' ...
                        'Element: ' class_name '. Prop: ' props{i}.TAG '.' ...
                        ] ...
                        )
                end
            end
        end
        props_update = getTokens(txt, 'props_update', 'prop');
        for i = 1:1:numel(props_update)
            res = regexp(props_update{i}.token, ...
                '^(\s*)(?<tag>\w*)\s*\((?<category>\w*),\s*(?<format>\w*)\)\.*', ...
                'names' ...
                );
            props_update{i}.TAG = upper(res.tag);
            props_update{i}.CATEGORY = upper(res.category);
            props_update{i}.FORMAT = upper(res.format);
            
            lines = splitlines(props_update{i}.token);
            props_update{i}.description = lines{1};
            
            props_update{i}.settings = getToken(props_update{i}.token, 'settings');
            props_update{i}.default = getToken(props_update{i}.token, 'default');
            props_update{i}.conditioning = splitlines(getToken(props_update{i}.token, 'conditioning'));
            props_update{i}.preset = splitlines(getToken(props_update{i}.token, 'preset'));
            props_update{i}.check_prop = splitlines(getToken(props_update{i}.token, 'check_prop'));
            props_update{i}.postset = splitlines(getToken(props_update{i}.token, 'postset'));
            props_update{i}.postprocessing = splitlines(getToken(props_update{i}.token, 'postprocessing'));
            props_update{i}.calculate = splitlines(getToken(props_update{i}.token, 'calculate'));
            props_update{i}.calculate_callbacks = splitlines(getToken(props_update{i}.token, 'calculate_callbacks'));
            props_update{i}.check_value = splitlines(getToken(props_update{i}.token, 'check_value'));
            props_update{i}.gui = splitlines(getToken(props_update{i}.token, 'gui'));
            
            % sanity checks
            if element_created
                % default not checked because can be used for all categories
                
                % conditioning
                if any(Element.getPropCategory(class_name, props_update{i}.TAG) == [Category.CONSTANT Category.RESULT Category.QUERY Category.EVANESCENT]) ...
                        && ~isequal(props_update{i}.conditioning, {''})
                    warning( ...
                        [BRAPH2.STR ':create_Element'], ...
                        [BRAPH2.STR ':create_Element\n' ...
                        '¡conditioning! should not be used with props of category ' props_update{i}.CATEGORY '.\n' ...
                        'This code might give rise to unpredictable behavior.\n' ...
                        'Element: ' class_name '. Prop update: ' props_update{i}.TAG '.' ...
                        ] ...
                        )
                end
                
                % preset
                if any(Element.getPropCategory(class_name, props_update{i}.TAG) == [Category.CONSTANT, Category.RESULT, Category.QUERY, Category.EVANESCENT]) ...
                        && ~isequal(props_update{i}.preset, {''})
                    warning( ...
                        [BRAPH2.STR ':create_Element'], ...
                        [BRAPH2.STR ':create_Element\n' ...
                        '¡preset! should not be used with props of category ' props_update{i}.CATEGORY '.\n' ...
                        'This code might give rise to unpredictable behavior.\n' ...
                        'Element: ' class_name '. Prop update: ' props_update{i}.TAG '.' ...
                        ] ...
                        )
                end
                
                % check_prop
                if any(Element.getPropCategory(class_name, props_update{i}.TAG) == [Category.CONSTANT Category.RESULT Category.QUERY Category.EVANESCENT]) ...
                        && ~isequal(props_update{i}.check_prop, {''})
                    warning( ...
                        [BRAPH2.STR ':create_Element'], ...
                        [BRAPH2.STR ':create_Element\n' ...
                        '¡check_prop! should not be used with props of category ' props_update{i}.CATEGORY '.\n' ...
                        'This code might give rise to unpredictable behavior.\n' ...
                        'Element: ' class_name '. Prop update: ' props_update{i}.TAG '.' ...
                        ] ...
                        )
                end
                
                % postset
                if any(Element.getPropCategory(class_name, props_update{i}.TAG) == [Category.CONSTANT Category.RESULT Category.QUERY Category.EVANESCENT]) ...
                        && ~isequal(props_update{i}.postset, {''})
                    warning( ...
                        [BRAPH2.STR ':create_Element'], ...
                        [BRAPH2.STR ':create_Element\n' ...
                        '¡postset! should not be used with props of category ' props_update{i}.CATEGORY '.\n' ...
                        'This code might give rise to unpredictable behavior.\n' ...
                        'Element: ' class_name '. Prop update: ' props_update{i}.TAG '.' ...
                        ] ...
                        )
                end
                
                % postprocessing not checked because can be used for all categories
                
                % calculate
                if any(Element.getPropCategory(class_name, props_update{i}.TAG) == [Category.CONSTANT Category.METADATA Category.PARAMETER Category.DATA Category.FIGURE Category.GUI]) ...
                        && ~isequal(props_update{i}.calculate, {''})
                    warning( ...
                        [BRAPH2.STR ':create_Element'], ...
                        [BRAPH2.STR ':create_Element\n' ...
                        '¡calculate! should not be used with props of category ' props_update{i}.CATEGORY '.\n' ...
                        'This code might give rise to unpredictable behavior.\n' ...
                        'Element: ' class_name '. Prop update: ' props_update{i}.TAG '.' ...
                        ] ...
                        )
                end
                
                % check_value
                if any(Element.getPropCategory(class_name, props_update{i}.TAG) == [Category.CONSTANT]) ...
                        && ~isequal(props_update{i}.check_value, {''})
                    warning( ...
                        [BRAPH2.STR ':create_Element'], ...
                        [BRAPH2.STR ':create_Element\n' ...
                        '¡check_value! should not be used with props of category ' props_update{i}.CATEGORY '.\n' ...
                        'This code might give rise to unpredictable behavior.\n' ...
                        'Element: ' class_name '. Prop update: ' props_update{i}.TAG '.' ...
                        ] ...
                        )
                end
            end
        end
    end

CET = '%CET: Computational Efficiency Trick';

%% Generate file
file_str = [];

generate_header()
    function generate_header()
        if isempty(class_attributes)
            g(0, ['classdef ' class_name ' < ' superclass_name])
        else
            g(0, ['classdef (' class_attributes ') ' class_name ' < ' superclass_name])
        end
            gs(1, {
                ['%' class_name ' ' header_description '.']
                ['% It is a subclass of <a href="matlab:help ' superclass_name '">' superclass_name '</a>.']
                 '%'
                })
            gs(1, cellfun(@(x) ['% ' x], description, 'UniformOutput', false))
                if element_created 
                    if Element.getPropNumber(class_name)
                        gs(1, {
                             '%'
                            ['% The list of ' class_name ' properties is:']
                            })
                            for prop = Element.getProps(class_name)
                                g(1, ['%  <strong>' int2str(prop) '</strong> <strong>' Element.getPropTag(class_name, prop) '</strong> \t' Element.getPropDescription(class_name, prop)])
                            end
                    else
                        gs(1, {
                             '%'
                            ['% ' class_name ' has no properties.']
                            })
                    end
                end
            gs(1, {
                 '%'
                ['% ' class_name ' methods (constructor):']
                ['%  ' class_name ' - constructor']
                 '%'
                ['% ' class_name ' methods:']
                 '%  set - sets values of a property'
                 '%  check - checks the values of all properties'
                 '%  getr - returns the raw value of a property'
                 '%  get - returns the value of a property'
                 '%  memorize - returns the value of a property and memorizes it'
                 '%             (for RESULT, QUERY, and EVANESCENT properties)'
                 '%  getPropSeed - returns the seed of a property'
                 '%  isLocked - returns whether a property is locked'
                 '%  lock - locks unreversibly a property'
                 '%  isChecked - returns whether a property is checked'
                 '%  checked - sets a property to checked'
                 '%  unchecked - sets a property to NOT checked'
                 '%'
                ['% ' class_name ' methods (display):']
                ['%  tostring - string with information about the ' descriptive_name]
                ['%  disp - displays information about the ' descriptive_name]
                ['%  tree - displays the tree of the ' descriptive_name]
                 '%'
                ['% ' class_name ' methods (miscellanea):']
                 '%  getNoValue - returns a pointer to a persistent instance of NoValue'
                 '%               Use it as Element.getNoValue()'
                 '%  getCallback - returns the callback to a property'
                ['%  isequal - determines whether two ' descriptive_name ' are equal (values, locked)']
                 '%  getElementList - returns a list with all subelements'
                ['%  copy - copies the ' descriptive_name]
                 '%'
                ['% ' class_name ' methods (save/load, Static):']
                ['%  save - saves BRAPH2 ' descriptive_name ' as b2 file']
                ['%  load - loads a BRAPH2 ' descriptive_name ' from a b2 file']
                 '%'
                ['% ' class_name ' method (JSON encode):']
                ['%  encodeJSON - returns a JSON string encoding the ' descriptive_name]
                 '%'
                ['% ' class_name ' method (JSON decode, Static):']
                ['%   decodeJSON - returns a JSON string encoding the ' descriptive_name]
                 '%'
                ['% ' class_name ' methods (inspection, Static):']
                ['%  getClass - returns the class of the ' descriptive_name]
                ['%  getSubclasses - returns all subclasses of ' class_name]
                ['%  getProps - returns the property list of the ' descriptive_name]
                ['%  getPropNumber - returns the property number of the ' descriptive_name]
                 '%  existsProp - checks whether property exists/error'
                 '%  existsTag - checks whether tag exists/error'
                 '%  getPropProp - returns the property number of a property'
                 '%  getPropTag - returns the tag of a property'
                 '%  getPropCategory - returns the category of a property'
                 '%  getPropFormat - returns the format of a property'
                 '%  getPropDescription - returns the description of a property'
                 '%  getPropSettings - returns the settings of a property'
                 '%  getPropDefault - returns the default value of a property'
                 '%  getPropDefaultConditioned - returns the conditioned default value of a property'
                 '%  checkProp - checks whether a value has the correct format/error'
                 '%'
                ['% ' class_name ' methods (GUI):']
                 '%  getPanelProp - returns a prop panel'
                 '%'
                ['% ' class_name ' methods (GUI, Static):']
                 '%  getGUIMenuImport - returns the importer menu'
                 '%  getGUIMenuExport - returns the exporter menu'
                 '%'
                ['% ' class_name ' methods (category, Static):']
                 '%  getCategories - returns the list of categories'
                 '%  getCategoryNumber - returns the number of categories'
                 '%  existsCategory - returns whether a category exists/error'
                 '%  getCategoryTag - returns the tag of a category'
                 '%  getCategoryName - returns the name of a category'
                 '%  getCategoryDescription - returns the description of a category'
                 '%'
                ['% ' class_name ' methods (format, Static):']
                 '%  getFormats - returns the list of formats'
                 '%  getFormatNumber - returns the number of formats'
                 '%  existsFormat - returns whether a format exists/error'
                 '%  getFormatTag - returns the tag of a format'
                 '%  getFormatName - returns the name of a format'
                 '%  getFormatDescription - returns the description of a format'
                 '%  getFormatSettings - returns the settings for a format'
                 '%  getFormatDefault - returns the default value for a format'
                 '%  checkFormat - returns whether a value format is correct/error'
                 '%'
                })
            gs(1, {
                ['% To print full list of constants, click here <a href="matlab:metaclass = ?' class_name '; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">' class_name ' constants</a>.']
                 '%'
                })
                % % The code below is not in use, but it permits to add the list of constants to the documentation of the element.
                % if element_created
                %     gs(1, {
                %          '%'
                %         ['% ' class_name ' properties (Constant).']
                %         })
                %     metaclass = eval(['?' class_name]);
                %     property_list = metaclass.PropertyList;
                %     for i = 1:1:length(property_list)
                %         property = property_list(i);
                %         if property.Constant
                %             g(1, ['%  ' property.Name ' - ' tostring(property.DefaultValue)])
                %         end
                %     end
                % end
            if ~isempty(seealso)
                gs(1, {
                     '%'
                    ['% See also ' seealso '.']
                     '%'
                    ['% BUILD BRAPH2 BRAPH2.BUILD class_name ' build]
                    })
            end
            g(1, '')
    end

generate_constants()
    function generate_constants()
        if numel(constants) == 1 && isempty(constants{1})
            return
        end
        g(1, 'properties (Constant) % constants')
            gs(2, constants)
        g(1, 'end')
    end

generate_props()
    function generate_props()
        if isempty(props)
            return
        end
        g(1, 'properties (Constant) % properties')
        
        for i = 1:1:numel(props)
            if ~element_created %CET
                g(2, [props{i}.TAG ' = ' superclass_name '.getPropNumber() + ' int2str(i) ';'])
            else
                g(2, [props{i}.TAG ' = ' int2str(Element.getPropProp(class_name, props{i}.TAG)) '; ' CET])
            end
            gs(2, {
                [props{i}.TAG '_TAG = ''' props{i}.TAG ''';']
                [props{i}.TAG '_CATEGORY = Category.' props{i}.CATEGORY ';']
                [props{i}.TAG '_FORMAT = Format.' props{i}.FORMAT ';']
                })
            if i ~= numel(props)
                g(2, '')
            end
        end
        
        g(1, 'end');
    end

generate_constructor()
    function generate_constructor()
        g(1, 'methods % constructor')
            g(2, ['function ' moniker ' = ' class_name '(varargin)'])
                gs(3, {
                    ['%' class_name '() creates a ' descriptive_name '.']
                     '%'
                    ['% ' class_name '(PROP, VALUE, ...) with property PROP initialized to VALUE.']
                     '%'
                    ['% ' class_name '(TAG, VALUE, ...) with property TAG set to VALUE.']
                     '%'
                     '% Multiple properties can be initialized at once identifying'
                     '%  them with either property numbers (PROP) or tags (TAG).'
                     '%'
                    })
                    if element_created
                        if Element.getPropNumber(class_name)
                            g(3, ['% The list of ' class_name ' properties is:'])
                            for prop = Element.getProps(class_name)
                                g(3, ['%  <strong>' int2str(prop) '</strong> <strong>' Element.getPropTag(class_name, prop) '</strong> \t' Element.getPropDescription(class_name, prop)])
                            end
                        else
                            g(3, ['% ' class_name ' has no properties.'])
                        end
                    end
                gs(3, {
                    '%'
                    '% See also Category, Format.'
                    ''
                    })
                g(3, [moniker ' = ' moniker '@' superclass_name '(varargin{:});'])
            g(2, 'end')
        g(1, 'end')
    end

generate_inspection()
    function generate_inspection()
        g(1, 'methods (Static) % inspection')
        
        % getBuild()
        g(2, 'function build = getBuild()')
            gs(3, {
                ['%GETBUILD returns the build of the ' descriptive_name '.']
                 '%'
                ['% BUILD = ' class_name '.GETBUILD() returns the build of ''' class_name '''.']
                 '%'
                 '% Alternative forms to call this method are:'
                ['%  BUILD = ' upper(moniker) '.GETBUILD() returns the build of the ' descriptive_name ' ' upper(moniker) '.']
                ['%  BUILD = Element.GETBUILD(' upper(moniker) ') returns the build of ''' upper(moniker) '''.']
                ['%  BUILD = Element.GETBUILD(''' class_name ''') returns the build of ''' class_name '''.']
                 '%'
                ['% Note that the Element.GETBUILD(' upper(moniker) ') and Element.GETBUILD(''' class_name ''')']
                 '%  are less computationally efficient.'
                 ''
                 ['build = ' build ';']
                })
        g(2, 'end')

        % getClass()
        g(2, ['function ' moniker '_class = getClass()'])
            gs(3, {
                ['%GETCLASS returns the class of the ' descriptive_name '.']
                 '%'
                ['% CLASS = ' class_name '.GETCLASS() returns the class ''' class_name '''.']
                 '%'
                 '% Alternative forms to call this method are:'
                ['%  CLASS = ' upper(moniker) '.GETCLASS() returns the class of the ' descriptive_name ' ' upper(moniker) '.']
                ['%  CLASS = Element.GETCLASS(' upper(moniker) ') returns the class of ''' upper(moniker) '''.']
                ['%  CLASS = Element.GETCLASS(''' class_name ''') returns ''' class_name '''.']
                 '%'
                ['% Note that the Element.GETCLASS(' upper(moniker) ') and Element.GETCLASS(''' class_name ''')']
                 '%  are less computationally efficient.'
                 ''
                })
            g(3, [moniker '_class = ''' class_name ''';'])
        g(2, 'end')
        
        % getSubclasses()
        g(2, 'function subclass_list = getSubclasses()')
            gs(3, {
                ['%GETSUBCLASSES returns all subclasses of the ' descriptive_name '.']
                 '%'
                ['% LIST = ' class_name '.GETSUBCLASSES() returns all subclasses of ''' class_name '''.']
                 '%'
                 '% Alternative forms to call this method are:'
                ['%  LIST = ' upper(moniker) '.GETSUBCLASSES() returns all subclasses of the ' descriptive_name ' ' upper(moniker) '.']
                ['%  LIST = Element.GETSUBCLASSES(' upper(moniker) ') returns all subclasses of ''' upper(moniker) '''.']
                ['%  LIST = Element.GETSUBCLASSES(''' class_name ''') returns all subclasses of ''' class_name '''.']
                 '%'
                ['% Note that the Element.GETSUBCLASSES(' upper(moniker) ') and Element.GETSUBCLASSES(''' class_name ''')']
                 '%  are less computationally efficient.'
                 '%'
                 '% See also subclasses.'
                 ''
                })
                if ~element_created %CET
                    g(3, ['subclass_list = subclasses(''' class_name ''', [], [], true);'])
                else
                    subclass_list = Element.getSubclasses(class_name);
                    g(3, ['subclass_list = {' sprintf(' ''%s'' ', subclass_list{:}) '}; ' CET])
                end
        g(2, 'end')
        
        % getProps([category])
        g(2, 'function prop_list = getProps(category)')
            gs(3, {
                ['%GETPROPS returns the property list of ' descriptive_name '.']
                 '%'
                ['% PROPS = ' class_name '.GETPROPS() returns the property list of ' descriptive_name]
                 '%  as a row vector.'
                 '%'
                ['% PROPS = ' class_name '.GETPROPS(CATEGORY) returns the property list ']
                 '%  of category CATEGORY.'
                 '%'
                 '% Alternative forms to call this method are:'
                ['%  PROPS = ' upper(moniker) '.GETPROPS([CATEGORY]) returns the property list of the ' descriptive_name ' ' upper(moniker) '.']
                ['%  PROPS = Element.GETPROPS(' upper(moniker) '[, CATEGORY]) returns the property list of ''' upper(moniker) '''.']
                ['%  PROPS = Element.GETPROPS(''' class_name '''[, CATEGORY]) returns the property list of ''' class_name '''.']
                 '%'
                ['% Note that the Element.GETPROPS(' upper(moniker) ') and Element.GETPROPS(''' class_name ''')']
                 '%  are less computationally efficient.'
                 '%'
                 '% See also getPropNumber, Category.'
                 ''
                })
                if ~element_created %CET
                    g(3, 'if nargin == 0')
                        g(4, 'prop_list = [ ...')
                            g(5, [superclass_name '.getProps() ...'])
                                for i = 1:1:numel(props)
                                    g(6, [class_name '.' props{i}.TAG ' ...'])
                                end
                                g(6, '];')
                        g(4, 'return')
                    g(3, 'end')
                    g(3, '')
                    g(3, 'switch category')
                        g(4, 'case Category.CONSTANT')
                            g(5, 'prop_list = [ ...')
                                g(6, [superclass_name '.getProps(Category.CONSTANT) ...'])
                                for i = 1:1:numel(props)
                                    if strcmp(props{i}.CATEGORY, 'CONSTANT')
                                        g(6, [class_name '.' props{i}.TAG ' ...'])
                                    end
                                end
                                g(6, '];')
                        g(4, 'case Category.METADATA')
                            g(5, 'prop_list = [ ...')
                                g(6, [superclass_name '.getProps(Category.METADATA) ...'])
                                for i = 1:1:numel(props)
                                    if strcmp(props{i}.CATEGORY, 'METADATA')
                                        g(6, [class_name '.' props{i}.TAG ' ...'])
                                    end
                                end
                                g(6, '];')
                        g(4, 'case Category.PARAMETER')
                            g(5, 'prop_list = [ ...')
                                g(6, [superclass_name '.getProps(Category.PARAMETER) ...'])
                                for i = 1:1:numel(props)
                                    if strcmp(props{i}.CATEGORY, 'PARAMETER')
                                        g(6, [class_name '.' props{i}.TAG ' ...'])
                                    end
                                end
                                g(6, '];')
                        g(4, 'case Category.DATA')
                            g(5, 'prop_list = [ ...');
                                g(6, [superclass_name '.getProps(Category.DATA) ...'])
                                for i = 1:1:numel(props)
                                    if strcmp(props{i}.CATEGORY, 'DATA')
                                        g(6, [class_name '.' props{i}.TAG ' ...'])
                                    end
                                end
                                g(6, '];')
                        g(4, 'case Category.RESULT')
                            g(5, 'prop_list = [')
                                g(6, [superclass_name '.getProps(Category.RESULT) ...'])
                                for i = 1:1:numel(props)
                                    if strcmp(props{i}.CATEGORY, 'RESULT')
                                        g(6, [class_name '.' props{i}.TAG ' ...'])
                                    end
                                end
                                g(6, '];')
                        g(4, 'case Category.QUERY')
                            g(5, 'prop_list = [ ...')
                                g(6, [superclass_name '.getProps(Category.QUERY) ...'])
                                for i = 1:1:numel(props)
                                    if strcmp(props{i}.CATEGORY, 'QUERY')
                                        g(6, [class_name '.' props{i}.TAG ' ...'])
                                    end
                                end
                                g(6, '];')
                        g(4, 'case Category.EVANESCENT')
                            g(5, 'prop_list = [ ...')
                                g(6, [superclass_name '.getProps(Category.EVANESCENT) ...'])
                                for i = 1:1:numel(props)
                                    if strcmp(props{i}.CATEGORY, 'EVANESCENT')
                                        g(6, [class_name '.' props{i}.TAG ' ...'])
                                    end
                                end
                                g(6, '];')
                        g(4, 'case Category.FIGURE')
                            g(5, 'prop_list = [ ...')
                                g(6, [superclass_name '.getProps(Category.FIGURE) ...'])
                                for i = 1:1:numel(props)
                                    if strcmp(props{i}.CATEGORY, 'FIGURE')
                                        g(6, [class_name '.' props{i}.TAG ' ...'])
                                    end
                                end
                                g(6, '];')
                        g(4, 'case Category.GUI')
                            g(5, 'prop_list = [ ...')
                                g(6, [superclass_name '.getProps(Category.GUI) ...'])
                                for i = 1:1:numel(props)
                                    if strcmp(props{i}.CATEGORY, 'GUI')
                                        g(6, [class_name '.' props{i}.TAG ' ...'])
                                    end
                                end
                                g(6, '];')
                    g(3, 'end')
                else
                    g(3, CET)
                    g(3, '')
                    g(3, 'if nargin == 0')
                        g(4, ['prop_list = ' mat2str(Element.getProps(class_name)) ';'])
                        g(4, 'return')
                    g(3, 'end')
                    g(3, '')
                    g(3, 'switch category')
                        if Element.getProps(class_name, Category.CONSTANT) > 0
                            g(4, 'case Category.CONSTANT % __Category.CONSTANT__')
                                g(5, ['prop_list = ' mat2str(Element.getProps(class_name, Category.CONSTANT)) ';'])
                        end
                        if Element.getProps(class_name, Category.METADATA) > 0
                            g(4, 'case Category.METADATA % __Category.METADATA__')
                                g(5, ['prop_list = ' mat2str(Element.getProps(class_name, Category.METADATA)) ';'])
                        end
                        if Element.getProps(class_name, Category.PARAMETER) > 0
                            g(4, 'case Category.PARAMETER % __Category.PARAMETER__')
                                g(5, ['prop_list = ' mat2str(Element.getProps(class_name, Category.PARAMETER)) ';'])
                        end
                        if Element.getProps(class_name, Category.DATA) > 0
                            g(4, 'case Category.DATA % __Category.DATA__')
                                g(5, ['prop_list = ' mat2str(Element.getProps(class_name, Category.DATA)) ';'])
                        end
                        if Element.getProps(class_name, Category.RESULT) > 0
                            g(4, 'case Category.RESULT % __Category.RESULT__')
                                g(5, ['prop_list = ' mat2str(Element.getProps(class_name, Category.RESULT)) ';'])
                        end
                        if Element.getProps(class_name, Category.QUERY) > 0
                            g(4, 'case Category.QUERY % __Category.QUERY__')
                                g(5, ['prop_list = ' mat2str(Element.getProps(class_name, Category.QUERY)) ';'])
                        end
                        if Element.getProps(class_name, Category.EVANESCENT) > 0
                            g(4, 'case Category.EVANESCENT % __Category.EVANESCENT__')
                                g(5, ['prop_list = ' mat2str(Element.getProps(class_name, Category.EVANESCENT)) ';'])
                        end
                        if Element.getProps(class_name, Category.FIGURE) > 0
                            g(4, 'case Category.FIGURE % __Category.FIGURE__')
                                g(5, ['prop_list = ' mat2str(Element.getProps(class_name, Category.FIGURE)) ';'])
                        end
                        if Element.getProps(class_name, Category.GUI) > 0
                            g(4, 'case Category.GUI % __Category.GUI__')
                                g(5, ['prop_list = ' mat2str(Element.getProps(class_name, Category.GUI)) ';'])
                        end
                            g(4, 'otherwise')
                                g(5, 'prop_list = [];')
                    g(3, 'end')
                end
        g(2, 'end')
        
        % getPropNumber([category])
        g(2, 'function prop_number = getPropNumber(varargin)')
            gs(3, {
                ['%GETPROPNUMBER returns the property number of ' descriptive_name '.']
                 '%'
                ['% N = ' class_name '.GETPROPNUMBER() returns the property number of ' descriptive_name '.']
                 '%'
                ['% N = ' class_name '.GETPROPNUMBER(CATEGORY) returns the property number of ' descriptive_name]
                 '%  of category CATEGORY'
                 '%'
                 '% Alternative forms to call this method are:'
                ['%  N = ' upper(moniker) '.GETPROPNUMBER([CATEGORY]) returns the property number of the ' descriptive_name ' ' upper(moniker) '.']
                ['%  N = Element.GETPROPNUMBER(' upper(moniker) ') returns the property number of ''' upper(moniker) '''.']
                ['%  N = Element.GETPROPNUMBER(''' class_name ''') returns the property number of ''' class_name '''.']
                 '%'
                ['% Note that the Element.GETPROPNUMBER(' upper(moniker) ') and Element.GETPROPNUMBER(''' class_name ''')']
                 '%  are less computationally efficient.'
                 '%'
                 '% See also getProps, Category.'
                 ''
                })
            if ~element_created %CET
                g(3, ['prop_number = numel(' class_name '.getProps(varargin{:}));'])
            else
                g(3, CET)
                g(3, '')
                g(3, 'if nargin == 0')
                    g(4, ['prop_number = ' int2str(Element.getPropNumber(class_name)) ';'])
                    g(4, 'return')
                g(3, 'end')
                g(3, '')
                g(3, 'switch varargin{1} % category = varargin{1}')
                    if Element.getPropNumber(class_name, Category.CONSTANT) > 0
                        g(4, 'case Category.CONSTANT % __Category.CONSTANT__')
                            g(5, ['prop_number = ' int2str(Element.getPropNumber(class_name, Category.CONSTANT)) ';'])
                    end
                    if Element.getPropNumber(class_name, Category.METADATA) > 0
                        g(4, 'case Category.METADATA % __Category.METADATA__')
                            g(5, ['prop_number = ' int2str(Element.getPropNumber(class_name, Category.METADATA)) ';'])
                    end
                    if Element.getPropNumber(class_name, Category.PARAMETER) > 0
                        g(4, 'case Category.PARAMETER % __Category.PARAMETER__')
                            g(5, ['prop_number = ' int2str(Element.getPropNumber(class_name, Category.PARAMETER)) ';'])
                    end
                    if Element.getPropNumber(class_name, Category.DATA) > 0
                        g(4, 'case Category.DATA % __Category.DATA__')
                            g(5, ['prop_number = ' int2str(Element.getPropNumber(class_name, Category.DATA)) ';'])
                    end
                    if Element.getPropNumber(class_name, Category.RESULT) > 0
                        g(4, 'case Category.RESULT % __Category.RESULT__')
                            g(5, ['prop_number = ' int2str(Element.getPropNumber(class_name, Category.RESULT)) ';'])
                    end
                    if Element.getPropNumber(class_name, Category.QUERY) > 0
                        g(4, 'case Category.QUERY % __Category.QUERY__')
                            g(5, ['prop_number = ' int2str(Element.getPropNumber(class_name, Category.QUERY)) ';'])
                    end
                    if Element.getPropNumber(class_name, Category.EVANESCENT) > 0
                        g(4, 'case Category.EVANESCENT % __Category.EVANESCENT__')
                            g(5, ['prop_number = ' int2str(Element.getPropNumber(class_name, Category.EVANESCENT)) ';'])
                    end
                    if Element.getPropNumber(class_name, Category.FIGURE) > 0
                        g(4, 'case Category.FIGURE % __Category.FIGURE__')
                            g(5, ['prop_number = ' int2str(Element.getPropNumber(class_name, Category.FIGURE)) ';'])
                    end
                    if Element.getPropNumber(class_name, Category.GUI) > 0
                        g(4, 'case Category.GUI % __Category.GUI__')
                            g(5, ['prop_number = ' int2str(Element.getPropNumber(class_name, Category.GUI)) ';'])
                    end
                        g(4, 'otherwise')
                            g(5, 'prop_number = 0;')
                g(3, 'end')
            end
        g(2, 'end')
        
        % existsProp(prop)
        g(2, 'function check_out = existsProp(prop)')
            gs(3, {
                ['%EXISTSPROP checks whether property exists in ' descriptive_name '/error.']
                 '%'
                ['% CHECK = ' class_name '.EXISTSPROP(PROP) checks whether the property PROP exists.']
                 '%'
                 '% Alternative forms to call this method are:'
                ['%  CHECK = ' upper(moniker) '.EXISTSPROP(PROP) checks whether PROP exists for ' upper(moniker) '.']
                ['%  CHECK = Element.EXISTSPROP(' upper(moniker) ', PROP) checks whether PROP exists for ' upper(moniker) '.']
                ['%  CHECK = Element.EXISTSPROP(' class_name ', PROP) checks whether PROP exists for ' class_name '.']
                 '%'
                 '% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.'
                ['%  Error id: [BRAPH2:' class_name ':WrongInput]']
                 '%'
                 '% Alternative forms to call this method are:'
                ['%  ' upper(moniker) '.EXISTSPROP(PROP) throws error if PROP does NOT exist for ' upper(moniker) '.']
                ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                ['%  Element.EXISTSPROP(' upper(moniker) ', PROP) throws error if PROP does NOT exist for ' upper(moniker) '.']
                ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                ['%  Element.EXISTSPROP(' class_name ', PROP) throws error if PROP does NOT exist for ' class_name '.']
                ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                 '%'
                ['% Note that the Element.EXISTSPROP(' upper(moniker) ') and Element.EXISTSPROP(''' class_name ''')']
                 '%  are less computationally efficient.'
                 '%'
                 '% See also getProps, existsTag.'
                 ''
                })
            if ~element_created %CET
                g(3, ['check = any(prop == ' class_name '.getProps());'])
            else
                g(3, ['check = prop >= 1 && prop <= ' int2str(Element.getPropNumber(class_name)) ' && round(prop) == prop; ' CET])
            end
            g(3, '')
            g(3, 'if nargout == 1')
                g(4, 'check_out = check;')
            g(3, 'elseif ~check')
                g(4, 'error( ...')
                    gs(5, {
                        ['[BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT], ...']
                        ['[BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT ''\\n'' ...']
                        ['''The value '' tostring(prop, 100, '' ...'') '' is not a valid prop for ' class_name '.''] ...']
                        ')'
                        })
            g(3, 'end')
        g(2, 'end')
        
        % existsTag(prop)
        g(2, 'function check_out = existsTag(tag)')
            gs(3, {
                ['%EXISTSTAG checks whether tag exists in ' descriptive_name '/error.']
                 '%'
                ['% CHECK = ' class_name '.EXISTSTAG(TAG) checks whether a property with tag TAG exists.']
                 '%'
                 '% Alternative forms to call this method are:'
                ['%  CHECK = ' upper(moniker) '.EXISTSTAG(TAG) checks whether TAG exists for ' upper(moniker) '.']
                ['%  CHECK = Element.EXISTSTAG(' upper(moniker) ', TAG) checks whether TAG exists for ' upper(moniker) '.']
                ['%  CHECK = Element.EXISTSTAG(' class_name ', TAG) checks whether TAG exists for ' class_name '.']
                 '%'
                 '% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.'
                ['%  Error id: [BRAPH2:' class_name ':WrongInput]']
                 '%'
                 '% Alternative forms to call this method are:'
                ['%  ' upper(moniker) '.EXISTSTAG(TAG) throws error if TAG does NOT exist for ' upper(moniker) '.']
                ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                ['%  Element.EXISTSTAG(' upper(moniker) ', TAG) throws error if TAG does NOT exist for ' upper(moniker) '.']
                ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                ['%  Element.EXISTSTAG(' class_name ', TAG) throws error if TAG does NOT exist for ' class_name '.']
                ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                 '%'
                ['% Note that the Element.EXISTSTAG(' upper(moniker) ') and Element.EXISTSTAG(''' class_name ''')']
                 '%  are less computationally efficient.'
                 '%'
                 '% See also getProps, existsTag.'
                 ''
                })
            if ~element_created %CET
                gs(3, {
                    [lower(class_name) '_tag_list = cellfun(@(x) ' class_name '.getPropTag(x), num2cell(' class_name '.getProps()), ''UniformOutput'', false);']
                    ['check = any(strcmp(tag, ' lower(class_name) '_tag_list));']
                    })
            else
                tag_list = cellfun(@(prop) Element.getPropTag(class_name, prop), num2cell(Element.getProps(class_name)), 'UniformOutput', false);
                if isempty(tag_list)
                    tag_list_txt = '{}';
                else
                    tag_list_txt = ['{' sprintf(' ''%s'' ', tag_list{:}) '}'];
                end
                g(3, ['check = any(strcmp(tag, ' tag_list_txt ')); ' CET])
            end
            g(3, '')
            g(3, 'if nargout == 1')
                g(4, 'check_out = check;')
            g(3, 'elseif ~check')
                g(4, 'error( ...')
                    gs(5, {
                        ['[BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT], ...']
                        ['[BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT ''\\n'' ...']
                        ['''The value '' tag '' is not a valid tag for ' class_name '.''] ...']
                         ')'
                        })
            g(3, 'end')
        g(2, 'end')
        
        % getPropProp(pointer)
        g(2, 'function prop = getPropProp(pointer)')
            gs(3, {
                 '%GETPROPPROP returns the property number of a property.'
                 '%'
                 '% PROP = Element.GETPROPPROP(PROP) returns PROP, i.e., the '
                 '%  property number of the property PROP.'
                 '%'
                 '% PROP = Element.GETPROPPROP(TAG) returns the property number '
                 '%  of the property with tag TAG.'
                 '%'
                 '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  PROPERTY = ' upper(moniker) '.GETPROPPROP(POINTER) returns property number of POINTER of ' upper(moniker) '.']
                ['%  PROPERTY = Element.GETPROPPROP(' class_name ', POINTER) returns property number of POINTER of ' class_name '.']
                ['%  PROPERTY = ' upper(moniker) '.GETPROPPROP(' class_name ', POINTER) returns property number of POINTER of ' class_name '.']
                 '%'
                ['% Note that the Element.GETPROPPROP(' upper(moniker) ') and Element.GETPROPPROP(''' class_name ''')']
                 '%  are less computationally efficient.'
                 '%'
                 '% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,'
                 '%  getPropSettings, getPropDefault, checkProp.'
                 ''
                })
            g(3, 'if ischar(pointer)')
                if ~element_created %CET
                    gs(4, {
                        [lower(class_name) '_tag_list = cellfun(@(x) ' class_name '.getPropTag(x), num2cell(' class_name '.getProps()), ''UniformOutput'', false);']
                        ['prop = find(strcmp(pointer, ' lower(class_name) '_tag_list)); % tag = pointer']
                        })
                else
                    tag_list = cellfun(@(prop) Element.getPropTag(class_name, prop), num2cell(Element.getProps(class_name)), 'UniformOutput', false);
                    if isempty(tag_list)
                        tag_list_txt = '{}';
                    else
                        tag_list_txt = ['{' sprintf(' ''%s'' ', tag_list{:}) '}'];
                    end
                    g(4, ['prop = find(strcmp(pointer, ' tag_list_txt ')); % tag = pointer ' CET])
                end
            g(3, 'else % numeric')
                g(4, 'prop = pointer;')
            g(3, 'end')
        g(2, 'end')
        
        % getPropTag(pointer)
        g(2, 'function tag = getPropTag(pointer)')
            gs(3, {
                 '%GETPROPTAG returns the tag of a property.'
                 '%'
                 '% TAG = Element.GETPROPTAG(PROP) returns the tag TAG of the '
                 '%  property PROP.'
                 '%'
                 '% TAG = Element.GETPROPTAG(TAG) returns TAG, i.e. the tag of '
                 '%  the property with tag TAG.'
                 '%'
                 '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  TAG = ' upper(moniker) '.GETPROPTAG(POINTER) returns tag of POINTER of ' upper(moniker) '.']
                ['%  TAG = Element.GETPROPTAG(' class_name ', POINTER) returns tag of POINTER of ' class_name '.']
                ['%  TAG = ' upper(moniker) '.GETPROPTAG(' class_name ', POINTER) returns tag of POINTER of ' class_name '.']
                 '%'
                ['% Note that the Element.GETPROPTAG(' upper(moniker) ') and Element.GETPROPTAG(''' class_name ''')']
                 '%  are less computationally efficient.'
                 '%'
                 '% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,'
                 '%  getPropDescription, getPropDefault, checkProp.'
                 ''
                })
            g(3, 'if ischar(pointer)')
                g(4, 'tag = pointer;')
            g(3, 'else % numeric')
                if ~element_created %CET
                    gs(4, {
                        'prop = pointer;'
                        ''
                        'switch prop'
                        })
                        for i = 1:1:numel(props)
                            g(5, ['case ' class_name '.' props{i}.TAG])
                                g(6, ['tag = ' class_name '.' props{i}.TAG '_TAG;'])
                        end
                        if ~strcmp(superclass_name, 'Element')
                            g(5, 'otherwise')
                                g(6, ['tag = getPropTag@' superclass_name '(prop);'])
                        end
                    g(4, 'end')
                else
                    tag_list = cellfun(@(prop) Element.getPropTag(class_name, prop), num2cell(Element.getProps(class_name)), 'UniformOutput', false);
                    g(4, CET)
                    if isempty(tag_list)
                        g(4, [lower(class_name) '_tag_list = {}; % will throw an error if called'])
                    else
                        g(4, [lower(class_name) '_tag_list = {' sprintf(' ''%s'' ', tag_list{:}) '};'])
                    end
                    g(4, ['tag = ' lower(class_name) '_tag_list{pointer}; % prop = pointer'])
                end
            g(3, 'end')
        g(2, 'end')
        
        % getPropCategory(pointer)
        g(2, 'function prop_category = getPropCategory(pointer)')
            gs(3, {
                 '%GETPROPCATEGORY returns the category of a property.'
                 '%'
                 '% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the category of the'
                 '%  property PROP.'
                 '%'
                 '% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the category of the'
                 '%  property with tag TAG.'
                 '%'
                 '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  CATEGORY = ' upper(moniker) '.GETPROPCATEGORY(POINTER) returns category of POINTER of ' upper(moniker) '.']
                ['%  CATEGORY = Element.GETPROPCATEGORY(' class_name ', POINTER) returns category of POINTER of ' class_name '.']
                ['%  CATEGORY = ' upper(moniker) '.GETPROPCATEGORY(' class_name ', POINTER) returns category of POINTER of ' class_name '.']
                 '%'
                ['% Note that the Element.GETPROPCATEGORY(' upper(moniker) ') and Element.GETPROPCATEGORY(''' class_name ''')']
                 '%  are less computationally efficient.'
                 '%'
                 '% See also Category, getPropProp, getPropTag, getPropSettings,'
                 '%  getPropFormat, getPropDescription, getPropDefault, checkProp.'
                 ''
                })
            gs(3, {
                ['prop = ' class_name '.getPropProp(pointer);']
                 ''
                })
                if ~element_created %CET
                    g(3, 'switch prop')
                        for i = 1:1:numel(props)
                            g(4, ['case ' class_name '.' props{i}.TAG])
                                g(5, ['prop_category = ' class_name '.' props{i}.TAG '_CATEGORY;'])
                        end
                        if ~strcmp(superclass_name, 'Element')
                            g(4, 'otherwise')
                                g(5, ['prop_category = getPropCategory@' superclass_name '(prop);'])
                        end
                    g(3, 'end')
                else
                    category_list = cellfun(@(prop) int2str(Element.getPropCategory(class_name, prop)), num2cell(Element.getProps(class_name)), 'UniformOutput', false);
                    g(3, CET)
                    if isempty(category_list)
                        g(3, [lower(class_name) '_category_list = {};'])
                    else
                        g(3, [lower(class_name) '_category_list = {' sprintf(' %s ', category_list{:}) '};'])
                    end
                    g(3, ['prop_category = ' lower(class_name) '_category_list{prop};'])
                end
        g(2, 'end')
        
        % getPropFormat(pointer)
        g(2, 'function prop_format = getPropFormat(pointer)')
            gs(3, {
                 '%GETPROPFORMAT returns the format of a property.'
                 '%'
                 '% FORMAT = Element.GETPROPFORMAT(PROP) returns the'
                 '%  format of the property PROP.'
                 '%'
                 '% FORMAT = Element.GETPROPFORMAT(TAG) returns the'
                 '%  format of the property with tag TAG.'
                 '%'
                 '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  FORMAT = ' upper(moniker) '.GETPROPFORMAT(POINTER) returns format of POINTER of ' upper(moniker) '.']
                ['%  FORMAT = Element.GETPROPFORMAT(' class_name ', POINTER) returns format of POINTER of ' class_name '.']
                ['%  FORMAT = ' upper(moniker) '.GETPROPFORMAT(' class_name ', POINTER) returns format of POINTER of ' class_name '.']
                 '%'
                ['% Note that the Element.GETPROPFORMAT(' upper(moniker) ') and Element.GETPROPFORMAT(''' class_name ''')']
                 '%  are less computationally efficient.'
                 '%'
                 '% See also Format, getPropProp, getPropTag, getPropCategory,'
                 '%  getPropDescription, getPropSettings, getPropDefault, checkProp.'
                 ''
                })
            gs(3, {
                ['prop = ' class_name '.getPropProp(pointer);']
                 ''
                })
            if ~element_created %CET
                g(3, 'switch prop')
                    for i = 1:1:numel(props)
                        g(4, ['case ' class_name '.' props{i}.TAG])
                            g(5, ['prop_format = ' class_name '.' props{i}.TAG '_FORMAT;'])
                    end
                    if ~strcmp(superclass_name, 'Element')
                        g(4, 'otherwise')
                            g(5, ['prop_format = getPropFormat@' superclass_name '(prop);'])
                    end
                g(3, 'end')
            else
                format_list = cellfun(@(prop) int2str(Element.getPropFormat(class_name, prop)), num2cell(Element.getProps(class_name)), 'UniformOutput', false);
                g(3, CET)
                if isempty(format_list)
                    g(3, [lower(class_name) '_format_list = {};'])
                else
                    g(3, [lower(class_name) '_format_list = {' sprintf(' %s ', format_list{:}) '};'])
                end
                g(3, ['prop_format = ' lower(class_name) '_format_list{prop};'])
            end
        g(2, 'end')
        
        % getPropDescription(pointer)
        g(2, 'function prop_description = getPropDescription(pointer)')
            gs(3, {
                 '%GETPROPDESCRIPTION returns the description of a property.'
                 '%'
                 '% DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the'
                 '%  description of the property PROP.'
                 '%'
                 '% DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the'
                 '%  description of the property with tag TAG.'
                 '%'
                 '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  DESCRIPTION = ' upper(moniker) '.GETPROPDESCRIPTION(POINTER) returns description of POINTER of ' upper(moniker) '.']
                ['%  DESCRIPTION = Element.GETPROPDESCRIPTION(' class_name ', POINTER) returns description of POINTER of ' class_name '.']
                ['%  DESCRIPTION = ' upper(moniker) '.GETPROPDESCRIPTION(' class_name ', POINTER) returns description of POINTER of ' class_name '.']
                 '%'
                ['% Note that the Element.GETPROPDESCRIPTION(' upper(moniker) ') and Element.GETPROPDESCRIPTION(''' class_name ''')']
                 '%  are less computationally efficient.'
                 '%'
                 '% See also getPropProp, getPropTag, getPropCategory,'
                 '%  getPropFormat, getPropSettings, getPropDefault, checkProp.'
                 ''
                })
            gs(3, {
                ['prop = ' class_name '.getPropProp(pointer);']
                 ''
                })
            if ~element_created %CET
                g(3, 'switch prop')
                    for i = 1:1:numel(props)
                        g(4, ['case ' class_name '.' props{i}.TAG])
                            g(5, ['prop_description = ''' props{i}.description ''';'])
                    end
                    for i = 1:1:numel(props_update)
                        g(4, ['case ' class_name '.' props_update{i}.TAG])
                            g(5, ['prop_description = ''' props_update{i}.description ''';'])
                    end
                    if ~strcmp(superclass_name, 'Element')
                        g(4, 'otherwise')
                            g(5, ['prop_description = getPropDescription@' superclass_name '(prop);'])
                    end
                g(3, 'end')
            else
                format_list = cellfun(@(prop) Element.getPropDescription(class_name, prop), num2cell(Element.getProps(class_name)), 'UniformOutput', false);
                g(3, CET)
                if isempty(format_list)
                    g(3, [lower(class_name) '_description_list = {};'])
                else
                    g(3, [lower(class_name) '_description_list = {' sprintf(' ''%s'' ', format_list{:}) '};'])
                end
                g(3, ['prop_description = ' lower(class_name) '_description_list{prop};'])
            end
        g(2, 'end')
        
        % getPropSettings(pointer)
        g(2, 'function prop_settings = getPropSettings(pointer)')
            gs(3, {
                 '%GETPROPSETTINGS returns the settings of a property.'
                 '%'
                 '% SETTINGS = Element.GETPROPSETTINGS(PROP) returns the'
                 '%  settings of the property PROP.'
                 '%'
                 '% SETTINGS = Element.GETPROPSETTINGS(TAG) returns the'
                 '%  settings of the property with tag TAG.'
                 '%'
                 '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  SETTINGS = ' upper(moniker) '.GETPROPSETTINGS(POINTER) returns settings of POINTER of ' upper(moniker) '.']
                ['%  SETTINGS = Element.GETPROPSETTINGS(' class_name ', POINTER) returns settings of POINTER of ' class_name '.']
                ['%  SETTINGS = ' upper(moniker) '.GETPROPSETTINGS(' class_name ', POINTER) returns settings of POINTER of ' class_name '.']
                 '%'
                ['% Note that the Element.GETPROPSETTINGS(' upper(moniker) ') and Element.GETPROPSETTINGS(''' class_name ''')']
                 '%  are less computationally efficient.'
                 '%'
                 '% See also getPropProp, getPropTag, getPropCategory, getPropFormat,'
                 '%  getPropDescription, getPropDefault, checkProp.'
                 ''
                })
            gs(3, {
                ['prop = ' class_name '.getPropProp(pointer);']
                 ''
                })
            if ~element_created %CET
                g(3, 'switch prop')
                    for i = 1:1:numel(props)
                        g(4, ['case ' class_name '.' props{i}.TAG])
                            if isempty(props{i}.settings)
                                g(5, ['prop_settings = Format.getFormatSettings(Format.' props{i}.FORMAT ');'])
                            else
                                g(5, ['prop_settings = ' props{i}.settings ';'])
                            end
                    end
                    for i = 1:1:numel(props_update)
                        if ~isempty(props_update{i}.settings)
                            g(4, ['case ' class_name '.' props_update{i}.TAG])
                                g(5, ['prop_settings = ' props_update{i}.settings ';'])
                        end
                    end
                    if ~strcmp(superclass_name, 'Element')
                        g(4, 'otherwise')
                            g(5, ['prop_settings = getPropSettings@' superclass_name '(prop);'])
                    end
                g(3, 'end')
            else
                g(3, ['switch prop ' CET])
                    for i = 1:1:numel(props)
                        g(4, ['case ' class_name '.' props{i}.TAG ' % __' class_name '.' props{i}.TAG '__'])
                        if isempty(props{i}.settings)
                            g(5, ['prop_settings = Format.getFormatSettings(Format.' props{i}.FORMAT ');'])
                        else
                            g(5, ['prop_settings = ' props{i}.settings ';'])
                        end
                    end
                    for i = 1:1:numel(props_update)
                        if ~isempty(props_update{i}.settings)
                            g(4, ['case ' class_name '.' props_update{i}.TAG ' % __' class_name '.' props_update{i}.TAG '__'])
                            g(5, ['prop_settings = ' props_update{i}.settings ';'])
                        end
                    end
                    if ~strcmp(superclass_name, 'Element')
                        g(4, 'otherwise')
                        g(5, ['prop_settings = getPropSettings@' superclass_name '(prop);'])
                    end
                g(3, 'end')
            end
        g(2, 'end')
        
        % getPropDefault(pointer)
        g(2, 'function prop_default = getPropDefault(pointer)')
            gs(3, {
                 '%GETPROPDEFAULT returns the default value of a property.'
                 '%'
                ['% DEFAULT = ' class_name '.GETPROPDEFAULT(PROP) returns the default ']
                 '%  value of the property PROP.'
                 '%'
                ['% DEFAULT = ' class_name '.GETPROPDEFAULT(TAG) returns the default ']
                 '%  value of the property with tag TAG.'
                 '%'
                 '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  DEFAULT = ' upper(moniker) '.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ' upper(moniker) '.']
                ['%  DEFAULT = Element.GETPROPDEFAULT(' class_name ', POINTER) returns the default value of POINTER of ' class_name '.']
                ['%  DEFAULT = ' upper(moniker) '.GETPROPDEFAULT(' class_name ', POINTER) returns the default value of POINTER of ' class_name '.']
                 '%'
                ['% Note that the Element.GETPROPDEFAULT(' upper(moniker) ') and Element.GETPROPDEFAULT(''' class_name ''')']
                 '%  are less computationally efficient.'
                 '%'
                 '% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, '
                 '%  getPropCategory, getPropFormat, getPropDescription, checkProp.'
                 ''
                })
            gs(3, {
                ['prop = ' class_name '.getPropProp(pointer);']
                 ''
                })
            if ~element_created %CET
                g(3, 'switch prop')
                    for i = 1:1:numel(props)
                        g(4, ['case ' class_name '.' props{i}.TAG])
                            if ~isempty(props{i}.default)
                                g(5, ['prop_default = ' props{i}.default ';'])
                            else
                                g(5, ['prop_default = Format.getFormatDefault(Format.' props{i}.FORMAT ', ' class_name '.getPropSettings(prop));'])
                            end
                    end
                    for i = 1:1:numel(props_update)
                        if ~isempty(props_update{i}.default)
                            g(4, ['case ' class_name '.' props_update{i}.TAG])
                                g(5, ['prop_default = ' props_update{i}.default ';'])
                        elseif ~isempty(props_update{i}.settings)
                            g(4, ['case ' class_name '.' props_update{i}.TAG])
                                g(5, ['prop_default = Format.getFormatDefault(Format.' props_update{i}.FORMAT ', ' class_name '.getPropSettings(prop));'])
                        end
                    end
                    if ~strcmp(superclass_name, 'Element')
                        g(4, 'otherwise');
                            g(5, [ 'prop_default = getPropDefault@' superclass_name '(prop);']);
                    end
                g(3, 'end')
            else
                g(3, ['switch prop ' CET])
                    for i = 1:1:numel(props)
                        g(4, ['case ' class_name '.' props{i}.TAG ' % __' class_name '.' props{i}.TAG '__'])
                            if ~isempty(props{i}.default)
                                g(5, ['prop_default = ' props{i}.default ';'])
                            else
                                g(5, ['prop_default = Format.getFormatDefault(Format.' props{i}.FORMAT ', ' class_name '.getPropSettings(prop));'])
                            end
                    end
                    for i = 1:1:numel(props_update)
                        if ~isempty(props_update{i}.default)
                            g(4, ['case ' class_name '.' props_update{i}.TAG ' % __' class_name '.' props_update{i}.TAG '__'])
                                g(5, ['prop_default = ' props_update{i}.default ';'])
                        elseif ~isempty(props_update{i}.settings)
                            g(4, ['case ' class_name '.' props_update{i}.TAG ' % __' class_name '.' props_update{i}.TAG '__'])
                                g(5, ['prop_default = Format.getFormatDefault(Format.' props_update{i}.FORMAT ', ' class_name '.getPropSettings(prop));'])
                        end
                    end
                    if ~strcmp(superclass_name, 'Element')
                        g(4, 'otherwise');
                            g(5, [ 'prop_default = getPropDefault@' superclass_name '(prop);']);
                    end
                g(3, 'end')
            end
        g(2, 'end')
        
        % getPropDefaultConditioned(pointer)
        g(2, 'function prop_default = getPropDefaultConditioned(pointer)')
            gs(3, {
                 '%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.'
                 '%'
                ['% DEFAULT = ' class_name '.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default ']
                 '%  value of the property PROP.'
                 '%'
                ['% DEFAULT = ' class_name '.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default ']
                 '%  value of the property with tag TAG.'
                 '%'
                 '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  DEFAULT = ' upper(moniker) '.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ' upper(moniker) '.']
                ['%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(' class_name ', POINTER) returns the conditioned default value of POINTER of ' class_name '.']
                ['%  DEFAULT = ' upper(moniker) '.GETPROPDEFAULTCONDITIONED(' class_name ', POINTER) returns the conditioned default value of POINTER of ' class_name '.']
                 '%'
                ['% Note that the Element.GETPROPDEFAULTCONDITIONED(' upper(moniker) ') and Element.GETPROPDEFAULTCONDITIONED(''' class_name ''')']
                 '%  are less computationally efficient.'
                 '%'
                 '% See also conditioning, getPropDefault, getPropProp, getPropTag, '
                 '%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, '
                 '%  checkProp.'
                 ''
                })
            gs(3, {
                ['prop = ' class_name '.getPropProp(pointer);']
                ''
                ['prop_default = ' class_name '.conditioning(prop, ' class_name '.getPropDefault(prop));']
                })
        g(2, 'end')
        
        g(1, 'end')
    end

generate_conditioning()
    function generate_conditioning()
        if all(cellfun(@(x) isequal(x.conditioning, {''}), props)) ...
                && all(cellfun(@(x) isequal(x.conditioning, {''}), props_update)) ...
                && ~strcmp(superclass_name, 'Element')
            return
        end
        g(1, 'methods (Static, Access=protected) % conditioning')
            if strcmp(superclass_name, 'Element')
                g(2, 'function value = conditioning(~, value)')
            else
                g(2, 'function value = conditioning(pointer, value)')
            end
                gs(3, {
                     '%CONDITIONING conditions a value before setting a property.'
                     '%'
                     '% VALUE = CONDITIONING(EL, PROP, VALUE) conditions the value VALUE before'
                     '%  it is set as the value of the property PROP.'
                     '%  By default, this function does not do anything, so it should be'
                     '%  implemented in the subclasses of Element when needed.'
                     '%'
                     '% Conditioning is only used for props of Category.METADATA,'
                     '%  Category.PARAMETER, Category.DATA, Category.FIGURE and Category.GUI.'
                     '%'
                     '% See also preset, checkProp, postset, postprocessing, calculateValue,'
                     '%  checkValue.'
                     ''
                    })
                if any(cellfun(@(x) ~isequal(x.conditioning, {''}), props)) ...
                        || any(cellfun(@(x) ~isequal(x.conditioning, {''}), props_update))
                    gs(3, {
                        ['prop = ' class_name '.getPropProp(pointer);']
                         ''
                         'switch prop'
                        })
                        for i = 1:1:numel(props)
                            if numel(props{i}.conditioning) > 1 || ~isempty(props{i}.conditioning{1})
                                g(4, ['case ' class_name '.' props{i}.TAG ' % __' class_name '.' props{i}.TAG '__'])
                                    gs(5, props{i}.conditioning)
                                    g(5, '')
                            end
                        end
                        for i = 1:1:numel(props_update)
                            if numel(props_update{i}.conditioning) > 1 || ~isempty(props_update{i}.conditioning{1})
                                g(4, ['case ' class_name '.' props_update{i}.TAG ' % __' class_name '.' props_update{i}.TAG '__'])
                                    gs(5, props_update{i}.conditioning)
                                    g(5, '')
                            end
                        end
                        if ~strcmp(superclass_name, 'Element')
                            g(4, 'otherwise')
                                g(5, ['if prop <= ' superclass_name '.getPropNumber()'])
                                    g(6, ['value = conditioning@' superclass_name '(pointer, value);'])
                                g(5, 'end')
                        end
                    g(3, 'end')
                end
            g(2, 'end')
        g(1, 'end')
    end

generate_preset()
    function generate_preset()
        if all(cellfun(@(x) isequal(x.preset, {''}), props)) ...
                && all(cellfun(@(x) isequal(x.preset, {''}), props_update))
            return
        end
        g(1, 'methods (Access=protected) % preset')
            g(2, ['function value = preset(' moniker ', prop, value)'])
                gs(3, {
                     '%PRESET preprocesses the value of a property before setting it.'
                     '%'
                     '% VALUE = PRESET(EL, PROP, VALUE) prepropcesses the VALUE of the property'
                     '%  PROP. It works only with properties with Category.METADATA,'
                     '%  Category.PARAMETER, Category.DATA, Category.FIGURE and Category.GUI. By'
                     '%  default, this function does not do anything, so it should be implemented'
                     '%  in the subclasses of Element when needed.'
                     '%'
                     '% See also conditioning, checkProp, postset, postprocessing,'
                     '%  calculateValue, checkValue.'
                     ''
                    })
                g(3, 'switch prop')
                    for i = 1:1:numel(props)
                        if ~isequal(props{i}.preset, {''})
                            g(4, ['case ' class_name '.' props{i}.TAG ' % __' class_name '.' props{i}.TAG '__'])
                                gs(5, props{i}.preset)
                                g(5, '')
                        end
                    end
                    for i = 1:1:numel(props_update)
                        if ~isequal(props_update{i}.preset, {''})
                            g(4, ['case ' class_name '.' props_update{i}.TAG ' % __' class_name '.' props_update{i}.TAG '__'])
                                gs(5, props_update{i}.preset)
                                g(5, '')
                        end
                    end
                    if ~strcmp(superclass_name, 'Element')
                        g(4, 'otherwise')
                            g(5, ['if prop <= ' superclass_name '.getPropNumber()'])
                                g(6, ['value = preset@' superclass_name '(' moniker ', prop, value);'])
                            g(5, 'end')
                    end
                g(3, 'end')
            g(2, 'end')
        g(1, 'end')
    end

generate_checkProp()
    function generate_checkProp()
        g(1, 'methods (Static) % checkProp')
            g(2, 'function prop_check = checkProp(pointer, value)')
                gs(3, {
                     '%CHECKPROP checks whether a value has the correct format/error.'
                     '%'
                    ['% CHECK = ' upper(moniker) '.CHECKPROP(POINTER, VALUE) checks whether']
                     '%  VALUE is an acceptable value for the format of the property'
                     '%  POINTER (POINTER = PROP or TAG).'
                     '% '
                     '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                    ['%  CHECK = ' upper(moniker) '.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of ' upper(moniker) '.']
                    ['%  CHECK = Element.CHECKPROP(' class_name ', PROP, VALUE) checks VALUE format for PROP of ' class_name '.']
                    ['%  CHECK = ' upper(moniker) '.CHECKPROP(' class_name ', PROP, VALUE) checks VALUE format for PROP of ' class_name '.']
                     '% '
                    ['% ' upper(moniker) '.CHECKPROP(POINTER, VALUE) throws an error if VALUE is']
                     '%  NOT an acceptable value for the format of the property POINTER.'
                    ['%  Error id: €BRAPH2.STR€:' class_name ':€BRAPH2.WRONG_INPUT€']
                     '% '
                     '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                    ['%  ' upper(moniker) '.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ' upper(moniker) '.']
                    ['%   Error id: €BRAPH2.STR€:' class_name ':€BRAPH2.WRONG_INPUT€']
                    ['%  Element.CHECKPROP(' class_name ', PROP, VALUE) throws error if VALUE has not a valid format for PROP of ' class_name '.']
                    ['%   Error id: €BRAPH2.STR€:' class_name ':€BRAPH2.WRONG_INPUT€']
                    ['%  ' upper(moniker) '.CHECKPROP(' class_name ', PROP, VALUE) throws error if VALUE has not a valid format for PROP of ' class_name '.']
                    ['%   Error id: €BRAPH2.STR€:' class_name ':€BRAPH2.WRONG_INPUT€]']
                     '% '
                    ['% Note that the Element.CHECKPROP(' upper(moniker) ') and Element.CHECKPROP(''' class_name ''')']
                     '%  are less computationally efficient.'
                     '%'
                     '% See also Format, getPropProp, getPropTag, getPropSettings,'
                     '% getPropCategory, getPropFormat, getPropDescription, getPropDefault.'
                     ''
                    })
                gs(3, {
                    ['prop = ' class_name '.getPropProp(pointer);']
                     ''
                     'switch prop'
                    })
                    for i = 1:1:numel(props)
                        g(4, ['case ' class_name '.' props{i}.TAG ' % __' class_name '.' props{i}.TAG '__']);
                            g(5, ['check = Format.checkFormat(Format.' props{i}.FORMAT ', value, ' class_name '.getPropSettings(prop));'])
                            if numel(props{i}.check_prop) > 1 || ~isempty(props{i}.check_prop{1})
                                g(5, 'if check')
                                    gs(6, props{i}.check_prop)
                                g(5, 'end')
                            end
                    end
                    for i = 1:1:numel(props_update)
                        if ~isempty(props_update{i}.settings) || numel(props_update{i}.check_prop) > 1 || ~isempty(props_update{i}.check_prop{1})
                            g(4, ['case ' class_name '.' props_update{i}.TAG ' % __' class_name '.' props_update{i}.TAG '__']);
                                g(5, ['check = Format.checkFormat(Format.' props_update{i}.FORMAT ', value, ' class_name '.getPropSettings(prop));'])
                                if numel(props_update{i}.check_prop) > 1 || ~isempty(props_update{i}.check_prop{1})
                                    g(5, 'if check')
                                        gs(6, props_update{i}.check_prop)
                                    g(5, 'end')
                                end
                        end
                    end
                    if ~strcmp(superclass_name, 'Element')
                        g(4, 'otherwise')
                            g(5, ['if prop <= ' superclass_name '.getPropNumber()'])
                                g(6, ['check = checkProp@' superclass_name '(prop, value);'])
                            g(5, 'end')
                    end
                g(3, 'end')
                g(3, '')
                g(3, 'if nargout == 1')
                    g(4, 'prop_check = check;')
                g(3, 'elseif ~check')
                    g(4, 'error( ...')
                        gs(5, {
                            ['[BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT], ...']
                            ['[BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT ''\\n'' ...']
                            ['''The value '' tostring(value, 100, '' ...'') '' is not a valid property '' ' class_name '.getPropTag(prop) '' ('' ' class_name '.getFormatTag(' class_name '.getPropFormat(prop)) '').''] ...']
                            ')'
                            })
                g(3, 'end')
            g(2, 'end')
        g(1, 'end')
    end

generate_postset()
    function generate_postset()
        if all(cellfun(@(x) isequal(x.postset, {''}), props)) ...
                && all(cellfun(@(x) isequal(x.postset, {''}), props_update))
            return
        end
        g(1, 'methods (Access=protected) % postset')
            g(2, ['function postset(' moniker ', prop)'])
                gs(3, {
                     '%POSTSET postprocessing after a prop has been set.'
                     '%'
                     '% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By'
                     '%  default, this function does not do anything, so it should be implemented'
                     '%  in the subclasses of Element when needed.'
                     '%'
                     '% This postprocessing occurs only when PROP is set.'
                     '%'
                     '% See also conditioning, preset, checkProp, postprocessing, calculateValue,'
                     '%  checkValue.'
                     ''
                    })
                g(3, 'switch prop')
                    for i = 1:1:numel(props)
                        if ~isequal(props{i}.postset, {''})
                            g(4, ['case ' class_name '.' props{i}.TAG ' % __' class_name '.' props{i}.TAG '__'])
                                gs(5, props{i}.postset)
                                g(5, '')
                        end
                    end
                    for i = 1:1:numel(props_update)
                        if ~isequal(props_update{i}.postset, {''})
                            g(4, ['case ' class_name '.' props_update{i}.TAG ' % __' class_name '.' props_update{i}.TAG '__'])
                                gs(5, props_update{i}.postset)
                                g(5, '')
                        end
                    end
                    if ~strcmp(superclass_name, 'Element')
                        g(4, 'otherwise')
                            g(5, ['if prop <= ' superclass_name '.getPropNumber()'])
                                g(6, ['postset@' superclass_name '(' moniker ', prop);'])
                            g(5, 'end')
                    end
                g(3, 'end')
            g(2, 'end')
        g(1, 'end')
    end

generate_postprocessing()
    function generate_postprocessing()
        if all(cellfun(@(x) isequal(x.postprocessing, {''}), props)) ...
                && all(cellfun(@(x) isequal(x.postprocessing, {''}), props_update))
            return
        end
        g(1, 'methods (Access=protected) % postprocessing')
            g(2, ['function postprocessing(' moniker ', prop)'])
                gs(3, {
                     '%POSTPROCESSING postprocessesing after setting.'
                     '%'
                     '% POSTPROCESSING(EL, PROP) postprocessesing of PROP after setting. By'
                     '%  default, this function does not do anything, so it should be implemented'
                     '%  in the subclasses of Element when needed.'
                     '%'
                     '% The postprocessing of all properties occurs each time set is called.'
                     '%'
                     '% See also conditioning, preset, checkProp, postset, calculateValue,'
                     '%  checkValue.'
                     ''
                    })
                g(3, 'switch prop')
                    for i = 1:1:numel(props)
                        if ~isequal(props{i}.postprocessing, {''})
                            g(4, ['case ' class_name '.' props{i}.TAG ' % __' class_name '.' props{i}.TAG '__'])
                                gs(5, props{i}.postprocessing)
                                g(5, '')
                        end
                    end
                    for i = 1:1:numel(props_update)
                        if ~isequal(props_update{i}.postprocessing, {''})
                            g(4, ['case ' class_name '.' props_update{i}.TAG ' % __' class_name '.' props_update{i}.TAG '__'])
                                gs(5, props_update{i}.postprocessing)
                                g(5, '')
                        end
                    end
                    if ~strcmp(superclass_name, 'Element')
                        g(4, 'otherwise')
                            g(5, ['if prop <= ' superclass_name '.getPropNumber()'])
                                g(6, ['postprocessing@' superclass_name '(' moniker ', prop);'])
                            g(5, 'end')
                    end
                g(3, 'end')
            g(2, 'end')
        g(1, 'end')
    end

generate_calculateValue()
    function generate_calculateValue()
        if sum(cellfun(@(prop) any(strcmp(prop.CATEGORY, {'RESULT', 'QUERY', 'EVANESCENT'})), props)) == 0 ...
                && sum(cellfun(@(prop) any(strcmp(prop.CATEGORY, {'RESULT', 'QUERY', 'EVANESCENT'})), props_update)) == 0
            return
        elseif all(cellfun(@(x) isequal(x.calculate, {''}), props)) ...
                && all(cellfun(@(x) isequal(x.calculate, {''}), props_update))
            return
        end
        g(1, 'methods (Access=protected) % calculate value')
            g(2, ['function value = calculateValue(' moniker ', prop, varargin)'])
                gs(3, {
                     '%CALCULATEVALUE calculates the value of a property.'
                     '%'
                     '% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property'
                     '%  PROP. It works only with properties with Category.RESULT,'
                     '%  Category.QUERY, and Category.EVANESCENT. By default this function'
                     '%  returns the default value for the prop and should be implemented in the'
                     '%  subclasses of Element when needed.'
                     '%'
                     '% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with'
                     '%  Category.QUERY.'
                     '%'
                     '% See also getPropDefaultConditioned, conditioning, preset, checkProp,'
                     '%  postset, postprocessing, checkValue.'
                     ''
                    })
                g(3, 'switch prop')
                    for i = 1:1:numel(props)
                        if any(strcmp(props{i}.CATEGORY, {'QUERY' 'EVANESCENT'}))
                            if ~isequal(props{i}.calculate, {''})
                                g(4, ['case ' class_name '.' props{i}.TAG ' % __' class_name '.' props{i}.TAG '__'])
                                    gs(5, props{i}.calculate)
                                    g(5, '')
                            end
                        elseif any(strcmp(props{i}.CATEGORY, 'RESULT'))
                            if ~isequal(props{i}.calculate, {''})
                                g(4, ['case ' class_name '.' props{i}.TAG ' % __' class_name '.' props{i}.TAG '__'])
                                    g(5, ['rng_settings_ = rng(); rng(' moniker '.getPropSeed(' class_name '.' props{i}.TAG '), ''twister'')'])
                                    g(5, '')
                                    gs(5, props{i}.calculate)
                                    g(5, '')
                                    g(5, 'rng(rng_settings_)')
                                    g(5, '')
                            end
                        end
                    end
                    for i = 1:1:numel(props_update)
                        if any(strcmp(props_update{i}.CATEGORY, {'QUERY' 'EVANESCENT'}))
                            if ~isequal(props_update{i}.calculate, {''})
                                g(4, ['case ' class_name '.' props_update{i}.TAG ' % __' class_name '.' props_update{i}.TAG '__'])
                                    gs(5, props_update{i}.calculate)
                                    g(5, '')
                            end
                        elseif strcmp(props_update{i}.CATEGORY, 'RESULT')
                            if ~isequal(props_update{i}.calculate, {''})
                                g(4, ['case ' class_name '.' props_update{i}.TAG ' % __' class_name '.' props_update{i}.TAG '__'])
                                    g(5, ['rng_settings_ = rng(); rng(' moniker '.getPropSeed(' class_name '.' props_update{i}.TAG '), ''twister'')'])
                                    g(5, '')
                                    gs(5, props_update{i}.calculate)
                                    g(5, '')
                                    g(5, 'rng(rng_settings_)')
                                    g(5, '')
                            end                            
                        end
                    end
                        g(4, 'otherwise')
                            g(5, ['if prop <= ' superclass_name '.getPropNumber()'])
                                g(6, ['value = calculateValue@' superclass_name '(' moniker ', prop, varargin{:});'])
                            g(5, 'else')
                                g(6, ['value = calculateValue@Element(' moniker ', prop, varargin{:});'])
                            g(5, 'end')
                g(3, 'end')
                g(3, '')
                if any(cellfun(@(x) any(contains(x.calculate, '{@cb_get,')), props)) ...
                        || any(cellfun(@(x) any(contains(x.calculate, '{@cb_get,')), props_update))
                    g(3, 'function cb_get(~, ~, varargin)')
                        g(4, [moniker '.get(varargin{:})'])
                    g(3, 'end')
                end
                if any(cellfun(@(x) any(contains(x.calculate, '{@cb_set,')), props)) ...
                        || any(cellfun(@(x) any(contains(x.calculate, '{@cb_set,')), props_update))
                    g(3, 'function cb_set(~, ~, varargin)')
                        g(4, [moniker '.set(varargin{:})'])
                    g(3, 'end')
                end
                for i = 1:1:numel(props)
                    if any(strcmp(props{i}.CATEGORY, {'RESULT', 'QUERY', 'EVANESCENT'}))
                        if ~isequal(props{i}.calculate_callbacks, {''})
                            gs(3, props{i}.calculate_callbacks)
                        end
                    end
                end
                for i = 1:1:numel(props_update)
                    if any(strcmp(props_update{i}.CATEGORY, {'RESULT', 'QUERY', 'EVANESCENT'}))
                        if ~isequal(props_update{i}.calculate_callbacks, {''})
                            gs(3, props_update{i}.calculate_callbacks)
                        end
                    end
                end
            g(2, 'end')
        g(1, 'end')
    end

generate_checkValue()
    function generate_checkValue()
        if all(cellfun(@(x) isequal(x.check_value, {''}), props)) ...
                && all(cellfun(@(x) isequal(x.check_value, {''}), props_update))
            return
        end
        g(1, 'methods (Access=protected) % check value')
            g(2, ['function [check, msg] = checkValue(' moniker ', prop, value)'])
                gs(3, {
                     '%CHECKVALUE checks the value of a property after it is set/calculated.'
                     '%'
                     '% [CHECK, MSG] = CHECKVALUE(EL, PROP, VALUE) checks the value'
                     '%  of the property PROP after it is set/calculated. This function by'
                     '%  default returns a CHECK = true and MSG = ''. It should be implemented in'
                     '%  the subclasses of Element when needed.'
                     '%'
                     '% See also conditioning, preset, checkProp, postset, postprocessing,'
                     '%  calculateValue.'
                     ''
                     'check = true;'
                    ['msg = [''Error while checking '' tostring(' moniker ') '' '' ' moniker '.getPropTag(prop) ''.''];']
                     ''
                    })
                g(3, 'switch prop')
                    for i = 1:1:numel(props)
                        if ~isequal(props{i}.check_value, {''})
                            g(4, ['case ' class_name '.' props{i}.TAG ' % __' class_name '.' props{i}.TAG '__'])
                                gs(5, props{i}.check_value)
                                g(5, '')
                        end
                    end
                    for i = 1:1:numel(props_update)
                        if ~isequal(props_update{i}.check_value, {''})
                            g(4, ['case ' class_name '.' props_update{i}.TAG ' % __' class_name '.' props_update{i}.TAG '__'])
                                gs(5, props_update{i}.check_value)
                                g(5, '')
                        end
                    end
                    if ~strcmp(superclass_name, 'Element')
                        g(4, 'otherwise')
                            g(5, ['if prop <= ' superclass_name '.getPropNumber()'])
                                g(6, ['[check, msg] = checkValue@' superclass_name '(' moniker ', prop, value);'])
                            g(5, 'end')
                    end
                g(3, 'end')
            g(2, 'end')
        g(1, 'end')
    end

generate_gui()
    function generate_gui()
        if all(cellfun(@(x) isequal(x.gui, {''}), props)) ...
                && all(cellfun(@(x) isequal(x.gui, {''}), props_update))
            return
        end
        g(1, 'methods % GUI')
            if any(cellfun(@(x) ~isequal(x.gui, {''}), props)) || any(cellfun(@(x) ~isequal(x.gui, {''}), props_update))
                g(2, ['function pr = getPanelProp(' moniker ', prop, varargin)'])
                    gs(3, {
                        '%GETPANELPROP returns a prop panel.'
                        '%'
                        '% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.'
                        '%'
                        '% PR = GETPANELPROP(EL, PROP, ''Name'', Value, ...) sets the properties '
                        '%  of the panel prop.'
                        '%'
                        '% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,'
                        '%  PanelPropClassList, PanelPropColor, PanelPropHandle,'
                        '%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,'
                        '%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,'
                        '%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,'
                        '%  PanelPropString, PanelPropStringList.'
                        ''
                        })
                    g(3, 'switch prop')
                        for i = 1:1:numel(props)
                            if numel(props{i}.gui) > 1 || ~isempty(props{i}.gui{1})
                                g(4, ['case ' class_name '.' props{i}.TAG ' % __' class_name '.' props{i}.TAG '__'])
                                    gs(5, props{i}.gui)
                                g(5, '')
                            end
                        end
                        for i = 1:1:numel(props_update)
                            if numel(props_update{i}.gui) > 1 || ~isempty(props_update{i}.gui{1})
                                g(4, ['case ' class_name '.' props_update{i}.TAG ' % __' class_name '.' props_update{i}.TAG '__'])
                                gs(5, props_update{i}.gui)
                                g(5, '')
                            end
                        end
                        g(4, 'otherwise')
                            gs(5, {['pr = getPanelProp@' superclass_name '(' moniker ', prop, varargin{:});'], ''})
                    g(3, 'end')
                g(2, 'end')
            end            
        g(1, 'end')
    end

generate_gui_static()
    function generate_gui_static()
        if isequal(gui_menu_import, {''}) && isequal(gui_menu_export, {''})
            return
        end
        g(1, 'methods (Static) % GUI static methods')
            if ~isequal(gui_menu_import, {''})
                g(2, 'function getGUIMenuImport(el, menu_import, pe)')
                    gs(3, {
                        '%GETGUIMENUIMPORT sets a figure menu.'
                        '%'
                        '% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu import'
                        '%  which operates on the element EL in the plot element PE.'
                        '%'
                        '% See also getGUIMenuExporter, PlotElement.'
                        ''
                        })
                    gs(3, {
                        'Element.getGUIMenuImport(el, menu_import, pe);'
                        ''
                        })
                    gs(3, gui_menu_import)
                    g(3, '')
                g(2, 'end')
            end
            if ~isequal(gui_menu_export, {''})
                g(2, 'function getGUIMenuExport(el, menu_export, pe)')
                    gs(3, {
                        '%GETGUIMENUEXPORT sets a figure menu.'
                        '%'
                        '% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu export'
                        '%  which operates on the element EL in the plot element PE.'
                        '%'
                        '% See also getGUIMenuImporter, PlotElement.'
                        ''
                        })
                    gs(3, {
                        'Element.getGUIMenuExport(el, menu_export, pe);'
                        ''
                        })
                    gs(3, gui_menu_export)
                    g(3, '')
                g(2, 'end')
            end
        g(1, 'end')
    end

generate_footer()
    function generate_footer()
        g(0, 'end')
    end

%% Save file
target_file = [target_dir filesep() class_name '.m'];
object_file = fopen(target_file, 'w');
fprintf(object_file, file_str);
fclose(object_file);

disp(['¡! saved file: ' target_file])

%% Hard-code constants
if element_created
    hard_code_constants(target_file)

    disp(['¡! hard-coded constants: ' target_file])
end

%% Separator
disp(' ')

%% Help functions
    function g(tabs, str)
        str = regexprep(str, '%', '%%');
        file_str = [file_str repmat('\t', 1, tabs) str '\n'];
    end
    function gs(tabs, lines)
        for i = 1:1:length(lines)
            g(tabs, lines{i})
        end
    end
end