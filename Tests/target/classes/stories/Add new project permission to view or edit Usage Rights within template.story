!--NGN-3367 NGN-5035
Feature:          Add new project permission to view or edit Usage Rights within template
Narrative:
In order to
As a              AgencyAdmin
I want to         Check new project permission to view or edit Usage Rights within template

Scenario: Check that 'element.usage_rights.read' permission correctly works for different global roles if user has been added to folder via Team in template
Meta: @skip
      @gdam
Given I created '<ProjectRole>' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission            |
| project.read          |
| project_template.read |
| folder.read           |
| element.read          |
| <Permission>          |
And created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And created '<TemplateName>' template
And created '/F_ANPPT_S01' folder for template '<TemplateName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPT_S01' folder for '<TemplateName>' template
And waited while file 'Fish Ad.mov' fully uploaded to folder folder '/F_ANPPT_S01' of template '<TemplateName>'
And added users '<UserEmail>' to template '<TemplateName>' team folders '/F_ANPPT_S01' with role '<ProjectRole>' expired '12.02.2021'
When I login with details of '<UserEmail>'
Then I '<Condition>' see active Usage Rights tab on file '/files/Fish Ad.mov' info page in folder '/F_ANPPT_S01' template '<TemplateName>'

Examples:
| UserEmail      | UserRole     | UserAgency    | TemplateName   | ProjectRole     | Permission                 | Condition  |
| U_ANPPT_S01_1  | agency.admin | DefaultAgency | T_ANPPT_S01_1  | PR_ANPPT_S01_1  | element.usage_rights.read  | should     |
| U_ANPPT_S01_2  | agency.admin | DefaultAgency | T_ANPPT_S01_2  | PR_ANPPT_S01_2  |                            | should     |
| U_ANPPT_S01_3  | agency.user  | DefaultAgency | T_ANPPT_S01_3  | PR_ANPPT_S01_3  | element.usage_rights.read  | should     |
| U_ANPPT_S01_4  | agency.user  | DefaultAgency | T_ANPPT_S01_4  | PR_ANPPT_S01_4  |                            | should not |
| U_ANPPT_S01_5  | guest.user   | DefaultAgency | T_ANPPT_S01_5  | PR_ANPPT_S01_5  | element.usage_rights.read  | should     |
| U_ANPPT_S01_6  | guest.user   | DefaultAgency | T_ANPPT_S01_6  | PR_ANPPT_S01_6  |                            | should not |
| U_ANPPT_S01_7  | agency.admin | AnotherAgency | T_ANPPT_S01_7  | PR_ANPPT_S01_7  | element.usage_rights.read  | should     |
| U_ANPPT_S01_8  | agency.admin | AnotherAgency | T_ANPPT_S01_8  | PR_ANPPT_S01_8  |                            | should not |
| U_ANPPT_S01_9  | agency.user  | AnotherAgency | T_ANPPT_S01_9  | PR_ANPPT_S01_9  | element.usage_rights.read  | should     |
| U_ANPPT_S01_10 | agency.user  | AnotherAgency | T_ANPPT_S01_10 | PR_ANPPT_S01_10 |                            | should not |
| U_ANPPT_S01_11 | guest.user   | AnotherAgency | T_ANPPT_S01_11 | PR_ANPPT_S01_11 | element.usage_rights.read  | should     |
| U_ANPPT_S01_12 | guest.user   | AnotherAgency | T_ANPPT_S01_12 | PR_ANPPT_S01_12 |                            | should not |


Scenario: Check that user can open 'Usage Rights' tab and view added usage right with 'element.usage_rights.read' permission for different global roles if user has been added to folder via Team in template
Meta: @skip
      @gdam
