!--NGN-2448
Feature:          ACL Project permissions - Edit Projects Settings and View Settings Project permissions
Narrative:
In order to
As a              AgencyAdmin
I want to         Check permission: Edit Projects Settings and View Settings Project permissions

Scenario: Check that project.write and project.settings.read permissions are available only for project roles
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
And I opened role '<Role>' page with parent 'DefaultAgency'
Then I should see role '<Role>' that '<Should>' contains following selected permissions 'project.write,project.settings.read'

Examples:
| Role               | Should     |
| agency.admin       | should     |
| agency.enums.read  | should not |
| agency.enums.write | should not |
| agency.user        | should not |
| guest.user         | should not |
| project.admin      | should     |


Scenario: Check that availability of Edit link depends on Edit Project Settings permission
Meta:@gdam
     @projects
Given I created 'ACLPPP3' project
And created '/ACLPPF3' folder for project 'ACLPPP3'
And created users with following fields:
| Email  | Role       |
| <User> | guest.user |
And I created '<Role>' role with '<Permissions>' permissions in 'project' group for advertiser 'DefaultAgency'
And fill Share popup by users '<User>' in project 'ACLPPP3' folders '/ACLPPF3' with role '<Role>' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of '<User>'
And I am on project 'ACLPPP3' overview page
Then I '<Should>' see element 'EditLink' on page 'ProjectsOverview'

Examples:
| User      | Role      | Permissions                                                               | Should     |
| ACLPPU3_1 | ACLPPR3_1 | folder.read,element.read,project.read,project.settings.read               | should not |
| ACLPPU3_2 | ACLPPR3_2 | project.write,folder.read,element.read,project.read,project.settings.read | should     |


Scenario: Check that availability of project overview tab depends on project.settings.read permission
Meta:@gdam
     @projects
Given I created 'ACLPPP4' project
And created '/ACLPPF4' folder for project 'ACLPPP4'
And created users with following fields:
| Email  | Role       |
| <User> | guest.user |
And I created '<Role>' role with '<Permissions>' permissions in 'project' group for advertiser 'DefaultAgency'
And fill Share popup by users '<User>' in project 'ACLPPP4' folders '/ACLPPF4' with role '<Role>' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of '<User>'
And I am on project 'ACLPPP4' files page
Then I '<Should>' see element 'OverviewTab' on page 'FilesPage'

Examples:
| User      | Role      | Permissions                                                 | Should     |
| ACLPPU4_1 | ACLPPR4_1 | folder.read,element.read,project.read                       | should not |
| ACLPPU4_2 | ACLPPR4_2 | folder.read,element.read,project.read,project.settings.read | should     |


Scenario: Check that project owners cannot be edited in spite of Edit Project Settings permission
Meta:@gdam
     @projects
Given I created 'ACLPPP5' project
And created '/ACLPPF5' folder for project 'ACLPPP5'
And created users with following fields:
| Email   | Role       |
| ACLPPU5 | guest.user |
And I created 'ACLPPR5' role with 'folder.read,element.read,project.read,project.settings.read,project.write' permissions in 'project' group for advertiser 'DefaultAgency'
And fill Share popup by users 'ACLPPU5' in project 'ACLPPP5' folders '/ACLPPF5' with role 'ACLPPR5' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of 'ACLPPU5'
And I am on project 'ACLPPP5' overview page
Then I 'should not' see Project Owners section while edit project 'ACLPPP5'


Scenario: Check that Editing works if user has Edit Project Settings permission
Meta:@gdam
     @projects
Given I created 'ACLPPP6' project
And created '/ACLPPF6' folder for project 'ACLPPP6'
And created users with following fields:
| Email   | Role       |
| ACLPPU6 | guest.user |
And I created 'ACLPPR6' role with 'folder.read,element.read,project.read,project.settings.read,project.write' permissions in 'project' group for advertiser 'DefaultAgency'
And fill Share popup by users 'ACLPPU6' in project 'ACLPPP6' folders '/ACLPPF6' with role 'ACLPPR6' expired '12.12.2022' and 'should' access to subfolders
And I logged in with details of 'ACLPPU6'
And I am on project 'ACLPPP6' overview page
When I edit the following fields for 'ACLPPP6' project:
| Name    | Start date | End date   |
| ACLPPU7 | [Today]    | 11.11.2022 |
And click on element 'SaveButton' without delay
Then I should see message warning 'Changes saved successfully'
And Project 'ACLPPU7' should include the following fields:
| Name    | Start date | End date   |
| ACLPPU7 | [Today]    | 11.11.2022 |