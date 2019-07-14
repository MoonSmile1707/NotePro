# Unit Testing

<hr/>

## Description 

Unit tests are typically autmated tests written and run by software developers to ensure that a section of an application meets its design and behaves as intended. In procedural programming, a unit could be an entire module, but it is more commonly an individual function or procedure. In object-oriented programming, a unit is often an entire interface, such as a class, but could be an individual method. By writing tests first for the smallest testable units, then the compound behaviors between those , one can build up comprehensive tests for complex applications.

## Advantages

The goal of unit testing is to isolate each part of the program and show that the individual parts are correct. A unit provides a strict, written contract that the piece of code must satisfy. As a resul, it affords several benefits.

Unit testing finds problems early in the development cycle. his includes both bugs in the programmer's implementation and flaws or missing parts of the specification for the unit. The process of writing a thorough set of tests forces the author to think through inputs, outputs, and error conditions, and thust more cresply define the unit's desired behavior. The cost of finding a bug before coding begins or when the code is first written is conisderably lower than the coset of detecting, identifying, and correcting the bug later. Bugs in released code may also cause costly problems for the end-users of the software. Code can be impossible or difficult to unit test if poorly written, thus unit testing can force developers to structure functions and objects in better ways.

Unit testing provides a sort of living documentation of the system. Devleopers looking to learn what funcutionality is provided by a unit, and how to use it, can look at the unit tests to gain a basic understanding of the unit's interface.

Unit testing may reduce uncertainty in the units themselves and can be used in a bottom-up testing style approach. By testing the parts of a program first and then testing the sum of its parts, integration testing becomes much easier.

- Developers looking to learn what functionality is provided by a unit and how to use it can look at the unit tests to gain a basic understanding for the unit API.
- Unit testing allows the programmer to refactor code at a later date, and make sure the module still works correctly. The procedure is to write test cases for all functions and methods so that whenver a change causes a fault, it can be quickly identified and fixed.
- Due to the modular nature of the unit testin, we cant test parts of the project without waiting for others to be completed.

## Limitations and disadvantages

Testing will not catch every error in the program , because it cannot evluate every execution path in any but the most trivial programs. This problem is a superset of the halting problem, which is undecidable. The same is tru for unit testing, Additionally, unit testing by definition only tests the functionality of the units themselves. Therefore, it will not catch integration errors or broader system-level errors (such as functions performed across multiple units, o non-functional test areas such as perfromace). TUnt testing should be done in conjunction with other software testin activities, as they only show the presence or absence of partiular errors; they cannot prove a complete absence of errors. to guarantee correct behavior for every execution path and every possible input and ensure the absence of errors, other techniques are required, namely the application of formal methods to proving that a software component has no unexpected behavior.

- Unit testing can't be expected to catch every error in a program. It is not possible to evaluate all execution paths even in the most trivial programs.
- Unit testing by its very nature focused on a unit of code. Hence it can't catch integration errors or broad system level errors.

## Unit Testing Best Practices

- Unit Test cases should be independent. In case of any enhancements or change in requirements, unit test cases should not be affected.
- Test only one code at a time.
- Follow clear and consistent naming conventions for your unit tests.
- In case of a change in code in any module, eunsure there is a corresponding unit [Test Case](https://www.guru99.com/test-case.html) for the modeul, and the module passes the tests before changing the implementation.
- Bugs identified during unit testing must be fixed before proceeding to the next phase in SDLC
- Adopt a "test as your code" approach. The more code you write without testing, the more paths you have to check for errors.

## Unit Teating: Mock Objects

Unit testing relies on mock objects being created to est sections of code that are not yet part of a complete application. Mock objects fill in for the missing parts of the program.

For example, you might have a function that needs variables or objects that are not created yet. In unit testing, those will be accounted for inthe form of mock objects created solely for the purpose of the unit testing done on that section of code.

## Unit Testing Tools

There are several automated tools available to assist with unit testing. We will provide a few examples below:

1. [Jtest](https://prsft.co/2n7GdAM): Parasoft Jtest is an IDE plucgin that leverages open-source frameworks(Junit, Mockito, PowerMock, and Spring) with guided and easy one-click actions for creating, scaling, and maintaining unit tests.

2. [Junit](https://www.guru99.com/junit-tutorial.html): Junit is a free to use teing tool used for Java programming language. It provides assertions to identify test method. This tool test data first and then inserted in the piece of code.

3. [NUnit](http://nunit.org/): NUnit is widely used unit-testing framework use for all .net languages.

4. [JMockit](http://jmockit.github.io/index.html):: JMockit is open source Unit testing tool. It is a code coverage tool with line and path metrics.

5. [EMMA](http://emma.sourceforge.net/): EMMA is an open-souce toolkit for analyzing and reporting code written in Java language. Emma support coverge types like method, line, basic block.

## Test Driven Development(TDD) & Unit Testing

Unit testing in TDD involves an extensive use of testing framewotk. A unit test framework is used in order to create automated unit tests. Unit testing frameworks are not unique to TDD, but thwy are essential to it. Below we look at some of what TDD brings to the world of unit testing:

- Tests are written before the code.
- Rely heavily on testing frameworks.
- All classes in the applications are tested.
- Quick and easy integration is made possible.

## Unit Testing Myth

    Myth: It requires time, and I am always oversheduled
    My code is rock solid! I do not need unit tests.

Myths by their very nature are false assumptions. These assumptions lead to a vicious cycle as follows:

![unit testing](../../../img-root/unit-testing.png)

Truth is Unit testing increase the speed of development.

Once units are integrated, very simple errors which could have very easily found and fixed in unit tested take a very long time to be traced and fixed.

## Summary

There can be alot involved in unit testing. It can be complex or rather simple depending on the application being tested and the testing strategies, tools and philosophies used. Unit testing is always necessary on some level. That is a certainty.

<hr/>

Get more information at [here](https://en.wikipedia.org/wiki/Unit_testing).