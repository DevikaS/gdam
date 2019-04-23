!--NGN-7068
Feature:          Project and Template - Folders sorting
Narrative:
In order to
As a              AgencyAdmin
I want to         Check sorting of a new Folder

Meta:
@component project

Scenario: Sorting of New Folder creation in project
Meta:@gdam
@projects
Given I created 'P_PTFS_S01' project
And created in 'P_PTFS_S01' project next folders:
| folder        |
| /F_PTFS_S01_1 |
| /F_PTFS_S01_2 |
| /F_PTFS_S01_3 |
| /F_PTFS_S01_4 |
| /F_PTFS_S01_5 |
When I go to project 'P_PTFS_S01' files page
And click element 'ProjectRoot' on page 'FilesPage'
And click element 'SortByComboBox' on page 'FilesPage'
And click element '<SortingOption>' on page 'FilesPage'
Then I 'should' see folders sorted in the following order '<Result>' on opened project page

Examples:
| SortingOption         | Result                                                           |
| SortByNewestFirst     | F_PTFS_S01_5,F_PTFS_S01_4,F_PTFS_S01_3,F_PTFS_S01_2,F_PTFS_S01_1 |
| SortByTitleAscending  | F_PTFS_S01_1,F_PTFS_S01_2,F_PTFS_S01_3,F_PTFS_S01_4,F_PTFS_S01_5 |


Scenario: Sorting of New Folder creation in template
Meta:@gdam
@projects
Given I created 'T_PTFS_S02' template
And created in 'T_PTFS_S02' template next folders:
| folder        |
| /F_PTFS_S02_1 |
| /F_PTFS_S02_2 |
| /F_PTFS_S02_3 |
| /F_PTFS_S02_4 |
| /F_PTFS_S02_5 |
When I go to template 'T_PTFS_S02' files page
And click element 'ProjectRoot' on page 'FilesPage'
And click element 'SortByComboBox' on page 'FilesPage'
And click element '<SortingOption>' on page 'FilesPage'
Then I 'should' see folders sorted in the following order '<Result>' on opened template page

Examples:
| SortingOption         | Result                                                           |
| SortByNewestFirst     | F_PTFS_S02_5,F_PTFS_S02_4,F_PTFS_S02_3,F_PTFS_S02_2,F_PTFS_S02_1 |
| SortByTitleDescending | F_PTFS_S02_5,F_PTFS_S02_4,F_PTFS_S02_3,F_PTFS_S02_2,F_PTFS_S02_1 |


Scenario: check folders sorting after delete in project
Meta:@gdam
@projects
Given I created 'P_PTFS_S03' project
And created in 'P_PTFS_S03' project next folders:
| folder        |
| /F_PTFS_S03_1 |
| /F_PTFS_S03_2 |
| /F_PTFS_S03_3 |
| /F_PTFS_S03_4 |
| /F_PTFS_S03_5 |
And deleted folder '/F_PTFS_S03_3' in project 'P_PTFS_S03'
When I go to project 'P_PTFS_S03' files page
And click element 'ProjectRoot' on page 'FilesPage'
And click element 'SortByComboBox' on page 'FilesPage'
And click element '<SortingOption>' on page 'FilesPage'
Then I 'should' see folders sorted in the following order '<Result>' on opened project page

Examples:
| SortingOption         | Result                                              |
| SortByNewestFirst     | F_PTFS_S03_5,F_PTFS_S03_4,F_PTFS_S03_2,F_PTFS_S03_1 |
| SortByTitleAscending  | F_PTFS_S03_1,F_PTFS_S03_2,F_PTFS_S03_4,F_PTFS_S03_5 |


Scenario: check folders sorting after delete in template
Meta:@gdam
@projects
Given I created 'T_PTFS_S04' template
And created in 'T_PTFS_S04' template next folders:
| folder        |
| /F_PTFS_S04_1 |
| /F_PTFS_S04_2 |
| /F_PTFS_S04_3 |
| /F_PTFS_S04_4 |
| /F_PTFS_S04_5 |
And deleted folder '/F_PTFS_S04_3' in template 'T_PTFS_S04'
When I go to template 'T_PTFS_S04' files page
And click element 'ProjectRoot' on page 'FilesPage'
And click element 'SortByComboBox' on page 'FilesPage'
And click element '<SortingOption>' on page 'FilesPage'
Then I 'should' see folders sorted in the following order '<Result>' on opened template page

Examples:
| SortingOption         | Result                                              |
| SortByNewestFirst     | F_PTFS_S04_5,F_PTFS_S04_4,F_PTFS_S04_2,F_PTFS_S04_1 |
| SortByTitleDescending | F_PTFS_S04_5,F_PTFS_S04_4,F_PTFS_S04_2,F_PTFS_S04_1 |


Scenario: check folders sorting after rename in project
Meta:@gdam
@projects
Given I created '<ProjectName>' project
And created in '<ProjectName>' project next folders:
| folder        |
| /F_PTFS_S05_1 |
| /F_PTFS_S05_2 |
| /F_PTFS_S05_3 |
| /F_PTFS_S05_4 |
| /F_PTFS_S05_5 |
And renamed folder '/F_PTFS_S05_3' to 'F_PTFS_S05_6' in '<ProjectName>' project
When I go to project '<ProjectName>' files page
And click element 'ProjectRoot' on page 'FilesPage'
And click element 'SortByComboBox' on page 'FilesPage'
And click element '<SortingOption>' on page 'FilesPage'
And refresh the page
Then I 'should' see folders sorted in the following order '<Result>' on opened project page

Examples:
| ProjectName  | SortingOption         | Result                                                           |
| P_PTFS_S05_1 | SortByNewestFirst     | F_PTFS_S05_5,F_PTFS_S05_4,F_PTFS_S05_6,F_PTFS_S05_2,F_PTFS_S05_1 |
| P_PTFS_S05_2 | SortByTitleAscending  | F_PTFS_S05_1,F_PTFS_S05_2,F_PTFS_S05_4,F_PTFS_S05_5,F_PTFS_S05_6 |


Scenario: check folders sorting after rename in template
Meta:@gdam
@projects
Given I created '<TemplateName>' template
And created in '<TemplateName>' template next folders:
| folder        |
| /F_PTFS_S06_1 |
| /F_PTFS_S06_2 |
| /F_PTFS_S06_3 |
| /F_PTFS_S06_4 |
| /F_PTFS_S06_5 |
And renamed folder '/F_PTFS_S06_3' to 'F_PTFS_S06_6' in '<TemplateName>' template
When I go to template '<TemplateName>' files page
And click element 'ProjectRoot' on page 'FilesPage'
And click element 'SortByComboBox' on page 'FilesPage'
And click element '<SortingOption>' on page 'FilesPage'
Then I 'should' see folders sorted in the following order '<Result>' on opened template page

Examples:
| TemplateName | SortingOption         | Result                                                           |
| T_PTFS_S06_1 | SortByNewestFirst     | F_PTFS_S06_5,F_PTFS_S06_4,F_PTFS_S06_6,F_PTFS_S06_2,F_PTFS_S06_1 |
| T_PTFS_S06_3 | SortByTitleDescending | F_PTFS_S06_6,F_PTFS_S06_5,F_PTFS_S06_4,F_PTFS_S06_2,F_PTFS_S06_1 |