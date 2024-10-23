%% ¡header!
ElementWithFigure < ConcreteElement (ef, element with figure) is an element with a figure.

%%% ¡description!
An Element with a Figure (ElementWithFigure) is an example of an element 
 that contains the handle of a figure with one panel that in turn contains 
 10 buttons.

%%% ¡seealso!
uifigure, uipanel, uibutton

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the element with figure.
%%%% ¡default!
'ElementWithFigure'

%%% ¡prop!
NAME (constant, string) is the name of the element with figure.
%%%% ¡default!
'Element with a Figure'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the element with figure.
%%%% ¡default!
'An Element with a Figure (ElementWithFigure) is an example of an element that contains the handle of a figure with one panel that in turn contains 10 buttons.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the element with figure.
%%%% ¡settings!
'ElementWithFigure'

%%% ¡prop!
ID (data, string) is a few-letter code for the element with figure.
%%%% ¡default!
'ElementWithFigure ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the element with figure.
%%%% ¡default!
'ElementWithFigure label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the element with figure.
%%%% ¡default!
'ElementWithFigure notes'


%% ¡props!

%%% ¡prop!
RANDOM_NUMBER (result, scalar) is a random number.
%%%% ¡calculate!
value = rand();

%% ¡props!

%%% ¡prop!
FIG (evanescent, handle) is the handle of a figure.
%%%% ¡calculate!
value = uifigure( ...
    'Name', 'Figure from ElementWithFigure', ...
    'Color', BRAPH2.COL ...
    );

%%% ¡prop!
PANEL (evanescent, handle) is the handle of the panel.
%%%% ¡calculate!
if ~check_graphics(ef.memorize('FIG'), 'figure')
    ef.set('FIG', Element.getNoValue());
end

fig = ef.memorize('FIG');

value = uipanel( ...
    'Parent', fig, ...
    'Units', 'normalized', ...
    'Position', [.25 .25 .50 .50], ...
    'BackgroundColor', BRAPH2.COL_BKG ...
    );

%%% ¡prop!
BUTTONS (evanescent, handlelist) is the list of handles of the buttons.
%%%% ¡calculate!
if ~check_graphics(ef.getr('PANEL'), 'uipanel')
    ef.set('PANEL', Element.getNoValue());
end

panel = ef.memorize('PANEL');

value = {};
for i = 1:1:10
    value{i} = uibutton( ...
        'Parent', panel, ...
        'Text', ['B' int2str(i)], ...
        'Position', [ ...
            (i - 1) * w(panel, 'pixels') / 10 ...
            (i - 1) * h(panel, 'pixels') / 10 ...
            w(panel, 'pixels') / 10 ...
            h(panel, 'pixels') / 10 ...
            ], ...
        'ButtonPushedFcn', {@cb_button} ...
        );
end
%%%% ¡calculate_callbacks!
function cb_button(src, ~)
    disp(src.get('Text'))
end


%% ¡tests!

%%% ¡excluded_props!
[ElementWithFigure.PANEL ElementWithFigure.BUTTONS]

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ElementWithFigure'])
assert(length(findall(0, 'type', 'figure')) == 4)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ElementWithFigure'])

%%% ¡test!
Simple test
%%%% ¡code!
ef = ElementWithFigure()

ef.memorize('BUTTONS')

close(ef.get('FIG'))
