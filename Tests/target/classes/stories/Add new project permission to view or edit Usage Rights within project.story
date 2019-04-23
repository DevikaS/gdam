!--NGN-3367 NGN-5005
Feature:          Add new project permission to view or edit Usage Rights within project
Narrative:
In order to
As a              AgencyAdmin
I want to         Check new project permission to view or edit Usage Rights within project

Scenario: Check that Usage Rights permissions are available for project roles
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
When I create 'R_ANPPP_S01' role in 'project' group for organization 'DefaultAgency'
Then I 'should' see 'available' permissions 'element.usage_rights.read,element.usage_rights.write' on opened global role page


Scenario: Check that Usage Rights permissions are selected for agency.admin role
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
When I open role 'agency.admin' page with parent 'DefaultAgency'
Then I 'should' see 'selected' permissions 'element.usage_rights.read,element.usage_rights.write' on opened global role page


Scenario: Check that Usage Rights permissions are selected for project.admin role
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
When I open role 'project.admin' page with parent 'DefaultAgency'
Then I 'should' see 'selected' permissions 'element.usage_rights.read,element.usage_rights.write' on opened global role page


Scenario: Check that 'element.usage_rights.read' permission correctly works for different global roles if folder has been shared in project
Meta:@projects
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
And created 'P_ANPPP_S04' project
And created '/F_ANPPP_S04' folder for project 'P_ANPPP_S04'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPP_S04' folder for 'P_ANPPP_S04' project
And waited while transcoding is finished in folder '/F_ANPPP_S04' on project 'P_ANPPP_S04' files page
And fill Share popup by users '<UserEmail>' in project 'P_ANPPP_S04' folders '/F_ANPPP_S04' with role '<ProjectRole>' expired '12.02.2021' and 'should' access to subfolders
When I login with details of '<UserEmail>'
Then I '<Condition>' see active 'Usage Rights' tab on file '/files/Fish Ad.mov' info page in folder '/F_ANPPP_S04' project 'P_ANPPP_S04'

Examples:
| UserEmail      | UserRole     | UserAgency    | ProjectRole    | Permission                | Condition  |
| U_ANPPP_S04_3  | agency.user  | DefaultAgency | PR_ANPPP_S04_1 | element.usage_rights.read | should     |
| U_ANPPP_S04_6  | guest.user   | DefaultAgency | PR_ANPPP_S04_2 |                           | should not |
| U_ANPPP_S04_8  | agency.admin | AnotherAgency | PR_ANPPP_S04_2 |                           | should not |
| U_ANPPP_S04_10 | agency.user  | AnotherAgency | PR_ANPPP_S04_2 |                           | should not |
| U_ANPPP_S04_11 | guest.user   | AnotherAgency | PR_ANPPP_S04_1 | element.usage_rights.read | should     |


Scenario: Check that user can open 'Usage Rights' tab and view added usage right with 'element.usage_rights.read' permission for different global roles if folder has been shared in project
Meta:@projects
     @gdam
Given I created 'PR_ANPPP_S05' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission                |
| project.read              |
| project_template.read     |
| folder.read               |
| element.read              |
| element.usage_rights.read |
And created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And created '<ProjectName>' project
And created '/F_ANPPP_S05' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPP_S05' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_ANPPP_S05' on project '<ProjectName>' files page
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S05' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |
And refreshed the page
And fill Share popup by users '<UserEmail>' in project '<ProjectName>' folders '/F_ANPPP_S05' with role 'PR_ANPPP_S05' expired '12.02.2021' and 'should' access to subfolders
When I login with details of '<UserEmail>'
Then I 'should' see 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S05' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |

Examples:
| UserEmail     | UserRole     | UserAgency    | ProjectName   |
| U_ANPPP_S05_1 | agency.admin | DefaultAgency | P_ANPPP_S05_1 |
| U_ANPPP_S05_2 | agency.user  | DefaultAgency | P_ANPPP_S05_2 |


