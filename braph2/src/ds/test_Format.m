%TEST_FORMAT

%% Test 1: Static methods
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    format_list = Format.getFormats();
    
    assert(numel(format_list) == Format.getFormatNumber(), ...
        [BRAPH2.STR ':Format:' BRAPH2.FAIL_TEST], ...
        'Format.getFormatNumber() does not return correct number of formats.')
    
    for format = format_list
        assert(Format.existsFormat(format), ...
            [BRAPH2.STR ':Format:' BRAPH2.FAIL_TEST], ...
            ['Format.existsFormat(' tostring(format) ') must return true.'])
        
        assert(strcmp(eval(['Format.' upper(Format.getFormatName(format)) '_TAG']), Format.getFormatTag(format)), ...
            [BRAPH2.STR ':Format:' BRAPH2.FAIL_TEST], ...
            ['Format.getFormatName(' tostring(format) ') does not return correct output.'])

        assert(strcmp(eval(['Format.' upper(Format.getFormatName(format)) '_NAME']), Format.getFormatName(format)), ...
            [BRAPH2.STR ':Format:' BRAPH2.FAIL_TEST], ...
            ['Format.getFormatName(' tostring(format) ') does not return correct output.'])
        
        assert(strcmp(eval(['Format.' upper(Format.getFormatName(format)) '_DESCRIPTION']), Format.getFormatDescription(format)), ...
            [BRAPH2.STR ':Format:' BRAPH2.FAIL_TEST], ...
            ['Format.getFormatDescription(' tostring(format) ') does not return correct output.'])
        
        assert(ischar(Format.getFormatDescription(format, Format.getFormatSettings(format))), ...
            [BRAPH2.STR ':Format:' BRAPH2.FAIL_TEST], ...
            ['Format.getDescription(' tostring(format) ', settings) should return a char array.'])
        
        assert(Format.checkFormat(format, Format.getFormatDefault(format)), ...
            [BRAPH2.STR ':Format:' BRAPH2.FAIL_TEST], ...
            ['Format.checkFormat(' tostring(format) ') does not work.'])
    end
end

%% Test 2.EM: Check EMPTY
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % EMPTY formats that should be accepted
    clear value
    value{1} = [];
    value{2} = '';

    for i = 1:1:length(value)
        Format.checkFormat(Format.EMPTY, value{i})
    end
    
    % EMPTY formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = 'String';
    wrong_value{2} = true;
    wrong_value{3} = 3.14;

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.EMPTY, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.ST: Check STRING
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % STRING formats that should be accepted
    clear value
    value{1} = 'String';

    for i = 1:1:length(value)
        Format.checkFormat(Format.STRING, value{i})
    end

    % STRING formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = true;
    wrong_value{2} = 3.14;

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.STRING, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.ST: Check STRINGLIST
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % STRINGLIST formats that should be accepted
    clear value
    value{1} = {};
    value{2} = {'String1'};
    value{3} = {'String1', 'String2'};
    value{4} = {'String1', 'String2', 'String3', 'String4'};

    for i = 1:1:length(value)
        Format.checkFormat(Format.STRINGLIST, value{i})
    end

    % STRINGLIST formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = true;
    wrong_value{2} = 3.14;
    wrong_value{3} = '';
    wrong_value{4} = "";
    wrong_value{5} = 'String';
    wrong_value{6} = {"", ""}; %#ok<CLARRSTR>
    wrong_value{7} = {"String"}; %#ok<STRSCALR>

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.STRINGLIST, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.LO: Check LOGICAL
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % LOGICAL formats that should be accepted
    clear value
    value{1} = true;
    value{2} = false;

    for i = 1:1:length(value)
            Format.checkFormat(Format.LOGICAL, value{i})
    end
    
    % LOGICAL formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = 'String';
    wrong_value{2} = 3.14;
    wrong_value{3} = true(2);

    for i = 1:1:length(wrong_value)
            assert_with_error('Format.checkFormat(Format.LOGICAL, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.OP: Check OPTION
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % OPTION formats that should be accepted
    clear value
    value{1} = '';

    for i = 1:1:length(value)
        Format.checkFormat(Format.OPTION, value{i})
    end
    
    % OPTION formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = 'String';
    wrong_value{2} = true;
    wrong_value{3} = 3.14;

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.OPTION, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.OP.s: Check OPTION with settings
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % OPTION formats that should be accepted
    clear value settings
    value{1} = 'true';  settings{1} = {'true', 'false'};
    value{2} = 'male';  settings{2} = {'female', 'male'};
    value{3} = 'Male';  settings{3} = {'Female', 'Male'};
    value{4} = 'PhD';   settings{4} = {'elementary', 'high school', 'college', 'MSc', 'PhD'};

    for i = 1:1:length(value)
        Format.checkFormat(Format.OPTION, value{i}, settings{i})
    end
    
    % OPTION formats that should NOT be accepted
    clear wrong_value wrong_settings
    wrong_value{1} = 'true';    wrong_settings{1} = {'0', '1'};
    wrong_value{2} = 'male';    wrong_settings{2} = {'woman', 'man'};
    wrong_value{3} = 'Man';     wrong_settings{3} = {'woman', 'man'};
    wrong_value{4} = 'phd';     wrong_settings{4} = {'elementary', 'high school', 'college', 'MSc', 'PhD'};
    wrong_value{5} = 'phd';     wrong_settings{5} = {'elementary', 'high school', 'college', 'M.Sc.', 'Ph.D.'};

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.OPTION, varargin{1}, varargin{2})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i}, wrong_settings{i})
    end
