!--NGN-11262
Feature:          User can filter project list by BU
Narrative:
In order to
As a              AgencyAdmin
I want to         Check filter project by BU


Scenario: Check that BU dropdown is absent if user has access to only one BU
Meta:@projects
      @gdam
Given I created users with following fields:
| Email            | Role         |
| U_UCFPLBBU_S00_1 | agency.admin |
When I login with details of 'U_UCFPLBBU_S00_1'
And go to project list page
Then I 'should not' see element 'BusinessUnitCombo' on page 'Projects'


Scenario: Check that you can filter project by BU if user has access to more than on BU
Meta:@projects
      @gdam
Given I created the agency 'A_UCFPLBBU_S01_1' with default attributes
And I created the agency 'A_UCFPLBBU_S01_2' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique     |
| U_UCFPLBBU_S01_1 | agency.admin | A_UCFPLBBU_S01_1 |
| U_UCFPLBBU_S01_2 | agency.admin | A_UCFPLBBU_S01_2 |
And added agencies 'A_UCFPLBBU_S01_2' as a partner to agency 'A_UCFPLBBU_S01_1'
And logged in with details of 'U_UCFPLBBU_S01_1'
And created 'C_UCFPLBBU_S01' category
And added users 'U_UCFPLBBU_S01_2' to category 'C_UCFPLBBU_S01' with role 'library.user' by users details
And on user 'U_UCFPLBBU_S01_2' details page
And edited for user 'U_UCFPLBBU_S01_2' agency role 'Business Unit User'
When I login with details of 'U_UCFPLBBU_S01_2'
And create following projects:
| Name             | Business Unit    |
| P_UCFPLBBU_S01_1 | A_UCFPLBBU_S01_1 |
| P_UCFPLBBU_S01_2 | A_UCFPLBBU_S01_2 |
And go to project list page
And select business unit 'A_UCFPLBBU_S01_2' on projects list page
Then I 'should' see project 'P_UCFPLBBU_S01_2' on project list page
And I 'should not' see project 'P_UCFPLBBU_S01_1' on project list page
When select business unit 'A_UCFPLBBU_S01_1' on projects list page
Then I 'should not' see project 'P_UCFPLBBU_S01_2' on project list page
And I 'should' see project 'P_UCFPLBBU_S01_1' on project list page


Scenario: Check other filtering with enabled 'Business Unit' filter
Meta: @bug
      @gdam
      @projects
!--FAB-455 --Corss media scenario fails
Given I created the agency 'A_UCFPLBBU_S01_1' with default attributes
And created the agency 'A_UCFPLBBU_S01_2' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique     |
| U_UCFPLBBU_S02_1 | agency.admin | A_UCFPLBBU_S01_1 |
| U_UCFPLBBU_S02_3 | agency.admin | A_UCFPLBBU_S01_2 |
And logged in with details of 'U_UCFPLBBU_S02_1'
And created 'P_UCFPLBBU_S02_1' project
And created '/F_UCFPLBBU_S02' folder for project 'P_UCFPLBBU_S02_1'
And fill Share popup by users 'U_UCFPLBBU_S02_3' in project 'P_UCFPLBBU_S02_1' folders '/F_UCFPLBBU_S02' with role 'Project User' expired '12.12.2022' and 'should' access to subfolders
And on user 'U_UCFPLBBU_S02_3' details page
And edited for user 'U_UCFPLBBU_S02_3' agency role 'Business Unit User'
And logged in with details of 'U_UCFPLBBU_S02_3'
And created 'P_UCFPLBBU_S02_2' project
When create following projects:
| Name             | Media Type  | Business Unit    |
| P_UCFPLBBU_S02_1 | Broadcast   | A_UCFPLBBU_S01_1 |
| P_UCFPLBBU_S02_2 | Cross Media | A_UCFPLBBU_S01_1 |
| P_UCFPLBBU_S02_3 | Broadcast   | A_UCFPLBBU_S01_2 |
| P_UCFPLBBU_S02_4 | Cross Media | A_UCFPLBBU_S01_2 |
And I go to project list page
And I select filtering by media type '<MediaType>'
And select business unit '<BusinessUnit>' on projects list page
Then I should see '<ProjectAvailable>' project in project list
And I shouldn't see '<ProjectInvisible>' project in project list

