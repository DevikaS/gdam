!--NGN-480
Feature:          Copy or Move files - Project search

Narrative:
In order to
As a              AgencyAdmin
I want to         Check project searching on Copy/Move files

Scenario: Check that after clicking on 'Want to move files to another project?' link Search project field is displayed on Move pop-up
Meta:@gdam
     @projects
Given I created 'PCPSCM1' project
And created '/FCPSCM1' folder for project 'PCPSCM1'
And uploaded into project 'PCPSCM1' following files:
| FileName                                         | Path     |
| /files/1284355391_120558340_1-----1284355391.jpg | /FCPSCM1 |
And I am on project 'PCPSCM1' folder '/FCPSCM1' page
When I click on Want to move files to another project link on move/copy file '1284355391_120558340_1-----1284355391.jpg' popup
Then I 'should' see Search project field on move/copy file popup


Scenario: Check that after clicking on 'Want to copy files to another project?' link Search project field is displayed on Copy pop-up
Meta:@gdam
     @projects
Given I created 'PCPSCM2' project
And created '/FCPSCM2' folder for project 'PCPSCM2'
And uploaded into project 'PCPSCM2' following files:
| FileName                                         | Path     |
| /files/1284355391_120558340_1-----1284355391.jpg | /FCPSCM2 |
And I am on project 'PCPSCM2' folder '/FCPSCM2' page
When I click on Want to copy files to another project link on move/copy file '1284355391_120558340_1-----1284355391.jpg' popup
Then I 'should' see Search project field on move/copy file popup


Scenario: Search projects in look-up
Meta:@gdam
     @projects
Given I created following projects:
| Name               |
| Project1           |
| First Second Third |
| First Second       |
| First              |
| Nødhjælp           |
And created '/PTF13' folder for project 'Project1'
And uploaded into project 'Project1' following files:
| FileName                                         | Path   |
| /files/1284355391_120558340_1-----1284355391.jpg | /PTF13 |
And I am on project 'Project1' folder '/PTF13' page
When I click on Want to copy files to another project link on move/copy file '1284355391_120558340_1-----1284355391.jpg' popup
And I type '<Text>' in search field on move/copy file popup
Then I should see '<Projects>' are available for selecting in search projects on move/copy file popup

Examples:
| Text      | Projects                              |
| First     | First,First Second,First Second Third |
| Nødhjælp  | Nødhjælp                              |
|           |                                       |


Scenario: Check that another project can be found and selected
Meta:@gdam
     @projects
Given I created following projects:
| Name     |
| Eroject1 |
| Eroject2 |
And created '/EPTF13' folder for project 'Eroject1'
And created '/EPTF14' folder for project 'Eroject2'
And uploaded into project 'Eroject1' following files:
| FileName                                         | Path    |
| /files/1284355391_120558340_1-----1284355391.jpg | /EPTF13 |
And I am on project 'Eroject1' folder '/EPTF13' page
When I click on Want to copy files to another project link on move/copy file '1284355391_120558340_1-----1284355391.jpg' popup
And I type 'Eroject2' in search field on move/copy file popup
And I select project 'Eroject2' on move/copy file popup
Then I should see selected project 'Eroject2' with folder '/EPTF14' on move/copy file popup


Scenario: Check that renamed project can be found by new name
Meta:@gdam
     @projects
Given I created following projects:
| Name     |
| Kroject1 |
| Kroject2 |
And created '/KTF13' folder for project 'Kroject1'
And created '/KTF23' folder for project 'Kroject2'
And uploaded into project 'Kroject1' following files:
| FileName                                         | Path   |
| /files/1284355391_120558340_1-----1284355391.jpg | /KTF13 |
And I am on project 'Kroject2' settings page
When I edit the following fields for 'Kroject2' project:
| Name     |
| Kroject3 |
And click on element 'SaveButton'
And go to project 'Kroject1' folder '/KTF13' page
And I click on Want to copy files to another project link on move/copy file '1284355391_120558340_1-----1284355391.jpg' popup
And I type 'Kroject3' in search field on move/copy file popup
Then I should see 'Kroject3' are available for selecting in search projects on move/copy file popup