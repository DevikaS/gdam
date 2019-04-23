!--NGN-278
Feature:          Project Share folder - Change permissions
Narrative:
In order to
As a              AgencyAdmin
I want to         Check sharing folder


Scenario: Check that 'Access to subfolders' permissions can be changed
Meta:@gdam
@projects
Given I created 'PR_PSFCP1' role in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| first1    | last1    | aaaaaaaa1 | 80501554825 | guest.user |
| first2    | last2    | bbbbbbbb1 | 80501554825 | guest.user |
And I created 'PSFCP1' project
And created '/PSFCPF1' folder for project 'PSFCP1'
When I open share popup in project 'PSFCP1' for folder '/PSFCPF1' from root project
And fill Share window of project folder for following users:
| User      | Role      | ExpiredDate | ShouldAccess |
| aaaaaaaa1 | PR_PSFCP1 |             | should not   |
| bbbbbbbb1 | PR_PSFCP1 |             | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
And change data on Users already on this folder tab on following:
| User      | Role      | ExpiredDate | ShouldAccess |
| bbbbbbbb1 | PR_PSFCP1 |             | should       |
!-- And go to Users already on this folder tab after 'Save' changes on Share window
Then I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email       | Role      | ExpiredDate | ShouldAccess |
| AgencyAdmin |           |             | should       |
| aaaaaaaa1   | PR_PSFCP1 |             | should not   |
| bbbbbbbb1   | PR_PSFCP1 |             | should       |


Scenario: Check that user is removed from Share when Expiration date is passed
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| first3    | last3    | aaaaaaaa2 | 80501554825 | guest.user |
And I created 'PSFCP2' project
And created '/PSFCPF2' folder for project 'PSFCP2'
And I am on project 'PSFCP2' folder '/PSFCPF2' page
And added users 'aaaaaaaa2' to project 'PSFCP2' team folders '/PSFCPF2' with role 'project.observer' expired '11.11.2011'
When login with details of 'aaaaaaaa2'
And I go to project list page
Then I 'should not' see '/PSFCPF2' folder in 'PSFCP2' project


Scenario: Check that team template users are removed from Share when 'Expiration Date ' date is passed
Meta:@gdam
@projects
Given I created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| first4    | last4    | aaaaaaaa3 | 80501554825 | guest.user |
| first5    | last5    | bbbbbbbb3 | 80501554825 | guest.user |
And I created 'PSFCP3' project
And created '/PSFCPF3' folder for project 'PSFCP3'
And I added users to team template with the following fields:
| UserName  | TeamTemplate |
| aaaaaaaa3 | 1ttcp1       |
| bbbbbbbb3 | 1ttcp1       |
And I am on project 'PSFCP3' folder '/PSFCPF3' page
And added team template '1ttcp1' to project 'PSFCP3' team folders '/PSFCPF3' with role 'project.observer' expired '11.11.2011'
When login with details of 'aaaaaaaa3'
And I go to project list page
Then I 'should not' see '/PSFCPF3' folder in 'PSFCP3' project


Scenario: Check if access is removed from all folders, user should not be displayed on 'Users Already on this folder' page anymore
Meta:@gdam
@projects
Given I created 'PR_PSFCP4' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| first5    | last5    | aaaaaaaa4 | 80501554825 | guest.user |
And I created 'PSFCP4' project
And created '/PSFCPF4' folder for project 'PSFCP4'
When I open share popup in project 'PSFCP4' for folder '/PSFCPF4' from root project
And fill Share window of project folder for following users:
| User      | Role      | ExpiredDate | ShouldAccess |
| aaaaaaaa4 | PR_PSFCP4 | 12.12.2050  | should not   |
And click element 'Add' on page 'ShareWindow'
And go to project 'PSFCP4' teams page
And open user 'aaaaaaaa4' permissions on project 'PSFCP4' team page
And select folder '/PSFCPF4' in manage permissions popup of project 'PSFCP4' team for user 'aaaaaaaa4'
And remove 'PR_PSFCP4' role on permissions popup of project team tab
And click Save button on permissions popup of project team tab
And wait for '3' seconds
And go to project 'PSFCP4' folder '/PSFCPF4' page
And open share popup in project 'PSFCP4' for folder '/PSFCPF4' from root project
And click element 'UsersAlreadyOnThisFolder' on page 'ShareWindow'
Then I 'should not' see user 'aaaaaaaa4' with role 'PR_PSFCP4' on Users already on this folder tab


