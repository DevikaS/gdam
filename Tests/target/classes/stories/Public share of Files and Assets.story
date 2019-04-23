!--NGN-8873
Feature:          Public share of Files and Assets
BookNarrative:
In order to
As a              AgencyAdmin
I want to         check sharing of files and assets via public link

Scenario: Check that Share file button becomes active after publishing project
Meta:@gdam
@projects
Given I created 'P_PSOFAA_S01' project
And created '/F_PSOFAA_S01' folder for project 'P_PSOFAA_S01'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S01' folder for 'P_PSOFAA_S01' project
And waited while preview is available in folder '/F_PSOFAA_S01' on project 'P_PSOFAA_S01' files page
When I select file 'Fish Ad.mov' on project files page
Then I 'should' see element 'ShareFiles' on page 'FilesPage'
When I unpublish the project 'P_PSOFAA_S01'
And go to project 'P_PSOFAA_S01' folder '/F_PSOFAA_S01' page
And select file 'Fish Ad.mov' on project files page
Then I 'should not' see element 'ShareFiles' on page 'FilesPage'


Scenario: Check that 'Share file (s)' button available for 'project admin' user
Meta:@gdam
@projects
Given I created  'P_PSOFAA_S02' project
And created '/F_PSOFAA_S02' folder for project 'P_PSOFAA_S02'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S02' folder for 'P_PSOFAA_S02' project
And waited while preview is available in folder '/F_PSOFAA_S02' on project 'P_PSOFAA_S02' files page
When I select file 'Fish Ad.mov' on project files page
Then I 'should' see element 'ShareFiles' on page 'FilesPage'


Scenario: Check that 'Share file (s)' button available for user with 'element.share' permission (custom roles)
Meta:@gdam
@projects
Given I created 'PR_PSOFAA_S03' role with 'element.read,element.share,project.read,folder.read,folder.share' permissions in 'project' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email        | Role        |
| U_PSOFAA_S03 | agency.user |
And created 'P_PSOFAA_S03' project
And created '/F_PSOFAA_S03' folder for project 'P_PSOFAA_S03'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S03' folder for 'P_PSOFAA_S03' project
And added users 'U_PSOFAA_S03' to project 'P_PSOFAA_S03' team folders '/F_PSOFAA_S03' with role 'PR_PSOFAA_S03' expired '02.02.2020' and 'should' access to subfolders
When I login with details of 'U_PSOFAA_S03'
And go to project 'P_PSOFAA_S03' folder '/F_PSOFAA_S03' page
And select file 'Fish Ad.mov' on project files page
Then I 'should' see element 'ShareFiles' on page 'FilesPage'


Scenario: Check that public link not activated by default
Meta:@gdam
@projects
Given I created 'P_PSOFAA_S04' project
And created '/F_PSOFAA_S04' folder for project 'P_PSOFAA_S04'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S04' folder for 'P_PSOFAA_S04' project
And waited while preview is available in folder '/F_PSOFAA_S04' on project 'P_PSOFAA_S04' files page
When I open public url for file 'Fish Ad.mov' in folder '/F_PSOFAA_S04' and project 'P_PSOFAA_S04'
And wait for '5' seconds
Then I should see text on page contains 'We are sorry! You do not have permission to access this area.'
And 'should not' be on public file preview page


Scenario: Check activate functionality for public link
Meta:@gdam
@projects
Given I created 'P_PSOFAA_S05' project
And created '/F_PSOFAA_S05' folder for project 'P_PSOFAA_S05'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S05' folder for 'P_PSOFAA_S05' project
And waited while preview is available in folder '/F_PSOFAA_S05' on project 'P_PSOFAA_S05' files page
When I 'activate' public url for file 'Fish Ad.mov' in folder '/F_PSOFAA_S05' and project 'P_PSOFAA_S05'
And open public url from opened Share files popup
Then I 'should' be on public file preview page


Scenario: Check deactivate functionality for public link
Meta:@gdam
@projects
Given I created 'P_PSOFAA_S06' project
And created '/F_PSOFAA_S06' folder for project 'P_PSOFAA_S06'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S06' folder for 'P_PSOFAA_S06' project
And waited while preview is available in folder '/F_PSOFAA_S06' on project 'P_PSOFAA_S06' files page
When I 'activate' public url for file 'Fish Ad.mov' in folder '/F_PSOFAA_S06' and project 'P_PSOFAA_S06'
And 'deactivate' public url on opened Share files popup
And open public url from opened Share files popup
And wait for '5' seconds
Then I 'should' see error message 'We are sorry! You do not have permission to access this area.' on the page
And 'should not' be on public file preview page


