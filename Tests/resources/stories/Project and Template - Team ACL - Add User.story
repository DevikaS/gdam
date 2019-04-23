Feature:          Project and Template - Team ACL - Add User
Narrative:
In order to
As a              AgencyAdmin
I want to         Check acl in template and projects for share user

Meta:
@component project

Scenario: Check that shared folder is visible for share user
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @projects
Given I created '<ProjectRole>' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email       | Agency       | Role       |
| <UserEmail> | <UserAgency> | <UserType> |
And created '<ProjectName>' project
And created '/PF_PTTAU_S01' folder for project '<ProjectName>'
And uploaded into project '<ProjectName>' following files:
| FileName           | Path          |
| /files/Fish Ad.mov | /PF_PTTAU_S01 |
| /files/Fish-Ad.mov | /PF_PTTAU_S01 |
And waited while preview is available in folder '/PF_PTTAU_S01' on project '<ProjectName>' files page
When I go to project '<ProjectName>' teams page
And add user '<UserEmail>' into project '<ProjectName>' team with role '<ProjectRole>' expired '12.12.2021' for folder on popup '/PF_PTTAU_S01'
And login with details of '<UserEmail>'
And go to project '<ProjectName>' folder '/PF_PTTAU_S01' page
Then I should see following files inside '/PF_PTTAU_S01' folder for '<ProjectName>' project:
| FileName    | FilesCount |
| Fish Ad.mov | 1          |
| Fish-Ad.mov | 1          |

Examples:
| UserEmail     | UserAgency    | UserType    | ProjectRole    | ProjectName   |
| U_PTTAU_S01_1 | DefaultAgency | agency.user | PR_PTTAU_S01_1 | P_PTTAU_S01_1 |
| U_PTTAU_S01_2 | AnotherAgency | agency.user | PR_PTTAU_S01_2 | P_PTTAU_S01_2 |
| U_PTTAU_S01_3 | DefaultAgency | guest.user  | PR_PTTAU_S01_3 | P_PTTAU_S01_3 |


Scenario: Check that shared folder is visible for easyshare user
Meta:@gdam
@projects
Given I created 'PR_PTTAU_SEU01' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created 'P_PTTAU_SEU01' project
And created '/PF_PTTAU_SEU01' folder for project 'P_PTTAU_SEU01'
And uploaded into project 'P_PTTAU_SEU01' following files:
| FileName           | Path            |
| /files/Fish Ad.mov | /PF_PTTAU_SEU01 |
| /files/Fish-Ad.mov | /PF_PTTAU_SEU01 |
And waited while preview is available in folder '/PF_PTTAU_SEU01' on project 'P_PTTAU_SEU01' files page
When I go to project 'P_PTTAU_SEU01' teams page
And add user 'ESU_PTTAU_SEU01' into project 'P_PTTAU_SEU01' team with role 'PR_PTTAU_SEU01' expired '12.12.2021' for folder on popup '/PF_PTTAU_SEU01'
And logout from account
And open link from email when user 'ESU_PTTAU_SEU01' received email with next subject 'You have been invited'
And accept new user with first name 'Firstname' and last name 'Lastname'
And go to project 'P_PTTAU_SEU01' folder '/PF_PTTAU_SEU01' page
Then I should see following files inside '/PF_PTTAU_SEU01' folder for 'P_PTTAU_SEU01' project:
| FileName    | FilesCount |
| Fish Ad.mov | 1          |
| Fish-Ad.mov | 1          |


Scenario: Check that after share several folders all visible for share user
Meta:@gdam
@projects
Given I created '<ProjectRole>' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| Email       | Agency       | Role        |
| <UserEmail> | <UserAgency> | agency.user |
And created '<ProjectName>' project
And created in '<ProjectName>' project next folders:
| folder                         |
| PF_PTTAU_S02_1                 |
| PF_PTTAU_S02_2                 |
| PF_PTTAU_S02_3/PSF_PTTAU_S02_1 |
And uploaded into project '<ProjectName>' following files:
| FileName           | Path            |
| /files/Fish Ad.mov | /PF_PTTAU_S02_1 |
| /files/Fish-Ad.mov | /PF_PTTAU_S02_1 |
And waited while preview is available in folder '/PF_PTTAU_S02_1' on project '<ProjectName>' files page
When I go to project '<ProjectName>' teams page
And add user '<UserEmail>' into project '<ProjectName>' team with role '<ProjectRole>' expired '12.12.2021' for folder on popup '/PF_PTTAU_S02_1,/PF_PTTAU_S02_2,/PF_PTTAU_S02_3,/PF_PTTAU_S02_3/PSF_PTTAU_S02_1'
And login with details of '<UserEmail>'
And go to project '<ProjectName>' folder '/PF_PTTAU_S02_1' page
Then I should see following files inside '/PF_PTTAU_S02_1' folder for '<ProjectName>' project:
| FileName    | FilesCount |
| Fish Ad.mov | 1          |
| Fish-Ad.mov | 1          |
And 'should' see following folders in '<ProjectName>' project:
| folder                         |
| PF_PTTAU_S02_1                 |
| PF_PTTAU_S02_2                 |
| PF_PTTAU_S02_3/PSF_PTTAU_S02_1 |

