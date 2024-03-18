# PR Guidelines #

## 1.- A PR is segmented by function and scope #

Be sure that the PR focuses on one feature and all related files to that same feature. If the feature is too big, consider splitting the PR based on functionalities. Example: Create a PR for the main functions and another PR for the util functions that support a feature.

## 2.- Description of PR ##

### Describe the type of change ###

- [ ] Bug fix - Code is not working as expected
- [ ] New feature - Add something that didn't exist previously
- [ ] Breaking change - This affects other code/team

Please include “why” and “how” this PR needs to exist and not “what” is in the PR. It is not the same to say: “Add new methods for the payment feature” than to say “The payment feature needs to update the value of the discount and apply a new price at the end of the price quote”. 

In case of a bug fix, consider adding any relevant information on how it worked before and how it works after it is fixed. Also consider referencing other related PRs to make your description even richer.

## 3.- How Has This Been Tested? ##

Describe what tests have been done, and only include the tests for the scope of the PR. Provide instructions on how to reproduce the tests and any configuration needed to run them.

## 4.- Attached assets  ##

If the nature of the PR needs to add images/video to exemplify more the PR, be sure to add them.

## 5.- Checklist to do before creating the PR ##
- [ ] Code follows the style guidelines of this project
- [ ] Code and functionality has been self reviewed
- [ ] Commented code in hard to understand logics
- [ ] Documentation changes
- [ ] Tests have been done to the code at least for the whole functionality
- [ ] Unit/UI tests have been run 
- [ ] Dependent changes have been merged already to avoid crashing Dev or Master branch

### NOTE: If the PR doesn't follow the rules, it may result in a request for changes and worst case scenario declined. ###