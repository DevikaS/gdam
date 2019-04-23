!--NGN-39
Feature:          Create new folder in project
Narrative:
In order to
As a              AgencyAdmin
I want to         Check creating of a new Folder

Scenario: New Folder creation (smoke)
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @projects
Given I created 'Project1' project
When I create '/Nødhjælp' folder in 'Project1' project
Then I 'should' see '/Nødhjælp' folder in 'Project1' project


Scenario: New Folder creation
Meta:@gdam
     @projects
Given I created 'Project1' project
When I create '<Folder>' folder in 'Project1' project
Then I 'should' see '<Folder>' folder in 'Project1' project

Examples:
| Folder              |
| /Nødhjælp           |
| /Nødhjælp/O'Higgins |
| /Nødhjælp/Nødhjælp  |


Scenario: Proper creating several folders
Meta:@gdam
     @projects
Given I created 'Project3_2' project
And created '/NEW' folder for project 'Project3_2'
When I create '6' folders in folder '/NEW' for project 'Project3_2'
Then I should see '6' folders in '/NEW' for project 'Project3_2'


Scenario: Successfully editing of folder name
Meta:@gdam
     @projects
Given I created '<Project>' project
And created '<Folder1>' folder for project '<Project>'
And created '<Folder2>' folder for project '<Project>'
When I rename folder '<Folder2>' to '<FolderNewName>' in '<Project>' project
Then I '<Condition1>' see error message 'Folder with this name already exist'
And '<Condition2>' see '<FolderNewName>' folder in '<Project>' project
And '<Condition3>' see '<Folder2>' folder in '<Project>' project

Examples:
| Project  | Folder1 | Folder2 | FolderNewName | Condition1 | Condition2 | Condition3 |
| Project4 | /NEW    | /NEW2   | LOL           | should not | should     | should not |
| Project4 | /NEW    | /LOL    | NEW           | should     | should     | should     |


Scenario: Empty field
Meta:@gdam
     @projects
Given I created 'Project5' project
When I create '' folder in 'Project5' project
Then I 'should' see red inputs on page


Scenario: Create folder with 'New folder' button help (new button is added in header)
Meta:@gdam
     @projects
!--is not realized yet | FFF4 | /Project root | /Test | /Project root/Test | should |
Given I created '<ProjectName>' project
And created '<Folder>' folder for project '<ProjectName>'
When I create sub folder '<NewFolder>' in folder '<Folder>' in project '<ProjectName>' using button NewFolder
And refresh the page
Then I '<ShouldSee>' see '<CheckFolder>' folder in '<ProjectName>' project

Examples:
| ProjectName | Folder   | NewFolder | CheckFolder   | ShouldSee |
| FFF1        | /NEW     | Test      | /NEW/Test     | should    |
| FFF2        | /NEW/Sub | Test      | /NEW/Sub/Test | should    |
| FFF3        | /NEW/NEW | Test      | /NEW/NEW/Test | should    |