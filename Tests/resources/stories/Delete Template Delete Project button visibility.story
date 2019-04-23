!--NGN-2625 NGN-1877
Feature:          Delete Template Delete Project button visibility
Narrative:
In order to
As a              AgencyAdmin
I want to         Check visibility of Delete Template/Delete Project button

Scenario: Check that Delete button is displayed only for agency.admin on Project List
Meta:@gdam
@projects
Given I created users with following fields:
| Email          | Role               | Agency        |
| U_DTDPBVS_S4_0 | agency.admin       | DefaultAgency |
| U_DTDPBVS_S4_1 | agency.user        | DefaultAgency |
| U_DTDPBVS_S4_2 | guest.user         | DefaultAgency |
| U_DTDPBVS_S4_3 | agency.enums.write | DefaultAgency |
| U_DTDPBVS_S4_4 | agency.enums.read  | DefaultAgency |
And I created 'PR_DTDPBVS_S4_1' role in 'project' group for advertiser 'DefaultAgency'
And I created 'P_DTDPBVS_S4_1' project
And I created 'P_DTDPBVS_S4_2' project
And I created '/F_DTDPBVS_S4_1' folder for project 'P_DTDPBVS_S4_1'
And I created '/F_DTDPBVS_S4_2' folder for project 'P_DTDPBVS_S4_2'
And I added users '<UsersName>' to project 'P_DTDPBVS_S4_1' team folders '/F_DTDPBVS_S4_1' with role 'PR_DTDPBVS_S4_1' expired '12.12.2021' and 'false' access to subfolders
And I added users '<UsersName>' to project 'P_DTDPBVS_S4_2' team folders '/F_DTDPBVS_S4_2' with role 'PR_DTDPBVS_S4_1' expired '12.12.2021' and 'false' access to subfolders
And I logged in with details of '<UsersName>'
When I go to project list page
Then I '<Should>' see delete button on projects list page

Examples:
| UsersName      | Should     |
| U_DTDPBVS_S4_0 | should     |
| U_DTDPBVS_S4_1 | should not |
| U_DTDPBVS_S4_2 | should not |
| U_DTDPBVS_S4_3 | should not |
| U_DTDPBVS_S4_4 | should not |


Scenario: Check that visibility for Delete project link for added user to folder
Meta:@gdam
@projects
Given I created users with following fields:
| Email          | Role               | Agency        |
| U_DTDPBVS_S5_0 | agency.admin       | DefaultAgency |
| U_DTDPBVS_S5_1 | agency.user        | DefaultAgency |
| U_DTDPBVS_S5_2 | guest.user         | DefaultAgency |
| U_DTDPBVS_S5_3 | agency.enums.write | DefaultAgency |
| U_DTDPBVS_S5_4 | agency.enums.read  | DefaultAgency |
| U_DTDPBVS_S5_5 | agency.admin       | AnotherAgency |
| U_DTDPBVS_S5_6 | agency.user        | AnotherAgency |
| U_DTDPBVS_S5_7 | guest.user         | AnotherAgency |
And I created 'PR_DTDPBVS_S5_1' role with 'project.read,project.settings.read,project_template.read,folder.read' permissions in 'project' group for advertiser 'DefaultAgency'
And I created 'P_DTDPBVS_S5_1' project
And I created '/F_DTDPBVS_S5_1' folder for project 'P_DTDPBVS_S5_1'
And I added users '<UsersName>' to project 'P_DTDPBVS_S5_1' team folders '/' with role 'PR_DTDPBVS_S5_1' expired '12.12.2021' and 'false' access to subfolders
And I logged in with details of '<UsersName>'
And waited for '2' seconds
When I go to project 'P_DTDPBVS_S5_1' overview page
Then I '<Should>' see delete project link on project 'P_DTDPBVS_S5_1' overview page

