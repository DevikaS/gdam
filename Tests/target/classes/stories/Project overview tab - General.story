!--NGN-34
Feature:          Project overview tab - General
Narrative:
In order to
As a              AgencyAdmin
I want to         check general functionality on project overview tab

Scenario: Check that uploaded file is displayed in carousel
Meta:@gdam
@projects
Given I created following projects:
| Name  | Job Number |
| POGP1 | POGJ1      |
And created '/F1' folder for project 'POGP1'
And uploaded into project 'POGP1' following files:
| FileName         | Path |
| /files/logo1.gif | /F1  |
| /files/logo2.png | /F1  |
| /files/logo3.jpg | /F1  |
When I wait while transcoding is finished in folder '/F1' on project 'POGP1' files page
And go to project 'POGP1' overview page
Then I should see following files on project 'POGP1' overview page:
| FileName  |
| logo1.gif |
| logo2.png |
| logo3.jpg |


Scenario: Check that scrolling in carousel shows all files
Meta:@gdam
@projects
Given I created following projects:
| Name  | Job Number |
| POGP2 | POGJ2      |
And created '/F1' folder for project 'POGP2'
And uploaded into project 'POGP2' following files:
| FileName                    | Path |
| /files/logo1.gif            | /F1  |
| /files/logo2.png            | /F1  |
| /files/logo3.jpg            | /F1  |
| /files/logo4.bmp            | /F1  |
| /files/13DV-CAPITAL-10.mpg  | /F1  |
| /files/128_shortname.jpg    | /F1  |
| /files/CCITT_1.TIF          | /F1  |
| /files/test.ogg             | /F1  |
| /files/GWGTestfile064v3.pdf | /F1  |
| /files/index.html           | /F1  |
When I wait while transcoding is finished in folder '/F1' on project 'POGP2' files page
And I go to project 'POGP2' overview page
And scroll to the and files carousel on project 'POGP2' overview page
Then I should see following files on project 'POGP2' overview page:
| FileName             |
| logo1.gif            |
| logo2.png            |
| logo3.jpg            |
| logo4.bmp            |
| 13DV-CAPITAL-10.mpg  |
| 128_shortname.jpg    |
| CCITT_1.TIF          |
| test.ogg             |
| GWGTestfile064v3.pdf |
| index.html           |


Scenario: Check that file metadata is correctly shown in carusel
Meta:@gdam
@projects
Given I created following projects:
| Name  | Job Number |
| POGP2 | POGJ2      |
And created '/F1' folder for project 'POGP2'
And uploaded into project 'POGP2' following files:
| FileName                    | Path |
| /files/13DV-CAPITAL-10.mpg  | /F1  |
When I wait while transcoding is finished in folder '/F1' on project 'POGP2' files page
And I go to project 'POGP2' overview page
Then I should see following files metadata on project 'POGP2' overview page:
| FileName             | Duration | Size     | Type |
| 13DV-CAPITAL-10.mpg  | 3s 120ms | 408 KB   | MPEG |


Scenario: Check that 'Open asset' element and link on file name redirects to file details page
Meta:@gdam
@projects
Given I created following projects:
| Name  | Job Number |
| POGP1 | POGJ1      |
And created '/F1' folder for project 'POGP1'
And uploaded '/files/logo1.gif' file into '/F1' folder for 'POGP1' project
When I wait while transcoding is finished in folder '/F1' on project 'POGP1' files page
And I go to project 'POGP1' overview page
And open file 'logo1.gif' on project 'POGP1' overview page
Then I should see file 'logo1.gif' info page in project 'POGP1' folder '/F1'


Scenario: Check that thumbnails for transcoded files is displayed
Meta:@gdam
@projects
Given I created following projects:
| Name  | Job Number |
| POGP1 | POGJ1      |
And created '/F1' folder for project 'POGP1'
And uploaded '/files/logo1.gif' file into '/F1' folder for 'POGP1' project
When I wait while preview is available in folder '/F1' on project 'POGP1' files page
And I go to project 'POGP1' overview page
Then Files preview should be available on project 'POGP1' overview page


Scenario: Check 'Edit' element
Meta:@gdam
@projects
Given I created following projects:
| Name  | Job Number |
| POGP1 | POGJ1      |
And created '/F1' folder for project 'POGP1'
When I go to project 'POGP1' overview page
And rename folder '/F1' to 'F1_1' on project 'POGP1' overview page
Then I should see folder 'F1_1' on project 'POGP1' files page


Scenario: Check 'Open folder' function
Meta:@gdam
@projects
Given I created following projects:
| Name  | Job Number |
| POGP1 | POGJ1      |
And created '/F1' folder for project 'POGP1'
When I go to project 'POGP1' overview page
And select folder '/F1' in project 'POGP1'
Then I should see folder 'F1' on project 'POGP1' files page


Scenario: Check that for agency admin user appears all elements in folder drop down menu
Meta:@gdam
@projects
Given I created following projects:
| Name  | Job Number |
| POGP1 | POGJ1      |
And created '/F1' folder for project 'POGP1'
When I go to project 'POGP1' overview page
And open pop up menu of folder '/F1' on project 'POGP1' overview page
Then I 'should' see in pop up menu for folder '/F1' in project 'POGP1' overview page following items:
| item        |
| Open folder |
| Edit        |
| Share       |
| New Folder  |
| Remove      |


Scenario: Check that too long names of files are wrapped in carousel
Meta:@gdam
@projects
Given I created following projects:
| Name  | Job Number |
| POGP1 | POGJ1      |
And created '/F1' folder for project 'POGP1'
And uploaded '/files/logo1.gif' file into '/F1' folder for 'POGP1' project
When I wait while transcoding is finished in folder '/F1' on project 'POGP1' files page
And I set title 'qwertyuioasdfghjklzxcvbnqwerty' for file 'logo1.gif' in folder '/F1' of project 'POGP1'
And I go to project 'POGP1' overview page
Then I should see file 'qwertyuioasdfghjklzxcvbnqwerty' with wrapped title from folder '/F1' on project 'POGP1' overview page


Scenario: Check that Edit link, Create template from project link, Delete project link is displayed on Project Overview
Meta:@gdam
@projects
Given I created following projects:
| Name  | Job Number |
| POGP1 | POGJ1      |
When I go to project 'POGP1' overview page
Then I 'should' see following elements on page 'ProjectsOverview':
| element                       |
| EditLink                      |
| CreateTemplateFromProjectLink |
| DeleteProjectLink             |


Scenario: Check that particular menu points is available for Project Root on Project Overview
Meta:@gdam
@projects
Given I created following projects:
| Name  | Job Number |
| POGP1 | POGJ1      |
And I am on project 'POGP1' overview page
When I open pop up menu of folder '/' on project 'POGP1' overview page
Then I 'should' see in pop up menu for folder '/' in project 'POGP1' overview page following items:
| item        |
| New Folder  |
| Open folder |
| Edit        |
| Copy        |
| Share       |
And 'should not' see in pop up menu for folder '/' in project 'POGP1' overview page following items:
| item        |
| Remove      |


Scenario: Check that updated project logo should be displayed in project overview page
Meta:@gdam
@projects
!-- QA-1174
Given I am on Create New Project page
When I create 'POGP3' project with 'MandatoryFields' and 'JPG' logo
And go to project 'POGP3' overview page
Then 'should' see project 'POGP3' with logo 'JPG' in project overview page
When I edit the following fields for 'POGP3' project:
| Name  | Logo   |
| POGP3 | PNG    |
And click on element 'SaveButton'
When I refresh the page without delay
Then 'should' see project 'POGP3' with logo 'PNG' in project overview page