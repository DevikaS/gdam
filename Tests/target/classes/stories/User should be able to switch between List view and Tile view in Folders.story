!--NGN-11678
Feature:          User should be able to switch between List view and Tile view in Folders
Narrative:
In order to:
As a              AgencyAdmin
I want to         Check that user is prompted to accept TnC before accessing project


Scenario: check that user is able to switch from Tile view to List view in Trash
Meta: @gdam
@projects
Given I created 'P_USBATSBLVATVIF_S1' project
And created '/F_USBATSBLVATVIF_S1' folder for project 'P_USBATSBLVATVIF_S1'
And uploaded into project 'P_USBATSBLVATVIF_S1' following files:
| FileName                    | Path                 |
| /files/for_babylon43.7z     | /F_USBATSBLVATVIF_S1 |
| /files/logo3.jpg            | /F_USBATSBLVATVIF_S1 |
And waited while transcoding is finished in folder '/F_USBATSBLVATVIF_S1' on project 'P_USBATSBLVATVIF_S1' files page
And deleted file 'for_babylon43.7z' in project 'P_USBATSBLVATVIF_S1' folder '/F_USBATSBLVATVIF_S1'
When I go to the Project Trash page for project 'P_USBATSBLVATVIF_S1'
And switch to 'list' view
Then I should see for project 'P_USBATSBLVATVIF_S1' trash bin page files in the 'list' view


Scenario: Check correctness of filtering in List view (all filter types)
Meta: @gdam
@projects
Given I created 'P_USBATSBLVATVIF_S3' project
And created '/F_USBATSBLVATVIF_S3' folder for project 'P_USBATSBLVATVIF_S3'
And uploaded into project 'P_USBATSBLVATVIF_S3' following files:
| FileName                                     | Path                 |
| /images/logo.jpeg                            | /F_USBATSBLVATVIF_S3 |
| /images/logo.png                             | /F_USBATSBLVATVIF_S3 |
| /images/logo.bmp                             | /F_USBATSBLVATVIF_S3 |
| /files/ISO_12233-reschart.svg                | /F_USBATSBLVATVIF_S3 |
| /files/CCITT_1.TIF                           | /F_USBATSBLVATVIF_S3 |
| /files/GWGTestfile064v3.pdf                  | /F_USBATSBLVATVIF_S3 |
| /files/video10s.avi                          | /F_USBATSBLVATVIF_S3 |
| /files/test.mp3                              | /F_USBATSBLVATVIF_S3 |
| /files/test.ogg                              | /F_USBATSBLVATVIF_S3 |
| /files/Tesco_Trade_Meat_Wine_PANTS939015.wav | /F_USBATSBLVATVIF_S3 |
| /files/index.html                            | /F_USBATSBLVATVIF_S3 |
| /files/Fish Ad.mov                           | /F_USBATSBLVATVIF_S3 |
| /files/13DV-CAPITAL-10.mpg                   | /F_USBATSBLVATVIF_S3 |
| /files/usage.docx                            | /F_USBATSBLVATVIF_S3 |
And I am on project 'P_USBATSBLVATVIF_S3' folder '/F_USBATSBLVATVIF_S3' page
When I wait while transcoding is finished in folder '/F_USBATSBLVATVIF_S3' on project 'P_USBATSBLVATVIF_S3' files page
And switch to 'list' view
And select media type filters '<Filter>' on project 'P_USBATSBLVATVIF_S3' folder '/F_USBATSBLVATVIF_S3' page
Then I should see files '<Files>' inside '/F_USBATSBLVATVIF_S3' folder for 'P_USBATSBLVATVIF_S3' project
Examples:
| Filter                          | Files                                                                                                                                                                                               |
| VIDEO                           | video10s.avi,Fish Ad.mov,13DV-CAPITAL-10.mpg                                                                                                                                                        |
| AUDIO                           | test.mp3,test.ogg,Tesco_Trade_Meat_Wine_PANTS939015.wav                                                                                                                                             |
| PRINT                           | GWGTestfile064v3.pdf                                                                                                                                                                                |
| IMAGE                           | logo.jpeg,logo.png,ISO_12233-reschart.svg,CCITT_1.TIF,logo.bmp                                                                                                                                      |
| DIGITAL                         | index.html                                                                                                                                                                                          |
| DOCUMENT                        | usage.docx                                                                                                                                                                                          |
| VIDEO,AUDIO                     | video10s.avi,Fish Ad.mov,13DV-CAPITAL-10.mpg,test.mp3,test.ogg,Tesco_Trade_Meat_Wine_PANTS939015.wav                                                                                                |
| IMAGE,AUDIO,VIDEO,PRINT,DIGITAL | video10s.avi,Fish Ad.mov,13DV-CAPITAL-10.mpg,test.mp3,test.ogg,Tesco_Trade_Meat_Wine_PANTS939015.wav,index.html,GWGTestfile064v3.pdf,logo.jpeg,logo.png,ISO_12233-reschart.svg,CCITT_1.TIF,logo.bmp |


