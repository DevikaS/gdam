!-- NGN-3414
Feature:          Add default project role - Project.Contributor
Narrative:
In order to
As a              AgencyAdmin
I want to         Check default project role Project.Contributor

Scenario: Check that default Project.Contributor role is available by default
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
And I am on global roles page
And I search advertiser 'DefaultAgency' on global roles page
And I selected advertiser 'DefaultAgency' on global roles page
Then I 'should' see 'project.contributor' role on in the roles list


Scenario: Check that Project.Contributor role has correctly specified permissions
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
And I am on global roles page
When I open role 'project.user' page with parent 'DefaultAgency'
And refresh the page without delay
Then I should see role 'project.contributor' that 'should' contains following selected permissions 'activity.read,comment.create,comment.delete,comment.read,folder.share,folder.create,element.create,folder.delete,element.delete,folder.read,element.read,folder.write,element.write,project.write,project.read'
And I should see role 'project.contributor' that 'should not' contains following selected permissions 'file.download,project.settings.read,project_team.delete,project_team.write,project_team.read,project_template.write,project_template.read'


Scenario: Check that Project.Contributor role isn't editable on agency level
Meta: @skip
     @gdam
Given I am on Roles page
When I open role 'project.contributor' page
And I click role 'Project contributor' on roles list
Then I 'should' see that all permissions check boxes are disabled for role 'project.contributor'
And I should see role name text field is 'disabled' on role 'project.contributor' page


Scenario: Check that Project.Contributor role is pre-populated on Share Folder
Meta: @gdam
      @projects
Given I created '2 Unlimited. 1993,  No Limits! PC004' project
And created '/No limits' folder for project '2 Unlimited. 1993,  No Limits! PC004'
When I open Share window from popup menu for folder '/No limits' on project '2 Unlimited. 1993,  No Limits! PC004'
Then I 'should' see role 'Project Contributor' in the role dropdown on Share popup

Scenario: Check that Project.Contributor role is pre-populated on Add User pop-up on Team tab
Meta: @gdam
      @projects
Given I created '2 Unlimited. 1993,  No Limits! PC005' project
And created '/Tribal dance' folder for project '2 Unlimited. 1993,  No Limits! PC005'
And I am on project '2 Unlimited. 1993,  No Limits! PC005' teams page
When I click element 'AddMemberButton' on page 'TeamsPage'
And I click element 'AddMemberUserItem' on page 'TeamsPage'
Then I 'should' see role 'Project Contributor' in roles list of add user to project '2 Unlimited. 1993,  No Limits! PC005' team popup


Scenario: Check that 'comment.create' permission of Project.Contributor role correct work in shared folder
Meta: @gdam
      @projects
Given I created '2 Unlimited. 1993,  No Limits! PC007' project
And created '/Mysterious' folder for project '2 Unlimited. 1993,  No Limits! PC007'
And I uploaded '/files/_file1.gif' file into '/Mysterious' folder for '2 Unlimited. 1993,  No Limits! PC007' project
And waited while transcoding is finished in folder '/Mysterious' on project '2 Unlimited. 1993,  No Limits! PC007' files page
And I created users with following fields:
| Email    | Role        |
| Doth_007 | agency.user |
And I added users 'Doth_007' to project '2 Unlimited. 1993,  No Limits! PC007' team folders '/Mysterious' with role 'project.contributor' expired '12.12.2031'
And I logged in with details of 'Doth_007'
When I go to the file comments page project '2 Unlimited. 1993,  No Limits! PC007' and folder '/Mysterious' and file '_file1.gif'
Then I 'should' see comment textarea on current file comment page
When I add comment 'Without sense, but female is pretty' into current file
Then I 'should' see comment 'Without sense, but female is pretty' for current file


Scenario: Check that 'comment.read' permission of Project.Contributor role correct work on shared folder
Meta: @gdam
      @projects
