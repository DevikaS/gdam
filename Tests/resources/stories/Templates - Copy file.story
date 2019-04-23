!--NGN-480
Feature:          Templates - Copy file
Narrative:
In order to
As a              AgencyAdmin
I want to         Check copying files within Templates

Scenario: Check that file name correctly displayed on Copy pop-up
Meta:@gdam
@projects
Given I created 'T_TCFS_S1_1' template
And created '/F_TCFS_S1_1' folder for template 'T_TCFS_S1_1'
And uploaded into template 'T_TCFS_S1_1' following files:
| FileName         | Path         |
| /images/logo.jpg | /F_TCFS_S1_1 |
And I am on template 'T_TCFS_S1_1' folder '/F_TCFS_S1_1' page
When I click on Want to copy files to another project link on move/copy file 'logo.jpg' popup
Then I should see 'Copy' 'logo.jpg' as title of move/copy file popup
And I should see please select folder where you want to 'copy' file 'logo.jpg' on move/copy file popup


Scenario: Check that quantity of selected files is correctly displayed on Move pop-up in case if two files are selected at least
Meta:@gdam
@projects
Given I created 'T_TCFS_S2_1' template
And created '/F_TCFS_S2_1' folder for template 'T_TCFS_S2_1'
And uploaded into template 'T_TCFS_S2_1' following files:
| FileName           | Path         |
| /images/logo.jpg   | /F_TCFS_S2_1 |
| /files/file_1.pdf  | /F_TCFS_S2_1 |
| /images/logo.png   | /F_TCFS_S2_1 |
| /files/Fish Ad.mov | /F_TCFS_S2_1 |
And I am on template 'T_TCFS_S2_1' folder '/F_TCFS_S2_1' page
And I selected files on template files page:
| FileName    |
| logo.jpg    |
| logo.png    |
| Fish Ad.mov |
When I click copy button on template files page
Then I should see 'Copy' '3 files' as title of move/copy file popup
And I should see please select folder where you want to 'copy' file '3 files' on move/copy file popup


Scenario: Check that Copy button can be clicked only after folder selection within single template
Meta:@gdam
@projects
Given I created 'T_TCFS_S3_1' template
And created in 'T_TCFS_S3_1' template next folders:
| folder                               |
| /F_TCFS_S3_1/F_TCFS_S3_2             |
| /F_TCFS_S3_1/F_TCFS_S3_3/F_TCFS_S3_4 |
| /F_TCFS_S3_5/F_TCFS_S3_6             |
And uploaded into template 'T_TCFS_S3_1' following files:
| FileName         | Path                     |
| /images/logo.jpg | /F_TCFS_S3_1/F_TCFS_S3_2 |
And I am on template 'T_TCFS_S3_1' folder '/F_TCFS_S3_1/F_TCFS_S3_2' page
And selected file 'logo.jpg' on template files page
And I clicked move button on template files page
When I select folder '<Folder>' on move/copy file popup
Then I '<Mode>' see enabled move button on move/copy file popup

Examples:
| Folder                               | Mode       |
|                                      | should not |
| /F_TCFS_S3_1/F_TCFS_S3_3/F_TCFS_S3_4 | should     |
| /F_TCFS_S3_5/                        | should     |


Scenario: Check proper displaying folder hierarchy on Copy pop-up
Meta:@gdam
@projects
Given I created 'T_TCFS_S6_1' template
And created in 'T_TCFS_S6_1' template next folders:
| folder                               |
| /F_TCFS_S6_1/F_TCFS_S6_2             |
| /F_TCFS_S6_1/F_TCFS_S6_3/F_TCFS_S6_4 |
| /F_TCFS_S6_5/F_TCFS_S6_6             |
And uploaded into template 'T_TCFS_S6_1' following files:
| FileName         | Path         |
| /images/logo.jpg | /F_TCFS_S6_1 |
And I am on template 'T_TCFS_S6_1' folder '/F_TCFS_S6_1' page
And selected file 'logo.jpg' on template files page
When I click copy button on template files page
Then I should see following folders on move/copy files popup:
| folder                               |
| /F_TCFS_S6_1/F_TCFS_S6_2             |
| /F_TCFS_S6_1/F_TCFS_S6_3/F_TCFS_S6_4 |
| /F_TCFS_S6_5/F_TCFS_S6_6             |


Scenario: Check that single file is copied on template
Meta: @bug
      @gdam
      @projects
!-- Fails till FAB-404 gets fixed
Given I created 'T_TCFS_S7_1' template
And created 'T_TCFS_S7_2' template
And created '/F_TCFS_S7' folder for template 'T_TCFS_S7_1'
And created '/F_TCFS_S7' folder for template 'T_TCFS_S7_2'
And uploaded '/images/logo.jpg' file into '/F_TCFS_S7' folder for 'T_TCFS_S7_1' template
When I go to template 'T_TCFS_S7_1' folder '/F_TCFS_S7' page
And click on Want to copy files to another project link on move/copy file 'logo.jpg' popup
And enter 'T_TCFS_S7_2' in search field on move/copy file popup
And select folder '/F_TCFS_S7' on move/copy file popup
And click copy button on move/copy files popup
When I go to template 'T_TCFS_S7_2' folder '/F_TCFS_S7' page
Then I 'should' see file 'logo.jpg' on template files page and files count are '1'
When I go to template 'T_TCFS_S7_1' folder '/F_TCFS_S7' page
Then I 'should' see file 'logo.jpg' on template files page and files count are '1'


