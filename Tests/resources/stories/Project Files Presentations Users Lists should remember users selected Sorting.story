!--NGN-10627
Feature:          Project, Files, Presentations, Users Lists should remember user's selected Sorting
Narrative:
In order to
As a              AgencyAdmin
I want to         Project, Files, Presentations, Users Lists should remember user's selected Sorting

Scenario: Check that Project list remember user's selected Sorting
Meta:@gdam
@projects
Given created the agency 'PFPULSRUSS_A1' with default attributes
And I created users with following fields:
| Email          | Role         | AgencyUnique  |
| U_PFPULSRUSS_1 | agency.admin | PFPULSRUSS_A1 |
And I logged in with details of 'U_PFPULSRUSS_1'
And created 'a' project
And created 'b' project
And created 'c' project
And I am on Project list page
And waited for '3' seconds
And 'add' following project column 'Job number' on opened Project list page
When I sorting projects by field '<FieldName>' in order '<Order>'
And I logout from account
And I login with details of 'U_PFPULSRUSS_1'
And I go to Project list page
Then I should see projects sorted by field '<FieldName>' in order '<Order>'

Examples:
| FieldName | Order |
| Title     | asc   |
| Title     | desc  |
| jobNumber | asc   |
| jobNumber | desc  |


Scenario: Check that Templates list remember user's selected Sorting
Meta:@gdam
@projects
Given created the agency 'PFPULSRUSS_A1' with default attributes
And I created users with following fields:
| Email          | Role         | AgencyUnique  |
| U_PFPULSRUSS_2 | agency.admin | PFPULSRUSS_A1 |
And I logged in with details of 'U_PFPULSRUSS_2'
And created 'a_template' template
And created 'b_template' template
And created 'c_template' template
And I am on Template list page
When I sorting templates by field '<SortBy>' in order '<Order>'
And I logout from account
And I login with details of 'U_PFPULSRUSS_2'
And I go to Template list page
Then I should see templates sorted by field '<FieldName>' in order '<Order>'

Examples:
| SortBy          | FieldName | Order |
| _cm.common.name | name      | asc   |
| _cm.common.name | name      | desc  |


Scenario: Check that User list remember user's selected Sorting
Meta:@gdam
@projects
Given created the agency 'PFPULSRUSS_A1' with default attributes
And I created users with following fields:
| Email          | Role         | AgencyUnique  |
| U_PFPULSRUSS_3 | agency.admin | PFPULSRUSS_A1 |
And I logged in with details of 'U_PFPULSRUSS_3'
And created following users:
| User Name |
| a_user    |
| b_user    |
| c_user    |
And I am on Users list page
When I sort users by field 'User' in order '<Order>'
And I logout from account
And I login with details of 'U_PFPULSRUSS_3'
And go to User list page
Then I 'should' see users sorted by field '<FieldName>' in order '<Order>'

Examples:
| FieldName | Order |
| name      | asc   |
| name      | desc  |


Scenario: Check that Presentation list remember user's selected Sorting
Meta:@gdam
@library
Given created the agency 'PFPULSRUSS_A1' with default attributes
And I created users with following fields:
| Email          | Role         | AgencyUnique  |
| U_PFPULSRUSS_4 | agency.admin | PFPULSRUSS_A1 |
And I logged in with details of 'U_PFPULSRUSS_4'
And created following reels:
| Name           | Description |
| a_presentation | test descr  |
| b_presentation | test descr  |
| c_presentation | test descr  |
And I am on the all presentations page
When I sorting presentations by field '<FieldName>' in order '<Order>'
And I logout from account
And I login with details of 'U_PFPULSRUSS_4'
And go to the all presentations page
Then I 'should' see presentations sorted by '<FieldName>' field in order '<Order>'

Examples:
| FieldName | Order |
| name      | asc   |
| name      | desc  |