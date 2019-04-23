!--NGN-480
Feature:          Project - Copy file
Narrative:
In order to
As a              AgencyAdmin
I want to         Check copying files

Meta:
@component project

Scenario: Check that file name correctly displayed on Copy pop-up
Meta:@gdam
@projects
Given I created 'P_PCFS_S7_1_1' project
And created '/F_PCFS_S1_1' folder for project 'P_PCFS_S7_1_1'
And uploaded into project 'P_PCFS_S7_1_1' following files:
| FileName          | Path         |
| /files/image10.jpg | /F_PCFS_S1_1 |
And I waited while transcoding is finished in folder '/F_PCFS_S1_1' on project 'P_PCFS_S7_1_1' files page
And I am on project 'P_PCFS_S7_1_1' folder '/F_PCFS_S1_1' page
When I click on Want to copy files to another project link on move/copy file 'image10.jpg' popup
Then I should see 'Copy' 'image10.jpg' as title of move/copy file popup
And I should see please select folder where you want to 'copy' file 'image10.jpg' on move/copy file popup


Scenario: Check that quantity of selected files is correctly displayed on Copy pop-up in case if two files are selected at least
Meta:@gdam
@projects
Given I created 'P_PCFS_S2_1' project
And created '/F_PCFS_S2_1' folder for project 'P_PCFS_S2_1'
And uploaded into project 'P_PCFS_S2_1' following files:
| FileName           | Path         |
| /files/image10.jpg  | /F_PCFS_S2_1 |
| /files/logo3.png  | /F_PCFS_S2_1 |
| /files/logo1.gif  | /F_PCFS_S2_1 |
| /files/logo2.png | /F_PCFS_S2_1 |
And I am on project 'P_PCFS_S2_1' folder '/F_PCFS_S2_1' page
And I selected files on project files page:
| FileName    |
| image10.jpg  |
| logo1.gif  |
| logo2.png |
When I click copy button on project files page
Then I should see 'Copy' '3 files' as title of move/copy file popup
And I should see please select folder where you want to 'copy' file '3 files' on move/copy file popup

Scenario: Check that Copy button can be clicked only after folder selection within single project
Meta:@gdam
@projects
Given I created 'P_PCFS_S3_1' project
And created in 'P_PCFS_S3_1' project next folders:
| folder                               |
| /F_PCFS_S3_1/F_PCFS_S3_2             |
| /F_PCFS_S3_1/F_PCFS_S3_3/F_PCFS_S3_4 |
| /F_PCFS_S3_5/F_PCFS_S3_6             |
And uploaded into project 'P_PCFS_S3_1' following files:
| FileName                | Path                     |
| /files/image10.jpg | /F_PCFS_S3_1/F_PCFS_S3_2 |
And I am on project 'P_PCFS_S3_1' folder '/F_PCFS_S3_1/F_PCFS_S3_2' page
And selected file 'image10.jpg' on project files page
And I clicked copy button on project files page
When I select folder '<Folder>' on move/copy file popup
Then I '<Mode>' see enabled copy button on move/copy file popup

Examples:
| Folder                               | Mode       |
|                                      | should not |
| /F_PCFS_S3_1/F_PCFS_S3_3/F_PCFS_S3_4 | should     |
| /F_PCFS_S3_5/                        | should     |


Scenario: Check proper displaying folder hierarchy on Copy pop-up
Meta:@gdam
@projects
Given I created 'P_PCFS_S6_1' project
And created in 'P_PCFS_S6_1' project next folders:
| folder                               |
| /F_PCFS_S6_1/F_PCFS_S6_2             |
| /F_PCFS_S6_1/F_PCFS_S6_3/F_PCFS_S6_4 |
| /F_PCFS_S6_5/F_PCFS_S6_6             |
And uploaded into project 'P_PCFS_S6_1' following files:
| FileName                | Path         |
| /files/image10.jpg | /F_PCFS_S6_1 |
And I am on project 'P_PCFS_S6_1' folder '/F_PCFS_S6_1' page
And selected file 'image10.jpg' on project files page
When I click copy button on project files page
Then I should see following folders on move/copy files popup:
| folder                               |
| /F_PCFS_S6_1/F_PCFS_S6_2             |
| /F_PCFS_S6_1/F_PCFS_S6_3/F_PCFS_S6_4 |
| /F_PCFS_S6_5/F_PCFS_S6_6             |