Scenario: Check public share for registered user within agency (send to registered user)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email        | Role        |
| U_PSOFAA_S07 | agency.user |
And created 'P_PSOFAA_S07' project
And created '/F_PSOFAA_S07' folder for project 'P_PSOFAA_S07'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S07' folder for 'P_PSOFAA_S07' project
And waited while preview is available in folder '/F_PSOFAA_S07' on project 'P_PSOFAA_S07' files page
When I send public link of file 'Fish Ad.mov' from folder '/F_PSOFAA_S07' and project 'P_PSOFAA_S07' to following users:
| ExpireDate | UserEmails   | Message |
| 12.12.21   | U_PSOFAA_S07 | hi dude |
Then I 'should' see email notification for 'File sharing' with field to 'U_PSOFAA_S07' and subject 'has shared file with you' contains following attributes:
| UserName    | Agency        | FileName    | Message |
| AgencyAdmin | DefaultAgency | Fish Ad.mov | hi dude |


Scenario: Check email notification about public share for unregistered user (no registration process)
Meta:@gdam
     @gdamemails
Given I created 'P_PSOFAA_S08' project
And created '/F_PSOFAA_S08' folder for project 'P_PSOFAA_S08'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S08' folder for 'P_PSOFAA_S08' project
And waited while preview is available in folder '/F_PSOFAA_S08' on project 'P_PSOFAA_S08' files page
When I send public link of file 'Fish Ad.mov' from folder '/F_PSOFAA_S08' and project 'P_PSOFAA_S08' to following users:
| ExpireDate | UserEmails     | Message |
| 12.12.21   | NAU_PSOFAA_S08 | hi dude |
Then I 'should not' see email with subject 'You are invited to Adbank' sent to 'NAU_PSOFAA_S08'
Then I 'should' see email notification for 'File sharing' with field to 'NAU_PSOFAA_S08' and subject 'has shared file with you' contains following attributes:
| UserName    | Agency        | FileName    | Message |
| AgencyAdmin | DefaultAgency | Fish Ad.mov | hi dude |


Scenario: Check public link from email notification (email to user from another BU)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email        | Role        | Agency        |
| U_PSOFAA_S09 | agency.user | AnotherAgency |
And created 'P_PSOFAA_S09' project
And created '/F_PSOFAA_S09' folder for project 'P_PSOFAA_S09'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S09' folder for 'P_PSOFAA_S09' project
And waited while preview is available in folder '/F_PSOFAA_S09' on project 'P_PSOFAA_S09' files page
When I send public link of file 'Fish Ad.mov' from folder '/F_PSOFAA_S09' and project 'P_PSOFAA_S09' to following users:
| ExpireDate | UserEmails   | Message |
| 12.12.21   | U_PSOFAA_S09 | hi dude |
Then I 'should' see email notification for 'File sharing' with field to 'U_PSOFAA_S09' and subject 'has shared file with you' contains following attributes:
| UserName    | Agency        | FileName    | Message |
| AgencyAdmin | DefaultAgency | Fish Ad.mov | hi dude |


Scenario: Check expiration of public share (today is considered as expiry date)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email        | Role        |
| U_PSOFAA_S10 | agency.user |
And created 'P_PSOFAA_S10' project
And created '/F_PSOFAA_S10' folder for project 'P_PSOFAA_S10'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S10' folder for 'P_PSOFAA_S10' project
And waited while preview is available in folder '/F_PSOFAA_S10' on project 'P_PSOFAA_S10' files page
When I send public link of file 'Fish Ad.mov' from folder '/F_PSOFAA_S10' and project 'P_PSOFAA_S10' to following users:
| ExpireDate | UserEmails   | Message |
| Today      | U_PSOFAA_S10 | hi dude |
And login with details of 'U_PSOFAA_S10'
And open link from email when user 'U_PSOFAA_S10' received email with next subject 'shared file with you'
And wait for '5' seconds
Then I 'should' see error message 'We are sorry! You do not have permission to access this area.' on the page
And 'should not' be on public file preview page


