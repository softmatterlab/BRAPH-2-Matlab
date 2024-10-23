%% ¡header!
IndexedDictionary < ConcreteElement (idict, indexed dictionary) is an indexed dictionary.

%%% ¡description!
An Indexed Dictionary (IndexedDictionary) provides the methods necessary 
 to handle data in an indexed dictionary. It contains and manages an 
 ordered list of couples {KEY, IT}, where KEY is a unique alphanumeric key 
 (a string) provided by a property of format STRING or CLASS and of 
 category PARAMETER or DATA, and IT is an element of a class defined in the 
 constructor using the property IT_CLASS.

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the indexed dictionary (IndexedDictionary).
%%%% ¡default!
'IndexedDictionary'

%%% ¡prop!
NAME (constant, string) is the name of the indexed dictionary.
%%%% ¡default!
'Indexed Dictionary'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the indexed dictionary.
%%%% ¡default!
'An Indexed Dictionary (IndexedDictionary) provides the methods necessary to handle data in an indexed dictionary. It contains and manages an ordered list of couples {KEY, IT}, where KEY is a unique alphanumeric key (a string) provided by a property of format STRING or CLASS and of category PARAMETER or DATA, and IT is an element of a class defined in the constructor using the property IT_CLASS.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the indexed dictionary.
%%%% ¡settings!
'IndexedDictionary'

%%% ¡prop!
ID (data, string) is a few-letter code for the indexed dictionary.
%%%% ¡default!
'IndexedDictionary ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the indexed dictionary.
%%%% ¡default!
'IndexedDictionary label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the indexed dictionary.
%%%% ¡default!
'IndexedDictionary notes'

%% ¡props!

%%% ¡prop!
IT_CLASS (parameter, class) is the class of the item elements.

