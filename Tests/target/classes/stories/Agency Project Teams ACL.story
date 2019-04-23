!--NGN-4856 NGN-981
Feature:          Agency Project Teams ACL
Narrative:
In order to
As a              AgencyAdmin
I want to         check ACL of Agency Project Teams

Scenario: Check that after adding Agency team to project, project is visible for users (agency, guest) (S1)
Meta:@gdam
     @projects
Given I created users with following fields:
| Email     | Role        |
| APT_AU_S1 | agency.user |
| APT_AU_S2 | guest.user  |
And I created agency project team 'Dream team 1' with following data:
| UserName  | Role                |
| APT_AU_S1 | project.observer    |
| APT_AU_S2 | project.contributor |
And I created 'Ahniminidjan S1 A2' project
And I created in 'Ahniminidjan S1 A2' project next folders:
| folder          |
| /test           |
| /test/subfolder |
| /mainfolder     |
And I added agency project team 'Dream team 1' into project 'Ahniminidjan S1 A2'
And I logged in with details of '<UserName>'
When I go to Project list page
Then I should see 'Ahniminidjan S1 A2' project in project list
When I go to project 'Ahniminidjan S1 A2' files page
Then I should see tabs for project 'Ahniminidjan S1 A2' folder '' according to:
| TabName   | ShouldState |
| Files     | should      |
| Approvals | should      |
| Overview  | should not  |
| Team      | should not  |
When I go to project 'Ahniminidjan S1 A2' folder '/test' page
Then I 'should' see folder name '/test' on files page
When I go to project 'Ahniminidjan S1 A2' folder '/test/subfolder' page
Then I 'should' see folder name '/test/subfolder' on files page
When I go to project 'Ahniminidjan S1 A2' folder '/mainfolder' page
Then I 'should' see folder name '/mainfolder' on files page

Examples:
| UserName  |
| APT_AU_S1 |
| APT_AU_S2 |


Scenario: Check that after adding Agency project team to folder, subfolders and other folder isn't visible (S2)
Meta:@gdam
     @projects
Given I created users with following fields:
| Email      | Role        |
| APT_AU_S2A | agency.user |
| APT_AU_S2B | guest.user  |
And I created agency project team 'Witches academy' with following data:
| UserName   | Role                |
| APT_AU_S2A | project.observer    |
| APT_AU_S2B | project.contributor |
And I created 'Ahniminidjan S2 A2' project
And I created in 'Ahniminidjan S2 A2' project next folders:
| folder          |
| /test           |
| /test/subfolder |
| /mainfolder     |
And I uploaded into project 'Ahniminidjan S2 A2' following files:
| FileName             | Path            |
| /files/GWGTest2.pdf  | /test/subfolder |
| /files/Fish-Ad.mov   | /test/subfolder |
| /files/test.mp3      | /test/subfolder |
| /files/shortname.wav | /test/subfolder |
And I waited while transcoding is finished in folder '/test/subfolder' on project 'Ahniminidjan S2 A2' files page
When I add agency project team 'Witches academy' into folder '/test/subfolder' in the project 'Ahniminidjan S2 A2'
And I login with details of '<UserName>'
And I go to Project list page
Then I should see 'Ahniminidjan S2 A2' project in project list
When I go to project 'Ahniminidjan S2 A2' files page
Then I should see tabs for project 'Ahniminidjan S2 A2' folder '' according to:
| TabName   | ShouldState |
| Files     | should      |
| Approvals | should      |
| Overview  | should not  |
| Team      | should not  |
And I should see following folders for the project 'Ahniminidjan S2 A2':
| Folder     | State      |
| subfolder  | should     |
| mainfolder | should not |
| test       | should not |
Then I 'should' see on project 'Ahniminidjan S2 A2' folder '/test/subfolder' are created by user 'AgencyAdmin' files page following files :
| FileName      |
| GWGTest2.pdf  |
| Fish-Ad.mov   |
| test.mp3      |
| shortname.wav |
When I go to file 'Fish-Ad.mov' info page in folder '/test/subfolder' project 'Ahniminidjan S2 A2' of user 'AgencyAdmin'
And I wait while proxy is visible on file info page
Then I 'should' see proxy of file 'Video' on file info page
When I go to file 'test.mp3' info page in folder '/test/subfolder' project 'Ahniminidjan S2 A2' of user 'AgencyAdmin'
And I wait while proxy is visible on file info page
Then I 'should' see proxy of file 'Audio' on file info page
When I go to file 'shortname.wav' info page in folder '/test/subfolder' project 'Ahniminidjan S2 A2' of user 'AgencyAdmin'
And I wait while proxy is visible on file info page
Then I 'should' see proxy of file 'Video' on file info page
When I go to file 'GWGTest2.pdf' info page in folder '/test/subfolder' project 'Ahniminidjan S2 A2' of user 'AgencyAdmin'
And I wait while proxy is visible on file info page
Then I 'should' see proxy of file 'PDF' on file info page