Scenario: Check visibility of 'Edit' link next to added usage right according to 'element.usage_rights.write' permission for different global roles if folder has been shared in project
Meta:@projects
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
And created 'P_ANPPP_S06' project
And created '/F_ANPPP_S06' folder for project 'P_ANPPP_S06'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPP_S06' folder for 'P_ANPPP_S06' project
And waited while transcoding is finished in folder '/F_ANPPP_S06' on project 'P_ANPPP_S06' files page
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S06' and project 'P_ANPPP_S06' Usage Rights page:
| Comment      |
| test comment |
And refreshed the page
And fill Share popup by users '<UserEmail>' in project 'P_ANPPP_S06' folders '/F_ANPPP_S06' with role '<ProjectRole>' expired '12.02.2021' and 'should' access to subfolders
When I login with details of '<UserEmail>'
Then I '<Condition>' see Edit link next to 'Other usage' usage rule on file 'Fish Ad.mov' and folder '/F_ANPPP_S06' and project 'P_ANPPP_S06' Usage Rights page

Examples:
| UserEmail      | UserRole     | UserAgency    | ProjectRole    | Permission                 | Condition  |
| U_ANPPP_S06_1  | agency.admin | DefaultAgency | PR_ANPPP_S06_1 | element.usage_rights.write | should     |
| U_ANPPP_S06_2  | agency.admin | DefaultAgency | PR_ANPPP_S06_2 |                            | should     |
| U_ANPPP_S06_3  | agency.user  | DefaultAgency | PR_ANPPP_S06_1 | element.usage_rights.write | should     |
| U_ANPPP_S06_4  | agency.user  | DefaultAgency | PR_ANPPP_S06_2 |                            | should not |


Scenario: Check that new usage right can be added by user with different global roles if folder has been shared in project with 'element.usage_rights.write' permission
Meta:@projects
     @gdam
Given I created 'PR_ANPPP_S07' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
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
And created '<ProjectName>' project
And created '/F_ANPPP_S07' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPP_S07' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_ANPPP_S07' on project '<ProjectName>' files page
And fill Share popup by users '<UserEmail>' in project '<ProjectName>' folders '/F_ANPPP_S07' with role 'PR_ANPPP_S07' expired '12.02.2021' and 'should' access to subfolders
When I login with details of '<UserEmail>'
And add 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S07' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |
And refresh the page
Then I 'should' see 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S07' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |

Examples:
| UserEmail     | UserRole     | UserAgency    | ProjectName   |
| U_ANPPP_S07_1 | agency.admin | DefaultAgency | P_ANPPP_S07_1 |
| U_ANPPP_S07_2 | agency.user  | DefaultAgency | P_ANPPP_S07_2 |


Scenario: Check that usage right can be edited by user with different global roles if folder has been shared in project with 'element.usage_rights.write' permission
Meta:@projects
     @gdam
Given I created 'PR_ANPPP_S08' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
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
And created '<ProjectName>' project
And created '/F_ANPPP_S08' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPP_S08' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_ANPPP_S08' on project '<ProjectName>' files page
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S08' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |
And refreshed the page
And fill Share popup by users '<UserEmail>' in project '<ProjectName>' folders '/F_ANPPP_S08' with role 'PR_ANPPP_S08' expired '12.02.2021' and 'should' access to subfolders
When I login with details of '<UserEmail>'
And edit entry of 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S08' and project '<ProjectName>' Usage Rights page:
| EntryNumber | Comment              |
| 1           | updated test comment |
And refresh the page
Then I 'should' see 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S08' and project '<ProjectName>' Usage Rights page:
| Comment              |
| updated test comment |

Examples:
| UserEmail     | UserRole     | UserAgency    | ProjectName   |
| U_ANPPP_S08_1 | agency.admin | DefaultAgency | P_ANPPP_S08_1 |
| U_ANPPP_S08_2 | agency.user  | DefaultAgency | P_ANPPP_S08_2 |


Scenario: Check that usage right can be deleted by user with different global roles if folder has been shared in project with 'element.usage_rights.write' permission
Meta:@projects
     @gdam