Given I created '<ProjectRole>' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission                |
| project.read              |
| project_template.read     |
| folder.read               |
| element.read              |
| element.usage_rights.read |
And created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And created '<TemplateName>' template
And created '/F_ANPPT_S02' folder for template '<TemplateName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPT_S02' folder for '<TemplateName>' template
And waited while file 'Fish Ad.mov' fully uploaded to folder folder '/F_ANPPT_S02' of template '<TemplateName>'
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPT_S02' and template '<TemplateName>' Usage Rights page:
| Comment      |
| test comment |
And added users '<UserEmail>' to template '<TemplateName>' team folders '/F_ANPPT_S02' with role '<ProjectRole>' expired '12.02.2021'
When I login with details of '<UserEmail>'
Then I 'should' see 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPT_S02' and template '<TemplateName>' Usage Rights page:
| Comment      |
| test comment |

Examples:
| UserEmail     | UserRole     | UserAgency    | TemplateName  | ProjectRole    |
| U_ANPPT_S02_1 | agency.admin | DefaultAgency | T_ANPPT_S02_1 | PR_ANPPT_S02_1 |
| U_ANPPT_S02_2 | agency.user  | DefaultAgency | T_ANPPT_S02_2 | PR_ANPPT_S02_2 |
| U_ANPPT_S02_3 | guest.user   | DefaultAgency | T_ANPPT_S02_3 | PR_ANPPT_S02_3 |
| U_ANPPT_S02_4 | agency.admin | AnotherAgency | T_ANPPT_S02_4 | PR_ANPPT_S02_4 |
| U_ANPPT_S02_5 | agency.user  | AnotherAgency | T_ANPPT_S02_5 | PR_ANPPT_S02_5 |
| U_ANPPT_S02_6 | guest.user   | AnotherAgency | T_ANPPT_S02_6 | PR_ANPPT_S02_6 |


Scenario: Check visibility of 'Add Usage' button and 'Edit' link next to added usage right according to 'element.usage_rights.write' permission for different global roles if user has been added to folder via Team in template
Meta: @skip
      @gdam
Given I created '<ProjectRole>' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission                |
| project.read              |
| project_template.read     |
| folder.read               |
| element.read              |
| element.usage_rights.read |
| <Permission>              |
And created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And created '<TemplateName>' template
And created '/F_ANPPT_S03' folder for template '<TemplateName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPT_S03' folder for '<TemplateName>' template
And waited while file 'Fish Ad.mov' fully uploaded to folder folder '/F_ANPPT_S03' of template '<TemplateName>'
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPT_S03' and template '<TemplateName>' Usage Rights page:
| Comment      |
| test comment |
And added users '<UserEmail>' to template '<TemplateName>' team folders '/F_ANPPT_S03' with role '<ProjectRole>' expired '12.02.2021'
When I login with details of '<UserEmail>'
Then I '<Condition>' see Edit link next to 'Other usage' usage rule on file 'Fish Ad.mov' and folder '/F_ANPPT_S03' and template '<TemplateName>' Usage Rights page