Scenario: Check edit public share details ('expire date' field)
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email        | Role        |
| U_PSOFAA_S11 | agency.user |
And created 'P_PSOFAA_S11' project
And created '/F_PSOFAA_S11' folder for project 'P_PSOFAA_S11'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S11' folder for 'P_PSOFAA_S11' project
And waited while preview is available in folder '/F_PSOFAA_S11' on project 'P_PSOFAA_S11' files page
When I send public link of file 'Fish Ad.mov' from folder '/F_PSOFAA_S11' and project 'P_PSOFAA_S11' to following users:
| ExpireDate | UserEmails   | Message |
| 12.12.21   | U_PSOFAA_S11 | hi dude |
And login with details of 'U_PSOFAA_S11'
And open link from email when user 'U_PSOFAA_S11' received email with next subject 'shared file with you'
Then I 'should' be on public file preview page
When I login with details of 'AgencyAdmin'
When I send public link of file 'Fish Ad.mov' from folder '/F_PSOFAA_S11' and project 'P_PSOFAA_S11' to following users:
| ExpireDate | UserEmails   | Message |
| Today      | U_PSOFAA_S11 | hi dude |
And login with details of 'U_PSOFAA_S11'
And open link from email when user 'U_PSOFAA_S11' received email with next subject 'shared file with you'
And wait for '5' seconds
Then I should see text on page contains 'We are sorry! You do not have permission to access this area.'
And 'should not' be on public file preview page


Scenario: Check proxy download option
Meta: @qagdamsmoke
	  @livegdamsmoke
	  @gdamemails
	  @gdamcrossbrowser
Given I created users with following fields:
| Email        | Role        |
| U_PSOFAA_S12 | agency.user |
And created 'P_PSOFAA_S12' project
And created '/F_PSOFAA_S12' folder for project 'P_PSOFAA_S12'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S12' folder for 'P_PSOFAA_S12' project
And waited while preview is available in folder '/F_PSOFAA_S12' on project 'P_PSOFAA_S12' files page
When I send public link of file 'Fish Ad.mov' from folder '/F_PSOFAA_S12' and project 'P_PSOFAA_S12' to following users:
| ExpireDate | UserEmails   | Message | DownloadProxy |
| 12.12.21   | U_PSOFAA_S12 | hi dude | true          |
And logout from account
And open link from email when user 'U_PSOFAA_S12' received email with next subject 'shared file with you'
And refresh the page
And click download button on public file preview page
Then I 'should' see element 'DownloadProxy' on page 'PublicFilePreview'


Scenario: Check email notification at sharing file to several user
Meta:@gdam
     @gdamemails
Given I created users with following fields:
| Email        | Role        |
| U_PSOFAA_S13 | agency.user |
And created 'P_PSOFAA_S13' project
And created '/F_PSOFAA_S13' folder for project 'P_PSOFAA_S13'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S13' folder for 'P_PSOFAA_S13' project
And waited while preview is available in folder '/F_PSOFAA_S13' on project 'P_PSOFAA_S13' files page
When I send public link of file 'Fish Ad.mov' from folder '/F_PSOFAA_S13' and project 'P_PSOFAA_S13' to following users:
| ExpireDate | UserEmails                  | Message  |
| 12.12.21   | U_PSOFAA_S13,NAU_PSOFAA_S13 | hi dudes |
Then I 'should' see email notification for 'File sharing' with field to 'U_PSOFAA_S13' and subject 'has shared file with you' contains following attributes:
| UserName    | Agency        | FileName    | Message  |
| AgencyAdmin | DefaultAgency | Fish Ad.mov | hi dudes |
And 'should' see email notification for 'File sharing' with field to 'NAU_PSOFAA_S13' and subject 'has shared file with you' contains following attributes:
| UserName    | Agency        | FileName    | Message  |
| AgencyAdmin | DefaultAgency | Fish Ad.mov | hi dudes |


Scenario: Check that file is not available in search results after sharing
Meta:@gdam
     @projects
Given I created the following agency:
| Name         |
| A_PSOFAA_S14 |
And created users with following fields:
| Email        | Role        | Agency       |
| U_PSOFAA_S14 | agency.user | A_PSOFAA_S14 |
And created 'P_PSOFAA_S14' project
And created '/F_PSOFAA_S14' folder for project 'P_PSOFAA_S14'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S14' folder for 'P_PSOFAA_S14' project
And waited while preview is available in folder '/F_PSOFAA_S14' on project 'P_PSOFAA_S14' files page
When I send public link of file 'Fish Ad.mov' from folder '/F_PSOFAA_S14' and project 'P_PSOFAA_S14' to following users:
| ExpireDate | UserEmails   | Message |
| 12.12.21   | U_PSOFAA_S14 | hi dude |
And login with details of 'U_PSOFAA_S14'
And search by text 'Fish Ad.mov'
Then I 'should not' see search object 'Fish Ad.mov'


