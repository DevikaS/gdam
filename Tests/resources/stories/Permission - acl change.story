!--NGN-2394
Feature:          Permission - acl change
Narrative:
In order to
As a              AgencyAdmin
I want to         Check permission: acl.change

Scenario: Check that Change Acl permission is setted up by default for agency admin
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
And I am on global roles page
Then I should see role 'agency.admin' that 'should' contains following selected permissions 'acl.change'


Scenario: Check that Change Acl permission is available only for Global roles
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
And I am on global roles page
Then I should see role '<Role>' that '<Should>' contains following permissions 'acl.change' available for selecting

Examples:
| Role               | Should     |
| agency.admin       | should     |
| agency.enums.read  | should     |
| agency.enums.write | should     |
| agency.user        | should     |
| guest.user         | should     |
| project.admin      | should not |


Scenario: Check that availability of Applications access and User Role depends on Change Acl permission on new user settings
Meta:@globaladmin
     @gdam
Given I created '<role>' role with '<Permissions>' permissions in 'global' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email  | Role   |
| <User> | <role> |
And I logged in with details of '<User>'
And I am on Create New User page
Then I '<Should>' see following elements on page 'myprofile':
| element                     |
| ApplicationAccessCheckBoxes |
| UserRoleBox                 |

Examples:
| User    | role    | Permissions                                                                                                                                      | Should     |
| PACU3_1 | PACR3_1 | user.create,user.read,user.write,user.delete,user_group.create,user_group.read,user_group.write,user_group.delete,role.read,enum.read            | should not |
| PACU3_2 | PACR3_2 | acl.change,user.create,user.read,user.write,user.delete,user_group.create,user_group.read,user_group.write,user_group.delete,role.read,enum.read | should     |


Scenario: Check that availability of Applications access and User Role depends on Change Acl permission on own profile settings
Meta:@globaladmin
     @gdam
Given I created '<role>' role with '<Permissions>' permissions in 'global' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email  | Role   |
| <User> | <role> |
And I logged in with details of '<User>'
And I am on my profile page
Then I '<Should>' see following elements on page 'myprofile':
| element                     |
| ApplicationAccessCheckBoxes |
| UserRoleBox                 |

Examples:
| User    | role    | Permissions                                                                                                                                      | Should     |
| PACU4_1 | PACR4_1 | user.create,user.read,user.write,user.delete,user_group.create,user_group.read,user_group.write,user_group.delete,role.read,enum.read            | should not |
| PACU4_2 | PACR4_2 | acl.change,user.create,user.read,user.write,user.delete,user_group.create,user_group.read,user_group.write,user_group.delete,role.read,enum.read | should     |