!--NGN-132
Feature:          Delete Folder from Project-Trash bin
Narrative:
In order to
As a              AgencyAdmin
I want to         Check moving folder/subfolders and files to trash bin

Scenario: Check that folder after delete should be moved to trash bin with subfolders
Meta:@gdam
@projects
Given I created 'HUT1' project
And created in 'HUT1' project next folders:
| folder                   |
| /áéíóúàèì                |
| /Läckürol                |
| /Läckürol/blö            |
| /Läckürol/blö/!@#$%^&*() |
And I am on project 'HUT1' folder '/Läckürol' page
When I delete folder '/Läckürol' in project 'HUT1'
And I delete folder '/áéíóúàèì' in project 'HUT1'
And I go to the Project Trash page for project 'HUT1'
Then I should see following folders in project 'HUT1' in trash bin:
| folder                   |
| /Läckürol                |
| /Läckürol/blö            |
| /Läckürol/blö/!@#$%^&*() |
| /áéíóúàèì                |


Scenario: Check that after delete folders, they should be removed from ui
Meta:@gdam
@projects
Given I created 'HUT2' project
And created in 'HUT2' project next folders:
| folder       |
| /tes         |
| /tes/upd     |
| /tes/upd/ert |
| /Lol         |
| /Lol2        |
When I delete folder '/tes' in project 'HUT2'
Then I should see following folders in 'HUT2' project:
| folder       | should     |
| /tes         | should not |


Scenario: Check that trash bin should be visible only for agency admin user
Meta:@gdam
@projects
Given I created users with following fields:
| Email  | Role   |
| <User> | <role> |
And I logged in with details of '<User>'
And I created 'PTF' project
When I go to project 'PTF' files page
Then I '<Should>' see element 'TrashBin' on page 'FilesPage'

Examples:
| User   | role         | Should     |
| testp2 | agency.user  | should not |
| testp  | agency.admin | should     |


Scenario: Check that trash bin should be visible only for NewRoleWithCreateViewProjectPermission
Meta:@gdam
@projects
Given I created '<role>' role with 'project.create' permissions in 'global' group for advertiser 'DefaultAgency'
And I created users with following fields:
| Email  | Role   |
| <User> | <role> |
And I logged in with details of '<User>'
And I created 'PTF' project
When I go to project 'PTF' files page
Then I '<Should>' see element 'TrashBin' on page 'FilesPage'

Examples:
| User   | role                                   | Should     |
| testp3 | NewRoleWithCreateViewProjectPermission | should not |


Scenario: Check that after delete files is situated in parent folder
Meta:@gdam
@projects
Given I created 'HUT7' project
And created in 'HUT7' project next folders:
| folder       |
| /tes         |
| /tes/upd     |
| /tes/upd/ert |
And uploaded into project 'HUT7' following files:
| FileName                                     | Path         |
| /files/for_babylon43.7z                      | /tes/upd/ert |
| /files/!@#$%^&()_+;,.Document.txt            | /tes/upd/ert |
| /files/Tesco_Trade_Meat_Wine_PANTS939015.wav | /tes         |
| /files/GWGTestfile064v3.pdf                  | /tes         |
| /files/New Text Document.txt                 | /tes         |
When I delete folder '/tes' in project 'HUT7'
And I go to the Project Trash page for project 'HUT7'
Then I 'should' see the following files in the project 'HUT7' trash bin:
| FileName                              |
| for_babylon43.7z                      |
| !@#$%^&()_+;,.Document.txt            |
| Tesco_Trade_Meat_Wine_PANTS939015.wav |
| GWGTestfile064v3.pdf                  |
| New Text Document.txt                 |
And I 'should' see the following files in the project 'HUT7' trash bin in folder '/tes':
| FileName                              |
| Tesco_Trade_Meat_Wine_PANTS939015.wav |
| GWGTestfile064v3.pdf                  |
| New Text Document.txt                 |
And I 'should' see the following files in the project 'HUT7' trash bin in folder '/tes/upd/ert':
| FileName                   |
| for_babylon43.7z           |
| !@#$%^&()_+;,.Document.txt |


Scenario: Check 'select all' and counter functions in trash bin
Meta:@gdam
     @bug
     @projects
!--FAB-345
Given I created 'HUT5' project
And created in 'HUT5' project next folders:
| folder |
| /tes   |
And uploaded into project 'HUT5' following files:
| FileName                          | Path |
| /files/for_babylon43.7z           | /tes |
| /files/!@#$%^&()_+;,.Document.txt | /tes |
| /files/ÄäDocumentÖö.txt           | /tes |
And I deleted folder '/tes' in project 'HUT5'
And I am on the Project Trash page for project 'HUT5'
When I click element 'SelectAll' on page 'FilesPage'
Then I 'should' see that the following files are selected in the project trash bin:
| FileName                   |
| for_babylon43.7z           |
| !@#$%^&()_+;,.Document.txt |
| ÄäDocumentÖö.txt           |
Then I should see element 'CounterOfFiles' with text '3 Files (3 selected)' on page 'FilesPage'


Scenario: check that after sharing project on owner trash bin opens correct
Meta:@gdam
@projects
!-- NGN-1445
Given I created users with following fields:
| Email |
| testp |
And the following projects were created:
| Name | Administrators |
| BEB  | testp          |
And created in 'BEB' project next folders:
| folder |
| /tes   |
And I logged in with details of 'testp'
And I am on project 'BEB' files page
When I go to the Project Trash page for project 'BEB'
Then I should see opened trash bin


Scenario: Check that trash bin should be visible only for NewRoleWithCreateViewProjectPermission
Meta:@gdam
@projects
Given I created 'NewRoleWithCreateViewProjectPermission' role with 'project.create' permissions in 'global' group for advertiser 'DefaultAgency'
And I created users with following fields:
| Email        | Role                                   | Agency        |
| U_DFFPTBSL_1 | NewRoleWithCreateViewProjectPermission | AnotherAgency |
And I created 'P_DFFPTBSL_1' project
And I created '/F_DFFPTBSL_1' folder for project 'P_DFFPTBSL_1'
And I created 'PR_DFFPTBSL_1' role in 'project' group for advertiser 'DefaultAgency'
And I added users 'U_DFFPTBSL_1' to project 'P_DFFPTBSL_1' team folders '/F_DFFPTBSL_1' with role 'PR_DFFPTBSL_1' expired '12.12.2021'
And I logged in with details of 'U_DFFPTBSL_1'
When I go to project 'P_DFFPTBSL_1' files page
Then I 'should not' see element 'TrashBin' on page 'FilesPage'