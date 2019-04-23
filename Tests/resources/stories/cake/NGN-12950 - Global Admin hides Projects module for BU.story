!--NGN-12950
Feature:          Global Admin hides Projects module for BU
BookNarrative:
In order to
As a              GlobalAdmin
I want to         Ensure access levels are respected as set for the user's agency.

Meta:
@cake

Scenario: Users from BU cannot see Project-related sections on Dashboard when projects disabled for BU.
Given I created the agency 'A_USHTOCP_S01' with default attributes
And created users with following fields:
| Email           | Role         | Agency        |
| U_USHTOCP_S01_1 | agency.admin | A_USHTOCP_S01 |
When I update agency 'A_USHTOCP_S01' with following fields on agency overview page:
| FieldName                                       | FieldValue         |
| Enable Projects Module                          | false              |
And login with details of 'U_USHTOCP_S01_1'
Then I 'should not' see section 'approvals' on Dashboard page
And I 'should not' see section 'files in your projects' on Dashboard page
And I 'should not' see section 'my projects' on Dashboard page
And I 'should not' see the 'Projects' link in the navigation menu

!--Scenario: Users from BU cannot see Add to Project button on Library page when projects disabled for BU.
!--Given I updated agency 'A_USHTOCP_S01' with following fields on agency overview page:
!--| FieldName                                       | FieldValue         |
!--| Enable Projects Module                          | false              |
!--When I login with details of 'U_USHTOCP_S01_1'
!--Then I 'should not' see the add to a project button on library page

Scenario: Check that projects list page is inaccessible by direct link when projects disabled for BU.
Given I updated agency 'A_USHTOCP_S01' with following fields on agency overview page:
| FieldName                                       | FieldValue         |
| Enable Projects Module                          | <ProjectsEnabled>  |
When I login with details of 'U_USHTOCP_S01_1'
Then I '<Condition>' see an access denied message on project list page

Examples:
| Condition  | ProjectsEnabled |
| should     | false           |
| should not | true            |

Scenario: Check that user profile settings does not offer projects access when disabled for BU.
Given I updated agency 'A_USHTOCP_S01' with following fields on agency overview page:
| FieldName                                       | FieldValue         |
| Enable Projects Module                          | false              |
And created users with following fields:
| Email           | Role         | Agency        |
| U_USHTOCP_S04_1 | agency.admin | A_USHTOCP_S01 |
When I login with details of 'U_USHTOCP_S01_1'
Then I 'should not' see 'library' application access checkbox on user 'U_USHTOCP_S04_1' details page
