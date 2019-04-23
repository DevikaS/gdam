!--NGN-480
Feature:          Templates - Move file
Narrative:
In order to
As a              AgencyAdmin
I want to         Check moving files within template

Scenario: Check that file name correctly displayed on Move pop-up for template
Meta:@gdam
@projects
Given I created 'T_TMFS_S1_1' template
And created '/F_TMFS_S1_1' folder for template 'T_TMFS_S1_1'
And uploaded into template 'T_TMFS_S1_1' following files:
| FileName         | Path         |
| /images/logo.jpg | /F_TMFS_S1_1 |
And I am on template 'T_TMFS_S1_1' folder '/F_TMFS_S1_1' page
When I click on Want to move files to another project link on move/copy file 'logo.jpg' popup
Then I should see 'Move' 'logo.jpg' as title of move/copy file popup
And I should see please select folder where you want to 'move' file 'logo.jpg' on move/copy file popup


Scenario: Check that quantity of selected files is correctly displayed on Move pop-up in case if two files are selected at least
Meta:@gdam
@projects
Given I created 'T_TMFS_S2_1' template
And created '/F_TMFS_S2_1' folder for template 'T_TMFS_S2_1'
And uploaded into template 'T_TMFS_S2_1' following files:
| FileName           | Path         |
| /images/logo.jpg   | /F_TMFS_S2_1 |
| /files/file_1.pdf  | /F_TMFS_S2_1 |
| /images/logo.png   | /F_TMFS_S2_1 |
| /files/Fish Ad.mov | /F_TMFS_S2_1 |
And I am on template 'T_TMFS_S2_1' folder '/F_TMFS_S2_1' page
And I selected files on template files page:
| FileName    |
| logo.jpg    |
| logo.png    |
| Fish Ad.mov |
When I click move button on template files page
Then I should see 'Move' '3 files' as title of move/copy file popup
And I should see please select folder where you want to 'move' file '3 files' on move/copy file popup


Scenario: Check that Move button can be clicked only after folder selection within single template
Meta:@gdam
@projects
Given I created 'T_TMFS_S3_1' template
And created in 'T_TMFS_S3_1' template next folders:
| folder                               |
| /F_TMFS_S3_1/F_TMFS_S3_2             |
| /F_TMFS_S3_1/F_TMFS_S3_3/F_TMFS_S3_4 |
| /F_TMFS_S3_5/F_TMFS_S3_6             |
And uploaded into template 'T_TMFS_S3_1' following files:
| FileName         | Path                     |
| /images/logo.jpg | /F_TMFS_S3_1/F_TMFS_S3_2 |
And I am on template 'T_TMFS_S3_1' folder '/F_TMFS_S3_1/F_TMFS_S3_2' page
And selected file 'logo.jpg' on template files page
And I clicked move button on template files page
When I select folder '<Folder>' on move/copy file popup
Then I '<Mode>' see enabled move button on move/copy file popup

Examples:
| Folder                               | Mode       |
|                                      | should not |
| /F_TMFS_S3_1/F_TMFS_S3_3/F_TMFS_S3_4 | should     |
| /F_TMFS_S3_5/                        | should     |


Scenario: Check proper displaying folder hierarchy on Move pop-up
Meta:@gdam
@projects
Given I created 'T_TMFS_S6_1' template
And created in 'T_TMFS_S6_1' template next folders:
| folder                               |
| /F_TMFS_S6_1/F_TMFS_S6_2             |
| /F_TMFS_S6_1/F_TMFS_S6_3/F_TMFS_S6_4 |
| /F_TMFS_S6_5/F_TMFS_S6_6             |
And uploaded into template 'T_TMFS_S6_1' following files:
| FileName         | Path         |
| /images/logo.jpg | /F_TMFS_S6_1 |
And waited while preview is available in folder '/F_TMFS_S6_1' on template 'T_TMFS_S6_1' files page
And I am on template 'T_TMFS_S6_1' folder '/F_TMFS_S6_1' page
And selected file 'logo.jpg' on template files page
When I click move button on template files page
Then I should see following folders on move/copy files popup:
| folder                               |
| /F_TMFS_S6_1/F_TMFS_S6_2             |
| /F_TMFS_S6_1/F_TMFS_S6_3/F_TMFS_S6_4 |
| /F_TMFS_S6_5/F_TMFS_S6_6             |


Scenario: Check that single file is moved in templates
Meta: @skip
      @gdam