Examples:
| UserEmail      | UserRole     | UserAgency    | TemplateName   | ProjectRole     | Permission                 | Condition  |
| U_ANPPT_S03_1  | agency.admin | DefaultAgency | T_ANPPT_S03_1  | PR_ANPPT_S03_1  | element.usage_rights.write | should     |
| U_ANPPT_S03_2  | agency.admin | DefaultAgency | T_ANPPT_S03_2  | PR_ANPPT_S03_2  |                            | should     |
| U_ANPPT_S03_3  | agency.user  | DefaultAgency | T_ANPPT_S03_3  | PR_ANPPT_S03_3  | element.usage_rights.write | should     |
| U_ANPPT_S03_4  | agency.user  | DefaultAgency | T_ANPPT_S03_4  | PR_ANPPT_S03_4  |                            | should not |
| U_ANPPT_S03_5  | guest.user   | DefaultAgency | T_ANPPT_S03_5  | PR_ANPPT_S03_5  | element.usage_rights.write | should     |
| U_ANPPT_S03_6  | guest.user   | DefaultAgency | T_ANPPT_S03_6  | PR_ANPPT_S03_6  |                            | should not |
| U_ANPPT_S03_7  | agency.admin | AnotherAgency | T_ANPPT_S03_7  | PR_ANPPT_S03_7  | element.usage_rights.write | should     |
| U_ANPPT_S03_8  | agency.admin | AnotherAgency | T_ANPPT_S03_8  | PR_ANPPT_S03_8  |                            | should not |
| U_ANPPT_S03_9  | agency.user  | AnotherAgency | T_ANPPT_S03_9  | PR_ANPPT_S03_9  | element.usage_rights.write | should     |
| U_ANPPT_S03_10 | agency.user  | AnotherAgency | T_ANPPT_S03_10 | PR_ANPPT_S03_10 |                            | should not |
| U_ANPPT_S03_11 | guest.user   | AnotherAgency | T_ANPPT_S03_11 | PR_ANPPT_S03_11 | element.usage_rights.write | should     |
| U_ANPPT_S03_12 | guest.user   | AnotherAgency | T_ANPPT_S03_12 | PR_ANPPT_S03_12 |                            | should not |


Scenario: Check that new usage right can be added by user with different global roles if user has been added to folder via Team in template with 'element.usage_rights.write' permission
Meta: @skip
      @gdam
Given I created '<ProjectRole>' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission                 |
| project.read               |
| project_template.read      |
| folder.read                |
| element.read               |
| element.usage_rights.read  |
| element.usage_rights.write |
And created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And created '<TemplateName>' template
And created '/F_ANPPT_S04' folder for template '<TemplateName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPT_S04' folder for '<TemplateName>' template
And waited while file 'Fish Ad.mov' fully uploaded to folder folder '/F_ANPPT_S04' of template '<TemplateName>'
And added users '<UserEmail>' to template '<TemplateName>' team folders '/F_ANPPT_S04' with role '<ProjectRole>' expired '12.02.2021'
When I login with details of '<UserEmail>'
And add 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPT_S04' and template '<TemplateName>' Usage Rights page:
| Comment      |
| test comment |
Then I 'should' see 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPT_S04' and template '<TemplateName>' Usage Rights page:
| Comment      |
| test comment |

Examples:
| UserEmail     | UserRole     | UserAgency    | TemplateName  | ProjectRole    |
| U_ANPPT_S04_1 | agency.admin | DefaultAgency | T_ANPPT_S04_1 | PR_ANPPT_S04_1 |
| U_ANPPT_S04_2 | agency.user  | DefaultAgency | T_ANPPT_S04_2 | PR_ANPPT_S04_2 |
| U_ANPPT_S04_3 | guest.user   | DefaultAgency | T_ANPPT_S04_3 | PR_ANPPT_S04_3 |
| U_ANPPT_S04_4 | agency.admin | AnotherAgency | T_ANPPT_S04_4 | PR_ANPPT_S04_4 |
| U_ANPPT_S04_5 | agency.user  | AnotherAgency | T_ANPPT_S04_5 | PR_ANPPT_S04_5 |
| U_ANPPT_S04_6 | guest.user   | AnotherAgency | T_ANPPT_S04_6 | PR_ANPPT_S04_6 |


Scenario: Check that usage right can be edited by user with different global roles if user has been added to folder via Team in template with 'element.usage_rights.write' permission
Meta: @skip
      @gdam
