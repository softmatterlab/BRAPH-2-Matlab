function create_test_Element(generator_file, target_dir)
%CREATE_TEST_ELEMENT creates the test of an element.
%
% CREATE_TEST_ELEMENT(FILE, DIR) creates the m-file with the script to test
%  an Element from its generator file FILE (with ending '.gen.m') and saves
%  it in the target directory DIR.
%
% The structure of the generator file can be found in <a href="matlab:help create_Element">create_Element</a>.
%
% See also genesis, create_Element.

txt = fileread(generator_file);

disp(['¡ source file: ' generator_file])
disp(['¡ target dir: ' target_dir])
disp('¡! generator file read')

%% Analysis
[class_name, moniker, build] = analyze_header();
    function [class_name, moniker, build] = analyze_header()
        header = getToken(txt, 'header');
        res = regexp(header, ...
            ['^\s*(?<class_name>\w*)\s*<\s*(?<superclass_name>\w*)' ...
             '\s*\(\s*(?<moniker>\w*)\s*,\s*(?<descriptive_name>[^)]*)\)' ...
             '\s*(?<header_description>[^.]*)\.'], ...
             'names' ...
             );
        class_name = res.class_name;
        moniker = res.moniker;

        build = getToken(txt, 'header', 'build');
    end

prop_number = Element.getPropNumber(class_name);

[excluded_props, warning_off, tests, test_functions] = analyze_tests();
    function [excluded_props, warning_off, tests, test_functions] = analyze_tests()
        excluded_props = getToken(txt, 'tests', 'excluded_props');
        if isempty(excluded_props)
            excluded_props = '[]';
        end

        warning_off = getToken(txt, 'tests', 'warning_off');
        if isempty(warning_off)
            warning_off = false;
        else
            warning_off = true;
        end
        
        tests = getTokens(txt, 'tests', 'test');
        for i = 1:1:numel(tests)
            tests{i}.name = getToken(tests{i}.token, 'name');
            
            tests{i}.probability = getToken(tests{i}.token, 'probability');
            if isempty(tests{i}.probability)
                tests{i}.probability = '1';
            end
            
            tests{i}.code = splitlines(getToken(tests{i}.token, 'code'));
        end
        
        test_functions = splitlines(getToken(txt, 'tests', 'test_functions'));
    end

