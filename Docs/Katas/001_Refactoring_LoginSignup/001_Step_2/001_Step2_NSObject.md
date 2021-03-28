# Step 2: Removing NSObject

- The original code was made to be used from Objective-C as well. When you need interoperability with Objective-C and you have to use swift classes or call swift methods from Objective-C, you need either to use the @objc decoration or just to derive your classes from NSObject.

- There are some implications with the choice of supporting Obj-C but also with the choice of not supporting it.

- Swift classes that are subclasses of NSObject:

  - are Objective-C classes themselves
  - use `objc_msgSend()` for calls to (most of) their methods
  - provide Objective-C runtime metadata for (most of) their method implementations

  Swift classes that are not subclasses of NSObject:

  - are Objective-C classes, but implement only a handful of methods for NSObject compatibility
  - do not use `objc_msgSend()` for calls to their methods (by default)
  - do not provide Objective-C runtime metadata for their method implementations (by default)

- Subclassing NSObject in Swift gets you Objective-C runtime flexibility but also Objective-C performance. Avoiding NSObject can improve performance if you don't need Objective-C's flexibility.

- One advantage of Objective-C is its dynamic behaviour that allows to implement features like as method interception and run-time introspection.

- New features of the Swift language permit to implements some of the dynamic mechanism allowed by Obj-C, without including the Objective-C runtime metadata:

  - The dynamic attribute. This allows us to instruct Swift that a method should use dynamic dispatch, and will therefore support interception.

    ```swift
    public dynamic func foobar() -> AnyObject {
    }
    ```

  - Property observers 

    Property observers observe and respond to changes in a property's value. Property observers are called every time a property's value is set, even if the new value is the same as the property's current value.

    You can add property observers to any stored properties you define, apart from lazy stored properties. You can also add property observers to any inherited property (whether stored or computed) by overriding the property within a subclass.

    You have the option to define either or both of these observers on a property:

    - willSet is called just before the value is stored.
    - didSet is called immediately after the new value is stored.
      

- As we don't need, for our purposes, the interoperability with Objective-C, we are going to remove NSObject from our classes.

  - remove the derivation from NSObject
  - remove the super.init() call

- Run the tests. They are all still green. We can commit our changes in safety.



Now your project should look like this:
[Step_1_FinalCode](FinalCode/)

Next step we'll remove the dependecy from NSObject:

[Step 2](../001_Step_2/001_Step2_RemoveObjC.md)

