!--NGN-247
Feature:          Disable user
Narrative:
In order to
As a              AgencyAdmin
I want to         check disable user functionality

Scenario: Check that 'Disable user' checkbox is present on 'User settings' page
Meta:@gdam
@projects
Given I am on Users list page
When I click element 'AddUsersToThisUnitLink' on page 'Users'
Then I should be on create user page
And I 'should' see element 'DisableUserCheckBox' on page 'UserEdit'


Scenario: Check that 'Inactive' button appears for disabled users
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | Email     | Disabled |
| USR1      | Dis_usr1  | true     |
And I am on Users list page
Then I 'should' see 'Dis_usr1' in User list
When I go to Users list page with selected user 'Dis_usr1'
Then I 'should' see element 'InactiveUserButton' on page 'Users'


Scenario: Check that Disabled user cannot log in into the system
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | Email    | Password   | Disabled |
| USR2      | Dis_usr2 | abcdefghA1 | true     |
When I logout from account
And I login to system as user with name 'Dis_usr2' and password 'abcdefghA1'
Then I should see text on page contains 'The username and password do not match'


Scenario: Check that user can log in to the system after activation (uncheck 'Disable user' )
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | Email     | Disabled |
| USR8      | Dis_usr8  | true     |
And I am on user 'Dis_usr8' details page
When I 'uncheck' 'Disable user' checkbox
And I click save on users details page
And login with details of 'Dis_usr8'
Then I should see that user 'Dis_usr8' is logged now


Scenario: Check that disabled user doesn't appear in user list for share project
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | Email     | Disabled |
| USR3      | Dis_usr3  | true     |
And created 'PRJ_USr_L01' project
And I created '/F_USr_L01' folder for project 'PRJ_USr_L01'
And I am on project 'PRJ_USr_L01' folder '/F_USr_L01' page
When I open share popup in project 'PRJ_USr_L01' for folder '/F_USr_L01' from root project
And I fill Share popup of project folder by following user 'Dis_usr3'
And I fill Share popup of project folder by following role 'project.contributor'
Then I 'should not' see user 'Dis_usr3' in autocomplete popup on Share window

Scenario: Check that disabled user doesn't appear in user list for add to project team
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | Email     | Disabled |
| USR4      | Dis_usr4  | true     |
And created 'PRJ_USr_L02' project
And I created '/F_Usr_L02' folder for project 'PRJ_USr_L02'
And I am on project 'PRJ_Usr_L02' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And type in element 'UserNameTextField' on page 'AddTeamUserPopUp' text 'USR4'
Then I 'should not' see user email 'Dis_usr4' is available for selecting in add user to team popup


Scenario: Check that disabled user doesn't appear in user list for add to template team
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | Email     | Disabled |
| USR5      | Dis_usr5  | true     |
And created 'Temp_Usr_L02' template
And I created '/F_Usr_L02' folder for template 'Temp_Usr_L02'
And I am on template 'Temp_Usr_L02' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And type in element 'UserNameTextField' on page 'AddTeamUserPopUp' text 'USR5'
Then I 'should not' see user email 'Dis_usr5' is available for selecting in add user to team popup


Scenario: Check that disabled user doesn't appear in search result in add to category
Meta:@gdam
     @bug
     @projects
!--FAB-472
Given I created users with following fields:
| FirstName | Email     | Disabled |
| USR6      | Dis_usr6  | true     |
And I created following categories:
| Name |
| Dis  |
And I am on collection 'Dis' on administration area collections page
When I click element 'AddUsers' on page 'Categories'
And I try to add user 'Dis_usr6' for category 'Dis'
Then I 'should' see empty drop down user list on 'Limit User' popup


Scenario: Check that disabled user doesn't appear in search result for send presentation
Meta:@gdam
@library
Given I created users with following fields:
| FirstName | Email     | Disabled |
| USR7      | Dis_usr7  | true     |
And I created 'Dis_reel1' reels with description 'Dis_reel1'
And I am on the presentations assets page 'Dis_reel1'
When I open Send presentation popup
And I try to add user 'Dis_usr7' on 'Send presentation' popup
Then I 'should not' see user 'Dis_usr7' is available for selecting on Send presentation popup


Scenario: Check that after activation user is visible in search result for share project
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | Email     | Disabled |
| USR9      | Dis_usr9  | true     |
And created 'PRJ_USr_L03' project
And I created '/F_USr_L03' folder for project 'PRJ_USr_L03'
And I am on user 'Dis_usr9' details page
When I 'uncheck' 'Disable user' checkbox
And I click save on users details page
And I open share popup in project 'PRJ_USr_L03' for folder '/F_USr_L03' from root project
And I click element 'Share' on page 'FilesPage'
And I fill Share popup of project folder by following user 'Dis_usr9'
Then I 'should' see user 'Dis_usr9' in autocomplete popup on Share window


