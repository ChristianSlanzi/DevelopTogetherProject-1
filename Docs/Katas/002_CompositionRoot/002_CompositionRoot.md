# CompositionRoot

Composition Root is a place where components from different layers of the application are wired together. The main point of having composition root is to separate configuration logic from the rest of our code, do it in a well defined place in a common manner. Having a piece of code which single responsobility is to configure other components. Creating dependencies and injecting them in constructors or properties should be done only in the Composition Root.

![composition root](https://ilya.puchka.me/static/53003f043287bfc0e700525afe0ca802/50ac3/composition_root.png)

### List of Steps

| #    | Title                                                        | Description                                       | Started    |
| ---- | ------------------------------------------------------------ | ------------------------------------------------- | ---------- |
| 000  | [Removing fixed XCode composition](002_Step_0/002_Step0_XCodeComposition.md) | How to bypass the XCode default fixed composition | 2021-03-29 |
| 001  | [App Dependencies](002_Step_1/002_Step1_AppDependencies.md)  | Let's add our composition root                    | 2021-03-29 |
| 002  | [Composing the SignupViewController](002_Step_2/002_Step2_ComposingSignup.md) | Compose the second scene                          | 2021-03-29 |

## 

