%% ¡header!
ArithmeticOperationsWithQuery < ArithmeticOperations (ao, calculator with query) calculates simple arithmetic operations with a query.

%%% ¡description!
A Calculator with a Query (ArithmeticOperationsWithQuery) has a query prop
 that permits to obtain either the sum or the difference of the two data 
 scalar props.


%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the calculator with query.
%%%% ¡default!
'ArithmeticOperationsWithQuery'

%%% ¡prop!
NAME (constant, string) is the name of the calculator with query.
%%%% ¡default!
'Calculator with a Query '

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the calculator with query.
%%%% ¡default!
'A Calculator with a Query (ArithmeticOperationsWithQuery) has a query prop that permits to obtain either the sum or the difference of the two data scalar props.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the calculator with query.
%%%% ¡settings!
'ArithmeticOperationsWithQuery'

%%% ¡prop!
ID (data, string) is a few-letter code for the calculator with query.
%%%% ¡default!
'ArithmeticOperationsWithQuery ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the calculator with query.
%%%% ¡default!
'ArithmeticOperationsWithQuery label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the calculator with query.
%%%% ¡default!
'ArithmeticOperationsWithQuery notes'


%% ¡props!

%%% ¡prop!
SUM_OR_DIFF (query, scalar) returns the sum or difference depending on the argument.
%%%% ¡calculate!
% R = ao.get('SUM_OR_DIFF', SUM_OR_DIFF) returns the sum of A and B if 
%  SUM_OR_DIFF = 'SUM' or the difference of A and B if SUM_OR_DIFF = 'DIFF'.

if isempty(varargin)
    value = NaN;
    return
end    
sum_or_diff = varargin{1};

switch sum_or_diff 
    case 'SUM'
        value = ao.get('SUM');

    case 'DIFF'
        value = ao.get('DIFF');

    otherwise
        value = NaN;
end



%% ¡tests!

%%% ¡test!
Simple test
%%%% ¡code!
ao = ArithmeticOperationsWithQuery('A', 6, 'B', 4)

assert(ao.get('SUM_OR_DIFF', 'SUM') == ao.get('SUM'))
assert(ao.get('SUM_OR_DIFF', 'DIFF') == ao.get('DIFF'))
assert(isnan(ao.get('SUM_OR_DIFF')))
assert(isnan(ao.get('SUM_OR_DIFF', 'anything else')))