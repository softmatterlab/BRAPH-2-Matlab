%% ¡header!
NoValue < Element (nv, NoValue) represents a value that has not been set or calculated.

%%% ¡class_attributes!
Sealed=true

%%% ¡description!
NoValue is an element without values used to represent a value that has
 not been set (for properties of categories METADATA, PARAMETER, DATA, FIGURE or GUI) 
 or calculated (for properties of category RESULT, QUERY, EVANESCENT), 
 while it should not be used for properties of category CONSTANT.
For computational efficiency, it is best to use only one instance of NoValue 
 using Element.getNoValue(), instead of creating new instances using the 
 constructor NoValue(). 
No element can be a subclass of NoValue.

%%% ¡seealso!
ConcreteElement

%%% ¡build!
1