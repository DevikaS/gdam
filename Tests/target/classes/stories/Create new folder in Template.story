!--NGN-755
Feature:          Create new folder in Template
Narrative:
In order to
As a              AgencyAdmin
I want to         Check creating of a new Folder

Scenario: New Folder creation
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @projects
Given I am on Dashboard page
And created 'T_CFT_S01' template
When I create '/F_CFT_S01' folder for template 'T_CFT_S01'
And refresh the page
Then I 'should' see '/F_CFT_S01' folder in 'T_CFT_S01' template


Scenario: New Folder creation with same name
Meta:@gdam
	  @projects
Given I created 'CFTT3' template
When I create '/NEW' folder in 'CFTT3' template
And I create '/NEW' folder in 'CFTT3' template
Then I 'should' see error message 'Folder with this name already exist'


Scenario: Proper creating several folders
Meta:@gdam
	  @projects
Given I created 'CFTT4' template
And created '/NEW' folder for template 'CFTT4'
When I create '6' folders in folder '/NEW' for template 'CFTT4'
Then I should see '6' folders in '/NEW' for template 'CFTT4'


Scenario: Successfully editing of folder name
Meta:@gdam
	  @projects
Given I created 'CFTT5' template
And created '<Folder1>' folder for template 'CFTT5'
And created '<Folder2>' folder for template 'CFTT5'
When I rename folder '<Folder2>' to '<FolderNewName>' in 'CFTT5' template
Then I '<ShouldError>' see error message 'Folder with this name already exist'
And 'should' see '<FolderNewName>' folder in 'CFTT5' template
And '<Should>' see '<Folder2>' folder in 'CFTT5' template

Examples:
| Folder1 | Folder2 | FolderNewName | Should     | ShouldError |
| /NEW    | /NEW2   | LOL           | Should not | should not  |
| /NEW    | /LOL    | NEW           | Should     | should      |


Scenario: Empty field
Meta:@gdam
	  @projects
Given I created 'CFTT6' template
When I create '' folder in 'CFTT6' template
Then I 'should' see red inputs on page


Scenario: Create folder with 'New folder' button help (new button is added in header)
Meta:@gdam
	  @projects
Given I created '<TemplateName>' template
And created '<Folder>' folder for template '<TemplateName>'
When I create sub folder '<NewFolder>' in folder '<Folder>' in template '<TemplateName>' using button NewFolder
And wait for '2' seconds
Then I '<ShouldSee>' see '<CheckFolder>' folder in '<TemplateName>' template

Examples:
| TemplateName | Folder   | NewFolder | CheckFolder   | ShouldSee |
| CFTT9_1      | /NEW     | Test      | /NEW/Test     | should    |
| CFTT9_2      | /NEW/Sub | Test      | /NEW/Sub/Test | should    |
| CFTT9_3      | /NEW/NEW | Test      | /NEW/NEW/Test | should    |