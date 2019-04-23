Feature:          Visibility of Delete Project and Create template from Project
Narrative:
In order to
As a              GlobalAdmin
I want to         visibility of Delete Project

Lifecycle:
Before:
Given I created the following agency:
| Name         | A4User        | Country        |
| DPACTBOP_A01 | DefaultA4User | United Kingdom |
| DPACTBOP_A02 | DefaultA4User | United Kingdom |
And created 'agency_user_copy' role in 'global' group for advertiser 'DPACTBOP_A01' with following permissions:
| Permission           |
| adkit.create                 |
| project_template.read        |
| project_template.write          |
| agency_team.read         |
| asset.create   |
| asset_filter_collection.create |
| asset_filter_collection_break.create |
| dictionary.read |
| enum.create  |
| enum.read |
| enum.write |
| group.agency_enums.read |
| presentation.create |
| project.create |
| project_template.create |
| user.invite |
| user.read |
| user_group.read |
And created 'project_admin_copy' role in 'project' group for advertiser 'DPACTBOP_A01' with following permissions:
| Permission           |
| activity.read        |
| adkit.complete       |
| adkit.read           |
| adkit.write          |
| adkit_template.read  |
| adkit_template.write |
| approval.admin       |
| approval.create      |
| attached_file.create |
| attached_file.delete |
| attached_file.read   |
| comment.create       |
| comment.delete       |
| comment.read         |
| element.copy         |
| element.create       |
| element.delete       |
| element.move         |
| element.read         |
| element.related_files.create |
| element.related_files.delete |
| element.related_files.read   |
| element.send_to_library      |
| element.usage_rights.read    |
| element.usage_rights.write   |
| element.version_history.read |
| element.write                |
| file.download                |
| folder.copy                  |
| folder.create                |
| folder.delete                |
| folder.move                  |
| folder.read                  |
| folder.share                 |
| folder.write                 |
| project.activity             |
| project.read                 |
| project.settings.read        |
| project.write                |
| project_team.read            |
| project.team.write           |
| project_template.read        |
| project_template.write       |
| proxy.download               |
And created 'custom_agency_admin_copy' role in 'global' group for advertiser 'DPACTBOP_A01' with following permissions:
| Permission            |
| acl.change            |
| adkit-complete        |
| adkit.read            |
| adkit.write           |
| adkit_template.write  |
| folder.create         |
| folder.delete         |
| folder.move           |
| folder.read           |
| folder.share          |
| folder.write          |
| group.agency_enums.create |
| group.agency_enums.delete |
| group.agency_enums.read   |
| group.agency_enums.write  |
| head.read                 |
| inbox.read                |
| market.custom.edit        |
| notifications.read        |
| presentation.create       |
| presentation.delete       |
| presentation.public_share.create |
| presentation.public_share.write  |
| presentation.read                |
| presentation.write               |
| print_order.create               |
| print_order.delete               |
| print_order.read                 |
| print_order.write                |
| project.create                   |
| project.read                     |
| project.settings.read            |
| project.write                    |
| project_team.delete              |
| project_team.read                |
| project_team.write               |
| project_template.read            |
| project_template.write           |
| proxy.download                   |
| role.create                      |
| role.delete                      |
| role.read                        |
| role.write                       |
| schema.create                    |
| schema.delete                    |
| schema.edit                      |
| schema.write                     |
| trash.read                       |
| trash.undelete                   |
| user.create                      |
| user.delete                      |
| user.invite                      |
| user.read                        |
| user.write                       |
| user_group.create                |
| user_group.delete                |
| user_group.read                  |
| user_group.write                 |
| users.create                     |
| users.delete                     |
| users.read                       |
| users.write                      |
And I created users with following fields:
| Email              | Role               | AgencyUnique           |
| U1_DPACTBOP_A01    | agency.admin       | DPACTBOP_A01           |
| U2_DPACTBOP_A02    | agency.admin       | DPACTBOP_A02           |

