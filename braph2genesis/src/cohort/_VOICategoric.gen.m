%% ¡header!
VOICategoric < VOI (voi, categorical variable of interest) is a categorical variable of interest.

%%% ¡description!
A Categorical Variable Of Interest (VOICategoric) is a categorical variable of interest.

%%% ¡seealso!
VOINumeric

%%% ¡build!
1

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the categorical variable of interest.
%%%% ¡default!
'VOICategoric'

%%% ¡prop!
NAME (constant, string) is the name of the categorical variable of interest.
%%%% ¡default!
'Categorical Variable Of Interest'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the categorical variable of interest.
%%%% ¡default!
'A Categorical Variable Of Interest (VOICategoric) is a categorical variable of interest.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the categorical variable of interest.
%%%% ¡settings!
'VOICategoric'

%%% ¡prop!
ID (data, string) is a few-letter code for the categorical variable of interest.
%%%% ¡default!
'VOICategoric ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the categorical variable of interest.
%%%% ¡default!
'VOICategoric label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the categorical variable of interest.
%%%% ¡default!
'VOICategoric notes'

%%% ¡prop!
V (data, scalar) is the value of the categorical variable of interest.
%%%% ¡default!
1
%%%% ¡check_value!
check = ismember(voi.get('V'), [1:1:length(voi.get('CATEGORIES'))]);
if check 
    msg = 'All ok!';
else
    msg = ['V should be an integer corresponding to one of the CATEGORIES (here, ' cell2str(voi.get('CATEGORIES')) '), while is is ' num2str(voi.get('V')) '.'];
end

%% ¡props!

%%% ¡prop!
CATEGORIES (parameter, stringlist) is the list of categories.
%%%% ¡default!
{'Male', 'Female'}