Scenario: Check that single file is copied on project
Meta:@gdam
@projects
Given I created users with following fields:
| Email       | Role         |
| <userEmail> | agency.admin |
And I logged in with details of '<userEmail>'
And I created following projects:
| Name        |
| P_PCFS_S7_1 |
| P_PCFS_S7_2 |
And created in 'P_PCFS_S7_1' project next folders:
| folder                   |
| /F_PCFS_S7_1             |
| /F_PCFS_S7_1/F_PCFS_S7_2 |
And created in 'P_PCFS_S7_2' project next folders:
| folder                   |
| /F_PCFS_S7_3             |
| /F_PCFS_S7_3/F_PCFS_S7_4 |
And uploaded into project '<Project>' following files:
| FileName   | Path     |
| <FilePath> | <Folder> |
And I waited while transcoding is finished in folder '<Folder>' on project '<Project>' files page
And I am on project '<Project>' folder '<Folder>' page
And I clicked on Want to copy files to another project link on move/copy file '<FileName>' popup
And I entered '<TargetProject>' in search field on move/copy file popup
And I selected folder '<TargetFolder>' on move/copy file popup
When I click copy button on move/copy files popup
And I go to project '<TargetProject>' folder '<TargetFolder>' page
Then I 'should' see file '<FileName>' on project files page and files count are '<NumberOfFiles>'
Then I 'should' see folder name '<TargetFolder>' on files page
When I go to project '<Project>' folder '<Folder>' page
Then I 'should' see file '<FileName>' on project '<Project>' folder '<Folder>' files page

Examples:
| Project     | Folder                   | TargetProject | TargetFolder             | FilePath                 | FileName          | NumberOfFiles | userEmail  |
| P_PCFS_S7_1 | /F_PCFS_S7_1             | P_PCFS_S7_1   | /F_PCFS_S7_1/F_PCFS_S7_2 | /files/128_shortname.jpg | 128_shortname.jpg | 1             | User_S_7_1 |
| P_PCFS_S7_1 | /F_PCFS_S7_1/F_PCFS_S7_2 | P_PCFS_S7_2   | /F_PCFS_S7_3             | /files/delete.avi        | delete.avi        | 1             | User_S_7_3 |
| P_PCFS_S7_2 | /F_PCFS_S7_3             | P_PCFS_S7_1   | /F_PCFS_S7_1             | /files/atCalcImage.jpg   | atCalcImage.jpg   | 1             | User_S_7_4 |

Scenario: Check that single file is copied on project within same folder
Meta:@gdam
@projects
Given I created users with following fields:
| Email       | Role         |
| <userEmail> | agency.admin |
And I logged in with details of '<userEmail>'
And I created following projects:
| Name        |
| P_PCFS_S7_1 |
| P_PCFS_S7_2 |
And created in 'P_PCFS_S7_1' project next folders:
| folder                   |
| /F_PCFS_S7_1             |
| /F_PCFS_S7_1/F_PCFS_S7_2 |
And created in 'P_PCFS_S7_2' project next folders:
| folder                   |
| /F_PCFS_S7_3             |
| /F_PCFS_S7_3/F_PCFS_S7_4 |
And uploaded into project '<Project>' following files:
| FileName   | Path     |
| <FilePath> | <Folder> |
And I waited while transcoding is finished in folder '<Folder>' on project '<Project>' files page
And I am on project '<Project>' folder '<Folder>' page
And I clicked on Want to copy files to another project link on move/copy file '<FileName>' popup
And I entered '<TargetProject>' in search field on move/copy file popup
And I selected folder '<TargetFolder>' on move/copy file popup
When I click copy button on move/copy files popup
And I go to project '<TargetProject>' folder '<TargetFolder>' page
And I refresh the page
Then I 'should' see file '<FileName>' on project files page and files count are '<NumberOfFiles>'
Then I 'should' see folder name '<TargetFolder>' on files page
When I go to project '<Project>' folder '<Folder>' page
Then I 'should' see file '<FileName>' on project '<Project>' folder '<Folder>' files page

Examples:
| Project     | Folder                   | TargetProject | TargetFolder             | FilePath                 | FileName          | NumberOfFiles | userEmail  |
| P_PCFS_S7_1 | /F_PCFS_S7_1             | P_PCFS_S7_1   | /F_PCFS_S7_1             | /files/120.600.gif       | 120.600.gif       | 2             | User_S_7_2 |
| P_PCFS_S7_2 | /F_PCFS_S7_3/F_PCFS_S7_4 | P_PCFS_S7_2   | /F_PCFS_S7_3/F_PCFS_S7_4 | /files/shortname.wav     | shortname.wav     | 2             | User_S_7_5 |

