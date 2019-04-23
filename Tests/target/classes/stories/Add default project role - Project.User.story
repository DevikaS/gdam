!--NGN-1311
Feature:          Add default project role - Project.User
Narrative:
In order to
As a              AgencyAdmin
I want to         Check default project role: Project.User

Scenario: Check that default Project.User role is available by default
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
And I am on global roles page
Then I 'should' see 'project.user' role on in the roles list


Scenario: Check that Project.User role has correctly specified permissions
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
And I am on global roles page
When I open role 'project.user' page with parent 'DefaultAgency'
Then I should see role 'project.user' that 'should' contains following selected permissions 'folder.read,element.read,folder.create,element.create,project.read,project_template.read,file.download,comment.read,comment.create'
And I should see role 'project.user' that 'should not' contains following selected permissions 'folder.write,element.write,folder.delete,element.delete,comment.delete,activity.read,folder.share,project.write,project.settings.read,project_team.delete,project_team.write,project_team.read,project_template.write'

Scenario: Check that Project.User role is pre-populated on Share Folder
Meta:@gdam
      @projects
Given I created 'Helloween. The Dark Ride 2000. Sc4. P1' project
And created '/Beyond The Portal' folder for project 'Helloween. The Dark Ride 2000. Sc4. P1'
When I open Share window from popup menu for folder '/Beyond The Portal' on project 'Helloween. The Dark Ride 2000. Sc4. P1'
Then I 'should' see role 'Project User' in the role dropdown on Share popup

Scenario: Check that Project.User role is pre-populated on Add User pop-up on Team tab
Meta:@gdam
     @projects
Given I created 'P. check that project.user role is pre-populated. Step2. Team tab' project
And created '/simple folder.' folder for project 'P. check that project.user role is pre-populated. Step2. Team tab'
And I am on project 'P. check that project.user role is pre-populated. Step2. Team tab' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And I click element 'AddMemberUserItem' on page 'TeamsPage'
Then I 'should' see role 'Project User' in roles list of add user to project 'P. check that project.user role is pre-populated. Step2. Team tab' team popup

Scenario: Check that 'create comment' permission of Project.User role correct work in shared folder
Meta:@gdam
     @projects
Given I created 'Terminator. Another version. Commented by project.user' project
And created '/Give me the gun' folder for project 'Terminator. Another version. Commented by project.user'
And I uploaded '/files/filetext.txt' file into '/Give me the gun' folder for 'Terminator. Another version. Commented by project.user' project
And waited while transcoding is finished in folder '/Give me the gun' on project 'Terminator. Another version. Commented by project.user' files page
And I created users with following fields:
| Email    | Role        |
| Guru_S27 | agency.user |
And I added users 'Guru_S27' to project 'Terminator. Another version. Commented by project.user' team folders '/Give me the gun' with role 'project.user' expired '12.12.2031'
And I logged in with details of 'Guru_S27'
When I go to the file comments page project 'Terminator. Another version. Commented by project.user' and folder '/Give me the gun' and file 'filetext.txt'
Then I 'should' see comment textarea on current file comment page
When I add comment 'It was better early than now. ((' into current file
Then I 'should' see comment 'It was better early than now. ((' for current file


Scenario: Check that 'view comment' permission of Project.User role correct work on shared folder
Meta:@gdam
     @projects
Given I created 'Helloween. Mr. Torture. Fine song. View comments from project.user' project
And created '/Welcome! First couplet' folder for project 'Helloween. Mr. Torture. Fine song. View comments from project.user'
And I uploaded '/files/filetext.txt' file into '/Welcome! First couplet' folder for 'Helloween. Mr. Torture. Fine song. View comments from project.user' project
And I created users with following fields:
| Email      | Role        |
| Singer_S13 | agency.user |
And waited while transcoding is finished in folder '/Welcome! First couplet' on project 'Helloween. Mr. Torture. Fine song. View comments from project.user' files page
And I am on the file comments page project 'Helloween. Mr. Torture. Fine song. View comments from project.user' and folder '/Welcome! First couplet' and file 'filetext.txt'
And I added comment 'Funny song. Not bad' into current file
And I added users 'Singer_S13' to project 'Helloween. Mr. Torture. Fine song. View comments from project.user' team folders '/Welcome! First couplet' with role 'project.user' expired '12.12.2031'
And I logged in with details of 'Singer_S13'
When I go to the file comments page project 'Helloween. Mr. Torture. Fine song. View comments from project.user' and folder '/Welcome! First couplet' and file 'filetext.txt'
Then I should see following comments for current file:
| Name                | UserType    |
| Funny song. Not bad | AgencyAdmin |