Examples:
| MediaType   | BusinessUnit     | ProjectAvailable | ProjectInvisible                                   |
| Broadcast   | A_UCFPLBBU_S01_1 | P_UCFPLBBU_S02_1 | P_UCFPLBBU_S02_2,P_UCFPLBBU_S02_3,P_UCFPLBBU_S02_4 |
| Cross Media | A_UCFPLBBU_S01_2 | P_UCFPLBBU_S02_4 | P_UCFPLBBU_S02_1,P_UCFPLBBU_S02_2,P_UCFPLBBU_S02_3 |


Scenario: Check filter by BU for Work Request
Meta:@projects
      @gdam
Given I created the agency 'A_UCFPLBBU_S01_1' with default attributes
And created the agency 'A_UCFPLBBU_S01_2' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique     |
| U_UCFPLBBU_S02_1 | agency.admin | A_UCFPLBBU_S01_1 |
| U_UCFPLBBU_S02_2 | agency.admin | A_UCFPLBBU_S01_2 |
And added agencies 'A_UCFPLBBU_S01_2' as a partner to agency 'A_UCFPLBBU_S01_1'
And logged in with details of 'U_UCFPLBBU_S02_1'
And created 'P_UCFPLBBU_S02_1' project
And created '/F_UCFPLBBU_S02' folder for project 'P_UCFPLBBU_S02_1'
And fill Share popup by users 'U_UCFPLBBU_S02_2' in project 'P_UCFPLBBU_S02_1' folders '/F_UCFPLBBU_S02' with role 'Project User' expired '12.12.2022' and 'should' access to subfolders
And on user 'U_UCFPLBBU_S02_2' details page
And edited for user 'U_UCFPLBBU_S02_2' agency role 'Business Unit Admin'
And logged in with details of 'U_UCFPLBBU_S02_2'
When create new work request and fill the following fields for:
| Business Unit    | Name              |
| A_UCFPLBBU_S01_1 | WR_UCFPLBBU_S02_1 |
And create new work request and fill the following fields for:
| Business Unit    | Name              |
| A_UCFPLBBU_S01_2 | WR_UCFPLBBU_S02_2 |
And I go to work request list page
And select business unit 'A_UCFPLBBU_S01_1' on work requests list page
Then I should see 'WR_UCFPLBBU_S02_1' work request in work request list
And I 'should not' see following work request 'WR_UCFPLBBU_S02_2' in work request list
When I select business unit 'A_UCFPLBBU_S01_2' on work requests list page
Then I should see 'WR_UCFPLBBU_S02_2' work request in work request list
And I 'should not' see following work request 'WR_UCFPLBBU_S02_1' in work request list


Scenario: Check filter by BU for Work Request Template
Meta:@projects
      @gdam