Scenario: Check Delete Project and create template links for user with Project admin role for Projects
Meta: @gdam
@projects
Given I logged in with details of 'U1_DPACTBOP_A01'
And I created 'P_DPACTBOP_1' project
And I added users 'U2_DPACTBOP_A02' to project 'P_DPACTBOP_1' team folders '/' with role 'project_admin_copy' expired '12.12.2021' and 'true' access to subfolders
And I logged in with details of 'U2_DPACTBOP_A02'
When I go to project 'P_DPACTBOP_1' overview page
Then I 'should not' see delete project link on project 'P_DPACTBOP_1' overview page
Then I 'should not' see Create template from project link on project 'P_DPACTBOP_1' overview page

Scenario: Check Delete Project and Create Template links for user with multiple roles - Agency Admin and Project Contributor For Projects
Meta: @gdam
@projects
Given I created users with following fields:
| Email              | Role          | AgencyUnique           |
| U3_DPACTBOP_A02    | agency.user   | DPACTBOP_A02           |
And I logged in with details of 'U1_DPACTBOP_A01'
And added existing user 'U3_DPACTBOP_A02' to agency 'DPACTBOP_A01' with role 'agency.admin'
And I created 'P_DPACTBOP_2' project
And I added users 'U3_DPACTBOP_A02' to project 'P_DPACTBOP_2' team folders '/' with role 'project.contributor' expired '12.12.2021' and 'true' access to subfolders
And I logged in with details of 'U3_DPACTBOP_A02'
When I go to project 'P_DPACTBOP_2' overview page
Then I 'should' see delete project link on project 'P_DPACTBOP_2' overview page
And I 'should' see Create template from project link on project 'P_DPACTBOP_2' overview page
When I click create template from project for project 'P_DPACTBOP_2'
And I specify template name 'Temp_P_DPACTBOP_2' on create template page
And click on element 'SaveButton'
And I wait for '2' seconds
Then I should see message warning 'Changes saved successfully'
When I go to template list page
Then I 'should' see template 'Temp_P_DPACTBOP_2' on template list page
When I go to project 'P_DPACTBOP_2' overview page
And I clicked on Delete project on overview page
And click element 'Delete' on page 'DeletePopUp'
And I wait for '2' seconds
Then I shouldn't see 'P_DPACTBOP_2' project in project list


Scenario: Check Delete Project and Create Template links for user with customAgencyAdmin and Project Contributor roles for Projects
Meta: @gdam
@projects
Given I created users with following fields:
| Email              | Role          | AgencyUnique        |
| U4_DPACTBOP_A02    | agency.user   | DPACTBOP_A02        |
And I logged in with details of 'U1_DPACTBOP_A01'
And added existing user 'U4_DPACTBOP_A02' to agency 'DPACTBOP_A01' with custom role 'custom_agency_admin_copy'
And I created 'P_DPACTBOP_3' project
And I added users 'U4_DPACTBOP_A02' to project 'P_DPACTBOP_3' team folders '/' with role 'project.contributor' expired '12.12.2021' and 'true' access to subfolders
And I logged in with details of 'U4_DPACTBOP_A02'
When I go to project 'P_DPACTBOP_3' overview page
Then I 'should not' see delete project link on project 'P_DPACTBOP_3' overview page
Then I 'should not' see Create template from project link on project 'P_DPACTBOP_3' overview page

Scenario: Check Delete Project and Create Template links for user with Project Admin role for Work Requests
Meta: @gdam
@projects
Given I logged in with details of 'U1_DPACTBOP_A01'
And created 'WR_DPACTBOP_4' work request
And added users 'U2_DPACTBOP_A02' to work request 'WR_DPACTBOP_4' team with role 'project_admin_copy' expired '02.02.2020'
And I logged in with details of 'U2_DPACTBOP_A02'
When I go to work request 'WR_DPACTBOP_4' overview page
Then I 'should not' see the link 'Delete project' on work request 'WR_DPACTBOP_4' overview page
And I 'should not' see the link 'Create template from project' on work request 'WR_DPACTBOP_4' overview page