Given I created 'PR_ANPPP_S09' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
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
And created '<ProjectName>' project
And created '/F_ANPPP_S09' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPP_S09' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_ANPPP_S09' on project '<ProjectName>' files page
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S09' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |
And refreshed the page
And fill Share popup by users '<UserEmail>' in project '<ProjectName>' folders '/F_ANPPP_S09' with role 'PR_ANPPP_S09' expired '12.02.2021' and 'should' access to subfolders
When I login with details of '<UserEmail>'
And remove '1' entry of 'Other usage' usage rule on file 'Fish Ad.mov' and folder '/F_ANPPP_S09' and project '<ProjectName>' Usage Rights page
Then I 'should not' see 'Other usage' usage rule on file 'Fish Ad.mov' and folder '/F_ANPPP_S09' and project '<ProjectName>' Usage Rights page

Examples:
| UserEmail     | UserRole     | UserAgency    | ProjectName   |
| U_ANPPP_S09_1 | agency.admin | DefaultAgency | P_ANPPP_S09_1 |
| U_ANPPP_S09_2 | agency.user  | DefaultAgency | P_ANPPP_S09_2 |


Scenario: Check that 'element.usage_rights.read' permission correctly works for different global roles if user has been added to folder via Team in project
Meta:@projects
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
And created 'P_ANPPP_S10' project
And created '/F_ANPPP_S10' folder for project 'P_ANPPP_S10'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPP_S10' folder for 'P_ANPPP_S10' project
And waited while transcoding is finished in folder '/F_ANPPP_S10' on project 'P_ANPPP_S10' files page
And added users '<UserEmail>' to project 'P_ANPPP_S10' team folders '/F_ANPPP_S10' with role '<ProjectRole>' expired '12.02.2021'
When I login with details of '<UserEmail>'
Then I '<Condition>' see active 'Usage Rights' tab on file '/files/Fish Ad.mov' info page in folder '/F_ANPPP_S10' project 'P_ANPPP_S10'

Examples:
| UserEmail      | UserRole     | UserAgency    | ProjectRole    | Permission                | Condition  |
| U_ANPPP_S10_4  | agency.user  | DefaultAgency | PR_ANPPP_S10_2 |                           | should not |
| U_ANPPP_S10_5  | guest.user   | DefaultAgency | PR_ANPPP_S10_1 | element.usage_rights.read | should     |
| U_ANPPP_S10_9  | agency.user  | AnotherAgency | PR_ANPPP_S10_1 | element.usage_rights.read | should     |
| U_ANPPP_S10_12 | guest.user   | AnotherAgency | PR_ANPPP_S10_2 |                           | should not |


Scenario: Check that user can open 'Usage Rights' tab and view added usage right with 'element.usage_rights.read' permission for different global roles if user has been added to folder via Team in project
Meta:@projects
     @gdam
Given I created 'PR_ANPPP_S11' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission                |
| project.read              |
| project_template.read     |
| folder.read               |
| element.read              |
| element.usage_rights.read |
And created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And created '<ProjectName>' project
And created '/F_ANPPP_S11' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPP_S11' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_ANPPP_S11' on project '<ProjectName>' files page
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S11' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |
And refreshed the page
And added users '<UserEmail>' to project '<ProjectName>' team folders '/F_ANPPP_S11' with role 'PR_ANPPP_S11' expired '12.02.2021'
When I login with details of '<UserEmail>'
Then I 'should' see 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S11' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |

Examples:
| UserEmail     | UserRole     | UserAgency    | ProjectName   |
| U_ANPPP_S11_3 | guest.user   | DefaultAgency | P_ANPPP_S11_3 |
| U_ANPPP_S11_4 | agency.admin | AnotherAgency | P_ANPPP_S11_4 |


