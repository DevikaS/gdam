!--NGN-624
Feature:          Roles Edit Roles
Narrative:
In order to
As a              GlobalAdmin
I want to         Check creating of a  Roles

Scenario: Default roles is editable
Meta:@globaladmin
@skip
@gdam
!--With NGN-14650 implementation this scenario is invalid. So added a new Scenario 'Default roles not editable'
Given I am on global roles page
When I open role '<RoleName>' page with parent 'DefaultAgency'
Then I 'should' see following elements on page 'Roles':
| element    |
| CopyButton |
And permissions checkboxes are 'enabled' on role '<RoleName>' page
And I should see elements on page 'Roles' in the following state:
| element       | state         |
| RoleNameFiled | not read only |

Examples:
| RoleName      |
| agency.admin  |
| agency.user   |
| project.admin |
| guest.user    |


Scenario: Edit Role name for not default role
Meta:@globaladmin
     @gdam
Given I created '<RoleName>' role in '<GroupName>' group for advertiser 'DefaultAgency'
And logged in with details of 'GlobalAdmin'
When I open role 'project.admin' page with parent 'DefaultAgency'
And I wait for '3' seconds
And I search advertiser 'DefaultAgency' on global roles page
And I select advertiser 'DefaultAgency' on global roles page
And I open role '<RoleName>' page with parent 'DefaultAgency'
And refresh the page
And I change role name to '<NewRoleName>'
And click element 'SaveButton' on page 'Roles'
Then I should see role '<ExpectedRole>' in '<GroupName>' group
And I '<Should>' see red inputs on global roles page

Examples:
| RoleName | GroupName | NewRoleName   | Message     | ExpectedRole | Should     |
| ER1      | global    | ERN1          | Role edited | ERN1         | should not |
| ER2      | library   | ERN2          | Role edited | ERN2         | should not |
| ER3      | project   | ERN3          | Role edited | ERN3         | should not |
| ER4      | project   | project.admin |             | ER4          | should     |
| ER5      | global    | agency.admin  |             | ER5          | should     |


Scenario: Edit permissions for not default role
Meta:@globaladmin
     @gdam
Given I created '<RoleName>' role with '<Permissions>' permissions in '<GroupName>' group for advertiser 'DefaultAgency'
When I open role '<RoleName>' page with parent 'DefaultAgency'
And refresh the page
And I change '<RoleName>' permissions to '<NewPermissions>' in agency 'DefaultAgency'
And click element 'SaveButton' on page 'Roles'
Then I should see role '<RoleName>' contains '<NewPermissions>'

Examples:
| RoleName | GroupName | Permissions                                                                                                                                                                                      | NewPermissions                                                                                   |
| ER6      | global    | asset.create,project_template.create,user.create,user.read,user.write,user.delete,user_group.create,user_group.read,user_group.write,user_group.delete,role.read,enum.read,project_template.read | project.create,role.create,role.read,role.write,role.delete,enum.read,asset_filter_category.read |
| ER7      | project   | project_team.write,folder.read,element.read                                                                                                                                                      | project_team.delete,project.read,folder.delete,element.delete                                    |
| ER8      | library   | presentation.create,asset.write,asset.read,asset_filter_category.read                                                                                                                            | asset.delete,presentation.read,asset.read,asset_filter_category.read                             |


Scenario: Not saving changes of permissions
Meta:@globaladmin
     @gdam
Given I created 'ER9' role with 'project.read,project.write,folder.create,folder.delete,folder.read,folder.share,folder.write' permissions in 'project' group for advertiser 'DefaultAgency'
And created 'ER10' role in 'library' group for advertiser 'DefaultAgency'
When I open role 'ER9' page with parent 'DefaultAgency'
And I change role permissions to 'file.download,element.create,element.delete,element.read,element.write,element.usage_rights.read,element.usage_rights.write,project.read'
And open role 'ER10' page with parent 'DefaultAgency'
And open role 'ER9' page with parent 'DefaultAgency'
And refresh the page
Then I should see role 'ER9' contains 'project.read,project.write,folder.create,folder.delete,folder.read,folder.share,folder.write'


!-- New scenario for NGN-14650
Scenario: Default roles not editable
Meta:@globaladmin
     @gdam
Given I am on global roles page
When I open role '<RoleName>' page with parent 'DefaultAgency'
And refresh the page without delay
Then I 'should' see element 'CopyButton' on roles page
And permissions checkboxes are 'disabled' on role '<RoleName>' page


Examples:
| RoleName      |
| agency.admin  |
| guest.user    |