Scenario: Check activity about public share on file details
Meta:@gdam
     @projects
Given I created 'P_PSOFAA_S15' project
And created '/F_PSOFAA_S15' folder for project 'P_PSOFAA_S15'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S15' folder for 'P_PSOFAA_S15' project
And waited while preview is available in folder '/F_PSOFAA_S15' on project 'P_PSOFAA_S15' files page
When I send public link of file 'Fish Ad.mov' from folder '/F_PSOFAA_S15' and project 'P_PSOFAA_S15' to following users:
| ExpireDate | UserEmails   | Message |
| 12.12.21   | U_PSOFAA_S15 | hi dude |
When I go to file 'Fish Ad.mov' info page in folder '/F_PSOFAA_S15' project 'P_PSOFAA_S15'
And refresh the page
Then I 'should' see activity for user 'AgencyAdmin' on file 'Fish Ad.mov' activity tab in project 'P_PSOFAA_S15' folder '/F_PSOFAA_S15' page with message 'created public link for file' and value ''


Scenario: Check that project owner can see activity about public share
Meta:@gdam
     @projects
Given I created 'P_PSOFAA_S16' project
And created '/F_PSOFAA_S16' folder for project 'P_PSOFAA_S16'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S16' folder for 'P_PSOFAA_S16' project
And waited while preview is available in folder '/F_PSOFAA_S16' on project 'P_PSOFAA_S16' files page
When I send public link of file 'Fish Ad.mov' from folder '/F_PSOFAA_S16' and project 'P_PSOFAA_S16' to following users:
| ExpireDate | UserEmails   | Message |
| 12.12.21   | U_PSOFAA_S16 | hi dude |
Then I 'should' see activity for user 'AgencyAdmin' on project 'P_PSOFAA_S16' overview page with message 'created public link for file' and value 'Fish Ad.mov'


Scenario: Check that project owner can see activity about public share on Dashboard (public share created by user with permission) (public share created by user with permission)
Meta:@gdam
     @projects
Given I created the following agency:
| Name         |
| A_PSOFAA_S17 |
And created 'PR_PSOFAA_S17' role with 'element.read,element.share,project.read,folder.read,folder.share,element.public_share.create,file.download,proxy.download' permissions in 'project' group for advertiser 'A_PSOFAA_S17'
And created users with following fields:
| Email          | Role         | Agency       |
| U_PSOFAA_S17_1 | agency.admin | A_PSOFAA_S17 |
| U_PSOFAA_S17_2 | agency.user  | A_PSOFAA_S17 |
And logged in with details of 'U_PSOFAA_S17_1'
And created 'P_PSOFAA_S17' project
And created '/F_PSOFAA_S17' folder for project 'P_PSOFAA_S17'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S17' folder for 'P_PSOFAA_S17' project
And waited while preview is available in folder '/F_PSOFAA_S17' on project 'P_PSOFAA_S17' files page
And added users 'U_PSOFAA_S17_2' to project 'P_PSOFAA_S17' team folders 'F_PSOFAA_S17' with role 'PR_PSOFAA_S17' expired '12.12.2021' and 'should' access to subfolders
And logged in with details of 'U_PSOFAA_S17_2'
When I send public link of file 'Fish Ad.mov' from folder 'F_PSOFAA_S17' and project 'P_PSOFAA_S17' to following users:
| ExpireDate | UserEmails     | Message |
| 12.12.21   | U_PSOFAA_S17_2 | hi dude |
And login with details of 'U_PSOFAA_S17_1'
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName       | Message                      | Value       |
| U_PSOFAA_S17_2 | created public link for file | Fish Ad.mov |


Scenario: Check behaviour after delete file
Meta:@gdam
@gdamemails
Given I created users with following fields:
| Email        | Role        |
| U_PSOFAA_S18 | agency.user |
And created 'P_PSOFAA_S18' project
And created '/F_PSOFAA_S18' folder for project 'P_PSOFAA_S18'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S18' folder for 'P_PSOFAA_S18' project
And waited while preview is available in folder '/F_PSOFAA_S18' on project 'P_PSOFAA_S18' files page
When I send public link of file 'Fish Ad.mov' from folder '/F_PSOFAA_S18' and project 'P_PSOFAA_S18' to following users:
| ExpireDate | UserEmails   | Message |
| 12.12.21   | U_PSOFAA_S18 | hi dude |
And refresh the page
And 'delete' file 'Fish Ad.mov' from project files page
And login with details of 'U_PSOFAA_S18'
And open link from email when user 'U_PSOFAA_S18' received email with next subject 'shared file with you'
And wait for '5' seconds
Then I 'should' see error message 'We are sorry! You do not have permission to access this area.' on the page
And 'should not' be on public file preview page