Scenario: Check that several files can be copied
Meta: @skip
      @gdam
!--03/09 confirmed with Maria that this test can be skipped, we have one test anyways to cover multiple files scenario --"you can safely remove this test,no one is uploading files to templates, let alone moving them"
Given I created 'T_TCFS_S8' template
And created '/F_TCFS_S8' folder for template 'T_TCFS_S8'
And uploaded few files '/images/logo.jpg,/images/logo.gif,/images/logo.png' with delimiter ',' into '/F_TCFS_S8' folder for 'T_TCFS_S8' template
When I go to template 'T_TCFS_S8' folder '/F_TCFS_S8' page
And click on Want to copy files to another project link on move/copy file 'logo.jpg,logo.gif,logo.png' popup
And enter 'T_TCFS_S8' in search field on move/copy file popup
And select folder '/F_TCFS_S8' on move/copy file popup
And click copy button on move/copy files popup
Then I 'should' see file 'logo.jpg,logo.gif,logo.png' on template files page and files count are '2'
And I 'should' see folder name '/F_TCFS_S8' on files page
When I go to template 'T_TCFS_S8' folder 'F_TCFS_S8' page
Then I 'should' see file 'logo.jpg,logo.gif,logo.png' on template files page and files count are '2'


Scenario: Check that deletion file from one folder does not delete it copy from the other folder
Meta:@gdam
@projects
Given I created 'T_TCFS_S9_1' template
And created in 'T_TCFS_S9_1' template next folders:
| folder       |
| /F_TCFS_S9_1 |
| /F_TCFS_S9_2 |
And uploaded into template 'T_TCFS_S9_1' following files:
| FileName         | Path         |
| /images/logo.jpg | /F_TCFS_S9_1 |
And waited for '3' seconds
And I waited while transcoding is finished in folder 'F_TCFS_S9_1' on template 'T_TCFS_S9_1' files page
And I am on template 'T_TCFS_S9_1' folder 'F_TCFS_S9_1' page
And I clicked on Want to copy files to another project link on move/copy file 'logo.jpg' popup
And I selected folder '/F_TCFS_S9_2' on move/copy file popup
And I clicked copy button on move/copy files popup
And I am on template 'T_TCFS_S9_1' folder '/F_TCFS_S9_1' page
When I 'delete' file 'logo.jpg' from template files page
And wait for '2' seconds
Then I 'should' see file 'logo.jpg' on template 'T_TCFS_S9_1' folder '/F_TCFS_S9_2' files page


Scenario: Check that Copy button can be clicked only after folder selection in another template
Meta:@gdam
@projects
!-- NGN-1886
Given I created following templates:
| Name         |
| T_TMFS_S12_1 |
| T_TMFS_S12_2 |
And created in 'T_TMFS_S12_1' template next folders:
| folder                                  |
| /F_TMFS_S12_1/F_TMFS_S12_2              |
| /F_TMFS_S12_1/F_TMFS_S12_3/F_TMFS_S12_4 |
| /F_TMFS_S12_5/F_TMFS_S12_6              |
And uploaded into template 'T_TMFS_S12_1' following files:
| FileName         | Path                       |
| /images/logo.jpg | /F_TMFS_S12_1/F_TMFS_S12_2 |
And I am on template 'T_TMFS_S12_1' folder '/F_TMFS_S12_1/F_TMFS_S12_2' page
And selected file 'logo.jpg' on project files page
And I clicked copy button on project files page
And I clicked on Want to copy files to another project link
And I entered 'T_TMFS_S12_2' in search field on move/copy file popup
When I select template 'T_TMFS_S12_2' on move/copy file popup
Then I 'should not' see enabled move button on move/copy file popup


Scenario: Check that file can be copied to folder where the same file is already exist
Meta:@gdam
@projects
!-- NGN-2183
Given created 'T_TCFS_S14' template
And created '/F_TCFS_S14_1' folder for template 'T_TCFS_S14'
And created '/F_TCFS_S14_2' folder for template 'T_TCFS_S14'
And uploaded '/images/logo.jpg' file into '/F_TCFS_S14_1' folder for 'T_TCFS_S14' template
And uploaded '/images/logo.jpg' file into '/F_TCFS_S14_2' folder for 'T_TCFS_S14' template
When I go to template 'T_TCFS_S14' folder '/F_TCFS_S14_1' page
And wait for '3' seconds
And click on Want to copy files to another project link on move/copy file 'logo.jpg' popup
And select folder 'F_TCFS_S14_2' on move/copy file popup
And click copy button on move/copy files popup
And go to template 'T_TCFS_S14' folder 'F_TCFS_S14_2' page
And wait for '3' seconds
Then I 'should' see file 'logo.jpg' on template files page and files count are '2'
When I go to template 'T_TCFS_S14' folder 'F_TCFS_S14_1' page
And wait for '3' seconds
Then I 'should' see file 'logo.jpg' on template files page and files count are '1'