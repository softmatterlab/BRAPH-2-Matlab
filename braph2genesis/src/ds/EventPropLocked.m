classdef (ConstructOnLoad) EventPropLocked < event.EventData
    %EventPropLocked is the data container for the PropLocked event.
    % It corresponds to a property being locked.
    %
    % EventPropLocked properties:
    %  el       - element
    %  prop     - property that has been locked
    %
    % EventPropLocked constructor:
    %  EventPropLocked - constructor
    %
    % See also Element, event, listener.
    
    properties
        el % element
        prop % property that has been locked
    end
    methods
        function event = EventPropLocked(el, pointer)
            %EVENTPROPLOCKED() creates a data container for the PropLocked event.
            %
            % EVENTPROPLOCKED(EL, POINTER) with element EL and the POINTER to the
            %  result property that has been locked. 
            %  POINTER can be either a TAG or a PROP.
            %
            % See also Element, event.

            event.el = el;
            event.prop = el.getPropProp(pointer);
        end
    end
end