function save_layout(el, order, title)
%SAVE_LAYOUT saves the layout of an element.
%
% SAVE_LAYOUT(EL, ORDER, TITLE) saves the layout of the element EL (which
%  can be an element, class, or class name). 
%  ORDER is the order of each property (from 1 to the number of properties
%   to be shown, NaN for properties not to be shown).
%  TITLE is a cell array with the title of each property.
%
% See also load_layout.

assert( ...
    length(order) == Element.getPropNumber(el) && length(title) == Element.getPropNumber(el), ...
    [BRAPH2.STR ':load_layout:' BRAPH2.ERR_IOLAYOUT], ...
    [BRAPH2.STR ':load_layout:' BRAPH2.ERR_IOLAYOUT ' ' ...
    'The ORDER length (' int2str(length(order)) ') ' ...
    'and the TITLE length (' int2str(length(title)) ') ' ...
    'must be equal to the element (' Element.getClass(el) ') number of properties (' int2str(Element.getPropNumber(el)) ').'] ...
    )

layout_filename = [fileparts(which(BRAPH2.LAUNCHER)) filesep 'src' filesep 'gui' filesep 'layouts' filesep Element.getClass(el) '.layout'];

% % % save(layout_filename, '-mat', 'order', 'title') %TBE
data = cell(length(title) * 2, 1);
data(1:2:end) = title;
data(2:2:end) = num2cell(order);
writecell(data, layout_filename, 'FileType', 'text', 'Delimiter', 'tab')