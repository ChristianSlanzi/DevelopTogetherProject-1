# Refactoring Login/Signup

In this Kata we'll show how is possible to refactore a module being sure that after each change it is still working as before. This can be assured because the module has tests and because we do the refactoring continuing our TDD approach.

We'll take the LoginSignup we developed in the first Kata. After a review, some considerations came out:

- tests are taking too long because it's also performing UI Tests
- login doesn't have an outcome message
- classes are derived from NSObject, which loads objective-c.
- The module is coupled with its UI
- The module is not a framework

In the tutorial documentation we'll show step by step which are the task required to Refactor our Login/Signup and we'll break this development in steps. For each Step we'll provided the initial source code and the final source code, so that you can follow us along the development and that you are able to make a comparison with your version.

Every Step will be listed in the following table:

### List of Steps

| #    | Title                                     | Description        | Started    |
| ---- | ----------------------------------------- | ------------------ | ---------- |
| 000  | [Step 0](000_Step_0/000_Step0_Project.md) | Review the project | 2021-03-27 |
|      |                                           |                    |            |
|      |                                           |                    |            |
|      |                                           |                    |            |
|      |                                           |                    |            |
|      |                                           |                    |            |
|      |                                           |                    |            |
|      |                                           |                    |            |
|      |                                           |                    |            |
|      |                                           |                    |            |
|      |                                           |                    |            |
|      |                                           |                    |            |
|      |                                           |                    |            |
|      |                                           |                    |            |
|      |                                           |                    |            |
|      |                                           |                    |            |
|      |                                           |                    |            |

