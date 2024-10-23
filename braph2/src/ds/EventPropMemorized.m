classdef (ConstructOnLoad) EventPropMemorized < event.EventData
    %EventPropMemorized is the data container for the PropMemorized event.
    % It corresponds to a property being memorized (applied to categories
    % RESULT, QUERY, and EVANESCENT).
    %
    % EventPropMemorized properties:
    %  el       - element
    %  prop     - property whose result has been memorized
    %
    % EventPropMemorized constructor:
    %  EventPropMemorized - constructor
    %
    % See also Element, event, listener.
    
    properties
        el % element
        prop % property whose result has been memorized
    end
    methods
        function event = EventPropMemorized(el, pointer)
            %EVENTPROPMEMORIZED() creates a data container for the PropMemorized event.
            %
            % EVENTPROPMEMORIZED(EL, POINTER) with element EL and the POINTER to the
            %  result property that has been memorized. 
            %  POINTER can be either a TAG or a PROP.
            %
            % See also Element, event.

            event.el = el;
            event.prop = el.getPropProp(pointer);
        end
    end
end