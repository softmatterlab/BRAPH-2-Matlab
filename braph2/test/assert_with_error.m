function assert_with_error(code, error_identifier, varargin)

try 
    clear e
    eval(code)
catch e
    assert(isequal(e.identifier, error_identifier), ...
        [BRAPH2.STR ':Graph:' BRAPH2.BUG_ERR], ...
        ['Expected error: ' error_identifier '. Instead, thrown error ' e.identifier])    
end
assert(exist('e', 'var') == 1, ...
    [BRAPH2.STR ':Format:' BRAPH2.BUG_ERR], ...
    ['Error not thrown. Expected error: ' error_identifier])

end