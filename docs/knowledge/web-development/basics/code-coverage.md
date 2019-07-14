# Code coverage

<hr/>

## What is Code coverage

Code coverage is a measure which describes the degree of which the source code o the program has been tested. It one form of white box testing which finds the areas of the set of test cases. It also creates some test cases to increase coverage and determining a quantitative measure of code coverage.

## Why use Code Coverage

Here, are some prime reasons for using code coverage:

- It helps you to measure the efficiency of test implementation.
- It offer a quantitative measurement.
- It defines the degree to which the source code has been tested.

## Code Coverage Methods

### Statement Coverage

Statement coverage is a white box test design technique which involves execution of all the executable statements in the source code at least once. It is used to calculate and measure the number of statements in the source code which can be executed given the requirements.

Statement coverage is used to derive scenario based upon the structure of the code under test.

    Statement Coverage = (Number of excuted statements / Total number of statements) * 100

**What is covered by Statement Coverage?**

1. Unused Statements
2. Dead Code
3. Unused Branches

### Decision Coverage

Decision coverage reports the true or false outcomes of each Boolean expression. In this coverage, expressions can sometimes get complicated. Therefore, it is very hard to achieve 100% coverage.

That's why there are many different methods of reporting this metric. All these methods focus on covering the most important combinations. It is very much similar to decision coverage, but it offers better sensitivity to control flow.

    Decision Coverage = (Number of Decision Outcomes Exercised/Tootal Number of Decision Outcomes) * 100

### Branch Coverage

In the branch coverage, every outcome from a code module is tested. if the outcomes are binary, you need to test both True and False outcomes.

By using Branch coverage method, you can also measure the fraction of independent code segments. it also helps you to find out which is sections of code don't have any branches.

    Branch Coverage = (Number of Executed Branched/Total Number of Branches) * 100

Branch coverage Testing offers the following advantages:

- Allows you to validate-all the branches in the code.
- Helps you to ensure that no branched lead to any abnormality of the program's operation.
- Branch coverage method removes issues which happen because of statement coverage testing.
- Allows you to find those areas which are not tested by other testing methods.
- It allows you to find a quantitative measure of code coverage.
- Branch coverage ignores branches inside the Boolean expressions.

### Condition Coverage

Conditional coverage or expression coverage will reveal how the variables or subexpressions in the coditional statement are evaluated. In this coverage expressions with logical operands are only considered.

Conditional coverage offers better sensitivity to the control flow thatn decision coverage. Condition coverage does not give a guarantee about full decision coverage.

    Condition Coverage = (Number of Executed Operands/ Total Number of Operands) * 100

## Finite State Machine Coverage

Finite state machine coverage is certainly the most complex type of code coverage method. This is because it works on the behavior of the design. In this coverage method, you need to look for how many time-specific states are visited, transited. It also checks how many sequences are included in a finite state machine.

## Which Type of Code Coverage to Choose

This is certainly the most difficult answer to give. In order to select a coverage method, the tester needs to check that the

- code under test has single or multiple undiscovered defects.
- cost of the potential penalty.
- cost of lost reputation.
- cost of lost sale, etc.

## Advantages of Using Code Coverage

- Helpful to evaluate a quantitative measure of code coverage.
- It allows you to create extra test cased to increase coverage.
- It allows you to find the areas of a program which is not exercised by a set of test cases.

## Disadvantages of Using Code Coverage

- Even when any specifc feature is not implemented in design, code coverage still report 100% coverage.
- It is not possible to determine whetger we tested all possible values of a feature with the help of code coverage.
- Code coverage is also not telling how much and how well you have covered your logic.
- In the case when the specified function hasn't implemented, or a not incluced from the specification, then structure-based techniques cannot find that issue.

## Summary

- Code coverage is a measure which describes the degree of which the source code of the program has been tested.
- It helps you to measure the efficiency of test implementation.
- Five Code Coverage methods are 1.) Statement Coverage 2.) Condition Coverage 3.) Branch Coverage 4) Toggle Coverage 5) FSM Coverage.
- Statement coverage involves execution of all the executable statements in the source code at least once.
- Decision coverage reports the true or false outcomes of each Boolean expression.
- In the branch coverage, every outcome from a code module is tested.
- Conditional will reveal how the variables or subexpressions in the conditional statement are evaluated.
- Finite state machine coverage is certainly the most complext type of code coverage method.
- In order to select a coverage method, the tester needs to check the cost of the potential penalty, lost reputation, lost sale, etc.
- Code coverage tells you how well the source code has been exercised by your test bench while Functional coverage measures how well the functionality of the design has been covered.
- Covertura, JTest, Clover, Emma, Kalistick are few important code coverage tools.
- Code Coverage allows you to create extra test cases to increase coverage.
- Code Coverage does help you to determine whether we tested all possible value of a feature.

<hr/>

Get more information at [here](https://www.guru99.com/code-coverage.html).