Examples:
| UserEmail     | UserAgency    | ProjectRole    | ProjectName   |
| U_PTTAU_S02_1 | DefaultAgency | PR_PTTAU_S02_1 | P_PTTAU_S02_1 |
| U_PTTAU_S02_2 | AnotherAgency | PR_PTTAU_S02_2 | P_PTTAU_S02_2 |


Scenario: Check that after share several folders all visible for easyshare user
Meta:@gdam
@projects
Given I created 'PR_PTTAU_SEU02' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created 'P_PTTAU_SEU02' project
And created in 'P_PTTAU_SEU02' project next folders:
| folder                             |
| PF_PTTAU_SEU02_1                   |
| PF_PTTAU_SEU02_2                   |
| PF_PTTAU_SEU02_3/PSF_PTTAU_SEU02_1 |
And uploaded into project 'P_PTTAU_SEU02' following files:
| FileName           | Path              |
| /files/Fish Ad.mov | /PF_PTTAU_SEU02_1 |
| /files/Fish-Ad.mov | /PF_PTTAU_SEU02_1 |
And waited while preview is available in folder '/PF_PTTAU_SEU02_1' on project 'P_PTTAU_SEU02' files page
When I go to project 'P_PTTAU_SEU02' teams page
And add user 'ESU_PTTAU_SEU02' into project 'P_PTTAU_SEU02' team with role 'PR_PTTAU_SEU02' expired '12.12.2021' for folder on popup '/PF_PTTAU_SEU02_1,/PF_PTTAU_SEU02_2,/PF_PTTAU_SEU02_3,/PF_PTTAU_SEU02_3/PSF_PTTAU_SEU02_1'
And logout from account
And open link from email when user 'ESU_PTTAU_SEU02' received email with next subject 'You have been invited'
And accept new user with first name 'Firstname' and last name 'Lastname'
And go to project 'P_PTTAU_SEU02' folder '/PF_PTTAU_SEU02_1' page
Then I should see following files inside '/PF_PTTAU_SEU02_1' folder for 'P_PTTAU_SEU02' project:
| FileName    | FilesCount |
| Fish Ad.mov | 1          |
| Fish-Ad.mov | 1          |
And 'should' see following folders in 'P_PTTAU_SEU02' project:
| folder                             |
| PF_PTTAU_SEU02_1                   |
| PF_PTTAU_SEU02_2                   |
| PF_PTTAU_SEU02_3/PSF_PTTAU_SEU02_1 |


Scenario: Check that after delete user from share, folder disappears for share user
Meta:@gdam
@projects
Given I created '<ProjectRole>' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| Email       | Agency       | Role       |
| <UserEmail> | <UserAgency> | <UserType> |
And created '<ProjectName>' project
And created '/PF_PTTAU_S03' folder for project '<ProjectName>'
And uploaded into project '<ProjectName>' following files:
| FileName           | Path          |
| /files/Fish Ad.mov | /PF_PTTAU_S03 |
When I go to project '<ProjectName>' teams page
And add user '<UserEmail>' into project '<ProjectName>' team with role '<ProjectRole>' expired '12.12.2021' for folder on popup '/PF_PTTAU_S03'
And remove user '<UserEmail>' from project '<ProjectName>' team page
And login with details of '<UserEmail>'
Then I 'should not' see project '<ProjectName>' on project list page

Examples:
| UserEmail     | UserAgency    | UserType    | ProjectRole    | ProjectName   |
| U_PTTAU_S03_1 | DefaultAgency | agency.user | PR_PTTAU_S03_1 | P_PTTAU_S03_1 |
| U_PTTAU_S03_2 | AnotherAgency | agency.user | PR_PTTAU_S03_2 | P_PTTAU_S03_2 |
| U_PTTAU_S03_3 | DefaultAgency | guest.user  | PR_PTTAU_S03_3 | P_PTTAU_S03_3 |