Examples:
| UserName   |
| APT_AU_S2A |
| APT_AU_S2B |


Scenario: Check different permissions for one folder for one user(Permissions should be matched)(S4)
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
	  @gdam
	  @projects
Given I created 'PR_S4_Alpha' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission   |
| project.read |
| folder.read  |
| element.read |
| element.create |
And I created 'PR_S4_Beta' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission   |
| folder.share |
| element.read |
And I created users with following fields:
| Email     | Role        |
| APT_AU_S4 | agency.user |
And I created agency project team 'Dream team 4 Alpha' with following data:
| UserName  | Role        |
| APT_AU_S4 | PR_S4_Alpha |
And I created agency project team 'Dream team 4 Beta' with following data:
| UserName  | Role       |
| APT_AU_S4 | PR_S4_Beta |
And I created 'Ahniminidjan S4 A1' project
And I created in 'Ahniminidjan S4 A1' project next folders:
| folder |
| /test  |
And I uploaded '/files/shortname.wav' file into '/test' folder for 'Ahniminidjan S4 A1' project
And I added agency project team 'Dream team 4 Alpha' into project 'Ahniminidjan S4 A1'
And I added agency project team 'Dream team 4 Beta' into project 'Ahniminidjan S4 A1'
And I logged in with details of 'APT_AU_S4'
And I am on project 'Ahniminidjan S4 A1' folder '/test' page
When I upload '/files/Fish Ad.mov' file into '/test' folder for 'Ahniminidjan S4 A1' project
And I wait for '10' seconds
And wait while preview is available in folder '/test' on project 'Ahniminidjan S4 A1' files page
Then I 'should' see file 'shortname.wav' on project 'Ahniminidjan S4 A1' folder '/test' files page
And I 'should' see element 'Share' on page 'FilesPage'
And I 'should' see element 'DisabledMoreButton' on page 'FilesPage'
When I open pop up menu of folder '/test' on project 'Ahniminidjan S4 A1' overview page
Then I 'should not' see in pop up menu for folder '/test' in project 'Ahniminidjan S4 A1' overview page following items:
| item   |
| Remove |
When I go to project 'Ahniminidjan S4 A1' folder '/test' page
When I select file 'shortname.wav' on project files page
Then I 'should not' see enabled buttons on Download popup for project 'Ahniminidjan S4 A1' folder '/test'
When I go to file 'shortname.wav' info page in folder '/test' project 'Ahniminidjan S4 A1'
Then I should see following tabs on file 'shortname.wav' info page in folder '/test' project 'Ahniminidjan S4 A1':
| TabName  | ShouldState |
| Comments | should not  |


Scenario: Check that after delete one user from Agency team, project dissapears only for him (S5)
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Role        |
| APT_AU_S5_1 | agency.user |
| APT_AU_S5_2 | guest.user  |
And I created agency project team 'Dream team 5 Zeta' with following data:
| UserName    | Role                |
| APT_AU_S5_1 | project.contributor |
| APT_AU_S5_2 | project.observer    |
And I created 'Ahniminidjan S5 A1' project
And I created in 'Ahniminidjan S5 A1' project next folders:
| folder          |
| /test           |
| /test/subfolder |
| /mainfolder     |
And I added agency project team 'Dream team 5 Zeta' into project 'Ahniminidjan S5 A1'
And I am on project 'Ahniminidjan S5 A1' teams page
When I remove user 'APT_AU_S5_1' form project 'Ahniminidjan S5 A1' team page when agency project team 'Dream team 5 Zeta' was selected
And I login with details of 'APT_AU_S5_1'
And I go to Project list page
Then I shouldn't see 'Ahniminidjan S5 A1' project in project list
When I login with details of 'APT_AU_S5_2'
And I go to Project list page
Then I should see 'Ahniminidjan S5 A1' project in project list


