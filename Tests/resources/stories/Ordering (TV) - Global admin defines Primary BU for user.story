!--NGN-11265
!--ORD-4841
Feature: Global admin defines Primary BU for user
Narrative:
In order to:
As a AgencyAdmin
I want to check correct work of defining Primary BU for user under Global Admin

Scenario: Check saving new Primary Business Unit for particular user
Meta: @ordering
Given I am logged in as 'GlobalAdmin'
And created the following agency:
| Name       | A4User        |
| GADPBUA1_1 | DefaultA4User |
| GADPBUA1_2 | DefaultA4User |
And added agency 'GADPBUA1_2' as a partner to agency 'GADPBUA1_1'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| GADPBUU1_1 | agency.admin | GADPBUA1_1   |
| GADPBUU1_2 | agency.admin | GADPBUA1_2   |
And added existing user 'GADPBUU1_2' to agency 'GADPBUA1_1' with role 'agency.admin'
And I am on profile user 'GADPBUU1_2' setting page of agency 'GADPBUA1_2'
When I fill following fields for user Profile Setting:
| Primary Business Unit |
| GADPBUA1_1            |
And save user Profile Setting
And refresh the page without delay
And go to profile user 'GADPBUU1_2' setting page of agency 'GADPBUA1_2'
Then I should see following data for user Profile Setting:
| Primary Business Unit |
| GADPBUA1_1            |

Scenario: Check possibility to change Primary BU after sharing folder to particular user
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| GADPBUA2_1 | DefaultA4User |
| GADPBUA2_2 | DefaultA4User |
And added agency 'GADPBUA2_2' as a partner to agency 'GADPBUA2_1'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| GADPBUU2_1 | agency.admin | GADPBUA2_1   |
| GADPBUU2_2 | agency.admin | GADPBUA2_2   |
And logged in with details of 'GADPBUU2_1'
And created 'GADPBUP2_1' project
And created '/GADPBUF2_1' folder for project 'GADPBUP2_1'
And added users 'GADPBUU2_2' to project 'GADPBUP2_1' team folders '/GADPBUF2_1' with role 'project.user' expired '02.02.2020' and 'should' access to subfolders
And I am logged in as 'GlobalAdmin'
When I go to profile user 'GADPBUU2_2' setting page of agency 'GADPBUA2_2'
Then I 'should' see available following Primary BUs 'GADPBUA2_1,GADPBUA2_2' for user Profile Setting

Scenario: Check combining orders after adding user to agency and then changing Primary BU
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| GADPBUA3_1 | DefaultA4User |
| GADPBUA3_2 | DefaultA4User |
And added agency 'GADPBUA3_2' as a partner to agency 'GADPBUA3_1'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| GADPBUU3_1 | agency.admin | GADPBUA3_1   |
| GADPBUU3_2 | agency.admin | GADPBUA3_2   |
And added existing user 'GADPBUU3_2' to agency 'GADPBUA3_1' with role 'agency.admin'
And logged in with details of 'GADPBUU3_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| GADPBUCN3_1  |
And logged in with details of 'GADPBUU3_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| GADPBUCN3_2  |
And I am logged in as 'GlobalAdmin'
And I am on profile user 'GADPBUU3_2' setting page of agency 'GADPBUA3_2'
When I fill following fields for user Profile Setting:
| Primary Business Unit |
| GADPBUA3_1            |
And save user Profile Setting
And login with details of 'GADPBUU3_2'
And go to View Draft Orders tab of 'tv' order on ordering page
Then I 'should' see 'own' orders with following item clock numbers 'GADPBUCN3_1,GADPBUCN3_2' in 'draft' order list
When I login with details of 'GADPBUU3_1'
And go to View Draft Orders tab of 'tv' order on ordering page
Then I 'should' see 'own' orders with following item clock numbers 'GADPBUCN3_1' in 'draft' order list

Scenario: Check agency branding after changing Primary BU
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| GADPBUA4_1 | DefaultA4User |
| GADPBUA4_2 | DefaultA4User |
And added agency 'GADPBUA4_2' as a partner to agency 'GADPBUA4_1'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| GADPBUU4_1 | agency.admin | GADPBUA4_1   |
| GADPBUU4_2 | agency.admin | GADPBUA4_2   |
And added existing user 'GADPBUU4_2' to agency 'GADPBUA4_1' with role 'agency.admin'
And logged in with details of 'GADPBUU4_1'
And I am on the system branding page
And uploaded logo '/images/SB_Logo.png' on system branding page
And selected color '#5a3c5a' on system branding page
And clicked save on the system branding page
And I am logged in as 'GlobalAdmin'
And I am on profile user 'GADPBUU4_2' setting page of agency 'GADPBUA4_2'
When I fill following fields for user Profile Setting:
| Primary Business Unit |
| GADPBUA4_1            |
And save user Profile Setting
And login with details of 'GADPBUU4_2'
Then I 'should not' see that header logo is default
And I 'should' see that header has next color '90, 60, 90'


Scenario: Check QC assets in Library after adding user to agency and then changing Primary BU
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| GADPBUA5_1 | DefaultA4User |
| GADPBUA5_2 | DefaultA4User |
And added agency 'GADPBUA5_2' as a partner to agency 'GADPBUA5_1'
And created users with following fields:
| Email      | Role         | AgencyUnique |Access|
| GADPBUU5_1 | agency.admin | GADPBUA5_1   |streamlined_library,library,ordering|
| GADPBUU5_2 | agency.admin | GADPBUA5_2   |streamlined_library,library,ordering|
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GADPBUA5_1':
| Advertiser  | Brand       | Sub Brand   | Product     |
| GADPBUAR5_1 | GADPBUBR5_1 | GADPBUSB5_1 | GADPBUPR5_1 |
And added existing user 'GADPBUU5_2' to agency 'GADPBUA5_1' with role 'agency.admin'
And logged in with details of 'GADPBUU5_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info 1  | GADPBUAR5_1 | GADPBUBR5_1 | GADPBUSB5_1 | GADPBUPR5_1 | GADPBUC5_1 | GADPBUCN5_1  | 20       | 12/14/2022     | HD 1080i 25fps | GADPBUT5_1 | Adtext             | BSkyB Green Button:Standard |
And complete order contains item with clock number 'GADPBUCN5_1' with following fields:
| Job Number  | PO Number   |
| GADPBUJN5_1 | GADPBUPN5_1 |
And I am logged in as 'GlobalAdmin'
And I am on profile user 'GADPBUU5_2' setting page of agency 'GADPBUA5_2'
When I fill following fields for user Profile Setting:
| Primary Business Unit |
| GADPBUA5_1            |
And save user Profile Setting
And login with details of 'GADPBUU5_2'
And I go to the Library page for collection 'Everything'NEWLIB
Then I 'should not' see assets 'GADPBUT5_1' in the collection 'Everything'NEWLIB