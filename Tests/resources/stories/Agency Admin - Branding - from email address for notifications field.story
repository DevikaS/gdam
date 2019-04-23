!--NGN-8877
Feature:          Agency Admin - Branding - from email address for notifications field
Narrative:
In order to
As a              AgencyAdmin
I want to         check from email address for notifications field

Scenario: Check that should be possible to enter email not @adstream.com
Meta:@gdamemails
     @gdam
Given I created the agency 'A_AABFEF_S01' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |
| U_AABFEF_S01 | agency.admin | A_AABFEF_S01 |
And logged in with details of 'U_AABFEF_S01'
When I fill From email field with text 'test@notadstream.com' on system branding page
And click save on the system branding page
And wait for '2' seconds
And refresh the page
Then I 'should' see From email field with text 'test@notadstream.com' on system branding page


Scenario: Check that not be possible to enter email in invalid format, which can crash email notifications from this BU/other BUs.
Meta:@gdamemails
     @gdam
Given I created the agency 'A_AABFEF_S02' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |
| U_AABFEF_S02 | agency.admin | A_AABFEF_S02 |
And logged in with details of 'U_AABFEF_S02'
When I fill From email field with text 'invalid,email'notadstream.com' on system branding page
And click save on the system branding page
Then I 'should' see error hint '* Invalid email' under From email field on opened system branding page
When I refresh the page
Then I 'should' see From email field with text '' on system branding page


Scenario: Check that after change 'from' address, user recives notification about invite from correct address
Meta:@gdamemails
     @gdam
Given I created the agency 'A_AABFEF_S03' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |
| U_AABFEF_S03 | agency.admin | A_AABFEF_S03 |
And logged in with details of 'U_AABFEF_S03'
When I fill From email field with text 'test@notadstream.com' on system branding page
And click save on the system branding page
And invite user 'IU_AABFEF_S03'
Then I 'should' see email notification for 'Invite user' with field to 'IU_AABFEF_S03' and subject 'You are invited to the Adstream Platform' contains following attributes:
| EmailFrom            | UserEmail    | Agency       |
| test@notadstream.com | U_AABFEF_S03 | A_AABFEF_S03 |


Scenario: Check that after change 'from' address,user recives notification about invite from correct address
Meta:@gdamemails
     @gdam
Given I created the agency 'A_AABFEF_S04' with default attributes
And created users with following fields:
| Email         | Role         | Agency       |
| AU_AABFEF_S04 | agency.admin | A_AABFEF_S04 |
| U_AABFEF_S04  | agency.user  | A_AABFEF_S04 |
And logged in with details of 'AU_AABFEF_S04'
And created 'P_AABFEF_S04' project
And created '/F_AABFEF_S04' folder for project 'P_AABFEF_S04'
When I fill From email field with text 'test@notadstream.com' on system branding page
And click save on the system branding page
And filling Share popup by users 'U_AABFEF_S04' in project 'P_AABFEF_S04' folders '/F_AABFEF_S04' with role 'project.user' expired '02.02.2020' and 'should' access to subfolders
And wait for '3' seconds
Then I 'should' see email notification for 'Folder sharing for User' with field to 'U_AABFEF_S04' and subject 'Folders have been shared with you' contains following attributes:
| EmailFrom            | UserName      | Agency       | ProjectName  | FolderName   |
| test@notadstream.com | AU_AABFEF_S04 | A_AABFEF_S04 | P_AABFEF_S04 | F_AABFEF_S04 |


Scenario: Check that after change 'from' address, user recives notification about share collection from correct address
Meta:@gdamemails
     @gdam
Given I created the agency 'A_AABFEF_S04_1' with default attributes
And created the agency 'A_AABFEF_S04_2' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| U_AABFEF_S04_1 | agency.admin | A_AABFEF_S04_1 |streamlined_library|
| U_AABFEF_S04_2 | agency.admin | A_AABFEF_S04_2 |streamlined_library|
And I logged in with details of 'U_AABFEF_S04_2'
And set following notification settings for user:
| UserEmail      | SettingName           | SettingState |
| U_AABFEF_S04_2| assetFilterShared     | on           |
And logged in with details of 'GlobalAdmin'
And added following partners 'A_AABFEF_S04_1' to agency 'A_AABFEF_S04_2' on partners page
And logged in with details of 'U_AABFEF_S04_1'
And created following categories:
| Name         |
| C_AABFEF_S04 |
And uploaded asset '/files/logo2.png' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I fill From email field with text 'test@notadstream.com' on system branding page
And click save on the system branding page
And I shared next agencies for following categories:
| CategoryName | AgencyName     |
| C_AABFEF_S04 | A_AABFEF_S04_2 |
And login with details of 'U_AABFEF_S04_2'
When I go to the collections page
When I go to the Shared Collection 'C_AABFEF_S04' from agency 'A_AABFEF_S04_1' pageNEWLIB
And I select asset 'logo2.png' for collection 'C_AABFEF_S04' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
Then I 'should' see email notification for 'Category sharing' with field to 'U_AABFEF_S04_2' and subject 'Collection has been shared with' contains following attributes:
| EmailFrom            | UserName1      | Agency         | UserName       | CategoryName |
| test@notadstream.com | U_AABFEF_S04_1 | A_AABFEF_S04_1 | U_AABFEF_S04_2 | C_AABFEF_S04 |