%%% ¡prop!
IT_KEY (parameter, scalar) is the property of the elements to be used as key (its category must be parameter or data, and its format must be string or class).
%%%% ¡default!
ConcreteElement.ID
%%%% ¡preset!
it_class = idict.get('IT_CLASS');
category = Element.getPropCategory(it_class, value);
format = Element.getPropFormat(it_class, value);
if ~(any(format == [Format.STRING Format.CLASS]) && any(category == [Category.CONSTANT Category.PARAMETER Category.DATA]))
    error( ...
        [BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT], ...
        [BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT '\\n' ...
        'The format of property ''IT_KEY'' must be ''' int2str(Format.STRING) ''' or ''' int2str(Format.CLASS) ''' (it is ''' int2str(format) ''').\\n' ...
        'Its category must be ''' int2str(Category.CONSTANT) ''', ''' int2str(Category.PARAMETER) ''' or ''' int2str(Category.DATA) ''' (it is ''' int2str(category) ''').'] ...
        )
end

%%% ¡prop!
IT_LIST (data, itemlist) is the list containing the items.
%%%% ¡preset!
if ~all(cellfun(@(x) isa(x, idict.get('IT_CLASS')), idict.get('IT_LIST')))
    error( ...
        [BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT], ...
        [BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT '\\n' ...
        'All items of ''IT_LIST'' must be ' idict.get('IT_CLASS') '.'] ...
        )
end

%%% ¡prop!
LENGTH (query, scalar) returns the number of items in the indexed dictionary.
%%%% ¡calculate!
value = length(idict.get('IT_LIST')); 
% length = value

%%% ¡prop!
CONTAINS (query, logical) checks whether an item exists in an indexed dictionary.
%%%% ¡calculate!
% BOOL = idict.get('CONTAINS', POINTER) returns true if POINTER (index, key
%  or item) exists in the indexed dictionary.
if isempty(varargin)
    value = false;
    return
end    
pointer = varargin{1};

if isa(pointer, 'numeric')  % pointer is index
    value = idict.get('CONTAINS_INDEX', pointer);
elseif isa(pointer, 'char')  % pointer is key
    value = idict.get('CONTAINS_KEY', pointer);
elseif isa(pointer, idict.get('IT_CLASS'))  % pointer is item - not necessarily unique
    value = idict.get('CONTAINS_IT', pointer);
else
    value = false;
end
% bool = value

%%% ¡prop!
CONTAINS_INDEX (query, logical) checks whether an index exists in an indexed dictionary.
%%%% ¡calculate!
% BOOL = idict.get('CONTAINS_INDEX', INDEX) returns true if the INDEX exists in
%  the indexed dictionary.
if isempty(varargin)
    value = false;
    return
end
index = varargin{1};

value = index >= 1 && index <= idict.get('LENGTH') && round(index) == index;
% bool = value

%%% ¡prop!
CONTAINS_KEY (query, logical) checks whether a key exists in an indexed dictionary.
%%%% ¡calculate!
% BOOL = idict.get('CONTAINS_KEY', KEY) returns true if the KEY exists in
%  the indexed dictionary.
if isempty(varargin)
    value = false;
    return
end
key = varargin{1};

it_key = idict.get('IT_KEY');
value = any(cellfun(@(it) strcmp(it.get(it_key), key), idict.get('IT_LIST')));
% bool = value

%%% ¡prop!
CONTAINS_IT (query, logical) checks whether an item exists in an indexed dictionary
%%%% ¡calculate!
% BOOL = idict.get('CONTAINS_IT', IT) returns true if IT exists in
%  the indexed dictionary.
if isempty(varargin)
    value = false;
    return
end
item = varargin{1};

value = any(cellfun(@(it) it == item, idict.get('IT_LIST')));
% bool = value

%%% ¡prop!
INDEX (query, scalar) returns the index of a key or item.
%%%% ¡calculate!
% INDEX = idict.get('INDEX', POINTER) returns the index of a POINTER (a key
%  or item).
if isempty(varargin)
    value = -1;
    return
end
pointer = varargin{1};

if isa(pointer, 'numeric')  % pointer is index
    value = pointer;
elseif isa(pointer, 'char')  % pointer is key
    value = idict.get('INDEX_FROM_KEY', pointer);
elseif isa(pointer, idict.get('IT_CLASS'))  % pointer is item - not necessarily unique
    value = idict.get('INDEX_FROM_IT', pointer);
end
% index = value

%%% ¡prop! 
INDEX_FROM_KEY (query, scalar) returns the index of a key.
%%%% ¡calculate!
% INDEX = idict.get('INDEX_FROM_KEY', KEY) returns the index of KEY.
if isempty(varargin)
    value = -1;
    return
end
key = varargin{1};

value = find(strcmp(key, idict.get('KEYS')));
% index = value 
% error if idict does not contain the key

%%% ¡prop! 
INDEX_FROM_IT (query, scalar) returns the index of an item.
%%%% ¡calculate!
% INDEX = idict.get('INDEX_FROM_IT', IT) returns the index of the first
% occurrence of item IT.
if isempty(varargin)
    value = -1;
    return
end
item = varargin{1};

value = find(cellfun(@(it) it == item, idict.get('IT_LIST'))); % return the first occurrence
% index = value 
% error if idict does not contain the item

%%% ¡prop! 
KEYS (query, stringlist) returns all the keys in the indexed dictionary.
%%%% ¡calculate!
it_key = idict.get('IT_KEY');
value = cellfun(@(it) it.get(it_key), idict.get('IT_LIST'), 'UniformOutput', false);
% keys = value

%%% ¡prop!
KEY (query, string) returns the key of an index or item.
%%%% ¡calculate!
% KEY = idict.get('KEY', POINTER) returns the key of POINTER (an index or
%  item). If the POINTER is an item, it returns the first occurrence.
if isempty(varargin)
    value = '';
    return
end
pointer = varargin{1};

if isa(pointer, idict.get('IT_CLASS'))  % pointer is item - not necessarily unique
   value = idict.get('KEY_FROM_IT', pointer);  % first occurrence
else  % pointer is an index
    it_list = idict.get('IT_LIST');
    value = it_list{pointer}.get(idict.get('IT_KEY'));
end
% key = value

%%% ¡prop!
KEY_FROM_INDEX (query, string) returns the key of an index
%%%% ¡calculate!
% KEY = idict.get('KEY_FROM_INDEX', INDEX) returns the key of INDEX.
if isempty(varargin)
    value = '';
    return
end
index = varargin{1};

it_list = idict.get('IT_LIST');
value = it_list{index}.get(idict.get('IT_KEY'));
% key = value % error if index does not exist

%%% ¡prop!
KEY_FROM_IT (query, string) returns the key of an item.
%%%% ¡calculate!
% KEY = get('KEY_FROM_IT', IT) returns the key of the first occurrence
%  of item IT.
if isempty(varargin)
    value = '';
    return
end
item = varargin{1};

it_list = idict.get('IT_LIST');
value = it_list{idict.get('INDEX_FROM_IT', item)}.get(idict.get('IT_KEY'));
% key = value % error if idict does not contain the item

%%% ¡prop!
IT (query, item) returns the item of an index or key.
%%%% ¡calculate!
% IT = idict.get('IT', POINTER) returns the item of POINTER (an index or key).
if isempty(varargin)
    value = ConcreteElement();
    return
end
pointer = varargin{1};

if isa(pointer, 'char')  % pointer is a key
    value = idict.get('IT_FROM_KEY', pointer);
else  % pointer is an index
    value = idict.get('IT_FROM_INDEX', pointer);
end
% item = value

%%% ¡prop!
IT_FROM_INDEX (query, item) returns the item of an index.
%%%% ¡calculate!
% IT = idict.get('IT_FROM_INDEX', INDEX) returns the item of INDEX.
if isempty(varargin)
    value = ConcreteElement();
    return
end
index = varargin{1};

it_list = idict.get('IT_LIST');
value = it_list{index};
% item = value % error if the index does not exist

%%% ¡prop!
IT_FROM_KEY (query, item) returns the item of a key.
%%%% ¡calculate!
% IT = idict.get('IT_FROM_KEY', KEY) returns the item of KEY.
if isempty(varargin)
    value = ConcreteElement();
    return
end
key = varargin{1};

it_list = idict.get('IT_LIST');
value = it_list{idict.get('INDEX_FROM_KEY', key)};
% item = value % error if idict does not contain the key

%%% ¡prop!
ADD (query, empty) adds an item and key to an indexed dictionary
%%%% ¡calculate!
% idict.get('ADD', IT, INDEX) adds an item and key to the indexed
%  dictionary in position INDEX. If INDEX is empty, it adds it to the end
%  of IDICT.
if isempty(varargin)
    value = [];
    return
end
item = varargin{1};
if length(varargin) == 2
    index = varargin{2};
else
    index = idict.get('LENGTH') + 1;
end

if index <= 0 || index > idict.get('LENGTH')
    index = idict.get('LENGTH') + 1;
end

if ~isa(item, idict.get('IT_CLASS'))
    error(...
        [BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_INPUT], ...
        [BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_INPUT '\\n' ...
        'Item must be an object of class ' idict.get('IT_CLASS') ',' ...
        ' while it is of class ' class(item) '.'] ...
        )
end
if idict.get('CONTAINS_KEY', item.get(idict.get('IT_KEY'))) % key = item.get(idict.get('IT_KEY'))
    error( ...
        [BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_INPUT], ...
        [BRAPH2.STR ':' class(idict) ':' BRAPH2.WRONG_INPUT '\\n' ...
        'Key ''' item.get(idict.get('IT_KEY')) ''' is already contained in the indexed dictionary.'] ... % key = item.get(idict.get('IT_KEY'))
        )
end

it_list = idict.get('IT_LIST');
if index <= idict.get('LENGTH')  
    % create space for {key, item}
    it_list(index + 1:end + 1) = it_list(index:end);
    it_list{index} = item;
else
    it_list{end + 1} = item;
end
idict.set('IT_LIST', it_list)

value = [];

%%% ¡prop!
REMOVE (query, empty) removes a key and item from an indexed dictionary.
%%%% ¡calculate!
% idict.get('REMOVE', POINTER) removes the key and item of POINTER (an
%  index, key or item) from the indexed dictionary IDICT.
if isempty(varargin)
    value = [];
    return
end
pointer = varargin{1};

index = idict.get('INDEX', pointer);

it_list = idict.get('IT_LIST');
it_list(index) = [];
idict.set('IT_LIST', it_list);

value = [];

%%% ¡prop!
REPLACE (query, empty) replaces an item and key in an indexed dictionary.
%%%% ¡calculate!
% idict.get('REPLACE', NEW_IT, INDEX) replaces the item and key of INDEX
%  in the indexed dictionary IDICT with item NEW_IT.
if isempty(varargin)
    value = [];
    return
end
new_item = varargin{1};
index = varargin{2};

if ~isa(new_item, idict.get('IT_CLASS'))
    error( ...
        [BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT], ...
        ['The item class must be ' idict.get('IT_CLASS') '.'] ...
        )
end

if idict.get('CONTAINS', index)
    idict.get('REMOVE', index)
    idict.get('ADD', new_item, index)
end

value = [];

%%% ¡prop!
REPLACE_KEY (query, empty) replaces key in indexed dictionary.
%%%% ¡calculate!
% idict.get('REPLACE_KEY', OLD_KEY, NEW_KEY) replaces OLD_KEY in the
%  indexed dictionary IDICT with NEW_KEY.
if isempty(varargin)
    value = [];
    return
end
old_key = varargin{1};
new_key = varargin{2};

if ~idict.get('CONTAINS', new_key)
    item = idict.get('IT_FROM_KEY', old_key);
    item.set(idict.get('IT_KEY'), new_key)
end

value = [];

%%% ¡prop!
REPLACE_IT (query, empty) replaces item in indexed dictionary.
%%%% ¡calculate!
% idict.get('REPLACE_IT', OLD_IT, NEW_IT) replaces OLD_IT with
%  NEW_IT in the indexed dictionary IDICT. It replaces only the first
%  occurrence of OLD_IT.
if isempty(varargin)
    value = [];
    return
end
old_it = varargin{1};
new_it = varargin{2};

index = idict.get('INDEX_FROM_IT', old_it);
idict.get('REPLACE', new_it, index);

value = [];

%%% ¡prop!
INVERT (query, empty) inverts position of two items in indexed dictionary.
%%%% ¡calculate!
% idict.get('INVERT', INDEXI, INDEXJ) inverts the positions of the items at
%  INDEX_I and INDEX_J in the indexed dictionary IDICT.
if isempty(varargin)
    value = [];
    return
end
i = varargin{1};
j = varargin{2};

if i > j
    if i > 0 && i <= idict.get('LENGTH') && j > 0 && j <= idict.get('LENGTH') && i ~= j
        item_i = idict.get('IT', i);
        item_j = idict.get('IT', j);

        idict.get('REMOVE', i)
        idict.get('REMOVE', j)

        idict.get('ADD', item_i, j);
        idict.get('ADD', item_j, i);
    end
elseif i ~= j
    idict.get('INVERT', j, i);
end

value = [];

%%% ¡prop!
MOVE_TO (query, empty) moves an item of an indexed dictionary to another position.
%%%% ¡calculate!
% idict.get('MOVE_TO', OLD_INDEX, NEW_INDEX) moves an item from position
%  OLD_INDEX to position NEW_INDEX in the indexed dictionary IDICT.
if isempty(varargin)
    value = [];
    return
end
i = varargin{1};
j = varargin{2};

if i > 0 && i <= idict.get('LENGTH') && j > 0 && j <= idict.get('LENGTH') && i ~= j
    item = idict.get('IT', i);
    idict.get('REMOVE', i)
    idict.get('ADD', item, j)
end

value = [];

%%% ¡prop!
REMOVE_ALL (query, rvector) removes selected items.
%%%% ¡calculate!
% SELECTED = idict.get('REMOVE_ALL', SELECTED) removes all items whose
%  positions in the indexed dictionary DICT are included in the array
%  SELECTED. It returns an empty array.
if isempty(varargin)
    value = [];
    return
end
selected = varargin{1};

for i = length(selected):-1:1
    idict.get('REMOVE', selected(i))
end
value = []; % selected = value;

%%% ¡prop!
MOVE_UP (query, rvector) moves up selected items.
%%%% ¡calculate!
% SELECTED = idict.get('MOVE_UP', SELECTED) moves up by one position all
%  items whose positions in the indexed dictionary DICT are included in the
%  SELECTED array and returns their final positions.
if isempty(varargin)
    value = [];
    return
end
selected = varargin{1};

if ~isempty(selected)
    first_index_to_process = 1;
    unprocessable_length = 1;
    while first_index_to_process <= idict.get('LENGTH') ...
            && first_index_to_process <= numel(selected) ...
            && selected(first_index_to_process) == unprocessable_length
        first_index_to_process = first_index_to_process + 1;
        unprocessable_length = unprocessable_length + 1;
    end

    for i = first_index_to_process:1:numel(selected)
        idict.get('INVERT', selected(i), selected(i)-1);
        selected(i) = selected(i) - 1;
    end
end

value = selected;

%%% ¡prop!
MOVE_DOWN (query, rvector) moves down selected items.
%%%% ¡calculate!
% SELECTED = idict.get('MOVE_DOWN', SELECTED) moves down by one position
%  all items whose positions in the indexed dictionary DICT are included in
%  the SELECTED array and returns their final positions.  
if isempty(varargin)
    value = [];
    return
end
selected = varargin{1};

if ~isempty(selected)
    last_index_to_process = numel(selected);
    unprocessable_length = idict.get('LENGTH');
    while last_index_to_process > 0 ...
            && selected(last_index_to_process) == unprocessable_length
        last_index_to_process = last_index_to_process - 1;
        unprocessable_length = unprocessable_length - 1;
    end

    for i = last_index_to_process:-1:1
        idict.get('INVERT', selected(i), selected(i) + 1);
        selected(i) = selected(i) + 1;
    end
end

value = selected;

%%% ¡prop!
MOVE_TO_TOP (query, empty) moves selected items to top.
%%%% ¡calculate!
% SELECTED = idict.get('MOVE_TO_TOP', SELECTED) moves to top all items
%  whose positions in the indexed dictionary DICT are included in the
%  SELECTED array and returns their final positions.
if isempty(varargin)
    value = [];
    return
end
selected = varargin{1};

if ~isempty(selected)
    for i = 1:1:numel(selected)
        idict.get('MOVE_TO', selected(i), i);
    end
    selected = reshape(1:1:numel(selected), size(selected));
end

value = selected;

%%% ¡prop!
MOVE_TO_BOTTOM (query, rvector) moves selected items to bottom.
%%%% ¡calculate!
% SELECTED = idict.get('MOVE_TO_BOTTOM', SELECTED) moves to bottom all
%  items whose positions in the indexed dictionary DICT dictionary are
%  included in the SELECTED array and returns their final positions.
if isempty(varargin)
    value = [];
    return
end
selected = varargin{1};

idict_length = idict.get('LENGTH');
if ~isempty(selected)
    for i = numel(selected):-1:1
        idict.get('MOVE_TO', selected(i), idict_length - (numel(selected)-i));
    end
    selected = reshape(idict_length - numel(selected)+1:1:idict_length, size(selected));
end

value = selected;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Instantiation with items
%%%% ¡probability!
.01
%%%% ¡code!
it1 = IndexedDictionary('ID', 'item_1');
it2 = IndexedDictionary('ID', 'item_2');
it3 = IndexedDictionary('ID', 'item_3');
it4 = IndexedDictionary('ID', 'item_4');
it5 = IndexedDictionary('ID', 'item_5');
it6 = IndexedDictionary('ID', 'item_6');

items = {it1, it2, it3, it4, it5, it6};

assert_with_error( ...
    ['idict = IndexedDictionary(' ...
    '''ID'', ''Trial Indexed Dictionary'', ' ...
    '''IT_CLASS'', ''IndexedDictionary'', ' ...
    '''IT_KEY'', IndexedDictionary.getPropProp(''ID''), ' ...
    '''IT_LIST'', {varargin{1}, varargin{2}, varargin{3}, varargin{4}, varargin{5}, Element.getNoValue()}' ...
    ');'], ...
    [BRAPH2.STR ':IndexedDictionary:' BRAPH2.WRONG_INPUT], ...
    it1, it2, it3, it4, it5 ...
    )

idict = IndexedDictionary( ...
    'ID', 'Trial Indexed Dictionary', ...
    'IT_CLASS', 'IndexedDictionary', ...
    'IT_KEY', IndexedDictionary.getPropProp('ID'), ...
    'IT_LIST', items ...
    );

%%% ¡test!
%%%% ¡name!
Inspection
%%%% ¡probability!
.01
%%%% ¡code!
it1 = IndexedDictionary('ID', 'Key 1');
it2 = IndexedDictionary('ID', 'Key 2');
it3 = IndexedDictionary('ID', 'Key 3');
it4 = IndexedDictionary('ID', 'Key 4');
it5 = IndexedDictionary('ID', 'Key 5');
it6 = IndexedDictionary('ID', 'Key 6');

items = {it1, it2, it3, it4, it5, it6};
keys = cellfun(@(item) item.get('ID'), items, 'UniformOutput', false);

idict = IndexedDictionary( ...
    'ID', 'Trial Indexed Dictionary', ...
    'IT_CLASS', 'IndexedDictionary', ...
    'IT_KEY', IndexedDictionary.getPropProp('ID'), ...
    'IT_LIST', items ...
    );

assert(isequal(idict.get('LENGTH'), 6), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''LENGTH'') does not work.')

assert(isequal(idict.get('CONTAINS_INDEX', 2), true), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''CONTAINS_INDEX'', index) does not work.')
assert(isequal(idict.get('CONTAINS', 2), true), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''CONTAINS'', index) does not work.')
assert(isequal(idict.get('CONTAINS_INDEX', -1), false), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''CONTAINS_INDEX'', index) does not work.')
assert(isequal(idict.get('CONTAINS', -1), false), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''CONTAINS'', index) does not work.')
assert(isequal(idict.get('CONTAINS_INDEX', 7), false), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''CONTAINS_INDEX'', index) does not work.')
assert(isequal(idict.get('CONTAINS', 7), false), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''CONTAINS'', index) does not work.')

assert(isequal(idict.get('CONTAINS_KEY', 'Key 3'), true), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''CONTAINS_KEY'', key) does not work.')
assert(isequal(idict.get('CONTAINS', 'Key 3'), true), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''CONTAINS'', key) does not work.')
assert(isequal(idict.get('CONTAINS_KEY', 'Key -1'), false), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''CONTAINS_KEY'', key) does not work.')
assert(isequal(idict.get('CONTAINS', 'Key -1'), false), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''CONTAINS'', key) does not work.')
assert(isequal(idict.get('CONTAINS_KEY', 'Key 7'), false), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''CONTAINS_KEY'', key) does not work.')
assert(isequal(idict.get('CONTAINS', 'Key 7'), false), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''CONTAINS'', key) does not work.')

assert(isequal(idict.get('CONTAINS_IT', it4), true), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''CONTAINS_IT'', item) does not work.')
assert(isequal(idict.get('CONTAINS', it4), true), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''CONTAINS'', item) does not work.')
assert(isequal(idict.get('CONTAINS_IT', IndexedDictionary()), false), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''CONTAINS_IT'', item) does not work.')
assert(isequal(idict.get('CONTAINS', IndexedDictionary()), false), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''CONTAINS'', item) does not work.')
assert(isequal(idict.get('CONTAINS_IT', ConcreteElement()), false), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''CONTAINS_IT'', item) does not work.')
assert(isequal(idict.get('CONTAINS', ConcreteElement()), false), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''CONTAINS'', item) does not work.')

assert(isequal(idict.get('INDEX_FROM_KEY', 'Key 1'), 1), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''INDEX_FROM_KEY'', key) does not work.')
assert(isequal(idict.get('INDEX', 'Key 1'), 1), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''INDEX'', key) does not work.')
assert(isequal(idict.get('INDEX_FROM_IT', it4), 4), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''INDEX_FROM_IT'', item) does not work.')
assert(isequal(idict.get('INDEX', it4), 4), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''INDEX'', item) does not work.')

assert(isequal(idict.get('KEYS'), keys), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''KEYS'') does not work.')
assert(isequal(idict.get('KEY_FROM_INDEX', 2), 'Key 2'), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''KEY_FROM_INDEX'', index) does not work.')
assert(isequal(idict.get('KEY', 2), 'Key 2'), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''KEY'', index) does not work.')
assert(isequal(idict.get('KEY_FROM_IT', it2), 'Key 2'), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''KEY_FROM_IT'', item) does not work.')
assert(isequal(idict.get('KEY', it2), 'Key 2'), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''KEY'', item) does not work.')

assert(isequal(idict.get('IT_LIST'), items), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''IT_LIST'') does not work.')
assert(isequal(idict.get('IT_FROM_INDEX', 3), it3), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''IT_FROM_INDEX'', index) does not work.')
assert(isequal(idict.get('IT', 3), it3), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''IT'', index) does not work.')
assert(isequal(idict.get('IT_FROM_KEY', 'Key 3'), it3), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''IT_FROM_KEY'', key) does not work.')
assert(isequal(idict.get('IT', 'Key 3'), it3), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''IT'', key) does not work.')

%%% ¡test!
%%%% ¡name!
Add
%%%% ¡probability!
.01
%%%% ¡code!    
it1 = IndexedDictionary('ID', 'Key 1');
it2 = IndexedDictionary('ID', 'Key 2');
it3 = IndexedDictionary('ID', 'Key 3');
it4 = IndexedDictionary('ID', 'Key 4');
it5 = IndexedDictionary('ID', 'Key 5');
it6 = IndexedDictionary('ID', 'Key 6');

items = {it1, it2, it3, it4};

idict = IndexedDictionary( ...
    'ID', 'Trial Indexed Dictionary', ...
    'IT_CLASS', 'IndexedDictionary', ...
    'IT_KEY', IndexedDictionary.getPropProp('ID'), ...
    'IT_LIST', items ...
    );

idict.get('ADD', it6)
assert(isequal(idict.get('LENGTH'), 5), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''ADD'', item) does not work.')
assert(isequal(idict.get('IT', 5), it6), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''ADD'', item) does not work.')

idict.get('ADD', it5, 5)
assert(isequal(idict.get('LENGTH'), 6), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''ADD'', item, index) does not work.')
assert(isequal(idict.get('IT', 5), it5) && isequal(idict.get('IT', 6), it6), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''ADD'', item, index) does not work.')

%%% ¡test!
%%%% ¡name!
Remove
%%%% ¡probability!
.01
%%%% ¡code!
it1 = IndexedDictionary('ID', 'Key 1');
it2 = IndexedDictionary('ID', 'Key 2');
it3 = IndexedDictionary('ID', 'Key 3');
it4 = IndexedDictionary('ID', 'Key 4');
it5 = IndexedDictionary('ID', 'Key 5');
it6 = IndexedDictionary('ID', 'Key 6');

items = {it1, it2, it3, it4, it5, it6};

idict = IndexedDictionary( ...
    'ID', 'Trial Indexed Dictionary', ...
    'IT_CLASS', 'IndexedDictionary', ...
    'IT_KEY', IndexedDictionary.getPropProp('ID'), ...
    'IT_LIST', items ...
    );

idict.get('REMOVE', 4)
assert(isequal(idict.get('LENGTH'), 5), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''REMOVE'', index) does not work.')
assert(isequal(idict.get('IT', idict.get('LENGTH')), it6), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''REMOVE'', index) does not work.')

idict.get('REMOVE', 5)
idict.get('REMOVE', 1)
assert(isequal(idict.get('IT_LIST'), {it2, it3, it5}), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''REMOVE'', index) does not work.')

%%% ¡test!
%%%% ¡name!
Replace
%%%% ¡probability!
.01
%%%% ¡code!    
it1 = IndexedDictionary('ID', 'Key 1');
it2 = IndexedDictionary('ID', 'Key 2');
it3 = IndexedDictionary('ID', 'Key 3');
it4 = IndexedDictionary('ID', 'Key 4');
it5 = IndexedDictionary('ID', 'Key 5');
it6 = IndexedDictionary('ID', 'Key 6');

items = {it1, it2, it3, it4};

idict = IndexedDictionary( ...
    'ID', 'Trial Indexed Dictionary', ...
    'IT_CLASS', 'IndexedDictionary', ...
    'IT_KEY', IndexedDictionary.getPropProp('ID'), ...
    'IT_LIST', items ...
    );

idict.get('REPLACE', it5, 4)
assert(isequal(idict.get('LENGTH'), 4), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''REPLACE'', item, index) does not work.')
assert(isequal(idict.get('KEY', 4), 'Key 5') && isequal(idict.get('IT', 4), it5), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''REPLACE'', item, index) does not work.')

idict.get('REPLACE_KEY', 'Key 5', 'Key 4')
assert(isequal(idict.get('LENGTH'), 4), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''REPLACE_KEY'', key, item) does not work.')
assert(isequal(idict.get('KEY', 4), 'Key 4') && isequal(idict.get('IT', 4), it5), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''REPLACE_KEY'', key, item) does not work.')

idict.get('REPLACE_IT', it5, it4)
assert(isequal(idict.get('LENGTH'), 4), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''REPLACE_IT'', item1, item2) does not work.')
assert(isequal(idict.get('KEY', 4), 'Key 4') && isequal(idict.get('IT', 4), it4), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''REPLACE_IT'', item1, item2) does not work.')

%%% ¡test!
%%%% ¡name!
Invert
%%%% ¡probability!
.01
%%%% ¡code!
it1 = IndexedDictionary('ID', 'Key 1');
it2 = IndexedDictionary('ID', 'Key 2');
it3 = IndexedDictionary('ID', 'Key 3');
it4 = IndexedDictionary('ID', 'Key 4');
it5 = IndexedDictionary('ID', 'Key 5');
it6 = IndexedDictionary('ID', 'Key 6');

items = {it1, it2, it3, it4};

idict = IndexedDictionary( ...
    'ID', 'Trial Indexed Dictionary', ...
    'IT_CLASS', 'IndexedDictionary', ...
    'IT_KEY', IndexedDictionary.getPropProp('ID'), ...
    'IT_LIST', items ...
    );

idict.get('INVERT', 1, 4)
idict.get('INVERT', 3, 2)
assert(isequal(idict.get('LENGTH'), 4), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''INVERT'', index1, index2) does not work.')
assert(isequal(idict.get('KEYS'), {'Key 4', 'Key 3', 'Key 2', 'Key 1'}), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''INVERT'', index1, index2) does not work.')

%%% ¡test!
%%%% ¡name!
Move_to
%%%% ¡probability!
.01
%%%% ¡code!
it1 = IndexedDictionary('ID', 'Key 1');
it2 = IndexedDictionary('ID', 'Key 2');
it3 = IndexedDictionary('ID', 'Key 3');
it4 = IndexedDictionary('ID', 'Key 4');
it5 = IndexedDictionary('ID', 'Key 5');
it6 = IndexedDictionary('ID', 'Key 6');

items = {it1, it2, it3, it4};

idict = IndexedDictionary( ...
    'ID', 'Trial Indexed Dictionary', ...
    'IT_CLASS', 'IndexedDictionary', ...
    'IT_KEY', IndexedDictionary.getPropProp('ID'), ...
    'IT_LIST', items ...
    );

idict.get('MOVE_TO', 1, 4);
idict.get('MOVE_TO', 1, 3);
idict.get('MOVE_TO', 1, 2);
assert(isequal(idict.get('LENGTH'), 4), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''MOVE_TO'', index1, index2) does not work.')
assert(isequal(idict.get('KEYS'), {'Key 4', 'Key 3', 'Key 2', 'Key 1'}), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''MOVE_TO'', index1, index2) does not work.')

%%% ¡test!
%%%% ¡name!
Remove all
%%%% ¡probability!
.01
%%%% ¡code!
it1 = IndexedDictionary('ID', 'Key 1');
it2 = IndexedDictionary('ID', 'Key 2');
it3 = IndexedDictionary('ID', 'Key 3');
it4 = IndexedDictionary('ID', 'Key 4');
it5 = IndexedDictionary('ID', 'Key 5');
it6 = IndexedDictionary('ID', 'Key 6');

items = {it1, it2, it3, it4, it5, it6};

idict = IndexedDictionary( ...
    'ID', 'Trial Indexed Dictionary', ...
    'IT_CLASS', 'IndexedDictionary', ...
    'IT_KEY', IndexedDictionary.getPropProp('ID'), ...
    'IT_LIST', items ...
    );

selected = idict.get('REMOVE_ALL', [1 3 6]);
assert(isequal(idict.get('LENGTH'), 3), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''REMOVE_ALL'', indices) does not work.')
assert(isequal(idict.get('KEYS'), {'Key 2', 'Key 4', 'Key 5'}), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''REMOVE_ALL'', indices) does not work.')
assert(isequal(selected, []), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''REMOVE_ALL'', indices) does not work.')

%%% ¡test!
%%%% ¡name!
Move up
%%%% ¡probability!
.01
%%%% ¡code!
it1 = IndexedDictionary('ID', 'Key 1');
it2 = IndexedDictionary('ID', 'Key 2');
it3 = IndexedDictionary('ID', 'Key 3');
it4 = IndexedDictionary('ID', 'Key 4');
it5 = IndexedDictionary('ID', 'Key 5');
it6 = IndexedDictionary('ID', 'Key 6');

items = {it1, it2, it3, it4, it5, it6};

idict = IndexedDictionary( ...
    'ID', 'Trial Indexed Dictionary', ...
    'IT_CLASS', 'IndexedDictionary', ...
    'IT_KEY', IndexedDictionary.getPropProp('ID'), ...
    'IT_LIST', items ...
    );

selected = idict.get('MOVE_UP', [1 2 4 6]);
assert(isequal(idict.get('LENGTH'), 6), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''MOVE_UP'', indices) does not work.')
assert(isequal(idict.get('KEYS'), {'Key 1', 'Key 2', 'Key 4', 'Key 3', 'Key 6', 'Key 5'}), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''MOVE_UP'', indices) does not work.')
assert(isequal(selected, [1 2 3 5]), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''MOVE_UP'', indices) does not work.')

%%% ¡test!
%%%% ¡name!
Move down
%%%% ¡probability!
.01
%%%% ¡code!
it1 = IndexedDictionary('ID', 'Key 1');
it2 = IndexedDictionary('ID', 'Key 2');
it3 = IndexedDictionary('ID', 'Key 3');
it4 = IndexedDictionary('ID', 'Key 4');
it5 = IndexedDictionary('ID', 'Key 5');
it6 = IndexedDictionary('ID', 'Key 6');

items = {it1, it2, it3, it4, it5, it6};

idict = IndexedDictionary( ...
    'ID', 'Trial Indexed Dictionary', ...
    'IT_CLASS', 'IndexedDictionary', ...
    'IT_KEY', IndexedDictionary.getPropProp('ID'), ...
    'IT_LIST', items ...
    );

selected = idict.get('MOVE_DOWN', [1 3 5 6]);
assert(isequal(idict.get('LENGTH'), 6), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''MOVE_DOWN'', indices) does not work.')
assert(isequal(idict.get('KEYS'), {'Key 2', 'Key 1', 'Key 4', 'Key 3', 'Key 5', 'Key 6'}), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''MOVE_DOWN'', indices) does not work.')
assert(isequal(selected, [2 4 5 6]), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''MOVE_DOWN'', indices) does not work.')

%%% ¡test!
%%%% ¡name!
Move to top
%%%% ¡probability!
.01
%%%% ¡code!
it1 = IndexedDictionary('ID', 'Key 1');
it2 = IndexedDictionary('ID', 'Key 2');
it3 = IndexedDictionary('ID', 'Key 3');
it4 = IndexedDictionary('ID', 'Key 4');
it5 = IndexedDictionary('ID', 'Key 5');
it6 = IndexedDictionary('ID', 'Key 6');

items = {it1, it2, it3, it4, it5, it6};

idict = IndexedDictionary( ...
    'ID', 'Trial Indexed Dictionary', ...
    'IT_CLASS', 'IndexedDictionary', ...
    'IT_KEY', IndexedDictionary.getPropProp('ID'), ...
    'IT_LIST', items ...
    );

selected = idict.get('MOVE_TO_TOP', [1 3 5 6]);
assert(isequal(idict.get('LENGTH'), 6), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''MOVE_TO_TOP'', indices) does not work.')
assert(isequal(idict.get('KEYS'), {'Key 1', 'Key 3', 'Key 5', 'Key 6', 'Key 2', 'Key 4'}), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''MOVE_TO_TOP'', indices) does not work.')
assert(isequal(selected, [1 2 3 4]), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''MOVE_TO_TOP'', indices) does not work.')

%%% ¡test!
%%%% ¡name!
Move to bottom
%%%% ¡probability!
.01
%%%% ¡code!
it1 = IndexedDictionary('ID', 'Key 1');
it2 = IndexedDictionary('ID', 'Key 2');
it3 = IndexedDictionary('ID', 'Key 3');
it4 = IndexedDictionary('ID', 'Key 4');
it5 = IndexedDictionary('ID', 'Key 5');
it6 = IndexedDictionary('ID', 'Key 6');

items = {it1, it2, it3, it4, it5, it6};

idict = IndexedDictionary( ...
    'ID', 'Trial Indexed Dictionary', ...
    'IT_CLASS', 'IndexedDictionary', ...
    'IT_KEY', IndexedDictionary.getPropProp('ID'), ...
    'IT_LIST', items ...
    );

selected = idict.get('MOVE_TO_BOTTOM', [1 3 5 6]);
assert(isequal(idict.get('LENGTH'), 6), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''MOVE_TO_BOTTOM'', indices) does not work.')
assert(isequal(idict.get('KEYS'), {'Key 2', 'Key 4', 'Key 1', 'Key 3', 'Key 5', 'Key 6'}), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''MOVE_TO_BOTTOM'', indices) does not work.')
assert(isequal(selected, [3 4 5 6]), ...
	[BRAPH2.STR ':' class(idict) ':' BRAPH2.FAIL_TEST], ...
    'IndexedDictionary.get(''MOVE_TO_BOTTOM'', indices) does not work.')
