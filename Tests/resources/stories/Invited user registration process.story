!--NGN-4968 NGN-8876
Feature:          Invited user registration process
BookNarrative:
In order to
As a              AgencyAdmin
I want to         check registration process for newly invited users and redirects after different activities

Scenario: Check that registration page has Branding from Sender agency (invite via Address book)
Meta:@gdam
@gdamemails
Given I created the agency 'A_IURP_S01' with default attributes
And updated agency 'A_IURP_S01' login page with following attributes:
| Logo | Background | BackgroundAlign | TextColor | FooterTextColor | ButtonColor | LinkColor | FooterColor | BackgroundColor | FooterText  | Message |
| JPG  | PNG        | left            | #5c775a   | #5c775b         | #5c775c     | #5c775d   | #afafaf     | #d2d2d2         | Footer Text | Message |
And created users with following fields:
| Email       | Role         | Agency     |
| AU_IURP_S01 | agency.admin | A_IURP_S01 |
And logged in with details of 'AU_IURP_S01'
And invited user 'TU_IURP_S01'
When I logout from account
And open link from email when user 'TU_IURP_S01' received email with next subject 'You are invited to the Adstream Platform'
And fill registration form with following fields:
| FirstName | LastName | Password   | ConfirmPassword |
| Eric      | Cartman  | abcdefghA1 | abcdefghA1      |
Then I 'should' see following attributes on opened registration page:
| Logo | Background | BackgroundAlign | TextColor | FooterTextColor | ButtonColor | LinkColor | FooterColor | BackgroundColor | FooterText  | Message |
| JPG  | PNG        | left            | #5c775a   | #5c775b         | #5c775c     | #5c775d   | #afafaf     | #d2d2d2         | Footer Text | Message |


Scenario: Check that user should set password according to BU rules (add owner +confirm password check)
Meta:@gdam
@gdamemails
Given I created the agency 'A_IURP_S02' with default attributes
And updated password rules for agency 'A_IURP_S02' with following attributes:
| MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
| 2                     | 1                        | 1            |
And created users with following fields:
| Email       | Role         | Agency     |
| AU_IURP_S02 | agency.admin | A_IURP_S02 |
And logged in with details of 'AU_IURP_S02'
And created '<ProjectName>' project
And edited the following fields for '<ProjectName>' project:
| Name          | Administrators    |
| <ProjectName> | <TestedUserEmail> |
And clicked on element 'SaveButton'
And waited for '4' seconds
When I logout from account
And open link from email when user '<TestedUserEmail>' received email with next subject 'You are invited to Adbank'
And fill registration form with following fields:
| FirstName      | LastName       | Password             | ConfirmPassword             |
| TU_IURP_S02_FN | TU_IURP_S02_LN | <TestedUserPassword> | <TestedUserConfirmPassword> |
And click element 'SaveButton' on page 'Registration' without delay
Then I '<Condition>' see warning message 'Password does not match the rule. Try another.' on page


Examples:
| ProjectName  | TestedUserEmail | TestedUserPassword | TestedUserConfirmPassword | Condition  |
| P_IURP_S02_1 | TU_IURP_S02_1   | abF5               | abF5                      | should not |
| P_IURP_S02_2 | TU_IURP_S02_2   | ok3310ABC          | ok3310ABC                 | should not |
| P_IURP_S02_3 | TU_IURP_S02_3   | test               | test                      | should     |


Scenario: Check that user should not see active save button if passwords don't match
Meta:@gdam
@gdamemails
Given I created the agency 'A_IURP_S02' with default attributes
And updated password rules for agency 'A_IURP_S02' with following attributes:
| MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
| 2                     | 1                        | 1            |
And created users with following fields:
| Email       | Role         | Agency     |
| AU_IURP_S02 | agency.admin | A_IURP_S02 |
And logged in with details of 'AU_IURP_S02'
And created '<ProjectName>' project
And edited the following fields for '<ProjectName>' project:
| Name          | Administrators    |
| <ProjectName> | <TestedUserEmail> |
And clicked on element 'SaveButton'
And waited for '2' seconds
When I logout from account
And open link from email when user '<TestedUserEmail>' received email with next subject 'You are invited to Adbank'
And fill registration form with following fields:
| Password             | ConfirmPassword             |
| <TestedUserPassword> | <TestedUserConfirmPassword> |
Then I '<Condition>' see element 'ActiveSaveButton' on page 'Registration'

Examples:
| ProjectName  | TestedUserEmail | TestedUserPassword | TestedUserConfirmPassword | Condition  |
| P_IURP_S02_4 | TU_IURP_S02_4   | toDo3              | TOdO3                     | should not |


Scenario: Check that user sees password guidance on registration page ('Secure share file' case)
!--NGN-8938
Meta:@gdam
@gdamemails
Given I created the agency 'A_IURP_X01' with default attributes
And updated password rules for agency 'A_IURP_X01' with following attributes:
| MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
| 8                     | 1                        | 1            |
And created users with following fields:
| Email       | Role         | Agency     |
| AU_IURP_X01 | agency.admin | A_IURP_X01 |
When I login with details of 'AU_IURP_X01'
And I created 'P_IURP_S03' project
And create '/F_IURP_S03' folder for project 'P_IURP_S03'
And upload '/files/Fish1-Ad.mov' file into '/F_IURP_S03' folder for 'P_IURP_S03' project
When I add secure share for file 'Fish1-Ad.mov' from folder '/F_IURP_S03' and project 'P_IURP_S03' to following users:
| UserEmails  |
| TU_IURP_S03 |
And logout from account
And open link from email when user 'TU_IURP_S03' received email with next subject 'You are invited to Adbank'
Then I 'should' see message about password rules on registration page with following attributes:
| MinimumPasswordLength | UppercaseCharactersCount | NumbersCount |
| 8                     | 1                        | 1            |

