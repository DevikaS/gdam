!-- NGN-3414
Feature:          Add default project role - Project.Observer
Narrative:
In order to
As a              AgencyAdmin
I want to         Check default project role - Project.Observer

Scenario: Check that default Project.Observer role is available by default
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
And I am on global roles page
Then I 'should' see 'project.observer' role on in the roles list


Scenario: Check that Project.Observer role has correctly specified permissions
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
And I am on global roles page
When I open role 'project.observer' page with parent 'DefaultAgency'
And refresh the page
Then I should see role 'project.observer' that 'should' contains following selected permissions 'comment.create,comment.delete,comment.read,folder.share,folder.read,element.read,project.read'
And I should see role 'project.observer' that 'should not' contains following selected permissions 'project.settings.read,project_team.delete,project_team.write,project_team.read,project_template.write,project_template.read,activity.read,file.download,folder.create,element.create,folder.delete,element.delete,folder.write,element.write,project.write'


Scenario: Check that Project.Observer role isn't editable on agency level
Meta: @skip
      @gdam
Given I am on roles page
When I open role 'project.observer' page
And I click role 'Project observer' on roles list
Then I 'should' see that all permissions check boxes are disabled for role 'project.observer'
And I should see role name text field is 'disabled' on role 'project.observer' page

Scenario: Check that Project.Observer role is pre-populated on Share Folder
Meta:@gdam
      @projects
Given I created '2 Unlimited. 1993,  No Limits! PO004' project
And created '/No limits' folder for project '2 Unlimited. 1993,  No Limits! PO004'
When I open Share window from popup menu for folder '/No limits' on project '2 Unlimited. 1993,  No Limits! PO004'
Then I 'should' see role 'Project Observer' in the role dropdown on Share popup

Scenario: Check that Project.Observer role is pre-populated on Add User pop-up on Team tab
Meta:@gdam
      @projects
Given I created '2 Unlimited. 1993,  No Limits! PO005' project
And created '/Tribal dance' folder for project '2 Unlimited. 1993,  No Limits! PO005'
And I am on project '2 Unlimited. 1993,  No Limits! PO005' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And I click element 'AddMemberUserItem' on page 'TeamsPage'
Then I 'should' see role 'Project Observer' in roles list of add user to project '2 Unlimited. 1993,  No Limits! PO005' team popup


Scenario: Check that 'create comment' permission of Project.Observer role correct work in shared folder
Meta:@gdam
      @projects
Given I created '2 Unlimited. 1993,  No Limits! PCO07' project
And created '/Mysterious' folder for project '2 Unlimited. 1993,  No Limits! PCO07'
And I uploaded '/files/logo3.jpg' file into '/Mysterious' folder for '2 Unlimited. 1993,  No Limits! PCO07' project
And waited while transcoding is finished in folder '/Mysterious' on project '2 Unlimited. 1993,  No Limits! PCO07' files page
And I created users with following fields:
| Email     | Role        |
| Blake_007 | agency.user |
And I added users 'Blake_007' to project '2 Unlimited. 1993,  No Limits! PCO07' team folders '/Mysterious' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Blake_007'
When I go to the file comments page project '2 Unlimited. 1993,  No Limits! PCO07' and folder '/Mysterious' and file 'logo3.jpg'
Then I 'should' see comment textarea on current file comment page
When I add comment 'Without sense, but female is pretty' into current file
Then I 'should' see comment 'Without sense, but female is pretty' on file 'logo3.jpg' comments page on folder '/Mysterious' in project '2 Unlimited. 1993,  No Limits! PCO07'


Scenario: Check that 'view comment' permission of Project.Observer role correct work on shared folder
Meta:@gdam
      @projects
Given I created '2 Unlimited. 1993,  No Limits! PO008' project
And created '/Faces' folder for project '2 Unlimited. 1993,  No Limits! PO008'
And I uploaded '/files/logo3.jpg' file into '/Faces' folder for '2 Unlimited. 1993,  No Limits! PO008' project
And waited while transcoding is finished in folder '/Faces' on project '2 Unlimited. 1993,  No Limits! PO008' files page
And I created users with following fields:
| Email         |
| Aaliyah_PC008 |
And I am on the file comments page project '2 Unlimited. 1993,  No Limits! PO008' and folder '/Faces' and file 'logo3.jpg'
And I added comment 'Funny song. Not bad' into current file
And I added users 'Aaliyah_PC008' to project '2 Unlimited. 1993,  No Limits! PO008' team folders '/Faces' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Aaliyah_PC008'
When I go to the file comments page project '2 Unlimited. 1993,  No Limits! PO008' and folder '/Faces' and file 'logo3.jpg'
Then I 'should' see comment 'Funny song. Not bad' on file 'logo3.jpg' comments page on folder '/Faces' in project '2 Unlimited. 1993,  No Limits! PO008'


