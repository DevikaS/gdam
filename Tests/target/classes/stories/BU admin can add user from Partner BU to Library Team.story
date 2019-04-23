!-- NGN-10533
Feature:          BU admin can add user from Partner BU to Library Team
BookNarrative:
In order to
As a              AgencyAdmin
I want to         Check that user from partner BU can be added to library team and access to asset according to role in team


Scenario:  Check that you can update user role for user in secondary BU and this change doesn't affect user in primary BU
!--NGN-11018
Meta:@library
     @gdam
Given I created the agency 'BUACAUFPBUTLT_A1' with default attributes
And I created the agency 'BUACAUFPBUTLT_A2' with default attributes
And created users with following fields:
| Email                | Role         | AgencyUnique     |
| BUACAUFPBUTLT_EA01_1 | agency.admin | BUACAUFPBUTLT_A1 |
| BUACAUFPBUTLT_EA01_2 | agency.admin | BUACAUFPBUTLT_A2 |
And logged in with details of 'GlobalAdmin'
And added following partners 'BUACAUFPBUTLT_A2' to agency 'BUACAUFPBUTLT_A1' on partners page
When I login with details of 'BUACAUFPBUTLT_EA01_1'
And create 'C1_BUACAUFPBUTLT' category
And add users 'BUACAUFPBUTLT_EA01_2' to category 'C1_BUACAUFPBUTLT' with role 'library.user' by users details
And go to user 'BUACAUFPBUTLT_EA01_2' details page
And edit for user 'BUACAUFPBUTLT_EA01_2' agency role 'agency.user'
And login with details of 'BUACAUFPBUTLT_EA01_2'
And go to user 'BUACAUFPBUTLT_EA01_2' details page
Then I should see on user details page fields with following values:
| element   | value               |
| Role      | Business Unit Admin |


Scenario: Check that you cannot edit user details for user from partner BU
Meta:@library
     @gdam
Given I created the agency 'BUASCTUFPBU_A1' with default attributes
And I created the agency 'BUASCTUFPBU_A2' with default attributes
And created users with following fields:
| Email                | Role         | AgencyUnique   |
| BUACAUFPBUTLT_EA02_1 | agency.admin | BUASCTUFPBU_A1 |
| BUACAUFPBUTLT_EA02_2 | agency.admin | BUASCTUFPBU_A2 |
And logged in with details of 'GlobalAdmin'
And added following partners 'BUASCTUFPBU_A2' to agency 'BUASCTUFPBU_A1' on partners page
When I login with details of 'BUACAUFPBUTLT_EA02_1'
And create 'C2_BUACAUFPBUTLT' category
And add users 'BUACAUFPBUTLT_EA02_2' to category 'C2_BUACAUFPBUTLT' with role 'library.user' by users details
Then I 'should not' see following enabled fields 'email,language,gtalk,skype,mobile,firstName,lastName,phone,folders,library,ordering' on user 'BUACAUFPBUTLT_EA02_2' edit page



Scenario: Check that user from partner BU can be added to Library team
Meta:@library
     @gdam
Given I created the agency 'BUASCTUFPBU_A1' with default attributes
And I created the agency 'BUASCTUFPBU_A2' with default attributes
And created users with following fields:
| Email                | Role         | AgencyUnique   |  Access               |
| BUACAUFPBUTLT_EA03_1 | agency.admin | BUASCTUFPBU_A1 | streamlined_library   |
| BUACAUFPBUTLT_EA03_2 | agency.admin | BUASCTUFPBU_A2 | streamlined_library   |
And logged in with details of 'GlobalAdmin'
And added following partners 'BUASCTUFPBU_A2' to agency 'BUASCTUFPBU_A1' on partners page
When I login with details of 'BUACAUFPBUTLT_EA03_1'
And create 'C3_1_BUACAUFPBUTLT' category
And create 'C3_2_BUACAUFPBUTLT' category
And add users 'BUACAUFPBUTLT_EA03_2' to category 'C3_1_BUACAUFPBUTLT' with role 'library.user' by users details
And add users 'BUACAUFPBUTLT_EA03_2' to library team 'library_team'
And go to collection 'C3_1_BUACAUFPBUTLT' on administration area collections page
And add library teams 'library_team' for category 'C3_2_BUACAUFPBUTLT' with role 'library.user'
And login with details of 'BUACAUFPBUTLT_EA03_2'
And I go to the collections page
Then I 'should' see on the library page sub collections 'C3_2_BUACAUFPBUTLT' under agency 'BUASCTUFPBU_A1'NEWLIB