Scenario: Check that 'download file' permission of Project.User role correct work on file details in shared folder
Meta:@gdam
Given I created 'Nightwish. Tarja Soile Susanna Turunen Cabuli. Female Vocalist. Project.user was interested' project
And created '/Angels fall first' folder for project 'Nightwish. Tarja Soile Susanna Turunen Cabuli. Female Vocalist. Project.user was interested'
And I uploaded '/files/filetext.txt' file into '/Angels fall first' folder for 'Nightwish. Tarja Soile Susanna Turunen Cabuli. Female Vocalist. Project.user was interested' project
And I created users with following fields:
| Email        | Role        |
| ostrich_Semu | agency.user |
And waited while transcoding is finished in folder '/Angels fall first' on project 'Nightwish. Tarja Soile Susanna Turunen Cabuli. Female Vocalist. Project.user was interested' files page
And I added users 'ostrich_Semu' to project 'Nightwish. Tarja Soile Susanna Turunen Cabuli. Female Vocalist. Project.user was interested' team folders '/Angels fall first' with role 'project.user' expired '12.12.2031'
And I logged in with details of 'ostrich_Semu'
When I go to file 'filetext.txt' info page in folder '/Angels fall first' project 'Nightwish. Tarja Soile Susanna Turunen Cabuli. Female Vocalist. Project.user was interested'
Then I 'should' see element 'DownloadOriginal' on page 'FileInfoPage'
And I 'should' see element 'DownloadMasterUsingSendplus' on page 'FileInfoPage'


Scenario: Check that 'download file' permission of Project.User role correct work in shared folder
Meta:@gdam
Given I created 'Nightwish. Angels fall first. Scenario - project.user role' project
And created '/Elvenpath' folder for project 'Nightwish. Angels fall first. Scenario - project.user role'
And I uploaded '/files/Fish1-Ad.wmv' file into '/Elvenpath' folder for 'Nightwish. Angels fall first. Scenario - project.user role' project
And I created users with following fields:
| Email    | Role        |
| TT_spu_1 | agency.user |
And waited while transcoding is finished in folder '/Elvenpath' on project 'Nightwish. Angels fall first. Scenario - project.user role' files page
And I added users 'TT_spu_1' to project 'Nightwish. Angels fall first. Scenario - project.user role' team folders '/Elvenpath' with role 'project.user' expired '12.12.2031'
And I logged in with details of 'TT_spu_1'
And I am on project 'Nightwish. Angels fall first. Scenario - project.user role' folder '/Elvenpath' page
And I selected file 'Fish1-Ad.wmv' on project files page
When I click Download button on project files page
Then I 'should' see checkbox 'master' is visible on opened pop-up of download File


Scenario: Check that 'create folder & files' permission of Project.User role correct work in shared folder
Meta:@gdam
Given I created 'Two beer or not two beer?. And a bit about create folder permission. Step X. project.user' project
And created '/What is up? High level' folder for project 'Two beer or not two beer?. And a bit about create folder permission. Step X. project.user'
And I created users with following fields:
| Email       | Role        |
| VIPorRIP_S1 | agency.user |
And I added users 'VIPorRIP_S1' to project 'Two beer or not two beer?. And a bit about create folder permission. Step X. project.user' team folders '/What is up? High level' with role 'project.user' expired '12.12.2031'
And I logged in with details of 'VIPorRIP_S1'
When I go to project 'Two beer or not two beer?. And a bit about create folder permission. Step X. project.user' folder '/What is up? High level' page
Then I 'should' see new folder button on project 'Two beer or not two beer?. And a bit about create folder permission. Step X. project.user' folder '/What is up? High level' page
When I create sub folder 'Nothing. Low level!' in folder '/What is up? High level' in project 'Two beer or not two beer?. And a bit about create folder permission. Step X. project.user' using button NewFolder
Then I 'should' see '/What is up? High level/Nothing. Low level!' folder in 'Two beer or not two beer?. And a bit about create folder permission. Step X. project.user' project
When I create '/What is up? High level/Who knows? Second level' folder in 'Two beer or not two beer?. And a bit about create folder permission. Step X. project.user' project
Then I 'should' see '/What is up? High level/Who knows? Second level' folder in 'Two beer or not two beer?. And a bit about create folder permission. Step X. project.user' project


