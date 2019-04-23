!--NGN-1808
Feature:          File Activity
Narrative:
In order to
As a              AgencyAdmin
I want to         Check activity for file
Meta:


Scenario: Check that file activity filter action type works
Given I created users with following fields:
| FirstName       | LastName    | Email  | Role         |
| Testname        | LastName    | FA_U_6 | agency.admin |
And logged in with details of 'FA_U_6'
And created 'FAP6' project
And created '/FAF6' folder for project 'FAP6'
And uploaded '/files/Fish Ad.mov' file into '/FAF6' folder for 'FAP6' project
And waited while file 'Fish Ad.mov' fully uploaded to folder folder '/FAF6' of project 'FAP6'
When I go to file '/files/Fish Ad.mov' info page in folder '/FAF6' project 'FAP6'
And I set Action ' project' on Activity tab on open uploaded file '/files/Fish Ad.mov' in folder '/FAF6' project 'FAP6'
And I click on filter button in Activity tab on open uploaded file '/files/Fish Ad.mov' in folder '/FAF6' project 'FAP6'
Then I should see on Activity tab for file '/files/Fish Ad.mov' in folder '/FAF6' project 'FAP6' empty results

Scenario: Check that file activity filter action type displays proper activities
Given logged in with details of 'FA_U_6'
When I go to file '/files/Fish Ad.mov' info page in folder '/FAF6' project 'FAP6'
And I set Action 'Created file' on Activity tab on open uploaded file '/files/Fish Ad.mov' in folder '/FAF6' project 'FAP6'
And I click on filter button in Activity tab on open uploaded file '/files/Fish Ad.mov' in folder '/FAF6' project 'FAP6'
Then I 'should' see on Activity tab for file '/files/Fish Ad.mov' in folder '/FAF6' project 'FAP6' following recent user's activity :
| User   | Logo  | ActivityType | ActivityMessage |
| FA_U_6 | EMPTY | created      | created file    |

Scenario: Check that file activity filter action type and username displays proper activities
Given logged in with details of 'FA_U_6'
When I go to file '/files/Fish Ad.mov' info page in folder '/FAF6' project 'FAP6'
And I set Action 'Created file' on Activity tab on open uploaded file '/files/Fish Ad.mov' in folder '/FAF6' project 'FAP6'
And I type an userName 'FA_U_6' on Activity tab on open uploaded file '/files/Fish Ad.mov' in folder '/FAF6' project 'FAP6'
And I click on filter button in Activity tab on open uploaded file '/files/Fish Ad.mov' in folder '/FAF6' project 'FAP6'
Then I 'should' see on Activity tab for file '/files/Fish Ad.mov' in folder '/FAF6' project 'FAP6' following recent user's activity :
| User   | Logo  | ActivityType | ActivityMessage |
| FA_U_6 | EMPTY | created      | created file    |
