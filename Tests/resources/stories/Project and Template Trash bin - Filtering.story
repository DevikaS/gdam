!--NGN-2535
Feature:          Project and Template Trash bin - Filtering
Narrative:
In order to
As a              AgencyAdmin
I want to         Check filter in folders on project view

Meta:
@component project

Scenario: check all files are appear in folder when all filters 'off'
Meta:@gdam
@projects
Given I created following projects:
| Name    | Job Number |
| PTTBFP1 | PTTBFPJ1   |
And created '/PTTBFF1' folder for project 'PTTBFP1'
And uploaded into project 'PTTBFP1' following files:
| FileName                    | Path     |
| /images/logo.jpeg           | /PTTBFF1 |
| /images/logo.png            | /PTTBFF1 |
| /files/GWGTestfile064v3.pdf | /PTTBFF1 |
| /files/video10s.avi         | /PTTBFF1 |
And I am on project 'PTTBFP1' folder '/PTTBFF1' page
When I click element 'SelectAll' on page 'FilesPage'
And I delete all files from project 'PTTBFP1' folder '/PTTBFF1' files page
And I go to the Project Trash page for project 'PTTBFP1'
And select media type filters '' on project 'PTTBFP1' folder '' trash bin page
Then I 'should' see the following files in the project 'PTTBFP1' trash bin:
| FileName             |
| logo.jpeg            |
| logo.png             |
| GWGTestfile064v3.pdf |
| video10s.avi         |


Scenario: check that sub-type greyed out when some/all filter 'on'
Meta:@gdam
@projects
Given I created following projects:
| Name    | Job Number |
| PTTBFP3 | PTTBFPJ3   |
When I go to the Project Trash page for project 'PTTBFP3'
And select media type filters '<Filter>' on project 'PTTBFP3' folder '' trash bin page
Then I '<Should>' see Media Sub Type is greyed out on project 'PTTBFP3' folder '' trash bin page

Examples:
| Filter                          | Should     |
| IMAGE                           | should not |
| VIDEO                           | should not |
| VIDEO,AUDIO,PRINT,IMAGE,DIGITAL | should     |