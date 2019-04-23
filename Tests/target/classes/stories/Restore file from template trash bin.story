!--NGN-1372
Feature:          Restore file from template trash bin
Narrative:
In order to
As a              AgencyAdmin
I want to         Check restoring file from trash bin (Template)

Scenario: Check that deleted file that wasn't transcoded should be transcoded after restore (for template)
Meta: @skip
      @gdam


Scenario: Check that file can be restored (for template)
!-- NGN-2846
Meta: @skip
      @gdam

!--NGN-2620, NGN-2623
Given I created 'RFTT1' template
And created '/RFTF1' folder for template 'RFTT1'
And uploaded into template 'RFTT1' following files:
| FileName                 | Path   |
| /files/for_babylon43.7z | /RFTF1 |
And I am on template 'RFTT1' folder '/RFTF1' page
When I 'delete' file 'for_babylon43.7z' from template files page
And I go to the Template Trash page for template 'RFTT1'
And restore file 'for_babylon43.7z' from template 'RFTT1' trash bin to folder 'RFTT1/RFTF1'
Then I 'should not' see the following files in the template 'RFTT1' trash bin:
| FileName         |
| for_babylon43.7z |
And 'should' see file 'for_babylon43.7z' on template 'RFTT1' folder '/RFTF1' files page


Scenario: Check that several files can be restored (for template)
!--NGN-2846 NGN-2623
Meta: @skip
      @gdam
Given I created 'RFTT2' template
And created '/RFTF2' folder for template 'RFTT2'
And uploaded into template 'RFTT2' following files:
| FileName                                     | Path   |
| /files/for_babylon43.7z                      | /RFTF2 |
| /files/!@#$%^&()_+;,.Document.txt            | /RFTF2 |
| /files/ÄäDocumentÖö.txt                      | /RFTF2 |
| /files/13DV-CAPITAL-10.mpg                   | /RFTF2 |
| /files/Tesco_Trade_Meat_Wine_PANTS939015.wav | /RFTF2 |
| /files/GWGTestfile064v3.pdf                  | /RFTF2 |
| /files/New Text Document.txt                 | /RFTF2 |
And I am on template 'RFTT2' folder '/RFTF2' page
When I click element 'SelectAll' on page 'FilesPage'
And I delete all files from template 'RFTT2' folder '/RFTF2' files page
And I go to the Template Trash page for template 'RFTT2'
And click element 'SelectAll' on page 'FilesPage'
And restore multiple files from template 'RFTT2' trash bin page to folder 'RFTT2/RFTF2'
Then I 'should not' see the following files in the template 'RFTT2' trash bin:
| FileName                              |
| for_babylon43.7z                      |
| !@#$%^&()_+;,.Document.txt            |
| ÄäDocumentÖö.txt                      |
| 13DV-CAPITAL-10.mpg                   |
| Tesco_Trade_Meat_Wine_PANTS939015.wav |
| GWGTestfile064v3.pdf                  |
| New Text Document.txt                 |
And I 'should' see on template 'RFTT2' folder '/RFTF2' files page following files :
| FileName                              |
| for_babylon43.7z                      |
| !@#$%^&()_+;,.Document.txt            |
| ÄäDocumentÖö.txt                      |
| 13DV-CAPITAL-10.mpg                   |
| Tesco_Trade_Meat_Wine_PANTS939015.wav |
| GWGTestfile064v3.pdf                  |
| New Text Document.txt                 |


Scenario: Check restoring file to another folder (not parent) (for template)
!--NGN-2846 NGN-2620 NGN-2623
Meta: @skip
      @gdam
Given I created 'RFTT5' template
And created in 'RFTT5' template next folders:
| folder   |
| /RFTF5_1 |
| /RFTF5_2 |
And uploaded into template 'RFTT5' following files:
| FileName                | Path     |
| /files/for_babylon43.7z | /RFTF5_1 |
And I am on template 'RFTT5' folder '/RFTF5_1' page
When I 'delete' file 'for_babylon43.7z' from template files page
And I go to the Template Trash page for template 'RFTT5'
And restore file 'for_babylon43.7z' from template 'RFTT5' trash bin to folder 'RFTT5/RFTF5_2'
Then I 'should not' see the following files in the template 'RFTT5' trash bin:
| FileName         |
| for_babylon43.7z |
And 'should' see file 'for_babylon43.7z' on template 'RFTT5' folder '/RFTF5_2' files page
And 'should not' see file 'for_babylon43.7z' on template 'RFTT5' folder '/RFTF5_1' files page


