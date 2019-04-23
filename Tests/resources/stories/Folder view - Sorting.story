!--NGN-525
Feature:          Folder view - Sorting
Narrative:
In order to
As a              AgencyAdmin
I want to         Sorting uploaded files in folder

Scenario: Check availability sorting options
Meta:@gdam
@projects
Given I created 'FVP1' project
And created '/FVF1' folder for project 'FVP1'
And I am on project 'FVP1' folder '/FVF1' page
When I click element 'SortByComboBox' on page 'FilesPage'
Then I 'should' see following elements on page 'FilesPage':
| element               |
| SortByNewestFirst     |
| SortByTitleAscending  |
| SortByTitleDescending |
| SortBySizeDescending  |
| SortBySizeAscending   |


Scenario: Check that 'Newest first' option is default sorting option
Meta:@gdam
@projects
Given I created 'FVP2' project
And created '/FVF2' folder for project 'FVP2'
And uploaded into project 'FVP2' following files:
| FileName                 | Path  |
| /files/128_shortname.jpg | /FVF2 |
| /files/Fish1-Ad.mov      | /FVF2 |
| /files/_file1.gif        | /FVF2 |
And waited while preview is available in folder '/FVF2' on project 'FVP2' files page
Then should see sorting type 'Most recently uploaded First' is selected on project 'FVP2' folder '/FVF2' page
And should see sorting files by 'Most recently uploaded First' on project 'FVP2' folder '/FVF2'


Scenario: Check sorting
Meta:@gdam
@projects
Given I created 'FVP3' project
And created '/FVF3' folder for project 'FVP3'
And uploaded into project 'FVP3' following files:
| FileName                 | Path  |
| /files/128_shortname.jpg | /FVF3 |
| /files/Fish1-Ad.mov      | /FVF3 |
| /files/_file1.gif        | /FVF3 |
And I am on project 'FVP3' folder '/FVF3' page
When I wait while transcoding is finished in folder '/FVF3' on project 'FVP3' files page
And click element 'SortByComboBox' on page 'FilesPage'
And click element '<SortingOption>' on page 'FilesPage'
Then I should see sorting files by '<Result>' on project 'FVP3' folder '/FVF3'

Examples:
| SortingOption         | Result                       |
| SortByNewestFirst     | Most recently uploaded First |
| SortByTitleDescending | Title (Z to A)               |
| SortBySizeAscending   | Size (Ascending)             |


Scenario: Check availability sorting options for Templates
Meta:@gdam
@projects
Given I created 'FVT1' template
And created '/FVF1' folder for template 'FVT1'
And I am on template 'FVT1' folder '/FVF1' page
When I click element 'SortByComboBox' on page 'FilesPage'
Then I 'should' see following elements on page 'FilesPage':
| element               |
| SortByNewestFirst     |
| SortByTitleAscending  |
| SortByTitleDescending |
| SortBySizeDescending  |
| SortBySizeAscending   |


Scenario: Check that 'Newest first' option is default sorting option for Templates
Meta:@gdam
@projects
Given I created 'FVT2' template
And created '/FVF2' folder for template 'FVT2'
And uploaded into template 'FVT2' following files:
| FileName                 | Path  |
| /files/128_shortname.jpg | /FVF2 |
| /files/Fish1-Ad.mov      | /FVF2 |
| /files/_file1.gif        | /FVF2 |
And I am on template 'FVT2' folder '/FVF2' page
Then should see sorting type 'Most recently uploaded First' is selected on template 'FVT2' folder '/FVF2' page
And should see sorting files by 'Most recently uploaded First' on template 'FVT2' folder '/FVF2'



Scenario: Check sorting for Templates
Meta:@gdam
@projects
Given I created 'FVT3' template
And created '/FVF3' folder for template 'FVT3'
And uploaded into template 'FVT3' following files:
| FileName                 | Path  |
| /files/128_shortname.jpg | /FVF3 |
| /files/Fish1-Ad.mov      | /FVF3 |
| /files/_file1.gif        | /FVF3 |
And I am on template 'FVT3' folder '/FVF3' page
When I wait while transcoding is finished in folder '/FVF3' on template 'FVT3' files page
And click element 'SortByComboBox' on page 'FilesPage'
And click element '<SortingOption>' on page 'FilesPage'
Then I should see sorting files by '<Result>' on template 'FVT3' folder '/FVF3'

Examples:
| SortingOption         | Result                       |
| SortByNewestFirst     | Most recently uploaded First |
| SortByTitleAscending  | Title (A to Z)               |
| SortBySizeDescending  | Size (Descending)            |