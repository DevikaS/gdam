!--NGN-9307
Feature:          Add separate permission for File preview download
BookNarrative:
In order to
As a              AgencyAdmin
I want to         check separate permission for File preview download

Scenario: Check that proxy.download permission enabled by default for project.admin and project.contributor roles
Meta:@globaladmin
     @gdam
Given I created the agency 'A_ASPFFPD_S01' with default attributes
And logged in with details of 'GlobalAdmin'
When I open role '<GlobalRole>' page with parent 'A_ASPFFPD_S01'
Then I 'should' see '<PermissionState>' permissions 'proxy.download' on opened global role page

Examples:
| GlobalRole          | PermissionState |
| project.admin       | selected        |
| project.contributor | selected        |


Scenario: Check that after share folder for user, without proxy.download permission in project role, download buttons for proxy and custom formats doesn't avalable in file (Folder view > Select file(s) > Download pop up)
Meta:@projects
     @gdam
Given I created users with following fields:
| Email         | Role        |
| U_ASPFFPD_S02 | agency.user |
And created 'PR_ASPFFPD_S02' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission     |
| comment.create |
| comment.read   |
| element.create |
| element.read   |
| folder.create  |
| folder.read    |
| project.read   |
| file.download  |
And created 'P_ASPFFPD_S02' project
And created '/F_ASPFFPD_S02' folder for project 'P_ASPFFPD_S02'
And uploaded '/files/Fish1-Ad.mov' file into '/F_ASPFFPD_S02' folder for 'P_ASPFFPD_S02' project
And waited while preview is available in folder '/F_ASPFFPD_S02' on project 'P_ASPFFPD_S02' files page
And I fill Share popup by users 'U_ASPFFPD_S02' in project 'P_ASPFFPD_S02' folders '/F_ASPFFPD_S02' with role 'PR_ASPFFPD_S02' expired '12.12.2021' and 'should' access to subfolders
When I login with details of 'U_ASPFFPD_S02'
And go to project 'P_ASPFFPD_S02' folder '/F_ASPFFPD_S02' page
And select file 'Fish1-Ad.mov' on project files page
Then I 'should not' see Download link for 'proxy' type on Download popup for project 'P_ASPFFPD_S02' folder '/F_ASPFFPD_S02'


Scenario: Check that after share folder for user, without proxy.download permission in project role, download buttons for proxy and custom formats doesn't avalable in file (File > Info > Download button)
Meta:@projects
     @gdam
Given I created users with following fields:
| Email         | Role        |
| U_ASPFFPD_S03 | agency.user |
And created 'PR_ASPFFPD_S03' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission     |
| comment.create |
| comment.read   |
| element.create |
| element.read   |
| folder.create  |
| folder.read    |
| project.read   |
| file.download  |
And created 'P_ASPFFPD_S03' project
And created '/F_ASPFFPD_S03' folder for project 'P_ASPFFPD_S03'
And uploaded '/files/Fish1-Ad.mov' file into '/F_ASPFFPD_S03' folder for 'P_ASPFFPD_S03' project
And waited while preview is available in folder '/F_ASPFFPD_S03' on project 'P_ASPFFPD_S03' files page
And I fill Share popup by users 'U_ASPFFPD_S03' in project 'P_ASPFFPD_S03' folders '/F_ASPFFPD_S03' with role 'PR_ASPFFPD_S03' expired '12.12.2021' and 'should' access to subfolders
When I login with details of 'U_ASPFFPD_S03'
Then I 'should not' see Download link for 'proxy' type on Download popup on file 'Fish1-Ad.mov' info page for project 'P_ASPFFPD_S03' folder '/F_ASPFFPD_S03'
And 'should not' see Download proxy button on file 'Fish1-Ad.mov' info page in folder '/F_ASPFFPD_S03' project 'P_ASPFFPD_S03'


Scenario: Check that after share folder for user, without proxy.download permission in project role, download buttons for proxy and custom formats doesn't avalable in file (1.File > Info > versions)
Meta:@projects
     @gdam
