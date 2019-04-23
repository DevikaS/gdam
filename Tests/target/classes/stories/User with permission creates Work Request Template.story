Feature: User with permission creates Work Request Template
Narrative:
In order to work with the system
As a AgencyAdmin
I want to be able to create Work Request Template


Scenario: check that by clicking this button user should see Create Work Request Template form with WR schema fields.
Meta:@gdam
@projects
Given I created the agency 'BU_UWPPTSAOCWRT_S01' with default attributes
And I created 'R_UWPPTSAOCWRT_S01' role in 'global' group for advertiser 'BU_UWPPTSAOCWRT_S01' with following permissions:
| Permission            |
| element.read          |
| folder.read           |
| adkit_template.create |
| adkit_template.read   |
| project.create |
| project_template.create |
And created users with following fields:
| Email        | Role         | Agency              |
| <UserEmail>  | <UserRole>   | BU_UWPPTSAOCWRT_S01 |
And logged in with details of '<UserEmail>'
When I go to Work Request Template list page
And I create new work request template with following fields:
| FieldName  | FieldValue          |
| Name       | <Name>              |
| Media type | Broadcast           |
| Start date | Today               |
| End date   | Tomorrow            |
Then I should see '<Name>' work request template in work request template list

Examples:
| UserEmail           | UserRole           | Name |
| UWPPTSAOCWRT_S02_A  | R_UWPPTSAOCWRT_S01 | WRT_UWPPTSAOCWRT_S02_A |
| UWPPTSAOCWRT_S02_B  | agency.admin       | WRT_UWPPTSAOCWRT_S02_B |


Scenario:check that user can then create Folders to this Template
Meta:@gdam
@projects
Given I created the agency 'BU_UWPPTSAOCWRT_S01' with default attributes
And I created 'R_UWPPTSAOCWRT_S01' role in 'global' group for advertiser 'BU_UWPPTSAOCWRT_S01' with following permissions:
| Permission            |
| element.read          |
| folder.read           |
| adkit_template.create |
| adkit_template.read   |
| adkit.create |
And created users with following fields:
| Email        | Role         | Agency              |
| <UserEmail>  | <UserRole>   | BU_UWPPTSAOCWRT_S01 |
And logged in with details of '<UserEmail>'
And created '<Name>' work request template
When I go to work request template '<Name>' files page
And create '/F_UWPPTSAOCWRT_S03' folder in '<Name>' Work Request Template
Then I 'should' see '/F_UWPPTSAOCWRT_S03' folder in '<Name>' work request template

Examples:
| UserEmail           | UserRole           | Name |
| UWPPTSAOCWRT_S03_A  | R_UWPPTSAOCWRT_S01 | WRT_UWPPTSAOCWRT_S03_A |
| UWPPTSAOCWRT_S03_B  | agency.admin       | WRT_UWPPTSAOCWRT_S03_B |


Scenario: check that user can create team to this template.
Meta:@gdam
@projects
Given I created the agency 'BU_UWPPTSAOCWRT_S01' with default attributes
And created users with following fields:
| Email                | Role         | Agency              |
| U_UWPPTSAOCWRT_S0A_A | agency.user  | BU_UWPPTSAOCWRT_S01 |
| U_UWPPTSAOCWRT_S0A_B | agency.user  | BU_UWPPTSAOCWRT_S01 |
| U_UWPPTSAOCWRT_S04   | agency.admin | BU_UWPPTSAOCWRT_S01 |
And logged in with details of 'U_UWPPTSAOCWRT_S04'
And created 'WRT_UWPPTSAOCWRT_S04_B' work request template
And created '/F_UWPPTSAOCWRT_S04' folder for work request template 'WRT_UWPPTSAOCWRT_S04_B'
And I created agency project team 'APT_UWPPTSAOCWRT_S04' with following data:
| UserName              | Role                |
| U_UWPPTSAOCWRT_S0A_A  | project.observer    |
| U_UWPPTSAOCWRT_S0A_B  | project.contributor |
And I am on work request template 'WRT_UWPPTSAOCWRT_S04_B' teams page
When I add agency project team 'APT_UWPPTSAOCWRT_S04' for folder 'F_UWPPTSAOCWRT_S04' in the work request template 'WRT_UWPPTSAOCWRT_S04_B'
Then I 'should' see project team 'APT_UWPPTSAOCWRT_S04' in agency project teams list for this project
And I 'should' see user 'U_UWPPTSAOCWRT_S0A_A' name in teams of work request template 'WRT_UWPPTSAOCWRT_S04_B'
And I 'should' see user 'U_UWPPTSAOCWRT_S0A_B' name in teams of work request template 'WRT_UWPPTSAOCWRT_S04_B'