Given I created '2 Unlimited. 1993,  No Limits! PC008' project
And created '/Faces' folder for project '2 Unlimited. 1993,  No Limits! PC008'
And I uploaded '/files/_file1.gif' file into '/Faces' folder for '2 Unlimited. 1993,  No Limits! PC008' project
And I created users with following fields:
| Email     |
| Ray_PC008 |
And waited while transcoding is finished in folder '/Faces' on project '2 Unlimited. 1993,  No Limits! PC008' files page
And I am on the file comments page project '2 Unlimited. 1993,  No Limits! PC008' and folder '/Faces' and file '_file1.gif'
And I added comment 'Funny song. Not bad' into current file
And I added users 'Ray_PC008' to project '2 Unlimited. 1993,  No Limits! PC008' team folders '/Faces' with role 'project.contributor' expired '12.12.2031'
And I logged in with details of 'Ray_PC008'
When I go to the file comments page project '2 Unlimited. 1993,  No Limits! PC008' and folder '/Faces' and file '_file1.gif'
Then I should see following comments for current file:
| Name                | UserType    |
| Funny song. Not bad | AgencyAdmin |


Scenario: Check that 'download file' permission of Project.Contributor role correct work on file details in shared folder
Meta: @gdam
      @projects
Given I created '2 Unlimited. 1993,  No Limits! PC009' project
And created '/Maximum overdrive' folder for project '2 Unlimited. 1993,  No Limits! PC009'
And I uploaded '/files/_file1.gif' file into '/Maximum overdrive' folder for '2 Unlimited. 1993,  No Limits! PC009' project
And I created users with following fields:
| Email          | Role        |
| Alejandro_PC09 | agency.user |
And waited while transcoding is finished in folder '/Maximum overdrive' on project '2 Unlimited. 1993,  No Limits! PC009' files page
And I added users 'Alejandro_PC09' to project '2 Unlimited. 1993,  No Limits! PC009' team folders '/Maximum overdrive' with role 'project.contributor' expired '12.12.2031'
And I logged in with details of 'Alejandro_PC09'
When I go to file '_file1.gif' info page in folder '/Maximum overdrive' project '2 Unlimited. 1993,  No Limits! PC009'
Then I 'should not' see element 'DownloadOriginal' on page 'FileInfoPage'
And I 'should not' see element 'DownloadMasterUsignnVerge' on page 'FileInfoPage'


Scenario: Check that 'download file' permission of Project.Contributor role correct work in shared folder
Meta: @gdam
      @projects
Given I created '2 Unlimited. 1993,  No Limits! PC010' project
And created '/Break The Chain' folder for project '2 Unlimited. 1993,  No Limits! PC010'
And I uploaded '/files/_file1.gif' file into '/Break The Chain' folder for '2 Unlimited. 1993,  No Limits! PC010' project
And I created users with following fields:
| Email       | Role        |
| Claire_PC10 | agency.user |
And waited while transcoding is finished in folder '/Break The Chain' on project '2 Unlimited. 1993,  No Limits! PC010' files page
And I added users 'Claire_PC10' to project '2 Unlimited. 1993,  No Limits! PC010' team folders '/Break The Chain' with role 'project.contributor' expired '12.12.2031'
And I logged in with details of 'Claire_PC10'
And I am on project '2 Unlimited. 1993,  No Limits! PC010' folder '/Break The Chain' page
And I selected file '_file1.gif' on project files page
When I click Download button on project files page
Then I 'should not' see checkbox 'master' is visible on opened pop-up of download File


Scenario: Check that 'folder.create,element.create' permission of Project.Contributor role correct work in shared folder
Meta: @gdam
      @projects
