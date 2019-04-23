Feature:          Project and Template - Team ACL - Add Team template
Narrative:
In order to
As a              AgencyAdmin
I want to         Check acl in template and projects for share team template

Meta:
@component project

Scenario: Check that shared folder is visible for share Team template
Meta:@gdam
@projects
Given I created '<ProjectRole>' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email       | Agency       | Role        |
| <UserEmail> | <UserAgency> | agency.user |
And added following users to address book:
| UserName    |
| <UserEmail> |
And waited for '3' seconds
And added following users to team template '<TeamTemplateName>':
| UserName    |
| <UserEmail> |
And created '<ProjectName>' project
And created '/PF_PTTAT_S01' folder for project '<ProjectName>'
And uploaded into project '<ProjectName>' following files:
| FileName           | Path          |
| /files/Fish Ad.mov | /PF_PTTAT_S01 |
| /files/Fish-Ad.mov | /PF_PTTAT_S01 |
When I go to project '<ProjectName>' teams page
And add team template '<TeamTemplateName>' into project '<ProjectName>' team for folders on popup:
| Folder        | Roles         | Expire     |
| /PF_PTTAT_S01 | <ProjectRole> | 12.12.2021 |
And login with details of '<UserEmail>'
And wait for '5' seconds
Then I should see following files inside '/PF_PTTAT_S01' folder for '<ProjectName>' project:
| FileName    | FilesCount |
| Fish Ad.mov | 1          |
| Fish-Ad.mov | 1          |

Examples:
| UserEmail     | UserAgency    | ProjectRole    | ProjectName   | TeamTemplateName |
| U_PTTAT_S01_1 | DefaultAgency | PR_PTTAT_S01_1 | P_PTTAT_S01_1 | TT_PTTAT_S01_1   |
| U_PTTAT_S01_2 | AnotherAgency | PR_PTTAT_S01_2 | P_PTTAT_S01_2 | PT_PTTAT_S01_2   |


Scenario: Check that after share several folders all visible for share Team template
Meta:@gdam
@projects
Given I created '<ProjectRole>' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email       | Agency       | Role        |
| <UserEmail> | <UserAgency> | agency.user |
And added following users to address book:
| UserName    |
| <UserEmail> |
And waited for '3' seconds
And added following users to team template '<TeamTemplateName>':
| UserName    |
| <UserEmail> |
And created '<ProjectName>' project
And created in '<ProjectName>' project next folders:
| folder                       |
| PF_PTTAT_S03_1               |
| PF_PTTAT_S03_2               |
| PF_PTTAT_S03_3/PSF_PTTAT_S03 |
And uploaded into project '<ProjectName>' following files:
| FileName           | Path            |
| /files/Fish Ad.mov | /PF_PTTAT_S03_1 |
| /files/Fish-Ad.mov | /PF_PTTAT_S03_1 |
When I go to project '<ProjectName>' teams page
And add team template '<TeamTemplateName>' into project '<ProjectName>' team for folders on popup:
| Folder                         | Roles         | Expire     |
| /PF_PTTAT_S03_1                | <ProjectRole> | 12.12.2021 |
| /PF_PTTAT_S03_2                | <ProjectRole> | 12.12.2021 |
| /PF_PTTAT_S03_3/PSF_PTTAT_S03  | <ProjectRole> | 12.12.2021 |
| /PF_PTTAT_S03_3                | <ProjectRole> | 12.12.2021 |
And login with details of '<UserEmail>'
Then I should see following files inside '/PF_PTTAT_S03_1' folder for '<ProjectName>' project:
| FileName    | FilesCount |
| Fish Ad.mov | 1          |
| Fish-Ad.mov | 1          |
And 'should' see following folders in '<ProjectName>' project:
| folder                       |
| PF_PTTAT_S03_1               |
| PF_PTTAT_S03_2               |
| PF_PTTAT_S03_3/PSF_PTTAT_S03 |

Examples:
| UserEmail     | UserAgency    | ProjectRole    | ProjectName   | TeamTemplateName |
| U_PTTAT_S03_1 | DefaultAgency | PR_PTTAT_S03_1 | P_PTTAT_S03_1 | TT_PTTAT_S03_1   |
| U_PTTAT_S03_2 | AnotherAgency | PR_PTTAT_S03_2 | P_PTTAT_S03_2 | TT_PTTAT_S03_2   |


Scenario: Check that after delete Team template from share, folder disappears for share user
Meta:@gdam
@projects
Given I created '<ProjectRole>' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email       | Agency       | Role        |
| <UserEmail> | <UserAgency> | agency.user |
And added following users to address book:
| UserName    |
| <UserEmail> |
And added following users to team template '<TeamTemplateName>':
| UserName    |
| <UserEmail> |
And created '<ProjectName>' project
And created '/PF_PTTAT_S05' folder for project '<ProjectName>'
When I go to project '<ProjectName>' teams page
And add team template '<TeamTemplateName>' into project '<ProjectName>' team for folders on popup:
| Folder        | Roles         | Expire     |
| /PF_PTTAT_S05 | <ProjectRole> | 12.12.2021 |
And wait for '3' seconds
And remove user '<UserEmail>' from project '<ProjectName>' team page
And login with details of '<UserEmail>'
Then I 'should not' see project '<ProjectName>' on project list page

Examples:
| UserEmail     | UserAgency    | ProjectRole    | ProjectName   | TeamTemplateName |
| U_PTTAT_S05_1 | DefaultAgency | PR_PTTAT_S05_1 | P_PTTAT_S05_1 | TT_PTTAT_S05_1   |
| U_PTTAT_S05_2 | AnotherAgency | PR_PTTAT_S05_2 | P_PTTAT_S05_2 | PT_PTTAT_S05_2   |


Scenario: Check if share date is expire, folder disappears for share user
Meta:@gdam
!-- 31/07/2015-Confirmed with Maria that this scenario is no longer valid as its a date picker and user shouldnt be allowed to enter a old date
Meta: @skip
Given I created '<ProjectRole>' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email       | Agency       | Role        |
| <UserEmail> | <UserAgency> | agency.user |
And added following users to address book:
| UserName    |
| <UserEmail> |
And added following users to team template '<TeamTemplateName>':
| UserName    |
| <UserEmail> |
And created '<ProjectName>' project
And created '/PF_PTTAT_S07' folder for project '<ProjectName>'
And added team template '<TeamTemplateName>' to project '<ProjectName>' team folders '/PF_PTTAT_S07' with role '<ProjectRole>' expired '11.11.2011'
When wait for '60' seconds
And I login with details of '<UserEmail>'
Then I 'should not' see project '<ProjectName>' on project list page

Examples:
| UserEmail     | UserAgency    | ProjectRole    | ProjectName   | TeamTemplateName |
| U_PTTAT_S07_1 | DefaultAgency | PR_PTTAT_S07_1 | P_PTTAT_S07_1 | TT_PTTAT_S07_1   |
| U_PTTAT_S07_2 | AnotherAgency | PR_PTTAT_S07_2 | P_PTTAT_S07_2 | TT_PTTAT_S07_2   |
