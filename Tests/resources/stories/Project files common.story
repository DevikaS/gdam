!--NGN-259
Feature:          Project files common
Narrative:
In order to
As a              AgencyAdmin
I want to         Check uploading file to folder within project

Scenario: Check that 'Select All' selects all files
Meta:@gdam
@projects
Given I created 'PFC2' project
And created '/PFF2' folder for project 'PFC2'
And uploaded into project 'PFC2' following files:
| FileName              | Path  |
| /files/file_1.wav     | /PFF2 |
| /files/file_1.mp3     | /PFF2 |
| /files/file_1.unknown | /PFF2 |
And I am on project 'PFC2' folder '/PFF2' page
When I click element 'SelectAll' on page 'FilesPage'
Then I should see '3' selected files in folder '/PFF2' of project 'PFC2'