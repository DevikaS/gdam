!--NGN-527
Feature:          Folder view - Search
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Search in Folder view

Scenario: Check Search in Folder view
Meta:@gdam
@projects
Given I created 'FVP1' project
And created in 'FVP1' project next folders:
| folder  |
| /main   |
| /q3we   |
| /qwe    |
| /qwerty |
And I am on project 'FVP1' folder '/main' page
And I have refreshed the page
When I type folder name '<Data>' in search folders field in project 'FVP1' folder '/main'
Then I '<Should>' see element 'ErrorMessage' on page 'FilesPage'
And I should see folder '<Result>' on project 'FVP1' files page

Examples:
| Data | Should     | Result |
| q3we | should not | q3we   |
| qa   | should     | main   |


Scenario: Check open Search result in Folder view
Meta:@gdam
@projects
Given I created 'FVP2' project
And created in 'FVP2' project next folders:
| folder  |
| /main   |
| /q3we   |
| /qwe    |
| /qwerty |
And uploaded into project 'FVP2' following files:
| FileName                     | Path    |
| /files/for_babylon43.7z      | /q3we   |
| /files/GWGTestfile064v3.pdf  | /qwe    |
| /files/New Text Document.txt | /qwerty |
And I am on project 'FVP2' folder '/main' page
When I type folder name '<Data>' in search folders field in project 'FVP2' folder '/main'
Then I 'should' see '<Name>' file inside '<Path>' folder for 'FVP2' project

Examples:
| Data   | Path    | Name                  |
| q3we   | /q3we   | for_babylon43.7z      |


Scenario: Check Search in Folder view on Templates
Meta:@gdam
@projects
Given I created 'FVT1' template
And created in 'FVT1' template next folders:
| folder  |
| /main   |
| /q3we   |
| /qwe    |
| /qwerty |
And I am on template 'FVT1' folder '/main' page
When I  type folder name '<Data>' in search folders field in template 'FVT1' folder '/main'
Then I '<Should>' see element 'ErrorMessage' on page 'FilesPage'
And I should see folder '<Result>' on template 'FVT1' files page

Examples:
| Data   | Should     | Result |
| qwerty | should not | qwerty |
| qa     | should     | main   |


Scenario: Check open Search result in Folder view on Templates
Meta:@gdam
@projects
Given I created 'FVT2' template
And created in 'FVT2' template next folders:
| folder  |
| /main   |
| /q3we   |
| /qwe    |
| /qwerty |
And uploaded into template 'FVT2' following files:
| FileName                     | Path    |
| /files/for_babylon43.7z      | /q3we   |
| /files/GWGTestfile064v3.pdf  | /qwe    |
| /files/New Text Document.txt | /qwerty |
And I am on template 'FVT2' folder '/main' page
When I  type folder name '<Data>' in search folders field in template 'FVT2' folder '/main'
Then I should see '<Name>' file inside '<Path>' folder for 'FVT2' template

Examples:
| Data   | Path    | Name                  |
| qwerty | /qwerty | New Text Document.txt |