Scenario: Check that Public share tab unavailable if more then one file selected
Meta:@gdam
     @projects
Given I created 'P_PSOFAA_S31' project
And created '/F_PSOFAA_S31' folder for project 'P_PSOFAA_S31'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S31' folder for 'P_PSOFAA_S31' project
And uploaded '/files/Fish-Ad.mov' file into '/F_PSOFAA_S31' folder for 'P_PSOFAA_S31' project
And waited while preview is available in folder '/F_PSOFAA_S31' on project 'P_PSOFAA_S31' files page
When I select file 'Fish Ad.mov,Fish-Ad.mov' on project files page
And click element 'ShareFiles' on page 'FilesPage'
Then I 'should not' see Public share tab on opened Share files popup




Scenario: Check that public link depends on BU custom url
!--need to investigation
Meta: @skip
      @gdam
Scenario: user without file.download and proxy.download cant share to download proxy or master
!--NGN-16658
Given I created the following agency:
| Name              |
| A_PSOFAA_S17_ATP1 |
And created 'PR_PSOFAA_S17_ATP1' role with 'element.read,element.share,project.read,folder.read,folder.share,element.public_share.create' permissions in 'project' group for advertiser 'A_PSOFAA_S17_ATP1'
And created users with following fields:
| Email               | Role         | Agency            |
| U_PSOFAA_S17_1_ATP1 | agency.admin | A_PSOFAA_S17_ATP1 |
| U_PSOFAA_S17_2_ATP1 | agency.user  | A_PSOFAA_S17_ATP1 |
And logged in with details of 'U_PSOFAA_S17_1_ATP1'
And created 'P_PSOFAA_S17_ATP1' project
And created '/F_PSOFAA_S17_ATP1' folder for project 'P_PSOFAA_S17_ATP1'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S17_ATP1' folder for 'P_PSOFAA_S17_ATP1' project
And waited while preview is available in folder '/F_PSOFAA_S17_ATP1' on project 'P_PSOFAA_S17_ATP1' files page
And added users 'U_PSOFAA_S17_2_ATP1' to project 'P_PSOFAA_S17_ATP1' team folders 'F_PSOFAA_S17_ATP1' with role 'PR_PSOFAA_S17_ATP1' expired '12.12.2021' and 'should' access to subfolders
And logged in with details of 'U_PSOFAA_S17_2_ATP1'
When I open public share for file 'Fish Ad.mov' in folder 'F_PSOFAA_S17_ATP1' and project 'P_PSOFAA_S17_ATP1'
Then I 'should not' see element 'DownloadProxy' on page 'PublicSharePopup'
Then I 'should not' see element 'DownloadOriginal' on page 'PublicSharePopup'
When I refresh the page without delay
When I send public link of file without download permission 'Fish Ad.mov' from folder 'F_PSOFAA_S17_ATP1' and project 'P_PSOFAA_S17_ATP1' to following users:
| ExpireDate | UserEmails          | Message |
| 12.12.21   | U_PSOFAA_S17_2_ATP1 | hi dude |
And login with details of 'U_PSOFAA_S17_2_ATP1'
And open link from email when user 'U_PSOFAA_S17_2_ATP1' received email with next subject 'shared file with you'
Then I 'should not' see element 'DownloadButton' on page 'PublicFilePreview'


Scenario: user without file.download and with proxy.download cant share to download proxy or master
Meta:@gdam
     @gdamemails
