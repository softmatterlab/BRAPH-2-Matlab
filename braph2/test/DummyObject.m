classdef DummyObject < handle
    %DummyObject Dummy object.
    % Dummy objects used for unit testing and debugging.
    % It implements handle.
    %
    % DummyObject properties:
    %  name
    %
    % DummyObject methods:
    %  DummyObject - constructor
    %  tostring - returns a string describing the object
    %
    % See also handle, DummyCopiableObject.
    
    properties
        name
    end
    methods 
        function obj = DummyObject(name)
            %DummyObject(NAME) creates a dummy object with the property NAME.
            
            obj.name = name;
        end
        function str = tostring(obj)
            %TOSTRING returns a string with the object name.
            %
            % STR = TOSTRING(OBJ) returns a string with the object name.
            
            str = [class(obj) ' ' tostring(obj.name)];
        end
    end
end