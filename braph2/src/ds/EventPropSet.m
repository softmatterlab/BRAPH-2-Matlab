classdef (ConstructOnLoad) EventPropSet < event.EventData
    %EventPropSet is the data container for the PropSet event.
    % It corresponds to a property being set. It applies to all properties.
    %
    % EventPropSet properties:
    %  el       - element
    %  props    - properties that have been set
    %
    % EventPropSet constructor:
    %  EventPropSet - constructor
    %
    % See also Element, event, listener.
    
    properties
        el % element
        props % properties that have been set
    end
    methods
        function event = EventPropSet(el, varargin)
            %EVENTPROPSET() creates a data container for the PropSet event.
            %
            % EVENTPROPSET(EL, POINTER1, POINTER2, ... ) with element EL and the
            %  POINTER1, POINTER2, ... to the properties that have been set. 
            %  Each POINTER1, POINTER2, ... can be either a TAG or a PROP.
            %
            % See also Element, event.

            event.el = el;
            event.props = cellfun(@(pointer) el.getPropProp(pointer), varargin, 'UniformOutput', false);
        end
    end
end