Scenario: Check if access is removed from all folders, users from team template should not be displayed on 'Users Already on this folder' page anymore
Meta:@gdam
@projects
Given I created 'PR_PSFCP5' role in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| first6    | last6    | aaaaaaaa5 | 80501554825 | guest.user |
And added user 'aaaaaaaa5' to Address book
And I created 'PSFCP5' project
And created '/PSFCPF5' folder for project 'PSFCP5'
And I added users to team template with the following fields:
| UserName  | TeamTemplate |
| aaaaaaaa5 | 3tt3         |
When I open share popup in project 'PSFCP5' for folder '/PSFCPF5' from root project
And fill Share window of project folder for following team templates :
| TeamTemplate | Role      |
| 3tt3         | PR_PSFCP5 |
And click element 'Add' on page 'ShareWindow'
And go to project 'PSFCP5' teams page
And open user 'aaaaaaaa5' permissions on project 'PSFCP5' team page
And select folder '/PSFCPF5' in manage permissions popup of project 'PSFCP5' team for user 'aaaaaaaa5'
And remove 'PR_PSFCP5' role on permissions popup of project team tab
And click Save button on permissions popup of project team tab
And wait for '2' seconds
And open share popup in project 'PSFCP5' for folder '/PSFCPF5' from root project
And click element 'UsersAlreadyOnThisFolder' on page 'ShareWindow'
Then I 'should not' see user 'aaaaaaaa5' with role 'PR_PSFCP5' on Users already on this folder tab


Scenario: Check re-add user to folder with another permission (Folder Share)
Meta:@gdam
@projects
Given I created following roles:
| RoleName  | Group   |
| PR_PSFCP5 | project |
| PR_PSFCP6 | project |
And created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| first7    | last7    | aaaaaaaa6 | 80501554825 | guest.user |
And I created 'PSFCP6' project
And created '/PSFCPF6' folder for project 'PSFCP6'
When I open share popup in project 'PSFCP6' for folder '/PSFCPF6' from root project
And fill Share window of project folder for following users:
| User      | Role      | ExpiredDate | ShouldAccess |
| aaaaaaaa6 | PR_PSFCP5 |             | should not   |
And click element 'Add' on page 'ShareWindow'
And open share popup in project 'PSFCP6' for folder '/PSFCPF6' from root project
And fill Share window of project folder for following users:
| User      | Role       | ExpiredDate | ShouldAccess |
| aaaaaaaa6 | PR_PSFCP6  |             | should not   |
And go to Users already on this folder tab after 'Add' filled users on Share window
Then I should see on selected 'Users already on this folder' tab on Share window the following the same users with different roles :
| Email       | Role      | ExpiredDate | ShouldAccess |
| AgencyAdmin |           |             | should       |
| aaaaaaaa6   | PR_PSFCP5 |             | should not   |
| aaaaaaaa6   | PR_PSFCP6 |             | should not   |



Scenario: Check re-add team template to folder with another permission (Folder Share)
Meta:@bug
     @gdam
     @projects
!--NGN-16380
Given I created following roles:
| RoleName  | Group   |
| PR_PSFCP7 | project |
| PR_PSFCP8 | project |
And created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| first8    | last8    | aaaaaaaa7 | 80501554825 | guest.user |
And added user 'aaaaaaaa7' into address book
And I created 'PSFCP7' project
And created '/PSFCPF7' folder for project 'PSFCP7'
And I added users to team template with the following fields:
| UserName  | TeamTemplate |
| aaaaaaaa7 | 4tt4         |
| aaaaaaaa7 | 5tt5         |
When I open share popup in project 'PSFCP7' for folder '/PSFCPF7' from root project
And fill Share window of project folder for following team templates :
| TeamTemplate | Role      |
| 4tt4         | PR_PSFCP7 |
And click element 'Add' on page 'ShareWindow'
And open share popup in project 'PSFCP7' for folder '/PSFCPF7' from root project
And fill Share window of project folder for following team templates :
| TeamTemplate | Role      |
| 5tt5         | PR_PSFCP8 |
And go to Users already on this folder tab after 'Add' filled users on Share window
Then I should see on selected 'Users already on this folder' tab on Share window the following the same users with different roles :
| Email       | Role       | ExpiredDate | ShouldAccess |
| AgencyAdmin |            |             | should       |
| aaaaaaaa7   | PR_PSFCP7  |             | should not   |
| aaaaaaaa7   | PR_PSFCP8  |             | should not   |