Scenario: Check that sorting display correct results after scrolling long list (NGN-11414)
Meta:@gdam
@projects
Given I created 'P_USBATSBLVATVIF_S4' project
And created '/F_USBATSBLVATVIF_S4' folder for project 'P_USBATSBLVATVIF_S4'
And uploaded into project 'P_USBATSBLVATVIF_S4' following files:
| FileName                                     | Path                 |
| /images/logo.jpeg                            | /F_USBATSBLVATVIF_S4 |
| /images/logo.png                             | /F_USBATSBLVATVIF_S4 |
| /images/logo.bmp                             | /F_USBATSBLVATVIF_S4 |
| /files/ISO_12233-reschart.svg                | /F_USBATSBLVATVIF_S4 |
| /files/CCITT_1.TIF                           | /F_USBATSBLVATVIF_S4 |
| /files/logo1.gif                             | /F_USBATSBLVATVIF_S4 |
| /files/video10s.avi                          | /F_USBATSBLVATVIF_S4 |
| /files/test.mp3                              | /F_USBATSBLVATVIF_S4 |
| /images/empty.logo.png                       | /F_USBATSBLVATVIF_S4 |
| /files/Tesco_Trade_Meat_Wine_PANTS939015.wav | /F_USBATSBLVATVIF_S4 |
| /images/empty.project.logo.png               | /F_USBATSBLVATVIF_S4 |
| /files/Fish Ad.mov                           | /F_USBATSBLVATVIF_S4 |
| /files/13DV-CAPITAL-10.mpg                   | /F_USBATSBLVATVIF_S4 |
| /files/128_shortname.jpg                     | /F_USBATSBLVATVIF_S4 |
| /files/image10.jpg                           | /F_USBATSBLVATVIF_S4 |
| /files/boxed-join.avi                        | /F_USBATSBLVATVIF_S4 |
| /files/audio01.mp3                           | /F_USBATSBLVATVIF_S4 |
| /files/audio02.mp3                           | /F_USBATSBLVATVIF_S4 |
| /files/audio03.mp3                           | /F_USBATSBLVATVIF_S4 |
| /images/branding_logo.png                    | /F_USBATSBLVATVIF_S4 |
| /images/big.logo.png                         | /F_USBATSBLVATVIF_S4 |
| /images/bg_img.jpg                           | /F_USBATSBLVATVIF_S4 |
| /images/admin.logo.jpg                       | /F_USBATSBLVATVIF_S4 |
| /images/SB_Logo.png                          | /F_USBATSBLVATVIF_S4 |
| /files/4002c.ai                              | /F_USBATSBLVATVIF_S4 |
| /files/test6.jar                             | /F_USBATSBLVATVIF_S4 |
And I am on project 'P_USBATSBLVATVIF_S4' folder '/F_USBATSBLVATVIF_S4' page
When I wait while transcoding is finished in folder '/F_USBATSBLVATVIF_S4' on project 'P_USBATSBLVATVIF_S4' files page
And switch to 'list' view
And scroll down to number of file is '25' on project 'P_USBATSBLVATVIF_S4' folder '/F_USBATSBLVATVIF_S4' page
And I sort files list view in project 'P_USBATSBLVATVIF_S4' folder '/F_USBATSBLVATVIF_S4' by column '<Column>' order '<Order>'
Then I should see not less than '20' files for project 'P_USBATSBLVATVIF_S4' folder '/F_USBATSBLVATVIF_S4'
When scroll down to number of file is '25' on project 'P_USBATSBLVATVIF_S4' folder '/F_USBATSBLVATVIF_S4' page
Then I should see sorting files by '<Result>' on project 'P_USBATSBLVATVIF_S4' folder '/F_USBATSBLVATVIF_S4'

Examples:
| Column | Order | Result            |
| Title  | asc   | Title (A to Z)    |
| Title  | desc  | Title (Z to A)    |
| Size   | asc   | Size (Ascending)  |
| Size   | desc  | Size (Descending) |


Scenario: Check that user selected view type is remembered (NGN-11415)
Meta: @gdam
@projects
Given I created 'P_USBATSBLVATVIF_S5' project
And created '/F_USBATSBLVATVIF_S5' folder for project 'P_USBATSBLVATVIF_S5'
And uploaded into project 'P_USBATSBLVATVIF_S5' following files:
| FileName                                     | Path                 |
| /images/logo.jpeg                            | /F_USBATSBLVATVIF_S5 |
| /files/test6.jar                             | /F_USBATSBLVATVIF_S5 |
And I am on project 'P_USBATSBLVATVIF_S5' folder '/F_USBATSBLVATVIF_S5' page
When I wait while transcoding is finished in folder '/F_USBATSBLVATVIF_S5' on project 'P_USBATSBLVATVIF_S5' files page
And switch to 'list' view
And go to Dashboard page
And go to project 'P_USBATSBLVATVIF_S5' folder '/F_USBATSBLVATVIF_S5' page
Then I should see for project 'P_USBATSBLVATVIF_S5' folder '/F_USBATSBLVATVIF_S5' page files in the 'list' view
When I switch to 'tile' view
And go to Dashboard page
And go to project 'P_USBATSBLVATVIF_S5' folder '/F_USBATSBLVATVIF_S5' page
Then I should see for project 'P_USBATSBLVATVIF_S5' folder '/F_USBATSBLVATVIF_S5' page files in the 'tile' view


