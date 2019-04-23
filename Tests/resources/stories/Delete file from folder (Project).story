!--NGN-962
Feature:          Delete file from folder (Project)
Narrative:
In order to
As a              AgencyAdmin
I want to         Check deleting file from folder (Project)

Scenario: Check that file can be deleted from project
Meta:@gdam
@projects
Given I created 'UFS1' project
And created '/UFF1' folder for project 'UFS1'
And uploaded into project 'UFS1' following files:
| FileName          | Path  |
| /files/_file1.gif | /UFF1 |
And I am on project 'UFS1' folder '/UFF1' page
When I 'delete' file '_file1.gif' from project files page
Then I 'should not' see file '_file1.gif' on project 'UFS1' folder '/UFF1' files page


Scenario: Check the button 'delete' is inactive if file wasn't selected
Meta:@gdam
@projects
Given I created 'UFS2' project
And created '/UFF1' folder for project 'UFS2'
And I uploaded into project 'UFS2' following files:
| FileName          | Path  |
| /files/_file1.gif | /UFF1 |
And I am on project 'UFS2' folder '/UFF1' page
Then I 'should' see element 'DisabledMoreButton' on page 'FilesPage'


Scenario: Check that several file can be deleted from project
Meta:@gdam
@projects
Given I created 'UFS3' project
And created '/UFF1' folder for project 'UFS3'
And I uploaded into project 'UFS3' following files:
| FileName                                     | Path  |
| /files/_file1.gif                            | /UFF1 |
| /files/13DV-CAPITAL-10.mpg                   | /UFF1 |
| /files/Tesco_Trade_Meat_Wine_PANTS939015.wav | /UFF1 |
And I am on project 'UFS3' folder '/UFF1' page
When I click element 'SelectAll' on page 'FilesPage'
And I delete all files from project 'UFS3' folder '/UFF1' files page
Then I 'should not' see on project 'UFS3' folder '/UFF1' files page following files :
| FileName                              |
| _file1.gif                            |
| 13DV-CAPITAL-10.mpg                   |
| Tesco_Trade_Meat_Wine_PANTS939015.wav |


Scenario: Check that deleted files from different folders, appears in trash bin
Meta:@gdam
@projects
Given I created 'UFS8' project
And created in 'UFS8' project next folders:
| folder       |
| /NEW         |
| /NEW/Sub     |
| /NEW/NEW/Sub |
| /new1        |
And I uploaded into project 'UFS8' following files:
| FileName                   | Path         |
| /files/atCalcImage.jpg     | /NEW/Sub     |
| /files/_file1.gif          | /NEW         |
| /files/file2_.gif          | /NEW/NEW/Sub |
| /files/13DV-CAPITAL-10.mpg | /new1        |
And waited while preview is available in folder '/NEW' on project 'UFS8' files page
And waited while preview is available in folder '/NEW/Sub' on project 'UFS8' files page
And waited while preview is available in folder '/NEW/NEW/Sub' on project 'UFS8' files page
And waited while preview is available in folder '/new1' on project 'UFS8' files page
When I delete the following files in next project and folders:
| Project | Folder       | FileName            |
| UFS8    | /NEW         | _file1.gif          |
| UFS8    | /NEW/Sub     | atCalcImage.jpg     |
| UFS8    | /NEW/NEW/Sub | file2_.gif          |
| UFS8    | /new1        | 13DV-CAPITAL-10.mpg |
And I go to the Project Trash page for project 'UFS8'
Then I 'should' see the following files in the project 'UFS8' trash bin:
| FileName            |
| _file1.gif          |
| atCalcImage.jpg     |
| file2_.gif          |
| 13DV-CAPITAL-10.mpg |


Scenario: Check that deleting files with same name from different folders appears in trash bin
Meta:@gdam
@projects
Given I created 'UFS9' project
And created in 'UFS9' project next folders:
| folder       |
| /NEW         |
| /NEW/Sub     |
| /NEW/NEW/Sub |
And I uploaded into project 'UFS9' following files:
| FileName          | Path         |
| /files/_file1.gif | /NEW/Sub     |
| /files/_file1.gif | /NEW         |
| /files/_file1.gif | /NEW/NEW/Sub |
And I am on project 'UFS9' folder '/NEW' page
When I delete the following files in next project and folders:
| Project | Folder       | FileName   |
| UFS9    | /NEW         | _file1.gif |
| UFS9    | /NEW/Sub     | _file1.gif |
| UFS9    | /NEW/NEW/Sub | _file1.gif |
And I go to the Project Trash page for project 'UFS9'
Then I 'should' see the following files in the project 'UFS9' trash bin:
| FileName   |
| _file1.gif |
| _file1.gif |
| _file1.gif |
And I 'should' see quantity '3' files with name '_file1.gif' in the project trash bin


Scenario: Check that deleted files appears in trash bin
Meta:@gdam
@projects
Given I created 'UFS10' project
And created '/UFF1' folder for project 'UFS10'
And I uploaded into project 'UFS10' following files:
| FileName                                     | Path  |
| /files/_file1.gif                            | /UFF1 |
| /files/atCalcImage.jpg                       | /UFF1 |
| /files/file2_.gif                            | /UFF1 |
| /files/13DV-CAPITAL-10.mpg                   | /UFF1 |
| /files/Tesco_Trade_Meat_Wine_PANTS939015.wav | /UFF1 |
And waited while preview is available in folder '/UFF1' on project 'UFS10' files page
When I click element 'SelectAll' on page 'FilesPage'
And I delete all files from project 'UFS10' folder '/UFF1' files page
And I go to the Project Trash page for project 'UFS10'
Then I 'should' see the following files in the project 'UFS10' trash bin:
| FileName                              |
| _file1.gif                            |
| atCalcImage.jpg                       |
| file2_.gif                            |
| 13DV-CAPITAL-10.mpg                   |
| Tesco_Trade_Meat_Wine_PANTS939015.wav |


Scenario: Check that after delete counter of file changes
Meta:@gdam
@projects
Given I created 'UFS11' project
And created '/UFF1' folder for project 'UFS11'
And I uploaded into project 'UFS11' following files:
| FileName                                     | Path  |
| /files/_file1.gif                            | /UFF1 |
| /files/atCalcImage.jpg                       | /UFF1 |
| /files/file2_.gif                            | /UFF1 |
| /files/13DV-CAPITAL-10.mpg                   | /UFF1 |
| /files/Tesco_Trade_Meat_Wine_PANTS939015.wav | /UFF1 |
And waited while preview is available in folder '/UFF1' on project 'UFS11' files page
When I delete the following files from project 'UFS11' and folder '/UFF1':
| FileName        |
| _file1.gif      |
| atCalcImage.jpg |
| file2_.gif      |
Then I should see element 'CounterOfFiles' with text '2 Files (0 selected)' on page 'FilesPage'