Given I created '<ProjectRole>' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission                 |
| project.read               |
| project_template.read      |
| folder.read                |
| element.read               |
| element.usage_rights.read  |
| element.usage_rights.write |
And created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And created '<TemplateName>' template
And created '/F_ANPPT_S05' folder for template '<TemplateName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPT_S05' folder for '<TemplateName>' template
And waited while file 'Fish Ad.mov' fully uploaded to folder folder '/F_ANPPT_S05' of template '<TemplateName>'
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPT_S05' and template '<TemplateName>' Usage Rights page:
| Comment      |
| test comment |
And added users '<UserEmail>' to template '<TemplateName>' team folders '/F_ANPPT_S05' with role '<ProjectRole>' expired '12.02.2021'
When I login with details of '<UserEmail>'
And edit entry of 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPT_S05' and template '<TemplateName>' Usage Rights page:
| EntryNumber | Comment              |
| 1           | updated test comment |
Then I 'should' see 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPT_S05' and template '<TemplateName>' Usage Rights page:
| Comment              |
| updated test comment |

Examples:
| UserEmail     | UserRole     | UserAgency    | TemplateName  | ProjectRole    |
| U_ANPPT_S05_1 | agency.admin | DefaultAgency | T_ANPPT_S05_1 | PR_ANPPT_S05_1 |
| U_ANPPT_S05_2 | agency.user  | DefaultAgency | T_ANPPT_S05_2 | PR_ANPPT_S05_2 |
| U_ANPPT_S05_3 | guest.user   | DefaultAgency | T_ANPPT_S05_3 | PR_ANPPT_S05_3 |
| U_ANPPT_S05_4 | agency.admin | AnotherAgency | T_ANPPT_S05_4 | PR_ANPPT_S05_4 |
| U_ANPPT_S05_5 | agency.user  | AnotherAgency | T_ANPPT_S05_5 | PR_ANPPT_S05_5 |
| U_ANPPT_S05_6 | guest.user   | AnotherAgency | T_ANPPT_S05_6 | PR_ANPPT_S05_6 |


Scenario: Check that usage right can be deleted by user with different global roles if user has been added to folder via Team in template with 'element.usage_rights.write' permission
Meta: @skip
      @gdam
Given I created '<ProjectRole>' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission                 |
| project.read               |
| project_template.read      |
| folder.read                |
| element.read               |
| element.usage_rights.read  |
| element.usage_rights.write |
And created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And created '<TemplateName>' template
And created '/F_ANPPT_S06' folder for template '<TemplateName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPT_S06' folder for '<TemplateName>' template
And waited while file 'Fish Ad.mov' fully uploaded to folder folder '/F_ANPPT_S06' of template '<TemplateName>'
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPT_S06' and template '<TemplateName>' Usage Rights page:
| Comment      |
| test comment |
And added users '<UserEmail>' to template '<TemplateName>' team folders '/F_ANPPT_S06' with role '<ProjectRole>' expired '12.02.2021'
When I login with details of '<UserEmail>'
And remove '1' entry of 'Other usage' usage rule on file 'Fish Ad.mov' and folder '/F_ANPPT_S06' and template '<TemplateName>' Usage Rights page
Then I 'should not' see 'Other usage' usage rule on file 'Fish Ad.mov' and folder '/F_ANPPT_S06' and template '<TemplateName>' Usage Rights page

Examples:
| UserEmail     | UserRole     | UserAgency    | TemplateName  | ProjectRole    |
| U_ANPPT_S06_1 | agency.admin | DefaultAgency | T_ANPPT_S06_1 | PR_ANPPT_S06_1 |
| U_ANPPT_S06_2 | agency.user  | DefaultAgency | T_ANPPT_S06_2 | PR_ANPPT_S06_2 |
| U_ANPPT_S06_3 | guest.user   | DefaultAgency | T_ANPPT_S06_3 | PR_ANPPT_S06_3 |
| U_ANPPT_S06_4 | agency.admin | AnotherAgency | T_ANPPT_S06_4 | PR_ANPPT_S06_4 |
| U_ANPPT_S06_5 | agency.user  | AnotherAgency | T_ANPPT_S06_5 | PR_ANPPT_S06_5 |
| U_ANPPT_S06_6 | guest.user   | AnotherAgency | T_ANPPT_S06_6 | PR_ANPPT_S06_6 |