Given I created users with following fields:
| Email         | Role        |
| U_ASPFFPD_S04 | agency.user |
And created 'PR_ASPFFPD_S04' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission                   |
| activity.read                |
| comment.create               |
| comment.delete               |
| comment.read                 |
| comment.write                |
| element.create               |
| element.delete               |
| element.read                 |
| element.share                |
| element.write                |
| element.version_history.read |
| folder.create                |
| folder.delete                |
| folder.read                  |
| folder.share                 |
| folder.write                 |
| project.read                 |
| project.write                |
And created 'P_ASPFFPD_S04' project
And created '/F_ASPFFPD_S04' folder for project 'P_ASPFFPD_S04'
And uploaded '/files/Fish1-Ad.mov' file into '/F_ASPFFPD_S04' folder for 'P_ASPFFPD_S04' project
And waited while preview is available in folder '/F_ASPFFPD_S04' on project 'P_ASPFFPD_S04' files page
And uploaded new file version '/files/Fish2-Ad.mov' for file 'Fish1-Ad.mov' into '/F_ASPFFPD_S04' folder for 'P_ASPFFPD_S04' project
And waited while preview is visible on project 'P_ASPFFPD_S04' in folder '/F_ASPFFPD_S04' for 'Fish1-Ad.mov' file revision '2'
And I fill Share popup by users 'U_ASPFFPD_S04' in project 'P_ASPFFPD_S04' folders '/F_ASPFFPD_S04' with role 'PR_ASPFFPD_S04' expired '12.12.2021' and 'should' access to subfolders
When I login with details of 'U_ASPFFPD_S04'
Then I 'should not' see Download Proxy link for version '2' for file 'Fish1-Ad.mov' version history page in folder '/F_ASPFFPD_S04' project 'P_ASPFFPD_S04'


Scenario: Check that after share folder for user, with proxy.download permission in project role, download buttons for proxy and custom formats are avalable in file (File > Info > Download button)
Meta:@projects
     @gdam
Given I created users with following fields:
| Email         | Role        |
| U_ASPFFPD_S05 | agency.user |
And created 'PR_ASPFFPD_S05' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission     |
| comment.create |
| comment.read   |
| element.create |
| element.read   |
| folder.create  |
| folder.read    |
| project.read   |
| file.download  |
| proxy.download |
And created 'P_ASPFFPD_S05' project
And created '/F_ASPFFPD_S05' folder for project 'P_ASPFFPD_S05'
And uploaded '/files/Fish1-Ad.mov' file into '/F_ASPFFPD_S05' folder for 'P_ASPFFPD_S05' project
And waited while preview is available in folder '/F_ASPFFPD_S05' on project 'P_ASPFFPD_S05' files page
And I fill Share popup by users 'U_ASPFFPD_S05' in project 'P_ASPFFPD_S05' folders '/F_ASPFFPD_S05' with role 'PR_ASPFFPD_S05' expired '12.12.2021' and 'should' access to subfolders
When I login with details of 'U_ASPFFPD_S05'
And go to project 'P_ASPFFPD_S05' folder '/F_ASPFFPD_S05' page
And select file 'Fish1-Ad.mov' on project files page
Then I 'should' see Download link for 'proxy' type on Download popup for project 'P_ASPFFPD_S05' folder '/F_ASPFFPD_S05'
Then I 'should' see Download link for 'proxy' type on Download popup on file 'Fish1-Ad.mov' info page for project 'P_ASPFFPD_S05' folder '/F_ASPFFPD_S05'
And 'should' see Download proxy button on file 'Fish1-Ad.mov' info page in folder '/F_ASPFFPD_S05' project 'P_ASPFFPD_S05'


Scenario: Check that after share folder for user, with proxy.download permission in project role, file could be playouted (mov, mpg, wmv, mp3)
Meta:@projects
     @gdam
Given I created users with following fields:
| Email         | Role        |
| U_ASPFFPD_S07 | agency.user |
And created 'PR_ASPFFPD_S07' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission     |
| comment.create |
| comment.read   |
| element.create |
| element.read   |
| folder.create  |
| folder.read    |
| project.read   |
| file.download  |
And created 'P_ASPFFPD_S07' project
And created '/F_ASPFFPD_S07' folder for project 'P_ASPFFPD_S07'
And uploaded '/files/Fish1-Ad.mov' file into '/F_ASPFFPD_S07' folder for 'P_ASPFFPD_S07' project
And uploaded '/files/Fish1-Ad.mpg' file into '/F_ASPFFPD_S07' folder for 'P_ASPFFPD_S07' project
And uploaded '/files/Fish1-Ad.wmv' file into '/F_ASPFFPD_S07' folder for 'P_ASPFFPD_S07' project
And uploaded '/files/Fish1-Ad.mp3' file into '/F_ASPFFPD_S07' folder for 'P_ASPFFPD_S07' project
And waited while preview is available in folder '/F_ASPFFPD_S07' on project 'P_ASPFFPD_S07' files page
And I fill Share popup by users 'U_ASPFFPD_S07' in project 'P_ASPFFPD_S07' folders '/F_ASPFFPD_S07' with role 'PR_ASPFFPD_S07' expired '12.12.2021' and 'should' access to subfolders
When I login with details of 'U_ASPFFPD_S07'
Then I 'should' be able to play clip on file '<AssetName>' info page for project 'P_ASPFFPD_S07' folder '/F_ASPFFPD_S07'

Examples:
| AssetName    |
| Fish1-Ad.mov |
| Fish1-Ad.mpg |
| Fish1-Ad.wmv |
| Fish1-Ad.mp3 |