Scenario: Check that 'download file' permission of Project.Observer role correct work on file details in shared folder
Meta:@gdam
      @projects
Given I created '2 Unlimited. 1993,  No Limits! PO009' project
And created '/Maximum overdrive' folder for project '2 Unlimited. 1993,  No Limits! PO009'
And I uploaded '/files/filetext.txt' file into '/Maximum overdrive' folder for '2 Unlimited. 1993,  No Limits! PO009' project
And I created users with following fields:
| Email | Role        |
| Jesse | agency.user |
And waited while transcoding is finished in folder '/Maximum overdrive' on project '2 Unlimited. 1993,  No Limits! PO009' files page
And I added users 'Jesse' to project '2 Unlimited. 1993,  No Limits! PO009' team folders '/Maximum overdrive' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Jesse'
When I go to file 'filetext.txt' info page in folder '/Maximum overdrive' project '2 Unlimited. 1993,  No Limits! PO009'
Then I 'should not' see element 'DownloadOriginal' on page 'FileInfoPage'
And I 'should not' see element 'DownloadMasterUsignnVerge' on page 'FileInfoPage'


Scenario: Check that 'download file' permission of Project.Observer role correct work on version history in shared folder
Meta:@gdam
      @projects
Given I created '2 Unlimited. 1993,  No Limits! PC010' project
And created '/ltb' folder for project '2 Unlimited. 1993,  No Limits! PC010'
And I uploaded '/files/filetext.txt' file into '/ltb' folder for '2 Unlimited. 1993,  No Limits! PC010' project
And I created users with following fields:
| Email  | Role        |
| Sierra | agency.user |
And I added users 'Sierra' to project '2 Unlimited. 1993,  No Limits! PC010' team folders '/ltb' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Sierra'
And I am on file 'filetext.txt' info page in folder '/ltb' project '2 Unlimited. 1993,  No Limits! PC010' tab version history
Then I 'should not' see download original link on the current file version history tab


Scenario: Check that 'download file' permission of Project.Observer role correct work in shared folder
Meta:@gdam
      @projects
Given I created '2 Unlimited. 1993,  No Limits! PO011' project
And created '/Maximum overdrive' folder for project '2 Unlimited. 1993,  No Limits! PO011'
And I uploaded '/images/logo.jpg' file into '/Maximum overdrive' folder for '2 Unlimited. 1993,  No Limits! PO011' project
And I created users with following fields:
| Email  | Role        |
| Leslie | agency.user |
And waited while preview is available in folder '/Maximum overdrive' on project '2 Unlimited. 1993,  No Limits! PO011' files page
And I added users 'Leslie' to project '2 Unlimited. 1993,  No Limits! PO011' team folders '/Maximum overdrive' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Leslie'
And I am on project '2 Unlimited. 1993,  No Limits! PO011' folder '/Maximum overdrive' page
When I select file 'logo.jpg' on project files page
And click Download button on project files page
Then I 'should' see count '0' of download link for current project
And I 'should not' see 'preview' as part of download file name for current project
And I 'should not' see 'original' as part of download file name for current project


Scenario: Check that 'create folder & files' permission of Project.Observer role correct work in shared folder
Meta:@gdam
     @projects
Given I created '2 Unlimited. 1993,  No Limits! PC012' project
And created '/Let the beat control your body' folder for project '2 Unlimited. 1993,  No Limits! PC012'
And I created users with following fields:
| Email   | Role        |
| Antonio | agency.user |
And I added users 'Antonio' to project '2 Unlimited. 1993,  No Limits! PC012' team folders '/Let the beat control your body' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Antonio'
When I go to project '2 Unlimited. 1993,  No Limits! PC012' folder '/Let the beat control your body' page
Then I 'should not' see new folder button on project '2 Unlimited. 1993,  No Limits! PC012' folder '/Let the beat control your body' page
And I should see drop down menu items for project '2 Unlimited. 1993,  No Limits! PC012' folder '/Let the beat control your body' according to:
| Name       | ShouldState |
| New Folder | should not  |


