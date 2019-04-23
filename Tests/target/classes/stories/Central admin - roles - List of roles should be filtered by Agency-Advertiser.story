!-- NGN-4308
Feature:          Central admin - roles - List of roles should be filtered by Agency-Advertiser
Narrative:
In order to
As a              GlobalAdmin
I want to         check list of roles according to selected agency/advertiser

Scenario: Check that only system roles appear by default (agency is not selected)
Meta:@globaladmin
     @gdam
     @skip
!-- NGN-14650: Skipping as 'System Roles' are not available with new implementation
When I go to global roles page
Then I 'should' see empty value in Agency dropdown
And I should see only following roles 'global administrators,easyshare downloadMaster,easyshare downloadProxy,easyshare view,agency list' in 'System' roles group on global roles page


Scenario: Check default roles list after selecting agency
Meta:@globaladmin
     @gdam
Given I created the agency 'Ag_RL1' with default attributes
When I go to global roles page
And I search advertiser 'Ag_RL1' on global roles page
And I select advertiser 'Ag_RL1' on global roles page
Then I should see roles '<Roles>' on global roles page in '<RolesGroup>' group

Examples:
| RolesGroup | Roles                                                           |
| Global     | agency admin,agency user,guest user                             |
| Project    | project admin,project contributor,project observer,project user |


Scenario: Check that roles list appears after selection agency/advertiser
Meta:@globaladmin
     @gdam
Given I created the agency 'Ag_RL1' with default attributes
And I created 'Lib R01' role in 'library' group for advertiser 'Ag_RL1'
When I go to global roles page
And I search advertiser 'Ag_RL1' on global roles page
And I select advertiser 'Ag_RL1' on global roles page
Then I should see role 'Lib R01' in 'Library' group


Scenario: Check that list of roles is changed after switch to another agency
Meta:@globaladmin
     @gdam
Given I created the agency 'Ag_RL2' with default attributes
And created the agency 'Ag_RL3' with default attributes
And I created following roles:
| RoleName | Group   | Agency |
| Prj R02  | project | Ag_RL2 |
| Lib R03  | library | Ag_RL3 |
When I go to global roles page
And I search advertiser '<Advertiser>' on global roles page
And I select advertiser '<Advertiser>' on global roles page
Then I should see role '<RoleGood>' in '<RoleGoodGroup>' group
And I 'should not' see '<RoleBad>' role on in the roles list

Examples:
| Advertiser | RoleGood | RoleGoodGroup | RoleBad |
| Ag_RL2     | Prj R02  | Project       | Lib R03 |
| Ag_RL3     | Lib R03  | Library       | Prj R02 |