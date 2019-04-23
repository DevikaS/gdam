!--NGN-1372
Feature:          Restore file from project trash bin
Narrative:
In order to
As a              AgencyAdmin
I want to         Check restoring file from trash bin (Project)


Scenario: Check that file can be restored
Meta: @gdam
@projects
Given I created 'RFPP1' project
And created '/RFPF1' folder for project 'RFPP1'
And uploaded into project 'RFPP1' following files:
| FileName           | Path   |
| /files/120.600.gif | /RFPF1 |
And I am on project 'RFPP1' folder '/RFPF1' page
When I 'delete' file '120.600.gif' from project files page
And I go to the Project Trash page for project 'RFPP1'
And restore file '120.600.gif' from project 'RFPP1' trash bin to folder 'RFPP1/RFPF1'
Then I 'should not' see the following files in the project 'RFPP1' trash bin:
| FileName    |
| 120.600.gif |
And 'should' see file '120.600.gif' on project 'RFPP1' folder '/RFPF1' files page


Scenario: Check that several files can be restored
!--NGN-2846 NGN-2623
Meta: @skip
      @gdam
Given I created 'RFPP2' project
And created '/RFPF2' folder for project 'RFPP2'
And uploaded into project 'RFPP2' following files:
| FileName                                     | Path   |
| /files/120.600.gif                          | /RFPF2 |
| /files/!@#$%^&()_+;,.Document.txt            | /RFPF2 |
| /files/ÄäDocumentÖö.txt                      | /RFPF2 |
| /files/13DV-CAPITAL-10.mpg                   | /RFPF2 |
| /files/Tesco_Trade_Meat_Wine_PANTS939015.wav | /RFPF2 |
| /files/GWGTestfile064v3.pdf                  | /RFPF2 |
| /files/New Text Document.txt                 | /RFPF2 |
And I am on project 'RFPP2' folder '/RFPF2' page
When I click element 'SelectAll' on page 'FilesPage'
And I delete all files from project 'RFPP2' folder '/RFPF2' files page
And I go to the Project Trash page for project 'RFPP2'
And click element 'SelectAll' on page 'FilesPage'
And restore multiple files from project 'RFPP2' trash bin page to folder '/RFPF2'
And refresh the page
Then I 'should not' see the following files in the project 'RFPP2' trash bin:
| FileName                              |
| 120.600.gif                          |
| !@#$%^&()_+;,.Document.txt            |
| ÄäDocumentÖö.txt                      |
| 13DV-CAPITAL-10.mpg                   |
| Tesco_Trade_Meat_Wine_PANTS939015.wav |
| GWGTestfile064v3.pdf                  |
| New Text Document.txt                 |
And I 'should' see on project 'RFPP2' folder '/RFPF2' files page following files :
| FileName                              |
| 120.600.gif                          |
| !@#$%^&()_+;,.Document.txt            |
| ÄäDocumentÖö.txt                      |
| 13DV-CAPITAL-10.mpg                   |
| Tesco_Trade_Meat_Wine_PANTS939015.wav |
| GWGTestfile064v3.pdf                  |
| New Text Document.txt                 |


Scenario: Check restoring file to another folder (not parent)
Meta: @gdam
@projects
Given I created 'RFPP4' project
And created in 'RFPP4' project next folders:
| folder   |
| /RFPF4_1 |
| /RFPF4_2 |
And uploaded into project 'RFPP4' following files:
| FileName           | Path     |
| /files/120.600.gif| /RFPF4_1 |
And I am on project 'RFPP4' folder '/RFPF4_1' page
When I 'delete' file '120.600.gif' from project files page
And I go to the Project Trash page for project 'RFPP4'
And restore file '120.600.gif' from project 'RFPP4' trash bin to folder 'RFPP4/RFPF4_2'
Then I 'should not' see the following files in the project 'RFPP4' trash bin:
| FileName     |
| 120.600.gif |
And 'should' see file '120.600.gif' on project 'RFPP4' folder '/RFPF4_2' files page
And 'should not' see file '120.600.gif' on project 'RFPP4' folder '/RFPF4_1' files page