Scenario: Check that 'View Activity', 'Edit Projects Settings', 'View Settings Project', 'View Project & Template Team', 'Delete Project & Template Team', 'Edit Project & Template Team', 'Delete Project' permissions of Project.User role correct work on shared folder
Meta:@gdam
Given I created 'ABBA. Money. Without any activity from project.user' project
And created '/Happy new year' folder for project 'ABBA. Money. Without any activity from project.user'
And I uploaded '/files/filetext.txt' file into '/Happy new year' folder for 'ABBA. Money. Without any activity from project.user' project
And I created users with following fields:
| Email     | Role        |
| BatMan_S1 | agency.user |
And waited while transcoding is finished in folder '/Happy new year' on project 'ABBA. Money. Without any activity from project.user' files page
And I added users 'BatMan_S1' to project 'ABBA. Money. Without any activity from project.user' team folders '/Happy new year' with role 'project.user' expired '12.12.2031'
And I logged in with details of 'BatMan_S1'
When I go to project list page
Then I 'should' see that last activity for project 'ABBA. Money. Without any activity from project.user' is ''
When I go to project 'ABBA. Money. Without any activity from project.user' folder '/Happy new year' page
Then I should see tabs for project 'ABBA. Money. Without any activity from project.user' folder '/Happy new year' according to:
| Name     | ShouldState |
| Overview | should not  |
| Team     | should not  |


Scenario: Check that 'Share Folder' permission of Project.User role correct work on shared folder
Meta:@gdam
Given I created 'The Big Bang theory. Season 1. project.user' project
And created '/Pilot' folder for project 'The Big Bang theory. Season 1. project.user'
And I created users with following fields:
| Email     | Role        |
| LightNerd | agency.user |
And I added users 'LightNerd' to project 'The Big Bang theory. Season 1. project.user' team folders '/Pilot' with role 'project.user' expired '12.12.2031'
And I logged in with details of 'LightNerd'
When I go to project 'The Big Bang theory. Season 1. project.user' folder '/Pilot' page
Then I 'should not' see enabled share button on project 'The Big Bang theory. Season 1. project.user' folder '/Pilot' page
And I should see drop down menu items for project 'The Big Bang theory. Season 1. project.user' folder '/Pilot' according to:
| Name  | ShouldState |
| Share | should not  |


Scenario: Check that 'Delete Comment' permission of Project.User role correct work on shared folder
Meta:@gdam
Given I created 'The Big Bang theory. Season 1. Comment by project.user' project
And created '/The Big Bran Hypothesis' folder for project 'The Big Bang theory. Season 1. Comment by project.user'
And I uploaded '/files/filetext.txt' file into '/The Big Bran Hypothesis' folder for 'The Big Bang theory. Season 1. Comment by project.user' project
And I am on the file comments page project 'The Big Bang theory. Season 1. Comment by project.user' and folder '/The Big Bran Hypothesis' and file 'filetext.txt'
And I added comment 'Funny episode.' into current file
And I created users with following fields:
| Email    | Role        |
| HardNerd | agency.user |
And I added users 'HardNerd' to project 'The Big Bang theory. Season 1. Comment by project.user' team folders '/The Big Bran Hypothesis' with role 'project.user' expired '12.12.2031'
And I logged in with details of 'HardNerd'
When I go to the file comments page project 'The Big Bang theory. Season 1. Comment by project.user' and folder '/The Big Bran Hypothesis' and file 'filetext.txt'
Then I 'should not' see remove link for file comment 'Funny episode.' for file 'filetext.txt' in project 'The Big Bang theory. Season 1. Comment by project.user' and folder '/The Big Bran Hypothesis'
When I add comment 'Without remorse' into current file
Then I 'should not' see remove link for file comment 'Without remorse' for file 'filetext.txt' in project 'The Big Bang theory. Season 1. Comment by project.user' and folder '/The Big Bran Hypothesis'