!--03/09 confirmed with Maria that this test can be skipped, we have one test anyways to cover multiple files scenario --"you can safely remove this test,no one is uploading files to templates, let alone moving them"
Given I created 'T_TMFS_S7_1' template
And created 'T_TMFS_S7_2' template
And created '/F_TMFS_S7' folder for template 'T_TMFS_S7_1'
And created '/F_TMFS_S7' folder for template 'T_TMFS_S7_2'
And uploaded '/images/logo.jpg' file into '/F_TMFS_S7' folder for 'T_TMFS_S7_1' template
When I go to template 'T_TMFS_S7_1' folder '/F_TMFS_S7' page
And click on Want to move files to another project link on move/copy file 'logo.jpg' popup
And enter 'T_TMFS_S7_2' in search field on move/copy file popup
And select folder 'F_TMFS_S7' on move/copy file popup
And click move button on move/copy files popup
When I go to template 'T_TMFS_S7_2' folder '/F_TMFS_S7' page
Then I 'should' see file 'logo.jpg' on template files page and files count are '1'
When I go to template 'T_TMFS_S7_1' folder '/F_TMFS_S7' page
Then I 'should' see file 'logo.jpg' on template files page and files count are '0'


Scenario: Check that several files can be moved
Meta: @bug
      @gdam
      @projects
!-- Fails till FAB-404 gets fixed
Given I created 'T_TMFS_S8' template
And created 'T_TMFS_S8_N' template
And created '/F_TMFS_S8' folder for template 'T_TMFS_S8'
And created '/F_TMFS_S8_N' folder for template 'T_TMFS_S8_N'
And uploaded few files '/images/logo.jpg,/images/logo.gif,/images/logo.png' with delimiter ',' into '/F_TMFS_S8' folder for 'T_TMFS_S8' template
When I go to template 'T_TMFS_S8' folder '/F_TMFS_S8' page
And click on Want to move files to another project link on move/copy file 'logo.jpg,logo.gif,logo.png' popup
And enter 'T_TMFS_S8_N' in search field on move/copy file popup
And select folder '/F_TMFS_S8_N' on move/copy file popup
And click move button on move/copy files popup
And go to template 'T_TMFS_S8_N' folder 'F_TMFS_S8_N' page
Then I 'should' see file 'logo.jpg,logo.gif,logo.png' on template files page and files count are '3'


Scenario: Check that Move button can be clicked only after folder selection in another template
Meta:@gdam
@projects
!--NGN-1886
Given I created following templates:
| Name         |
| T_TMFS_S10_1 |
| T_TMFS_S10_2 |
And created in 'T_TMFS_S10_1' template next folders:
| folder                                  |
| /F_TMFS_S10_1/F_TMFS_S10_2              |
| /F_TMFS_S10_1/F_TMFS_S10_3/F_TMFS_S10_4 |
| /F_TMFS_S10_5/F_TMFS_S10_6              |
And uploaded into template 'T_TMFS_S10_1' following files:
| FileName         | Path                       |
| /images/logo.jpg | /F_TMFS_S10_1/F_TMFS_S10_2 |
And I am on template 'T_TMFS_S10_1' folder '/F_TMFS_S10_1/F_TMFS_S10_2' page
And selected file 'logo.jpg' on project files page
And I clicked move button on project files page
And I clicked on Want to move files to another project link
And I entered 'T_TMFS_S10_2' in search field on move/copy file popup
When I select template 'T_TMFS_S10_2' on move/copy file popup
Then I 'should not' see enabled move button on move/copy file popup


Scenario: Check that file can be moved to folder where the same file is already exist (in template)
Meta:@gdam
@projects
Given created 'T_TMFS_S11_1' template
And created in 'T_TMFS_S11_1' template next folders:
| folder       |
| F_TMFS_S11_1 |
| F_TMFS_S11_2 |
And uploaded into template 'T_TMFS_S11_1' following files:
| FileName         | Path          |
| /images/logo.jpg | /F_TMFS_S11_1 |
| /images/logo.jpg | /F_TMFS_S11_2 |
And I am on template 'T_TMFS_S11_1' folder '/F_TMFS_S11_1' page
And I clicked on Want to move files to another project link on move/copy file 'logo.jpg' popup
And I selected folder 'F_TMFS_S11_2' on move/copy file popup
When I click move button on move/copy files popup
And go to template 'T_TMFS_S11_1' folder 'F_TMFS_S11_2' page
Then I 'should' see file 'logo.jpg' on project files page and files count are '2'
And I 'should' see folder name 'F_TMFS_S11_2' on files page
When I go to template 'T_TMFS_S11_1' folder 'F_TMFS_S11_1' page
Then I 'should not' see file 'logo.jpg' on project files page