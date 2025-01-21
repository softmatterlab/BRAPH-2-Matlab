function tokens = getTokens(txt, h1, varargin)
%GETTOKENS extract a list of tokens from a text.
%
% TOKENS = GETTOKENS(TXT, H1) extracts from text TXT the list of tokens 
%  %% ¡H1!
%  TOKENS{1}.token
%  %% ¡H1!
%  TOKENS{2}.token
%  ...
%
% TOKENS = GETTOKENS(TXT, H1, H2) extracts from text TXT the list of tokens 
%  %% ¡H1!
%  ...
%  %%% ¡H2!
%  TOKENS{1}.token
%  %%% ¡H2!
%  TOKENS{2}.token
%  ...
%
% TOKENS = GETTOKENS(TXT, H1, H2, H3, ...) extracts from text TXT the list
%  of tokens corresponding to the headings H1, H2, H3, ...
%
% See also getToken, create_Element, create_test_Element.

if isempty(varargin)
    t = 0;
    tokens = {};
    splits = regexp(txt, ['(^|' newline() ')%%\s*¡'], 'split');
    for j = 1:1:length(splits)
        split = splits{j};
        if regexp(split, ['^' h1 '!'])
            [~, final_index] = regexp(split, ['^' h1 '!(\s*)']);
            t = t + 1;
            split = regexprep(split, '%%%\s*¡', '%% ¡');
            tokens{t}.token = deblank(split(final_index+1:end)); %#ok<AGROW>
        end
    end
else
    txt = getToken(txt, h1, varargin{1:end-1});
    tokens = getTokens(txt, varargin{end});
end

end