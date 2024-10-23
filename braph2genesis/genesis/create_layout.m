function create_layout(generator_file, target_dir)
%CREATE_LAYOUT creates the layout of an element.
%
% CREATE_LAYOUT(FILE, DIR) creates the layout-file with the layout of an 
%  Element from its generator file FILE (with ending '.gen.m') and saves it
%  in the target directory DIR.
%
% The structure of the generator file can be found in <a href="matlab:help create_Element">create_Element</a>.
%
% See also genesis, create_Element.

txt = fileread(generator_file);

disp(['¡ source file: ' generator_file])
disp(['¡ target dir: ' target_dir])
disp('¡! generator file read')

%% Analysis
header = getToken(txt, 'header');
res = regexp(header, ...
    ['^\s*(?<class_name>\w*)\s*<\s*(?<superclass_name>\w*)' ...
     '\s*\(\s*(?<moniker>\w*)\s*,\s*(?<descriptive_name>[^)]*)\)' ...
     '\s*(?<header_description>[^.]*)\.'], ...
     'names' ...
     );
class_name = res.class_name;

element_created = exist(class_name, 'class') == 8;

%% Layout Generation
layout = getToken(txt, 'layout');
if ~isempty(layout) && element_created
    
    [order, title] = load_layout(class_name);
    order = order * NaN;
	
    props = getTokens(txt, 'layout', 'prop');
    for i = 1:1:numel(props)
        prop_id = eval(getToken(props{i}.token, 'id'));
        order(prop_id) = i;
        title{prop_id} = getToken(props{i}.token, 'title');
    end
    
    save_layout(class_name, order, title)
    
    disp(['¡! saved layout ' class_name])
end

%% Separator
disp(' ')

end