Scenario: Check that user sees same projectsfolder filter settings for all accessible BUs
Meta: @gdam
@projects
!--QA-1014
Given I created the agency 'BU_CU_S01_1' with default attributes
And created the agency 'BU_CU_S01_2' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CU_S01_1 | agency.admin | BU_CU_S01_1  |
And logged in with details of 'U_CU_S01_1'
And created 'PR_CU_S01_1' project
And created '/FR_CU_S01_1' folder for project 'PR_CU_S01_1'
And on project 'PR_CU_S01_1' folder '/FR_CU_S01_1' page
And I switched to 'list' view
And 'delete' following project column 'Size;Details;Statuses' on opened Project folder page
And 'add' following project column 'Last Updated;Title' on opened Project folder page
And I added existing user 'U_CU_S01_1' to agency 'BU_CU_S01_2' with role 'agency.user'
And created following projects:
| Name        | Business Unit |
| PR_CU_S02_1 | BU_CU_S01_2   |
And created '/FR_CU_S02_1' folder for project 'PR_CU_S02_1'
And I logout from account
And logged in with details of 'U_CU_S01_1'
When I go to project 'PR_CU_S02_1' folder '/FR_CU_S02_1' page
Then I 'should' see following project fields on project folder page:
| Last Updated | Title |
And I 'should not' see following project fields on project folder page:
| Size | Details | Statuses |
When I go to project 'PR_CU_S01_1' folder '/FR_CU_S01_1' page
Then I 'should' see following project fields on project folder page:
| Last Updated | Title |
And I 'should not' see following project fields on project folder page:
| Size | Details | Statuses |


Scenario: Check that user sees same sorting field for projectsfolder filter settings for all accessible BUs
Meta: @gdam
@projects
!--QA-1014
Given I created the agency 'BU_CU_S02_1' with default attributes
And created the agency 'BU_CU_S02_2' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| U_CU_S01_2 | agency.admin | BU_CU_S02_1  |
And logged in with details of 'U_CU_S01_2'
And created 'PR_CU_S01_1' project
And created '/FR_CU_S01_1' folder for project 'PR_CU_S01_1'
And uploaded into project 'PR_CU_S01_1' following files:
| FileName                      | Path         |
| /files/image10.jpg            | /FR_CU_S01_1 |
| /images/logo.bmp              | /FR_CU_S01_1 |
| /files/128_shortname.jpg      | /FR_CU_S01_1 |
| /files/ISO_12233-reschart.svg | /FR_CU_S01_1 |
| /files/CCITT_1.TIF            | /FR_CU_S01_1 |
And on project 'PR_CU_S01_1' folder '/FR_CU_S01_1' page
And waited while transcoding is finished in folder '/FR_CU_S01_1' on project 'PR_CU_S01_1' files page
And switched to 'list' view
And 'delete' following project column 'Size;Details;Statuses' on opened Project folder page
And 'add' following project column 'Last Updated;Title' on opened Project folder page
When I sort files list view in project 'PR_CU_S01_1' folder '/FR_CU_S01_1' by column 'Title' order 'asc'
Then I should see sorting files by 'Title (A to Z)' on project 'PR_CU_S01_1' folder '/FR_CU_S01_1'
When I add existing user 'U_CU_S01_2' to agency 'BU_CU_S02_2' with role 'agency.user'
And create following projects:
| Name        | Business Unit |
| PR_CU_S02_1 | BU_CU_S02_2   |
And create '/FR_CU_S02_1' folder for project 'PR_CU_S02_1'
And upload into project 'PR_CU_S02_1' following files:
| FileName                   | Path         |
| /files/13DV-CAPITAL-10.mpg | /FR_CU_S02_1 |
| /files/128_shortname.jpg   | /FR_CU_S02_1 |
| /images/SB_Logo.png        | /FR_CU_S02_1 |
| /files/image10.jpg         | /FR_CU_S02_1 |
| /files/boxed-join.avi      | /FR_CU_S02_1 |
| /files/audio01.mp3         | /FR_CU_S02_1 |
And I logout from account
And login with details of 'U_CU_S01_2'
And go to project 'PR_CU_S02_1' folder '/FR_CU_S02_1' page
And wait while transcoding is finished in folder '/FR_CU_S02_1' on project 'PR_CU_S02_1' files page
Then I should see sorting files by 'Title (A to Z)' on project 'PR_CU_S02_1' folder '/FR_CU_S02_1'