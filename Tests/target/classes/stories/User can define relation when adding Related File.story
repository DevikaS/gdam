!--NGN-13201
Feature:          User can define relation when adding Related File
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check that user can define relation when adding Related File


Scenario: Check that List of Relations should list all possible Relation Roles (i.e. Parent, Child, Master, Version, Other)
Meta:@gdam
@projects
Given I created '<ProjectName>' project
And created '/F_UCDRWARF_S01' folder for project '<ProjectName>'
And uploaded '/files/image9.jpg' file into 'F_UCDRWARF_S01' folder for '<ProjectName>' project
And uploaded '/files/image10.jpg' file into 'F_UCDRWARF_S01' folder for '<ProjectName>' project
And waited while transcoding is finished in folder 'F_UCDRWARF_S01' on project '<ProjectName>' files page
When I add related file 'image9.jpg' such as '<RelatedFileType>' for file from folder 'F_UCDRWARF_S01' from project '<ProjectName>' to file 'image10.jpg'
And go to file 'image9.jpg' in 'F_UCDRWARF_S01' in project '<ProjectName>' on related files page
Then 'should' see following related files on related files page:
| FileName    | ProjectName   | IsRelatedAs           |
| image10.jpg | <ProjectName> | <StatusForParentFile> |
When I go to file 'image10.jpg' in 'F_UCDRWARF_S01' in project '<ProjectName>' on related files page
Then 'should' see following related files on related files page:
| FileName    | ProjectName   | IsRelatedAs                |
| image9.jpg  | <ProjectName> | <StatusForDestinationFile> |

Examples:
| RelatedFileType | StatusForParentFile | StatusForDestinationFile | ProjectName    |
| parent          | Parent              | Child                    | P_UCDRWARF_S01 |
| master          | Version             | Master                   | P_UCDRWARF_S02 |


Scenario: Check that When user selects Role, UI shows hint: Selected files become [Role 1] to [Role 2]
Meta:@gdam
@projects
Given I created '<Project>' project
And created '/F_UCDRWARF_S03' folder for project '<Project>'
And uploaded '<Path1>' file into 'F_UCDRWARF_S03' folder for '<Project>' project
And uploaded '<Path2>' file into 'F_UCDRWARF_S03' folder for '<Project>' project
And waited while transcoding is finished in folder 'F_UCDRWARF_S03' on project '<Project>' files page
When I go to file '<File1>' in 'F_UCDRWARF_S03' in project '<Project>' on related files page
And type related file '<File2>' on related files page on pop-up
And select following related files '<File2>' on related file pop-up
And selected type of files become as '<FilesBecomeTypes>' on related file pop-up
And click on save button on related file pop-up
And wait for '3' seconds
And refresh the page
Then I 'should' see destination role '<FilesBecomeTypes>' on related file pop-up

Examples:
| FilesBecomeTypes | Project          | File1      |   File2    |     Path1           |    Path2          |
| Parent           | P_UCDRWARF_S03_1 |image9.jpg  |image10.jpg | /files/image9.jpg   |/files/image10.jpg |
| Child            | P_UCDRWARF_S03_2 |logo1.gif   |logo2.png   |/files/logo1.gif     |/files/logo2.png   |
| Master           | P_UCDRWARF_S03_3 |logo3.png   |logo3.txt   |/files/logo3.png     |/files/logo3.txt   |
| Version          | P_UCDRWARF_S03_4 |Fish1-Ad.mov|Fish2-Ad.mov|/files/Fish1-Ad.mov  |/files/Fish2-Ad.mov|
