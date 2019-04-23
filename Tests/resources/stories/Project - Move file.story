!--NGN-480
Feature:          Project - Move file
Narrative:
In order to
As a              AgencyAdmin
I want to         Check moving files

Meta:
@component project

Scenario: Check that file name correctly displayed on Move pop-up for project
Meta:@gdam
@projects
Given I created 'P_PMFS_S1_1' project
And created '/F_PMFS_S1_1' folder for project 'P_PMFS_S1_1'
And uploaded into project 'P_PMFS_S1_1' following files:
| FileName   | Path         |
| <FilePath> | /F_PMFS_S1_1 |
And I am on project 'P_PMFS_S1_1' folder '/F_PMFS_S1_1' page
When I click on Want to move files to another project link on move/copy file '<FileName>' popup
Then I should see 'Move' '<FileName>' as title of move/copy file popup
And I should see please select folder where you want to 'move' file '<FileName>' on move/copy file popup

Examples:
| FilePath              | FileName       |
| /files/logo3.unkwnown | logo3.unkwnown |
| /files/logo3.jpg      | logo3.jpg      |
| /files/logo3          | logo3          |

Scenario: Check that quantity of selected files is correctly displayed on Move pop-up in case if two files are selected at least
Meta:@gdam
@projects
Given I created 'P_PMFS_S2_1' project
And created '/F_PMFS_S2_1' folder for project 'P_PMFS_S2_1'
And uploaded into project 'P_PMFS_S2_1' following files:
| FileName           | Path         |
| /files/image10.jpg | /F_PMFS_S2_1 |
| /files/logo3.jpg   | /F_PMFS_S2_1 |
| /files/logo4.bmp   | /F_PMFS_S2_1 |
| /files/logo1.gif   | /F_PMFS_S2_1 |
And I am on project 'P_PMFS_S2_1' folder '/F_PMFS_S2_1' page
And I selected files on project files page:
| FileName    |
| image10.jpg |
| logo4.bmp   |
| logo1.gif   |
When I click move button on project files page
Then I should see 'Move' '3 files' as title of move/copy file popup
And I should see please select folder where you want to 'move' file '3 files' on move/copy file popup


Scenario: Check that Move button can be clicked only after folder selection within single project
Meta:@gdam
@projects
Given I created 'P_PMFS_S3_1' project
And created in 'P_PMFS_S3_1' project next folders:
| folder                               |
| /F_PMFS_S3_1/F_PMFS_S3_2             |
| /F_PMFS_S3_1/F_PMFS_S3_3/F_PMFS_S3_4 |
| /F_PMFS_S3_5/F_PMFS_S3_6             |
And uploaded into project 'P_PMFS_S3_1' following files:
| FileName                | Path                     |
| /files/image10.jpg | /F_PMFS_S3_1/F_PMFS_S3_2 |
And I am on project 'P_PMFS_S3_1' folder '/F_PMFS_S3_1/F_PMFS_S3_2' page
And selected file 'image10.jpg' on project files page
And I clicked move button on project files page
When I select folder '<Folder>' on move/copy file popup
Then I '<Mode>' see enabled move button on move/copy file popup

Examples:
| Folder                               | Mode       |
|                                      | should not |
| /F_PMFS_S3_1/F_PMFS_S3_3/F_PMFS_S3_4 | should     |
| /F_PMFS_S3_5/                        | should     |


Scenario: Check proper displaying folder hierarchy on Move pop-up
Meta:@gdam
@projects
Given I created 'P_PMFS_S6_1' project
And created in 'P_PMFS_S6_1' project next folders:
| folder                               |
| /F_PMFS_S6_1/F_PMFS_S6_2             |
| /F_PMFS_S6_1/F_PMFS_S6_3/F_PMFS_S6_4 |
| /F_PMFS_S6_5/F_PMFS_S6_6             |
And uploaded into project 'P_PMFS_S6_1' following files:
| FileName                | Path         |
| /files/image10.jpg | /F_PMFS_S6_1 |
And I am on project 'P_PMFS_S6_1' folder '/F_PMFS_S6_1' page
And selected file 'image10.jpg' on project files page
When I click move button on project files page
Then I should see following folders on move/copy files popup:
| folder                               |
| /F_PMFS_S6_1/F_PMFS_S6_2             |
| /F_PMFS_S6_1/F_PMFS_S6_3/F_PMFS_S6_4 |
| /F_PMFS_S6_5/F_PMFS_S6_6             |


