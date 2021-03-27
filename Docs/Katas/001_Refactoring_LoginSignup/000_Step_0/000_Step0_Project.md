# Step 0: Review the Project

- Here is the starting project:
  [Step_0_Code](Code/)
- First we run all the tests. They should be all green.
- That's a perfect start for analysis and refactor!
- Run also the app and try it.
- Finally review the code.
- After this steps, we can list our analysis considerations:
  - tests are taking too long because it's also performing UI Tests
  - classes are derived from NSObject, which loads objective-c.
  - The module is coupled with its UI
  - The module is not a framework
  - login doesn't have an outcome message
  - The validation outcome looks like is not perfectly synced with the fields changes. We should investigate it.
- Let's start creating a new scheme for the UI Tests indendent from the Unit tests.
- Click on the current Scheme, select Manage schemes... from the dropdown, duplicate the current scheme and name it "LoginSignupModule-UITests".
- Get back to the original scheme and select Edit Scheme
- From Build, delete the LoginSignupModuleUITests target. This will remove the ui tests from running under this scheme.
- Run the tests - all green and quickly!
- We could now remove the unit tests from the ui tests scheme.
- Perfect, now we have different schemes for different purposes!



Now your project should look like this:
[Step_0_FinalCode](FinalCode/)

Next step we'll an outcome message to the login process:

[Step 1](../000_Step_1/000_Step1_login.md)

