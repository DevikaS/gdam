!--NGN-11691
Feature:          User can select and copy assets from library in projects and work requests
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that user is able to select and copy assets from library in projects and work requests

Scenario: check that agency user with permission 'element.create' can see button 'Add from Library' in project
Meta:@gdam
@projects
Given I created users with following fields:
| Email       | Role        | Access          |
| <UserEmail> | agency.user | library,folders |
And created 'PR_USCAFLPW_S01' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission    |
| element.read  |
| file.download |
| folder.create |
| folder.read   |
| project.read  |
And created 'P_USCAFLPW_S01' project
And created '/F_USCAFLPW_S01' folder for project 'P_USCAFLPW_S01'
And added users '<UserEmail>' to project 'P_USCAFLPW_S01' team with role '<ProjectRole>' expired '02.02.2020'
And logged in with details of '<UserEmail>'
When I go to project 'P_USCAFLPW_S01' folder '/F_USCAFLPW_S01' page
Then I '<Condition>' see element 'AddFromLibraryButton' on page 'ProjectTeam'

Examples:
| UserEmail        | ProjectRole         | Condition  |
| U_USCAFLPW_S01_1 | project.contributor | should     |
| U_USCAFLPW_S01_2 | PR_USCAFLPW_S01     | should not |


Scenario: check that agency user with permission 'element.create' can see button 'Add from Library' in work request
Meta:@gdam
@projects
Given I created users with following fields:
| Email       | Role        |
| <UserEmail> | agency.user |
And created 'PR_USCAFLPW_S02' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission    |
| element.read  |
| file.download |
| folder.create |
| folder.read   |
| project.read  |
And created 'WR_USCAFLPW_S02' work request
And created '/F_USCAFLPW_S02' folder for work request 'WR_USCAFLPW_S02'
And added users '<UserEmail>' to work request 'WR_USCAFLPW_S02' team with role '<ProjectRole>' expired '02.02.2020'
And logged in with details of '<UserEmail>'
When I go to work request 'WR_USCAFLPW_S02' folder '/F_USCAFLPW_S02' page
Then I '<Condition>' see element 'AddFromLibraryButton' on page 'ProjectTeam'

Examples:
| UserEmail        | ProjectRole         | Condition  |
| U_USCAFLPW_S02_1 | project.contributor | should     |
| U_USCAFLPW_S02_2 | PR_USCAFLPW_S02     | should not |


Scenario: check that agency user can add assets from library to project
Meta:@gdam
@projects
Given I created 'P_USCAFLPW_S03' project
And created '/F_USCAFLPW_S03' folder for project 'P_USCAFLPW_S03'
And uploaded file '/files/image10.jpg' into libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I go to project 'P_USCAFLPW_S03' folder '/F_USCAFLPW_S03' page
And add file 'image10.jpg' from library on project 'P_USCAFLPW_S03' folder '/F_USCAFLPW_S03' files page
Then I 'should' see file 'image10.jpg' on project 'P_USCAFLPW_S03' folder '/F_USCAFLPW_S03' files page


Scenario: check that agency user can add assets from library to work request
Meta:@gdam
@projects
Given I created 'WR_USCAFLPW_S04' work request
And created '/F_USCAFLPW_S04' folder for work request 'WR_USCAFLPW_S04'
And uploaded file '/files/image10.jpg' into libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I go to work request 'WR_USCAFLPW_S04' folder '/F_USCAFLPW_S04' page
And add file 'image10.jpg' from library on work request 'WR_USCAFLPW_S04' folder '/F_USCAFLPW_S04' files page
Then I 'should' see file 'image10.jpg' on work request 'WR_USCAFLPW_S04' folder '/F_USCAFLPW_S04' files page