Given I created the agency 'A_UCFPLBBU_S01_1' with default attributes
And created the agency 'A_UCFPLBBU_S01_2' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique     |
| U_UCFPLBBU_S02_1 | agency.admin | A_UCFPLBBU_S01_1 |
| U_UCFPLBBU_S02_2 | agency.admin | A_UCFPLBBU_S01_2 |
And added agencies 'A_UCFPLBBU_S01_2' as a partner to agency 'A_UCFPLBBU_S01_1'
And logged in with details of 'U_UCFPLBBU_S02_1'
And created 'P_UCFPLBBU_S02_1' project
And created '/F_UCFPLBBU_S02' folder for project 'P_UCFPLBBU_S02_1'
And fill Share popup by users 'U_UCFPLBBU_S02_2' in project 'P_UCFPLBBU_S02_1' folders '/F_UCFPLBBU_S02' with role 'Project User' expired '12.12.2022' and 'should' access to subfolders
And on user 'U_UCFPLBBU_S02_2' details page
And edited for user 'U_UCFPLBBU_S02_2' agency role 'Business Unit Admin'
And logged in with details of 'U_UCFPLBBU_S02_2'
When I go to work request template list page
And create new work request template with following fields:
| FieldName      | FieldValue         |
| Name           | WRT_UCFPLBBU_S02_1 |
| Media type     | Broadcast          |
| Start date     | Today              |
| End date       | Tomorrow           |
And create new work request template with following fields:
| FieldName      | FieldValue         |
| Business Unit  | A_UCFPLBBU_S01_1   |
| Name           | WRT_UCFPLBBU_S02_4 |
| Media type     | Broadcast          |
| Start date     | Today              |
| End date       | Tomorrow           |
And I go to Work request template list page
And I select business unit 'A_UCFPLBBU_S01_1' on work requests template list page
Then I 'should' see following work request templates 'WRT_UCFPLBBU_S02_4' in work request template list
And I 'should not' see following work request templates 'WRT_UCFPLBBU_S02_1' in work request template list
When I select business unit 'A_UCFPLBBU_S01_2' on work requests template list page
Then I 'should' see following work request templates 'WRT_UCFPLBBU_S02_1' in work request template list
And I 'should not' see following work request templates 'WRT_UCFPLBBU_S02_4' in work request template list


Scenario: Check filter by BU for Project template
Meta:@projects
      @gdam
Given I created the agency 'A_UCFPLBBU_S01_1' with default attributes
And created the agency 'A_UCFPLBBU_S01_2' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique     |
| U_UCFPLBBU_S02_1 | agency.admin | A_UCFPLBBU_S01_1 |
| U_UCFPLBBU_S02_2 | agency.admin | A_UCFPLBBU_S01_2 |
And logged in with details of 'GlobalAdmin'
And added agencies 'A_UCFPLBBU_S01_2' as a partner to agency 'A_UCFPLBBU_S01_1'
And logged in with details of 'U_UCFPLBBU_S02_1'
And created 'P_UCFPLBBU_S02_1' project
And created '/F_UCFPLBBU_S02' folder for project 'P_UCFPLBBU_S02_1'
And fill Share popup by users 'U_UCFPLBBU_S02_2' in project 'P_UCFPLBBU_S02_1' folders '/F_UCFPLBBU_S02' with role 'Project User' expired '12.12.2022' and 'should' access to subfolders
And on user 'U_UCFPLBBU_S02_2' details page
And edited for user 'U_UCFPLBBU_S02_2' agency role 'Business Unit Admin'
And logged in with details of 'U_UCFPLBBU_S02_2'
And created 'P_UCFPLBBU_S02_2' project
When I go to template list page
And I create  new template with following fields:
| FieldName      | FieldValue        |
| Name           | PR_UCFPLBBU_S02_0 |
| Media type     | Broadcast         |
| Start date     | Today             |
| End date       | Tomorrow          |
And I create  new template with following fields:
| FieldName      | FieldValue        |
| Business Unit  | A_UCFPLBBU_S01_1  |
| Name           | PR_UCFPLBBU_S02_1 |
| Media type     | Broadcast         |
| Start date     | Today             |
| End date       | Tomorrow          |
And I go to template list page
When I select business unit 'A_UCFPLBBU_S01_1' on project templates page
Then I should see 'PR_UCFPLBBU_S02_1' template in template list
And I  should not see 'PR_UCFPLBBU_S02_0' template in template list
When I select business unit 'A_UCFPLBBU_S01_2' on project templates page
Then I should see 'PR_UCFPLBBU_S02_0' template in template list
And I should not see 'PR_UCFPLBBU_S02_1' template in template list


Scenario: Check that after switch to Template tab and back filter is saved
Meta:@projects
      @gdam
