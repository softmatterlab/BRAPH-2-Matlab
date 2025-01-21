%% ¡header!
Callback < Element (cb, callback) is a callback for a property of an element.

%%% ¡class_attributes!
Sealed=true

%%% ¡description!
A callback refers to a property of another element, which are identified 
 by its properties EL and PROP/TAG.
For computational efficiency, it is best to use only one instance of Callback
 for each prop of an instance of a concrete element EL, using 
 EL.getCallback('PROP', <prop number>) or EL.getCallback('TAG', <prop tag>),
 instead of creating new callback instances using its constructor. 
No element can be a subclass of Callback.

%%% ¡seealso!
Element

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
EL (data, item) is the callback element.
%%%% ¡settings!
'ConcreteElement'

%%% ¡prop!
PROP (data, scalar) is the callback property number.
%%%% ¡postset!
el = cb.get('EL');
prop = cb.get('PROP');
if ~strcmp(cb.get('TAG'), el.getPropTag(prop))
    cb.set('TAG', el.getPropTag(prop));
end

%%% ¡prop!
TAG (data, string) is the callback property tag.
%%%% ¡postset!
el = cb.get('EL');
tag = cb.get('TAG');
if cb.get('PROP') ~= el.getPropProp(tag)
    cb.set('PROP', el.getPropProp(tag));
end

%%% ¡prop!
TOSTRING (query, string) returns a string that represents the object.
%%%% ¡calculate!
value = cb.tostring();