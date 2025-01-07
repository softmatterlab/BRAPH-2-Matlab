function hard_code_constants(filename)
%HARD_CODE_CONSTANTS hard-codes constants in BRAPH2 files.
%
% HARD_CODE_CONSTANTS(FILENAME) replaces FILENAME with a a version where
%  constants are hard-coded. It hard-codes constants relative to BRAPH2,
%  Category, Format, and properties.
%
% See also genesis, create_Element.

persistent constants %#ok<*AGROW>
if isempty(constants)
    constants = {};

    % Elements
    el_class_list = Element.getSubclasses();
    for i = 1:1:length(el_class_list)
        el_class = el_class_list{i};

        for prop = Element.getProps(el_class)
            constants{end+1, 1} = [el_class '\.getClass\(\)'];
            constants{end, 2} = ['''' el_class ''''];

            constants{end+1, 1} = [el_class '\.getProps\(\)'];
            constants{end, 2} = mat2str(Element.getProps(el_class));
            for category = Category.getCategories()
                constants{end+1, 1} = [el_class '\.getProps\(Category\.' upper(Category.getCategoryName(category)) '\)'];
                constants{end, 2} = mat2str(Element.getProps(el_class, category));
            end
            
            constants{end+1, 1} = [el_class '\.getPropNumber\(\)'];
            constants{end, 2} = int2str(Element.getPropNumber(el_class));
            for category = Category.getCategories()
                constants{end+1, 1} = [el_class '\.getPropNumber\(Category\.' upper(Category.getCategoryName(category)) '\)'];
                constants{end, 2} = int2str(Element.getPropNumber(el_class, category));
            end
            
            constants{end+1, 1} = [el_class '\.' Element.getPropTag(el_class, prop)];
            constants{end, 2} = int2str(prop);
            
            constants{end+1, 1} = [el_class '\.' Element.getPropTag(el_class, prop) '_TAG'];
            constants{end, 2} = ['''' Element.getPropTag(el_class, prop) ''''];

            constants{end+1, 1} = [el_class '\.' Element.getPropTag(el_class, prop) '_CATEGORY'];
            constants{end, 2} = int2str(Element.getPropCategory(el_class, prop));

            constants{end+1, 1} = [el_class '\.' Element.getPropTag(el_class, prop) '_FORMAT'];
            constants{end, 2} = int2str(Element.getPropFormat(el_class, prop));
        end
        
        metaclass = eval(['?' el_class]);
        property_list = metaclass.PropertyList;
        for p = 1:1:length(property_list)
            property = property_list(p);
            if property.Constant
                if ischar(property.DefaultValue)
                    constants{end+1, 1} = ['€' el_class '\.' property.Name '€'];
                    constants{end, 2} = property.DefaultValue;
                    
                    constants{end+1, 1} = [el_class '\.' property.Name];
                    constants{end, 2} = ['''' property.DefaultValue ''''];
                elseif isnumeric(property.DefaultValue)
                    constants{end+1, 1} = [el_class '\.' property.Name];
                    constants{end, 2} = mat2str(property.DefaultValue);
                elseif iscell(property.DefaultValue)
                    % do nothing because there are very few cases and rarely used.
                else
                    warning( ...
                        [BRAPH2.STR ':hard_code_constants'], ...
                        [BRAPH2.STR ':hard_code_constants\n' ...
                        'The property format of ' el_class '.' property.Name ' is not currently dealt with by hard_code_constants. '] ...
                        )
                end
                constants{end+1, 1} = ['__' el_class '\.' property.Name '__'];
                constants{end, 2} = [el_class '\.' property.Name];
            end
        end
    end
    
    % BRAPH2
    constants{end+1, 1} = '€BRAPH2\.NAME€';
    constants{end, 2} = BRAPH2.NAME;
    constants{end+1, 1} = ' BRAPH2\.NAME';
    constants{end, 2} = [' ''' BRAPH2.NAME ''''];

    constants{end+1, 1} = '€BRAPH2\.VERSION€';
    constants{end, 2} = BRAPH2.VERSION;
    constants{end+1, 1} = 'BRAPH2\.VERSION';
    constants{end, 2} = ['''' BRAPH2.VERSION ''''];

    constants{end+1, 1} = '€BRAPH2\.STR€';
    constants{end, 2} = BRAPH2.STR;
    constants{end+1, 1} = 'BRAPH2\.STR';
    constants{end, 2} = ['''' BRAPH2.STR ''''];

    constants{end+1, 1} = 'BRAPH2\.BUILD';
    constants{end, 2} = int2str(BRAPH2.BUILD);
    
    constants{end+1, 1} = 'BRAPH2\.AUTHORS';
    constants{end, 2} = ['''' regexprep(BRAPH2.AUTHORS, '''', '''''') ''''];
    
    constants{end+1, 1} = 'BRAPH2\.COPYRIGHT';
    constants{end, 2} = ['''' BRAPH2.COPYRIGHT ''''];
    
    constants{end+1, 1} = 'BRAPH2\.WEB';
    constants{end, 2} = ['''' BRAPH2.WEB ''''];

    constants{end+1, 1} = 'BRAPH2\.BLUESKY';
    constants{end, 2} = ['''' BRAPH2.BLUESKY ''''];
    
    constants{end+1, 1} = 'BRAPH2\.MATLAB_VERSION';
    constants{end, 2} = ['''' BRAPH2.MATLAB_VERSION ''''];

    constants{end+1, 1} = 'BRAPH2\.MATLAB_RELEASE';
    constants{end, 2} = ['''' BRAPH2.MATLAB_RELEASE ''''];

    constants{end+1, 1} = '€BRAPH2\.WRONG_VER€';
    constants{end, 2} = BRAPH2.WRONG_VER;
    constants{end+1, 1} = 'BRAPH2\.WRONG_VER';
    constants{end, 2} = ['''' BRAPH2.WRONG_VER ''''];

    constants{end+1, 1} = '€BRAPH2\.MISS_ADDON€';
    constants{end, 2} = BRAPH2.MISS_ADDON;
    constants{end+1, 1} = 'BRAPH2\.MISS_ADDON';
    constants{end, 2} = ['''' BRAPH2.MISS_ADDON ''''];

    constants{end+1, 1} = '€BRAPH2\.FAIL_TEST€';
    constants{end, 2} = BRAPH2.FAIL_TEST;
    constants{end+1, 1} = 'BRAPH2\.FAIL_TEST';
    constants{end, 2} = ['''' BRAPH2.FAIL_TEST ''''];

    constants{end+1, 1} = '€BRAPH2\.WRONG_INPUT€';
    constants{end, 2} = BRAPH2.WRONG_INPUT;
    constants{end+1, 1} = 'BRAPH2\.WRONG_INPUT';
    constants{end, 2} = ['''' BRAPH2.WRONG_INPUT ''''];

    constants{end+1, 1} = '€BRAPH2\.CANCEL_IO€';
    constants{end, 2} = BRAPH2.CANCEL_IO;
    constants{end+1, 1} = 'BRAPH2\.CANCEL_IO';
    constants{end, 2} = ['''' BRAPH2.CANCEL_IO ''''];

    constants{end+1, 1} = '€BRAPH2\.ERR_IO€';
    constants{end, 2} = BRAPH2.ERR_IO;
    constants{end+1, 1} = 'BRAPH2\.ERR_IO';
    constants{end, 2} = ['''' BRAPH2.ERR_IO ''''];

    constants{end+1, 1} = '€BRAPH2\.ERR_FUNC€';
    constants{end, 2} = BRAPH2.ERR_FUNC;
    constants{end+1, 1} = 'BRAPH2\.ERR_FUNC';
    constants{end, 2} = ['''' BRAPH2.ERR_FUNC ''''];

    constants{end+1, 1} = '€BRAPH2\.ERR_COPY€';
    constants{end, 2} = BRAPH2.ERR_COPY;
    constants{end+1, 1} = 'BRAPH2\.ERR_COPY';
    constants{end, 2} = ['''' BRAPH2.ERR_COPY ''''];

    constants{end+1, 1} = '€BRAPH2\.ERR_CLONE€';
    constants{end, 2} = BRAPH2.ERR_CLONE;
    constants{end+1, 1} = 'BRAPH2\.ERR_CLONE';
    constants{end, 2} = ['''' BRAPH2.ERR_CLONE ''''];

    constants{end+1, 1} = '€BRAPH2\.ERR_JSON€';
    constants{end, 2} = BRAPH2.ERR_JSON;
    constants{end+1, 1} = 'BRAPH2\.ERR_JSON';
    constants{end, 2} = ['''' BRAPH2.ERR_JSON ''''];

    constants{end+1, 1} = '€BRAPH2\.ERR_TRY€';
    constants{end, 2} = BRAPH2.ERR_TRY;
    constants{end+1, 1} = 'BRAPH2\.ERR_TRY';
    constants{end, 2} = ['''' BRAPH2.ERR_TRY ''''];

    constants{end+1, 1} = '€BRAPH2\.ERR_IOLAYOUT€';
    constants{end, 2} = BRAPH2.ERR_IOLAYOUT;
    constants{end+1, 1} = 'BRAPH2\.ERR_IOLAYOUT';
    constants{end, 2} = ['''' BRAPH2.ERR_IOLAYOUT ''''];

    constants{end+1, 1} = 'BRAPH2\.FONTSIZE';
    constants{end, 2} = int2str(BRAPH2.FONTSIZE);

    constants{end+1, 1} = 'BRAPH2\.S';
    constants{end, 2} = int2str(BRAPH2.S);

    constants{end+1, 1} = 'BRAPH2\.COL';
    constants{end, 2} = mat2str(BRAPH2.COL);

    constants{end+1, 1} = 'BRAPH2\.COL_BKG';
    constants{end, 2} = mat2str(BRAPH2.COL_BKG);

    constants{end+1, 1} = 'BRAPH2\.COL_C';
    constants{end, 2} = mat2str(BRAPH2.COL_C);

    constants{end+1, 1} = 'BRAPH2\.COL_M';
    constants{end, 2} = mat2str(BRAPH2.COL_M);

    constants{end+1, 1} = 'BRAPH2\.COL_P';
    constants{end, 2} = mat2str(BRAPH2.COL_P);

    constants{end+1, 1} = 'BRAPH2\.COL_D';
    constants{end, 2} = mat2str(BRAPH2.COL_D);

    constants{end+1, 1} = 'BRAPH2\.COL_R';
    constants{end, 2} = mat2str(BRAPH2.COL_R);

    constants{end+1, 1} = 'BRAPH2\.COL_Q';
    constants{end, 2} = mat2str(BRAPH2.COL_Q);

    constants{end+1, 1} = 'BRAPH2\.COL_E';
    constants{end, 2} = mat2str(BRAPH2.COL_E);

    constants{end+1, 1} = 'BRAPH2\.COL_F';
    constants{end, 2} = mat2str(BRAPH2.COL_F);

    constants{end+1, 1} = 'BRAPH2\.COL_G';
    constants{end, 2} = mat2str(BRAPH2.COL_G);

    % Category
    constants{end+1, 1} = 'Category\.getCategoryNumber\(\)';
    constants{end, 2} = int2str(Category.getCategoryNumber());
    for category = 1:1:Category.getCategoryNumber()
        constants{end+1, 1} = ['Category\.' upper(Category.getCategoryName(category))];
        constants{end, 2} = int2str(category);
        constants{end+1, 1} = ['__' 'Category\.' upper(Category.getCategoryName(category)) '__'];
        constants{end, 2} = ['Category\.' upper(Category.getCategoryName(category))];

        constants{end+1, 1} = ['Category\.' upper(Category.getCategoryName(category)) '_TAG'];
        constants{end, 2} = ['''' Category.getCategoryTag(category) ''''];
        constants{end+1, 1} = ['__' 'Category\.' upper(Category.getCategoryName(category)) '_TAG' '__'];
        constants{end, 2} = ['Category\.' upper(Category.getCategoryName(category)) '_TAG'];

        constants{end+1, 1} = ['Category\.' upper(Category.getCategoryName(category)) '_NAME'];
        constants{end, 2} = ['''' Category.getCategoryName(category) ''''];
        constants{end+1, 1} = ['__' 'Category\.' upper(Category.getCategoryName(category)) '_NAME' '__'];
        constants{end, 2} = ['Category\.' upper(Category.getCategoryName(category)) '_NAME'];

        constants{end+1, 1} = ['Category\.' upper(Category.getCategoryName(category)) '_DESCRIPTION'];
        constants{end, 2} = ['''' regexprep(Category.getCategoryDescription(category), '''', '''''') ''''];
        constants{end+1, 1} = ['__' 'Category\.' upper(Category.getCategoryName(category)) '_DESCRIPTION' '__'];
        constants{end, 2} = ['Category\.' upper(Category.getCategoryName(category)) '_DESCRIPTION'];
    end

    % Format
    constants{end+1, 1} = 'Format\.getFormatNumber\(\)';
    constants{end, 2} = int2str(Format.getFormatNumber());
    for format = 1:1:Format.getFormatNumber()
        constants{end+1, 1} = ['Format\.' upper(Format.getFormatName(format))];
        constants{end, 2} = int2str(format);
        constants{end+1, 1} = ['__' 'Format\.' upper(Format.getFormatName(format)) '__'];
        constants{end, 2} = ['Format\.' upper(Format.getFormatName(format))];

        constants{end+1, 1} = ['Format\.' upper(Format.getFormatName(format)) '_TAG'];
        constants{end, 2} = ['''' Format.getFormatTag(format) ''''];
        constants{end+1, 1} = ['__' 'Format\.' upper(Format.getFormatName(format)) '_TAG' '__'];
        constants{end, 2} = ['Format\.' upper(Format.getFormatName(format)) '_TAG'];

        constants{end+1, 1} = ['Format\.' upper(Format.getFormatName(format)) '_NAME'];
        constants{end, 2} = ['''' Format.getFormatName(format) ''''];
        constants{end+1, 1} = ['__' 'Format\.' upper(Format.getFormatName(format)) '_NAME' '__'];
        constants{end, 2} = ['Format\.' upper(Format.getFormatName(format)) '_NAME'];

        constants{end+1, 1} = ['Format\.' upper(Format.getFormatName(format)) '_DESCRIPTION'];
        constants{end, 2} = ['''' regexprep(Format.getFormatDescription(format), '''', '''''') ''''];
        constants{end+1, 1} = ['__' 'Format\.' upper(Format.getFormatName(format)) '_DESCRIPTION' '__'];
        constants{end, 2} = ['Format\.' upper(Format.getFormatName(format)) '_DESCRIPTION'];
    end
    
    % getCompatibleMeasures
    if exist('Graph', 'class') == 8
        graph_code_list = Graph.getSubclasses();
        for i = 1:1:length(graph_code_list)
            graph_code = graph_code_list{i};
            compatible_measures = getCompatibleMeasures(graph_code);
            constants{end+1, 1} = ['getCompatibleMeasures\(''' graph_code '''\)'];
            constants{end, 2} = ['{' sprintf(' ''%s'' ', compatible_measures{:}) '}'];
        end
    end
    
    % Fine-tuning
    constants{end+1, 1} = ' *\* *1';
    constants{end, 2} = '';

    constants{end+1, 1} = '1 *\* *';
    constants{end, 2} = '';

    constants{end+1, 1} = ' */ *1';
    constants{end, 2} = '';

    constants{end+1, 1} = ' *\+ *0';
    constants{end, 2} = '';

    constants{end+1, 1} = '0 *\+ *';
    constants{end, 2} = '';

    constants{end+1, 1} = ' *- *0';
    constants{end, 2} = '';
end

txt = fileread(filename);
delete(filename)
for i = 1:1:length(constants)
    txt = regexprep(txt, [constants{i, 1} '(\W)'], [constants{i, 2} '$1']);
    % % NOTE 
    % % the form below is more robuts (but much slower). 
    % % Not needed as long as the element names are chosen carefully.
    % % E.g., the simpler (and faster) form can create problems if
    % % OrderedMultiplex is processed after Multiplex. 
    % txt = regexprep(txt, ['(\W)' constants{i, 1} '(\W)'], ['$1' constants{i, 2} '$2']);
end
txt = regexprep(txt, '%', '%%');
txt = regexprep(txt, '\\', '\\\\');

% hard code s(#)
token_extents = regexp(txt, '\W(s\([\d\.]*\))', 'tokenExtents');
for j = length(token_extents):-1:1
    token_extent = token_extents{j};
    txt = [txt(1:token_extent(1)-1) num2str(eval(txt(token_extent(1):token_extent(2)))) txt(token_extent(2)+1:end)];
end

% warnings
[~, el_class, ~] = fileparts(filename);
txt = regexprep(txt, '%%%%%%__WARN_TBI__', ...
    [ ...
    'warning([BRAPH2.STR '':' el_class '''], [BRAPH2.STR '':' el_class ' \\\\nThis functionality is not implemented yet.\\\\nYou can contact the BRAPH2 developers and ask for it, \\\\nor, even better, implement it yourself and share it with the community!''])' ...
    ]);

object_file = fopen(filename, 'w');
fprintf(object_file, txt);
fclose(object_file);

end