Scenario: Check that 'Edit Folder & Files' permission of Project.User role correct work on shared folder
Meta:@gdam
Given I created 'The Big Bang theory. Season 1. Edit folder does not work for project.user' project
And created '/The Fuzzy Boots Corollary' folder for project 'The Big Bang theory. Season 1. Edit folder does not work for project.user'
And I created users with following fields:
| Email     | Role        |
| StoneCity | agency.user |
And I added users 'StoneCity' to project 'The Big Bang theory. Season 1. Edit folder does not work for project.user' team folders '/The Fuzzy Boots Corollary' with role 'project.user' expired '12.12.2031'
And I logged in with details of 'StoneCity'
When I go to project 'The Big Bang theory. Season 1. Edit folder does not work for project.user' folder '/The Fuzzy Boots Corollary' page
Then I should see drop down menu items for project 'The Big Bang theory. Season 1. Edit folder does not work for project.user' folder '/The Fuzzy Boots Corollary' according to:
| Name | ShouldState |
| Edit | should not  |


Scenario: Check that 'Delete Folder & Files' permission of Project.User role correct work on shared folder
Meta:@gdam
Given I created 'The Big Bang theory. Season 1. Delete folder does not work for project.user' project
And created '/The Fuzzy Boots Corollary' folder for project 'The Big Bang theory. Season 1. Delete folder does not work for project.user'
And I uploaded '/files/filetext.txt' file into '/The Fuzzy Boots Corollary' folder for 'The Big Bang theory. Season 1. Delete folder does not work for project.user' project
And I created users with following fields:
| Email       | Role        |
| BoneChamber | agency.user |
And I added users 'BoneChamber' to project 'The Big Bang theory. Season 1. Delete folder does not work for project.user' team folders '/The Fuzzy Boots Corollary' with role 'project.user' expired '12.12.2031'
And I logged in with details of 'BoneChamber'
When I go to project 'The Big Bang theory. Season 1. Delete folder does not work for project.user' folder '/The Fuzzy Boots Corollary' page
Then I should see drop down menu items for project 'The Big Bang theory. Season 1. Delete folder does not work for project.user' folder '/The Fuzzy Boots Corollary' according to:
| Name   | ShouldState |
| Remove | should not  |


Scenario: Check that projects are correctly shared for user with 'Project.user' role
Meta:@gdam
Given I created following projects:
| Name                                                   |
| Solo. Nightwish. Over The Hills And Far Away P.U       |
| Solo. 2 Unlimited. No limits! P.U                      |
| Solo. Army of lovers. The Gods Of Earth And Heaven P.U |
And created in 'Solo. Nightwish. Over The Hills And Far Away P.U' project next folders:
| folder         |
| /10th Man Down |
| /Away          |
And created in 'Solo. 2 Unlimited. No limits! P.U' project next folders:
| folder      |
| /Mysterious |
And created in 'Solo. Army of lovers. The Gods Of Earth And Heaven P.U' project next folders:
| folder     |
| /Sebastien |
And I created users with following fields:
| Email        | Role        |
| MultiSongers | agency.user |
And I added users 'MultiSongers' to project 'Solo. Nightwish. Over The Hills And Far Away P.U' team folders '/10th Man Down' with role 'project.user' expired '12.12.2031'
And I logged in with details of 'MultiSongers'
When I go to project list page
Then I should see 'Solo. Nightwish. Over The Hills And Far Away P.U' project in project list
And I shouldn't see 'Solo. 2 Unlimited. No limits! P.U' project in project list
And I shouldn't see 'Solo. Army of lovers. The Gods Of Earth And Heaven P.U' project in project list
When I search by text 'Solo'
Then I 'should' see search object 'Solo. Nightwish. Over The Hills And Far Away P.U' with type 'Project' after wrap according to search 'Solo' with 'Name' type
And I 'should not' see search object 'Solo. 2 Unlimited. No limits! P.U' with type 'Project' after wrap according to search 'Solo' with 'Name' type
And I 'should not' see search object 'Solo. Army of lovers. The Gods Of Earth And Heaven P.U' with type 'Project' after wrap according to search 'Solo' with 'Name' type


