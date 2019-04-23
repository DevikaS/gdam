!--NGN-34
Feature:          Project overview tab - Project Activity
Narrative:
In order to
As a              AgencyAdmin
I want to         Check project activity on project overview

Scenario: Check that 10 of last activities correctly displayed on Project overview and selection of user on Team page
!--As per QA-678 Modified test
Meta:@gdam
@projects
Given I created following users:
| User Name |
| POTU1_1   |
| POTU1_2   |
And created following projects:
| Name  | Job Number | Administrators  |
| POTP1 | POTJ1      | POTU1_1,POTU1_2 |
And created '/F1' folder for project 'POTP1'
And I logged in with details of 'POTU1_1'
And uploaded into project 'POTP1' following files:
| FileName             | Path |
| /files/logo3         | /F1  |
| /files/correct.avi   | /F1  |
| /files/logo3.blabla  | /F1  |
| /files/audio01.mp3   | /F1  |
| /files/logo3.mpg    | /F1  |
And I logged in with details of 'POTU1_2'
And uploaded into project 'POTP1' following files:
| FileName                     | Path |
| /files/filetext.txt          | /F1  |
| /files/logo3.unkwnown         | /F1  |
| /files/shortname.wav         | /F1  |
| /files/for_babylon43.7z      | /F1  |
| /files/New Text Document.txt | /F1  |
And I logged in as 'AgencyAdmin'
And I am on project 'POTP1' folder '/F1' page
And waited while transcoding is finished in folder '/F1' on project 'POTP1' files page
When I go to project 'POTP1' overview page
And wait for '4' seconds
Then I should see following 'not sorted' activities on project 'POTP1' overview page:
| UserName | Message                                | Value                          |
| POTU1_1  | uploaded 1 files logo3                 | POTP1/POTP1/F1/logo3           |
| POTU1_1  | uploaded 1 files correct.avi           | POTP1/POTP1/F1/correct.avi     |
| POTU1_1  | uploaded 1 files logo3.blabla          | POTP1/POTP1/F1/logo3.blabla    |
| POTU1_1  | uploaded 1 files audio01.mp3           | POTP1/POTP1/F1/audio01.mp3     |
| POTU1_1  | uploaded 1 files logo3.mpg             | POTP1/POTP1/F1/logo3.mpg       |
| POTU1_2  | uploaded 1 files filetext.txt          | POTP1/POTP1/F1/filetext.txt    |
| POTU1_2  | uploaded 1 files logo3.unkwnown         | POTP1/POTP1/F1/logo3.unkwnown   |
| POTU1_2  | uploaded 1 files shortname.wav         | POTP1/POTP1/F1/shortname.wav   |
| POTU1_2  | uploaded 1 files for_babylon43.7z      | POTP1/POTP1/F1/for_babylon43.7z      |
| POTU1_2  | uploaded 1 files New Text Document.txt | POTP1/POTP1/F1/New Text Document.txt |
When wait for '4' seconds
And click on user 'POTU1_1' in project 'POTP1' overview activities
Then I 'should not' see user 'POTU1_1' is selected on project team page
When click on user 'POTU1_2' in project 'POTP1' overview activities
Then I 'should not' see user 'POTU1_2' is selected on project team page

Scenario: Check that 'create project' is displayed on Project Last activities in project overview
Meta:@gdam
@projects
Given I created 'POTU2' User
And I logged in with details of 'POTU2'
And the following projects were created:
| Name  | Job Number | Administrators |
| POTP2 | POTJ2      | AgencyAdmin    |
And I logged in as 'AgencyAdmin'
When I go to project 'POTP2' overview page
Then I 'should' see activity for user 'POTU2' on project 'POTP2' overview page with message 'created project' and value 'POTP2'


Scenario: Check that 'updated project' is displayed on Project Last activities in project overview
Meta:@gdam
@projects
Given I created 'POTU2' User
And I logged in with details of 'POTU2'
And the following projects were created:
| Name  | Job Number | Administrators |
| POTP2 | POTJ2      | AgencyAdmin    |
And I am on project 'POTP2' settings page
When I edit the following fields for 'POTP2' project:
| Name  | Job Number | Media Type |
| POTP2 | POTJ2      | Digital    |
And click on element 'SaveButton'
And I login as 'AgencyAdmin'
And go to project 'POTP2' overview page
Then I 'should' see activity for user 'POTU2' on project 'POTP2' overview page with message 'updated project' and value 'POTP2'