Scenario: Check restoring file to subfolder (not parent) (for template)
!--NGN-2846 NGN-2620 NGN-2623
Meta: @skip
      @gdam
Given I created 'RFTT6' template
And created in 'RFTT6' template next folders:
| folder              |
| /RFTF6_1            |
| /RFTF6_1/RFTF6_1Sub |
And uploaded into template 'RFTT6' following files:
| FileName                | Path     |
| /files/for_babylon43.7z | /RFTF6_1 |
And I am on template 'RFTT6' folder '/RFTF6_1' page
When I 'delete' file 'for_babylon43.7z' from template files page
And I go to the Template Trash page for template 'RFTT6'
And restore file 'for_babylon43.7z' from template 'RFTT6' trash bin to folder 'RFTT6/RFTF6_1/RFTF6_1Sub'
Then I 'should not' see the following files in the template 'RFTT6' trash bin:
| FileName         |
| for_babylon43.7z |
And 'should' see file 'for_babylon43.7z' on template 'RFTT6' folder '/RFTF6_1/RFTF6_1Sub' files page
And 'should not' see file 'for_babylon43.7z' on template 'RFTT6' folder '/RFTF6_1' files page


Scenario: Check that file can not be restored if folder is not selected (for template)
!--NGN-2846 NGN-2620 NGN-2623
Meta: @skip
      @gdam
Given I created 'RFTT7' template
And created in 'RFTT7' template next folders:
| folder |
| /RFTF7 |
And uploaded into template 'RFTT7' following files:
| FileName                | Path   |
| /files/for_babylon43.7z | /RFTF7 |
And I am on template 'RFTT7' folder '/RFTF7' page
When I 'delete' file 'for_babylon43.7z' from template files page
And delete folder '/RFTF7' in template 'RFTT7'
And I go to the Template Trash page for template 'RFTT7'
Then 'should not' see folder '/RFTF7' on Select folder restore popup when restore file 'for_babylon43.7z' from template 'RFTT7' trash bin page
And I should see element 'Ok' on page 'SelectFolderRestorePopUp' in following state 'disabled'


Scenario: Check restore file with already existed name in folder (for template)
!--NGN-2846 NGN-2620 NGN-2623
Meta: @skip
      @gdam
Given I created 'RFTT8' template
And created in 'RFTT8' template next folders:
| folder |
| /RFTF8 |
And uploaded into template 'RFTT8' following files:
| FileName                | Path   |
| /files/for_babylon43.7z | /RFTF8 |
And I am on template 'RFTT8' folder '/RFTF8' page
When I 'delete' file 'for_babylon43.7z' from template files page
And I upload into template 'RFTT8' following files:
| FileName                | Path   |
| /files/for_babylon43.7z | /RFTF8 |
And go to template 'RFTT8' folder '/RFTF8' page
And I go to the Template Trash page for template 'RFTT8'
And restore file 'for_babylon43.7z' from template 'RFTT8' trash bin to folder 'RFTT8/RFTF8'
Then I should see following files inside '/RFTF8' folder for 'RFTT8' template:
| FileName         | FilesCount |
| for_babylon43.7z | 2          |


Scenario: Check that deleted file that wasn't uploaded to storage should be uploaded to it after restore (for template)
!--NGN-2846 NGN-2620 NGN-2623
Meta: @skip
      @gdam
Given I created 'RFTT9' template
And created in 'RFTT9' template next folders:
| folder |
| /RFTF9 |
And uploaded into template 'RFTT9' following files:
| FileName                    | Path   |
| /files/GWGTestfile064v3.pdf | /RFTF9 |
And I am on template 'RFTT9' folder '/RFTF9' page
When I 'delete' file 'GWGTestfile064v3.pdf' from template files page
And I go to the Template Trash page for template 'RFTT9'
And restore file 'GWGTestfile064v3.pdf' from template 'RFTT9' trash bin to folder 'RFTT9/RFTF9'
And wait while transcoding is finished in folder '/RFTF9' on template 'RFTT9' files page
Then I 'should' see file 'GWGTestfile064v3.pdf' on template 'RFTT9' folder '/RFTF9' files page
And file '/files/GWGTestfile064v3.pdf' in folder '/RFTF9' on template 'RFTT9' files page is fully uploaded