Scenario: Check that after delete user from share, folder disappears for easyshare user
Meta:@gdam
@projects
Given I created 'PR_PTTAU_SEU03' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created 'P_PTTAU_SEU03' project
And created '/PF_PTTAU_SEU03' folder for project 'P_PTTAU_SEU03'
And uploaded into project 'P_PTTAU_SEU03' following files:
| FileName           | Path            |
| /files/Fish Ad.mov | /PF_PTTAU_SEU03 |
When I go to project 'P_PTTAU_SEU03' teams page
And add user 'ESU_PTTAU_SEU03' into project 'P_PTTAU_SEU03' team with role 'PR_PTTAU_SEU03' expired '12.12.2021' for folder on popup '/PF_PTTAU_SEU03'
And remove easyshare user 'ESU_PTTAU_SEU03' from project 'P_PTTAU_SEU03' team page
And logout from account
And open link from email when user 'ESU_PTTAU_SEU03' received email with next subject 'You have been Invited'
And accept new user with first name 'Firstname' and last name 'Lastname'
Then I 'should not' see project 'P_PTTAU_SEU03' on project list page


Scenario: Check that user cannot get shared folder using direct URL if sharing for him has been removed
Meta:@gdam
@gdamemails
Given I created '<ProjectRole>' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| Email       | Agency       | Role       |
| <UserEmail> | <UserAgency> | <UserType> |
And created '<ProjectName>' project
And created '/PF_PTTAU_S04' folder for project '<ProjectName>'
And uploaded into project '<ProjectName>' following files:
| FileName           | Path          |
| /files/Fish Ad.mov | /PF_PTTAU_S04 |
When I go to project '<ProjectName>' teams page
And add user '<UserEmail>' into project '<ProjectName>' team with role '<ProjectRole>' expired '12.12.2021' for folder on popup '/PF_PTTAU_S04'
And remove user '<UserEmail>' from project '<ProjectName>' team page
And login with details of '<UserEmail>'
And open link from email when user '<UserEmail>' received email with next subject 'Folders have been shared with'
Then I 'should' see empty page

Examples:
| UserEmail     | UserAgency    | UserType    | ProjectRole    | ProjectName   |
| U_PTTAU_S04_1 | DefaultAgency | agency.user | PR_PTTAU_S04_1 | P_PTTAU_S04_1 |
| U_PTTAU_S04_2 | AnotherAgency | agency.user | PR_PTTAU_S04_2 | P_PTTAU_S04_2 |
| U_PTTAU_S04_3 | DefaultAgency | guest.user  | PR_PTTAU_S04_3 | P_PTTAU_S04_3 |


Scenario: Check that easyshare user cannot get shared folder using direct URL if sharing for him has been removed
Meta:@gdam
@gdamemails
Given I created 'PR_PTTAU_SEU04' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created 'P_PTTAU_SEU04' project
And created '/PF_PTTAU_SEU04' folder for project 'P_PTTAU_SEU04'
And uploaded into project 'P_PTTAU_SEU04' following files:
| FileName           | Path            |
| /files/Fish Ad.mov | /PF_PTTAU_SEU04 |
When I go to project 'P_PTTAU_SEU04' teams page
And add user 'ESU_PTTAU_SEU04' into project 'P_PTTAU_SEU04' team with role 'PR_PTTAU_SEU04' expired '12.12.2021' for folder on popup '/PF_PTTAU_SEU04'
And wait for '15' seconds
And remove easyshare user 'ESU_PTTAU_SEU04' from project 'P_PTTAU_SEU04' team page
And logout from account
And open link from email when user 'ESU_PTTAU_SEU04' received email with next subject 'You have been invited'
And accept new user with first name 'Firstname' and last name 'Lastname'
Then I 'should' see empty page


Scenario: Check that user cannot get expired shared folder if he use direct URL
!-- 31/07/2015-Confirmed with Maria that this scenario is no longer valid as its a date picker and user shouldnt be allowed to enter a old date
Meta: @skip
      @gdam
Given I created '<ProjectRole>' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| Email       | Agency       | Role       |
| <UserEmail> | <UserAgency> | <UserType> |
And created '<ProjectName>' project
And created '/PF_PTTAU_S05' folder for project '<ProjectName>'
And uploaded into project '<ProjectName>' following files:
| FileName           | Path          |
| /files/Fish Ad.mov | /PF_PTTAU_S05 |
And added users '<UserEmail>' to project '<ProjectName>' team folders '/PF_PTTAU_S05' with role '<ProjectRole>' expired '11.11.2011'
And waited for '60' seconds
When I login with details of '<UserEmail>'
And open link from email when user '<UserEmail>' received email with next subject 'Folders have been shared with'
Then I 'should' see empty page