!--NGN-16658
Given I created the following agency:
| Name              |
| A_PSOFAA_S17_ATP2 |
And created 'PR_PSOFAA_S17_ATP2' role with 'element.read,element.share,project.read,folder.read,folder.share,element.public_share.create,proxy.download' permissions in 'project' group for advertiser 'A_PSOFAA_S17_ATP2'
And created users with following fields:
| Email                | Role         | Agency           |
| U_PSOFAA_S17_1_ATP2 | agency.admin | A_PSOFAA_S17_ATP2 |
| U_PSOFAA_S17_2_ATP2 | agency.user  | A_PSOFAA_S17_ATP2 |
And logged in with details of 'U_PSOFAA_S17_1_ATP2'
And created 'P_PSOFAA_S17_ATP2' project
And created '/F_PSOFAA_S17_ATP2' folder for project 'P_PSOFAA_S17_ATP2'
And uploaded '/files/Fish Ad.mov' file into '/F_PSOFAA_S17_ATP2' folder for 'P_PSOFAA_S17_ATP2' project
And waited while preview is available in folder '/F_PSOFAA_S17_ATP2' on project 'P_PSOFAA_S17_ATP2' files page
And added users 'U_PSOFAA_S17_2_ATP2' to project 'P_PSOFAA_S17_ATP2' team folders 'F_PSOFAA_S17_ATP2' with role 'PR_PSOFAA_S17_ATP2' expired '12.12.2021' and 'should' access to subfolders
And logged in with details of 'U_PSOFAA_S17_2_ATP2'
When I open public share for file 'Fish Ad.mov' in folder 'F_PSOFAA_S17_ATP2' and project 'P_PSOFAA_S17_ATP2'
Then I 'should' see element 'DownloadProxy' on page 'PublicSharePopup'
Then I 'should not' see element 'DownloadOriginal' on page 'PublicSharePopup'
When I refresh the page without delay
When I send public link of file 'Fish Ad.mov' from folder 'F_PSOFAA_S17_ATP2' and project 'P_PSOFAA_S17_ATP2' to following users:
| ExpireDate | UserEmails          | Message |DownloadProxy|
| 12.12.21   | U_PSOFAA_S17_2_ATP2 | hi dude |true         |
And login with details of 'U_PSOFAA_S17_2_ATP2'
And open link from email when user 'U_PSOFAA_S17_2_ATP2' received email with next subject 'shared file with you'
And click download button on public file preview page
Then I 'should' see element 'DownloadProxy' on page 'PublicFilePreview'
Then I 'should not' see element 'DownloadMaster' on page 'PublicFilePreview'


Scenario: Public share for asset to agency user (agency admin can share by default)
Meta:@gdam
@gdamemails
Given I created users with following fields:
| Email          | Role         |Access|
| U_PSOFAA_S19_1 | agency.admin |streamlined_library|
| U_PSOFAA_S19_2 | agency.user  |streamlined_library|
And logged in with details of 'U_PSOFAA_S19_1'
And uploaded file '/files/128_shortname.jpg' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When I send public link of asset '128_shortname.jpg' from collection 'My Assets' to following usersNEWLIB:
| ExpireDate | UserEmails     | Message |
| 12.12.21   | U_PSOFAA_S19_2 | hi dude |
Then I 'should' see email notification for 'Asset sharing' with field to 'U_PSOFAA_S19_2' and subject 'has shared file with you' contains following attributes:
| UserName       | Agency        | FileName    | Message |
| U_PSOFAA_S19_1 | DefaultAgency | 128_shortname.jpg | hi dude |


Scenario: Check public share for asset to user from another BU
Meta:@gdam
@gdamemails
Given I created users with following fields:
| Email          | Role         | Agency        |Access|
| U_PSOFAA_S20_1 | agency.admin | DefaultAgency |streamlined_library|
| U_PSOFAA_S20_2 | agency.user  | AnotherAgency |streamlined_library|
And logged in with details of 'U_PSOFAA_S20_1'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
When I send public link of asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| ExpireDate | UserEmails     | Message |
| 12.12.21   | U_PSOFAA_S20_2 | hi dude |
Then I 'should' see email notification for 'Asset sharing' with field to 'U_PSOFAA_S20_2' and subject 'has shared file with you' contains following attributes:
| UserName       | Agency        | FileName    | Message |
| U_PSOFAA_S20_1 | DefaultAgency | Fish Ad.mov | hi dude |

Scenario: Check public share asset to unregistered user
Meta:@gdam
@gdamemails
Given I created users with following fields:
| Email        | Role         |Access|
| U_PSOFAA_S21 | agency.admin |streamlined_library|
And logged in with details of 'U_PSOFAA_S21'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
When I send public link of asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| ExpireDate | UserEmails     | Message |
| 12.12.21   | NAU_PSOFAA_S21 | hi dude |
Then I 'should not' see email with subject 'You are invited to Adbank' sent to 'NAU_PSOFAA_S21'
And 'should' see email notification for 'Asset sharing' with field to 'NAU_PSOFAA_S21' and subject 'has shared file with you' contains following attributes:
| UserName     | Agency        | FileName    | Message |
| U_PSOFAA_S21 | DefaultAgency | Fish Ad.mov | hi dude |