Given I created '2 Unlimited. 1993,  No Limits! PC011' project
And created '/Let the beat control your body' folder for project '2 Unlimited. 1993,  No Limits! PC011'
And I created users with following fields:
| Email     | Role        |
| Jake_PC11 | agency.user |
And I added users 'Jake_PC11' to project '2 Unlimited. 1993,  No Limits! PC011' team folders '/Let the beat control your body' with role 'project.contributor' expired '12.12.2031'
And I logged in with details of 'Jake_PC11'
When I go to project '2 Unlimited. 1993,  No Limits! PC011' folder '/Let the beat control your body' page
Then I 'should' see new folder button on project '2 Unlimited. 1993,  No Limits! PC011' folder '/Let the beat control your body' page
When I create sub folder 'Invite me to trance' in folder '/Let the beat control your body' in project '2 Unlimited. 1993,  No Limits! PC011' using button NewFolder
Then I 'should' see '/Let the beat control your body/Invite me to trance' folder in '2 Unlimited. 1993,  No Limits! PC011' project
When I create '/Let the beat control your body/Where are you now' folder in '2 Unlimited. 1993,  No Limits! PC011' project
Then I 'should' see '/Let the beat control your body/Where are you now' folder in '2 Unlimited. 1993,  No Limits! PC011' project


Scenario: Check that 'folder.create,element.create' permission of Project.Contributor role correct work in shared project
Meta: @gdam
      @projects
Given I created '2 Unlimited. 1993,  No Limits! PC012' project
And created '/Shelter for a rainy day' folder for project '2 Unlimited. 1993,  No Limits! PC012'
And I created users with following fields:
| Email      | Role        |
| Molly_PC12 | agency.user |
And I added users 'Molly_PC12' to project '2 Unlimited. 1993,  No Limits! PC012' team folders '/Shelter for a rainy day' with role 'project.contributor' expired '12.12.2031'
And I logged in with details of 'Molly_PC12'
When I go to project '2 Unlimited. 1993,  No Limits! PC012' overview page
When I create '/Kiss me bliss me' folder in '2 Unlimited. 1993,  No Limits! PC012' project
Then I 'should' see '/Kiss me bliss me' folder in '2 Unlimited. 1993,  No Limits! PC012' project


Scenario: Check that 'folder.read,element.read' permission of Project.Contributor role correct work on shared folder
Meta: @gdam
      @projects
Given I created '2 Unlimited. 1993, No Limits! PC013' project
And created '/The power age' folder for project '2 Unlimited. 1993, No Limits! PC013'
And I uploaded '/files/_file1.gif' file into '/The power age' folder for '2 Unlimited. 1993, No Limits! PC013' project
And I created users with following fields:
| Email       | Role        |
| Miguel_PC13 | agency.user |
And waited while transcoding is finished in folder '/The power age' on project '2 Unlimited. 1993, No Limits! PC013' files page
And I added users 'Miguel_PC13' to project '2 Unlimited. 1993, No Limits! PC013' team folders '/The power age' with role 'project.contributor' expired '12.12.2031'
And I logged in with details of 'Miguel_PC13'
Then I should see that email with field to 'Miguel_PC13' contains following message 'Folders have been shared with you'
When I go to project '2 Unlimited. 1993, No Limits! PC013' folder '/The power age' page
And I search by text 'file1'
Then I 'should' see search object '_file1.gif' with type 'Files & Folders' after wrap according to search 'file1' with 'Name' type
When I search by text 'The power'
Then I 'should' see search object 'The power age' with type 'Files & Folders' after wrap according to search 'The power age' with 'Name' type


Scenario: Check that 'view projects' permission of Project.Contributor role correct work on shared folder
Meta: @gdam
      @projects
Given I created '2 Unlimited. 1993 No Limits! PC014' project
And created '/Deliver Us' folder for project '2 Unlimited. 1993 No Limits! PC014'
And I uploaded '/files/_file1.gif' file into '/Deliver Us' folder for '2 Unlimited. 1993 No Limits! PC014' project
And I created users with following fields:
| Email       | Role        |
| BatMan_PC14 | agency.user |
And waited while transcoding is finished in folder '/Deliver Us' on project '2 Unlimited. 1993 No Limits! PC014' files page
And I added users 'BatMan_PC14' to project '2 Unlimited. 1993 No Limits! PC014' team folders '/Deliver Us' with role 'project.contributor' expired '12.12.2031'
And I logged in with details of 'BatMan_PC14'
Then I should see that email with field to 'BatMan_PC14' contains following message 'Folders have been shared with you'
When I go to project list page
Then I should see '2 Unlimited. 1993 No Limits! PC014' project in project list
When I go to project '2 Unlimited. 1993 No Limits! PC014' folder '/Deliver Us' page
Then I 'should' see folder name 'Deliver Us' on files page
When I search by text '2 Unlimited'
Then I 'should' see search object '2 Unlimited. 1993 No Limits! PC014' with type 'Project' after wrap according to search '2 Unlimited' with 'Name' type