Scenario: Check that folders are correctly shared for user with 'Project.user' role
Meta:@gdam
Given I created following projects:
| Name                       |
| Pet Shop Boys. Unknown P.U |
| Queen. Innuendo P.U        |
| Bangles. Unknown P.U       |
And created in 'Pet Shop Boys. Unknown P.U' project next folders:
| folder                |
| /Pestnja. Go West     |
| /Pestnja. It is A Sin |
And created in 'Queen. Innuendo P.U' project next folders:
| folder             |
| /Pestnja. Headlong |
And created in 'Bangles. Unknown P.U' project next folders:
| folder                  |
| /Pestnja. Eternal Flame |
And I created users with following fields:
| Email     | Role        |
| SemantikS | agency.user |
And I added users 'SemantikS' to project 'Pet Shop Boys. Unknown P.U' team folders '/Pestnja. Go West' with role 'project.user' expired '12.12.2031'
And I logged in with details of 'SemantikS'
When I go to project 'Pet Shop Boys. Unknown P.U' folder '/Pestnja. Go West' page
Then I 'should' see '/Pestnja. Go West' folder in 'Pet Shop Boys. Unknown P.U' project
And I 'should not' see '/Pestnja. It is A Sin' folder in 'Pet Shop Boys. Unknown P.U' project
When I search by text 'Pestnja'
Then I 'should' see search object 'Pestnja. Go West' with type 'Folder' after wrap according to search 'Pestnja' with 'Name' type
And I 'should not' see search object 'Pestnja. It is A Sin' with type 'Folder' after wrap according to search 'Pestnja' with 'Name' type
And I 'should not' see search object 'Pestnja. Headlong' with type 'Folder' after wrap according to search 'Pestnja' with 'Name' type
And I 'should not' see search object 'Pestnja. Eternal Flame' with type 'Folder' after wrap according to search 'Pestnja' with 'Name' type


Scenario: Check that files are correctly shared for user with 'Project.user' role
Meta:@gdam
Given I created following projects:
| Name                                                                  |
| BWO - Fabricator 2007 P.U                                             |
| BWO - Halcyon Days 2006 P.U                                           |
| BWO - Halcyon Nights (the Remixes of the Album Halcyon Days) 2006 P.U |
And created in 'BWO - Fabricator 2007 P.U' project next folders:
| folder            |
| /Concrete Jungle  |
| /Chariots of fire |
And created in 'BWO - Halcyon Days 2006 P.U' project next folders:
| folder                    |
| /Sixteen tons of hardware |
And created in 'BWO - Halcyon Nights (the Remixes of the Album Halcyon Days) 2006 P.U' project next folders:
| folder     |
| /Open door |
And I created users with following fields:
| Email    | Role        |
| Trio_SSS | agency.user |
And uploaded '/files/searchfile1_1' file into '/Concrete Jungle' folder for 'BWO - Fabricator 2007 P.U' project
And uploaded '/files/searchfile1_2' file into '/Concrete Jungle' folder for 'BWO - Fabricator 2007 P.U' project
And uploaded '/files/searchfile1_1' file into '/Chariots of fire' folder for 'BWO - Fabricator 2007 P.U' project
And uploaded '/files/searchfile1_2' file into '/Sixteen tons of hardware' folder for 'BWO - Halcyon Days 2006 P.U' project
And uploaded '/files/searchfile1_3' file into '/Open door' folder for 'BWO - Halcyon Nights (the Remixes of the Album Halcyon Days) 2006 P.U' project
And I added users 'Trio_SSS' to project 'BWO - Fabricator 2007 P.U' team folders '/Concrete Jungle' with role 'project.user' expired '12.12.2031'
And I logged in with details of 'Trio_SSS'
When I go to project 'BWO - Fabricator 2007 P.U' folder '/Concrete Jungle' page
Then I 'should' see file 'searchfile1_1' on project files page and files count are '1'
And I 'should' see file 'searchfile1_2' on project files page and files count are '1'
When I search by text 'searchfile1'
And I click show all link for global user search for object 'Files & Folders'
Then I should see following folders and files for user 'AgencyAdmin' project 'BWO - Fabricator 2007 P.U' after search on the page:
| FolderName        | FileName      | ShouldState |
| /Concrete Jungle  | searchfile1_1 | should      |
| /Concrete Jungle  | searchfile1_2 | should      |
| /Chariots of fire | searchfile1_1 | should not  |
And I should see following folders and files for user 'AgencyAdmin' project 'BWO - Halcyon Days 2006 P.U' after search on the page:
| FolderName                | FileName      | ShouldState |
| /Sixteen tons of hardware | searchfile1_2 | should not  |
And I should see following folders and files for user 'AgencyAdmin' project 'BWO - Halcyon Nights (the Remixes of the Album Halcyon Days) 2006 P.U' after search on the page:
| FolderName | FileName      | ShouldState |
| /Open door | searchfile1_3 | should not  |



