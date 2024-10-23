%% ¡header!
SeededRandomness < ConcreteElement (sr, randomizer) generates a random number.

%%% ¡description!
A Randomizer (SeededRandomness) is an element with a random result property 
 whose main purpose is to illustrate the use of seeded randomness.


%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the randomizer.
%%%% ¡default!
'SeededRandomness'

%%% ¡prop!
NAME (constant, string) is the name of the randomizer.
%%%% ¡default!
'Randomizer'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the randomizer.
%%%% ¡default!
'A Randomizer (SeededRandomness) is an element with a random result property whose main purpose is to illustrate the use of seeded randomness.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the randomizer.
%%%% ¡settings!
'SeededRandomness'

%%% ¡prop!
ID (data, string) is a few-letter code for the randomizer.
%%%% ¡default!
'SeededRandomness ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the randomizer.
%%%% ¡default!
'SeededRandomness label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the randomizer.
%%%% ¡default!
'SeededRandomness notes'

%% ¡props!

%%% ¡prop!
RANDOM_NUMBER (result, scalar) is a random number.
%%%% ¡calculate!
value = rand();


%% ¡tests!

%%% ¡test!
Simple test
%%%% ¡code!
sr1 = SeededRandomness()
sr2 = SeededRandomness()

assert(sr1.get('RANDOM_NUMBER') == sr1.get('RANDOM_NUMBER'))
assert(sr2.get('RANDOM_NUMBER') == sr2.get('RANDOM_NUMBER'))
assert(sr1.get('RANDOM_NUMBER') ~= sr2.get('RANDOM_NUMBER'))