Scenario: Check that 'view folder & files', 'view projects' permissions of Project.Observer role correct work on shared folder in case of search demand object
Meta:@gdam
     @projects
Given I created 'Accept. Russian Roulette P0014' project
And created '/TV War Folder' folder for project 'Accept. Russian Roulette P0014'
And I uploaded '/files/filetext.txt' file into '/TV War Folder' folder for 'Accept. Russian Roulette P0014' project
And I created users with following fields:
| Email    | Role        |
| Danielle | agency.user |
And waited while transcoding is finished in folder '/TV War Folder' on project 'Accept. Russian Roulette P0014' files page
And I added users 'Danielle' to project 'Accept. Russian Roulette P0014' team folders '/TV War Folder' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Danielle'
When I search by text 'Accept'
Then I 'should' see search object 'Accept. Russian Roulette P0014' with type 'Project' after wrap according to search 'Accept. Russian Roulette P0014' with 'Name' type
When I search by text 'TV War'
Then I 'should' see search object 'TV War Folder' with type 'Folder' after wrap according to search 'TV War Folder' with 'Name' type
When I search by text 'filetext'
Then I 'should' see search object 'filetext.txt' with type 'Files & Folders' after wrap according to search 'filetext' with 'Name' type


Scenario: Check that 'view projects' permission of Project.Observer role correct work on shared folder
Meta:@gdam
      @projects
Given I created 'Accept - Russian Roulette' project
And created '/Deliver Us' folder for project 'Accept - Russian Roulette'
And I uploaded '/files/filetext.txt' file into '/Deliver Us' folder for 'Accept - Russian Roulette' project
And I created users with following fields:
| Email   | Role        |
| Dominic | agency.user |
And waited while transcoding is finished in folder '/Deliver Us' on project 'Accept - Russian Roulette' files page
And I added users 'Dominic' to project 'Accept - Russian Roulette' team folders '/Deliver Us' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Dominic'
When I go to project list page
Then I should see 'Accept - Russian Roulette' project in project list
When I go to project 'Accept - Russian Roulette' folder '/Deliver Us' page
Then I 'should' see folder name 'Deliver Us' on files page


Scenario: Check that 'Edit,View,Delete' settings of Project and its Template,Template Team permissions of Project.Observer role correctly work on shared folder
Meta:@gdam
      @projects
Given I created '2 Unlimited. 1993 No Limits! PC016' project
And created '/Throw the groove down' folder for project '2 Unlimited. 1993 No Limits! PC016'
And I uploaded '/files/filetext.txt' file into '/Throw the groove down' folder for '2 Unlimited. 1993 No Limits! PC016' project
And I created users with following fields:
| Email  | Role        |
| Amelia | agency.user |
And waited while transcoding is finished in folder '/Throw the groove down' on project '2 Unlimited. 1993 No Limits! PC016' files page
And I added users 'Amelia' to project '2 Unlimited. 1993 No Limits! PC016' team folders '/Throw the groove down' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Amelia'
When I go to project '2 Unlimited. 1993 No Limits! PC016' folder '/Throw the groove down' page
Then I should see tabs for project '2 Unlimited. 1993 No Limits! PC016' folder '/Throw the groove down' according to:
| Name     | ShouldState |
| Overview | should not  |
| Team     | should not  |


Scenario: Check that 'View Activity' permissions of Project.Observer role correct work on shared folder
Meta:@gdam
      @projects
Given I created '2 Unlimited. 1993 No Limits! PC017' project
And created '/Throw the groove down' folder for project '2 Unlimited. 1993 No Limits! PC017'
And I uploaded '/files/filetext.txt' file into '/Throw the groove down' folder for '2 Unlimited. 1993 No Limits! PC017' project
And I created users with following fields:
| Email   | Role        |
| Melanie | agency.user |
And waited while transcoding is finished in folder '/Throw the groove down' on project '2 Unlimited. 1993 No Limits! PC017' files page
And I added users 'Melanie' to project '2 Unlimited. 1993 No Limits! PC017' team folders '/Throw the groove down' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Melanie'
When I go to project list page
Then I 'should' see that last activity for project '2 Unlimited. 1993 No Limits! PC017' is ''