Scenario: Check that user is redirected to folder after registration
!--NGN-8605
Meta:@gdam
@gdamemails
Given I created 'P_IURP_S04' project
And created '/F_IURP_S04' folder for project 'P_IURP_S04'
And fill Share popup by users 'TU_IURP_S04' in project 'P_IURP_S04' for following folders '/F_IURP_S04' with role 'project.user' expired '12.12.2022' and 'should' access to subfolders
When I logout from account
And open link from email when user 'TU_IURP_S04' received email with next subject 'You have been invited'
And register user with following fields on opened registration page:
| FirstName | LastName | Password   | ConfirmPassword |
| Eric      | Cartman  | abcdefghA1 | abcdefghA1      |
Then I 'should' be on the project files page


Scenario: Check that newly invited user is redirected to approval tab after start stage for unregistered user
!--As per SPB-14, user should be landed on Dashboard page for approvals
Meta:@gdam
@gdamemails
Given I created 'P_IURP_S05' project
And created '/F_IURP_S05' folder for project 'P_IURP_S05'
And uploaded '/files/Fish1-Ad.mov' file into '/F_IURP_S05' folder for 'P_IURP_S05' project
And waited while preview is available in folder '/F_IURP_S05' on project 'P_IURP_S05' files page
And added approval stage on file 'Fish1-Ad.mov' approvals page in folder '/F_IURP_S05' project 'P_IURP_S05':
| Name        | Approvers   | Deadline         | Started |
| AS_IURP_S05 | TU_IURP_S05 | 01/05/2023 12:15 | true    |
When I logout from account
And open link from email when user 'TU_IURP_S05' received email with next subject 'You are invited to the Adstream Platform'
And register user with following fields on opened registration page:
| FirstName | LastName | Password   | ConfirmPassword |
| Eric      | Cartman  | abcdefghA1 | abcdefghA1      |
Then I 'should' be on the Dashboard page


Scenario: Check that invited user is redirected to shared file page after registration (secure share)
!--NGN-8605
Meta:@gdam
@gdamemails
Given I created 'P_IURP_S06' project
And created '/F_IURP_S06' folder for project 'P_IURP_S06'
And uploaded '/files/Fish1-Ad.mov' file into '/F_IURP_S06' folder for 'P_IURP_S06' project
And waited while preview is available in folder '/F_IURP_S06' on project 'P_IURP_S06' files page
When I add secure share for file 'Fish1-Ad.mov' from folder '/F_IURP_S06' and project 'P_IURP_S06' to following users:
| UserEmails  |
| TU_IURP_S06 |
And logout from account
And open link from email when user 'TU_IURP_S06' received email with next subject 'You are invited to Adbank'
And register user with following fields on opened registration page:
| FirstName | LastName | Password   | ConfirmPassword |
| Eric      | Cartman  | abcdefghA1 | abcdefghA1      |
Then I 'should' be on the asset info page


Scenario: Check that newly invited user redirects to project overview page (add admin to project)
!--NGN-8605
Meta:@gdam
@gdamemails
Given I created 'P_IURP_S07' project
And edited the following fields for 'P_IURP_S07' project:
| Name       | Administrators |
| P_IURP_S07 | TU_IURP_S07    |
And clicked on element 'SaveButton'
And waited for '3' seconds
When I logout from account
And open link from email when user 'TU_IURP_S07' received email with next subject 'You are invited to Adbank'
And register user with following fields on opened registration page:
| FirstName | LastName | Password   | ConfirmPassword |
| Eric      | Cartman  | abcdefghA1 | abcdefghA1      |
Then I 'should' be on the project overview page


Scenario: Check that invited user is redirected to Registartion page if open link in email after create project from template
!--NGN-8575
Meta:@gdam
@gdamemails
Given I created 'T_IURP_S08' template
And created '/F_IURP_S08' folder for template 'T_IURP_S08'
And edited the following fields for 'T_IURP_S08' template:
| Name       | Administrators |
| T_IURP_S08 | TU_IURP_S08    |
And clicked on element 'SaveButton'
And waited for '5' seconds
When I use 'T_IURP_S08' template
And fill the following fields for project from template:
| Name       | Start Date | End Date   |
| P_IURP_S08 | [Today]    | [Tomorrow] |
And click on element 'SaveButton'
And refresh the page
And publish the project 'P_IURP_S08'
And logout from account
And open link from email when user 'TU_IURP_S08' received email with next subject 'You are invited to Adbank'
Then I 'should' be on the registration page


Scenario: Check that invited user is redirected to project overview after registration (create project from template)
!--NGN-8605
Meta:@gdam
@gdamemails
Given I created 'T_IURP_S09' template
And created '/F_IURP_S09' folder for template 'T_IURP_S09'
And edited the following fields for 'T_IURP_S09' template:
| Name       | Administrators |
| T_IURP_S09 | TU_IURP_S09    |
And clicked on element 'SaveButton'
And waited for '5' seconds
When I use 'T_IURP_S09' template
And fill the following fields for project from template:
| Name       | Start Date | End Date   |
| P_IURP_S09 | [Today]    | [Tomorrow] |
And click on element 'SaveButton'
And publish the project 'P_IURP_S09'
And logout from account
And open link from email when user 'TU_IURP_S09' received email with next subject 'You are invited to Adbank'
And register user with following fields on opened registration page:
| FirstName | LastName | Password   | ConfirmPassword |
| Eric      | Cartman  | abcdefghA1 | abcdefghA1      |
Then I 'should' be on the project overview page