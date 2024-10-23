%% ¡header!
ConcreteElement < Element (el, concrete element) is the base class for all concrete elements.

%%% ¡description!
A Concrete Element (ConcreteElement) provides the infrastructure necessary 
 for all concrete elements. In particular, it has the constant properties 
 ELCLASS (string), NAME (string) and DESCRIPTION (string), the property 
 TEMPLATE (item), the indexing properties ID (string), LABEL (string), 
 and NOTES (string), and the query prop TOSTRING (string).
Even though it is possible to create instances of ConcreteElement, 
 typically one uses its subclasses.

%%% ¡seealso!
NoValue, Callback

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
ELCLASS (constant, string) is the class of the concrete element (ConcreteElement).
%%%% ¡default!
'ConcreteElement'

%%% ¡prop!
NAME (constant, string) is the name of the concrete element.
%%%% ¡default!
'Concrete Element'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the concrete element.
%%%% ¡default!
'A Concrete Element (ConcreteElement) provides the infrastructure necessary for all concrete elements. In particular, it has the constant properties NAME (string) and DESCRIPTION (string), the property TEMPLATE (item), and the indexing properties ID (string), LABEL (string), and NOTES (string). Even though it is possible to create instances of ConcreteElement, typically one uses its subclasses.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the concrete element.
%%%% ¡settings!
'ConcreteElement'
%%%% ¡preset!
if ~isa(el, class(value))
    error( ...
        [BRAPH2.STR ':' class(el) ':' BRAPH2.WRONG_INPUT], ...
        [BRAPH2.STR ':' class(el) ':' BRAPH2.WRONG_INPUT '\\n' ...
        'The element (' class(el) ') must be a template (' class(value) ').'] ...
        )
end
%%%% ¡postset!
template = el.get('TEMPLATE');

parameter_props = template.getProps(Category.PARAMETER);
parameter_props = parameter_props(parameter_props ~= template.TEMPLATE);

varargin = cell(1, 2 * length(parameter_props));
for i = 1:1:length(parameter_props)
    parameter_prop = parameter_props(i);
    varargin{2 * i - 1} = parameter_prop;
    varargin{2 * i} = template.getCallback(parameter_prop);    
end

warning_backup = warning('off', [BRAPH2.STR ':' class(el)]);
el.set(varargin{:});
warning(warning_backup)

%%% ¡prop!
ID (data, string) is a few-letter code for the concrete element.
%%%% ¡default!
'ConcreteElement ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the concrete element.
%%%% ¡default!
'ConcreteElement label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the concrete element.
%%%% ¡default!
'ConcreteElement notes'
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', el, 'PROP', ConcreteElement.NOTES, varargin{:});

%%% ¡prop!
TOSTRING (query, string) returns a string that represents the concrete element.
%%%% ¡calculate!
value = el.tostring();

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Copy with callbacks
%%%% ¡probability!
.01
%%%% ¡code!
el_0 = ConcreteElement('ID', 'original');
el_1 = ConcreteElement('ID', el_0.getCallback('ID'));

el_1_copy = el_1.copy();
el_0_copy = el_1_copy.getr('ID').get('EL');

assert(isequal(el_0, el_0_copy))
assert(isequal(el_1, el_1_copy))
assert(el_1.getr('ID') == el_0.getCallback('ID'))

assert(el_0 ~= el_0_copy)
assert(el_1 ~= el_1_copy)
assert(el_1_copy.getr('ID') == el_0_copy.getCallback('ID'))

el_0_copy.set('ID', 'copied')
assert(strcmp(el_1_copy.get('ID'), 'copied'))