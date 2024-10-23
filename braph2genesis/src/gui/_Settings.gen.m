%% ¡header!
Settings < ConcreteElement (st, graphics settings) contains some graphics settings.

%%% ¡description!
A Graphics Settings (Settings) provides the base element for all graphics settings.
 Typically, only its subclasses are employed.

 The graphics objects is identified by its handle(list), which can be retrieved as:
 
    h = st.get('<strong>H</strong>');
    
 It returns an empty object identifier if the graphical object handle has not been 
  set yet.
    
 The handle can be set by setting the props PANEL and PROP (or TAG) for props 
  of Format.HANDLE, and PANEL, PROP (or TAG) and I for props of Format.HANDLELIST.
 
The initial setup of the figure props (initial postset) can be done by calling:

    st.get('<strong>SETUP</strong>')

Typically, it is used as a prop of a subclass of Panel (pn) and it is 
 initialized in the prop DRAW with a code smiliar to this:

	pn.set(''ST'', Settings(''PANEL'', pn, ''PROP'', prop[, ''I'', i]) % preferred
	pn.set(''ST'', Settings(''PANEL'', pn, ''TAG'', tag[, ''I'', i])
 
  The option with PROP is to be preferred, because it is faster.

 It might be necessary to add some listeners (e.g., to update toogle buttons).

%%% ¡seealso!
Panel, listener

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the graphics settings.
%%%% ¡default!
'Settings'

%%% ¡prop!
NAME (constant, string) is the name of the graphics settings.
%%%% ¡default!
'Graphics Settings'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the graphics settings.
%%%% ¡default!
'A Graphics Settings (Settings) provides the base element for all graphics settings. Typically, only its subclasses are employed.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the line graphics settings.
%%%% ¡settings!
'Settings'

%%% ¡prop!
ID (data, string) is a few-letter code for the graphics settings.
%%%% ¡default!
'Settings ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graphics settings.
%%%% ¡default!
'Settings label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graphics settings.
%%%% ¡default!
'Settings notes'

%% ¡props!

%%% ¡prop!
PANEL (gui, item) is the panel to which the graphics object belongs.
%%%% ¡settings!
'Panel'

%%% ¡prop!
PROP (gui, scalar) is the prop of the graphics handle(list).
%%%% ¡default!
Panel.H
%%%% ¡postset!
pn = st.get('PANEL');
prop = st.get('PROP');
if ~strcmp(st.get('TAG'), pn.getPropTag(prop))
    st.set('TAG', pn.getPropTag(prop));
end
%%%% ¡check_value!
check = st.get('PANEL').getPropCategory(value) == Category.EVANESCENT && any(st.get('PANEL').getPropFormat(value) == [Format.HANDLE Format.HANDLELIST]);
if check
    msg = 'All ok';
else
    msg = ['The PROP ' tostring(value) ') must be evanescent handle(list), ' ...
        'while it is ' Category.getCategoryName(st.get('PANEL').getPropCategory(value)) ...
        ' ' Format.getFormatName(st.get('PANEL').getPropFormat(value)) '.'];
end

%%% ¡prop!
TAG (gui, string) is the tag of the graphics handle(s).
%%%% ¡default!
'H'
%%%% ¡postset!
pn = st.get('PANEL');
tag = st.get('TAG');
if st.get('PROP') ~= pn.getPropProp(tag)
    st.set('PROP', pn.getPropProp(tag));
end
%%%% ¡check_value!
check = st.get('PANEL').getPropCategory(value) == Category.EVANESCENT && any(st.get('PANEL').getPropFormat(value) == [Format.HANDLE Format.HANDLELIST]);
if check
    msg = 'All ok';
else
    msg = ['The PROP ' tostring(value) ') must be evanescent handle(list), ' ...
        'while it is ' Category.getCategoryName(st.get('PANEL').getPropCategory(value)) ...
        ' ' Format.getFormatName(st.get('PANEL').getPropFormat(value)) '.'];
end

%%% ¡prop!
I (gui, scalar) is the index of the handle, used only by handlelists.

%%% ¡prop!
H (query, handle) is the graphics object handle.
%%%% ¡calculate!
pn = st.get('PANEL');
prop = st.get('PROP');
switch pn.getPropFormat(prop)
    case Format.HANDLE
        if ~isa(pn.getr(prop), 'NoValue')
            value = pn.get(prop);
        else
            value = gobjects(1);
        end
        
    case Format.HANDLELIST
        if ~isa(pn.getr(prop), 'NoValue') && ~isa(st.getr('I'), 'NoValue')
            i = st.get('I');
            handlelists = pn.get(prop);
            value = handlelists{i};
        else
            value = gobjects(1);
        end
end

%%% ¡prop!
SETUP (query, scalar) sets all figure props.
%%%% ¡calculate!
figure_props = st.getProps(Category.FIGURE);
settings = cell(1, 2 * length(figure_props));
for i = 1:1:length(figure_props)
    figure_prop = figure_props(i);
    settings{2 * i - 1} = figure_prop;
    settings{2 * i} = st.get(figure_prop);
end
st.set(settings{:})
value = length(figure_props);