Scenario: Check that after add new user in Agency Project team, it doesn't affect already shared project (S6)
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Role        |
| APT_AU_S6_1 | agency.user |
| APT_AU_S6_2 | guest.user  |
| APT_AU_S6_N | agency.user |
And I created agency project team 'Dream team 6 Kappa' with following data:
| UserName    | Role                |
| APT_AU_S6_1 | project.contributor |
| APT_AU_S6_2 | project.observer    |
And I created 'Ahniminidjan S6 A1' project
And I created in 'Ahniminidjan S6 A1' project next folders:
| folder |
| /test  |
And I added agency project team 'Dream team 6 Kappa' into project 'Ahniminidjan S6 A1'
And I am on Users list page with selected user 'APT_AU_S6_N'
And I added user 'APT_AU_S6_N' to 'Dream team 6 Kappa' project team with role 'project.contributor' on Users list page
And I waited for '1' seconds
When I login with details of 'APT_AU_S6_1'
And I go to Project list page
Then I should see 'Ahniminidjan S6 A1' project in project list
When I login with details of 'APT_AU_S6_2'
And I go to Project list page
Then I should see 'Ahniminidjan S6 A1' project in project list
When I login with details of 'APT_AU_S6_N'
And I go to Project list page
Then I shouldn't see 'Ahniminidjan S6 A1' project in project list


Scenario: Check that after change role for user in Agency Project team, it doesn't affect already shared project (S7)
Meta:@gdam
     @projects
!--NGN-4858
Given I created 'PR_S7_Alpha' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission   |
| project.view |
And I created 'PR_S7_Beta' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission   |
| file.view    |
| element.view |
Given I created users with following fields:
| Email       | Role       |
| APT_AU_S7   | guest.user |
And I created agency project team 'Dream team 7 WWW' with following data:
| UserName  | Role        |
| APT_AU_S7 | PR_S7_Alpha |
And I created 'Ahniminidjan S7 A1' project
And I created in 'Ahniminidjan S7 A1' project next folders:
| folder |
| /test  |
And I added agency project team 'Dream team 7 WWW' into folder '/test' in the project 'Ahniminidjan S7 A1'
And I removed users 'APT_AU_S7' from 'project' team 'Dream team 7 WWW'
And I added 'APT_AU_S7' users to 'Dream team 7 WWW' project team with role 'PR_S7_Beta' on Users list page
When I login with details of 'APT_AU_S7'
And I go to Project list page
Then I should see 'Ahniminidjan S7 A1' project in project list
When I go to project 'Ahniminidjan S7 A1' files page
Then I should see following folders for the project 'Ahniminidjan S7 A1':
| Folder| State      |
| test  | should not |


Scenario: Check that after change role for user, it should not be applied in project (S8)
Meta:@gdam
     @projects
!--NGN-4858
Given I created 'PR_S8_Alpha' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission   |
| project.view |
And I created 'PR_S8_Beta' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission   |
| file.view    |
| element.view |
Given I created users with following fields:
| Email     | Role       |
| APT_AU_S8 | guest.user |
And I created 'Ahniminidjan S8 A1' project
And I created in 'Ahniminidjan S8 A1' project next folders:
| folder |
| /test  |
And I uploaded into project 'Ahniminidjan S8 A1' following files:
| FileName           | Path  |
| /files/Fish-Ad.mov | /test |
And I created agency project team 'Dream team 8 XXX' with following data:
| UserName  | Role        |
| APT_AU_S8 | PR_S8_Alpha |
And I added agency project team 'Dream team 8 XXX' into folder '/test' in the project 'Ahniminidjan S8 A1'
And I removed users 'APT_AU_S8' from 'project' team 'Dream team 8 XXX'
And I added 'APT_AU_S8' users to 'Dream team 8 XXX' project team with role 'PR_S8_Beta' on Users list page
When I login with details of 'APT_AU_S8'
And I go to Project list page
Then I should see 'Ahniminidjan S8 A1' project in project list
When I go to project 'Ahniminidjan S8 A1' files page
Then I should see following folders for the project 'Ahniminidjan S8 A1':
| Folder | State      |
| test   | should not |
And I 'should not' see on project 'Ahniminidjan S8 A1' folder '/test' are created by user 'AgencyAdmin' files page following files :
| FileName    |
| Fish-Ad.mov |
And I 'should not' see element 'UploadButton' on page 'FilesPage'
And I 'should not' see element 'DownloadButton' on page 'FilesPage'
And I 'should not' see element 'Share' on page 'FilesPage'
And I 'should not' see element 'MoreButton' on page 'FilesPage'
And I 'should not' see in pop up menu for folder '/test' in project 'Ahniminidjan S8 A1' overview page following items:
| item   |
| Remove |
| Share  |