Scenario: Check visibility of 'Edit' link next to added usage right according to 'element.usage_rights.write' permission for different global roles if user has been added to folder via Team in project
Meta:@projects
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
And created 'P_ANPPP_S12' project
And created '/F_ANPPP_S12' folder for project 'P_ANPPP_S12'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPP_S12' folder for 'P_ANPPP_S12' project
And waited while transcoding is finished in folder '/F_ANPPP_S12' on project 'P_ANPPP_S12' files page
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S12' and project 'P_ANPPP_S12' Usage Rights page:
| Comment      |
| test comment |
And refreshed the page
And added users '<UserEmail>' to project 'P_ANPPP_S12' team folders '/F_ANPPP_S12' with role '<ProjectRole>' expired '12.02.2021'
When I login with details of '<UserEmail>'
Then I '<Condition>' see Edit link next to 'Other usage' usage rule on file 'Fish Ad.mov' and folder '/F_ANPPP_S12' and project 'P_ANPPP_S12' Usage Rights page

Examples:
| UserEmail      | UserRole     | UserAgency    | ProjectRole    | Permission                 | Condition  |
| U_ANPPP_S12_5  | guest.user   | DefaultAgency | PR_ANPPP_S12_1 | element.usage_rights.write | should     |
| U_ANPPP_S12_6  | guest.user   | DefaultAgency | PR_ANPPP_S12_2 |                            | should not |
| U_ANPPP_S12_7  | agency.admin | AnotherAgency | PR_ANPPP_S12_1 | element.usage_rights.write | should     |
| U_ANPPP_S12_8  | agency.admin | AnotherAgency | PR_ANPPP_S12_2 |                            | should not |


Scenario: Check that new usage right can be added by user with different global roles if user has been added to folder via Team in project with 'element.usage_rights.write' permission
Meta:@projects
     @gdam
Given I created 'PR_ANPPP_S13' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
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
And created '<ProjectName>' project
And created '/F_ANPPP_S13' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPP_S13' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_ANPPP_S13' on project '<ProjectName>' files page
And added users '<UserEmail>' to project '<ProjectName>' team folders '/F_ANPPP_S13' with role 'PR_ANPPP_S13' expired '12.02.2021'
When I login with details of '<UserEmail>'
And add 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S13' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |
And refresh the page
Then I 'should' see 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S13' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |

Examples:
| UserEmail     | UserRole     | UserAgency    | ProjectName   |
| U_ANPPP_S13_3 | guest.user   | DefaultAgency | P_ANPPP_S13_3 |
| U_ANPPP_S13_4 | agency.admin | AnotherAgency | P_ANPPP_S13_4 |


Scenario: Check that usage right can be edited by user with different global roles if user has been added to folder via Team in project with 'element.usage_rights.write' permission
Meta:@projects
     @gdam
Given I created 'PR_ANPPP_S14' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
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
And created '<ProjectName>' project
And created '/F_ANPPP_S14' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPP_S14' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_ANPPP_S14' on project '<ProjectName>' files page
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S14' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |
And added users '<UserEmail>' to project '<ProjectName>' team folders '/F_ANPPP_S14' with role 'PR_ANPPP_S14' expired '12.02.2021'
When I login with details of '<UserEmail>'
And edit entry of 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S14' and project '<ProjectName>' Usage Rights page:
| EntryNumber | Comment              |
| 1           | updated test comment |
And refresh the page
Then I 'should' see 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S14' and project '<ProjectName>' Usage Rights page:
| Comment              |
| updated test comment |

Examples:
| UserEmail     | UserRole     | UserAgency    | ProjectName   |
| U_ANPPP_S14_3 | guest.user   | DefaultAgency | P_ANPPP_S14_3 |
| U_ANPPP_S14_4 | agency.admin | AnotherAgency | P_ANPPP_S14_4 |


Scenario: Check that usage right can be deleted by user with different global roles if user has been added to folder via Team in project with 'element.usage_rights.write' permission
Meta:@projects
     @gdam