Scenario: Check that several files can be copied
Meta:@gdam
@projects
Given I created following projects:
| Name        |
| P_PCFS_S8_1 |
| P_PCFS_S8_2 |
And created '/F_PCFS_S8_1/F_PCFS_S8_2' folder for project 'P_PCFS_S8_1'
And created '/F_PCFS_S8_1/F_PCFS_S8_2N' folder for project 'P_PCFS_S8_1'
And created '/F_PCFS_S8_3/F_PCFS_S8_4' folder for project 'P_PCFS_S8_2'
And uploaded few files '<FileUpload>' with delimiter ',' into '<Folder>' folder for '<Project>' project
And I am on project '<Project>' folder '<Folder>' page
And waited while transcoding is finished in folder '<Folder>' on project '<Project>' files page
And I clicked on Want to copy files to another project link on move/copy file '<FileOnPage>' popup
And I entered '<TargetProject>' in search field on move/copy file popup
And I selected folder '<TargetFolder>' on move/copy file popup
When I click copy button on move/copy files popup
And I wait for '3' seconds
Then I 'should' see file '<FileOnPage>' on project files page and files count are '<NumberOfFiles>'
When I go to project '<Project>' folder '<Folder>' page
Then I 'should' see file '<FileOnPage>' on project files page and files count are '<OriginalNumberOfFiles>'

Examples:
| Project     | Folder                   | TargetProject | TargetFolder             | FileUpload                                            | FileOnPage                    | NumberOfFiles | OriginalNumberOfFiles |
| P_PCFS_S8_1 | /F_PCFS_S8_1             | P_PCFS_S8_1   | /F_PCFS_S8_1/F_PCFS_S8_2 | /images/logo.bmp,/images/logo.gif,/images/logo.jpeg   | logo.bmp,logo.gif,logo.jpeg   | 3             | 3                     |
| P_PCFS_S8_1 | /F_PCFS_S8_1/F_PCFS_S8_2N| P_PCFS_S8_2   | /F_PCFS_S8_3             | /images/logo.jpg,/images/logo.png,/images/SB_Logo.png | logo.jpg,logo.png,SB_Logo.png | 3             | 3                     |

Scenario: Check that deletion file from one folder does not delete it copy from the other folder
Meta:@gdam
@projects
Given I created 'P_PCFS_S9_1' project
And created in 'P_PCFS_S9_1' project next folders:
| folder        |
| /F_PCFS_S9_1  |
| /F_PCFS_S9_2  |
And uploaded into project 'P_PCFS_S9_1' following files:
| FileName                | Path         |
| /files/image10.jpg | /F_PCFS_S9_1 |
And I am on project 'P_PCFS_S9_1' folder 'F_PCFS_S9_1' page
And I clicked on Want to copy files to another project link on move/copy file 'image10.jpg' popup
And I selected folder '/F_PCFS_S9_2' on move/copy file popup
And I clicked copy button on move/copy files popup
And I am on project 'P_PCFS_S9_1' folder '/F_PCFS_S9_1' page
When I 'delete' file 'image10.jpg' from project files page
And I go to project 'P_PCFS_S9_1' folder '/F_PCFS_S9_2' page
Then I 'should' see file 'image10.jpg' on project 'P_PCFS_S9_1' folder '/F_PCFS_S9_2' files page

Scenario: Check that Copy button can be clicked only after folder selection in another project
Meta:@gdam
@projects
!--NGN-1886
Given I created following projects:
| Name         |
| P_PCFS_S11_1 |
| P_PCFS_S11_2 |
And created in 'P_PCFS_S11_1' project next folders:
| folder                                  |
| /F_PCFS_S11_1/F_PCFS_S11_2              |
| /F_PCFS_S11_1/F_PCFS_S11_3/F_PCFS_S11_4 |
| /F_PCFS_S11_5/F_PCFS_S11_6              |
And uploaded into project 'P_PCFS_S11_1' following files:
| FileName                | Path                       |
| /files/image10.jpg | /F_PCFS_S11_1/F_PCFS_S11_2 |
And I am on project 'P_PCFS_S11_1' folder '/F_PCFS_S11_1/F_PCFS_S11_2' page
And selected file 'image10.jpg' on project files page
And I clicked copy button on project files page
And I selected folder '/F_PCFS_S11_5/F_PCFS_S11_6' on move/copy file popup
And I clicked on Want to copy files to another project link
And I entered 'P_PCFS_S11_2' in search field on move/copy file popup
When I select project 'P_PCFS_S11_2' on move/copy file popup
Then I 'should not' see enabled copy button on move/copy file popup


Scenario: Check that file can be copied to folder where the same file is already exist
Meta:@gdam
@projects
Given created 'P_PCFS_S12_1' project
And created in 'P_PCFS_S12_1' project next folders:
| folder       |
| F_PCFS_S12_1 |
| F_PCFS_S12_2 |
And uploaded into project 'P_PCFS_S12_1' following files:
| FileName                | Path          |
| /files/image10.jpg | /F_PCFS_S12_1 |
| /files/image10.jpg | /F_PCFS_S12_2 |
And I am on project 'P_PCFS_S12_1' folder '/F_PCFS_S12_1' page
And I clicked on Want to copy files to another project link on move/copy file 'image10.jpg' popup
And I selected folder 'F_PCFS_S12_2' on move/copy file popup
When I click copy button on move/copy files popup
Then I 'should' see file 'image10.jpg' on project files page and files count are '2'
And I 'should' see folder name 'F_PCFS_S12_2' on files page
When I go to project 'P_PCFS_S12_1' folder 'F_PCFS_S12_1' page
Then I 'should' see file 'image10.jpg' on project 'P_PCFS_S12_1' folder 'F_PCFS_S12_1' files page


