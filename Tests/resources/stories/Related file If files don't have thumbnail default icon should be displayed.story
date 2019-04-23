!--NGN-11519
Feature:          Related file If files don't have thumbnail default icon should be displayed
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that Related file If files don't have thumbnail default icon should be displayed


Scenario: Check that html, audio file with preview and zip related files are displayed with default icon
Meta:@gdam
@projects
Given I created the agency 'A_RFIFDHTDISBD_1' with default attributes
And created users with following fields:
| Email              | Role         | AgencyUnique     |
| U_RFIFDHTDISBD_S01 | agency.admin | A_RFIFDHTDISBD_1 |
And logged in with details of 'U_RFIFDHTDISBD_S01'
And created 'P_RFIFDHTDISBD_1' project
And created '/folder' folder for project 'P_RFIFDHTDISBD_1'
And uploaded into project 'P_RFIFDHTDISBD_1' following files:
| FileName           | Path    |
| /files/logo1.gif   | /folder |
| /files/index.html  | /folder |
| /files/example.rar | /folder |
| /files/audio01.mp3 | /folder |
And waited while transcoding is finished in folder '/folder' on project 'P_RFIFDHTDISBD_1' files page
And opened file 'logo1.gif' in '/folder' in project 'P_RFIFDHTDISBD_1' on related files page
And typed related file 'index.html' on related files page on pop-up
And selected and save following related files 'index.html' on related file pop-up
And opened file 'logo1.gif' in '/folder' in project 'P_RFIFDHTDISBD_1' on related files page
And typed related file 'example.rar' on related files page on pop-up
And selected and save following related files 'example.rar' on related file pop-up
And opened file 'logo1.gif' in '/folder' in project 'P_RFIFDHTDISBD_1' on related files page
And typed related file 'audio01.mp3' on related files page on pop-up
And selected and save following related files 'audio01.mp3' on related file pop-up
When I go to project 'P_RFIFDHTDISBD_1' folder 'folder' page
Then I should see following count '4' of related files on project files page



