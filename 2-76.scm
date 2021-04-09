
Explicit dispatch
New type:
In child module
1.Tag data with type in constructor
2.Provide all the common procedures with altered names (eg. with suffixes)
3.Provide a predicate <type?>
In parent module 
4.Implement condition switching on type with predicate and dispatch calls to procedures mentioned above.

Add operation:
In child modules:
1. Add procedure with an altered name to all child modules
In parent module:
2. Add dispatch to that procedure

Data-directed programming
New type:
In child module:
1. Register each procedure with type-tag and its selector
2. Provide a procedure to "install" them and tag all data with its type in constructors
In parent module: nothing needs to be done

Add operation:
In child module:
1. Register procedure for new operation with type-tag and its selector in all child modules
In parent module: nothing needs to be done

Message passing

New type:
In child module:
1.Implement constructor that returns a procedure that accepts all of selectors of its type
In parent module: nothing needs to be done

Add operation:
In child module:
1. Update all constructors of child modules wih new selector
In parent module: nothing needs to be done

Personally I like message passing as it's least number of changes needed to add type or operation, no install calls and it doesn't force parent module to change.