Scenario: Check that after delete user from Agency Project team, it doesn't affect already shared project (S9)
Meta:@gdam
     @projects
Given I created users with following fields:
| Email       | Role        |
| APT_AU_S9_1 | agency.user |
| APT_AU_S9_2 | guest.user  |
And I created 'Ahniminidjan S9 A1' project
And I created in 'Ahniminidjan S9 A1' project next folders:
| folder |
| /test  |
And I created agency project team 'Dream team 9 Alpha' with following data:
| UserName    | Role                |
| APT_AU_S9_1 | project.contributor |
| APT_AU_S9_2 | project.observer    |
And I added agency project team 'Dream team 9 Alpha' into project 'Ahniminidjan S9 A1'
And I am on Users list page with selected user 'APT_AU_S9_2'
And I removed users 'APT_AU_S9_2' from 'project' team 'Dream team 9 Alpha'
When I login with details of 'APT_AU_S9_1'
And I go to Project list page
Then I should see 'Ahniminidjan S9 A1' project in project list
When I login with details of 'APT_AU_S9_2'
And I go to Project list page
Then I should see 'Ahniminidjan S9 A1' project in project list


Scenario: Check that all users could share own projects on Agency project teams that have been created by agency admin (S10)
Meta:@gdam
     @projects
Given I created 'GR_guest_copy' role with 'asset_filter_collection.create,enum.read,group.agency_enums.read,project.create,role.read,user.read,agency_team.read' permissions in 'global' group for advertiser 'DefaultAgency'
And I created users with following fields:
| Email         | Role          |
| APT_AU_S10_N1 | agency.user   |
| APT_AU_S10_N2 | GR_guest_copy |
| APT_AU_S10_1  | agency.user   |
| APT_AU_S10_2  | GR_guest_copy |
And I created agency project team 'Dream team 10 Omega' with following data:
| UserName     | Role                |
| APT_AU_S10_1 | project.contributor |
| APT_AU_S10_2 | project.observer    |
And I logged in with details of '<UserName>'
And I created '<ProjectName>' project
And I created in '<ProjectName>' project next folders:
| folder |
| /test  |
| /test2 |
And I uploaded '/files/Fish Ad.mov' file into '/test' folder for '<ProjectName>' project
And waited while preview is available in folder '/test' on project '<ProjectName>' files page
And I added agency project team 'Dream team 10 Omega' into folder '/test' in the project '<ProjectName>'
And I logged in with details of '<ShareUser>'
When I go to project '<ProjectName>' files page
Then I should see following folders for the project '<ProjectName>':
| Folder | State      |
| test   | should     |
| test2  | should not |
And I 'should' see on project '<ProjectName>' folder '/test' are created by user '<UserName>' files page following files :
| FileName    |
| Fish Ad.mov |
When I go to file 'Fish Ad.mov' info page in folder '/test' project '<ProjectName>' of user '<UserName>'
And I wait while proxy is visible on file info page
Then I 'should' see proxy of file 'Video' on file info page

Examples:
| UserName      | ShareUser    | ProjectName         |
| APT_AU_S10_N1 | APT_AU_S10_1 | Ahniminidjan S10 A1 |
| APT_AU_S10_N2 | APT_AU_S10_2 | Ahniminidjan S10 A2 |



Scenario: Check different permissions for one folder for one user(Permissions should be matched)(S4) #2
Meta:@gdam
     @projects