Examples:
| UsersName      | Should     |
| U_DTDPBVS_S5_0 | should     |
| U_DTDPBVS_S5_1 | should not |
| U_DTDPBVS_S5_2 | should not |
| U_DTDPBVS_S5_3 | should not |
| U_DTDPBVS_S5_4 | should not |
| U_DTDPBVS_S5_6 | should not |
| U_DTDPBVS_S5_7 | should not |

Scenario: Check that visibility for Delete project link for added user to folder
Meta:@gdam
     @bug
     @projects
!--FAB-743 (Bug)
Given I created users with following fields:
| Email          | Role               | Agency        |
| U_DTDPBVS_S5_5 | agency.admin       | AnotherAgency |
And I created 'PR_DTDPBVS_S5_1' role with 'project.read,project.settings.read,project_template.read,folder.read' permissions in 'project' group for advertiser 'DefaultAgency'
And I created 'P_DTDPBVS_S5_1' project
And I created '/F_DTDPBVS_S5_1' folder for project 'P_DTDPBVS_S5_1'
And I added users '<UsersName>' to project 'P_DTDPBVS_S5_1' team folders '/' with role 'PR_DTDPBVS_S5_1' expired '12.12.2021' and 'false' access to subfolders
And I logged in with details of '<UsersName>'
And waited for '2' seconds
When I go to project 'P_DTDPBVS_S5_1' overview page
Then I '<Should>' see delete project link on project 'P_DTDPBVS_S5_1' overview page

Examples:
| UsersName      | Should     |
| U_DTDPBVS_S5_5 | should not |

Scenario: Check that visibility for Delete project link for project owners
Meta:@gdam
@projects
Given I created users with following fields:
| Email          | Role               | Agency        |
| U_DTDPBVS_S6_0 | agency.admin       | DefaultAgency |
| U_DTDPBVS_S6_1 | agency.user        | DefaultAgency |
| U_DTDPBVS_S6_2 | guest.user         | DefaultAgency |
| U_DTDPBVS_S6_3 | agency.enums.write | DefaultAgency |
| U_DTDPBVS_S6_4 | agency.enums.read  | DefaultAgency |
| U_DTDPBVS_S6_5 | agency.admin       | AnotherAgency |
| U_DTDPBVS_S6_6 | agency.user        | AnotherAgency |
And I added following users to address book:
| UserName       |
| U_DTDPBVS_S6_5 |
| U_DTDPBVS_S6_6 |
And I created following projects:
| Name           | Administrators |
| <Project>      | <Admin> |
And I logged in with details of '<Admin>'
And waited for '5' seconds
When I go to project '<Project>' overview page
Then I '<Should>' see delete project link on project '<Project>' overview page

Examples:
| Project        | Admin          | Should     |
| P_DTDPBVS_S6_0 | U_DTDPBVS_S6_0 | should     |
| P_DTDPBVS_S6_1 | U_DTDPBVS_S6_1 | should     |
| P_DTDPBVS_S6_2 | U_DTDPBVS_S6_2 | should     |
| P_DTDPBVS_S6_3 | U_DTDPBVS_S6_3 | should     |
| P_DTDPBVS_S6_4 | U_DTDPBVS_S6_4 | should     |

Scenario: Check that visibility for Delete project link for project owners
Meta:@gdam
@bug
@projects
!--FAB-743 (Bug)
Given I created users with following fields:
| Email          | Role               | Agency        |
| U_DTDPBVS_S6_5 | agency.admin       | AnotherAgency |
| U_DTDPBVS_S6_6 | agency.user        | AnotherAgency |
And I added following users to address book:
| UserName       |
| U_DTDPBVS_S6_5 |
| U_DTDPBVS_S6_6 |
And I created following projects:
| Name           | Administrators |
| <Project>      | <Admin> |
And I logged in with details of '<Admin>'
And waited for '5' seconds
When I go to project '<Project>' overview page
Then I '<Should>' see delete project link on project '<Project>' overview page

Examples:
| Project        | Admin          | Should     |
| P_DTDPBVS_S6_5 | U_DTDPBVS_S6_5 | should not |
| P_DTDPBVS_S6_6 | U_DTDPBVS_S6_6 | should not |
