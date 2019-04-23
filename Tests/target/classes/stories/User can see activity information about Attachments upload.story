!--NGN-10118
Feature:          User can see activity information about Attachments upload
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check activity about attachments for asset and files


Scenario: Check activity about upload attachment on asset details
Meta:@gdam
@library
Given I created the agency 'A_UCSAIAAU_S01' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| E_UCSAIAAU_S01 | agency.admin | A_UCSAIAAU_S01 |streamlined_library|
When I login with details of 'E_UCSAIAAU_S01'
And upload following assetsNEWLIB:
| Name              |
| /files/_file1.gif |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And attache new file '/files/120.600.gif' into collection 'My Assets' for asset '_file1.gif' on attachment assets pageNEWLIB
And go to asset '_file1.gif' activity page in Library for collection 'My Assets'NEWLIB
And I refresh the page
Then I 'should' see the following activities on asset '_file1.gif' activity page for collection 'My Assets'NEWLIB:
| UserName       | Message                               | Value       |
| E_UCSAIAAU_S01 | Attachment Created by                 |             |



Scenario: Check activity 'attachment.updated' on file details page
Meta:@gdam
@projects
Given I created the agency 'A_UCSAIAAU_S01' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |
| E_UCSAIAAU_S02 | agency.admin | A_UCSAIAAU_S01 |
When I login with details of 'E_UCSAIAAU_S02'
And I create 'P_UUAFFAA_S02' project
And create '/folder' folder for project 'P_UUAFFAA_S02'
And upload '/files/atCalcImage.jpg' file into '/folder' folder for 'P_UUAFFAA_S02' project
And wait while transcoding is finished in folder '/folder' on project 'P_UUAFFAA_S02' files page
And go to file 'atCalcImage.jpg' info page in folder '/folder' project 'P_UUAFFAA_S02' tab attachments files
And attach new file '/images/logo.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA_S02' project
And wait for '3' seconds
And refresh the page
Then I 'should' see the activity on file 'atCalcImage.jpg' activity tab in project 'P_UUAFFAA_S02' folder '/folder':
| UserName       | Message                            | Value           |
| E_UCSAIAAU_S02 | uploaded attachment(s) logo.jpg to | atCalcImage.jpg |


Scenario: Check activity 'attachment.deleted' on project overview page
Meta:@gdam
@projects
Given I created the agency 'A_UCSAIAAU_S01' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |
| E_UCSAIAAU_S03 | agency.admin | A_UCSAIAAU_S01 |
When I login with details of 'E_UCSAIAAU_S03'
And I create 'P_UUAFFAA_S03' project
And create '/folder' folder for project 'P_UUAFFAA_S03'
And upload '/files/atCalcImage.jpg' file into '/folder' folder for 'P_UUAFFAA_S03' project
And wait while transcoding is finished in folder '/folder' on project 'P_UUAFFAA_S03' files page
And go to file 'atCalcImage.jpg' info page in folder '/folder' project 'P_UUAFFAA_S03' tab attachments files
And attach new file '/images/logo.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA_S03' project
And refresh the page
And delete attached file 'logo.jpg' on info page in tab attachments files
And wait for '5' seconds
And go to project 'P_UUAFFAA_S03' overview page
And refresh the page
Then I 'should' see following activities in 'Recent Activity' section on opened Project Overview page:
| UserName       | Message                                             | Value                   |
| E_UCSAIAAU_S03 | deleted attachment(s) logo.jpg from atCalcImage.jpg | /P_UUAFFAA_S03/folder/atCalcImage.jpg |


Scenario: Check activity uploaded attachment on Dashboard (fo file)
Meta:@gdam
@projects
Given I created the agency 'A_UCSAIAAU_S01' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |
| E_UCSAIAAU_S04 | agency.admin | A_UCSAIAAU_S01 |
When I login with details of 'E_UCSAIAAU_S04'
And I create 'P_UUAFFAA_S04' project
And create '/folder' folder for project 'P_UUAFFAA_S04'
And upload '/files/atCalcImage.jpg' file into '/folder' folder for 'P_UUAFFAA_S04' project
And wait while transcoding is finished in folder '/folder' on project 'P_UUAFFAA_S04' files page
And go to file 'atCalcImage.jpg' info page in folder '/folder' project 'P_UUAFFAA_S04' tab attachments files
And attach new file '/images/logo.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA_S04' project
And wait for '2' seconds
And go to Dashboard page
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName       | Message                                            | Value                   |
| E_UCSAIAAU_S04 | uploaded attachment(s) logo.jpg to atCalcImage.jpg | /P_UUAFFAA_S04/folder/atCalcImage.jpg |

Scenario: Check activity 'attachment.updated' on Team tab
Meta:@gdam
@projects
Given I created the agency 'A_UCSAIAAU_S01' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |
| E_UCSAIAAU_S05 | agency.admin | A_UCSAIAAU_S01 |
When I login with details of 'E_UCSAIAAU_S05'
And I create 'P_UUAFFAA_S05' project
And create '/folder' folder for project 'P_UUAFFAA_S05'
And upload '/files/atCalcImage.jpg' file into '/folder' folder for 'P_UUAFFAA_S05' project
And wait while transcoding is finished in folder '/folder' on project 'P_UUAFFAA_S05' files page
And go to file 'atCalcImage.jpg' info page in folder '/folder' project 'P_UUAFFAA_S05' tab attachments files
And attach new file '/images/logo.jpg' for file 'atCalcImage.jpg' into '/folder' folder for 'P_UUAFFAA_S05' project
And refresh the page
And updated attached file 'logo.jpg' on info page in tab attachments files
And wait for '5' seconds
And go to project 'P_UUAFFAA_S05' teams page
And refresh the page
Then I 'should' see following activities in 'Recent Activity' section on Project Team page:
| UserName       | Message                                       | Value                   |
| E_UCSAIAAU_S05 | updated attachment(s) to file atCalcImage.jpg | /P_UUAFFAA_S05/folder/atCalcImage.jpg |


Scenario: Check activity 'attachment.deleted' on asset details
Meta:@gdam
@library
Given I created the agency 'A_UCSAIAAU_S01' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| E_UCSAIAAU_S06 | agency.admin | A_UCSAIAAU_S01 |streamlined_library|
When I login with details of 'E_UCSAIAAU_S06'
And upload following assetsNEWLIB:
| Name              |
| /files/_file1.gif |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And attache new file '/files/120.600.gif' into collection 'My Assets' for asset '_file1.gif' on attachment assets pageNEWLIB
And go to asset '_file1.gif' info page in Library for collection 'My Assets' on attachment assets pageNEWLIB
And I remove attached files '120.600.gif' on asset attachments pageNEWLIB
And I wait for '5' seconds
And go to asset '_file1.gif' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset '_file1.gif' activity page for collection 'My Assets'NEWLIB:
| UserName       | Message                                | Value       |
| E_UCSAIAAU_S06 | Attachment Deleted by                  |  |