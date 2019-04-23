!--NGN-49 NGN-4376
Feature:          Agency - People - Sort user list
Narrative:
In order to
As a              AgencyAdmin
I want to         Check sorting of user list

Scenario: Check availability User list sorting options
Meta:@gdam
     @projects
When I go to User list page
Then I 'should' see following elements on page 'Users':
| element    |
| SortByUser |
| SortByUnit |


Scenario: Check default sorting
Meta:@gdam
     @projects
When I go to User list page
Then I 'should' see users sorted by field 'User' in order 'asc'


Scenario: Check User list sorting
Meta:@gdam
     @projects
Given I am on Users list page
When I sort users by field '<FieldName>' in order '<Order>'
Then I 'should' see users sorted by field '<FieldName>' in order '<Order>'

Examples:
| FieldName | Order |
| User      | asc   |
| User      | desc  |
| Unit      | asc   |
| Unit      | desc  |