%% Basic tests
basic_tests{1} = test_inspection_methods();
    function basic_test = test_inspection_methods()
        basic_test.name = 'Inspection Methods';
        basic_test.probability = '.01';
        basic_test.code = {
             'categories = num2cell(Category.getCategories());'
            [moniker ' = ' class_name '();']
             ' '
             '% get(''ELCLASS'')'
            ['if isa(' class_name ', ''ConcreteElement'')']
                ['\t' 'assert(strcmp(' class_name '().get(''ELCLASS''), ''' class_name '''), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' class_name '().get(''''ELCLASS'''') should return ''''' class_name '''''.'')']
             'end'
             ' '
             '% getBuild()'
            ['assert(' class_name '.getBuild() == ' build ' && ' class_name '.getBuild() > 0, ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' class_name '.getBuild() should return the ' class_name ' build number.'')']
            ['assert(' moniker '.getBuild() == ' build ' && ' moniker '.getBuild() > 0 , ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' moniker '.getBuild() should return the ' class_name ' build number.'')']
            ['assert(Element.getBuild(' moniker ') == ' build ' && Element.getBuild(' moniker ') > 0, ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''Element.getBuild(' moniker ') should return the ' class_name ' build number.'')']
            ['assert(Element.getBuild('''  class_name ''') == '  build ' && Element.getBuild('''  class_name ''') > 0, ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''Element.getBuild(''''' class_name ''''') should return the ' class_name ' build number.'')']
             ' '
             '% getClass()'
            ['assert(strcmp(' class_name '.getClass(), ''' class_name '''), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' class_name '.getClass() should return ''''' class_name '''''.'')']
            ['assert(strcmp(' moniker '.getClass(), ''' class_name '''), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' moniker '.getClass() should return ''''' class_name '''''.'')']
            ['assert(strcmp(Element.getClass(' moniker '), ''' class_name '''), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''Element.getClass(' moniker ') should return '''''  class_name '''''.'')']
            ['assert(strcmp(Element.getClass('''  class_name '''), '''  class_name '''), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''Element.getClass(''''' class_name ''''') should return ''''' class_name '''''.'')']
             ' '
             '% getSubclasses()'
            ['assert(isequal(' class_name '.getSubclasses(), subclasses(''' class_name ''', [], [], true)), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' class_name '.getSubclasses() should return the same result as subclasses(''''' class_name ''''', [], [], true).'')']
            ['assert(isequal(' moniker '.getSubclasses(), subclasses(''' class_name ''', [], [], true)), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''el.getSubclasses() should return the same result as subclasses(''''' class_name ''''', [], [], true).'')']
            ['assert(isequal(Element.getSubclasses(' moniker '), subclasses(''' class_name ''', [], [], true)), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''Element.getSubclasses(' moniker ') should return the same result as subclasses(''''' class_name ''''', [], [], true).'')']
            ['assert(isequal(Element.getSubclasses(''' class_name '''), subclasses(''' class_name ''', [], [], true)), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''Element.getSubclasses(''''' class_name ''''') should return the same result as subclasses(''''' class_name ''''', [], [], true).'')']
             ' '
             '% getProps()'
            ['assert(isempty(' class_name '.getProps()) || isequal(' class_name '.getProps(), 1:1:length(' class_name '.getProps())), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' class_name '.getProps() should return a row vector [1:1:N].'')']
            ['assert(isempty(' class_name '.getProps()) || isequal(' moniker '.getProps(), 1:1:length(' class_name '.getProps())), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' moniker '.getProps() should return a row vector [1:1:N].'')']
            ['assert(isempty(' class_name '.getProps()) || isequal(Element.getProps(' moniker '), 1:1:length(' class_name '.getProps())), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''Element.getProps(' moniker ') should return a row vector [1:1:N].'')']
            ['assert(isempty(' class_name '.getProps()) || isequal(Element.getProps(''' class_name '''), 1:1:length(' class_name '.getProps())), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''Element.getProps(''''' class_name ''''') should return a row vector [1:1:N].'')']
             ' '
             '% getProps(category)'
            ['tmp = cellfun(@(category) ' class_name '.getProps(category), categories, ''UniformOutput'', false);']
            ['assert(isempty(' class_name '.getProps()) || isequal(sort(horzcat(tmp{:})), 1:1:length(' class_name '.getProps())), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' class_name '.getProps(category) does not work.'')']
            ['tmp = cellfun(@(category) ' moniker '.getProps(category), categories, ''UniformOutput'', false);']
            ['assert(isempty(' class_name '.getProps()) || isequal(sort(horzcat(tmp{:})), 1:1:length(' class_name '.getProps())), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' moniker '.getProps(category) does not work.'')']
            ['tmp = cellfun(@(category) Element.getProps(' moniker ', category), categories, ''UniformOutput'', false);']
            ['assert(isempty(' class_name '.getProps()) || isequal(sort(horzcat(tmp{:})), 1:1:length(' class_name '.getProps())), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''Element.getProps(' moniker ', category) does not work.'')']
            ['tmp = cellfun(@(category) Element.getProps(''' class_name ''', category), categories, ''UniformOutput'', false);']
            ['assert(isempty(' class_name '.getProps()) || isequal(sort(horzcat(tmp{:})), 1:1:length(' class_name '.getProps())), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''Element.getProps(''''' class_name ''''', category) does not work.'')']
             ' '            
             '% getPropNumber()'
            ['assert(' class_name '.getPropNumber() == length(' class_name '.getProps()), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' class_name '.getPropNumber() should return the number of properties.'')']
            ['assert(' moniker '.getPropNumber() == length(' class_name '.getProps()), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' moniker '.getPropNumber() should return the number of properties.'')']
            ['assert(Element.getPropNumber(' moniker ') == length(' class_name '.getProps()), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''Element.getPropNumber(' moniker ') should return the number of properties.'')']
            ['assert(Element.getPropNumber(''' class_name ''') == length(' class_name '.getProps()), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''Element.getPropNumber(''''' class_name ''''') should return the number of properties.'')']
             ' '
             '% getPropNumber(category)'
            ['assert(sum(cellfun(@(category) ' class_name '.getPropNumber(category), categories)) == ' class_name '.getPropNumber(), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' class_name '.getPropNumber(category) does not work.'')']
            ['assert(sum(cellfun(@(category) ' moniker '.getPropNumber(category), categories)) == ' class_name '.getPropNumber(), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' moniker '.getPropNumber(category) does not work.'')']
            ['assert(sum(cellfun(@(category) Element.getPropNumber(' moniker ', category), categories)) == ' class_name '.getPropNumber(), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''Element.getPropNumber(' moniker ', category) does not work.'')']
            ['assert(sum(cellfun(@(category) Element.getPropNumber(''' class_name ''', category), categories)) == ' class_name '.getPropNumber(), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''Element.getPropNumber(''''' class_name ''''', category) does not work.'')']
             ' '
             '% existsProp(prop)'
            ['assert(~' class_name '.existsProp(NaN), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' class_name '.existsProp(prop) does not work.'')']
            ['assert(~' moniker '.existsProp(NaN), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' moniker '.existsProp(prop) does not work.'')']    
            ['assert(~Element.existsProp(' moniker ', NaN), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''Element.existsProp(' moniker ', prop) does not work.'')']
            ['assert(~Element.existsProp(''' class_name ''', NaN), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''Element.existsProp(''''' class_name ''''', prop) does not work.'')']
             ' '
            ['assert_with_error(''' class_name '.existsProp(NaN)'', [BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT])']
            ['assert_with_error(''varargin{1}.existsProp(NaN)'', [BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT], ' moniker ')']
            ['assert_with_error(''Element.existsProp(varargin{1}, NaN)'', [BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT], ' moniker ')']
            ['assert_with_error(''Element.existsProp(''''' class_name ''''', NaN)'', [BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT])']
             ' '
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'assert(' class_name '.existsProp(prop), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' class_name '.existsProp(prop) does not work.'')']
                ['\t' 'assert(' moniker '.existsProp(prop), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' moniker '.existsProp(prop) does not work.'')']    
                ['\t' 'assert(Element.existsProp(' moniker ', prop), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.existsProp(' moniker ', prop) does not work.'')']
                ['\t' 'assert(Element.existsProp(''' class_name ''', prop), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.existsProp(''''' class_name ''''', prop) does not work.'')']
             'end'
             ' '
             '% existsTag(tag)'
            ['assert(~' class_name '.existsTag(''''), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' class_name '.existsTag(tag) does not work.'')']
            ['assert(~' moniker '.existsTag(''''), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' moniker '.existsTag(tag) does not work.'')']    
            ['assert(~Element.existsTag(' moniker ', ''''), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''Element.existsTag(' moniker ', tag) does not work.'')']
            ['assert(~Element.existsTag(''' class_name ''', ''''), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''Element.existsTag(''''' class_name ''''', tag) does not work.'')']
             ' '
            ['assert_with_error(''' class_name '.existsTag('''''''')'', [BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT])']
            ['assert_with_error(''varargin{1}.existsTag('''''''')'', [BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT], ' moniker ')']
            ['assert_with_error(''Element.existsTag(varargin{1}, '''''''')'', [BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT], ' moniker ')']
            ['assert_with_error(''Element.existsTag(''''' class_name ''''', '''''''')'', [BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT])']
             ' '
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'tag = ' moniker '.getPropTag(prop);']
                ['\t' 'assert(' class_name '.existsTag(tag), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' class_name '.existsTag(tag) does not work.'')']
                ['\t' 'assert(' moniker '.existsTag(tag), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' moniker '.existsTag(tag) does not work.'')']    
                ['\t' 'assert(Element.existsTag(' moniker ', tag), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.existsTag(' moniker ', tga) does not work.'')']
                ['\t' 'assert(Element.existsTag(''' class_name ''', tag), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.existsTag(''''' class_name ''''', tag) does not work.'')']
             'end'
             ' '
             '% getPropProp(pointer)'
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'assert(' class_name '.getPropProp(prop) == prop, ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' class_name '.getPropProp(prop) does not work.'')']
                ['\t' 'assert(' moniker '.getPropProp(prop) == prop, ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' moniker '.getPropProp(prop) does not work.'')']
                ['\t' 'assert(Element.getPropProp(' moniker ', prop) == prop, ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropProp(' moniker ', prop) does not work.'')']
                ['\t' 'assert(Element.getPropProp(''' class_name ''', prop) == prop, ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropProp(''''' class_name ''''', prop) does not work.'')']
                 ' '
                ['\t' 'tag = ' moniker '.getPropTag(prop);']
                ['\t' 'assert(' class_name '.getPropProp(tag) == prop, ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' class_name '.getPropProp(tag) does not work.'')']
                ['\t' 'assert(' moniker '.getPropProp(tag) == prop, ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' moniker '.getPropProp(tag) does not work.'')']
                ['\t' 'assert(Element.getPropProp(' moniker ', tag) == prop, ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropProp(' moniker ', tag) does not work.'')']
                ['\t' 'assert(Element.getPropProp(''' class_name ''', prop) == prop, ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropProp(''''' class_name ''''', tag) does not work.'')']
             'end'
             ' '
             '% getPropTag(pointer)'
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'tag = ' moniker '.getPropTag(prop);']
                 ' '
                ['\t' 'assert(strcmp(' class_name '.getPropTag(prop), tag), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' class_name '.getPropTag(prop) does not work.'')']
                ['\t' 'assert(strcmp(' moniker '.getPropTag(prop), tag), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' moniker '.getPropTag(prop) does not work.'')']
                ['\t' 'assert(strcmp(Element.getPropTag(' moniker ', prop), tag), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropTag(' moniker ', prop) does not work.'')']
                ['\t' 'assert(strcmp(Element.getPropTag(''' class_name ''', prop), tag), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropTag(''''' class_name ''''', prop) does not work.'')']
                 ' '
                ['\t' 'assert(strcmp(' class_name '.getPropTag(tag), tag), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' class_name '.getPropTag(tag) does not work.'')']
                ['\t' 'assert(strcmp(' moniker '.getPropTag(tag), tag), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' moniker '.getPropTag(tag) does not work.'')']
                ['\t' 'assert(strcmp(Element.getPropTag(' moniker ', tag), tag), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropTag(' moniker ', tag) does not work.'')']
                ['\t' 'assert(strcmp(Element.getPropTag(''' class_name ''', prop), tag), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropTag(''''' class_name ''''', tag) does not work.'')']
             'end'
             ' '
             '% getPropCategory(pointer)'
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'tag = ' moniker '.getPropTag(prop);']
                 ' '
                ['\t' 'assert(Category.existsCategory(' class_name '.getPropCategory(prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' class_name '.getPropCategory(prop) does not work.'')']
                ['\t' 'assert(Category.existsCategory(' moniker '.getPropCategory(prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' moniker '.getPropCategory(prop) does not work.'')']
                ['\t' 'assert(Category.existsCategory(Element.getPropCategory(' moniker ', prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropCategory(' moniker ', prop) does not work.'')']
                ['\t' 'assert(Category.existsCategory(Element.getPropCategory(' moniker ', prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropCategory(''''' class_name ''''', prop) does not work.'')']
                 ' '
                ['\t' 'assert(Category.existsCategory(' class_name '.getPropCategory(tag)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' class_name '.getPropCategory(tag) does not work.'')']
                ['\t' 'assert(Category.existsCategory(' moniker '.getPropCategory(tag)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' moniker '.getPropCategory(tag) does not work.'')']
                ['\t' 'assert(Category.existsCategory(Element.getPropCategory(' moniker ', tag)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropCategory(' moniker ', tag) does not work.'')']
                ['\t' 'assert(Category.existsCategory(Element.getPropCategory(' moniker ', tag)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropCategory(''''' class_name ''''', tag) does not work.'')']
             'end'
             ' '
             '% getPropFormat(pointer)'
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'tag = ' moniker '.getPropTag(prop);']
                 ' '
                ['\t' 'assert(Format.existsFormat(' class_name '.getPropFormat(prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' class_name '.getPropFormat(prop) does not work.'')']
                ['\t' 'assert(Format.existsFormat(' moniker '.getPropFormat(prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' moniker '.getPropFormat(prop) does not work.'')']
                ['\t' 'assert(Format.existsFormat(Element.getPropFormat(' moniker ', prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropFormat(' moniker ', prop) does not work.'')']
                ['\t' 'assert(Format.existsFormat(Element.getPropFormat(' moniker ', prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropFormat(''''' class_name ''''', prop) does not work.'')']
                 ' '
                ['\t' 'assert(Format.existsFormat(' class_name '.getPropFormat(tag)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' class_name '.getPropFormat(tag) does not work.'')']
                ['\t' 'assert(Format.existsFormat(' moniker '.getPropFormat(tag)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' moniker '.getPropFormat(tag) does not work.'')']
                ['\t' 'assert(Format.existsFormat(Element.getPropFormat(' moniker ', tag)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropFormat(' moniker ', tag) does not work.'')']
                ['\t' 'assert(Format.existsFormat(Element.getPropFormat(' moniker ', tag)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropFormat(''''' class_name ''''', tag) does not work.'')']
             'end'
             ' '
             '% getPropDescription(pointer)'
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'tag = ' moniker '.getPropTag(prop);']
                 ' '
                ['\t' 'assert(ischar(' class_name '.getPropDescription(prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' class_name '.getPropDescription(prop) does not work.'')']
                ['\t' 'assert(ischar(' moniker '.getPropDescription(prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' moniker '.getPropDescription(prop) does not work.'')']
                ['\t' 'assert(ischar(Element.getPropDescription(' moniker ', prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropDescription(' moniker ', prop) does not work.'')']
                ['\t' 'assert(ischar(Element.getPropDescription(' moniker ', prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropDescription(''''' class_name ''''', prop) does not work.'')']
                 ' '
                ['\t' 'assert(ischar(' class_name '.getPropDescription(tag)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' class_name '.getPropDescription(tag) does not work.'')']
                ['\t' 'assert(ischar(' moniker '.getPropDescription(tag)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' moniker '.getPropDescription(tag) does not work.'')']
                ['\t' 'assert(ischar(Element.getPropDescription(' moniker ', tag)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropDescription(' moniker ', tag) does not work.'')']
                ['\t' 'assert(ischar(Element.getPropDescription(' moniker ', tag)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.getPropDescription(''''' class_name ''''', tag) does not work.'')']
             'end'
             ' '
             '% getPropSettings(pointer)'
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'tag = ' moniker '.getPropTag(prop);']
                 ' '
                ['\t' 'settings = ' class_name '.getPropSettings(prop);']
                ['\t' 'settings = ' moniker '.getPropSettings(prop);']
                ['\t' 'settings = Element.getPropSettings(' moniker ', prop);']
                ['\t' 'settings = Element.getPropSettings(''' class_name ''', prop);']
                 ' '
                ['\t' 'settings = ' class_name '.getPropSettings(tag);']
                ['\t' 'settings = ' moniker '.getPropSettings(tag);']
                ['\t' 'settings = Element.getPropSettings(' moniker ', tag);']
                ['\t' 'settings = Element.getPropSettings(''' class_name ''', tag);']
             'end'
             ' '
             '% getPropDefault(pointer)'
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'tag = ' moniker '.getPropTag(prop);']
                 ' '
                ['\t' 'default = ' class_name '.getPropDefault(prop);']
                ['\t' 'default = ' moniker '.getPropDefault(prop);']
                ['\t' 'default = Element.getPropDefault(' moniker ', prop);']
                ['\t' 'default = Element.getPropDefault(''' class_name ''', prop);']
                 ' '
                ['\t' 'default = ' class_name '.getPropDefault(tag);']
                ['\t' 'default = ' moniker '.getPropDefault(tag);']
                ['\t' 'default = Element.getPropDefault(' moniker ', tag);']
                ['\t' 'default = Element.getPropDefault(''' class_name ''', tag);']
             'end'
             ' '
             '% getPropDefaultConditioned(pointer)'
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'tag = ' moniker '.getPropTag(prop);']
                 ' '
                ['\t' 'conditioned_default = ' class_name '.getPropDefaultConditioned(prop);']
                ['\t' 'conditioned_default = ' moniker '.getPropDefaultConditioned(prop);']
                ['\t' 'conditioned_default = Element.getPropDefaultConditioned(' moniker ', prop);']
                ['\t' 'conditioned_default = Element.getPropDefaultConditioned(''' class_name ''', prop);']
                 ' '
                ['\t' 'conditioned_default = ' class_name '.getPropDefaultConditioned(tag);']
                ['\t' 'conditioned_default = ' moniker '.getPropDefaultConditioned(tag);']
                ['\t' 'conditioned_default = Element.getPropDefaultConditioned(' moniker ', tag);']
                ['\t' 'conditioned_default = Element.getPropDefaultConditioned(''' class_name ''', tag);']
             'end'
             ' '
             '% checkProp(pointer, value)'
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'tag = ' moniker '.getPropTag(prop);']
                 ' '
                ['\t' 'assert(~' class_name '.checkProp(prop, {''probably wrong value'', 1}), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' class_name '.checkProp(prop, value) does not work.'')']
                ['\t' 'assert(~' moniker '.checkProp(prop, {''probably wrong value'', 1}), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' moniker '.checkProp(prop, value) does not work.'')']
                ['\t' 'assert(~Element.checkProp(' moniker ', prop, {''probably wrong value'', 1}), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.checkProp(' moniker ', prop, value) does not work.'')']
                ['\t' 'assert(~Element.checkProp(''' class_name ''', prop, {''probably wrong value'', 1}), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.checkProp(''''' class_name ''''', prop, value) does not work.'')']
                 ' '
                ['\t' 'assert_with_error(''' class_name '.checkProp(varargin{1}, {''''probably wrong value'''', 1})'', [BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT], prop)']
                ['\t' 'assert_with_error(''varargin{2}.checkProp(varargin{1}, {''''probably wrong value'''', 1})'', [BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT], prop, ' moniker ')']
                ['\t' 'assert_with_error(''Element.checkProp(varargin{2}, varargin{1}, {''''probably wrong value'''', 1})'', [BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT], prop, ' moniker ')']
                ['\t' 'assert_with_error(''Element.checkProp(''''' class_name ''''', varargin{1}, {''''probably wrong value'''', 1})'', [BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT], prop)']
                 ' '
                ['\t' 'assert(~' class_name '.checkProp(tag, {''probably wrong value'', 1}), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' class_name '.checkProp(tag, value) does not work.'')']
                ['\t' 'assert(~' moniker '.checkProp(tag, {''probably wrong value'', 1}), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' moniker '.checkProp(tag, value) does not work.'')']
                ['\t' 'assert(~Element.checkProp(' moniker ', tag, {''probably wrong value'', 1}), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.checkProp(' moniker ', tag, value) does not work.'')']
                ['\t' 'assert(~Element.checkProp(''' class_name ''', tag, {''probably wrong value'', 1}), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.checkProp(''''' class_name ''''', tag, value) does not work.'')']
                 ' '
                ['\t' 'assert_with_error(''' class_name '.checkProp(varargin{1}, {''''probably wrong value'''', 1})'', [BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT], tag)']
                ['\t' 'assert_with_error(''varargin{2}.checkProp(varargin{1}, {''''probably wrong value'''', 1})'', [BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT], tag, ' moniker ')']
                ['\t' 'assert_with_error(''Element.checkProp(varargin{2}, varargin{1}, {''''probably wrong value'''', 1})'', [BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT], tag, ' moniker ')']
                ['\t' 'assert_with_error(''Element.checkProp(''''' class_name ''''', varargin{1}, {''''probably wrong value'''', 1})'', [BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT], tag)']
                 ' '
                ['\t' 'assert(' class_name '.checkProp(prop, Element.getPropDefaultConditioned(' class_name ', prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' class_name '.checkProp(prop, <conditioned default value>) does not work.'')']
                ['\t' 'assert(' moniker '.checkProp(prop, Element.getPropDefaultConditioned(' class_name ', prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' moniker '.checkProp(prop, <conditioned default value>) does not work.'')']
                ['\t' 'assert(Element.checkProp(' moniker ', prop, Element.getPropDefaultConditioned(' class_name ', prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.checkProp(' moniker ', prop, <conditioned default value>) does not work.'')']
                ['\t' 'assert(Element.checkProp(''' class_name ''', prop, Element.getPropDefaultConditioned(' class_name ', prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.checkProp(''''' class_name ''''', prop, <conditioned default value>) does not work.'')']
                 ' '
                ['\t' 'assert(' class_name '.checkProp(tag, Element.getPropDefaultConditioned(' class_name ', prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' class_name '.checkProp(tag, <conditioned default value>) does not work.'')']
                ['\t' 'assert(' moniker '.checkProp(tag, Element.getPropDefaultConditioned(' class_name ', prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' moniker '.checkProp(tag, <conditioned default value>) does not work.'')']
                ['\t' 'assert(Element.checkProp(' moniker ', tag, Element.getPropDefaultConditioned(' class_name ', prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.checkProp(' moniker ', tag, <conditioned default value>) does not work.'')']
                ['\t' 'assert(Element.checkProp(''' class_name ''', tag, Element.getPropDefaultConditioned(' class_name ', prop)), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''Element.checkProp(''''' class_name ''''', tag, <conditioned default value>) does not work.'')']
                 ' '
            'end'
            ' '
            };
    end

basic_tests{end+1} = test_instantation_defaults();
    function basic_test = test_instantation_defaults()
        basic_test.name = 'Instantiation - defaults';
        basic_test.probability = '.01';
        
        if strcmp(class_name, 'Callback') || strcmp(class_name, 'NoValue')
            basic_test.code = {'% this test is not implemented for Callback and NoValue'};
            return
        end
        
        basic_test.code = {
            [moniker ' = ' class_name '( ...']
            };
            for prop = 1:1:prop_number
                TAG = upper(Element.getPropTag(class_name, prop));
                switch Element.getPropCategory(class_name, prop)
                    case Category.CONSTANT
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getNoValue()'];
                    case {Category.RESULT, Category.QUERY, Category.EVANESCENT}
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getNoValue()'];
                    otherwise % {Category.METADATA, Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ')'];
                end
                if prop < prop_number
                    basic_test.code{end} = [basic_test.code{end} ', ...'];
                else
                    basic_test.code{end} = [basic_test.code{end} ' ...'];
                end
            end
        basic_test.code = [reshape(basic_test.code, [], 1)
                ['\t' ');']
             ' '
            ['for prop = 1:1:' class_name '.getPropNumber()']
                 ' '
                ['\t' '% excluded props']
                ['\t' 'if any(prop == ' excluded_props ')']
                    ['\t\t' 'continue']
                ['\t' 'end']
                 ' '
                ['\t' 'TAG = upper(' class_name '.getPropTag(prop));']
                ['\t' 'switch ' class_name '.getPropCategory(prop)']
                    ['\t\t' 'case {Category.CONSTANT, Category.RESULT, Category.QUERY}']
                        ['\t\t\t' '% getr']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' moniker '.getr(prop) == ' class_name '.getNoValue(), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''Being a '' ' class_name '.getCategoryName(' class_name '.getPropCategory(prop)) '', ' class_name '.getr('' int2str(prop) '') must be inizialized to NoValue(). '' ...']
                            ['\t\t\t\t' '''Or there could be an error in ' class_name '.getr('' int2str(prop) '').''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' moniker '.getr(TAG) == ' class_name '.getNoValue(), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''Being a '' ' class_name '.getCategoryName(' class_name '.getPropCategory(prop)) '', ' class_name '.getr('' TAG '') must be inizialized to NoValue(). '' ...']
                            ['\t\t\t\t' '''Or there could be an error in ' class_name '.getr('' TAG '').''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' '% get']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' '~isa(' moniker '.get(prop), ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.get('' int2str(prop) '') must NOT be a NoValue, because it should have been calculated.''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'if isempty(' moniker '.getPropSettings(prop))']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' moniker '.checkFormat(' moniker '.getPropFormat(prop), ' moniker '.get(prop)), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '[''' class_name '.get('' int2str(prop) '') returns a value with the wrong format.''] ...']
                                ['\t\t\t\t\t' ')']
                        ['\t\t\t' 'else']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' moniker '.checkFormat(' moniker '.getPropFormat(prop), ' moniker '.get(prop), ' moniker '.getPropSettings(prop)), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '[''' class_name '.get('' int2str(prop) '') returns a value with the wrong format.''] ...']
                                ['\t\t\t\t\t' ')']
                        ['\t\t\t' 'end']
                   ['\t\t' 'case Category.EVANESCENT']
                        ['\t\t\t' '% getr']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' moniker '.getr(prop) == ' class_name '.getNoValue(), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''Being a '' ' class_name '.getCategoryName(' class_name '.getPropCategory(prop)) '', ' class_name '.getr('' int2str(prop) '') must be inizialized to NoValue(). '' ...']
                            ['\t\t\t\t' '''Or there could be an error in ' class_name '.getr('' int2str(prop) '').''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' moniker '.getr(TAG) == ' class_name '.getNoValue(), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''Being a '' ' class_name '.getCategoryName(' class_name '.getPropCategory(prop)) '', ' class_name '.getr('' TAG '') must be inizialized to NoValue(). '' ...']
                            ['\t\t\t\t' '''Or there could be an error in ' class_name '.getr('' TAG '').''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' '% get']
                        ['\t\t\t' 'warning_backup = warning(''off'', [BRAPH2.STR '':' class_name ''']);']                        
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' '~isa(' moniker '.get(prop), ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.get('' int2str(prop) '') must NOT be a NoValue, because it should have been calculated.''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'if isempty(' moniker '.getPropSettings(prop))']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' moniker '.checkFormat(' moniker '.getPropFormat(prop), ' moniker '.get(prop)), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '[''' class_name '.get('' int2str(prop) '') returns a value with the wrong format.''] ...']
                                ['\t\t\t\t\t' ')']
                        ['\t\t\t' 'else']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' moniker '.checkFormat(' moniker '.getPropFormat(prop), ' moniker '.get(prop), ' moniker '.getPropSettings(prop)), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '[''' class_name '.get('' int2str(prop) '') returns a value with the wrong format.''] ...']
                                ['\t\t\t\t\t' ')']
                        ['\t\t\t' 'end']
                        ['\t\t\t' 'warning(warning_backup)']
                    ['\t\t' 'otherwise % case {Category.METADATA, Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isequal(' moniker '.getr(prop), ' class_name '.getPropDefaultConditioned(prop)), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must be inizialized to its default value '' ...']
                            ['\t\t\t\t' '''given by ' class_name '.getPropDefaultConditioned('' int2str(prop) ''). '' ...']
                            ['\t\t\t\t' '''Or there could be an error in ' class_name '.getr('' int2str(prop) '').''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isequal(' moniker '.getr(TAG), ' class_name '.getPropDefaultConditioned(prop)), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' TAG '') must be inizialized to its default value '' ...']
                            ['\t\t\t\t' '''given by ' class_name '.getPropDefaultConditioned('' int2str(prop) ''). '' ...']
                            ['\t\t\t\t' '''Or there could be an error in ' class_name '.getr('' TAG '').''] ...']
                            ['\t\t\t\t'  ')']
                ['\t' 'end']
            'end'
            ];
    end

basic_tests{end+1} = test_memorize();
    function basic_test = test_memorize()
        basic_test.name = 'Memorize';
        basic_test.probability = '.01';

        if strcmp(class_name, 'Callback') || strcmp(class_name, 'NoValue')
            basic_test.code = {'% this test is not implemented for Callback and NoValue'};
            return
        end

        basic_test.code = {
            [moniker ' = ' class_name '( ...']
            };
            for prop = 1:1:prop_number
                TAG = upper(Element.getPropTag(class_name, prop));
                switch Element.getPropCategory(class_name, prop)
                    case Category.CONSTANT
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getNoValue()'];
                    case {Category.RESULT, Category.QUERY, Category.EVANESCENT}
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getNoValue()'];
                    otherwise % {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ')'];
                end
                if prop < prop_number
                    basic_test.code{end} = [basic_test.code{end} ', ...'];
                else
                    basic_test.code{end} = [basic_test.code{end} ' ...'];
                end
            end
        basic_test.code = [reshape(basic_test.code, [], 1)
                ['\t' ');']
             ' '
            ['for prop = 1:1:' class_name '.getPropNumber()']
                 ' '
                ['\t' '% excluded props']
                ['\t' 'if any(prop == ' excluded_props ')']
                    ['\t\t' 'continue']
                ['\t' 'end']
                 ' '
                ['\t' 'TAG = upper(' class_name '.getPropTag(prop));']
                ['\t' 'switch ' class_name '.getPropCategory(prop)']
                	['\t\t' 'case Category.RESULT']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' '~isa(' moniker '.get(prop), ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.get('' int2str(prop) '') must NOT be a NoValue, because it should have been calculated.''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isa(' moniker '.getr(prop), ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must be a NoValue, because it should NOT have been memorized.''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' '~isa(' moniker '.memorize(prop), ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.memorize('' int2str(prop) '') must NOT be a NoValue, because it should have been calculated.''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' '~isa(' moniker '.getr(prop), ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must NOT be a NoValue, because it should have been memorized.''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' moniker '.checkFormat(' moniker '.getPropFormat(prop), ' moniker '.getr(prop),' moniker '.getPropSettings(prop)), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') returns a value with the wrong format.''] ...']
                            ['\t\t\t\t' ')']
                    ['\t\t' 'case Category.QUERY']
                        ['% \t\t\t' 'warning_backup = warning(''off'', [BRAPH2.STR '':' class_name ''']);']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' '~isa(' moniker '.get(prop), ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.get('' int2str(prop) '') must NOT be a NoValue, because it should have been calculated.''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isa(' moniker '.getr(prop), ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must be a NoValue, because it should NOT have been memorized.''] ...']
                            ['\t\t\t\t' ')']
                         '% following tests excluded because properties QUERY should not be memorized'
                        ['% \t\t\t' 'warning_backup = warning(''off'', [BRAPH2.STR '':' class_name ''']);']
                        ['% \t\t\t' 'assert( ...']
                            ['% \t\t\t\t' '~isa(' moniker '.memorize(prop), ''NoValue''), ...']
                            ['% \t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['% \t\t\t\t' '[''' class_name '.memorize('' int2str(prop) '') must NOT be a NoValue, because it should have been calculated.''] ...']
                            ['% \t\t\t\t' ')']
                        ['% \t\t\t' 'warning(warning_backup)']
                        ['% \t\t\t' 'assert( ...']
                            ['% \t\t\t\t' '~isa(' moniker '.getr(prop), ''NoValue''), ...']
                            ['% \t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['% \t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must NOT be a NoValue, because it should have been memorized.''] ...']
                            ['% \t\t\t\t' ')']
                        ['% \t\t\t' 'assert( ...']
                            ['% \t\t\t\t' moniker '.checkFormat(' moniker '.getPropFormat(prop), ' moniker '.getr(prop),' moniker '.getPropSettings(prop)), ...']
                            ['% \t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['% \t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') returns a value with the wrong format.''] ...']
                            ['% \t\t\t\t' ')']
                        ['% \t\t\t' 'warning(warning_backup)']
                	['\t\t' 'case Category.EVANESCENT']
                        ['\t\t\t' 'warning_backup = warning(''off'', [BRAPH2.STR '':' class_name ''']);']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' '~isa(' moniker '.get(prop), ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.get('' int2str(prop) '') must NOT be a NoValue, because it should have been calculated.''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'warning(warning_backup)']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isa(' moniker '.getr(prop), ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must be a NoValue, because it should NOT have been memorized.''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' '~isa(' moniker '.memorize(prop), ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.memorize('' int2str(prop) '') must NOT be a NoValue, because it should have been calculated.''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' '~isa(' moniker '.getr(prop), ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must NOT be a NoValue, because it should have been memorized.''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' moniker '.checkFormat(' moniker '.getPropFormat(prop), ' moniker '.getr(prop),' moniker '.getPropSettings(prop)), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') returns a value with the wrong format.''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'if ' moniker '.getPropFormat(prop) == Format.HANDLE']
                            ['\t\t\t\t' 'warning_backup = warning(''off'', ''' BRAPH2.STR ':' class_name ''');']
                            ['\t\t\t\t' 'delete(ancestor(' moniker '.get(prop), ''figure''))']
                            ['\t\t\t\t' 'warning(warning_backup)']
                        ['\t\t\t' 'end']
                    ['\t' 'end']
             'end'
             ' '
            ['if ~isempty(' class_name '.getProps(Category.RESULT))']
                ['\t' 'for prop = 1:1:' class_name '.getPropNumber()']
                     ' '
                    ['\t\t' '% excluded props']
                    ['\t\t' 'if any(prop == ' excluded_props ')']
                        ['\t\t\t' 'continue']
                    ['\t\t' 'end']
                     ' '
                    ['\t\t' 'switch ' class_name '.getPropCategory(prop)']
                        ['\t\t\t' 'case {Category.PARAMETER, Category.DATA}']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' moniker '.isLocked(prop), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '[''' class_name '.isLocked('' int2str(prop) '') must be locked because a result has been calculated.''] ...']
                                ['\t\t\t\t\t' ')']
                        ['\t\t\t' 'otherwise']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' '~' moniker '.isLocked(prop), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '[''' class_name '.isLocked('' int2str(prop) '') must NOT be locked even though a result has been calculated.''] ...']
                                ['\t\t\t\t\t' ')']
                    ['\t\t' 'end']
                ['\t' 'end']
             'end'
            ];
    end