Scenario: Check that 'activity.read', 'View Project & Template Team', 'Delete Project & Template Team', 'Edit Project & Template Team', 'Delete Project' permissions of Project.Contributor role correct work on shared folder
Meta: @gdam
      @projects
Given I created '2 Unlimited. 1993 No Limits! PC016' project
And created '/Throw the groove down' folder for project '2 Unlimited. 1993 No Limits! PC016'
And I uploaded '/files/_file1.gif' file into '/Throw the groove down' folder for '2 Unlimited. 1993 No Limits! PC016' project
And I created users with following fields:
| Email       | Role        |
| Amelia_PC16 | agency.user |
And waited while transcoding is finished in folder '/Throw the groove down' on project '2 Unlimited. 1993 No Limits! PC016' files page
And I added users 'Amelia_PC16' to project '2 Unlimited. 1993 No Limits! PC016' team folders '/Throw the groove down' with role 'project.contributor' expired '12.12.2031'
And I logged in with details of 'Amelia_PC16'
When I go to project list page
Then I 'should' see that last activity for project '2 Unlimited. 1993 No Limits! PC016' is ''
When I go to project '2 Unlimited. 1993 No Limits! PC016' folder '/Throw the groove down' page
Then I should see tabs for project '2 Unlimited. 1993 No Limits! PC016' folder '/Throw the groove down' according to:
| Name     | ShouldState |
| Overview | should not  |
| Team     | should not  |


Scenario: Check that 'folder.share' permission of Project.Contributor role correct work on shared folder
Meta: @gdam
      @projects
Given I created users with following fields:
| Email           | Role        |
| Sebastian_PC017 | agency.user |
And created '2 Unlimited. 1994 Real Things. PC017' project
And created '/Burning like fire' folder for project '2 Unlimited. 1994 Real Things. PC017'
And added users 'Sebastian_PC017' to project '2 Unlimited. 1994 Real Things. PC017' team folders '/Burning like fire' with role 'project.contributor' expired '12.12.2031'
And logged in with details of 'Sebastian_PC017'
When I go to project '2 Unlimited. 1994 Real Things. PC017' folder '/Burning like fire' page
Then I 'should' see share button on project '2 Unlimited. 1994 Real Things. PC017' folder '/Burning like fire' page
And should see drop down menu items for project '2 Unlimited. 1994 Real Things. PC017' folder '/Burning like fire' according to:
| Name  | ShouldState |
| Share | should      |


Scenario: Check that 'comment.delete' permission of Project.Contributor role correct work on shared folder
Meta: @gdam
      @projects
Given I created 'The Big Bang theory. Season 1. Comment by PC018' project
And created '/The Big Bran Hypothesis' folder for project 'The Big Bang theory. Season 1. Comment by PC018'
And I uploaded '/files/_file1.gif' file into '/The Big Bran Hypothesis' folder for 'The Big Bang theory. Season 1. Comment by PC018' project
And waited while transcoding is finished in folder '/The Big Bran Hypothesis' on project 'The Big Bang theory. Season 1. Comment by PC018' files page
And I am on the file comments page project 'The Big Bang theory. Season 1. Comment by PC018' and folder '/The Big Bran Hypothesis' and file '_file1.gif'
And I added comment 'Funny episode.' into current file
And created users with following fields:
| Email         | Role        |
| HighWay_PC018 | agency.user |
And I added users 'HighWay_PC018' to project 'The Big Bang theory. Season 1. Comment by PC018' team folders '/The Big Bran Hypothesis' with role 'project.contributor' expired '12.12.2031'
And I logged in with details of 'HighWay_PC018'
When I go to the file comments page project 'The Big Bang theory. Season 1. Comment by PC018' and folder '/The Big Bran Hypothesis' and file '_file1.gif'
Then I 'should' see remove link for file comment 'Funny episode.' for file '_file1.gif' in project 'The Big Bang theory. Season 1. Comment by PC018' and folder '/The Big Bran Hypothesis'
When I remove comment 'Funny episode.' for file '_file1.gif' in project 'The Big Bang theory. Season 1. Comment by PC018' and folder '/The Big Bran Hypothesis' from 'AgencyAdmin' user
Then There are not any comments on the comments page for current file
When I add comment 'Comment for remove' into current file
Then I should see following comments for current file:
| Name               |
| Comment for remove |
When I remove comment 'Comment for remove' for file '_file1.gif' in project 'The Big Bang theory. Season 1. Comment by PC018' and folder '/The Big Bran Hypothesis' from 'AgencyAdmin' user
Then There are not any comments on the comments page for current file


