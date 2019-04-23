!-- NGN-10664
Feature:          Show total number of item on top for project list and Library etc
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check that show total number of item on top for project list and Library etc


Scenario: Check total number on Project list page
Meta:@gdam
@projects
Given I created the agency 'STNOT_A01' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| STNOT_EA01 | agency.admin | STNOT_A01    |
When I login with details of 'STNOT_EA01'
And create following projects:
| Name     |
| STNOT_P1 |
| STNOT_P2 |
| STNOT_P3 |
| STNOT_P4 |
| STNOT_P5 |
And go to project list page
Then I should see following count '5' of total projects


Scenario: Check total number on search results page (project and asset and file)
Meta:@gdam
@library
Given I created the agency 'STNOT_A01' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| STNOT_EA01 | agency.admin | STNOT_A01    |streamlined_library,dashboard,folders,adkits|
When I login with details of 'STNOT_EA01'
And create following projects:
| Name        |
| STNOT_P_2_1 |
| STNOT_P_2_2 |
| STNOT_P_2_3 |
And create '/STNOT_F03' folder for project 'STNOT_P_2_1'
And upload '/images/logo.png' file into '/STNOT_F03' folder for 'STNOT_P_2_1' project
And upload '/images/logo.gif' file into '/STNOT_F03' folder for 'STNOT_P_2_1' project
And upload following assetsNEWLIB:
| Name               |
| /files/audio01.mp3 |
| /files/audio02.mp3 |
| /files/audio03.mp3 |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
When I go to Dashboard page
And search by text 'STNOT_P_2'
And click show all link for global user search
Then I should see following count '3' of total projects on search result page
When I search by text 'logo'
And click show all link for global user search
Then I should see following count '2' of total files on search result page
When I search by text '.mp3'
And click show all link for global user search
Then I 'should' see asset count '3' on the library search results pageNEWLIB



Scenario: Check total number on Folder files list page
Meta:@gdam
Given I created the agency 'STNOT_A01' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| STNOT_EA03 | agency.admin | STNOT_A01    |
When I login with details of 'STNOT_EA03'
And create 'STNOT_P03' project
And create '/STNOT_F03' folder for project 'STNOT_P03'
And upload '/images/logo.png' file into '/STNOT_F03' folder for 'STNOT_P03' project
And upload '/images/logo.gif' file into '/STNOT_F03' folder for 'STNOT_P03' project
And upload '/images/logo.jpg' file into '/STNOT_F03' folder for 'STNOT_P03' project
And go to project 'STNOT_P03' folder '/STNOT_F03' page
Then I should see following count '3' of total files in project folder



Scenario: Check total number on Presentation list page
Meta:@gdam
Given I created the agency 'STNOT_A01' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |
| STNOT_EA05 | agency.admin | STNOT_A01    |
When I login with details of 'STNOT_EA05'
And go to the presentations assets page
And create new presentation with name 'STNOT_EA05_1' and description 'descr 1' from presentation page
And create new presentation with name 'STNOT_EA05_2' and description 'descr 2' from presentation page
And create new presentation with name 'STNOT_EA05_3' and description 'descr 3' from presentation page
And go to the all presentations page
Then I should see following count '3' of presentations


Scenario: Check total number on Admin - Users page
Meta:@gdam
Given I created the agency 'STNOT_A01' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |
| STNOT_EA01   | agency.admin | STNOT_A01    |
| STNOT_EA06_1 | agency.user  | STNOT_A01    |
| STNOT_EA06_2 | agency.user  | STNOT_A01    |
| STNOT_EA06_3 | agency.user  | STNOT_A01    |
When I login with details of 'STNOT_EA01'
And go to User list page
Then I should see following count '4' of users on Users page


Scenario: Check total number on Library page for Everything collection
Meta:@gdam
Given I created the agency 'STNOT_A05' with default attributes
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| STNOT_EA04 | agency.admin | STNOT_A05    |streamlined_library,library,adkits,folders|
When I login with details of 'STNOT_EA04'
And create 'STNOT_P04' project
And create '/STNOT_F04' folder for project 'STNOT_P04'
And upload following assetsNEWLIB:
| Name             |
| /files/logo1.gif |
| /files/logo2.png |
| /files/logo3.jpg |
When I go to the Library pageNEWLIB
Then I 'should' see total asset count '3' in collection 'Everything'NEWLIB
