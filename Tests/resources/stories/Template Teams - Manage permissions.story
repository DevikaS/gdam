!--NGN-32 NGN-1343
Feature:          Template Teams - Manage permissions
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Templates Team Manage permissions

Scenario: Check that all shared data is saved
Meta:@gdam
@projects
Given I created 'TTMPT1' template
And created '/TTMPF1' folder for template 'TTMPT1'
And created users with following fields:
| Email  | Role       |
| TTMPU1 | guest.user |
And created 'TTMPR1' role in 'project' group for advertiser 'DefaultAgency'
And added users 'TTMPU1' to template 'TTMPT1' team folders '/TTMPF1' with role 'TTMPR1' expired '12.12.2021'
And I am on template 'TTMPT1' teams page
When I open user 'TTMPU1' permissions on template 'TTMPT1' team page
Then I should see following role settings for folders in manage permissions popup of template 'TTMPT1' team for user 'TTMPU1':
| Folder  | Role   | Expiration |
| /TTMPF1 | TTMPR1 | 12.12.2021 |


Scenario: Check that Role can be changed
Meta:@gdam
@projects
Given I created 'TTMPT2' template
And created '/TTMPF2' folder for template 'TTMPT2'
And created users with following fields:
| Email  | Role       |
| TTMPU2 | guest.user |
And created following roles:
| RoleName | Group   |
| TTMPR2_1 | project |
| TTMPR2_2 | project |
And added users 'TTMPU2' to template 'TTMPT2' team folders '/TTMPF2' with role 'TTMPR2_1' expired '12.12.2021'
And I am on template 'TTMPT2' teams page
When I open user 'TTMPU2' permissions on template 'TTMPT2' team page
And select folder '/TTMPF2' in manage permissions popup of template 'TTMPT2' team for user 'TTMPU2'
And select role 'TTMPR2_2' in user 'TTMPU2' permissions popup for template 'TTMPT2' team
And add expiration date '11/11/2017' in user 'TTMPU2' permissions popup for template 'TTMPT2' team
And click Add role button on permissions popup of template team tab
And remove 'TTMPR2_1' role on permissions popup of template team tab
And click Save button on permissions popup of template team tab
And open user 'TTMPU2' permissions on template 'TTMPT2' team page
Then I should see following role(s) settings for folders in manage permissions popup of template 'TTMPT2' team for user 'TTMPU2':
| Folder  | Role     | Expiration |
| /TTMPF2 | TTMPR2_2 | 11.11.2017 |


Scenario: Check that 'include Children' is selected on Manage permissions next to parent folder if folder has been shared to user with access to subfolders
Meta:@gdam
@projects
Given I created 'TTMPT4' template
And created in 'TTMPT4' template next folders:
| folder             |
| /TTMPF4_1          |
| /TTMPF4_2/TTMPF4_3 |
And created users with following fields:
| Email  | Role       |
| TTMPU4 | guest.user |
And created 'TTMPR4' role in 'project' group for advertiser 'DefaultAgency'
And added users 'TTMPU4' to template 'TTMPT4' team folders '/TTMPF4_2' with role 'TTMPR4' expired '12.12.2021' and 'should' access to subfolders
And I am on template 'TTMPT4' teams page
When I open user 'TTMPU4' permissions on template 'TTMPT4' team page
Then I 'should' see selected Include Children checkbox for folder '/TTMPF4_2' and role 'TTMPR4' in manage permissions popup of template 'TTMPT4' team for user 'TTMPU4'


Scenario: Check that permissions for child folder is inhereted from parent folder if folder has been shared with access to subfolders
Meta:@gdam
@projects
Given I created 'TTMPT5' template
And created in 'TTMPT5' template next folders:
| folder             |
| /TTMPF5_1          |
| /TTMPF5_2/TTMPF5_3 |
And created users with following fields:
| Email  | Role       |
| TTMPU5 | guest.user |
And created 'TTMPR5' role in 'project' group for advertiser 'DefaultAgency'
And added users 'TTMPU5' to template 'TTMPT5' team folders '/TTMPF5_2' with role 'TTMPR5' expired '12.12.2021' and 'should' access to subfolders
And I am on template 'TTMPT5' teams page
When I open user 'TTMPU5' permissions on template 'TTMPT5' team page
Then I should see following role(s) settings for folders in manage permissions popup of template 'TTMPT5' team for user 'TTMPU5':
| Folder             | Role     | Expiration |
| /TTMPF5_2          | TTMPR5   | 12.12.2021 |
| /TTMPF5_2/TTMPF5_3 | TTMPR5   | 12.12.2021 |


Scenario: Check that for template administrators whole template is selected with corresponded permissions
Meta:@gdam
@projects
Given I created 'TTMPT6' template
And created in 'TTMPT6' template next folders:
| folder             |
| /TTMPF6_1          |
| /TTMPF6_2/TTMPF6_3 |
And I am on template 'TTMPT6' teams page
When I open user 'AgencyAdmin' permissions on template 'TTMPT6' team page
Then I should see following role settings for whole template in manage permissions popup of template 'TTMPT6' team for owner 'AgencyAdmin':
| Role          | Expiration |
| project.admin |            |
And 'should' see selected Include Children checkbox for root in manage permissions popup of template 'TTMPT6' team for user 'AgencyAdmin' with role 'project.admin'
And should see following role(s) settings for folders in manage permissions popup of template 'TTMPT6' team for user 'AgencyAdmin':
| Folder             | Role            | Expiration |
| /TTMPF6_1          | project.admin   |            |
| /TTMPF6_2          | project.admin   |            |
| /TTMPF6_2/TTMPF6_3 | project.admin   |            |
