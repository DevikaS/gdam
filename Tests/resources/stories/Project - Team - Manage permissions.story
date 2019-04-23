!--NGN-32
Feature:          Project - Team - Manage permissions
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Project - Team - Manage permissions

Meta:
@component project

Scenario: Check that all shared data is saved
Meta:@gdam
@projects
Given I created 'PTMP1' project
And created '/PTMF1' folder for project 'PTMP1'
And created users with following fields:
| Email | Role       |
| PTMU1 | guest.user |
And created 'PTMR1' role in 'project' group for advertiser 'DefaultAgency'
And added users 'PTMU1' to project 'PTMP1' team folders '/PTMF1' with role 'PTMR1' expired '12.12.2021'
And I am on project 'PTMP1' teams page
When I open user 'PTMU1' permissions on project 'PTMP1' team page
Then I should see following role settings for folders in manage permissions popup of project 'PTMP1' team for user 'PTMU1':
| Folder | Role  | Expiration |
| /PTMF1 | PTMR1 | 12.12.2021 |


Scenario: Check that Role can be changed
Meta:@gdam
@projects
Given I created 'PTMP2' project
And created '/PTMF2' folder for project 'PTMP2'
And created users with following fields:
| Email | Role       |
| PTMU2 | guest.user |
And created following roles:
| RoleName | Group   |
| PTMR2_1  | project |
| PTMR2_2  | project |
And added users 'PTMU2' to project 'PTMP2' team folders '/PTMF2' with role 'PTMR2_1' expired '12.12.2021'
And I am on project 'PTMP2' teams page
When I open user 'PTMU2' permissions on project 'PTMP2' team page
And select folder '/PTMF2' in manage permissions popup of project 'PTMP2' team for user 'PTMU2'
And select role 'PTMR2_2' in user 'PTMU2' permissions popup for project 'PTMP2' team
And add expiration date '11/11/2017' in user 'PTMU2' permissions popup for project 'PTMP2' team
And click Add role button on permissions popup of project team tab
And remove 'PTMR2_1' role on permissions popup of project team tab
And click Save button on permissions popup of project team tab
And open user 'PTMU2' permissions on project 'PTMP2' team page
Then I should see following role(s) settings for folders in manage permissions popup of project 'PTMP2' team for user 'PTMU2':
| Folder | Role    |Expiration|
| /PTMF2 | PTMR2_2 |11.11.2017|


Scenario: Check that Permissions can be changed
Meta:@gdam
@projects
Given I created 'PTMP3' project
And created in 'PTMP3' project next folders:
| folder    |
| /PTMPF3_1 |
| /PTMPF3_2 |
And created users with following fields:
| Email  | Role       |
| PTMPU3 | guest.user |
And created following roles:
| RoleName | Group   |
| PTMPR3_1 | project |
| PTMPR3_2 | project |
And added users 'PTMPU3' to project 'PTMP3' team folders '/PTMPF3_1' with role 'PTMPR3_1' expired '12.12.2021'
And added users 'PTMPU3' to project 'PTMP3' team folders '/PTMPF3_2' with role 'PTMPR3_2' expired '12.12.2030'
When I go to project 'PTMP3' teams page
And open user 'PTMPU3' permissions on project 'PTMP3' team page
And toggle folder '/PTMPF3_1' in manage permissions popup of project 'PTMP3' team for user 'PTMPU3'
And remove 'PTMPR3_1' role on permissions popup of project team tab
And click Save button on permissions popup of project team tab
And open user 'PTMPU3' permissions on project 'PTMP3' team page
Then I should see following role(s) settings for folders in manage permissions popup of project 'PTMP3' team for user 'PTMPU3':
| Folder    | Role     | Expiration |
| /PTMPF3_1 |          |            |
| /PTMPF3_2 | PTMPR3_2 | 12.12.2030 |


Scenario: Check that 'Include Children' is selected on Manage permissions next to parent folder if folder has been shared to user with access to subfolders
Meta:@gdam
@projects
Given I created 'PTMPP4' project
And created in 'PTMPP4' project next folders:
| folder             |
| /PTMPF4_1          |
| /PTMPF4_2/PTMPF4_3 |
And created users with following fields:
| Email  | Role       |
| PTMPU4 | guest.user |
And created 'PTMPR4' role in 'project' group for advertiser 'DefaultAgency'
And added users 'PTMPU4' to project 'PTMPP4' team folders '/PTMPF4_2' with role 'PTMPR4' expired '12.12.2021' and 'should' access to subfolders
And I am on project 'PTMPP4' teams page
When I open user 'PTMPU4' permissions on project 'PTMPP4' team page
Then I 'should' see selected Include Children checkbox for folder '/PTMPF4_2' and role 'PTMPR4' in manage permissions popup of project 'PTMPP4' team for user 'PTMPU4'


Scenario: Check that permissions for child folder is inhereted from parent folder if folder has been shared with access to subfolders
Meta:@gdam
@projects
Given I created 'PTMPP5' project
And created in 'PTMPP5' project next folders:
| folder             |
| /PTMPF5_1          |
| /PTMPF5_2/PTMPF5_3 |
And created users with following fields:
| Email  | Role       |
| PTMPU5 | guest.user |
And created 'PTMPR5' role in 'project' group for advertiser 'DefaultAgency'
And added users 'PTMPU5' to project 'PTMPP5' team folders '/PTMPF5_2' with role 'PTMPR5' expired '12.12.2021' and 'should' access to subfolders
And I am on project 'PTMPP5' teams page
When I open user 'PTMPU5' permissions on project 'PTMPP5' team page
Then I should see following role(s) settings for folders in manage permissions popup of project 'PTMPP5' team for user 'PTMPU5':
| Folder             | Role   | Expiration |
| /PTMPF5_2          | PTMPR5 | 12.12.2021 |
| /PTMPF5_2/PTMPF5_3 | PTMPR5 | 12.12.2021 |


Scenario: Check that for project administrators whole project is selected with corresponded permissions
Meta:@gdam
@projects
Given I created 'PTMPP6' project
And created in 'PTMPP6' project next folders:
| folder             |
| /PTMPF6_1          |
| /PTMPF6_2/PTMPF6_3 |
And I am on project 'PTMPP6' teams page
When I open user 'AgencyAdmin' permissions on project 'PTMPP6' team page
Then I should see following role settings for whole project in manage permissions popup of project 'PTMPP6' team for owner 'AgencyAdmin':
| Role          | Expiration |
| project.admin |            |
And 'should' see selected Include Children checkbox for root in manage permissions popup of project 'PTMPP6' team for user 'AgencyAdmin' with role 'project.admin'
Then I should see following role(s) settings for folders in manage permissions popup of project 'PTMPP6' team for user 'AgencyAdmin':
| Folder             | Role            | Expiration |
| /PTMPF6_1          | project.admin   |            |
| /PTMPF6_2          | project.admin   |            |
| /PTMPF6_2/PTMPF6_3 | project.admin   |            |

