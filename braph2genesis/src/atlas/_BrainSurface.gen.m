%% ¡header!
BrainSurface < ConcreteElement (bs, brain surface) is a brain surface.

%%% ¡description!
A Brain Surface (BrainSurface) contains the information of a brain surface.
 It provides the methods necessary to handle the brain surface data.
BrainSurface contains and manages the vertex_number, coordinates, 
 triangles_number, and triangles of a brain surface. 
    
%%% ¡seealso!
BrainAtlas, BrainRegion, BrainSurfacePF

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the brain surface.
%%%% ¡default!
'BrainSurface'

%%% ¡prop!
NAME (constant, string) is the name of the brain surface.
%%%% ¡default!
'Brain Surface'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the brain surface.
%%%% ¡default!
'A Brain Surface (BrainSurface) contains the information of a brain surface. It provides the methods necessary to handle the brain surface data. BrainSurface contains and manages the vertex_number, coordinates, triangles_number, and triangles of a brain surface.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the brain surface.
%%%% ¡settings!
'BrainSurface'

%%% ¡prop!
ID (data, string) is a few-letter code for the brain surface.
%%%% ¡default!
'BrainSurface ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the brain surface.
%%%% ¡default!
'BrainSurface label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the brain surface.
%%%% ¡default!
'BrainSurface notes'

%% ¡props!

%%% ¡prop!
VERTEX_NUMBER (data, scalar) is the number of triangle vertices of the brain surface.
%%%% ¡check_prop!
check = value >= 0;

%%% ¡prop!
COORDINATES (data, matrix) are the coordinates of the triangle vertices of the brain surface.
%%%% ¡check_prop!
check = isempty(value) || size(value, 2) == 3;
%%%% ¡check_value!
check = isequal(bs.get('VERTEX_NUMBER'), size(value, 1));
if check 
    msg = 'All ok!';
else
    msg = ['COORDINATES must have VERTEX_NUMBER (' num2str(bs.get('VERTEX_NUMBER')) ') columns while it has ' num2str(size(value, 2)) '.'];
end

%%% ¡prop!
TRIANGLES_NUMBER (data, scalar) is the number of triangles of the brain surface.
%%%% ¡check_prop!
check = value >= 0;

%%% ¡prop!
TRIANGLES (data, matrix) are the triads of coordinates of the triangles of the brain surface.
%%%% ¡check_prop!
check = isempty(value) || size(value, 2) == 3;
%%%% ¡check_value!
check = isequal(bs.get('TRIANGLES_NUMBER'), size(value, 1)) && all(all(value > 0)) && all(all(value <= bs.get('VERTEX_NUMBER')));
if check 
    msg = 'All ok!';
else
    msg = [ ...
        'TRIANGLES must have ' num2str(bs.get('TRIANGLES_NUMBER')) ' columns while it has ' num2str(size(value, 1)) '.' ...
        'The identifiers in TRIANGLES must be greater than 0 and smaller or equal to the VERTEX_NUMBER (' num2str(bs.get('VERTEX_NUMBER')) ') ' ...
        'while they are ' num2str(value) '.' ...
        ];
end