Scenario: Check that user has access according to libary role in team  (default roles library role)
Meta:@library
     @gdam
Given I created the agency 'BUASCTUFPBU_A1' with default attributes
And I created the agency 'BUASCTUFPBU_A2' with default attributes
And created users with following fields:
| Email                | Role         | AgencyUnique   |  Access             |
| BUACAUFPBUTLT_EA04_1 | agency.admin | BUASCTUFPBU_A1 |streamlined_library  |
| BUACAUFPBUTLT_EA04_2 | agency.admin | BUASCTUFPBU_A2 |  streamlined_library |
And logged in with details of 'GlobalAdmin'
And added following partners 'BUASCTUFPBU_A2' to agency 'BUASCTUFPBU_A1' on partners page
When I login with details of 'BUACAUFPBUTLT_EA04_1'
And create 'C4_BUACAUFPBUTLT' category
And upload following assetsNEWLIB:
| Name             |
| /files/logo1.gif |
And go to collection 'C4_BUACAUFPBUTLT' on administration area collections page
And add users 'BUACAUFPBUTLT_EA04_2' to category 'C4_BUACAUFPBUTLT' with role 'library.user' by users details
And I login with details of 'BUACAUFPBUTLT_EA04_2'
And go to the Library pageNEWLIB
And go to asset 'logo1.gif' info page in Library for collection 'C4_BUACAUFPBUTLT'NEWLIB
Then 'should' see Edit link on opened asset info pageNEWLIB
And 'should' see 'download proxy' button on opened asset info pageNEWLIB
And 'should' see 'download original' button on opened asset info pageNEWLIB


Scenario: Check that after remove user from library team after share he loses access to category
Meta: @gdam
      @library
Given I created the agency 'BUASCTUFPBU_A1' with default attributes
And I created the agency 'BUASCTUFPBU_A2' with default attributes
And created users with following fields:
| Email                | Role         | AgencyUnique   |  Access             |
| BUACAUFPBUTLT_EA05_1 | agency.admin | BUASCTUFPBU_A1 |streamlined_library   |
| BUACAUFPBUTLT_EU05_2 | agency.user  | BUASCTUFPBU_A2 |streamlined_library   |
And logged in with details of 'GlobalAdmin'
And added following partners 'BUASCTUFPBU_A2' to agency 'BUASCTUFPBU_A1' on partners page
When I login with details of 'BUACAUFPBUTLT_EA05_1'
And create 'C5_1_BUACAUFPBUTLT' category
And create 'C5_2_BUACAUFPBUTLT' category
And add users 'BUACAUFPBUTLT_EU05_2' to category 'C5_1_BUACAUFPBUTLT' with role 'library.user' by users details
And add users 'BUACAUFPBUTLT_EU05_2' to library team 'library_team'
And go to collection 'C5_1_BUACAUFPBUTLT' on administration area collections page
And add library teams 'library_team' for category 'C5_2_BUACAUFPBUTLT' with role 'library.user'
And remove users 'BUACAUFPBUTLT_EU05_2' from 'library' team 'library_team'
And login with details of 'BUACAUFPBUTLT_EU05_2'
And I go to the collections page
Then I 'should' see on the library page sub collections 'C5_1_BUACAUFPBUTLT' under agency 'BUASCTUFPBU_A1'NEWLIB
And I 'should not' see on the library page sub collections 'C5_2_BUACAUFPBUTLT' under agency 'BUASCTUFPBU_A1'NEWLIB