Scenario: Check that transcoded proxy and preview are available for copied file
Meta: @gdam
      @projects
Given I created following projects:
| Name         |
| P_PCFS_S13_1 |
| P_PCFS_S13_2 |
And created in 'P_PCFS_S13_1' project next folders:
| folder        |
| /F_PCFS_S13_1 |
And created in 'P_PCFS_S13_2' project next folders:
| folder        |
| /F_PCFS_S13_2 |
And uploaded into project 'P_PCFS_S13_1' following files:
| FileName           | Path          |
| /files/Fish Ad.mov | /F_PCFS_S13_1 |
And I am on project 'P_PCFS_S13_1' folder '/F_PCFS_S13_1' page
And I clicked on Want to copy files to another project link on move/copy file 'Fish Ad.mov' popup
And I entered 'P_PCFS_S13_2' in search field on move/copy file popup
And I selected folder '/F_PCFS_S13_2' on move/copy file popup
When I click copy button on move/copy files popup
And I wait while transcoding is finished in folder '/F_PCFS_S13_2' on project 'P_PCFS_S13_2' files page
Then I should see preview of file 'Video' into folder '/F_PCFS_S13_2' of project 'P_PCFS_S13_2'
When I go to file 'Fish Ad.mov' info page in folder '/F_PCFS_S13_2' project 'P_PCFS_S13_2'
Then I should see preview of video file on opened file details page
When I wait while proxy is visible on file info page
Then I 'should' see proxy of file 'Video' on file info page


Scenario: Check that in search results all copies of the file are available
Meta:@gdam
@projects
Given I created 'P_PCFS_S14_1' project
And created in 'P_PCFS_S14_1' project next folders:
| folder        |
| /F_PCFS_S14_1 |
| /F_PCFS_S14_2 |
And uploaded into project 'P_PCFS_S14_1' following files:
| FileName          | Path          |
| /files/image10.jpg | /F_PCFS_S14_1 |
| /files/image10.jpg | /F_PCFS_S14_1 |
And I am on project 'P_PCFS_S14_1' folder '/F_PCFS_S14_1' page
And I clicked on Want to copy files to another project link on move/copy file 'image10.jpg' popup
And I selected folder '/F_PCFS_S14_2' on move/copy file popup
And I clicked copy button on move/copy files popup
When I search in the 'Current project' next file 'image10' for project 'P_PCFS_S14_1' folder '/F_PCFS_S14_2'
Then I 'should' see file 'image10' and files count are '2' on the project search menu
When I click show all results link for current project
Then I should see items count '2' on the project search page


Scenario: Check that file can be copied to folder that was shared from another agency
Meta:@gdam
@projects
Given I created the following agency:
| Name        |
| A_PCF_S15_1 |
| A_PCF_S15_2 |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_PCF_S15_1 | agency.admin | A_PCF_S15_1  |
| U_PCF_S15_2 | agency.admin | A_PCF_S15_2  |
And logged in with details of 'U_PCF_S15_1'
And created 'P_PCF_S15_1' project
And created '/F_PCF_S15_1' folder for project 'P_PCF_S15_1'
And fill Share popup by users 'U_PCF_S15_2' in project 'P_PCF_S15_1' folders '/F_PCF_S15_1' with role 'project.user' expired '12.12.2022' and 'should' access to subfolders
And logged in with details of 'U_PCF_S15_2'
And created 'P_PCF_S15_2' project
And created '/F_PCF_S15_2' folder for project 'P_PCF_S15_2'
And uploaded '/files/Fish Ad.mov' file into '/F_PCF_S15_2' folder for 'P_PCF_S15_2' project
And waited while transcoding is finished in folder '/F_PCF_S15_2' on project 'P_PCF_S15_2' files page
And on project 'P_PCF_S15_2' folder '/F_PCF_S15_2' page
And clicked on Want to copy files to another project link on move/copy file 'Fish Ad.mov' popup
And entered 'P_PCF_S15_1' in search field on move/copy file popup
And selected folder 'F_PCF_S15_1' on move/copy file popup
And clicked copy button on move/copy files popup
And refreshed the page
When I login with details of 'U_PCF_S15_1'
Then I 'should' see 'Fish Ad.mov' file inside '/F_PCF_S15_1' folder for 'P_PCF_S15_1' project