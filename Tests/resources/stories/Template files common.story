!--NGN-259
Feature:          Template files common
Narrative:
In order to
As a              AgencyAdmin
I want to         Check uploading file to folder within template

Scenario: Check that 'Select All' selects all files
Meta:@gdam
@projects
Given I created 'TFC2' template
And created '/TFF2' folder for template 'TFC2'
And uploaded into template 'TFC2' following files:
| FileName | Path  |
| test     | /TFF2 |
| test     | /TFF2 |
| test     | /TFF2 |
And I am on template 'TFC2' folder '/TFF2' page
When I click element 'SelectAll' on page 'FilesPage'
Then I should see '3' selected files in folder '/TFF2' of template 'TFC2'