Scenario: Check that user see 'You doesn't have permissions to view this page' message if he tries to go to unshared project to him using direct url
Meta:@gdam
Given I created following projects:
| Name                              |
| Scorpions. Unsorted Version 1 P.U |
| Scorpions. Unsorted Version 2 P.U |
And created in 'Scorpions. Unsorted Version 1 P.U' project next folders:
| folder   |
| /Holiday |
And created in 'Scorpions. Unsorted Version 2 P.U' project next folders:
| folder         |
| /Lonely Nights |
And I created users with following fields:
| Email      | Role        |Access|
| Zombie_V04 | agency.user |folders|
And I added users 'Zombie_V04' to project 'Scorpions. Unsorted Version 1 P.U' team folders '/Holiday' with role 'project.user' expired '12.12.2031'
And I logged in with details of 'Zombie_V04'
When I go to project 'Scorpions. Unsorted Version 2 P.U' page were link was formed according to agency admin
Then I 'should not' see project overview page
And I shouldn't see 'Scorpions. Unsorted Version 2 P.U' project in project list


Scenario: Check that user see 'You doesn't have permissions to view this page' message if he tries to go to unshared folder to him using direct url
Meta:@gdam
Given I created following projects:
| Name                      |
| About lizards. Manual P.U |
| WOW or LineAge? P.U       |
And created in 'About lizards. Manual P.U' project next folders:
| folder         |
| /Light version |
| /Hard version  |
And created in 'WOW or LineAge? P.U' project next folders:
| folder         |
| /Light version |
And I created users with following fields:
| Email       | Role        |
| Paladin_V09 | agency.user |
And I added users 'Paladin_V09' to project 'About lizards. Manual P.U' team folders '/Light version' with role 'project.user' expired '12.12.2031'
And I logged in with details of 'Paladin_V09'
When I go to project 'About lizards. Manual P.U' folder '/Hard version' page of user 'AgencyAdmin'
Then I should see following folders in 'About lizards. Manual P.U' project:
| folder         | should     |
| /Light version | should     |
| /Hard version  | should not |


Scenario: Check that user should not see teams page if he tries to go to Team tab of shared project using direct url
Meta:@gdam
Given I created 'The Big Bang Theory. Season 1. Chapter 1 P.U' project
And I created '/Pilot' folder for project 'The Big Bang Theory. Season 1. Chapter 1 P.U'
And I created users with following fields:
| Email   | Role        |
| Melissa | agency.user |
And I added users 'Melissa' to project 'The Big Bang Theory. Season 1. Chapter 1 P.U' team folders '/Pilot' with role 'project.user' expired '12.12.2031'
And I logged in with details of 'Melissa'
And I am on project 'The Big Bang Theory. Season 1. Chapter 1 P.U' teams page of user 'AgencyAdmin'
And refreshed the page
Then I 'should not' see element 'SortByCompany' on page 'TeamsPage'