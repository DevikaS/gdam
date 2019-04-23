!--NGN-2419
Feature:          Project and Template - Trash bin-sorting
Narrative:
In order to
As a              AgencyAdmin
I want to         Sorting deleted files in trash

Meta:
@component project

Scenario: Check availability sorting options in trash bin
Meta:@gdam
@projects
Given I created 'PTTBSP1' project
And I am on the Project Trash page for project 'PTTBSP1'
When I click element 'SortByComboBoxTrashBin' on page 'FilesPage'
Then I 'should' see following elements on page 'FilesPage':
| element               |
| SortByDeleted         |
| SortByTitleAscending  |
| SortByTitleDescending |
| SortBySizeDescending  |
| SortBySizeAscending   |


Scenario: Check that 'Deleted' option is default sorting option in trash bin
Meta:@gdam
@projects
Given I created 'PTTBSP2' project
And created '/PTTBSF2' folder for project 'PTTBSP2'
And uploaded into project 'PTTBSP2' following files:
| FileName                 | Path     |
| /files/_file1.gif        | /PTTBSF2 |
| /files/128_shortname.jpg | /PTTBSF2 |
| /files/120.600.gif       | /PTTBSF2 |
And waited while preview is available in folder '/PTTBSF2' on project 'PTTBSP2' files page
And I am on project 'PTTBSP2' folder '/PTTBSF2' page
When I delete the following files in next project and folders:
| Project | Folder   | FileName          |
| PTTBSP2 | /PTTBSF2 | _file1.gif        |
| PTTBSP2 | /PTTBSF2 | 128_shortname.jpg |
| PTTBSP2 | /PTTBSF2 | 120.600.gif       |
And I go to the Project Trash page for project 'PTTBSP2'
Then should see sorting type 'Deleted' is selected on project 'PTTBSP2' trash bin page