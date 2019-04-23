!-- NGN-271
Feature:          Roles - Create new Role from scratch
Narrative:
In order to
As a              GlobalAdmin
I want to         Check creation new role from scratch by agency admin

Scenario: see Permissions page
Meta:@globaladmin
     @gdam
When I open role 'agency.admin' page with parent 'DefaultAgency'
Then I should see current permission is equal to 'agency.admin'


Scenario: Check that button 'Create New Role' is available for agency admin on Roles page
Meta:@globaladmin
     @gdam
Given I am on global roles page
And I search advertiser 'DefaultAgency' on global roles page
And selected advertiser 'DefaultAgency' on global roles page
Then I 'should' see following elements on page 'Roles':
| element             |
| CreateNewRoleButton |


Scenario: Check that all fields are available on Create New Role pop-up
Meta:@globaladmin
     @gdam
Given I am on global roles page
And I search advertiser 'DefaultAgency' on global roles page
And selected advertiser 'DefaultAgency' on global roles page
And I am on Create New Role pop-up
Then I 'should' see element 'RoleNameTextField' on roles page
And I 'should' see box 'RoleTypeSelectBox' on roles page with following fields:
| field        |
| global role  |
| project role |
| library role |
And I 'should' see element 'SaveButton' on roles page
And I 'should' see element 'CancelButton' on roles page


Scenario: Check that new role can be created by agency admin on Roles page
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @globaladmin
Given I logged in as 'GlobalAdmin'
When I fill Create New Role for 'agency.admin' with parent 'DefaultAgency' page with following fields for Agency:
| Role Name | Role Type |
| New Role3 | global    |
And I click element 'Save' button on create new role section
And I logout from account
And login with details of 'GlobalAdmin'
And go to global roles page
And I search advertiser 'DefaultAgency' on global roles page
And I wait for '10' seconds
And I select advertiser 'DefaultAgency' on global roles page
And I refresh when required for role
And wait role 'New Role3' on global role page to load
And I open role 'New Role3' on global role page
Then I should see current role is equal to created role 'New Role3'
And I should see role 'New Role3' and 'should' contains following selected permissions 'enum.read,role.read' for Agency
And I 'should' see 'New Role3' role on in the roles list


Scenario: Check that newly created role is displayed in alphabetical order
Meta:@globaladmin
     @gdam
Given I am on global roles page
And I search advertiser 'DefaultAgency' on global roles page
And selected advertiser 'DefaultAgency' on global roles page
And I am on Create New Role pop-up
When I fill Create New Role for 'agency.admin' with parent 'DefaultAgency' page with following fields:
| Role Name | Role Type |
| New Role4 | global    |
And I click element 'Save' button on create new role section
And open role 'New Role4' page with parent 'DefaultAgency'
Then I should see roles list in alphabetical order


Scenario: Check that role with the same name cannot be created
Meta:@globaladmin
     @gdam
Given I created 'New Role5' role in 'global' group for advertiser 'DefaultAgency'
And I opened role 'project.admin' page with parent 'DefaultAgency'
And I search advertiser 'DefaultAgency' on global roles page
And I selected advertiser 'DefaultAgency' on global roles page
And I am click on Create New Role button
When I fill Create New Role page with following fields:
| Role Name | Role Type |
| New Role5 | global    |
And I click element 'Save' button on create new role section
Then I 'should' see red inputs on page


Scenario: Check that role with empty name cannot be created
!-- NGN-14650: Added THEN step as per new functionality
Meta:@globaladmin
     @gdam
Given I am on global roles page
And I search advertiser 'DefaultAgency' on global roles page
And selected advertiser 'DefaultAgency' on global roles page
And I am on Create New Role pop-up
When I fill Create New Role for 'agency.admin' with parent 'DefaultAgency' page with following fields:
| Role Name | Role Type |
|           | global    |
Then I 'should not' see 'save button enabled in create role section


Scenario: Check that created role belongs to specified role type
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
And am on global roles page
And I search advertiser 'DefaultAgency' on global roles page
And selected advertiser 'DefaultAgency' on global roles page
When I create new '<name>' role in '<type>' group
And wait for '3' seconds
Then I should see role '<name>' in '<type>' group

Examples:
| name      | type    |
| New Role6 | global  |
| New Role7 | project |
| New Role8 | library |


Scenario: Check that role with the same name cannot be created (include symbols '.' and '_')
Meta:@globaladmin
     @gdam
@skip
!-- NGN-720 NGN-18878
Given I created 'New Role9' role in 'global' group for advertiser 'DefaultAgency'
And I opened role 'project.admin' page with parent 'DefaultAgency'
And I search advertiser 'DefaultAgency' on global roles page
And I selected advertiser 'DefaultAgency' on global roles page
And I am click on Create New Role button
When I fill Create New Role page with following fields:
| Role Name  | Role Type |
| <Rolename> | <group>   |
And I click element 'Save' button on create new role section
Then I 'should' see red inputs on page

Examples:
| Rolename  | group  |
| New.Role9 | global |
| New_Role9 | global |