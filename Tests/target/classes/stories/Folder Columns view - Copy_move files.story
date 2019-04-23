Feature:          Folder columns view - Copy, Move files
Narrative:
In order to
As a              AgencyAdmin
I want to         check that copy, move files work in folder columns view


Scenario: check that user can copy file from one folder to another folder in current project
Meta:@gdam
@library
Given I created the agency 'A_FCVCMF' with default attributes
And created users with following fields:
| Email    | Role         | AgencyUnique |
| U_FCVCMF | agency.admin | A_FCVCMF     |
And logged in with details of 'U_FCVCMF'
And I created 'P1_FCVCMF' project
And created in 'P1_FCVCMF' project next folders:
| folder       |
| /F1_1_FCVCMF |
| /F1_2_FCVCMF |
And uploaded '/files/_file1.gif' file into '/F1_1_FCVCMF' folder for 'P1_FCVCMF' project
And I waited while preview is available in folder '/F1_1_FCVCMF' on project 'P1_FCVCMF' files page
And I am on project 'P1_FCVCMF' folder '/F1_1_FCVCMF' page
When I switch to 'list' view
And I click on Want to copy files to another project link on move/copy file '_file1.gif' popup
And I enter 'P1_FCVCMF' in search field on move/copy file popup
And I select folder '/F1_2_FCVCMF' on move/copy file popup
And I click copy button on move/copy files popup
And go to project 'P1_FCVCMF' folder '/F1_2_FCVCMF' page
Then I 'should' see file '_file1.gif' on project files page and files count are '1'


Scenario: check that user can move file from one folder to another folder in current project
Meta:@gdam
@library
Given I created the agency 'A_FCVCMF' with default attributes
And created users with following fields:
| Email    | Role         | AgencyUnique |
| U_FCVCMF | agency.admin | A_FCVCMF     |
And logged in with details of 'U_FCVCMF'
And I created 'P2_FCVCMF' project
And created in 'P2_FCVCMF' project next folders:
| folder       |
| /F2_1_FCVCMF |
| /F2_2_FCVCMF |
And uploaded '/files/_file1.gif' file into '/F2_1_FCVCMF' folder for 'P2_FCVCMF' project
And I waited while preview is available in folder '/F2_1_FCVCMF' on project 'P2_FCVCMF' files page
And I am on project 'P2_FCVCMF' folder '/F2_1_FCVCMF' page
When I switch to 'list' view
And I click on Want to move files to another project link on move/copy file '_file1.gif' popup
And I enter 'P2_FCVCMF' in search field on move/copy file popup
And I select folder '/F2_2_FCVCMF' on move/copy file popup
And I click copy button on move/copy files popup
And go to project 'P2_FCVCMF' folder '/F2_2_FCVCMF' page
Then I 'should' see file '_file1.gif' on project files page and files count are '1'
When go to project 'P2_FCVCMF' folder '/F2_1_FCVCMF' page
Then I 'should not' see file '_file1.gif' on project files page and files count are '1'


Scenario: check that user can copy file from one folder to another project
Meta:@gdam
@library
Given I created the agency 'A_FCVCMF' with default attributes
And created users with following fields:
| Email    | Role         | AgencyUnique |
| U_FCVCMF | agency.admin | A_FCVCMF     |
And logged in with details of 'U_FCVCMF'
And I created 'P3_1_FCVCMF' project
And created 'P3_2_FCVCMF' project
And created in 'P3_1_FCVCMF' project next folders:
| folder       |
| /F3_1_FCVCMF |
And created in 'P3_2_FCVCMF' project next folders:
| folder       |
| /F3_2_FCVCMF |
And uploaded '/files/_file1.gif' file into '/F3_1_FCVCMF' folder for 'P3_1_FCVCMF' project
And I waited while preview is available in folder '/F3_1_FCVCMF' on project 'P3_1_FCVCMF' files page
And I am on project 'P3_1_FCVCMF' folder '/F3_1_FCVCMF' page
When I switch to 'list' view
And I click on Want to copy files to another project link on move/copy file '_file1.gif' popup
And I enter 'P3_2_FCVCMF' in search field on move/copy file popup
And I select folder '/F3_2_FCVCMF' on move/copy file popup
And I click copy button on move/copy files popup
And go to project 'P3_2_FCVCMF' folder '/F3_2_FCVCMF' page
Then I 'should' see file '_file1.gif' on project files page and files count are '1'


Scenario: check that user can move file from one folder to another project
Meta:@gdam
@library
Given I created the agency 'A_FCVCMF' with default attributes
And created users with following fields:
| Email    | Role         | AgencyUnique |
| U_FCVCMF | agency.admin | A_FCVCMF     |
And logged in with details of 'U_FCVCMF'
And I created 'P4_1_FCVCMF' project
And created 'P4_2_FCVCMF' project
And created in 'P4_1_FCVCMF' project next folders:
| folder       |
| /F4_1_FCVCMF |
And created in 'P4_2_FCVCMF' project next folders:
| folder       |
| /F4_2_FCVCMF |
And uploaded '/files/_file1.gif' file into '/F4_1_FCVCMF' folder for 'P4_1_FCVCMF' project
And I waited while preview is available in folder '/F4_1_FCVCMF' on project 'P4_1_FCVCMF' files page
And I am on project 'P4_1_FCVCMF' folder '/F4_1_FCVCMF' page
When I switch to 'list' view
And I click on Want to move files to another project link on move/copy file '_file1.gif' popup
And I enter 'P4_2_FCVCMF' in search field on move/copy file popup
And I select folder '/F4_2_FCVCMF' on move/copy file popup
And I click copy button on move/copy files popup
And go to project 'P4_2_FCVCMF' folder '/F4_2_FCVCMF' page
Then I 'should' see file '_file1.gif' on project files page and files count are '1'
When go to project 'P4_1_FCVCMF' folder '/F4_1_FCVCMF' page
Then I 'should not' see file '_file1.gif' on project files page and files count are '1'