Scenario: Check restoring file to subfolder (not parent)
Meta: @gdam
@projects
Given I created 'RFPP5' project
And created in 'RFPP5' project next folders:
| folder   |
| /RFPF5_1 |
| /RFPF5_1/RFPF5_1Sub |
And uploaded into project 'RFPP5' following files:
| FileName            | Path     |
| /files/120.600.gif | /RFPF5_1 |
And I am on project 'RFPP5' folder '/RFPF5_1' page
When I 'delete' file '120.600.gif' from project files page
And I go to the Project Trash page for project 'RFPP5'
And restore file '120.600.gif' from project 'RFPP5' trash bin to folder 'RFPP5/RFPF5_1/RFPF5_1Sub'
Then I 'should not' see the following files in the project 'RFPP5' trash bin:
| FileName     |
| 120.600.gif |
And 'should' see file '120.600.gif' on project 'RFPP5' folder '/RFPF5_1/RFPF5_1Sub' files page
And 'should not' see file '120.600.gif' on project 'RFPP5' folder '/RFPF5_1' files page


Scenario: Check that file can not be restored if folder is not selected
Meta: @gdam
@projects
Given I created 'RFPP6' project
And created in 'RFPP6' project next folders:
| folder |
| /RFPF6 |
And uploaded into project 'RFPP6' following files:
| FileName            | Path   |
| /files/120.600.gif | /RFPF6 |
And I am on project 'RFPP6' folder '/RFPF6' page
When I 'delete' file '120.600.gif' from project files page
And delete folder '/RFPF6' in project 'RFPP6'
And I go to the Project Trash page for project 'RFPP6'
Then 'should not' see folder '/RFPF6' on Select folder restore popup when restore file '120.600.gif' from project 'RFPP6' trash bin page
And I should see element 'Ok' on page 'SelectFolderRestorePopUp' in following state 'disabled'


Scenario: Check restore file with already existed name in folder
Meta: @gdam
@projects
Given I created 'RFPP7' project
And created in 'RFPP7' project next folders:
| folder |
| /RFPF7 |
And uploaded into project 'RFPP7' following files:
| FileName         | Path   |
| /files/logo3.mpg | /RFPF7 |
And I am on project 'RFPP7' folder '/RFPF7' page
When I 'delete' file 'logo3.mpg' from project files page
And upload into project 'RFPP7' following files:
| FileName         | Path   |
| /files/logo3.mpg | /RFPF7 |
And I go to the Project Trash page for project 'RFPP7'
And restore file 'logo3.mpg' from project 'RFPP7' trash bin to folder 'RFPP7/RFPF7'
Then I should see following files inside '/RFPF7' folder for 'RFPP7' project:
| FileName  | FilesCount |
| logo3.mpg | 2          |


Scenario: Check that deleted file that wasn't uploaded to storage should be uploaded to it after restore
Meta: @gdam
@projects
Given I created 'RFPP8' project
And created in 'RFPP8' project next folders:
| folder |
| /RFPF8 |
And uploaded into project 'RFPP8' following files:
| FileName                    | Path   |
| /files/GWGTestfile064v3.pdf | /RFPF8 |
And I am on project 'RFPP8' folder '/RFPF8' page
When I 'delete' file 'GWGTestfile064v3.pdf' from project files page
And I go to the Project Trash page for project 'RFPP8'
And restore file 'GWGTestfile064v3.pdf' from project 'RFPP8' trash bin to folder 'RFPP8/RFPF8'
And wait while transcoding is finished in folder '/RFPF8' on project 'RFPP8' files page
Then I 'should' see file 'GWGTestfile064v3.pdf' on project 'RFPP8' folder '/RFPF8' files page
And 'should' see preview file '/files/GWGTestfile064v3.pdf' on project 'RFPP8' folder '/RFPF8' page