Scenario: check that filter Template list by type: Work Request Templates, Project Templates works correctly.
Meta:@gdam
@projects
Given I created the agency 'BU_UWPPTSAOCWRT_S01' with default attributes
And I created 'R_UWPPTSAOCWRT_S01' role in 'global' group for advertiser 'BU_UWPPTSAOCWRT_S01' with following permissions:
| Permission            |
| element.read          |
| folder.read           |
| adkit_template.create |
| adkit_template.read   |
| adkit.create |
And created users with following fields:
| Email               | Role               | Agency              |
| U_UWPPTSAOCWRT_S05  | R_UWPPTSAOCWRT_S01 | BU_UWPPTSAOCWRT_S01 |
And logged in with details of 'U_UWPPTSAOCWRT_S05'
And created 'WR_UWPPTSAOCWRT_S05_1' work request template
And created 'WR_UWPPTSAOCWRT_S05_2' work request template
And created 'WR_UWPPTSAOCWRT_S05_3' work request template
And created 'T_UWPPTSAOCWRT_S05_1' template
And created 'T_UWPPTSAOCWRT_S05_2' template
And created 'T_UWPPTSAOCWRT_S05_3' template
When I go to Work request template list page
Then I 'should' see following work request templates 'WR_UWPPTSAOCWRT_S05_1,WR_UWPPTSAOCWRT_S05_2,WR_UWPPTSAOCWRT_S05_3' in work request template list
And I 'should not' see following work request templates 'T_UWPPTSAOCWRT_S05_1,T_UWPPTSAOCWRT_S05_2,T_UWPPTSAOCWRT_S05_3' in work request template list
When I go to template list page
Then I 'should' see template 'T_UWPPTSAOCWRT_S05_1' on template list page
And I 'should' see template 'T_UWPPTSAOCWRT_S05_2' on template list page
And I 'should' see template 'T_UWPPTSAOCWRT_S05_3' on template list page
And I 'should not' see template 'WR_UWPPTSAOCWRT_S05_1' on template list page
And I 'should not' see template 'WR_UWPPTSAOCWRT_S05_2' on template list page
And I 'should not' see template 'WR_UWPPTSAOCWRT_S05_3' on template list page


Scenario: check that user can create WR Template  if Projects' T&C is enabled.
Meta:@gdam
Given I created the agency 'BU_UWPPTSAOCWRT_S05' with default attributes
And I created 'R_UWPPTSAOCWRT_S05' role in 'global' group for advertiser 'BU_UWPPTSAOCWRT_S05' with following permissions:
| Permission            |
| element.read          |
| folder.read           |
| adkit_template.create |
| adkit_template.read   |
| adkit.create |
And created users with following fields:
| Email               | Role                | Agency              |
| U_UWPPTSAOCWRT_S05  | R_UWPPTSAOCWRT_S05  | BU_UWPPTSAOCWRT_S05 |
| U_UWPPTSAOCWRT_S05_N  | agency.admin      | BU_UWPPTSAOCWRT_S05 |
And logged in with details of 'U_UWPPTSAOCWRT_S05_N'
And I am on the T&C page
And waited for '3' seconds
And enabled current terms and conditions for projects on opened T&C page
And saved current terms and conditions on opened T&C page
And logged in with details of 'U_UWPPTSAOCWRT_S05'
When I go to Work Request Template list page
And accept agency Terms and Conditions
And I create new work request template with following fields:
| FieldName  | FieldValue          |
| Name       | WR_UWPPTSAOCWRT_S05 |
| Media type | Broadcast           |
| Start date | Today               |
| End date   | Tomorrow            |
Then I should see 'WR_UWPPTSAOCWRT_S05' work request template in work request template list