Scenario: Check that 'Share Folder' permission of Project.Contributor role correct work on shared folder
Meta:@gdam
      @projects
Given I created '2 Unlimited. 1994 Real Things.' project
And created '/Burning like fire' folder for project '2 Unlimited. 1994 Real Things.'
And I created users with following fields:
| Email  | Role        |
| Xavier | agency.user |
And I added users 'Xavier' to project '2 Unlimited. 1994 Real Things.' team folders '/Burning like fire' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Xavier'
When I go to project '2 Unlimited. 1994 Real Things.' folder '/Burning like fire' page
Then I 'should' see share button on project '2 Unlimited. 1994 Real Things.' folder '/Burning like fire' page
And I should see drop down menu items for project '2 Unlimited. 1994 Real Things.' folder '/Burning like fire' according to:
| Name  | ShouldState |
| Share | should      |


Scenario: Check that 'Delete Comment' permission of Project.observer role correct work on shared folder in case of delete existed comment
Meta:@gdam
      @projects
Given I created 'The Big Bang theory. Season 1. Comment by project.observer' project
And created '/The Big Bran Hypothesis' folder for project 'The Big Bang theory. Season 1. Comment by project.observer'
And I uploaded '/files/filetext.txt' file into '/The Big Bran Hypothesis' folder for 'The Big Bang theory. Season 1. Comment by project.observer' project
And waited while transcoding is finished in folder '/The Big Bran Hypothesis' on project 'The Big Bang theory. Season 1. Comment by project.observer' files page
And I am on the file comments page project 'The Big Bang theory. Season 1. Comment by project.observer' and folder '/The Big Bran Hypothesis' and file 'filetext.txt'
And I added comment 'Funny episode.' into current file
And I created users with following fields:
| Email | Role        |
| Amber | agency.user |
And I added users 'Amber' to project 'The Big Bang theory. Season 1. Comment by project.observer' team folders '/The Big Bran Hypothesis' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Amber'
When I go to the file comments page project 'The Big Bang theory. Season 1. Comment by project.observer' and folder '/The Big Bran Hypothesis' and file 'filetext.txt'
Then I 'should' see remove link for file comment 'Funny episode.' for file 'filetext.txt' in project 'The Big Bang theory. Season 1. Comment by project.observer' and folder '/The Big Bran Hypothesis'
When I remove comment 'Funny episode.' for file 'filetext.txt' in project 'The Big Bang theory. Season 1. Comment by project.observer' and folder '/The Big Bran Hypothesis' from 'AgencyAdmin' user
Then There are not any comments on the comments page for current file
When I add comment 'Comment for remove' into current file
Then I should see following comments for current file:
| Name               |
| Comment for remove |
When I remove comment 'Comment for remove' for file 'filetext.txt' in project 'The Big Bang theory. Season 1. Comment by project.observer' and folder '/The Big Bran Hypothesis' from 'AgencyAdmin' user
Then There are not any comments on the comments page for current file


Scenario: Check that 'Edit Folder & Files' permission of Project.Observer role correct work on shared folder
Meta:@gdam
      @projects
Given I created 'The Big Bang theory. Season 1. Edit folder does not work for project.observer' project
And created '/The Fuzzy Boots Corollary' folder for project 'The Big Bang theory. Season 1. Edit folder does not work for project.observer'
And I created users with following fields:
| Email  | Role        |
| Hayden | agency.user |
And I added users 'Hayden' to project 'The Big Bang theory. Season 1. Edit folder does not work for project.observer' team folders '/The Fuzzy Boots Corollary' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Hayden'
When I go to project 'The Big Bang theory. Season 1. Edit folder does not work for project.observer' folder '/The Fuzzy Boots Corollary' page
Then I should see drop down menu items for project 'The Big Bang theory. Season 1. Edit folder does not work for project.observer' folder '/The Fuzzy Boots Corollary' according to:
| Name | ShouldState |
| Edit | should not  |


Scenario: Check that 'Delete Folder & Files' permission of Project.Observer role correct work on shared folder
Meta:@gdam
      @projects