Scenario: Check that 'Edit Folder & Files' permission of Project.Contributor role correct work on shared folder
Meta: @gdam
      @projects
Given I created 'The Big Bang theory. Season 1. Edit folder does not work for PC019' project
And created '/The Fuzzy Boots Corollary' folder for project 'The Big Bang theory. Season 1. Edit folder does not work for PC019'
And I created users with following fields:
| Email             | Role        |
| CrystalWorld_PC19 | agency.user |
And I added users 'CrystalWorld_PC19' to project 'The Big Bang theory. Season 1. Edit folder does not work for PC019' team folders '/The Fuzzy Boots Corollary' with role 'project.contributor' expired '12.12.2031'
And I logged in with details of 'CrystalWorld_PC19'
When I go to project 'The Big Bang theory. Season 1. Edit folder does not work for PC019' folder '/The Fuzzy Boots Corollary' page
And I rename folder '/The Fuzzy Boots Corollary' to 'Unknown episode' in 'The Big Bang theory. Season 1. Edit folder does not work for PC019' project
Then 'should' see 'Unknown episode' folder in 'The Big Bang theory. Season 1. Edit folder does not work for PC019' project
And 'should not' see 'The Fuzzy Boots Corollary' folder in 'The Big Bang theory. Season 1. Edit folder does not work for PC019' project


Scenario: Check that 'folder.delete,element.delete' permission of Project.Contributor role correct work on shared folder for folders
Meta: @gdam
      @projects
!--Changes as per NGN-17753
!--If user deletes the folder that has been shared to them, it kind of removes them from the project team - which is another permission that they do not have.So project.contributor can only remove child folders when the parent is shared to them with inheritance, not the parent itself.
Given I created users with following fields:
| Email            | Role        | Agency        |
| WelcomeToT1_PC20 | agency.user | DefaultAgency |
And created 'The Big Bang theory. Season 1. Delete folder does not work for PC020' project
And created '/thbc' folder for project 'The Big Bang theory. Season 1. Delete folder does not work for PC020'
And created '/thbc/child' folder for project 'The Big Bang theory. Season 1. Delete folder does not work for PC020'
And created '/thbc2' folder for project 'The Big Bang theory. Season 1. Delete folder does not work for PC020'
And uploaded '/files/_file1.gif' file into '/thbc' folder for 'The Big Bang theory. Season 1. Delete folder does not work for PC020' project
And fill Share popup by users 'WelcomeToT1_PC20' in project 'The Big Bang theory. Season 1. Delete folder does not work for PC020' folders '/thbc,/thbc2' with role 'project.contributor' expired '12.12.2031' and 'should' access to subfolders
And logged in with details of 'WelcomeToT1_PC20'
When I go to project 'The Big Bang theory. Season 1. Delete folder does not work for PC020' folder '/thbc' page
And I open pop up menu of folder '/thbc' on project 'The Big Bang theory. Season 1. Delete folder does not work for PC020' files page
Then I 'should not' see in pop up menu for folder '/thbc' in project 'The Big Bang theory. Season 1. Delete folder does not work for PC020' files page following items:
| item   |
| Remove |
And refresh the page
When I open pop up menu of folder '/thbc/child' on project 'The Big Bang theory. Season 1. Delete folder does not work for PC020' files page
Then I 'should' see in pop up menu for folder '/thbc/child' in project 'The Big Bang theory. Season 1. Delete folder does not work for PC020' files page following items:
| item   |
| Remove |
When I delete folder '/thbc/child' in project 'The Big Bang theory. Season 1. Delete folder does not work for PC020'
Then 'should not' see '/thbc/child' folder in 'The Big Bang theory. Season 1. Delete folder does not work for PC020' project


