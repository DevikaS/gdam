!--NGN-962
Feature:          Delete file from folder (Template)
Narrative:
In order to
As a              AgencyAdmin
I want to         Check deleting file from folder (Template)

Scenario: Check that file can be deleted from Template
Meta:@gdam
@projects
Given I created 'UFS1' template
And created '/UFF1' folder for template 'UFS1'
And I uploaded into template 'UFS1' following files:
| FileName          | Path  |
| /files/_file1.gif | /UFF1 |
And I am on template 'UFS1' folder '/UFF1' page
When I 'delete' file '_file1.gif' from template files page
Then I 'should not' see file '_file1.gif' on template 'UFS1' folder '/UFF1' files page


Scenario: Check the button 'delete' is inactive if file wasn't selected
Meta:@gdam
@projects
Given I created 'UFS2' template
And created '/UFF1' folder for template 'UFS2'
And I uploaded into template 'UFS2' following files:
| FileName          | Path  |
| /files/_file1.gif | /UFF1 |
And I am on template 'UFS2' folder '/UFF1' page
Then I 'should' see element 'DisabledMoreButton' on page 'FilesPage'


Scenario: Check that several file can be deleted from Template
Meta:@gdam
@projects
Given I created 'UFS3' template
And created '/UFF1' folder for template 'UFS3'
And I uploaded into template 'UFS3' following files:
| FileName                                     | Path  |
| /files/_file1.gif                            | /UFF1 |
| /files/atCalcImage.jpg                       | /UFF1 |
| /files/file2_.gif                            | /UFF1 |
| /files/13DV-CAPITAL-10.mpg                   | /UFF1 |
| /files/Tesco_Trade_Meat_Wine_PANTS939015.wav | /UFF1 |
And I am on template 'UFS3' folder '/UFF1' page
When I click element 'SelectAll' on page 'FilesPage'
And I delete all files from template 'UFS3' folder '/UFF1' files page
Then I 'should not' see on template 'UFS3' folder '/UFF1' files page following files :
| FileName                              |
| _file1.gif                            |
| atCalcImage.jpg                       |
| file2_.gif                            |
| 13DV-CAPITAL-10.mpg                   |
| Tesco_Trade_Meat_Wine_PANTS939015.wav |


Scenario: Check that after delete counter of file changes
Meta:@gdam
@projects
Given I created 'UFS11' template
And created '/UFF1' folder for template 'UFS11'
And I uploaded into template 'UFS11' following files:
| FileName                                     | Path  |
| /files/_file1.gif                            | /UFF1 |
| /files/atCalcImage.jpg                       | /UFF1 |
| /files/file2_.gif                            | /UFF1 |
| /files/13DV-CAPITAL-10.mpg                   | /UFF1 |
| /files/Tesco_Trade_Meat_Wine_PANTS939015.wav | /UFF1 |
And I am on template 'UFS11' folder '/UFF1' page
When I delete the following files from template 'UFS11' and folder '/UFF1':
| FileName        |
| _file1.gif      |
| atCalcImage.jpg |
| file2_.gif      |
Then I should see element 'CounterOfFiles' with text '2 Files (0 selected)' on page 'FilesPage'