Scenario: Check that single file is moved
Meta:@gdam
@projects
Given I created following projects:
| Name        |
| P_PMFS_S7_1 |
| P_PMFS_S7_2 |
And created in 'P_PMFS_S7_1' project next folders:
| folder                   |
| /F_PMFS_S7_1             |
| /F_PMFS_S7_1/F_PMFS_S7_2 |
And created in 'P_PMFS_S7_2' project next folders:
| folder                   |
| /F_PMFS_S7_3             |
| /F_PMFS_S7_3/F_PMFS_S7_4 |
And uploaded into project '<Project>' following files:
| FileName   | Path     |
| <FilePath> | <Folder> |
And I am on project '<Project>' folder '<Folder>' page
And I clicked on Want to move files to another project link on move/copy file '<FileName>' popup
And I entered '<TargetProject>' in search field on move/copy file popup
And I selected folder '<TargetFolder>' on move/copy file popup
When I click move button on move/copy files popup
Then I 'should' see file '<FileName>' on project '<TargetProject>' folder '<TargetFolder>' files page
And 'should' see folder name '<TargetFolder>' on files page
And 'should not' see file '<FileName>' on project '<Project>' folder '<Folder>' files page

Examples:
| Project     | Folder                   | TargetProject | TargetFolder             | FilePath                   | FileName            |
| P_PMFS_S7_1 | /F_PMFS_S7_1             | P_PMFS_S7_1   | /F_PMFS_S7_1/F_PMFS_S7_2 | /files/_file1.gif          | _file1.gif          |
| P_PMFS_S7_1 | /F_PMFS_S7_1/F_PMFS_S7_2 | P_PMFS_S7_2   | /F_PMFS_S7_3             | /files/atCalcImage.jpg     | atCalcImage.jpg     |
| P_PMFS_S7_2 | /F_PMFS_S7_3             | P_PMFS_S7_1   | /F_PMFS_S7_1             | /files/13DV-CAPITAL-10.mpg | 13DV-CAPITAL-10.mpg |
| P_PMFS_S7_2 | /F_PMFS_S7_3/F_PMFS_S7_4 | P_PMFS_S7_2   | /F_PMFS_S7_3             | /files/file2_.gif          | file2_.gif          |


Scenario: Check that several files can be moved
Meta:@gdam
@projects
Given I created following projects:
| Name        |
| P_PMFS_S8_1 |
| P_PMFS_S8_2 |
And created in 'P_PMFS_S8_1' project next folders:
| folder                   |
| /F_PMFS_S8_1             |
| /F_PMFS_S8_1/F_PMFS_S8_2 |
And created in 'P_PMFS_S8_2' project next folders:
| folder                   |
| /F_PMFS_S8_3             |
| /F_PMFS_S8_3/F_PMFS_S8_4 |
And uploaded few files '<FileUpload>' with delimiter ',' into '<Folder>' folder for '<Project>' project
And I am on project '<Project>' folder '<Folder>' page
And I clicked on Want to move files to another project link on move/copy file '<FileOnPage>' popup
And I entered '<TargetProject>' in search field on move/copy file popup
And I selected folder '<TargetFolder>' on move/copy file popup
When I click move button on move/copy files popup
Then I 'should' see file '<FileOnPage>' on project '<TargetProject>' folder '<TargetFolder>' files page
And 'should' see folder name '<TargetFolder>' on files page
And 'should not' see file '<FileOnPage>' on project '<Project>' folder '<Folder>' files page

Examples:
| Project     | Folder                   | TargetProject | TargetFolder             | FileUpload                                                            | FileOnPage                                    |
| P_PMFS_S8_1 | /F_PMFS_S8_1             | P_PMFS_S8_1   | /F_PMFS_S8_1/F_PMFS_S8_2 | /images/logo.bmp,/images/logo.gif,/images/logo.jpeg                   | logo.bmp,logo.gif,logo.jpeg                   |
| P_PMFS_S8_1 | /F_PMFS_S8_1/F_PMFS_S8_2 | P_PMFS_S8_2   | /F_PMFS_S8_3             | /images/logo.jpg,/images/logo.png,/images/SB_Logo.png                 | logo.jpg,logo.png,SB_Logo.png                 |
| P_PMFS_S8_2 | /F_PMFS_S8_3             | P_PMFS_S8_1   | /F_PMFS_S8_1             | /images/admin.logo.jpg,/images/big.logo.png,/images/branding_logo.png | admin.logo.jpg,big.logo.png,branding_logo.png |


Scenario: Check that Move button can be clicked only after folder selection in another project
Meta:@gdam
@projects
!--NGN-1886
Given I created following projects:
| Name         |
| P_PMFS_S10_1 |
| P_PMFS_S10_2 |
And created in 'P_PMFS_S10_1' project next folders:
| folder                                  |
| /F_PMFS_S10_1/F_PMFS_S10_2              |
| /F_PMFS_S10_1/F_PMFS_S10_3/F_PMFS_S10_4 |
| /F_PMFS_S10_5/F_PMFS_S10_6              |
And uploaded into project 'P_PMFS_S10_1' following files:
| FileName                | Path                       |
| /files/image10.jpg | /F_PMFS_S10_1/F_PMFS_S10_2 |
And I am on project 'P_PMFS_S10_1' folder '/F_PMFS_S10_1/F_PMFS_S10_2' page
And selected file 'image10.jpg' on project files page
And I clicked move button on project files page
And I selected folder '/F_PMFS_S10_5/F_PMFS_S10_6' on move/copy file popup
And I clicked on Want to move files to another project link
And I entered 'P_PMFS_S10_2' in search field on move/copy file popup
When I select project 'P_PMFS_S10_2' on move/copy file popup
Then I 'should not' see enabled move button on move/copy file popup