Examples:
| UserEmail     | UserAgency    | UserType    | ProjectRole    | ProjectName   |
| U_PTTAU_S05_1 | DefaultAgency | agency.user | PR_PTTAU_S05_1 | P_PTTAU_S05_1 |
| U_PTTAU_S05_2 | AnotherAgency | agency.user | PR_PTTAU_S05_2 | P_PTTAU_S05_2 |
| U_PTTAU_S05_3 | DefaultAgency | guest.user  | PR_PTTAU_S05_3 | P_PTTAU_S05_3 |


Scenario: Check that easyshare user cannot get expired shared folder if he use direct URL
!-- 31/07/2015 -Confirmed with Maria that this scenario is no longer valid as its a date picker and user shouldnt be allowed to enter a old date
Meta: @skip
      @gdam
Given I created 'PR_PTTAU_SEU05' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created 'P_PTTAU_SEU05' project
And created '/PF_PTTAU_SEU05' folder for project 'P_PTTAU_SEU05'
And uploaded into project 'P_PTTAU_SEU05' following files:
| FileName           | Path            |
| /files/Fish Ad.mov | /PF_PTTAU_SEU05 |
And added users 'ESU_PTTAU_SEU05' to project 'P_PTTAU_SEU05' team folders '/PF_PTTAU_SEU05' with role 'PR_PTTAU_SEU05' expired '11.11.2011'
And waited for '60' seconds
When I logout from account
And open link from email when user 'ESU_PTTAU_SEU05' received email with next subject 'You are invited to Adbank'
And accept new user with first name 'Firstname' and last name 'Lastname'
Then I 'should not' see project 'P_PTTAU_SEU05' on project list page


Scenario: Check if share date is expire, folder disappears for share user
!-- 31/07/2015-Confirmed with Maria that this scenario is no longer valid as its a date picker and user shouldnt be allowed to enter a old date
Meta: @skip
      @gdam
Given I created '<ProjectRole>' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And I created users with following fields:
| Email       | Agency       | Role       |
| <UserEmail> | <UserAgency> | <UserType> |
And created '<ProjectName>' project
And created '/PF_PTTAU_S06' folder for project '<ProjectName>'
And uploaded into project '<ProjectName>' following files:
| FileName           | Path          |
| /files/Fish Ad.mov | /PF_PTTAU_S06 |
And added users '<UserEmail>' to project '<ProjectName>' team folders '/PF_PTTAU_S06' with role '<ProjectRole>' expired '11.11.2011'
And waited for '60' seconds
When I login with details of '<UserEmail>'
Then I 'should not' see project '<ProjectName>' on project list page

Examples:
| UserEmail     | UserAgency    | UserType    | ProjectRole    | ProjectName   |
| U_PTTAU_S06_1 | DefaultAgency | agency.user | PR_PTTAU_S06_1 | P_PTTAU_S06_1 |
| U_PTTAU_S06_2 | AnotherAgency | agency.user | PR_PTTAU_S06_2 | P_PTTAU_S06_2 |
| U_PTTAU_S06_3 | DefaultAgency | guest.user  | PR_PTTAU_S06_3 | P_PTTAU_S06_3 |


Scenario: Check if share date is expire, folder disappears for easyshare user
!-- 31/07/2015-Confirmed with Maria that this scenario is no longer valid as its a date picker and user shouldnt be allowed to enter a old date
Meta: @skip
      @gdam
Given I created 'PR_PTTAU_SEU06' role with 'folder.read,element.read,project.read' permissions in 'project' group for advertiser 'DefaultAgency'
And created 'P_PTTAU_SEU06' project
And created '/PF_PTTAU_SEU06' folder for project 'P_PTTAU_SEU06'
And uploaded into project 'P_PTTAU_SEU06' following files:
| FileName           | Path            |
| /files/Fish Ad.mov | /PF_PTTAU_SEU06 |
And added users 'ESU_PTTAU_SEU06' to project 'P_PTTAU_SEU06' team folders '/PF_PTTAU_SEU06' with role 'PR_PTTAU_SEU06' expired '11.11.2011'
And waited for '60' seconds
When I logout from account
And open link from email when user 'ESU_PTTAU_SEU06' received email with next subject 'You are invited to Adbank'
And accept new user with first name 'Firstname' and last name 'Lastname'
Then I 'should not' see project 'P_PTTAU_SEU06' on project list page