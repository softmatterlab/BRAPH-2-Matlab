%% ¡header!
ArithmeticOperations < ConcreteElement (ao, arithmetic operation calculator) calculates simple arithmetic operations.

%%% ¡description!
An Arithmetic Operation Calculator (ArithmeticOperations) contains two 
 numbers as data scalar props and calculates their sum and difference as 
 result scalar props.

%%% ¡seealso!
LogicalOperations, GeometricalOperations


%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the arithmetic operation calculator.
%%%% ¡default!
'ArithmeticOperations'

%%% ¡prop!
NAME (constant, string) is the name of the arithmetic operation calculator.
%%%% ¡default!
'Arithmetic Operation Calculator'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the arithmetic operation calculator.
%%%% ¡default!
'An Arithmetic Operations element (ArithmeticOperations) contains two numbers as data scalar props and calculates their sum and difference as result scalar props.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the arithmetic operation calculator.
%%%% ¡settings!
'ArithmeticOperations'

%%% ¡prop!
ID (data, string) is a few-letter code for the arithmetic operation calculator.
%%%% ¡default!
'ArithmeticOperations ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the arithmetic operation calculator.
%%%% ¡default!
'ArithmeticOperations label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the arithmetic operation calculator.
%%%% ¡default!
'ArithmeticOperations notes'

%%% ¡prop!
TOSTRING (query, string) returns a string that represents the object.
%%%% ¡calcualte!
a = ao.get('A');
b = ao.get('B');
value = ['Calculator of the sum and difference of ' num2str(A) ' and ' num2str(B)];


%% ¡props!

%%% ¡prop!
A (data, scalar) is the first number.

%%% ¡prop!
B (data, scalar) is the second number.

%%% ¡prop!
SUM (result, scalar) is the sum of the two numbers (A + B).
%%%% ¡calculate!
value = ao.get('A') + ao.get('B');

%%% ¡prop!
DIFF (result, scalar) is the difference of the two numbers (A - B).
%%%% ¡calculate!
value = ao.get('A') - ao.get('B');


%% ¡tests!

%%% ¡test!
%%%% ¡name!
Simple test
%%%% ¡code!
ao = ArithmeticOperations('A', 6, 'B', 4)

string = ao.get('TOSTRING')
assert(~ao.isLocked('A'))
assert(~ao.isLocked('B'))

sum = ao.get('SUM')

assert(ao.isLocked('A'))
assert(ao.isLocked('B'))

diff = ao.get('DIFF')

sum_raw = ao.getr('SUM')
diff_raw = ao.getr('DIFF')
assert(isa(sum_raw, 'NoValue') && isa(diff_raw, 'NoValue'))

%%% ¡test!
%%%% ¡name!
Simple test with memorization
%%%% ¡code!
ao = ArithmeticOperations('A', 6, 'B', 4)

sum = ao.memorize('SUM')
diff = ao.memorize('DIFF')

sum_raw = ao.getr('SUM')
diff_raw = ao.getr('DIFF')
assert(~isa(sum_raw, 'NoValue') && ~isa(diff_raw, 'NoValue'))