!--sic! NGN-11413
Given I created the agency 'A_UCFPLBBU_S01_1' with default attributes
And created the agency 'A_UCFPLBBU_S01_2' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique     |
| U_UCFPLBBU_S02_1 | agency.admin | A_UCFPLBBU_S01_1 |
| U_UCFPLBBU_S02_2 | agency.admin | A_UCFPLBBU_S01_2 |
And logged in with details of 'U_UCFPLBBU_S02_1'
And created 'P_UCFPLBBU_S02_1' project
And created '/F_UCFPLBBU_S02' folder for project 'P_UCFPLBBU_S02_1'
And fill Share popup by users 'U_UCFPLBBU_S02_2' in project 'P_UCFPLBBU_S02_1' folders '/F_UCFPLBBU_S02' with role 'Project User' expired '12.12.2022' and 'should' access to subfolders
And on user 'U_UCFPLBBU_S02_2' details page
And edited for user 'U_UCFPLBBU_S02_2' agency role 'Business Unit Admin'
And logged in with details of 'U_UCFPLBBU_S02_2'
And created 'P_UCFPLBBU_S06_2' project
And created following projects:
| Name             | Media Type | Start date | End date   | Business Unit    |
| P_UCFPLBBU_S06_3 | Broadcast  | [Today]    | [Tomorrow] | A_UCFPLBBU_S01_1 |
When I go to project list page
And select business unit 'A_UCFPLBBU_S01_1' on projects list page
And go to template list page
And wait for '3' seconds
And go to project list page
And wait for '3' seconds
Then I 'should' see project 'P_UCFPLBBU_S06_3' on project list page
And I 'should not' see project 'P_UCFPLBBU_S06_2' on project list page


Scenario: Check filter by BU on Project search result page
!--FAB-467
Meta:@bug
     @gdam
     @projects
Given I created the agency 'A_UCFPLBBU_S01_1' with default attributes
And created the agency 'A_UCFPLBBU_S01_2' with default attributes
And created users with following fields:
| Email            | Role         | AgencyUnique     |
| U_UCFPLBBU_S02_1 | agency.admin | A_UCFPLBBU_S01_1 |
| U_UCFPLBBU_S02_2 | agency.admin | A_UCFPLBBU_S01_2 |
And added agencies 'A_UCFPLBBU_S01_2' as a partner to agency 'A_UCFPLBBU_S01_1'
And logged in with details of 'U_UCFPLBBU_S02_1'
And created 'P_UCFPLBBU_S02_1' project
And created '/F_UCFPLBBU_S02' folder for project 'P_UCFPLBBU_S02_1'
And fill Share popup by users 'U_UCFPLBBU_S02_2' in project 'P_UCFPLBBU_S02_1' folders '/F_UCFPLBBU_S02' with role 'Project User' expired '12.12.2022' and 'should' access to subfolders
And on user 'U_UCFPLBBU_S02_2' details page
And edited for user 'U_UCFPLBBU_S02_2' agency role 'Business Unit Admin'
And logged in with details of 'U_UCFPLBBU_S02_2'
And created 'P_UCFPLBBU_S07_2' project
When I go to template list page
And I create  new template with following fields:
| FieldName      | FieldValue        |
| Name           | PR_UCFPLBBU_S07_1 |
| Media type     | Broadcast         |
| Start date     | Today             |
| End date       | Tomorrow          |
And I go to template list page
And I create  new template with following fields:
| FieldName      | FieldValue        |
| Business Unit  | A_UCFPLBBU_S01_1  |
| Name           | PR_UCFPLBBU_S07_2 |
| Media type     | Broadcast         |
| Start date     | Today             |
| End date       | Tomorrow          |
And I go to template list page
And I search by text 'PR_UCFPLBBU'
And click show all link for global user search
And I select business unit 'A_UCFPLBBU_S01_2' on projects search result page
Then I 'should' see following templates on the template search page 'PR_UCFPLBBU_S07_1'
And I 'should not' see following templates on the template search page 'PR_UCFPLBBU_S07_2'
When I select business unit 'A_UCFPLBBU_S01_1' on projects search result page
Then I 'should' see following templates on the template search page 'PR_UCFPLBBU_S07_2'
And I 'should not' see following templates on the template search page 'PR_UCFPLBBU_S07_1'