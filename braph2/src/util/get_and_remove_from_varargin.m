function [value, varargin] = get_and_remove_from_varargin(value, handle, varargin)
%GET_AND_REMOVE_FROM_VARARGIN returns and removes the first occurrence of a property from varargin.
%
% [VALUE, NEW_VARARGIN] = GET_AND_REMOVE_FROM_VARARGIN(DEFAULT, HANDLE,
%  VARARGIN) returns and removes the first occurence of the property
%  corresponding to HANDLE. If HANDLE does not exist, it returns DEFAULT.
%  VARARGIN is passed as a cell array.
%
% [VALUE, NEW_VARARGIN] = GET_AND_REMOVE_FROM_VARARGIN(DEFAULT, HANDLE,
%  'PropertyName', PROPERTY, ... ) VARARGIN can also be passed as a list of
%  couples, each including a 'PropertyName' and a PROPERTY.
%
% See also get_from_varargin, remove_from_varargin, clean_varargin,
%  copy_varargin.

value = get_from_varargin(value, handle, varargin{:});
varargin = remove_from_varargin(handle, varargin{:});

end