Scenario: Check that file can be moved to folder where the same file is already exist (in project)
Meta:@gdam
@projects
Given created 'P_PMFS_S11_1' project
And created in 'P_PMFS_S11_1' project next folders:
| folder       |
| F_PMFS_S11_1 |
| F_PMFS_S11_2 |
And uploaded into project 'P_PMFS_S11_1' following files:
| FileName          | Path          |
| /files/_file1.gif | /F_PMFS_S11_1 |
| /files/_file1.gif | /F_PMFS_S11_2 |
And I am on project 'P_PMFS_S11_1' folder '/F_PMFS_S11_1' page
And I clicked on Want to move files to another project link on move/copy file '_file1.gif' popup
And I selected folder 'F_PMFS_S11_2' on move/copy file popup
When I click move button on move/copy files popup
And go to project 'P_PMFS_S11_1' folder 'F_PMFS_S11_2' page
Then I 'should' see file '_file1.gif' on project files page and files count are '2'
And I 'should' see folder name 'F_PMFS_S11_2' on files page
When I go to project 'P_PMFS_S11_1' folder 'F_PMFS_S11_1' page
Then I 'should not' see file '_file1.gif' on project 'P_PMFS_S11_1' folder 'F_PMFS_S11_1' files page


Scenario: Check that transcoded proxy and preview are available for moved file
Meta: @gdam
      @projects
Given I created following projects:
| Name         |
| P_PMFS_S12_1 |
| P_PMFS_S12_2 |
And created in 'P_PMFS_S12_1' project next folders:
| folder        |
| /F_PMFS_S12_1 |
And created in 'P_PMFS_S12_2' project next folders:
| folder        |
| /F_PMFS_S12_2 |
And uploaded into project 'P_PMFS_S12_1' following files:
| FileName           | Path          |
| /files/Fish Ad.mov | /F_PMFS_S12_1 |
And waited while preview is available in folder '/F_PMFS_S12_1' on project 'P_PMFS_S12_1' files page
And I am on project 'P_PMFS_S12_1' folder '/F_PMFS_S12_1' page
And I clicked on Want to move files to another project link on move/copy file 'Fish Ad.mov' popup
And I entered 'P_PMFS_S12_2' in search field on move/copy file popup
And I selected folder '/F_PMFS_S12_2' on move/copy file popup
When I click move button on move/copy files popup
Then I should see preview of file 'Video' into folder '/F_PMFS_S12_2' of project 'P_PMFS_S12_2'
When I go to file 'Fish Ad.mov' info page in folder '/F_PMFS_S12_2' project 'P_PMFS_S12_2'
Then I 'should' see proxy of file 'Video' on file info page


Scenario: Check that file can be moved to folder that was shared from another agency
Meta:@gdam
@projects
Given I created the following agency:
| Name        |
| A_PMF_S13_1 |
| A_PMF_S13_2 |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| U_PMF_S13_1 | agency.admin | A_PMF_S13_1  |
| U_PMF_S13_2 | agency.admin | A_PMF_S13_2  |
And logged in with details of 'U_PMF_S13_1'
And created 'P_PMF_S13_1' project
And created '/F_PMF_S13_1' folder for project 'P_PMF_S13_1'
And fill Share popup by users 'U_PMF_S13_2' in project 'P_PMF_S13_1' folders '/F_PMF_S13_1' with role 'project.user' expired '12.12.2022' and 'should' access to subfolders
And logged in with details of 'U_PMF_S13_2'
And created 'P_PMF_S13_2' project
And created '/F_PMF_S13_2' folder for project 'P_PMF_S13_2'
And uploaded '/files/Fish Ad.mov' file into '/F_PMF_S13_2' folder for 'P_PMF_S13_2' project
And waited while transcoding is finished in folder '/F_PMF_S13_2' on project 'P_PMF_S13_2' files page
And on project 'P_PMF_S13_2' folder '/F_PMF_S13_2' page
And clicked on Want to move files to another project link on move/copy file 'Fish Ad.mov' popup
And entered 'P_PMF_S13_1' in search field on move/copy file popup
And selected folder 'F_PMF_S13_1' on move/copy file popup
And clicked move button on move/copy files popup
And refreshed the page
When I login with details of 'U_PMF_S13_1'
Then I 'should' see 'Fish Ad.mov' file inside '/F_PMF_S13_1' folder for 'P_PMF_S13_1' project