end

%% Test 2.CA: Check CLASS
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % CLASS formats that should be accepted
    clear value element_class_list
    value{1} = 'ConcreteElement';
    element_class_list = subclasses('ConcreteElement', [], [], true);
    for i = 1:1:numel(element_class_list)
        element_class = element_class_list{i};
        value{i + 1} = element_class; %#ok<SAGROW>
    end

    for i = 1:1:length(value)
            Format.checkFormat(Format.CLASS, value{i})
    end

    % CLASS formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = 'non existing class';
    wrong_value{2} = 3.14;
    wrong_value{3} = true;
    wrong_value{4} = '1String';

    for i = 1:1:length(wrong_value)
            assert_with_error('Format.checkFormat(Format.CLASS, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.CA.s: Check CLASS with settings
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % CLASS formats that should be accepted
    clear value element_class_list
    value{1} = 'ConcreteElement'; settings{1} = ConcreteElement.getClass();
    element_class_list = subclasses('ConcreteElement', [], [], true);
    for i = 1:1:numel(element_class_list)
        element_class = element_class_list{i};
        value{2 * i} = element_class; %#ok<SAGROW>
        settings{2 * i} = eval([element_class '.getClass()']);
        value{2 * i + 1} = element_class; %#ok<SAGROW>
        settings{2 * i + 1} = 'ConcreteElement';
    end

    for i = 1:1:length(value)
        Format.checkFormat(Format.CLASS, value{i}, settings{i})
    end

    % CLASS formats that should NOT be accepted
    clear wrong_value wrong_settings
    wrong_value{1} = 'non existing class';  wrong_settings{1} = 'Element';
    wrong_value{2} = 3.14;                  wrong_settings{2} = 'DoubleClass';
    wrong_value{3} = true;                  wrong_settings{3} = 'BooleanClass';
    wrong_value{4} = 'String';              wrong_settings{4} = 'Element';

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.CLASS, varargin{1}, varargin{2})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i}, wrong_settings{i})
    end
end