Given I created 'PR_ANPPP_S15' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
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
And created '<ProjectName>' project
And created '/F_ANPPP_S15' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPP_S15' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_ANPPP_S15' on project '<ProjectName>' files page
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S15' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |
And added users '<UserEmail>' to project '<ProjectName>' team folders '/F_ANPPP_S15' with role 'PR_ANPPP_S15' expired '12.02.2021'
When I login with details of '<UserEmail>'
And remove '1' entry of 'Other usage' usage rule on file 'Fish Ad.mov' and folder '/F_ANPPP_S15' and project '<ProjectName>' Usage Rights page
And refresh the page
Then I 'should not' see 'Other usage' usage rule on file 'Fish Ad.mov' and folder '/F_ANPPP_S15' and project '<ProjectName>' Usage Rights page

Examples:
| UserEmail     | UserRole     | UserAgency    | ProjectName   |
| U_ANPPP_S15_3 | guest.user   | DefaultAgency | P_ANPPP_S15_3 |
| U_ANPPP_S15_4 | agency.admin | AnotherAgency | P_ANPPP_S15_4 |


Scenario: Check that 'element.usage_rights.read' permission correctly works for different global roles if project has been shared via project ownership in project
Meta:@projects
     @gdam
Given I created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And created 'P_ANPPP_S16' project
And created '/F_ANPPP_S16' folder for project 'P_ANPPP_S16'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPP_S16' folder for 'P_ANPPP_S16' project
And waited while transcoding is finished in folder '/F_ANPPP_S16' on project 'P_ANPPP_S16' files page
And I am on project 'P_ANPPP_S16' settings page
And edited the following fields for 'P_ANPPP_S16' project:
| Name        | Administrators |
| P_ANPPP_S16 | <UserEmail>    |
And clicked on element 'SaveButton'
And waited for '2' seconds
When I login with details of '<UserEmail>'
Then I 'should' see active 'Usage Rights' tab on file '/files/Fish Ad.mov' info page in folder '/F_ANPPP_S16' project 'P_ANPPP_S16'

Examples:
| UserEmail     | UserRole     | UserAgency    |
| U_ANPPP_S16_1 | agency.admin | DefaultAgency |
| U_ANPPP_S16_4 | agency.user  | AnotherAgency |
| U_ANPPP_S16_6 | guest.user   | AnotherAgency |


Scenario: User with 'element.usage_rights.read' permission can open and view 'Usage Rights' tab if project has been shared via project ownership in project
Meta:@projects
     @gdam
Given I created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And added user '<UserEmail>' into address book
And created '<ProjectName>' project
And created '/F_ANPPP_S17' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPP_S17' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_ANPPP_S17' on project '<ProjectName>' files page
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S17' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |
And I am on project '<ProjectName>' settings page
And edited the following fields for '<ProjectName>' project:
| Name          | Administrators |
| <ProjectName> | <UserEmail>    |
And clicked on element 'SaveButton'
When I login with details of '<UserEmail>'
Then I 'should' see 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S17' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |

Examples:
| UserEmail     | UserRole     | UserAgency    | ProjectName   |
| U_ANPPP_S17_5 | guest.user   | DefaultAgency | P_ANPPP_S17_5 |
| U_ANPPP_S17_6 | guest.user   | AnotherAgency | P_ANPPP_S17_6 |


Scenario: User with 'element.usage_rights.write' permission can see 'Edit' link next to added usage right if project has been shared via project ownership in project
Meta:@projects
     @gdam
Given I created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And added user '<UserEmail>' into address book
And created '<ProjectName>' project
And created '/F_ANPPP_S18' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPP_S18' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_ANPPP_S18' on project '<ProjectName>' files page
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S18' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |
And I am on project '<ProjectName>' settings page
And edited the following fields for '<ProjectName>' project:
| Name          | Administrators |
| <ProjectName> | <UserEmail>    |
And clicked on element 'SaveButton'
And refreshed the page
When I login with details of '<UserEmail>'
Then I 'should' see Edit link next to 'Other usage' usage rule on file 'Fish Ad.mov' and folder '/F_ANPPP_S18' and project '<ProjectName>' Usage Rights page

