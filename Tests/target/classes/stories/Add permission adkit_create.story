!--NGN-10994
Feature:          Check that adkit.create permission is enable
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that adkit.create permission is enable

Scenario: check that permission is enabled by default for agency.admin and agency.user roles
Meta:@globaladmin
     @gdam
Given I created the agency 'APAC_A1' with default attributes
When I login with details of 'GlobalAdmin'
And go to global roles page
And I search advertiser 'APAC_A1' on global roles page
And select advertiser 'APAC_A1' on global roles page
And open role '<Role>' page with parent 'APAC_A1'
Then I should see role '<Role>' that '<ShouldState>' contains following selected permissions '<Permissions>'

Examples:
| Role         | ShouldState | Permissions                                                                         |
| agency.admin | should      | adkit.complete,adkit.create,adkit.delete,adkit.read,adkit.write,adkit_template.read |
| agency.user  | should not  | activity.read,adkit.create,adkit.delete,adkit.read                                  |


Scenario: Check that if permission is enabled than should affect visibility of Add to New Work Request button
Meta:@gdam
     @library
Given I created the agency 'APAC_A1' with default attributes
And I created users with following fields:
| Email   | Role    | Agency  |
| <Email> | <Roles> | APAC_A1 |
And I logged in with details of '<Email>'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I selected asset 'Fish Ad.mov' in the 'My Assets'  library pageNEWLIB
Then I '<ShouldState>' see 'Add to Work Request' option in menu for collection 'My Assets'NEWLIB

Examples:
| Email     | Roles        | ShouldState |
| APAC_E1_1 | agency.admin | should      |



Scenario: Check that if permission is not enabled than should affect visibility of Add to New Work Request button
Meta:@gdam
     @library
Given I created the agency 'APAC_A1_1' with default attributes
And I created users with following fields:
| Email   | Role    | Agency  |Access|
| <Email> | <Roles> | APAC_A1_1 |streamlined_library|
And I logged in with details of '<Email>'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I selected asset 'Fish Ad.mov' in the 'My Assets'  library pageNEWLIB
Then I '<ShouldState>' see 'Add to Work Request' option in menu for collection 'My Assets'NEWLIB

Examples:
| Email     | Roles        | ShouldState |
| APAC_E1_2 | agency.user  | should not  |
