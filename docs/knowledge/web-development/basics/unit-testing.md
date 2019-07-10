# Unit Testing

<hr/>

## Description 

Unit tests are typically autmated tests written and run by software developers to ensure that a section of an application meets its design and behaves as intended. In procedural programming, a unit could be an entire module, but it is more commonly an individual function or procedure. In object-oriented programming, a unit is often an entire interface, such as a class, but could be an individual method. By writing tests first for the smallest testable units, then the compound behaviors between those , one can build up comprehensive tests for complex applications.

## Advantages

The goal of unit testing is to isolate each part of the program and show that the individual parts are correct. A unit provides a strict, written contract that the piece of code must satisfy. As a resul, it affords several benefits.

Unit testing finds problems early in the development cycle. his includes both bugs in the programmer's implementation and flaws or missing parts of the specification for the unit. The process of writing a thorough set of tests forces the author to think through inputs, outputs, and error conditions, and thust more cresply define the unit's desired behavior. The cost of finding a bug before coding begins or when the code is first written is conisderably lower than the coset of detecting, identifying, and correcting the bug later. Bugs in released code may also cause costly problems for the end-users of the software. Code can be impossible or difficult to unit test if poorly written, thus unit testing can force developers to structure functions and objects in better ways.

Unit testing provides a sort of living documentation of the system. Devleopers looking to learn what funcutionality is provided by a unit, and how to use it, can look at the unit tests to gain a basic understanding of the unit's interface.

Unit testing may reduce uncertainty in the units themselves and can be used in a bottom-up testing style approach. By testing the parts of a program first and then testing the sum of its parts, integration testing becomes much easier.

## Limitations and disadvantages

Testing will not catch every error in the program , because it cannot evluate every execution path in any but the most trivial programs. This problem is a superset of the halting problem, which is undecidable. The same is tru for unit testing, Additionally, unit testing by definition only tests the functionality of the units themselves. Therefore, it will not catch integration errors or broader system-level errors (such as functions performed across multiple units, o non-functional test areas such as perfromace). TUnt testing should be done in conjunction with other software testin activities, as they only show the presence or absence of partiular errors; they cannot prove a complete absence of errors. to guarantee correct behavior for every execution path and every possible input and ensure the absence of errors, other techniques are required, namely the application of formal methods to proving that a software component has no unexpected behavior.

<hr/>

Get more information at [here](https://en.wikipedia.org/wiki/Unit_testing).