Given I created 'The Big Bang theory. Season 1. Delete folder does not work for project.observer' project
And created '/The Fuzzy Boots Corollary' folder for project 'The Big Bang theory. Season 1. Delete folder does not work for project.observer'
And I uploaded '/files/filetext.txt' file into '/The Fuzzy Boots Corollary' folder for 'The Big Bang theory. Season 1. Delete folder does not work for project.observer' project
And I created users with following fields:
| Email  | Role        |
| Isabel | agency.user |
And I added users 'Isabel' to project 'The Big Bang theory. Season 1. Delete folder does not work for project.observer' team folders '/The Fuzzy Boots Corollary' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Isabel'
When I go to project 'The Big Bang theory. Season 1. Delete folder does not work for project.observer' folder '/The Fuzzy Boots Corollary' page
Then I should see drop down menu items for project 'The Big Bang theory. Season 1. Delete folder does not work for project.observer' folder '/The Fuzzy Boots Corollary' according to:
| Name   | ShouldState |
| Remove | should not  |


Scenario: Check that projects are correctly shared for user with 'project.observer' role
Meta:@gdam
      @projects
Given I created following projects:
| Name                                                 |
| Stereo. Nightwish. Over The Hills And Far Away       |
| Stereo. 2 Unlimited. No limits!                      |
| Stereo. Army of lovers. The Gods Of Earth And Heaven |
And created in 'Stereo. Nightwish. Over The Hills And Far Away' project next folders:
| folder         |
| /10th Man Down |
| /Away          |
And created in 'Stereo. 2 Unlimited. No limits!' project next folders:
| folder      |
| /Mysterious |
And created in 'Stereo. Army of lovers. The Gods Of Earth And Heaven' project next folders:
| folder     |
| /Sebastien |
And I created users with following fields:
| Email   | Role        |
| Arianna | agency.user |
And I added users 'Arianna' to project 'Stereo. Nightwish. Over The Hills And Far Away' team folders '/10th Man Down' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Arianna'
When I go to project list page
Then I should see 'Stereo. Nightwish. Over The Hills And Far Away' project in project list
And I shouldn't see 'Stereo. 2 Unlimited. No limits!' project in project list
And I shouldn't see 'Stereo. Army of lovers. The Gods Of Earth And Heaven' project in project list
When I search by text 'Stereo'
Then I 'should' see search object 'Stereo. Nightwish. Over The Hills And Far Away' with type 'Project' after wrap according to search 'Stereo' with 'Name' type
And I 'should not' see search object 'Stereo. 2 Unlimited. No limits!' with type 'Project' after wrap according to search 'Stereo' with 'Name' type
And I 'should not' see search object 'Stereo. Army of lovers. The Gods Of Earth And Heaven' with type 'Project' after wrap according to search 'Stereo' with 'Name' type


Scenario: Check that folders are correctly shared for user with 'Project.Observer' role
Meta:@gdam
      @projects
Given I created following projects:
| Name                         |
| Pet Shop Boys. Unknown PO030 |
| Queen. Innuendo PO030        |
| Bangles. Unknown PO030       |
And created in 'Pet Shop Boys. Unknown PO030' project next folders:
| folder                |
| /SeasHit. Go West     |
| /SeasHit. It is A Sin |
And created in 'Queen. Innuendo PO030' project next folders:
| folder            |
| /SeasHit. Headlong|
And created in 'Bangles. Unknown PO030' project next folders:
| folder                  |
| /SeasHit. Eternal Flame |
And I created users with following fields:
| Email  | Role        |
| Landon | agency.user |
And I added users 'Landon' to project 'Pet Shop Boys. Unknown PO030' team folders '/SeasHit. Go West' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Landon'
When I go to project 'Pet Shop Boys. Unknown PO030' folder '/SeasHit. Go West' page
Then I 'should' see '/SeasHit. Go West' folder in 'Pet Shop Boys. Unknown PO030' project
And I 'should not' see '/SeasHit. It is A Sin' folder in 'Pet Shop Boys. Unknown PO030' project
When I search by text 'SeasHit'
Then I 'should' see search object 'SeasHit. Go West' with type 'Folder' after wrap according to search 'SeasHit' with 'Name' type
And I 'should not' see search object 'SeasHit. It is A Sin' with type 'Folder' after wrap according to search 'SeasHit' with 'Name' type
And I 'should not' see search object 'SeasHit. Headlong' with type 'Folder' after wrap according to search 'SeasHit' with 'Name' type
And I 'should not' see search object 'SeasHit. Eternal Flame' with type 'Folder' after wrap according to search 'SeasHit' with 'Name' type


