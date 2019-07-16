# The 7 most important software design patterns

<hr/>

## Singleton

The singleton pattern is used to limit creation of a lass to only one object. This is beneficial when one (and only one) object is needed to coordinate actions across the system. There are several examples of where only a single instance of a class should exist, includeing caches, thread pools, and registries.

**Important consideration:** It's possible to subclass a singleton by making the constructor protected instead of private. This might be suitable under some circumstances. One approach taken in these scenarios is to create a **register of singletons** of the subclasses and the **getInstance** method can take in a parameter or use an environment variable to return the desired singleton. The registry then maintains a mapping of string names to singleton objects, which can be accessed as needed. 

## Factory Method

A normal factory produces goods; a software factory produces objects. And not just that -- it does so without specifying the exact class of the object to be created. To accomplish this, objects are created by calling a factory method instead of calling a constructor

## Strategy

The strategy pattern allows grouping related algorithms under an abstraction, which allows switching out one algorithm or policy for another without modifying the client. Instead of directly implementing a single algorithm, the code receives runtime instructions specifying which of the group of algoritms to run.

## Observer

this pattern is a one-to-many dependency between objects so that when one object changes state, all its dependents are notified. This is typically done by calling one of their methods.

Key consideration: In case of many subjects and few observers, if each subject stores its observers separately, it'll increase the storage costs as some subjects will be storing the same observer multiple times.

## Builder

As the name implies, a builder pattern is used to build objects. Sometimes, the objects we create can be complex, made up of serveral sub-objects or require an elaborate construction process. The exercise of creating complex types can be simplified by using the builder pattern. A composite or an aggregate object is what builder generally builds.

Key consideration: The builder pattern might seem similar to the  'abstract factory' pattern but one difference is that the builder pattern creates an object step by step whereas the abstract factory pattern returns the object in one go.

## Adpapter

This allows incompatible classes to work together by converting the interface of one class into another. Think of it as a sort of translator: when two heads of states who don't speak a common language meet, usually an interpreter sets between the two and translators the conversation, thus enabling communication.

If you have two applications, with one spitting out output as XML with the other requiring JSON input, then you'll need an adapter between the two to make them work seamlessly.

## State

The state pattern encapsulates the various states a machine can be in, and allows an object ot alter its behavior when its interal state changes. The machine or the context, as it is called in pattern-speak, can have actions taken on it that propel it into different states. Without the use of the pattern, the code becomes inflexible and littered with if-else conditionals.

<hr/>

Get more information at [here](https://dev.to/fahimulhaq/the-7-most-important-software-design-patterns-2fea).
