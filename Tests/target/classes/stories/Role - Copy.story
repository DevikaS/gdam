!--NGN-623
Feature:          Role - Copy
Narrative:
In order to
As a              AgencyAdmin
I want to         Check copy role

Scenario: Check copyied role name given by default
Meta:@globaladmin
     @gdam
Given I created '<RoleName>' role with '<Permissions>' permissions in '<RoleGroups>' group for advertiser 'DefaultAgency'
And I logged in as 'GlobalAdmin'
When I open role 'project.admin' page with parent 'DefaultAgency'
And I search advertiser 'DefaultAgency' on global roles page
And I select advertiser 'DefaultAgency' on global roles page
And I open role '<RoleName>' page with parent 'DefaultAgency'
And refresh the page
And I click element 'CopyButton' on page 'Roles'
And click element 'SaveButton' on page 'Roles'
Then I should see current permission is matches to '<NewRoleName>'

Examples:
| RoleGroups | RoleName           | NewRoleName               |
| global     | Agency User        | Agency User.*-copy        |
| project    | Project Admin      | Project Admin.*-copy      |
| library    | Agency Queryfilter | Agency Queryfilter.*-copy |


Scenario: Role is copied successfully
Meta:@globaladmin
     @gdam
Given I created '<DefaultRoleName>' role with '<Permissions>' permissions in '<RoleGroups>' group for advertiser 'DefaultAgency'
And I logged in as 'GlobalAdmin'
When I open role '<DefaultRoleName>' page with parent 'DefaultAgency'
And I click element 'CopyButton' on page 'Roles'
And I change '<DefaultRoleName>' permissions to '<NewPermissions>' in agency 'DefaultAgency'
And I change role name to '<RoleName>'
And I click element 'SaveButton' on page 'Roles'
Then I 'should' see '<RoleName>' role on in the roles list
And role '<RoleName>' contains '<NewPermissions>'

Examples:
| RoleGroups | DefaultRoleName     | RoleName | Permissions                                         | NewPermissions                                     |
| library    | Agency Queryfilter1 | User1    | asset.read,asset_filter_category.read,file.download | asset.read,asset.delete,asset_filter_category.read |
| project    | Project Admin1      | User2    | project.read,project.write                          | folder.share,project.read                          |
| global     | Agency Enums Read1  | User4    | enum.read,role.read,user.create                     | project.create,enum.read,role.read                 |

Scenario: Check that editing role copied from origin role doesn't affect this origin role
Meta:@globaladmin
     @gdam
Given I created 'Role1' role with 'role.create,role.read,role.write,role.delete,enum.read' permissions in 'global' group for advertiser 'DefaultAgency'
And I logged in as 'GlobalAdmin'
When I open role 'Role1' page with parent 'DefaultAgency'
And I click element 'CopyButton' on page 'Roles'
And I change role name to 'Role2'
And I click element 'SaveButton' on page 'Roles'
And I change 'Role2' permissions to 'enum.read,role.read' in agency 'DefaultAgency'
And I click element 'SaveButton' on page 'Roles'
And wait for '3' seconds
Then role 'Role2' contains 'enum.read,role.read'
When I open role 'Role1' page with parent 'DefaultAgency'
And refresh the page without delay
Then role 'Role1' contains 'role.create,role.read,role.write,role.delete,enum.read'