basic_tests{end+1} = test_lock_1();
    function basic_test = test_lock_1()
        basic_test.name = 'Lock 1';
        basic_test.probability = '.01';
        basic_test.code = {
            [moniker ' = ' class_name '();']
             ' '
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'TAG = upper(' class_name '.getPropTag(prop));']
                ['\t' 'assert( ...']
                    ['\t\t' '~' moniker '.isLocked(prop), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '[''' class_name '.isLocked('' int2str(prop) '') must NOT be locked when it is instantiated.''] ...']
                    ['\t\t' ')']
                ['\t' 'assert( ...']
                    ['\t\t' '~' moniker '.isLocked(TAG), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '[''' class_name '.isLocked('' TAG '') must NOT be locked when it is instantiated.''] ...']
                    ['\t\t' ')']
             'end'
             ' '
            [moniker '.lock()']
             ' '
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'switch ' class_name '.getPropCategory(prop)']
                	['\t\t' 'case {Category.PARAMETER, Category.DATA}']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' moniker '.isLocked(prop), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.isLocked('' int2str(prop) '') must be locked because the element is now locked.''] ...']
                            ['\t\t\t\t' ')']
                	['\t\t' 'case {Category.CONSTANT, Category.METADATA, Category.RESULT, Category.QUERY, Category.EVANESCENT, Category.FIGURE, Category.GUI}']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' '~' moniker '.isLocked(prop), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.isLocked('' int2str(prop) '') must NOT be locked even though the element is now locked.''] ...']
                            ['\t\t\t\t' ')']
                ['\t' 'end']
             'end'
            };
    end