Scenario: Check proxy download option on public asset page
Meta:@gdam
@gdamemails
Given I created users with following fields:
| Email          | Role         |Access|
| U_PSOFAA_S24_1 | agency.admin |streamlined_library|
| U_PSOFAA_S24_2 | agency.user  |streamlined_library|
And logged in with details of 'U_PSOFAA_S24_1'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
When I send public link of asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| ExpireDate | UserEmails     | Message | DownloadProxy |
| 12.12.21   | U_PSOFAA_S24_2 | hi dude | true          |
And login with details of 'U_PSOFAA_S24_2'
And I open link from email when user 'U_PSOFAA_S24_2' received email with next subject 'has shared file with you'
And click element 'DownloadButton' on page 'PublicFilePreview'
Then I 'should' see element 'DownloadProxy' on page 'PublicFilePreview'


Scenario: Check edit details for public share (expire date)
Meta:@gdam
@gdamemails
!--NGN-8866
Given I created users with following fields:
| Email          | Role         |Access|
| U_PSOFAA_S25_1 | agency.admin |streamlined_library|
| U_PSOFAA_S25_2 | agency.user  |streamlined_library|
And logged in with details of 'U_PSOFAA_S25_1'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
When go to the Library page for collection 'My Assets'NEWLIB
And I refresh the page
And I send public link of asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| ExpireDate | UserEmails     | Message |
| 12.12.2021 | U_PSOFAA_S25_2 | hi dude |
And login with details of 'U_PSOFAA_S25_2'
And open link from email when user 'U_PSOFAA_S25_2' received email with next subject 'has shared file with you'
Then I 'should' be on public file preview page
When I login with details of 'U_PSOFAA_S25_1'
And go to the Library page for collection 'My Assets'NEWLIB
And I refresh the page
And I send public link of asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| ExpireDate | UserEmails     | Message |
| Today      | U_PSOFAA_S25_2 | hi dude |
And login with details of 'U_PSOFAA_S25_2'
And open link from email when user 'U_PSOFAA_S25_2' received email with next subject 'has shared file with you'
Then 'should not' be on public file preview page



Scenario: Check activity on asset details after public share
Meta:@gdam
@library
Given I created users with following fields:
| Email          | Role         |Access|
| U_PSOFAA_S27_1 | agency.admin |streamlined_library|
| U_PSOFAA_S27_2 | agency.user  |streamlined_library|
And logged in with details of 'U_PSOFAA_S27_1'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
When I send public link of asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| ExpireDate | UserEmails     | Message |
| 12.12.21   | U_PSOFAA_S27_2 | hi dude |
When I go to asset 'Fish Ad.mov' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName       | Message                       | Value |
| U_PSOFAA_S27_1 | Public Link Shared by |       |

Scenario: Check activity on Dashboard after public share
Meta:@gdam
@library
Given I created users with following fields:
| Email          | Role         |Access|
| U_PSOFAA_S28_1 | agency.admin |streamlined_library,dashboard|
| U_PSOFAA_S28_2 | agency.user  |streamlined_library,dashboard|
And logged in with details of 'U_PSOFAA_S28_1'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
When I send public link of asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| ExpireDate | UserEmails     | Message |
| 12.12.21   | U_PSOFAA_S28_2 | hi dude |
And go to Dashboard page
Then I 'should'  see following activities in 'Recent Activity' section on Dashboard page:
| UserName       | Message                       | Value       |
| U_PSOFAA_S28_1 | created public link for asset | Fish Ad.mov |


Scenario: Check that shared asset is not available in search results
Meta:@gdam
@library
Given I created the following agency:
| Name           |
| A_PSOFAA_S29_1 |
| A_PSOFAA_S29_2 |
And created users with following fields:
| Email          | Role         | Agency         |  Access             |
| U_PSOFAA_S29_1 | agency.admin | A_PSOFAA_S29_1 |streamlined_library,dashboard   |
| U_PSOFAA_S29_2 | agency.user  | A_PSOFAA_S29_2 |streamlined_library,dashboard   |
And logged in with details of 'U_PSOFAA_S29_1'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
When I send public link of asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| ExpireDate | UserEmails     | Message |
| 12.12.21   | U_PSOFAA_S29_2 | hi dude |
And login with details of 'U_PSOFAA_S29_2'
And I go to Dashboard page
And search by text 'Fish Ad.mov'
Then I 'should not' see search object 'Fish Ad.mov'
When go to the Library page for collection 'My Assets'NEWLIB
Then I 'should not' see assets 'Fish Ad.mov' in the collection 'My Assets'NEWLIB


