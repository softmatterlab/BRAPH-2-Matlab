%% ¡header!
BrainRegion < ConcreteElement (br, brain region) is a brain region.

%%% ¡description!
A Brain Region (BrainRegion) contains the information of a brain region.
 It provides the methods necessary to handle the brain regions data.
 BrainRegion contains and manages the id, label, x coordinate, y 
 coordinate, and z coordinate of a brain region. 
    
%%% ¡seealso!
BrainAtlas, BrainSurface

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the brain region.
%%%% ¡default!
'BrainRegion'

%%% ¡prop!
NAME (constant, string) is the name of the brain region.
%%%% ¡default!
'Brain Region'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the brain region.
%%%% ¡default!
'A Brain Region (BrainRegion) contains the information of a brain region. It provides the methods necessary to handle the brain regions data. BrainRegion contains and manages the id, label, x coordinate, y coordinate, and z coordinate of a brain region.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the brain region.
%%%% ¡settings!
'BrainRegion'

%%% ¡prop!
ID (data, string) is a few-letter code for the brain region.
%%%% ¡default!
'BrainRegion ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the brain region.
%%%% ¡default!
'BrainRegion label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the brain region.
%%%% ¡default!
'BrainRegion notes'

%% ¡props!

%%% ¡prop!
X (data, scalar) is the x-coordinate of the brain region.

%%% ¡prop!
Y (data, scalar) is the y-coordinate of the brain region.

%%% ¡prop!
Z (data, scalar) is the z-coordinate of the brain region.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Basic functions
%%%% ¡probability!
.01
%%%% ¡code!
br = BrainRegion('ID', 'BR1', 'LABEL', 'brain region', 'NOTES', 'Notes on brain region.', 'X', -1, 'Y', -2, 'Z', -3);

assert(ischar(br.tostring()), ...
    [BRAPH2.STR ':BrainRegion:' BRAPH2.FAIL_TEST], ...
    'BrainRegion.tostring() must return a string.')

%%% ¡test!
%%%% ¡name!
Get methods
%%%% ¡probability!
.01
%%%% ¡code!
id = 'BR1';
label = 'brain region 1';
notes = 'Notes on brain region 1.';
x = 1;
y = 2;
z = 3;
br = BrainRegion('ID', id, 'LABEL', label, 'NOTES', notes, 'X', x, 'Y', y, 'Z', z);

assert(isequal(br.get('ID'), id), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.FAIL_TEST], ...
    'BrainRegion.get() does not work.')
assert(isequal(br.get('LABEL'), label), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.FAIL_TEST], ...
    'BrainRegion.get() does not work.')
assert(isequal(br.get('NOTES'), notes), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.FAIL_TEST], ...
    'BrainRegion.get() does not work.')
assert(isequal(br.get('X'), x), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.FAIL_TEST], ...
    'BrainRegion.get() does not work.')
assert(isequal(br.get('Y'), y), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.FAIL_TEST], ...
    'BrainRegion.get() does not work.')
assert(isequal(br.get('Z'), z), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.FAIL_TEST], ...
    'BrainRegion.get() does not work.')

%%% ¡test!
%%%% ¡name!
Set methods
%%%% ¡probability!
.01
%%%% ¡code!
br = BrainRegion();
br.set('ID', 'br2');
br.set('LABEL', 'lab2');
br.set('NOTES', 'notes2');
br.set('X', 1);
br.set('Y', 2);
br.set('Z', 3);

assert(isequal(br.get('ID'), 'br2'), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.FAIL_TEST], ...
    'BrainRegion.set() does not work.')
assert(isequal(br.get('LABEL'), 'lab2'), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.FAIL_TEST], ...
    'BrainRegion.set() does not work.')
assert(isequal(br.get('NOTES'), 'notes2'), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.FAIL_TEST], ...
    'BrainRegion.set() does not work.')
assert(isequal(br.get('X'), 1), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.FAIL_TEST], ...
    'BrainRegion.set() does not work.')
assert(isequal(br.get('Y'), 2), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.FAIL_TEST], ...
    'BrainRegion.set() does not work.')
assert(isequal(br.get('Z'), 3), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.FAIL_TEST], ...
    'BrainRegion.set() does not work.')