Scenario: Check Delete Project and Create Template links for user with multiple roles - AgencyAdmin and Project Admin for Work Requests
Meta: @gdam
@projects
Given I created users with following fields:
| Email              | Role            | AgencyUnique           |
| U5_DPACTBOP_A02    | agency.user     | DPACTBOP_A02           |
And I logged in with details of 'U1_DPACTBOP_A01'
And added existing user 'U5_DPACTBOP_A02' to agency 'DPACTBOP_A01' with role 'agency.admin'
And created 'WR_DPACTBOP_5' work request
And added users 'U5_DPACTBOP_A02' to work request 'WR_DPACTBOP_5' team with role 'project.contributor' expired '02.02.2020'
And I logged in with details of 'U5_DPACTBOP_A02'
When I go to work request 'WR_DPACTBOP_5' overview page
Then I 'should' see the link 'Delete project' on work request 'WR_DPACTBOP_5' overview page
And I 'should' see the link 'Create template from project' on work request 'WR_DPACTBOP_5' overview page
When I click create template from project for Work Request 'WR_DPACTBOP_5'
And I specify template name 'Temp_P_DPACTBOP_5' on create template page
And click on element 'SaveButton'
Then I should see message warning 'Changes saved successfully'
And I wait for '2' seconds
When I go to Work Request template list page
Then I should see 'Temp_P_DPACTBOP_5' work request template in work request template list
When I go to work request 'WR_DPACTBOP_5' overview page
And I clicked on Delete project on Work Request overview page
And click element 'Delete' on page 'DeletePopUp'
And I wait for '2' seconds
Then I shouldn't see 'P_DPACTBOP_5' work request in work request list


Scenario: Check Delete Project and Create Template links for user with customAgencyAdmin and Project Contributor roles for Work Requests
Meta: @gdam
@projects
Given I created users with following fields:
| Email              | Role             | AgencyUnique        |
| U6_DPACTBOP_A02    | agency.user      | DPACTBOP_A02        |
And I logged in with details of 'U1_DPACTBOP_A01'
And added existing user 'U6_DPACTBOP_A02' to agency 'DPACTBOP_A01' with custom role 'custom_agency_admin_copy'
And created 'WR_DPACTBOP_6' work request
And added users 'U6_DPACTBOP_A02' to work request 'WR_DPACTBOP_6' team with role 'project.contributor' expired '02.02.2020'
And I logged in with details of 'U6_DPACTBOP_A02'
When I go to work request 'WR_DPACTBOP_6' overview page
Then I 'should not' see the link 'Delete project' on work request 'WR_DPACTBOP_6' overview page
And I 'should not' see the link 'Create template from project' on work request 'WR_DPACTBOP_6' overview page

Scenario: Check Delete Template links for user with Project Admin role for Project Templates
Meta: @gdam
@projects
Given I created users with following fields:
| Email              | Role                  | AgencyUnique           |
| U7_DPACTBOP_A02    | agency.user           | DPACTBOP_A02           |
And added existing user 'U7_DPACTBOP_A02' to agency 'DPACTBOP_A01' with custom role 'agency_user_copy'
And I logged in with details of 'U1_DPACTBOP_A01'
And I created 'PT_DPACTBOP_7' template
And added users 'U7_DPACTBOP_A02' to template 'PT_DPACTBOP_7' team folders '/' with role 'project_admin_copy' expired '12.12.2021'
And I logged in with details of 'U7_DPACTBOP_A02'
When I go to template 'PT_DPACTBOP_7' overview page
Then I 'should not' see delete template link on template 'PT_DPACTBOP_7' overview page

Scenario: Check Delete Template link for user with multiple roles - AgencyAdmin and Project Admin for Project Templates
Meta: @gdam
@projects
Given I created users with following fields:
| Email              | Role                  | AgencyUnique        |
| U8_DPACTBOP_A02    | agency.user           | DPACTBOP_A02        |
And I logged in with details of 'U1_DPACTBOP_A01'
And added existing user 'U8_DPACTBOP_A02' to agency 'DPACTBOP_A01' with role 'agency.admin'
And I created 'PT_DPACTBOP_8' template
And added users 'U8_DPACTBOP_A02' to template 'PT_DPACTBOP_8' team folders '/' with role 'project.contributor' expired '12.12.2021'
And I logged in with details of 'U8_DPACTBOP_A02'
When I go to template 'PT_DPACTBOP_8' overview page
Then I 'should' see delete template link on template 'PT_DPACTBOP_8' overview page
When I clicked on Delete template on overview page
And click element 'Delete' on page 'DeletePopUp'
And I wait for '2' seconds
Then I 'should not' see template 'PT_DPACTBOP_8' on template list page