%% Test 2.CL: Check CLASSLIST
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % CLASSLIST formats that should be accepted
    clear value
    value{1} = {'ConcreteElement'};
    element_class_list = subclasses('ConcreteElement', [], [], true);
    value{2} = element_class_list;
    for i = 1:1:numel(element_class_list)
        element_class = element_class_list{i};
        value{i + 2} = {element_class};
    end

    for i = 1:1:length(value)
        Format.checkFormat(Format.CLASSLIST, value{i})
    end

    % CLASSLIST formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = 'Element';
    wrong_value{2} = {'non existing class'};
    wrong_value{3} = 3.14;
    wrong_value{4} = true;
    wrong_value{5} = 'String';

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.CLASSLIST, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.CL.s: Check CLASSLIST with settings
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % CLASSLIST formats that should be accepted
    clear value settings
    value{1} = {'ConcreteElement'}; settings{1} = ConcreteElement.getClass();
    element_class_list = subclasses('ConcreteElement', [], [], true);
    value{2} = element_class_list;
    for i = 1:1:numel(element_class_list)
        element_class = element_class_list{i};
        value{2 * i + 1} = {element_class};
        settings{2 * i + 1} = eval([element_class '.getClass()']); %#ok<SAGROW>
        value{2 * i + 2} = {element_class};
        settings{2 * i + 2} = 'ConcreteElement'; %#ok<SAGROW>
    end

    for i = 1:1:length(value)
        Format.checkFormat(Format.CLASSLIST, value{i}, settings{i})
    end
    
    % CLASSLIST formats that should NOT be accepted
    clear wrong_value wrong_settings
    wrong_value{1} = 'Element';                 wrong_settings{1} = 'IndexedDictionary';
    wrong_value{2} = {'non existing class'};    wrong_settings{2} = 'Element';
    wrong_value{3} = 3.14;                      wrong_settings{3} = 'Numeric';
    wrong_value{4} = true;                      wrong_settings{4} = 'Boolean';
    wrong_value{5} = 'String';                  wrong_settings{5} = 'StringClass';

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.CLASSLIST, varargin{1}, varargin{2})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i}, wrong_settings{i})
    end
end

%% Test 2.IT: Check ITEM
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % ITEM formats that should be accepted
    clear value
    element_class_list = subclasses('ConcreteElement', [], [], true);
    for i = 1:1:numel(element_class_list)
        element_class = element_class_list{i};
        value{i} = eval([element_class '()']); %#ok<SAGROW>
    end
    
    for i = 1:1:length(value)
        Format.checkFormat(Format.ITEM, value{i})
    end
    
    % ITEM formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = 3.14;
    wrong_value{2} = true;
    wrong_value{3} = 'String';
    element_class_list = subclasses('Element', [], [], true);
    for i = 1:1:numel(element_class_list)
        element_class = element_class_list{i};
        wrong_value{i + 3} = element_class;
    end
    
    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.ITEM, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.IT.s: Check ITEM with settings
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % ITEM formats that should be accepted
    clear value settings
    element_class_list = subclasses('ConcreteElement', [], [], true);
    for i = 1:1:numel(element_class_list)
        element_class = element_class_list{i};
        value{i} = eval([element_class '()']); %#ok<SAGROW>
        settings{i} = eval([element_class '.getClass()']); %#ok<SAGROW>
    end
    
    for i = 1:1:length(value)
        Format.checkFormat(Format.ITEM, value{i}, settings{i})
    end
    
    % ITEM formats that should NOT be accepted
    clear wrong_value wrong_settings
    wrong_value{1} = 3.14;
    wrong_value{2} = true;
    wrong_value{3} = 'String';
    element_class_list = subclasses('Element', [], [], true);
    for i = 1:1:numel(element_class_list)
        element_class = element_class_list{i};
        wrong_value{2 * i + 2} = element_class;
        wrong_settings{2 * i + 2} = eval([element_class '.getClass()']); %#ok<SAGROW>
        wrong_value{2 * i + 3} = element_class;
        wrong_settings{2 * i + 3} = 'Element'; %#ok<SAGROW>
    end
    
    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.ITEM, varargin{1}, varargin{2})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i}, wrong_settings{i})
    end