Given I created 'PR_S4_Alpha_1' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission   |
| project.read |
| folder.read  |
| element.read |
And I created 'PR_S4_Beta_1' role in 'project' group for advertiser 'DefaultAgency' with following permissions:
| Permission   |
| folder.share |
| element.read |
And I created users with following fields:
| Email     | Role        |
| APT_AU_S4_1 | agency.user |
And I created agency project team 'Dream team 4 Alpha_1' with following data:
| UserName  | Role        |
| APT_AU_S4_1 | PR_S4_Alpha_1 |
And I created agency project team 'Dream team 4 Beta_1' with following data:
| UserName  | Role       |
| APT_AU_S4_1 | PR_S4_Beta_1 |
And I created 'Ahniminidjan S4 A1' project
And I created in 'Ahniminidjan S4 A1' project next folders:
| folder |
| /test  |
And I uploaded '/files/shortname.wav' file into '/test' folder for 'Ahniminidjan S4 A1' project
And I added agency project team 'Dream team 4 Alpha_1' into project 'Ahniminidjan S4 A1'
And I added agency project team 'Dream team 4 Beta_1' into project 'Ahniminidjan S4 A1'
And I logged in with details of 'APT_AU_S4_1'
And I am on project 'Ahniminidjan S4 A1' folder '/test' page
Then I 'should' see file 'shortname.wav' on project 'Ahniminidjan S4 A1' folder '/test' files page
And I 'should' see element 'Share' on page 'FilesPage'
And I 'should not' see element 'upload' on page 'FilesPage'
And I 'should' see element 'DisabledMoreButton' on page 'FilesPage'
When I open pop up menu of folder '/test' on project 'Ahniminidjan S4 A1' overview page
Then I 'should not' see in pop up menu for folder '/test' in project 'Ahniminidjan S4 A1' overview page following items:
| item   |
| Remove |
When I go to project 'Ahniminidjan S4 A1' folder '/test' page
When I select file 'shortname.wav' on project files page
Then I 'should not' see enabled buttons on Download popup for project 'Ahniminidjan S4 A1' folder '/test'
When I go to file 'shortname.wav' info page in folder '/test' project 'Ahniminidjan S4 A1'
Then I should see following tabs on file 'shortname.wav' info page in folder '/test' project 'Ahniminidjan S4 A1':
| TabName  | ShouldState |
| Comments | should not  |


Scenario: Check different permissions for a folder shared to a user of partner BU with role as project.contributor
Meta:@gdam
     @projects
!--QA-845
Given added agency 'AnotherAgency' as a partner to agency 'DefaultAgency'
And I created users with following fields:
| Email       | Role        | Agency           |
| APT_AU_S4_2 | agency.user | AnotherAgency    |
And I created 'Ahniminidjan S4 A1' project
And I created in 'Ahniminidjan S4 A1' project next folders:
| folder |
| /test/test1/test2/test3/test4/test5/test6/test7/test8/test9/test10/test11/test12/test13/test14/test15/test16/test17/test18/test19/test20/test21/test22/test23/test24/test25  |
And I uploaded '/files/shortname.wav' file into '/test/test1/test2/test3/test4/test5/test6/test7/test8/test9/test10/test11/test12/test13/test14/test15/test16/test17/test18/test19/test20/test21/test22/test23/test24/test25' folder for 'Ahniminidjan S4 A1' project
And fill Share popup by users 'APT_AU_S4_2' in project 'Ahniminidjan S4 A1' folders '/test' with role 'project.contributor' expired '12.12.2022' and 'should' access to subfolders
And logged in with details of 'APT_AU_S4_2'
And I am on project 'Ahniminidjan S4 A1' folder '/test/test1/test2/test3/test4/test5/test6/test7/test8/test9/test10/test11/test12/test13/test14/test15/test16/test17/test18/test19/test20/test21/test22/test23/test24/test25' page
When I select file 'shortname.wav' on project files page
Then I 'should' see element 'Share' on page 'FilesPage'
And I 'should' see element 'Upload' on page 'FilesPage'
And I 'should' see element 'Download' on page 'FilesPage'
And I 'should' see element 'New Folder' on page 'FilesPage'