Scenario: Check Delete Template link for user with customAgencyAdmin and Project Contributor roles for Project Templates
Meta: @gdam
@projects
Given I created users with following fields:
| Email              | Role              | AgencyUnique           |
| U9_DPACTBOP_A02    | agency.user       | DPACTBOP_A02           |
And I logged in with details of 'U1_DPACTBOP_A01'
And added existing user 'U9_DPACTBOP_A02' to agency 'DPACTBOP_A01' with custom role 'custom_agency_admin_copy'
And I created 'PT_DPACTBOP_9' template
And added users 'U9_DPACTBOP_A02' to template 'PT_DPACTBOP_9' team folders '/' with role 'project.contributor' expired '12.12.2021'
And I logged in with details of 'U9_DPACTBOP_A02'
When I go to template 'PT_DPACTBOP_9' overview page
Then I 'should not' see delete template link on template 'PT_DPACTBOP_9' overview page

Scenario: Check Delete Template links for user with Project Admin role for Work Request Templates
Meta: @gdam
@projects
Given I created users with following fields:
| Email               | Role             | AgencyUnique           |
| U10_DPACTBOP_A02    | agency.user      | DPACTBOP_A02           |
And added existing user 'U10_DPACTBOP_A02' to agency 'DPACTBOP_A01' with custom role 'agency_user_copy'
And I logged in with details of 'U1_DPACTBOP_A01'
And I created 'WRT_DPACTBOP_10' work request template
And added users 'U10_DPACTBOP_A02' to work request template 'WRT_DPACTBOP_10' team folders '/' with role 'project_admin_copy' expired '12.12.2021'
And I logged in with details of 'U10_DPACTBOP_A02'
When I go to work request template 'WRT_DPACTBOP_10' overview page
Then I 'should not' see delete template link on work request template 'WRT_DPACTBOP_10' overview page

Scenario: Check Delete Template link for user with multiple roles - AgencyAdmin and Project Admin for Work Request Templates
Meta: @gdam
@projects
Given I created users with following fields:
| Email               | Role             | AgencyUnique           |
| U11_DPACTBOP_A02    | agency.user      | DPACTBOP_A02           |
And I logged in with details of 'U1_DPACTBOP_A01'
And added existing user 'U11_DPACTBOP_A02' to agency 'DPACTBOP_A01' with role 'agency.admin'
And I created 'WRT_DPACTBOP_11' work request template
And added users 'U11_DPACTBOP_A02' to work request template 'WRT_DPACTBOP_11' team folders '/' with role 'project.contributor' expired '12.12.2021'
And I logged in with details of 'U11_DPACTBOP_A02'
When I go to work request template 'WRT_DPACTBOP_11' overview page
Then I 'should' see delete template link on work request template 'WRT_DPACTBOP_11' overview page
When I clicked on Delete template on Work Request template overview page
And click element 'Delete' on page 'DeletePopUp'
And I wait for '2' seconds
Then I 'should not' see following work request templates 'WRT_DPACTBOP_11' in work request template list


Scenario: Check Delete Template link for user with customAgencyAdmin and Project Contributor roles for Work Request Templates
Meta: @gdam
@projects
Given I created users with following fields:
| Email               | Role               | AgencyUnique           |
| U12_DPACTBOP_A02    | agency.user        | DPACTBOP_A02           |
And I logged in with details of 'U1_DPACTBOP_A01'
And added existing user 'U12_DPACTBOP_A02' to agency 'DPACTBOP_A01' with custom role 'custom_agency_admin_copy'
And I created 'WRT_DPACTBOP_12' work request template
And added users 'U12_DPACTBOP_A02' to work request template 'WRT_DPACTBOP_12' team folders '/' with role 'project.contributor' expired '12.12.2021'
And I logged in with details of 'U12_DPACTBOP_A02'
When I go to work request template 'WRT_DPACTBOP_12' overview page
Then I 'should not' see delete template link on work request template 'WRT_DPACTBOP_12' overview page