!--NGN-17583
Feature:         Ordering (TV Music) - Localisation
Narrative:
In order to
As a              AgencyAdmin
I want to         Check MAin Functionalities of Project,Library ,traffic for diffrent locale users


Scenario: Check Project Functionality for localised User
Meta: @ordering
Given I created the agency 'LOCPPDAA4' with default attributes
And created users with following fields:
| Email         | Role         | Agency      |
| U_LOCPPD_07   | agency.admin | LOCPPDAA4   |
| U_LOCPAR_08   | agency.user  | LOCPPDAA4   |
And logged in with details of 'U_LOCPPD_07'
And I am on user 'U_LOCPPD_07' details page
And I filled following fields on user 'U_LOCPPD_07' details page with specific Language:
| Language      |
| German        |
And I clicked save on users details page
And I logout from account
And logged in with details of 'U_LOCPPD_07'
And I created following projects:
| Name        |
| P_PMFS_S8_1 |
| P_PMFS_S8_2 |
And created in 'P_PMFS_S8_1' project next folders:
| folder                   |
| /F_PMFS_S8_1             |
And created in 'P_PMFS_S8_2' project next folders:
| folder                   |
| /F_PMFS_S8_3             |
And uploaded few files '/images/logo.bmp,/images/logo.gif,/images/logo.jpeg' with delimiter ',' into '/F_PMFS_S8_1' folder for 'P_PMFS_S8_1' project
And I am on project 'P_PMFS_S8_1' folder '/F_PMFS_S8_1' page
And I clicked on Want to move files to another project link on move/copy file 'logo.jpeg' popup for 'German' locale users
And I entered 'P_PMFS_S8_2' in search field on move/copy file popup
And I selected folder '/F_PMFS_S8_3' on move/copy file popup
When I click move button on move/copy files popup
When I go to project 'P_PMFS_S8_2' folder '/F_PMFS_S8_3' page
And add users 'U_LOCPAR_08' to project 'P_PMFS_S8_2' team folders '/F_PMFS_S8_3' with role 'project.observer' expired '11.11.2221'
When login with details of 'U_LOCPAR_08'
And I go to project list page
Then I 'should' see '/F_PMFS_S8_3' folder in 'P_PMFS_S8_2' project


Scenario: Check Library Functionality for localised User
Meta: @uitobe
Given I created the agency 'LOCPPDAA5' with default attributes
And created users with following fields:
| Email         | Role         | Agency      |
| U_LOCPPD_09   | agency.admin | LOCPPDAA5   |
And logged in with details of 'U_LOCPPD_09'
And I am on user 'U_LOCPPD_09' details page
And I filled following fields on user 'U_LOCPPD_09' details page with Language other than English:
| Language      |
| German        |
And I clicked save on users details page
And I logout from account
And logged in with details of 'U_LOCPPD_09'
And uploaded file '/files/Fish Ad.mov' into my library
And uploaded file '/files/GWGTest2.pdf' into my library
And created following collections:
| Name        | MediaType |
| C_LAATC_S02 | print     |
And waited while transcoding is finished in collection 'My Assets'
When I add following assets 'Fish Ad.mov,GWGTest2.pdf' to collection 'C_LAATC_S02' from collection 'My Assets'
Then I 'should' see assets with titles 'Fish Ad.mov,GWGTest2.pdf' in the collection 'C_LAATC_S02'
When I go to the library page for collection 'My Assets'
And create following reels:
| Name           | Description |
| PDAFOZAR8_3    | description |
And I go to library page for collection 'C_LAATC_S02'
And add asset 'Fish Ad.mov' into existing presentation 'PDAFOZAR8_3'
And go to the presentations assets page 'PDAFOZAR8_3'
Then I 'should' see presentation 'PDAFOZAR8_3' on the page
And 'should' see asset 'Fish Ad.mov' in the current presentation
When I send following assets 'Fish Ad.mov' from library collection 'My Assets' to Delivery for 'German' locale users
Then I should see for active order item on cover flow following data:
| Title        | Counter |
| Fish Ad.mov  |         |