Scenario: Check that click on file on Project Last activities section should redirect to file details page
Meta:@gdam
@projects
Given I created 'POTU2' User
And I logged in with details of 'POTU2'
And the following projects were created:
| Name  | Job Number | Administrators |
| POTP2 | POTJ2      | AgencyAdmin    |
And created '/F1' folder for project 'POTP2'
And uploaded into project 'POTP2' following files:
| FileName         | Path |
| /images/logo.jpg | /F1  |
| /images/logo.png | /F1  |
And waited while transcoding is finished in folder '/F1' on project 'POTP2' files page
When I login as 'AgencyAdmin'
And I go to project 'POTP2' overview page
And click on file 'logo.png' in project 'POTP2' overview activities
Then I should see file 'logo.png' info page in project 'POTP2' folder '/F1'


Scenario: Check that 'file copied' is displayed on Project Last activities in project overview
Meta:@gdam
     @bug
     @projects
!--FAB-495
Given I created 'POTU2' User
And I logged in with details of 'POTU2'
And the following projects were created:
| Name  | Job Number | Administrators |
| POTP2 | POTJ2      | AgencyAdmin    |
And created in 'POTP2' project next folders:
| folder |
| /F1    |
| /F2    |
And uploaded '/images/logo.png' file into '/F1' folder for 'POTP2' project
And waited while transcoding is finished in folder '/F1' on project 'POTP2' files page
And I am on project 'POTP2' folder '/F1' page
When I select file 'logo.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'Copy' on page 'FilesPage'
And select folder '/F2' on move/copy file popup
And click copy button on move/copy files popup
And I login as 'AgencyAdmin'
And go to project 'POTP2' overview page
Then I 'should' see activity for user 'POTU2' on project 'POTP2' overview page with message 'copied file from "POTP2/POTP2/F1" to "POTP2/POTP2/F2"' and value 'logo.png'


Scenario: Check that 'file moved' is displayed on Project Last activities in project overview
Meta:@gdam
@projects
Given I created 'POTU2' User
And I logged in with details of 'POTU2'
And the following projects were created:
| Name  | Job Number | Administrators |
| POTP2 | POTJ2      | AgencyAdmin    |
And created in 'POTP2' project next folders:
| folder |
| /F1    |
| /F3    |
And uploaded '/images/logo.png' file into '/F1' folder for 'POTP2' project
And waited while transcoding is finished in folder '/F1' on project 'POTP2' files page
And I am on project 'POTP2' folder '/F1' page
When I select file 'logo.png' on project files page
And click element 'MoreButton' on page 'FilesPage'
And click element 'Move' on page 'FilesPage'
And select folder '/F3' on move/copy file popup
And click move button on move/copy files popup
And I login as 'AgencyAdmin'
And go to project 'POTP2' overview page
Then I 'should' see activity for user 'POTU2' on project 'POTP2' overview page with message 'moved file from "POTP2/POTP2/F1" to "POTP2/POTP2/F3"' and value 'logo.png'


Scenario: Check that 'file played' is displayed on Project Last activities in project overview
Meta: @gdam
      @projects
Given I created 'POTU2' User
And I logged in with details of 'POTU2'
And the following projects were created:
| Name  | Job Number | Administrators |
| POTP2 | POTJ2      | AgencyAdmin    |
And created '/F1' folder for project 'POTP2'
And uploaded '/files/13DV-CAPITAL-10.mpg' file into '/F1' folder for 'POTP2' project
And I am on file '/files/13DV-CAPITAL-10.mpg' info page in folder '/F1' project 'POTP2'
When I wait while proxy is visible on file info page
And play clip on file '13DV-CAPITAL-10.mpg' info page in folder '/F1' project 'POTP2'
And wait for '1' seconds
And I login as 'AgencyAdmin'
And go to project 'POTP2' overview page
Then I 'should' see activity for user 'POTU2' on project 'POTP2' overview page with message 'played file' and value '/POTP2/F1/13DV-CAPITAL-10.mpg'


Scenario: Check that updated project logo should be displayed in Last project activity tab
Meta:@gdam
@projects
!--QA-1174
Given I am on Create New Project page
When I create 'POTP3' project with 'MandatoryFields' and 'JPG' logo
And go to project 'POTP3' overview page
And I refresh the page without delay
Then I 'should' see activity logo for project 'POTP3' overview page with activity 'created project' and 'JPG' logo
When I edit the following fields for 'POTP3' project:
| Name  | Logo   |
| POTP3 | PNG    |
And click on element 'SaveButton'
When I refresh the page without delay
Then I 'should' see activity logo for project 'POTP3' overview page with activity 'created project' and 'PNG' logo
