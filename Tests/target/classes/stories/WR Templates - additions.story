!--NGN-12363
Feature:          WR Templates - additions
Narrative:
In order to
As a              AgencyAdmin
I want to         check tat WR Templates - additions


Scenario: check that WR is created from WR templates successfully (team, files,folders)
Meta:@gdam
     @projects
Given I created 'WRTA1_S01' work request template
And I created '/FWRTA1_S01' folder for work request template 'WRTA1_S01'
And uploaded '/files/120.600.gif' file into '/FWRTA1_S01' folder for 'WRTA1_S01' work request template
And waited while transcoding is finished on Work request template 'WRTA1_S01' in folder '/FWRTA1_S01' for '120.600.gif' file
And created new work request with following fields:
| FieldName    | FieldValue |
| Name         | WRA1_S01   |
| Template     | WRTA1_S01  |
| IncludeFiles | true       |
Then I 'should' see file '120.600.gif' on work request template 'WRTA1_S01' folder '/FWRTA1_S01' files page


Scenario: check that WR is created from WR templates successfully (team, files,folders) and can be published
Meta:@gdam
     @projects
Given I created 'WRTA1_S02' work request template
And I created '/FWRTA1_S02' folder for work request template 'WRTA1_S02'
And uploaded '/files/120.600.gif' file into '/FWRTA1_S02' folder for 'WRTA1_S02' work request template
And waited while transcoding is finished on Work request template 'WRTA1_S02' in folder '/FWRTA1_S02' for '120.600.gif' file
And created new work request with following fields:
| FieldName    | FieldValue |
| Name         | WRA1_S02   |
| Template     | WRTA1_S02  |
| IncludeFiles | true       |
When I click publish button on work request 'WRA1_S02' Overview page
And wait for '1' seconds
Then I 'should' see 'Unpublish' button on Work Request Template 'WRTA1_S02' Overview page


Scenario: check that WR templates is without option 'Publish Immediately'
Meta:@gdam
     @projects
Given opened Create New Work Request Template popup
Then I should not see checkbox Publish Immediately on opened Work Request Template pop up


Scenario: check that WR templates with option 'other users in my Business Unit to create projects from this template' are avilible for appropriate users from BU
Meta:@gdam
     @projects
Given I created 'TEST_ROLE' role in 'global' group for advertiser 'DefaultAgency' with following permissions:
| Permission            |
| adkit_template.create |
| adkit_template.read   |
| agency_team.read      |
| asset.create          |
| enum.create           |
| enum.read             |
| enum.write            |
And created users with following fields:
| Email     | Role      |
| WRTA1_S04 | TEST_ROLE |
When I login with details of 'WRTA1_S04'
And open Create New Work Request Template popup
Then I 'should' see Allow other users in my Business Unit to create projects from this template on edit popup