end

%% Test 2.IL: Check ITEMLIST
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % ITEMLIST formats that should be accepted
    clear value
    element_class_list = subclasses('ConcreteElement', [], [], true);
    value{1} = cellfun(@(x) eval([x '()']), element_class_list, 'UniformOutput', false);
    for i = 1:1:length(element_class_list)
        value{i + 1} = {eval([element_class_list{i} '()'])}; %#ok<SAGROW>
    end

    for i = 1:1:length(value)
        Format.checkFormat(Format.ITEMLIST, value{i})
    end

    % ITEMLIST formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = 3.14;
    wrong_value{2} = true;
    wrong_value{3} = 'String';
    wrong_value{4} = {'1', '2', '3'};

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.ITEMLIST, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.IL.s: Check ITEMLIST with settings
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % ITEMLIST formats that should be accepted
    clear value settings
    element_class_list = subclasses('ConcreteElement', [], [], true);
    value{1} = cellfun(@(x) eval([x '()']), element_class_list, 'UniformOutput', false);
    settings{1} = 'ConcreteElement';
    for i = 1:1:length(element_class_list)
        value{2 * i} = {eval([element_class_list{i} '()'])}; %#ok<SAGROW>
        settings{2 * i} = element_class_list{i}; %#ok<SAGROW>
        value{2 * i + 1} = {eval([element_class_list{i} '()'])}; %#ok<SAGROW>
        settings{2 * i + 1} = 'ConcreteElement'; %#ok<SAGROW>
    end

    for i = 1:1:length(value)
        Format.checkFormat(Format.ITEMLIST, value{i}, settings{i})
    end

    % ITEMLIST formats that should NOT be accepted
    clear wrong_value wrong_settings
    wrong_value{1} = 3.14;              wrong_settings{1} = 'String';
    wrong_value{2} = true;              wrong_settings{2} = 'Boolean';
    wrong_value{3} = 'String';          wrong_settings{3} = 'Char';
    wrong_value{4} = {'1', '2', '3'};   wrong_settings{4} = 'String';

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.ITEM, varargin{1}, varargin{2})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i}, wrong_settings{i})
    end
end

%% Test 2.DI: Check IDICT
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % IDICT formats that should be accepted
    clear value
    element_class_list = subclasses('ConcreteElement', [], [], true);
    for i = 1:1:numel(element_class_list)
        element_class = element_class_list{i};
        if Element.existsTag(element_class, 'ID')
            value{i} = IndexedDictionary( ...
                'IT_CLASS', element_class, ...
                'IT_KEY', Element.getPropProp(element_class, 'ID'), ...
                'IT_LIST', {eval([element_class '()']), eval([element_class '()']), eval([element_class '()'])} ...
                ); %#ok<SAGROW>
        end
    end
    value = value(~cellfun('isempty', value));

    for i = 1:1:length(value)
        Format.checkFormat(Format.IDICT, value{i})
    end

    % IDICT formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = '';
    wrong_value{2} = 3.14;
    wrong_value{3} = true;
    wrong_value{4} = 'String';

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.IDICT, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.DI.s: Check IDICT with settings
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % IDICT formats that should be accepted
    clear value settings
    element_class_list = subclasses('ConcreteElement', [], [], true);
    for i = 1:1:numel(element_class_list)
        element_class = element_class_list{i};
        if Element.existsTag(element_class, 'ID')
            value{i} = IndexedDictionary( ...
                'IT_CLASS', element_class, ...
                'IT_KEY', Element.getPropProp(element_class, 'ID'), ...
                'IT_LIST', {eval([element_class '()']), eval([element_class '()']), eval([element_class '()'])} ...
                ); %#ok<SAGROW>
            settings{i} = element_class; %#ok<SAGROW>
        end
    end
    settings = settings(~cellfun('isempty', value));
    value = value(~cellfun('isempty', value));

    for i = 1:1:length(value)
        Format.checkFormat(Format.IDICT, value{i}, settings{i})
    end

    % IDICT formats that should NOT be accepted
    clear wrong_value wrong_settings
    wrong_value{1} = '';        wrong_settings{1} = 'String';
    wrong_value{2} = 3.14;      wrong_settings{2} = 'String';
    wrong_value{3} = true;      wrong_settings{3} = 'String';
    wrong_value{4} = 'String';  wrong_settings{4} = 'String';

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.IDICT, varargin{1}, varargin{2})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i}, wrong_settings{i})
    end
