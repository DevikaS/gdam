!--NGN-2249
Feature:          Add new permission - Share Folders
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Share Folders permission

Scenario: Check that Share folder permission is available only for project roles
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
And I opened role '<Role>' page with parent 'DefaultAgency'
Then I should see role '<Role>' that '<Should>' contains following selected permissions 'folder.share'

Examples:
| Role               | Should     |
| agency.admin       | should     |
| agency.enums.read  | should not |
| agency.enums.write | should not |
| agency.user        | should not |
| guest.user         | should not |
| project.admin      | should     |


Scenario: Check that availability of Share button depends on Share folder permission
Meta:@gdam
     @projects
Given I created 'ANPSF3' project
And created '/ANPSFF3' folder for project 'ANPSF3'
And created users with following fields:
| Email  | Role       |
| <User> | guest.user |
And I created '<Role>' role with '<Permissions>' permissions in 'project' group for advertiser 'DefaultAgency'
And fill Share popup by users '<User>' in project 'ANPSF3' folders '/' with role '<Role>' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of '<User>'
And I am on project 'ANPSF3' folder '' page
When I select folder '/ANPSFF3' on project files page
Then I '<Should>' see enabled share button on project 'ANPSF3' folder '' page

Examples:
| User      | Role      | Permissions                                        | Should     |
| ANPSFU3_1 | ANPSFR3_1 | folder.read,element.read,project.read              | should not |
| ANPSFU3_2 | ANPSFR3_2 | folder.share,folder.read,element.read,project.read | should     |


Scenario: Check that shared project can be reshared
Meta:@gdam
     @projects
Given I created 'ANPSF4' project
And created '/ANPSFF4' folder for project 'ANPSF4'
And created users with following fields:
| Email     | Role       |
| ANPSFU4_1 | guest.user |
| ANPSFU4_2 | guest.user |
And I created 'ANPSFR4_1' role with 'folder.share,folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And I created '<Role>' role with '<Permissions>' permissions in 'project' group for advertiser 'DefaultAgency'
And fill Share popup by users 'ANPSFU4_1' in project 'ANPSF4' folders '/' with role 'ANPSFR4_1' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of 'ANPSFU4_1'
And fill Share popup by users 'ANPSFU4_2' in project 'ANPSF4' folders '/' with role '<Role>' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of 'ANPSFU4_2'
And I am on project 'ANPSF4' folder '' page
And selected folder '/ANPSFF4' on project files page
Then I '<Should>' see enabled share button on project 'ANPSF4' folder '' page

Examples:
| Role      | Permissions                                        | Should     |
| ANPSFR4_2 | folder.read,element.read,project.read              | should not |
| ANPSFR4_3 | folder.share,folder.read,element.read,project.read | should     |