Scenario: Check that 'folder.delete,element.delete' permission of Project.Contributor role correct work on shared folder for files
Meta: @gdam
      @projects
Given I created 'The Big Bang theory. Season 1. Delete file works for PC021' project
And created '/thbc' folder for project 'The Big Bang theory. Season 1. Delete file works for PC021'
And I uploaded '/files/_file1.gif' file into '/thbc' folder for 'The Big Bang theory. Season 1. Delete file works for PC021' project
And I created users with following fields:
| Email        | Role        |
| Welcome_PC21 | agency.user |
And I added users 'Welcome_PC21' to project 'The Big Bang theory. Season 1. Delete file works for PC021' team folders '/thbc' with role 'project.contributor' expired '12.12.2031'
And I logged in with details of 'Welcome_PC21'
When I go to project 'The Big Bang theory. Season 1. Delete file works for PC021' folder '/thbc' page
And I 'delete' file '_file1.gif' from project files page
Then I 'should not' see file '_file1.gif' on project 'The Big Bang theory. Season 1. Delete file works for PC021' folder '/thbc' files page


Scenario: Check that projects are correctly shared for user with 'Project.Contributor' role
Meta: @gdam
      @projects
Given I created following projects:
| Name                                  |
| Award. Very important project PC022   |
| Award. Middle important project PC022 |
| Award. Low important project PC022    |
And created in 'Award. Very important project PC022' project next folders:
| folder         |
| /10th Man Down |
| /Away          |
And created in 'Award. Middle important project PC022' project next folders:
| folder      |
| /Mysterious |
And created in 'Award. Low important project PC022' project next folders:
| folder     |
| /Sebastien |
And I created users with following fields:
| Email    | Role        |
| VIP_P022 | agency.user |
And I added users 'VIP_P022' to project 'Award. Very important project PC022' team folders '/10th Man Down' with role 'project.contributor' expired '12.12.2031'
And I logged in with details of 'VIP_P022'
When I go to project list page
Then I should see 'Award. Very important project PC022' project in project list
And I shouldn't see 'Award. Middle important project PC022' project in project list
And I shouldn't see 'Award. Low important project PC022' project in project list
When I search by text 'Award'
Then I 'should' see search object 'Award. Very important project PC022' with type 'Project' after wrap according to search 'Award' with 'Name' type
And I 'should not' see search object 'Award. Middle important project PC022' with type 'Project' after wrap according to search 'Award' with 'Name' type
And I 'should not' see search object 'Award. Low important project PC022' with type 'Project' after wrap according to search 'Award' with 'Name' type


Scenario: Check that folders are correctly shared for user with 'Project.Contributor' role
Meta: @gdam
      @projects
