!--NGN-1372
Feature:          Template Trash bin - restore folder
Narrative:
In order to
As a              AgencyAdmin
I want to         Check restoring folder from trash bin (Template)

Scenario: Check that folder can be restored  (for template)
!--NGN-2846 NGN-3081
Meta: @skip
      @gdam
Given I created 'TTBRFT1' template
And created '/TTBRFF1' folder for template 'TTBRFT1'
And uploaded into template 'TTBRFT1' following files:
| FileName                | Path     |
| /files/for_babylon43.7z | /TTBRFF1 |
And I am on template 'TTBRFT1' folder '/TTBRFF1' page
When I delete folder '/TTBRFF1' in template 'TTBRFT1'
And go to template 'TTBRFT1' folder '/TTBRFF1' trash bin page
And restore folder '/TTBRFF1' from template 'TTBRFT1' trash bin page to folder 'Root folder'
Then I 'should' see '/TTBRFF1' folder in 'TTBRFT1' template
And 'should' see file 'for_babylon43.7z' on template 'TTBRFT1' folder '/TTBRFF1' files page
And 'should not' see '/TTBRFF1' folder on 'TTBRFT1' template trash bin page
And 'should not' see the following files in the template 'TTBRFT1' trash bin:
| FileName         |
| for_babylon43.7z |


Scenario: Check that folder is restored with subfolders (for template)
!--NGN-2846 NGN-3081
Meta: @skip
      @gdam
Given I created 'TTBRFT2' template
And created in 'TTBRFT2' template next folders:
| folder            |
| /TTBRFF2_1        |
| /TTBRFF2_1/Sub2_1 |
| /TTBRFF2_1/Sub2_2 |
| /TTBRFF2_1/Sub2_3 |
And I am on template 'TTBRFT2' folder '/TTBRFF2_1' page
When I delete folder '/TTBRFF2_1' in template 'TTBRFT2'
And go to template 'TTBRFT2' folder '/TTBRFF2_1' trash bin page
And restore folder '/TTBRFF2_1' from template 'TTBRFT2' trash bin page to folder 'Root folder'
Then I should see following folders in 'TTBRFT2' template:
| folder            |
| /TTBRFF2_1        |
| /TTBRFF2_1/Sub2_1 |
| /TTBRFF2_1/Sub2_2 |
| /TTBRFF2_1/Sub2_3 |
And 'should not' see following folders on template 'TTBRFT2' trash bin page :
| folder            |
| /TTBRFF2_1        |
| /TTBRFF2_1/Sub2_1 |
| /TTBRFF2_1/Sub2_2 |
| /TTBRFF2_1/Sub2_3 |


Scenario: Check restoring file to another folder (not parent) (for template)
!--NGN-2846 NGN-3081
Meta: @skip
      @gdam
Given I created 'TTBRFT5' template
And created in 'TTBRFT5' template next folders:
| folder            |
| /TTBRFF5_1        |
| /TTBRFF5_1/Sub5_1 |
| /TTBRFF5_2        |
And uploaded into template 'TTBRFT5' following files:
| FileName                | Path              |
| /files/for_babylon43.7z | /TTBRFF5_1/Sub5_1 |
And I am on template 'TTBRFT5' folder '/TTBRFF5_1/Sub5_1' page
When I delete folder '/TTBRFF5_1/Sub5_1' in template 'TTBRFT5'
And go to template 'TTBRFT5' folder '/Sub5_1' trash bin page
And restore folder '/Sub5_1' from template 'TTBRFT5' trash bin page to folder '/TTBRFF5_2'
Then I 'should' see '/TTBRFF5_2/Sub5_1' folder in 'TTBRFT5' template
And 'should' see file 'for_babylon43.7z' on template 'TTBRFT5' folder '/TTBRFF5_2/Sub5_1' files page
And 'should not' see '/TTBRFF5_1/Sub5_1' folder in 'TTBRFT5' template
And 'should not' see '/Sub5_1' folder on 'TTBRFT5' template trash bin page
And 'should not' see the following files in the template 'TTBRFT5' trash bin:
| FileName         |
| for_babylon43.7z |


Scenario: Check that folder can not be restored to deleted folder (for template)
!--NGN-2846 NGN-3081
Meta: @skip
      @gdam
Given I created 'TTBRFT6' template
And created in 'TTBRFT6' template next folders:
| folder     |
| /TTBRFF6_1 |
| /TTBRFF6_2 |
And I am on template 'TTBRFT6' folder '/TTBRFF6_1' page
When I delete folder '/TTBRFF6_1' in template 'TTBRFT6'
And go to template 'TTBRFT6' folder '/TTBRFF6_1' trash bin page
Then I 'should not' see folder '/TTBRFF6_1' on Select folder restore popup when restore folder '/TTBRFF6_1' from template 'TTBRFT6' trash bin page


Scenario: Check that folder can not be restored if folder is not selected (for template)
!--NGN-2846 NGN-3081
Meta: @skip
      @gdam
Given I created 'TTBRFT7' template
And created in 'TTBRFT7' template next folders:
| folder     |
| /TTBRFF7_1 |
| /TTBRFF7_2 |
And I am on template 'TTBRFT7' folder '/TTBRFF7_1' page
When I delete folder '/TTBRFF7_1' in template 'TTBRFT7'
And go to template 'TTBRFT7' folder '/TTBRFF7_1' trash bin page
Then I click Restore button from popup menu of folder '/TTBRFF7_1' in template 'TTBRFT7' trash bin page
And I should see element 'Ok' on page 'SelectFolderRestorePopUp' in following state 'disabled'


Scenario: Check restore folder with already existed name in folder should not be possible (for template)
!--NGN-2846 NGN-2617
Meta: @skip
      @gdam
Given I created 'TTBRFT8' template
And created in 'TTBRFT8' template next folders:
| folder            |
| /TTBRFF8_1        |
| /TTBRFF8_1/Sub8_1 |
And I am on template 'TTBRFT8' folder '/TTBRFF8_1/Sub8_1' page
And deleted folder '/TTBRFF8_1/Sub8_1' in template 'TTBRFT8'
And created '/TTBRFF8_1/Sub8_1' folder for template 'TTBRFT8'
When I go to template 'TTBRFT8' folder '/Sub8_1' trash bin page
And restore folder '/Sub8_1' from template 'TTBRFT8' trash bin page to folder '/TTBRFF8_1'
Then I 'should' see '/TTBRFF8_1/Sub8_1' folder in 'TTBRFT8' template
And I should see '1' folders in '/TTBRFF8_1' for template 'TTBRFT8'