Scenario: check that if user has not got permission to Download Master or Download Proxy in Library - Master or Proxy should not be copied to project
Meta:@gdam
@projects
Given I created the agency 'A_USCAFLPW_S05' with default attributes
And created users with following fields:
| Email           | Role         | Agency         | Access          |
| AU_USCAFLPW_S05 | agency.admin | A_USCAFLPW_S05 | library,folders |
| <UserEmail>     | agency.user  | A_USCAFLPW_S05 | library,folders |
And created '<LibraryRole>' role in 'library' group for advertiser 'A_USCAFLPW_S05' with following permissions:
| Permission                 |
| asset.read                 |
| asset.share                |
| asset.write                |
| asset_filter_category.read |
| <Permission>               |
And logged in with details of 'AU_USCAFLPW_S05'
And created 'C_USCAFLPW_S05' category
And created 'P_USCAFLPW_S05' project
And created '/F_USCAFLPW_S05' folder for project 'P_USCAFLPW_S05'
And uploaded file '/files/image10.jpg' into library
And waited while transcoding is finished in collection 'Everything'
And added users '<UserEmail>' to project 'P_USCAFLPW_S05' team with role 'project.contributor' expired '02.02.2020'
And added next users for following categories:
| CategoryName   | UserName    | RoleName      |
| C_USCAFLPW_S05 | <UserEmail> | <LibraryRole> |
And logged in with details of '<UserEmail>'
When I go to project 'P_USCAFLPW_S05' folder '/F_USCAFLPW_S05' page
And add file 'image10.jpg' from library on project 'P_USCAFLPW_S05' folder '/F_USCAFLPW_S05' files page
Then I 'should not' see Download link for '<DownloadButtonName>' type on file 'image10.jpg' info page for project 'P_USCAFLPW_S05' folder '/F_USCAFLPW_S05'

Examples:
| UserEmail        | Permission     | LibraryRole       | DownloadButtonName |
| U_USCAFLPW_S05_1 | file.download  | LR_USCAFLPW_S05_1 | proxy              |
| U_USCAFLPW_S05_2 | proxy.download | LR_USCAFLPW_S05_2 | original           |


Scenario: check that if user has not got permission to Download Master or Download Proxy in Library - Master or Proxy should not be copied to work request
Meta:@gdam
@projects
Given I created the agency 'A_USCAFLPW_S06' with default attributes
And created users with following fields:
| Email           | Role         | Agency         | Access          |
| AU_USCAFLPW_S06 | agency.admin | A_USCAFLPW_S06 | library,folders |
| <UserEmail>     | agency.user  | A_USCAFLPW_S06 | library,folders |
And created '<LibraryRole>' role in 'library' group for advertiser 'A_USCAFLPW_S06' with following permissions:
| Permission                 |
| asset.read                 |
| asset.share                |
| asset.write                |
| asset_filter_category.read |
| <Permission>               |
And logged in with details of 'AU_USCAFLPW_S06'
And created 'C_USCAFLPW_S06' category
And created 'P_USCAFLPW_S06' work request
And created '/F_USCAFLPW_S06' folder for work request 'P_USCAFLPW_S06'
And uploaded file '/files/image10.jpg' into library
And waited while transcoding is finished in collection 'Everything'
And added users '<UserEmail>' to work request 'P_USCAFLPW_S06' team with role 'project.contributor' expired '02.02.2020'
And added next users for following categories:
| CategoryName   | UserName    | RoleName      |
| C_USCAFLPW_S06 | <UserEmail> | <LibraryRole> |
And logged in with details of '<UserEmail>'
When I go to work request 'P_USCAFLPW_S06' folder '/F_USCAFLPW_S06' page
And add file 'image10.jpg' from library on work request 'P_USCAFLPW_S06' folder '/F_USCAFLPW_S06' files page
Then I 'should not' see Download link for '<DownloadButtonName>' type on file 'image10.jpg' info page for work request 'P_USCAFLPW_S06' folder '/F_USCAFLPW_S06'

Examples:
| UserEmail        | Permission     | LibraryRole       | DownloadButtonName |
| U_USCAFLPW_S06_1 | file.download  | LR_USCAFLPW_S06_1 | proxy              |
| U_USCAFLPW_S06_2 | proxy.download | LR_USCAFLPW_S06_2 | original           |