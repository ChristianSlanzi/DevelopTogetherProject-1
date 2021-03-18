# Clean Code principles and practices

The goal of Clean Code principles and practices is to produce software efficiently and effectively, and to design the code so that it is easily

- readable
- expandable
- maintainable



## Principles

#### SOLID

Together, the Single Responsibility Principle, the Open Closed Principle, the Liskov Substitution Principle, the Interface Segregation Principle and the Dependency Inversion Principle are known as the SOLID Principle.

#### DRY – Dont’ Repeat Yourself

Reduce the repetition of software patterns, replacing them with abstractions or using data normalisation to avoid redundancies.

#### KISS – **K**eep **I**t **S**imple and **S**tupid

Always use the simplest solution to a problem.

#### Beware of Optimisations

Optimisations often cause high expenses, they are often neither necessary nor useful.  If you do optimise, do it after a through analysis.

#### **F**avour **C**omposition **o**ver **I**nheritance

With composition classes are separated from their algorithm and their details in order to be able to change the behaviour of a class at runtime.

#### **S**ingle **L**evel of **A**bstraction

Different levels of abstraction of functions should not be mixed in order to increase the readability, understandability and maintainability of the code.

#### Source Code Conventions

Define guidelines that help to structurally improve software quality.

#### **S**eparation of **C**oncerns

Calls for a class to concentrate on a specific aspect in order to be able to test individual concerns separately and to make adjustments in a manageable way.

#### Principle of Least Astonishment

A user interface should always be designed so that the user experiences as few surprises as possible.

#### Law of Demeter

Objects should only communicate with objects in their immediate environment in order to reduce coupling.

#### Tell, Don't Ask Principle

It is about bundling data with the functions that work with this data. Instead oof asking an object for data in order to act with this data, the object should be told what it should do.

#### Design and Implementation don't overlap

Inconsistencies should be minimised by separating the responsibilities between design or architecture and implementation.

#### Implementation Reflects Design

Implementation should not exist independently of design or architecture.

#### YAGNI - You Ain't Gonna Need It

Functionality is only implemented when it is actually needed.



## Practices

#### Observe Boy Scout Rule

"Always leave a place in a better condition than you found it". Small things in the codee should be improved and bugs should be fixed before they mutate into bigger problems.

#### Carry Out a Root Cause Analysis

Focuses on the elimination of causes rather than the elimination of symptoms.

#### Use Version Control System

Version managment deals with the administration of files including archiving, logging, recovery and access coordination.

#### Apply Simple Refactoring Patterns

Refactoring addresses the restructuring of a software while retaining the range of functions.

#### Reflect Daily

Reflection is the prerequisite for active learning.

#### Issue Tracking

Also know as Bug Tracking, describes the process from the recording to the elimination of bugs, open issues, requests etc.

#### Use Automated Integration Tests

Integration tests check the cooperation of different components, after a refactoring or extension.

#### Conduct Reviews

Reviews increase the quality of the code, weather in the course of pair programming, peer reviews or code reviews.

#### Read and Educate Yourself

Stay up to date

#### Use Automated Unit Tests

Unit tests check wether the developed components work as intended.

#### Use Mockups

For the isolated testing of individual components, dependencies must be eliminated. Mockups or mock objects are test dummies that interact with the component to be tested.

#### Analyse Code Coverage

Code coverage expresses what part of the source code is executed by test cases.

#### Carry out Complex Refactoring

It is not possible to implement code directly in an optimal form. Complex refactorings can be checked by automated tests.

#### Take Part in Professional Events

It is important tp exchange ideas with other developers, for example at meetings, in user groups or at conventions.

#### Pursue Continuos Integration

The continuous integration of components into an application - for example in the form of daily builds - offers the advantage of diagnosing incompatibility and integration problems quickly and not only at the end of an interation.

#### Collect Metrics

Static code analysis helps to check correctness by means of automated tests or to determine compliance with requirements. The changeability of a software can also be partially determined by metrics.

#### Use Inversion of Control Container

The IoC Container helps to instantiate and connect many small objects that are created as a result of the SoC principle. It also helps to reconfigure classes for test cases.

#### Pass on Experience

Only through the transfer of knowledge does true reflection take place.

#### Measure Errors

To minimise the number of errors reported by customers after the release of a new version. The comparability of the measurements is more important than precision.

#### Pursue Continuous Delivery

Continuous Delivery describes a process for the delivery of tested updates, in which setup and deployment are automated. It follows after the Continuous Integration.

Conduct Iterative Development

Development in iterations and short feedback cycles are two essential success factors of software development. As a result, the risk of erroneous developments decreases and the quality of the software increases.

Develop in a component-oriented way

Component-oriented development promotes productivity through parallel implementation, improves the clarity of the application and facilitates testing of the individual components.

Test first

Test first propagates that interfaces and a correspondingly desired behaviour are described by tests. This approach simultaneously produces specification documentation in the form of executable code that can be automatically checked.