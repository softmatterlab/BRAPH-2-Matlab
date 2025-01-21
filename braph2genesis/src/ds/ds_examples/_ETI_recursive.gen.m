%% ¡header!
ETI_recursive < ConcreteElement (et, test I recursive elements) tests recursive elements.

%%% ¡description!
ETI_recursive tests the use of recursive elements.

%%% ¡build!
1

%% ¡props!

%%% ¡prop!
IT_D (data, item) is a prop data item.

%%% ¡prop!
IT_R (result, item) is a prop result item.

%%% ¡prop!
IT_E (evanescent, item) is a prop evanescent item.


%% ¡tests!

%%% ¡test!
%%%% ¡name!
Recursive elements
%%%% ¡probability!
.01
%%%% ¡code!
% basic recursion
et1 = ETI_recursive();
et2 = ETI_recursive('IT_D', et1);
et1.set('IT_D', et2)

assert(isequal(et1, et2)) % checks Element.isequal() and Element.getElementList()

% memorization and copy
et1.memorize('IT_R');
et1.memorize('IT_E');
et1_copy = et1.copy();

assert(~isa(et1.getr('IT_R'), 'NoValue'))
assert(~isa(et1_copy.getr('IT_R'), 'NoValue'))

assert(~isa(et1.getr('IT_E'), 'NoValue'))
assert(isa(et1_copy.getr('IT_E'), 'NoValue'))