Scenario: Check that after activation user is visible in search result for add to project team
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | Email     | Disabled |
| USR10     | Dis_usr10 | true     |
And created 'PRJ_USr_L04' project
And I created '/F_Usr_L04' folder for project 'PRJ_USr_L04'
And I am on user 'Dis_usr10' details page
When I 'uncheck' 'Disable user' checkbox
And I click save on users details page
And I go to project 'PRJ_USr_L04' teams page
And I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And type in element 'UserNameTextField' on page 'AddTeamUserPopUp' text 'USR10'
Then I 'should' see user email 'Dis_usr10' is available for selecting in add user to team popup


Scenario: Check that after activation user is visible in search result for add to template team
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | Email     | Disabled |
| USR11     | Dis_usr11 | true     |
And created 'Temp_Usr_L05' template
And I created '/F_Usr_L05' folder for template 'Temp_Usr_L05'
And I am on user 'Dis_usr11' details page
When I 'uncheck' 'Disable user' checkbox
And I click save on users details page
And I go to template 'Temp_Usr_L05' teams page
And I click element 'AddMemberButton' on page 'TeamsPage'
And click element 'AddMemberUserItem' on page 'TeamsPage'
And type in element 'UserNameTextField' on page 'AddTeamUserPopUp' text 'USR11'
Then I 'should' see user email 'Dis_usr11' is available for selecting in add user to team popup


Scenario: Check that after activation user is visible in search result for add to category
Meta:@gdam
@library
Given I created users with following fields:
| FirstName | Email     | Disabled |
| USR12     | Dis_usr12 | true     |
And I created following categories:
| Name |
| Dis2 |
And I am on user 'Dis_usr12' details page
When I 'uncheck' 'Disable user' checkbox
And I click save on users details page
And I go to collection 'Dis2' on administration area collections page
When I click element 'AddUsers' on page 'Categories'
And I try to add user 'Dis_usr12' for category 'Dis2'
Then I 'should' see drop down user list with 'USR12' and 'Dis_usr12' on 'Limit User' popup


Scenario: Check that after activation user is visible in search result for for send presentation
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | Email     | Disabled |
| USR13     | Dis_usr13 | true     |
And I created 'Dis_reel3' reels with description 'Dis_reel3'
And I am on user 'Dis_usr13' details page
When I 'uncheck' 'Disable user' checkbox
And I click save on users details page
When I add users 'Dis_usr13' to Address book
And I go to the presentations assets page 'Dis_reel3'
And I open Send presentation popup
And I try to add user 'Dis_usr13' on 'Send presentation' popup
Then I 'should' see user 'Dis_usr13' is available for selecting on Send presentation popup


Scenario: Check that 'Active' button appears for user after activation
Meta:@gdam
@library
Given I created users with following fields:
| FirstName | Email     | Disabled |
| USR14     | Dis_usr14 | true     |
And I am on user 'Dis_usr14' details page
When I 'uncheck' 'Disable user' checkbox
And I click save on users details page
And I go to Users list page with selected user 'Dis_usr14'
Then I 'should' see element 'ActiveUserButton' on page 'Users'


Scenario: Check that disabled users do not receive email notifications
Meta:@gdam
     @gdamemails
     @qagdamsmoke
     @livegdamsmoke
     @library
!--QA-1223
Given I created users with following fields:
| FirstName | Email     | Disabled |Access|
| USR15     | Dis_USR15 | true     |streamlined_library|
And uploaded file '/files/128_shortname.jpg' into libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets '128_shortname.jpg'NEWLIB
When I add secure share for asset '128_shortname.jpg' from collection 'My Assets' to following usersNEWLIB:
| UserEmails | Message                                     |
| Dis_USR15  | User Disabled. So email shouldn't triggered |
Then I 'should not' see email notification for 'Asset sharing with user' with field to 'Dis_USR15' and subject 'has been shared with' contains following attributes:
| UserName    | UserName1  | Agency        | FileName          | Message                                     |
| AgencyAdmin | Dis_USR15  | DefaultAgency | 128_shortname.jpg | User Disabled. So email shouldn't triggered |
When I go to user 'Dis_USR15' details page
And I 'uncheck' 'Disable user' checkbox
And I click save on users details page
And upload file '/files/logo2.png' into libraryNEWLIB
And wait while preview is available in collection 'My Assets'NEWLIB
And add secure share for asset 'logo2.png' from collection 'My Assets' to following usersNEWLIB:
| UserEmails | Message                                    |
| Dis_USR15  | User Enabled. So email should be triggered |
Then I 'should' see email notification for 'Asset sharing with user' with field to 'Dis_USR15' and subject 'has been shared with' contains following attributes:
| UserName    | UserName1  | Agency        | FileName  | Message                                    |
| AgencyAdmin | Dis_USR15  | DefaultAgency | logo2.png | User Enabled. So email should be triggered |