Scenario: Check that files are correctly shared for user with 'Project.Observer' role
Meta:@gdam
      @projects
Given I created following projects:
| Name              |
| Championship 2010 |
| Championship 2011 |
| Championship 2012 |
And created in 'Championship 2010' project next folders:
| folder            |
| /Concrete Jungle  |
| /Chariots of fire |
And created in 'Championship 2011' project next folders:
| folder                    |
| /Sixteen tons of hardware |
And created in 'Championship 2012' project next folders:
| folder     |
| /Open door |
And I created users with following fields:
| Email | Role        |
| Maya  | agency.user |
And uploaded '/files/searchfile1_1' file into '/Concrete Jungle' folder for 'Championship 2010' project
And uploaded '/files/searchfile1_2' file into '/Concrete Jungle' folder for 'Championship 2010' project
And uploaded '/files/searchfile1_1' file into '/Chariots of fire' folder for 'Championship 2010' project
And uploaded '/files/searchfile1_2' file into '/Sixteen tons of hardware' folder for 'Championship 2011' project
And uploaded '/files/searchfile1_3' file into '/Open door' folder for 'Championship 2012' project
And I added users 'Maya' to project 'Championship 2010' team folders '/Concrete Jungle' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Maya'
When I go to project 'Championship 2010' folder '/Concrete Jungle' page
Then I 'should' see file 'searchfile1_1' on project files page and files count are '1'
And I 'should' see file 'searchfile1_2' on project files page and files count are '1'
When I search by text 'searchfile1'
And I click show all link for global user search for object 'Files & Folders'
Then I should see following folders and files for user 'AgencyAdmin' project 'Championship 2010' after search on the page:
| FolderName        | FileName      | ShouldState |
| /Concrete Jungle  | searchfile1_1 | should      |
| /Concrete Jungle  | searchfile1_2 | should      |
| /Chariots of fire | searchfile1_1 | should not  |
And I should see following folders and files for user 'AgencyAdmin' project 'Championship 2011' after search on the page:
| FolderName                 | FileName      | ShouldState |
| /Sixteen tons of hardware  | searchfile1_2 | should not  |
And I should see following folders and files for user 'AgencyAdmin' project 'Championship 2012' after search on the page:
| FolderName | FileName      | ShouldState |
| /Open door | searchfile1_3 | should not  |


Scenario: Check that user see 'You doesn't have permissions to view this page' message if he tries to go to unshared project to him using direct url
Meta:@gdam
      @projects
Given I created following projects:
| Name                               |
| Scorpions. Unsorted Version 1 PO26 |
| Scorpions. Unsorted Version 2 PO26 |
And created in 'Scorpions. Unsorted Version 1 PO26' project next folders:
| folder   |
| /Holiday |
And created in 'Scorpions. Unsorted Version 2 PO26' project next folders:
| folder         |
| /Lonely Nights |
And I created users with following fields:
| Email | Role        |
| Cody  | agency.user |
And I added users 'Cody' to project 'Scorpions. Unsorted Version 1 PO26' team folders '/Holiday' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Cody'
When I go to project 'Scorpions. Unsorted Version 2 PO26' page were link was formed according to agency admin
Then I 'should not' see project overview page


Scenario: Check that user see 'You doesn't have permissions to view this page' message if he tries to go to unshared folder to him using direct url
Meta:@gdam
     @projects
Given I created following projects:
| Name                       |
| About lizards. Manual PO27 |
| WOW or LineAge? PO27       |
And created in 'About lizards. Manual PO27' project next folders:
| folder         |
| /Light version |
| /Hard version  |
And created in 'WOW or LineAge? PO27' project next folders:
| folder         |
| /Light version |
And I created users with following fields:
| Email   | Role        |
| Jocelyn | agency.user |
And I added users 'Jocelyn' to project 'About lizards. Manual PO27' team folders '/Light version' with role 'project.observer' expired '12.12.2031'
And I logged in with details of 'Jocelyn'
When I go to project 'About lizards. Manual PO27' folder '/Hard version' page of user 'AgencyAdmin'
Then I should see following folders in 'About lizards. Manual PO27' project:
| folder         | should     |
| /Light version | should     |
| /Hard version  | should not |