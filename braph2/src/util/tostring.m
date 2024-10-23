function str = tostring(value, n, ending)
%TOSTRING returns a char array representing the input value.
%
% STRING = TOSTRING(VALUE) returns a char array representing VALUE.
%  The char array depends on the type of VALUE. In particular, if VALUE is
%  an object with a method tostring(), it will call this method.
%
% STRING = TOSTRING(VALUE, N) trims the char array to the first N characters.
%
% STRING = TOSTRING(VALUE, N, ENDING) ends the char array with ENDING if it
%  has been trimmed.
%
% If the VALUE is not recognized, an error is thrown.
%  Error id: [BRAPH2:tostring:WrongInput].

if nargin < 3
    ending = '';
end

if nargin < 2
    n = inf;
end

if isobject(value) && ismethod(value, 'tostring') % objects with .tostring()
    str = value.tostring();
elseif isstring(value) % string objects - needs to be before otehr objects
    if isempty(value) % empty string
        str = '""';
    else % non-empty string
        str = ['"' char(value) '"'];
    end
elseif isobject(value) % other objects
    str = class(value);
elseif isnumeric(value) && isempty(value) % empty number
    str = '[]';
elseif isnumeric(value) 
    if numel(value) == 1 % scalar number
        str = num2str(value);
    else % other number
        str = '[';
        size_value = size(value);
        for i = 1:1:length(size_value) - 1 
            str = [str num2str(size_value(i)) ' x ']; %#ok<AGROW>
        end
        str = [str num2str(size_value(end)) ']'];
    end
elseif islogical(value)
    if numel(value) == 1 % scalar logical
        if value 
            str = 'true';
        else
            str = 'false';
        end
    else % other logical
        str = 'bool[';
        size_value = size(value);
        for i = 1:1:length(size_value) - 1 
            str = [str num2str(size_value(i)) ' x ']; %#ok<AGROW>
        end
        str = [str num2str(size_value(end)) ']'];
    end
elseif ischar(value) % char array
    if isempty(value) % empty string
        str = '''''';
    else % non-empty char array
        str = ['''' regexprep(value, '''', '''''') ''''];
    end
elseif iscell(value) % cell array
    if isempty(value) % empty cell array
        str = '{}';
    else % non-empty cell array
        str = '';
        size_value = size(value);
        for i = 1:1:length(size_value) - 1 
            str = [str num2str(size_value(i)) ' x ']; %#ok<AGROW>
        end
        str = [str num2str(size_value(end)) ' ' char(join(cellfun(@(x) tostring(x), value(:)', 'UniformOutput', false)))];
        str = ['{' strtrim(str) '}'];
    end
else % unrecognized / error
    error( ...
        [BRAPH2.STR ':tostring:' BRAPH2.WRONG_INPUT], ...
        [BRAPH2.STR ':tostring:' BRAPH2.WRONG_INPUT '\n' ...
        'The value cannot be converted to a string.'] ...
        )
end

if length(str) > n
    str = [str(1:n) ending];
end

end