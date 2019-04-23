!--NGN-3182
Feature:          ACL - View Activity
Narrative:
In order to
As a              AgencyAdmin
I want to         Check view activity permissions

Scenario: Check that 'activity.read' permission can be specified only for Global and Project Roles
Meta:@globaladmin
     @gdam
Given I created '<Role>' role in '<RoleType>' group for advertiser 'DefaultAgency'
And I logged in as 'GlobalAdmin'
And I opened role '<Role>' page with parent 'DefaultAgency'
Then I should see role '<Role>' that '<Should>' contains following permissions 'activity.read' available for selecting for 'DefaultAgency'

Examples:
| Role      | RoleType | Should     |
| ACLVAR1_1 | global   | should     |
| ACLVAR1_2 | project  | should     |
| ACLVAR1_3 | library  | should not |


Scenario: Check that View Activity permissions is included for Project Admin by default
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
And I opened role 'project.admin' page with parent 'DefaultAgency'
Then I should see role 'project.admin' that 'should' contains following selected permissions 'activity.read'


Scenario: Check displaying Activity and Carousel of project for users
Meta:@projects
     @gdam
Given I created 'ACLVAR3' role with 'folder.read,element.read,project.read,project.settings.read' permissions in 'project' group for advertiser '<agencyName>'
And created users with following fields:
| Email   | Role       | Agency       |
| <email> | <roleName> | <agencyName> |
And created 'ACLVAP3' project
And created '/ACLVAF3' folder for project 'ACLVAP3'
And uploaded '/files/_file1.gif' file into '/ACLVAF3' folder for 'ACLVAP3' project
And waited while transcoding is finished in folder '/ACLVAF3' on project 'ACLVAP3' files page
And fill Share popup by users '<email>' in project 'ACLVAP3' folders '/ACLVAF3' with role 'ACLVAR3' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of '<email>'
And waited for '3' seconds
When I go to project 'ACLVAP3' overview page
And refresh the page
Then I '<ActivityShould>' see activity where user 'AgencyAdmin' upload file '/ACLVAP3/ACLVAF3/_file1.gif' in project 'ACLVAP3' on Project Overview page
And '<FileShould>' see file '_file1.gif' on project 'ACLVAP3' overview page

Examples:
| email     | roleName     | agencyName    | FileShould | ActivityShould|
| ACLVAU3_2 | agency.admin | DefaultAgency | should     | should        |
| ACLVAU3_3 | agency.user  | DefaultAgency | should     | should not    |
| ACLVAU3_4 | guest.user   | DefaultAgency | should     | should not    |
| ACLVAU3_5 | agency.admin | AnotherAgency | should     | should not    |
| ACLVAU3_6 | agency.user  | AnotherAgency | should     | should not    |
| ACLVAU3_7 | guest.user   | AnotherAgency | should     | should not    |


Scenario: Check that Activity and carousel of project is displayed for project owners from current agency
Meta:@projects
     @gdam
Given I created users with following fields:
| Email   | Role       | Agency       |
| <email> | <roleName> | <agencyName> |
And added user '<email>' into address book
And created 'ACLVAP4' project
And created '/ACLVAF4' folder for project 'ACLVAP4'
And uploaded '/files/_file1.gif' file into '/ACLVAF4' folder for 'ACLVAP4' project
And waited while transcoding is finished in folder '/ACLVAF4' on project 'ACLVAP4' files page
And I am on project 'ACLVAP4' settings page
When I edit the following fields for 'ACLVAP4' project:
| Name    | Administrators |
| ACLVAP4 | <email>        |
And click on element 'SaveButton'
And wait for '3' seconds
And login with details of '<email>'
And go to project 'ACLVAP4' overview page
And refresh the page
Then I '<Should>' see activity where user 'AgencyAdmin' upload file '/ACLVAP4/ACLVAF4/_file1.gif' in project 'ACLVAP4' on Project Overview page
And '<Should>' see file '_file1.gif' on project 'ACLVAP4' overview page

Examples:
| email     | roleName     | agencyName    | Should |
| ACLVAU4_1 | agency.admin | DefaultAgency | should |
| ACLVAU4_2 | agency.user  | DefaultAgency | should |
| ACLVAU4_3 | guest.user   | DefaultAgency | should |


Scenario: Check that Activity and carousel of project is displayed for project owners from another agency
Meta:@projects
     @gdam
Given I created users with following fields:
| Email   | Role       | Agency       |
| <email> | <roleName> | <agencyName> |
And added user '<email>' into address book
And created 'ACLVAP5' project
And created '/ACLVAF5' folder for project 'ACLVAP5'
And uploaded '/files/_file1.gif' file into '/ACLVAF5' folder for 'ACLVAP5' project
And waited while transcoding is finished in folder '/ACLVAF5' on project 'ACLVAP5' files page
And I am on project 'ACLVAP5' settings page
When I edit the following fields for 'ACLVAP5' project:
| Name    | Administrators |
| ACLVAP5 | <email>        |
And click on element 'SaveButton'
And wait for '3' seconds
And login with details of '<email>'
And go to project 'ACLVAP5' overview page
Then I '<Should>' see activity where user 'AgencyAdmin' upload file '/ACLVAP5/ACLVAF5/_file1.gif' in project 'ACLVAP5' on Project Overview page
And '<Should>' see file '_file1.gif' on project 'ACLVAP5' overview page

Examples:
| email     | roleName     | agencyName    | Should |
| ACLVAU5_1 | agency.admin | AnotherAgency | should |
| ACLVAU5_2 | agency.user  | AnotherAgency | should |
| ACLVAU5_3 | guest.user   | AnotherAgency | should |