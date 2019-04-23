!--NGN-13256
Feature:          Global Admin hides Library module for BU
BookNarrative:
In order to
As a              GlobalAdmin
I want to         Ensure access levels are respected as set for the user's agency.

Meta:
@cake

Scenario: Users from BU cannot see Library-related sections on Dashboard when library disabled for BU.
Given I created the agency 'A_USHTOCP_S01' with default attributes
And created users with following fields:
| Email           | Role         | Agency        |
| U_USHTOCP_S01_1 | agency.admin | A_USHTOCP_S01 |
| U_USHTOCP_S01_2 | agency.admin | A_USHTOCP_S01 |
When I update agency 'A_USHTOCP_S01' with following fields on agency overview page:
| FieldName                                       | FieldValue         |
| Enable Library Module                           | false              |
And login with details of 'U_USHTOCP_S01_1'
Then I 'should not' see section 'latest library uploads' on Dashboard page
And I 'should not' see section 'presentations' on Dashboard page
And I 'should not' see the 'Library' link in the navigation menu

!--Scenario: Users from BU cannot see Add to Project button on Library page when projects disabled for BU.
!--Given I updated agency 'A_USHTOCP_S01' with following fields on agency overview page:
!--| FieldName                                       | FieldValue         |
!--| Enable Projects Module                          | false              |
!--When I login with details of 'U_USHTOCP_S01_1'
!--Then I 'should not' see the add to a project button on library page

Scenario: Check that library page is inaccessible by direct link when library disabled for BU.
Given I updated agency 'A_USHTOCP_S01' with following fields on agency overview page:
| FieldName                                       | FieldValue         |
| Enable Library Module                           | <LibraryEnabled>   |
When I login with details of '<Email>'
Then I '<Condition>' see an access denied message on library page

Examples:
| Email           | Condition  | LibraryEnabled  |
| U_USHTOCP_S01_1 | should     | false           |
| U_USHTOCP_S01_2 | should not | true            |

Scenario: Check that user profile settings does not offer library access when disabled for BU.
Given I updated agency 'A_USHTOCP_S01' with following fields on agency overview page:
| FieldName                                       | FieldValue         |
| Enable Library Module                           | false              |
And created users with following fields:
| Email           | Role         | Agency        |
| U_USHTOCP_S04_1 | agency.admin | A_USHTOCP_S01 |
When I login with details of 'U_USHTOCP_S01_1'
Then I 'should not' see 'library' application access checkbox on user 'U_USHTOCP_S04_1' details page