Examples:
| UserEmail     | UserRole     | UserAgency    | ProjectName   |
| U_ANPPP_S18_3 | agency.user  | DefaultAgency | P_ANPPP_S18_3 |
| U_ANPPP_S18_4 | agency.user  | AnotherAgency | P_ANPPP_S18_4 |
| U_ANPPP_S18_5 | guest.user   | DefaultAgency | P_ANPPP_S18_5 |
| U_ANPPP_S18_6 | guest.user   | AnotherAgency | P_ANPPP_S18_6 |


Scenario: Check that new usage right can be added by user with different global roles if project has been shared via project ownership in project
Meta:@projects
     @gdam
Given I created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And added user '<UserEmail>' into address book
And created '<ProjectName>' project
And created '/F_ANPPP_S19' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPP_S19' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_ANPPP_S19' on project '<ProjectName>' files page
And I am on project '<ProjectName>' settings page
And edited the following fields for '<ProjectName>' project:
| Name          | Administrators |
| <ProjectName> | <UserEmail>    |
And clicked on element 'SaveButton'
And waited for '3' seconds
When I login with details of '<UserEmail>'
And add 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S19' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |
And refresh the page
Then I 'should' see 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S19' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |

Examples:
| UserEmail     | UserRole     | UserAgency    | ProjectName   |
| U_ANPPP_S19_5 | guest.user   | DefaultAgency | P_ANPPP_S19_5 |
| U_ANPPP_S19_6 | guest.user   | AnotherAgency | P_ANPPP_S19_6 |


Scenario: Check that usage right can be edited by user with different global roles if project has been shared via project ownership in project
Meta:@projects
     @gdam
Given I created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And added user '<UserEmail>' into address book
And created '<ProjectName>' project
And created '/F_ANPPP_S20' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPP_S20' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_ANPPP_S20' on project '<ProjectName>' files page
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S20' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |
And I am on project '<ProjectName>' settings page
And edited the following fields for '<ProjectName>' project:
| Name          | Administrators |
| <ProjectName> | <UserEmail>    |
And clicked on element 'SaveButton'
And waited for '3' seconds
When I login with details of '<UserEmail>'
And edit entry of 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S20' and project '<ProjectName>' Usage Rights page:
| EntryNumber | Comment              |
| 1           | updated test comment |
And refresh the page
Then I 'should' see 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S20' and project '<ProjectName>' Usage Rights page:
| Comment              |
| updated test comment |

Examples:
| UserEmail     | UserRole     | UserAgency    | ProjectName   |
| U_ANPPP_S20_5 | guest.user   | DefaultAgency | P_ANPPP_S20_5 |
| U_ANPPP_S20_6 | guest.user   | AnotherAgency | P_ANPPP_S20_6 |


Scenario: Check that usage right can be deleted by user with different global roles if project has been shared via project ownership in project
Meta:@projects
     @gdam
Given I created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And added user '<UserEmail>' into address book
And created '<ProjectName>' project
And created '/F_ANPPP_S21' folder for project '<ProjectName>'
And uploaded '/files/Fish Ad.mov' file into '/F_ANPPP_S21' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_ANPPP_S21' on project '<ProjectName>' files page
And added 'Other usage' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_ANPPP_S21' and project '<ProjectName>' Usage Rights page:
| Comment      |
| test comment |
And I am on project '<ProjectName>' settings page
And edited the following fields for '<ProjectName>' project:
| Name          | Administrators |
| <ProjectName> | <UserEmail>    |
And clicked on element 'SaveButton'
And waited for '3' seconds
When I login with details of '<UserEmail>'
And remove '1' entry of 'Other usage' usage rule on file 'Fish Ad.mov' and folder '/F_ANPPP_S21' and project '<ProjectName>' Usage Rights page
And refresh the page
Then I 'should not' see 'Other usage' usage rule on file 'Fish Ad.mov' and folder '/F_ANPPP_S21' and project '<ProjectName>' Usage Rights page

Examples:
| UserEmail     | UserRole     | UserAgency    | ProjectName   |
| U_ANPPP_S21_5 | guest.user   | DefaultAgency | P_ANPPP_S21_5 |
| U_ANPPP_S21_6 | guest.user   | AnotherAgency | P_ANPPP_S21_6 |