end

%% Test 2.NN: Check SCALAR
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % SCALAR formats that should be accepted
    clear value
    value{1} = 3.14;

    for i = 1:1:length(value)
        Format.checkFormat(Format.SCALAR, value{i})
    end

    % SCALAR formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = [1 2 3];
    wrong_value{2} = 'String';
    
    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.SCALAR, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.NR: Check RVECTOR
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % RVECTOR formats that should be accepted
    clear value
    value{1} = [1 2 3];
    value{2} = 3.14;

    for i = 1:1:length(value)
        Format.checkFormat(Format.RVECTOR, value{i})
    end
    
    % RVECTOR formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = [1 2 3]';
    wrong_value{2} = 'String';

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.RVECTOR, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.NC: Check CVECTOR
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % CVECTOR formats that should be accepted
    clear value
    value{1} = [1 2 3]';
    value{2} = 3.14;

    for i = 1:1:length(value)
        Format.checkFormat(Format.CVECTOR, value{i})
    end
    
    % CVECTOR formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = [1 2 3];
    wrong_value{2} = 'String';

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.CVECTOR, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.NM: Check MATRIX
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % MATRIX formats that should be accepted
    clear value
    value{1} = rand(2, 3);
    value{2} = 3.14;
    value{3} = [1 2 3]';
    value{4} = [1 2 3];

    for i = 1:1:length(value)
        Format.checkFormat(Format.MATRIX, value{i})
    end
    
    % MATRIX formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = 'String';

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.MATRIX, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.NS: Check SMATRIX
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % SMATRIX formats that should be accepted
    clear value
    value{1} = rand(10);
    value{2} = 3.14;

    for i = 1:1:length(value)
        Format.checkFormat(Format.SMATRIX, value{i})
    end
    
    % SMATRIX formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = rand(2, 3);
    wrong_value{1} = [1 2 3]';
    wrong_value{1} = [1 2 3];
    wrong_value{1} = 'String';

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.SMATRIX, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.LL: Check CELL
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % CELL formats that should be accepted
    clear value
    value{1} = {rand(5)};
    value{2} = {
        rand(5) [] []
        [] rand(2) []
        [] [] rand(1)
        };
    value{3} = {
        rand(4) diag(rand(4, 1)) []
        diag(rand(4, 1)) rand(4) diag(rand(4, 1))
        [] diag(rand(4, 1)) rand(4)
        };
    value{4} = {
        rand(4) diag(rand(4, 1)) diag(rand(4, 1))
        diag(rand(4, 1)) rand(4) diag(rand(4, 1))
        diag(rand(4, 1)) diag(rand(4, 1)) rand(4)
        };
    value{5} = {
        rand(3) rand(3, 2) []
        rand(2, 3) rand(2) rand(2, 4)
        [] rand(4, 2) rand(4)
        };
    value{6} = {
        rand(3) rand(3, 2) rand(3, 4)
        rand(2, 3) rand(2) rand(2, 4)
        rand(4, 3) rand(4, 2) rand(4)
        };
    value{7} = {
        rand(5)
        rand(2)
        rand(1)
        };
    value{8} = {rand(5) rand(2) rand(1)};
    value{9} = {rand(3, 2, 4) 1 2};

    for i = 1:1:length(value)
        Format.checkFormat(Format.CELL, value{i})
    end

    % CELL formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = 'String';
    wrong_value{2} = true;
    wrong_value{3} = rand(5, 3);
    wrong_value{4} = rand(4, 3);
    wrong_value{5} = rand(3, 4);

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.CELL, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.ML: Check NET
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
% % %     if BRAPH2.installed('NN', 'warning')
% % %         % NET formats that should be accepted
% % %         clear value
% % %         
% % %         % switch off the nnet warning
% % %         w = warning('query', 'MATLAB:mir_warning_unrecognized_pragma');
% % %         warning('off', w.identifier);
% % %         
% % %         % create network object
% % %         value{1} = network();
% % %         
% % %         % create SeriesNetwork object
% % %         size_x = 28;
% % %         size_y = 28;
% % %         num_channel = 1;
% % %         num_neuron = 100;
% % %         num_class = 10;
% % %         layers = [
% % %             imageInputLayer([size_x size_y num_channel], 'Name', 'input', 'Mean', rand(size_x, size_y, num_channel))
% % %             fullyConnectedLayer(num_neuron, 'Name', 'fc1', 'Weights', rand(num_neuron, size_x * size_y), 'Bias', rand(num_neuron, 1))
% % %             fullyConnectedLayer(num_class, 'Name', 'fc2', 'Weights', rand(num_class, num_neuron), 'Bias', rand(num_class, 1))
% % %             softmaxLayer('Name', 'softmax')
% % %             classificationLayer('Classes', categorical(1:num_class), 'Name', 'classOutput')
% % %             ];
% % %         value{2} = SeriesNetwork(layers);
% % %         
% % %         % create DAGNetwrok object
% % %         lgraph = layerGraph(layers);
% % %         value{3} = assembleNetwork(lgraph);
% % %         
% % %         % create dlnetwork object
% % %         lgraph = removeLayers(lgraph, 'classOutput');
% % %         value{4} = dlnetwork(lgraph); % dlnetework object
% % %         
% % %         % resume nnet warning status and clear variables
% % %         warning(w.state, w.identifier)
% % %         vars = {'w', 'size_x', 'size_y', 'num_channel', 'num_neuron', 'num_class', 'layers', 'vars'};
% % %         clear(vars{:})
% % %         
% % %         for i = 1:1:length(value)
% % %             Format.checkFormat(Format.NET, value{i})
% % %         end
% % %         
% % %         % NET formats that should NOT be accepted
% % %         clear wrong_value
% % %         wrong_value{1} = 'String';
% % %         wrong_value{2} = 3.14;
% % %         wrong_value{3} = Element();
% % %         wrong_value{4} = {};
% % %         
% % %         for i = 1:1:length(wrong_value)
% % %             assert_with_error('Format.checkFormat(Format.NET, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
% % %         end
% % %     end
end

%% Test 2.HA: Check HANDLE
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % HANDLE formats that should be accepted
    clear value
    value{1} = gobjects(0);
    value{2} = gobjects(1);
    value{3} = uifigure();
    value{4} = uiaxes(value{3});

    for i = 1:1:length(value)
        Format.checkFormat(Format.HANDLE, value{i})
    end
    
    close(value{3})    

    % HANDLE formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = 0;
    wrong_value{2} = 'h';

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.HANDLE, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.HL: Check HANDLELIST
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % HANDLE formats that should be accepted
    clear value
    value{1} = {};
    value{2} = {gobjects(0)};
    value{3} = {gobjects(1)};
    value{4} = {uifigure()};
    value{5} = {uiaxes(value{4}{1}), uifigure()};

    for i = 1:1:length(value)
        Format.checkFormat(Format.HANDLELIST, value{i})
    end

    close(value{4}{1})
    close(value{5}{2})    
    
    % HANDLE formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = 0;
    wrong_value{2} = 'h';
    wrong_value{3} = gobjects(0);
    wrong_value{4} = gobjects(1);
    wrong_value{5} = uifigure();
    wrong_value{6} = uiaxes(wrong_value{5});

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.HANDLELIST, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
    
    close(wrong_value{5})    
end

%% Test 2.CO: Check COLOR
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % COLOR formats that should be accepted
    clear value
    value{1} = [0 0 0];
    value{2} = [1 1 1];
    value{3} = [1 0 0];
    value{4} = [0 1 0];
    value{5} = [0 1 1];

    for i = 1:1:length(value)
        Format.checkFormat(Format.COLOR, value{i})
    end
    
   % COLOR formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = 1;
    wrong_value{2} = 'b';
    wrong_value{3} = 'Color';
    wrong_value{4} = [2 2 2];
    wrong_value{5} = [-1 0 0];
    wrong_value{6} = {};
	wrong_value{7} = Element();

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.COLOR, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.AL: Check ALPHA
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % ALPHA formats that should be accepted
    clear value
    value{1} = 0;
    value{2} = .5;
    value{3} = 1;

    for i = 1:1:length(value)
        Format.checkFormat(Format.ALPHA, value{i})
    end
    
    % ALPHA formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = -1;
    wrong_value{2} = 2;
    wrong_value{3} = 'transparent';
    wrong_value{4} = [2 2 2];
    wrong_value{5} = [-1 0 0];
    wrong_value{6} = {};
	wrong_value{7} = Element();

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.ALPHA, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.MR: Check MARKER
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % MARKER formats that should be accepted
    clear value
    value{1} = 'o';
    value{2} = '+';
    value{3} = '*';
    value{4} = '.';
    value{5} = 'x';
    value{6} = '_';
    value{7} = '|';
    value{8} = 's';
    value{9} = 'd';
    value{10} = '^';
    value{11} = 'v';
    value{12} = '>';
    value{13} = '<';
    value{14} = 'p';
    value{15} = 'h';
    value{16} = 'none';

    for i = 1:1:length(value)
        Format.checkFormat(Format.MARKER, value{i})
    end
    
    % MARKER formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = '-';
    wrong_value{2} = ':';
    wrong_value{3} = '-.';
    wrong_value{4} = '--';
    wrong_value{5} = 1;
    wrong_value{6} = {};
	wrong_value{7} = Element();

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.MARKER, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.SZ: Check SIZE
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % SIZE formats that should be accepted
    clear value
    value{1} = .5;
    value{2} = 1;
    value{3} = 10;

    for i = 1:1:length(value)
        Format.checkFormat(Format.SIZE, value{i})
    end
    
    % SIZE formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = 0;
    wrong_value{2} = -1;
    wrong_value{3} = 'large';
	wrong_value{4} = Element();

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.SIZE, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end

%% Test 2.LN: Check LINE
if rand() >= (1 - .01) * BRAPH2TEST.RANDOM
    % LINE formats that should be accepted
    clear value
    value{1} = '-';
    value{2} = ':';
    value{3} = '-.';
    value{4} = '--';
    value{5} = 'none';
    
    for i = 1:1:length(value)
        Format.checkFormat(Format.LINE, value{i})
    end    

    % LINE formats that should NOT be accepted
    clear wrong_value
    wrong_value{1} = 'o';
    wrong_value{2} = '+';
    wrong_value{3} = '*';
    wrong_value{4} = '.';
    wrong_value{5} = 'x';
    wrong_value{6} = '_';
    wrong_value{7} = '|';
    wrong_value{8} = 's';
    wrong_value{9} = 'd';
    wrong_value{10} = '^';
    wrong_value{11} = 'v';
    wrong_value{12} = '>';
    wrong_value{13} = '<';
    wrong_value{14} = 'p';
    wrong_value{15} = 'h';
    wrong_value{16} = 1;
    wrong_value{17} = {};
	wrong_value{18} = Element();

    for i = 1:1:length(wrong_value)
        assert_with_error('Format.checkFormat(Format.LINE, varargin{1})', [BRAPH2.STR ':Format:' BRAPH2.WRONG_INPUT], wrong_value{i})
    end
end