Given I created following projects:
| Name               |
| Defender_200 PC023 |
| Atacker_200 PC023  |
| Warlock_200 PC023  |
And created in 'Defender_200 PC023' project next folders:
| folder                |
| /Pestnja. Go West     |
| /Pestnja. It is A Sin |
And created in 'Atacker_200 PC023' project next folders:
| folder             |
| /Pestnja. Headlong |
And created in 'Warlock_200 PC023' project next folders:
| folder                  |
| /Pestnja. Eternal Flame |
And I created users with following fields:
| Email     | Role        |
| RsickPC23 | agency.user |
And I added users 'RsickPC23' to project 'Defender_200 PC023' team folders '/Pestnja. Go West' with role 'project.contributor' expired '12.12.2031'
And I logged in with details of 'RsickPC23'
When I go to project 'Defender_200 PC023' folder '/Pestnja. Go West' page
Then I 'should' see '/Pestnja. Go West' folder in 'Defender_200 PC023' project
And I 'should not' see '/Pestnja. It is A Sin' folder in 'Defender_200 PC023' project
When I search by text 'Pestnja'
Then I 'should' see search object 'Pestnja. Go West' with type 'Folder' after wrap according to search 'Pestnja' with 'Name' type
And I 'should not' see search object 'Pestnja. It is A Sin' with type 'Folder' after wrap according to search 'Pestnja' with 'Name' type
And I 'should not' see search object 'Pestnja. Headlong' with type 'Folder' after wrap according to search 'Pestnja' with 'Name' type
And I 'should not' see search object 'Pestnja. Eternal Flame' with type 'Folder' after wrap according to search 'Pestnja' with 'Name' type


Scenario: Check that files are correctly shared for user with 'Project.Contributor' role
Meta: @gdam
      @projects
Given I created following projects:
| Name                                                                   |
| OWB -Fabricator 2007 PC024                                             |
| OWB -Halcyon Days 2006 PC024                                           |
| OWB -Halcyon Nights (the Remixes of the Album Halcyon Days) 2006 PC024 |
And created in 'OWB -Fabricator 2007 PC024' project next folders:
| folder            |
| /Concrete Jungle  |
| /Chariots of fire |
And created in 'OWB -Halcyon Days 2006 PC024' project next folders:
| folder                    |
| /Sixteen tons of hardware |
And created in 'OWB -Halcyon Nights (the Remixes of the Album Halcyon Days) 2006 PC024' project next folders:
| folder     |
| /Open door |
And I created users with following fields:
| Email    | Role        |
| Duo_PC24 | agency.user |
And uploaded '/files/searchfile1_1' file into '/Concrete Jungle' folder for 'OWB -Fabricator 2007 PC024' project
And uploaded '/files/searchfile1_2' file into '/Concrete Jungle' folder for 'OWB -Fabricator 2007 PC024' project
And uploaded '/files/searchfile1_1' file into '/Chariots of fire' folder for 'OWB -Fabricator 2007 PC024' project
And uploaded '/files/searchfile1_2' file into '/Sixteen tons of hardware' folder for 'OWB -Halcyon Days 2006 PC024' project
And uploaded '/files/searchfile1_3' file into '/Open door' folder for 'OWB -Halcyon Nights (the Remixes of the Album Halcyon Days) 2006 PC024' project
And I added users 'Duo_PC24' to project 'OWB -Fabricator 2007 PC024' team folders '/Concrete Jungle' with role 'project.contributor' expired '12.12.2031'
And I logged in with details of 'Duo_PC24'
When I go to project 'OWB -Fabricator 2007 PC024' folder '/Concrete Jungle' page
Then I 'should' see file 'searchfile1_1' on project files page and files count are '1'
And I 'should' see file 'searchfile1_2' on project files page and files count are '1'
When I search by text 'searchfile1'
And I click show all link for global user search for object 'Files & Folders'
Then I should see following folders and files for user 'AgencyAdmin' project 'OWB -Fabricator 2007 PC024' after search on the page:
| FolderName        | FileName      | ShouldState |
| /Concrete Jungle  | searchfile1_1 | should      |
| /Concrete Jungle  | searchfile1_2 | should      |
| /Chariots of fire | searchfile1_1 | should not  |
And I should see following folders and files for user 'AgencyAdmin' project 'OWB -Halcyon Days 2006 PC024' after search on the page:
| FolderName                | FileName      | ShouldState |
| /Sixteen tons of hardware | searchfile1_2 | should not  |
And I should see following folders and files for user 'AgencyAdmin' project 'OWB -Halcyon Nights (the Remixes of the Album Halcyon Days) 2006 PC024' after search on the page:
| FolderName | FileName      | ShouldState |
| /Open door | searchfile1_3 | should not  |