basic_tests{end+1} = test_lock_2();
    function basic_test = test_lock_2()
        basic_test.name = 'Lock 2';
        basic_test.probability = '.01';
        basic_test.code = {
            [moniker ' = ' class_name '();']
             ' '
            ['warning_backup = warning(''off'', ''' BRAPH2.STR ':' class_name ''');']
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' moniker '.lock(prop)']
                ['\t' 'switch ' class_name '.getPropCategory(prop)']
                    ['\t\t' 'case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' moniker '.isLocked(prop), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.isLocked('' int2str(prop) '') must be locked.''] ...']
                            ['\t\t\t\t' ')']
                    ['\t\t' 'case {Category.CONSTANT, Category.METADATA, Category.RESULT, Category.QUERY, Category.EVANESCENT}']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' '~' moniker '.isLocked(prop), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.isLocked('' int2str(prop) '') must NOT be locked even though locking has been attempted.''] ...']
                            ['\t\t\t\t' ')']
                ['\t' 'end']
            'end'
            'warning(warning_backup)'
            };
    end

basic_tests{end+1} = test_check();
    function basic_test = test_check()
        basic_test.name = 'Check';
        basic_test.probability = '.01';
        basic_test.code = {
            [moniker ' = ' class_name '();']
             ' '
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'TAG = upper(' class_name '.getPropTag(prop));']
                ['\t' 'assert( ...']
                    ['\t\t' moniker '.isChecked(prop), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '[''' class_name '.isChecked('' int2str(prop) '') must be checked when it is instantiated.''] ...']
                    ['\t\t' ')']
                ['\t' 'assert( ...']
                    ['\t\t' moniker '.isChecked(TAG), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '[''' class_name '.isChecked('' TAG '') must be checked when it is instantiated.''] ...']
                    ['\t\t' ')']
             'end'
             ' '
            [moniker '.unchecked()']
             ' '
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'assert( ...']
                    ['\t\t' '~' moniker '.isChecked(prop), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '[''' class_name '.isChecked('' int2str(prop) '') must NOT be checked because it has been set to unchecked.''] ...']
                    ['\t\t' ')']
             'end'
             ' '
            [moniker '.checked()']
             ' '
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'assert( ...']
                    ['\t\t' moniker '.isChecked(prop), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '[''' class_name '.isChecked('' int2str(prop) '') must be checked because it has been set to checked.''] ...']
                    ['\t\t' ')']
             'end'
            };
    end

basic_tests{end+1} = test_callbacks();
    function basic_test = test_callbacks()
        basic_test.name = 'Callbacks';
        basic_test.probability = '.01';

        if strcmp(class_name, 'Callback') || strcmp(class_name, 'NoValue')
            basic_test.code = {'% this test is not implemented for Callback and NoValue'};
            return
        end

        % element
        basic_test.code = {
            ['% basic ' class_name]
            [moniker '_0 = ' class_name '( ...']
            };
            for prop = 1:1:prop_number
                TAG = upper(Element.getPropTag(class_name, prop));
                switch Element.getPropCategory(class_name, prop)
                    case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ')'];
                    case {Category.METADATA}
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ')'];
                    otherwise
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getNoValue()'];
                end
                if prop < prop_number
                    basic_test.code{end} = [basic_test.code{end} ', ...'];
                else
                    basic_test.code{end} = [basic_test.code{end} ' ...'];
                end
            end
        basic_test.code = [reshape(basic_test.code, [], 1)
                ['\t' ');']
             ' '
            ];

        % element with 1st callbacks
        basic_test.code = [reshape(basic_test.code, [], 1)
            ['% ' class_name ' with 1st callbacks']
            [moniker '_1 = ' class_name '( ...']
            ];
            for prop = 1:1:prop_number
                TAG = upper(eval([class_name '.getPropTag(' int2str(prop) ')']));
                switch eval([class_name '.getPropCategory(' int2str(prop) ')'])
                    case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
                        if prop < prop_number
                            basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' moniker '_0.getCallback(' int2str(prop) '), ...'];
                        else
                            basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' moniker '_0.getCallback(' int2str(prop) ') ...'];
                        end
                        case {Category.METADATA}
                            basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ')'];
                        otherwise
                            basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getNoValue()'];
                end
                if prop < prop_number
                    basic_test.code{end} = [basic_test.code{end} ', ...'];
                else
                    basic_test.code{end} = [basic_test.code{end} ' ...'];
                end
            end
        basic_test.code = [reshape(basic_test.code, [], 1)
                ['\t' ');']
             ' '
            ];

        basic_test.code = [reshape(basic_test.code, [], 1)
            ['prop_number = ' class_name '.getPropNumber();']
            'for prop = 1:1:prop_number'
                ['\t' 'TAG = upper(' class_name '.getPropTag(prop));']
                ['\t' 'switch ' class_name '.getPropCategory(prop)']
                    ['\t\t' 'case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isa(' moniker '_1.getr(prop), ''Callback''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must be a callback.''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isequal(' moniker '_1.get(prop), ' moniker '_0.get(prop)) && ~isa(' moniker '_1.get(prop), ''Callback''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.get('' int2str(prop) '') must be the actual property and NOT a callback.''] ...']
                            ['\t\t\t\t' ')']
                    ['\t\t' 'otherwise']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' '~isa(' moniker '_1.getr(prop), ''Callback''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must NOT be a callback.''] ...']
                            ['\t\t\t\t' ')']
                ['\t' 'end']
             'end'
             ' '
            ];
        
        % element with 2nd callbacks
        basic_test.code = [reshape(basic_test.code, [], 1)
            ['% ' class_name ' with 2nd callbacks']
            [moniker '_2 = ' class_name '( ...']
            ];
            for prop = 1:1:prop_number
                TAG = upper(eval([class_name '.getPropTag(' int2str(prop) ')']));
                switch eval([class_name '.getPropCategory(' int2str(prop) ')'])
                    case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
                        if prop < prop_number
                            basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' moniker '_1.getCallback(' int2str(prop) '), ...'];
                        else
                            basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' moniker '_1.getCallback(' int2str(prop) ') ...'];
                        end
                        case {Category.METADATA}
                            basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ')'];
                        otherwise
                            basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getNoValue()'];
                end
                if prop < prop_number
                    basic_test.code{end} = [basic_test.code{end} ', ...'];
                else
                    basic_test.code{end} = [basic_test.code{end} ' ...'];
                end
            end
        basic_test.code = [reshape(basic_test.code, [], 1)
                ['\t' ');']
             ' '
            ];

        basic_test.code = [reshape(basic_test.code, [], 1)
            ['prop_number = ' class_name '.getPropNumber();']
            'for prop = 1:1:prop_number'
                ['\t' 'TAG = upper(' class_name '.getPropTag(prop));']
                ['\t' 'switch ' class_name '.getPropCategory(prop)']
                    ['\t\t' 'case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isa(' moniker '_2.getr(prop), ''Callback''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must be a callback.''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isequal(' moniker '_2.get(prop), ' moniker '_0.get(prop)) && ~isa(' moniker '_1.get(prop), ''Callback''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.get('' int2str(prop) '') must be the actual property and NOT a callback.''] ...']
                            ['\t\t\t\t' ')']
                    ['\t\t' 'otherwise']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' '~isa(' moniker '_2.getr(prop), ''Callback''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must NOT be a callback.''] ...']
                            ['\t\t\t\t' ')']
                ['\t' 'end']
             'end'
             ' '
            ];

        % element with 3rd callbacks
        basic_test.code = [reshape(basic_test.code, [], 1)
            ['% ' class_name ' with 3rd callbacks']
            [moniker '_3 = ' class_name '( ...']
            ];
            for prop = 1:1:prop_number
                TAG = upper(eval([class_name '.getPropTag(' int2str(prop) ')']));
                switch eval([class_name '.getPropCategory(' int2str(prop) ')'])
                    case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
                        if prop < prop_number
                            basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' moniker '_2.getCallback(' int2str(prop) '), ...'];
                        else
                            basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' moniker '_2.getCallback(' int2str(prop) ') ...'];
                        end
                        case {Category.METADATA}
                            basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ')'];
                        otherwise
                            basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getNoValue()'];
                end
                if prop < prop_number
                    basic_test.code{end} = [basic_test.code{end} ', ...'];
                else
                    basic_test.code{end} = [basic_test.code{end} ' ...'];
                end
            end
        basic_test.code = [reshape(basic_test.code, [], 1)
                ['\t' ');']
             ' '
            ];

        basic_test.code = [reshape(basic_test.code, [], 1)
            ['prop_number = ' class_name '.getPropNumber();']
            'for prop = 1:1:prop_number'
                ['\t' 'TAG = upper(' class_name '.getPropTag(prop));']
                ['\t' 'switch ' class_name '.getPropCategory(prop)']
                    ['\t\t' 'case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isa(' moniker '_3.getr(prop), ''Callback''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must be a callback.''] ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isequal(' moniker '_3.get(prop), ' moniker '_0.get(prop)) && ~isa(' moniker '_1.get(prop), ''Callback''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.get('' int2str(prop) '') must be the actual property and NOT a callback.''] ...']
                            ['\t\t\t\t' ')']
                    ['\t\t' 'otherwise']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' '~isa(' moniker '_3.getr(prop), ''Callback''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name '.getr('' int2str(prop) '') must NOT be a callback.''] ...']
                            ['\t\t\t\t' ')']
                ['\t' 'end']
             'end'
             ' '
            ];
    end

basic_tests{end+1} = test_copy();
    function basic_test = test_copy()
        basic_test.name = 'Copy';
        basic_test.probability = '.01';
        
        if strcmp(class_name, 'Callback') || strcmp(class_name, 'NoValue')
            basic_test.code = {'% this test is not implemented for Callback and NoValue'};
            return
        end
        
        % copy empty element
        basic_test.code = {
             '% copy empty element'
            [moniker ' = ' class_name '();']
             ' '
            [moniker '_copy = ' moniker '.copy();']
             ' '
            ['assert(' moniker '_copy ~= ' moniker ', ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' class_name '.copy() does not work. A copied element must point to a copied element.'')']
            ['assert(isequal(' moniker '_copy, ' moniker '), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' class_name '.copy() does not work. A copied element must have the same property values of the original element.'')']
             ' '
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'value = ' moniker '.getr(prop);']
                ['\t' 'value_copy = ' moniker '_copy.getr(prop);']
                ['\t' 'switch ' class_name '.getPropCategory(prop)']
                    ['\t\t' 'case {Category.EVANESCENT}']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isa(value_copy, ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '''' class_name '.copy() does not work. The copied value of an EVANESCENT property must be NoValue.'' ...']
                            ['\t\t\t\t' ')']
                    ['\t\t' 'otherwise']
                        ['\t\t\t' 'if isa(value, ''NoValue'')']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' 'value_copy == value, ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '''' class_name '.copy() does not work. There should be a unique instance of NoValue.'' ...']
                                ['\t\t\t\t\t' ')']
                        ['\t\t\t' 'elseif isa(value, ''Element'')']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' 'value_copy ~= value, ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '''' class_name '.copy() does not work. The handle of a copied element should point to a copied element.'' ...']
                                ['\t\t\t\t\t' ')']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' 'isequal(value_copy, value), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '''' class_name '.copy() does not work. When empty, a copied element should be equal to the element.'' ...']
                                ['\t\t\t\t\t' ')']
                        ['\t\t\t' 'elseif iscell(value) && all(all(cellfun(@(x) isa(x, ''Element''), value)))']
                            ['\t\t\t\t' 'for j = 1:1:length(value)']
                                ['\t\t\t\t\t' 'assert( ...']
                                    ['\t\t\t\t\t\t' 'value_copy ~= value, ...']
                                    ['\t\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                    ['\t\t\t\t\t\t' '''' class_name '.copy() does not work. The handle of a copied element should point to a copied element.'' ...']
                                    ['\t\t\t\t\t\t' ')']
                                ['\t\t\t\t\t' 'assert( ...']
                                    ['\t\t\t\t\t\t' 'isequal(value_copy, value), ...']
                                    ['\t\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                    ['\t\t\t\t\t\t' '''' class_name '.copy() does not work. When empty, a copied element should be equal to the element.'' ...']
                                    ['\t\t\t\t\t\t' ')']
                            ['\t\t\t\t' 'end']
                        ['\t\t\t' 'else']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' 'isequal(value_copy, value), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '''' class_name '.copy() does not work. The value copy should be equal to the original.'' ...']
                                ['\t\t\t\t\t' ')']
                        ['\t\t\t' 'end']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' moniker '_copy.isLocked(prop) == ' moniker '.isLocked(prop), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '''' class_name '.copy() does not work. The locked status of the copied and original elements must be the same.'' ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' moniker '_copy.isChecked(prop) == ' moniker '.isChecked(prop), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '''' class_name '.copy() does not work. The checked status of the copied and original elements must be the same.'' ...']
                            ['\t\t\t\t' ')']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' moniker '_copy.getPropSeed(prop) == ' moniker '.getPropSeed(prop), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '''' class_name '.copy() does not work. The randomization seeds of the copied and original elements must be the same.'' ...']
                            ['\t\t\t\t' ')']
                ['\t' 'end']
             'end'
             ' '
            };
        
        % copy element with default initialization and memorization
        basic_test.code = [reshape(basic_test.code, [], 1)
             '% copy element with default initialization and memorization'
            [moniker ' = ' class_name '( ...']
            ];
            for prop = 1:1:prop_number
                TAG = upper(Element.getPropTag(class_name, prop));
                switch Element.getPropCategory(class_name, prop)
                    case Category.CONSTANT
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getNoValue()'];
                    case {Category.RESULT, Category.QUERY, Category.EVANESCENT}
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getNoValue()'];
                    otherwise % {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ')'];
                end
                if prop < prop_number
                    basic_test.code{end} = [basic_test.code{end} ', ...'];
                else
                    basic_test.code{end} = [basic_test.code{end} ' ...'];
                end
            end
        basic_test.code = [reshape(basic_test.code, [], 1)
                ['\t' ');']
             ' '
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'if ' class_name '.getPropCategory(prop) == Category.QUERY']
                    ['\t\t' '% properties QUERY should not be memorized']
                    ['\t\t' '% ' 'warning_backup = warning(''off'', [BRAPH2.STR '':' class_name ''']);']
                    ['\t\t' '% ' moniker '.memorize(prop);']
                    ['\t\t' '% ' 'warning(warning_backup)']
                ['\t' 'elseif ' class_name '.getPropCategory(prop) == Category.EVANESCENT && ' moniker '.getPropFormat(prop) == Format.HANDLE']
                    ['\t\t' moniker '.memorize(prop);']
                    ['\t\t' 'warning_backup = warning(''off'', ''' BRAPH2.STR ':' class_name ''');']
                    ['\t\t' 'delete(ancestor(' moniker '.get(prop), ''figure''))']
                    ['\t\t' 'warning(warning_backup)']
                ['\t' 'else']
                    ['\t\t' moniker '.memorize(prop);']
                ['\t' 'end']
             'end'
             ' '
             '% copy element with default initialization'
            [moniker '_copy = ' moniker '.copy();']
             ' '
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'value = ' moniker '.getr(prop);']
                ['\t' 'value_copy = ' moniker '_copy.getr(prop);']
                ['\t' 'switch ' class_name '.getPropCategory(prop)']
                    ['\t\t' 'case {Category.EVANESCENT Category.QUERY}']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isa(value_copy, ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '''' class_name '.copy() does not work. The copied value of an EVANESCENT property must be NoValue.'' ...']
                            ['\t\t\t\t' ')']
                    ['\t\t' 'otherwise']
                        ['\t\t\t' 'if isa(value, ''NoValue'')']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' 'value_copy == value, ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '''' class_name '.copy() does not work. There should be a unique instance of NoValue.'' ...']
                                ['\t\t\t\t\t' ')']
                        ['\t\t\t' 'elseif isa(value, ''Element'')']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' 'value_copy ~= value, ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '''' class_name '.copy() does not work. The handle of a copied element should point to a copied element.'' ...']
                                ['\t\t\t\t\t' ')']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' 'isequal(value_copy, value), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '''' class_name '.copy() does not work. When empty, a copied element should be equal to the element.'' ...']
                                ['\t\t\t\t\t' ')']
                        ['\t\t\t' 'elseif iscell(value) && all(all(cellfun(@(x) isa(x, ''Element''), value)))']
                            ['\t\t\t\t' 'for j = 1:1:length(value)']
                                ['\t\t\t\t\t' 'assert( ...']
                                    ['\t\t\t\t\t\t' 'value_copy ~= value, ...']
                                    ['\t\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                    ['\t\t\t\t\t\t' '''' class_name '.copy() does not work. The handle of a copied element should point to a copied element.'' ...']
                                    ['\t\t\t\t\t\t' ')']
                                ['\t\t\t\t\t' 'assert( ...']
                                    ['\t\t\t\t\t\t' 'isequal(value_copy, value), ...']
                                    ['\t\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                    ['\t\t\t\t\t\t' '''' class_name '.copy() does not work. When empty, a copied element should be equal to the element.'' ...']
                                    ['\t\t\t\t\t\t' ')']
                            ['\t\t\t\t' 'end']
                        ['\t\t\t' 'else']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' 'isequal(value_copy, value), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '''' class_name '.copy() does not work. The value copy should be equal to the original.'' ...']
                                ['\t\t\t\t\t' ')']
                        ['\t\t\t' 'end']
                         ' '
                        ['\t\t\t\t' 'assert( ...']
                            ['\t\t\t\t\t' moniker '_copy.isLocked(prop) == ' moniker '.isLocked(prop), ...']
                            ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t\t' '''' class_name '.copy() does not work. The locked status of the copied and original elements must be the same.'' ...']
                            ['\t\t\t\t\t' ')']
                         ' '
                        ['\t\t\t\t' 'assert( ...']
                            ['\t\t\t\t\t' moniker '_copy.isChecked(prop) == ' moniker '.isChecked(prop), ...']
                            ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t\t' '''' class_name '.copy() does not work. The checked status of the copied and original elements must be the same.'' ...']
                            ['\t\t\t\t\t' ')']
                         ' '
                        ['\t\t\t\t' 'assert( ...']
                            ['\t\t\t\t\t' moniker '_copy.getPropSeed(prop) == ' moniker '.getPropSeed(prop), ...']
                            ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t\t' '''' class_name '.copy() does not work. The randomization seeds of the copied and original elements must be the same.'' ...']
                            ['\t\t\t\t\t' ')']
                ['\t' 'end']
            'end'
            ' '
            ];

        % copy element with callbacks
        basic_test.code = [reshape(basic_test.code, [], 1)
             '% copy element with callbacks'
            [moniker '_0 = ' class_name '( ...']
            ];
            for prop = 1:1:prop_number
                TAG = upper(Element.getPropTag(class_name, prop));
                switch Element.getPropCategory(class_name, prop)
                    case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ')'];
                    case {Category.METADATA}
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ')'];
                    otherwise
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getNoValue()'];
                end
                if prop < prop_number
                    basic_test.code{end} = [basic_test.code{end} ', ...'];
                else
                    basic_test.code{end} = [basic_test.code{end} ' ...'];
                end
            end
        basic_test.code = [reshape(basic_test.code, [], 1)
                ['\t' ');']
             ' '
            [moniker ' = ' class_name '( ...']
            ];
            for prop = 1:1:prop_number
                TAG = upper(eval([class_name '.getPropTag(' int2str(prop) ')']));
                switch eval([class_name '.getPropCategory(' int2str(prop) ')'])
                    case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
                        if prop < prop_number
                            basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' moniker '_0.getCallback(' int2str(prop) '), ...'];
                        else
                            basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' moniker '_0.getCallback(' int2str(prop) ') ...'];
                        end
                        case {Category.METADATA}
                            basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ')'];
                        otherwise
                            basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getNoValue()'];
                end
                if prop < prop_number
                    basic_test.code{end} = [basic_test.code{end} ', ...'];
                else
                    basic_test.code{end} = [basic_test.code{end} ' ...'];
                end
            end
        basic_test.code = [reshape(basic_test.code, [], 1)
                ['\t' ');']
             ' '
            [moniker '_copy = ' moniker '.copy();']
            [moniker '_0_copy = ' moniker '_copy.getr(''ID'').get(''EL'');']
             ' '
            ['for prop = 1:1:' class_name '.getPropNumber()']
                ['\t' 'value = ' moniker '.getr(prop);']
                ['\t' 'value_copy = ' moniker '_copy.getr(prop);']
                ['\t' 'switch ' class_name '.getPropCategory(prop)']
                    ['\t\t' 'case {Category.EVANESCENT}']
                        ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isa(value_copy, ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '''' class_name '.copy() does not work. The copied value of an EVANESCENT property must be NoValue.'' ...']
                            ['\t\t\t\t' ')']
                    ['\t\t' 'otherwise']
                        ['\t\t\t' 'if isa(value, ''NoValue'')']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' 'value_copy == value, ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '''' class_name '.copy() does not work. There should be a unique instance of NoValue.'' ...']
                                ['\t\t\t\t\t' ')']
                        ['\t\t\t' 'elseif isa(value, ''Element'')']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' 'value_copy ~= value, ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '''' class_name '.copy() does not work. The handle of a copied element should point to a copied element.'' ...']
                                ['\t\t\t\t\t' ')']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' 'isequal(value_copy, value), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '''' class_name '.copy() does not work. When empty, a copied element should be equal to the element.'' ...']
                                ['\t\t\t\t\t' ')']
                        ['\t\t\t' 'elseif iscell(value) && all(all(cellfun(@(x) isa(x, ''Element''), value)))']
                            ['\t\t\t\t' 'for j = 1:1:length(value)']
                                ['\t\t\t\t\t' 'assert( ...']
                                    ['\t\t\t\t\t\t' 'value_copy ~= value, ...']
                                    ['\t\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                    ['\t\t\t\t\t\t' '''' class_name '.copy() does not work. The handle of a copied element should point to a copied element.'' ...']
                                    ['\t\t\t\t\t\t' ')']
                                ['\t\t\t\t\t' 'assert( ...']
                                    ['\t\t\t\t\t\t' 'isequal(value_copy, value), ...']
                                    ['\t\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                    ['\t\t\t\t\t\t' '''' class_name '.copy() does not work. When empty, a copied element should be equal to the element.'' ...']
                                    ['\t\t\t\t\t\t' ')']
                            ['\t\t\t\t' 'end']
                        ['\t\t\t' 'else']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' 'isequal(value_copy, value), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '''' class_name '.copy() does not work. The value copy should be equal to the original.'' ...']
                                ['\t\t\t\t\t' ')']
                        ['\t\t\t' 'end']
                         ''
                        ['\t\t\t' 'if isa(value, ''Callback'')']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' 'value == ' moniker '_0.getCallback(prop), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '''' class_name '.copy() does not work. The callback should be obtained from ' class_name '.getCallback().'' ...']
                                ['\t\t\t\t\t' ')']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' 'value_copy == ' moniker '_0_copy.getCallback(prop), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '''' class_name '.copy() does not work. The callback should be obtained from ' class_name '.getCallback().'' ...']
                                ['\t\t\t\t\t' ')']
                        ['\t\t\t' 'end']
                         ' '
                        ['\t\t\t\t' 'assert( ...']
                            ['\t\t\t\t\t' moniker '_copy.isLocked(prop) == ' moniker '.isLocked(prop), ...']
                            ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t\t' '''' class_name '.copy() does not work. The locked status of the copied and original elements must be the same.'' ...']
                            ['\t\t\t\t\t' ')']
                         ' '
                        ['\t\t\t\t' 'assert( ...']
                            ['\t\t\t\t\t' moniker '_copy.isChecked(prop) == ' moniker '.isChecked(prop), ...']
                            ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t\t' '''' class_name '.copy() does not work. The checked status of the copied and original elements must be the same.'' ...']
                            ['\t\t\t\t\t' ')']
                         ' '
                        ['\t\t\t\t' 'assert( ...']
                            ['\t\t\t\t\t' moniker '_copy.getPropSeed(prop) == ' moniker '.getPropSeed(prop), ...']
                            ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t\t' '''' class_name '.copy() does not work. The randomization seeds of the copied and original elements must be the same.'' ...']
                            ['\t\t\t\t\t' ')']
                ['\t' 'end']
            'end'
            ' '
            ];
    end

basic_tests{end+1} = test_template();
    function basic_test = test_template()
        basic_test.name = 'Template';
        basic_test.probability = '.01';
        
        if strcmp(class_name, 'Callback') || strcmp(class_name, 'NoValue')
            basic_test.code = {'% this test is not implemented for Callback and NoValue'};
            return
        end
        
        basic_test.code = {
            [moniker '_template = ' class_name '();']
            [moniker ' = ' class_name '(''TEMPLATE'', ' moniker '_template);']
             ' '
            ['for prop = 1:1:' class_name '.getPropNumber()']
                 ' '
                ['\t' '% excluded props']
                ['\t' 'if any(prop == ' excluded_props ')']
                    ['\t\t' 'continue']
                ['\t' 'end']
                 ' '
                ['\t' 'TAG = upper(' class_name '.getPropTag(prop));']
                ['\t' 'switch ' class_name '.getPropCategory(prop)']
                    ['\t\t' 'case {Category.PARAMETER}']
                        ['\t\t\t' 'if prop == ' class_name '.TEMPLATE']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' 'isa(' moniker '.getr(prop), ''' class_name '''), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '''' class_name ' TEMPLATE does not work. ' class_name '.getr(''''TEMPLATE'''') should be a ' class_name ' element.'' ...']
                                ['\t\t\t\t\t' ')']
                           ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' 'isa(' moniker '_template.getr(prop), ''NoValue''), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '''' class_name ' TEMPLATE does not work. ' class_name '_template.getr(''''TEMPLATE'''') should be a NoValue.'' ...']
                                ['\t\t\t\t\t' ')']
                         ['\t\t\t' 'else']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' 'isa(' moniker '.getr(prop), ''Callback''), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '[''' class_name ' TEMPLATE does not work. ' class_name '.getr('' TAG '') should be a Callback.''] ...']
                                ['\t\t\t\t\t' ')']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' moniker '.getr(prop).get(''EL'') == ' moniker '_template && ' moniker '.getr(prop).get(''PROP'') == prop && strcmp(' moniker '.getr(prop).get(''TAG''), TAG), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '[''' class_name ' TEMPLATE does not work. ' class_name '.getr('' TAG '') should be a Callback to ' moniker '_template.'' TAG ''.''] ...']
                                ['\t\t\t\t\t' ')']
                            ['\t\t\t\t' 'assert( ...']
                                ['\t\t\t\t\t' 'isa(' moniker '_template.getr(prop), ''NoValue''), ...']
                                ['\t\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                                ['\t\t\t\t\t' '[''' class_name ' TEMPLATE does not work. ' class_name '_template.getr('' TAG '') should be a NoValue.''] ...']
                                ['\t\t\t\t\t' ')']
                        ['\t\t\t' 'end']
                    ['\t\t' 'otherwise']
                       ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isa(' moniker '.getr(prop), ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name ' TEMPLATE does not work. ' class_name '.getr('' TAG '') should be a NoValue.''] ...']
                            ['\t\t\t\t' ')']
                       ['\t\t\t' 'assert( ...']
                            ['\t\t\t\t' 'isa(' moniker '_template.getr(prop), ''NoValue''), ...']
                            ['\t\t\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                            ['\t\t\t\t' '[''' class_name ' TEMPLATE does not work. ' class_name '_template.getr('' TAG '') should be a NoValue.''] ...']
                            ['\t\t\t\t' ')']
                ['\t' 'end']
             'end'
           };
    end

basic_tests{end+1} = test_saveload();
    function basic_test = test_saveload()
        basic_test.name = 'Save Load';
        basic_test.probability = '.01';
        
        if strcmp(class_name, 'Callback') || strcmp(class_name, 'NoValue')
            basic_test.code = {'% this test is not implemented for Callback and NoValue'};
            return
        end
        
        basic_test.code = {
            [moniker ' = ' class_name '( ...']
            };
            for prop = 1:1:prop_number
                TAG = upper(Element.getPropTag(class_name, prop));
                switch Element.getPropCategory(class_name, prop)
                    case Category.CONSTANT
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getNoValue()'];
                    case {Category.RESULT, Category.QUERY, Category.EVANESCENT}
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getNoValue()'];
                    otherwise % {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ')'];
                end
                if prop < prop_number
                    basic_test.code{end} = [basic_test.code{end} ', ...'];
                else
                    basic_test.code{end} = [basic_test.code{end} ' ...'];
                end
            end
        basic_test.code = [reshape(basic_test.code, [], 1)
                ['\t' ');']
             ' '
            ['filename = [fileparts(which(''test_braph2'')) filesep ''' lower(class_name) '_to_be_erased.b2''];']
             ' '
            ['Element.save(' moniker ', filename)']
             ' '
            [moniker '_loaded = Element.load(filename);']
             ' '
             'assert( ...'
                ['\t' 'isequal(' moniker '.copy(), ' moniker '_loaded), ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' class_name '.save(' moniker ') and/or ' class_name '.load() do not work.'' ...']
                ['\t' ')']
             ' '
             'delete(filename)'
             ];
    end

basic_tests{end+1} = test_json(); % basic_tests{end+1} = test_json();
    function basic_test = test_json()
        basic_test.name = 'JSON';
        basic_test.probability = '.01';
        
        if strcmp(class_name, 'Callback') || strcmp(class_name, 'NoValue')
            basic_test.code = {'% this test is not implemented for Callback and NoValue'};
            return
        end
        
        basic_test.code = {
            [moniker ' = ' class_name '( ...']
            };
            for prop = 1:1:prop_number
                TAG = upper(Element.getPropTag(class_name, prop));
                switch Element.getPropCategory(class_name, prop)
                    case Category.CONSTANT
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getNoValue()'];
                    case {Category.RESULT, Category.QUERY, Category.EVANESCENT}
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getNoValue()'];
                    otherwise % {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
                        basic_test.code{end+1} = ['\t' class_name '.' TAG ', ' class_name '.getPropDefault(' class_name '.' TAG ')'];
                end
                if prop < prop_number
                    basic_test.code{end} = [basic_test.code{end} ', ...'];
                else
                    basic_test.code{end} = [basic_test.code{end} ' ...'];
                end
            end
        basic_test.code = [reshape(basic_test.code, [], 1)
                ['\t' ');']
             ' '
            ['[json, struct, el_list] = encodeJSON(' moniker ');']
            ['[' moniker '_dec, struct_dec, el_list_dec] = Element.decodeJSON(json);']
             ' '
            ['assert(' moniker '_dec ~= ' moniker ', ...']
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '''' class_name '.encodeJSON() or ' class_name '.decodeJSON() does not work. A JSON encoded/decoded element must point to an element other than the original one.'' ...'] 
                ['\t' ')']
            ['if all(cellfun(@(prop) ' class_name '.getPropFormat(prop), num2cell(' class_name '.getProps())) == Format.HANDLE) && all(cellfun(@(prop) ' class_name '.getPropFormat(prop), num2cell(' class_name '.getProps())) == Format.NET)']
                ['\t' 'assert(isequal(' moniker '_dec, ' moniker '), ...']
                    ['\t\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                    ['\t\t' '''' class_name '.encodeJSON() or ' class_name '.decodeJSON() does not work. A JSON encoded/decoded element must have the same property values of the original element.'' ...']
                    ['\t\t' ')']
             'end'
             ];
    end

tests = [basic_tests tests no_figure_test delete_figures];

    function test = no_figure_test()
        test.name = 'No Figures Left';
        test.probability = '1';
        
        test.code = {
             'assert(isempty(findall(0, ''type'', ''figure'')), ...'
                ['\t' '[BRAPH2.STR '':' class_name ':'' BRAPH2.FAIL_TEST], ...']
                ['\t' '['' When testing ' class_name ' no figures should be left over, either visible or not. '' ...']
                ['\t' 'int2str(length(findall(0, ''type'', ''figure''))) '' figure(s) were left over.''] ...']
                ['\t' ')']
            };
    end
    function test = delete_figures()
        test.name = 'Delete Figures';
        test.probability = '1';
        
        test.code = {
             'delete(findall(0, ''type'', ''figure''))'
            };
    end

%% Generate file
file_str = [];

generate_header()
    function generate_header()
        gs(0, {
            ['%TEST_' upper(class_name)]
            ''
            })
    end

generate_tests()
    function generate_tests()    
        for i = 1:1:numel(tests)
            g(0, ['%% Test ' int2str(i) ': ' tests{i}.name])
            
            g(0, ['if rand() >= (1 - ' tests{i}.probability ') * BRAPH2TEST.RANDOM'])
                
                if warning_off
                    gs(1, {['warning(''off'', [BRAPH2.STR '':' class_name '''])'], ''})
                end

                gs(1, tests{i}.code)

                if warning_off
                    gs(1, {'', ['warning(''on'', [BRAPH2.STR '':' class_name '''])']})
                end
                    
            gs(0, {
                'end'
                ''
                })
        end
    end

generate_test_functions()
    function generate_test_functions()
        if isequal(test_functions, {''})
            return
        end
        
        g(0, '%% Test functions')
        gs(0, test_functions)
    end

%% Save file
target_file = [target_dir filesep() 'test_' class_name '.m'];
object_file = fopen(target_file, 'w');
fprintf(object_file, file_str);
fclose(object_file);

disp(['¡! saved file: ' target_file])
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