Scenario: Check that public link is not accessible for deleted assets
Meta:@gdam
@gdamemails
Given I created users with following fields:
| Email          | Role         |Access|
| U_PSOFAA_S30_1 | agency.admin |streamlined_library|
| U_PSOFAA_S30_2 | agency.user  |streamlined_library|
And logged in with details of 'U_PSOFAA_S30_1'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
When I send public link of asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| ExpireDate | UserEmails     | Message |
| 12.12.21   | U_PSOFAA_S30_2 | hi dude |
And remove asset 'Fish Ad.mov' from 'My Assets' collection
And login with details of 'U_PSOFAA_S30_2'
And open link from email when user 'U_PSOFAA_S30_2' received email with next subject 'has shared file with you'
And wait for '5' seconds
Then I should see text on page contains 'We are sorry! You do not have permission to access this area.'
And 'should not' be on public file preview page

Scenario: Check that Public share tab unavailable if more then one asset selected
Meta:@gdam
@library
Given I created users with following fields:
| Email          | Role         |  Access          |
| U_PSOFAA_S32_1 | agency.admin |streamlined_library  |
And logged in with details of 'U_PSOFAA_S32_1'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And uploaded file '/files/Fish-Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
When I select asset 'Fish Ad.mov,Fish-Ad.mov' in the 'My Assets'  library pageNEWLIB
Then I 'should not' see Public share tab on opened Share files popup in collection 'My Assets'NEWLIB

Scenario: check that user can't see tab 'comments' on shared asset
Meta:@gdam
@gdamemails
Given I created users with following fields:
| Email          | Role         |Access|
| U_PSOFAA_S33_1 | agency.admin |streamlined_library  |
| U_PSOFAA_S33_2 | agency.user  |streamlined_library  |
And logged in with details of 'U_PSOFAA_S33_1'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
When I send public link of asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| ExpireDate | UserEmails     |
| 12.12.21   | U_PSOFAA_S33_2 |
And login with details of 'U_PSOFAA_S33_2'
And open link from email when user 'U_PSOFAA_S33_2' received email with next subject 'shared file with you'
Then I 'should not' see 'Comments' tab on opened public file preview page

Scenario: check that user can't see tab 'comments' on shared asset when some user added some comment after sharing
Meta:@gdam
@gdamemails
Given I created users with following fields:
| Email          | Role         |Access|
| U_PSOFAA_S34_1 | agency.admin |streamlined_library  |
| U_PSOFAA_S34_2 | agency.user  |streamlined_library  |
And logged in with details of 'U_PSOFAA_S34_1'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
When I send public link of asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| ExpireDate | UserEmails     | Message |
| 12.12.21   | U_PSOFAA_S34_2 | hi dude |
And login with details of 'U_PSOFAA_S34_2'
And open link from email when user 'U_PSOFAA_S34_2' received email with next subject 'has shared file with you'
Then I 'should not' see 'Comments' tab on opened public file preview page

Scenario: Check activate functionality for public link in library
Meta:@gdam
@library
Given I created users with following fields:
| Email        | Role         |Access|
| U_PSOFAA_S22 | agency.admin |streamlined_library  |
And logged in with details of 'U_PSOFAA_S22'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
When I 'activate' public url for asset 'Fish Ad.mov' in collection 'My Assets'NEWLIB
And open public url from opened Share files popupNEWLIB
Then I 'should' be on public file preview page



Scenario: Check deactivate functionality for public link in library
Meta:@gdam
@library
Given I created users with following fields:
| Email        | Role         |Access|
| U_PSOFAA_S23 | agency.admin |streamlined_library  |
And logged in with details of 'U_PSOFAA_S23'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
When I 'activate' public url for asset 'Fish Ad.mov' in collection 'My Assets'NEWLIB
And I 'deactivate' public url for asset 'Fish Ad.mov' in collection 'My Assets'NEWLIB
And wait for '3' seconds
And open public url from opened Share files popupNEWLIB
Then I should see text on page contains 'We are sorry! You do not have permission to access this area.'
And 'should not' be on public file preview page