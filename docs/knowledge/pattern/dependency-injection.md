# Dependency Injection

<hr/>

Dependency Injection is a tachnique that facilitates loosely coupled object-oriented software systems. It is closely related to the [Dependency Inversion Principle](https://deviq.com/dependency-inversion-principle). In simple systems, references to collaborating objects are made directly within classes that need to refer to them. This results in tight coupling between these classes, making them more difficult to test, refactor, and maintain. Dependency Injection is a technique by which the collaborating objects are passed the class that needs to work with them, and the class itself codes against an interface or base class, rather than a specific implemetation class. There are several ways inject dependencies into a class, via one of these parts of the class: contructor, property, method.

Constructor injection is the most common approach, and involves passing an instance of the dependency into the class's constructor. The constructor, in turn, sets the dependency to a local private field, which is then used within the class as needed. This is also an example of the [Strategy design pattern](https://deviq.com/strategy-design-pattern). Classes that follow the [Explicit Dependencies Principle](http://deviq.com/explicit-dependencies-principle) are easily able to take advantage of constructor dependency injection.

Property injection is similar, but instead of providing the instance of the dependency via the constructor, the dependency is instead set via a property of the class. This technique is useful in situations where construction of the class cannot be parameterized. With property injection, the calling code needs to set the dependency properties in order for the class to behave directly, and typically the only way this information is exposed is via documentation, comments. Constructor injection, on the hand, ensures that the object can only be instantiated when all of its dependencies are provided, so it eliminates the possibility of an object being in an invalid state.

Method injection simply involves passing collaborating objects as parameters to methods. It is most useful on public methods that have dependencies that are not used any where else in the class. so constructor and/or property injection would be overfill.

Dependency injection is related to inversion of control containers, which can be used to automatically and centrally manage which instances dependencies should be provided whenever an object needs to be created.

<hr/>

Get more information at [here](https://deviq.com/dependency-injection/).