Scenario: Check re-add team template to folders with same permission (Folder Share)
!--FAB-780 5.7.0_bug
Meta:@gdam
@projects
Given I created 'PR_PSFCP10' role in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| FirstName | LastName | Email     | Telephone   | Role       |
| first10   | last10   | aaaaaaaa9 | 80501554825 | guest.user |
| first11   | last11   | bbbbbbbb9 | 80501554825 | guest.user |
And added users 'aaaaaaaa9,bbbbbbbb9' to Address book
And I created 'PSFCP9' project
And created '/PSFCPF9' folder for project 'PSFCP9'
And I added users to team template with the following fields:
| UserName  | TeamTemplate |
| aaaaaaaa9 | 6tt6         |
| bbbbbbbb9 | 6tt6         |
When I open share popup in project 'PSFCP9' for folder '/PSFCPF9' from root project
And fill Share window of project folder for following team templates :
| TeamTemplate | Role       |
| 6tt6         | PR_PSFCP10 |
And click element 'Add' on page 'ShareWindow'
And open share popup in project 'PSFCP9' for folder '/PSFCPF9' from root project
And fill Share window of project folder for following team templates :
| TeamTemplate | Role       |
| 6tt6         | PR_PSFCP10 |
And go to Users already on this folder tab after 'Add' filled users on Share window
Then I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email       | Role       | ExpiredDate | ShouldAccess |
| AgencyAdmin |            |             | should       |
| aaaaaaaa9   | PR_PSFCP10 |             | should not   |
| bbbbbbbb9   | PR_PSFCP10 |             | should not   |


Scenario: After rename shared folder,share user should stay on 'Users Already on this folder' tab
Meta:@gdam
@projects
Given I created 'PR_PSFCP13' role in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| FirstName | LastName | Email      | Telephone   | Role        |
| first15   | last15   | aaaaaaaa12 | 80501554825 | guest.user  |
And I created 'PSFCP12' project
And created '/PSFCPF12' folder for project 'PSFCP12'
When I open share popup in project 'PSFCP12' for folder '/PSFCPF12' from root project
And fill Share window of project folder for following users:
| User       | Role       | ExpiredDate | ShouldAccess |
| aaaaaaaa12 | PR_PSFCP13 |             | should not   |
And click element 'Add' on page 'ShareWindow'
And rename folder '/PSFCPF12' to 'PSFCPF13' in 'PSFCP12' project
And wait for '3' seconds
And open share popup in project 'PSFCP12' for folder '/PSFCPF13' from root project
And click element 'UsersAlreadyOnThisFolder' on page 'ShareWindow'
Then I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email       | Role       | ExpiredDate | ShouldAccess |
| AgencyAdmin |            |             | should       |
| aaaaaaaa12  | PR_PSFCP13 |             | should not   |


Scenario: After rename shared folder,share users from teamplate should stay on 'Users Already on this folder' tab
Meta:@gdam
@projects
Given I created 'PR_PSFCP14' role in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| FirstName | LastName | Email      | Telephone   | Role       |
| first16   | last16   | aaaaaaaa13 | 80501554825 | guest.user |
| first17   | last17   | bbbbbbbb13 | 80501554825 | guest.user |
And added users 'aaaaaaaa13,bbbbbbbb13' to Address book
And I created 'PSFCP13' project
And created '/PSFCPF13' folder for project 'PSFCP13'
And I added users to team template with the following fields:
| UserName   | TeamTemplate |
| aaaaaaaa13 | 8tt8         |
| bbbbbbbb13 | 8tt8         |
And opened share popup in project 'PSFCP13' for folder '/PSFCPF13' from root project
When I fill Share window of project folder for following team templates :
| TeamTemplate | Role       |
| 8tt8         | PR_PSFCP14 |
And click element 'Add' on page 'ShareWindow'
And rename folder '/PSFCPF13' to 'PSFCPF14' in 'PSFCP13' project
And wait for '3' seconds
And open share popup in project 'PSFCP13' for folder '/PSFCPF14' from root project
And click element 'UsersAlreadyOnThisFolder' on page 'ShareWindow'
Then I should see on selected 'Users already on this folder' tab on Share window the following users in current order :
| Email       | Role       | ExpiredDate | ShouldAccess |
| AgencyAdmin |            |             | should       |
| aaaaaaaa13  | PR_PSFCP14 |             | should not   |
| bbbbbbbb13  | PR_PSFCP14 |             | should not   |