Feature:          Usage rights - email notification about expiry
Narrative:
In order to
As a              AgencyAdmin
I want to         check email notification about expiry usage rights


Scenario: Add a usage rights to an asset to see an AssetUsageRightsExpireSoon email notification
Meta:@gdam
@gdamemails
Given I created the agency 'A_UREEM_S01_1' with default attributes
And I have enabled the Asset Usage rights expiry job to run every 2 mins
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_UREEM_S01_1 | agency.admin | A_UREEM_S01_1 |streamlined_library|
| U_UREEM_S01_2 | agency.user  | A_UREEM_S01_1 |streamlined_library|
And logged in with details of 'U_UREEM_S01_1'
And created 'C_UREEM_S01' category
And added users 'U_UREEM_S01_2' to category 'C_UREEM_S01' with role 'library.user' by users details
And I am on the library page for collection 'My Assets'NEWLIB
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And logged in with details of 'U_UREEM_S01_2'
When I go to the library page for collection 'My Assets'NEWLIB
And add Usage Right 'General' for asset 'Fish Ad.mov' for collection 'C_UREEM_S01' with following fieldsNEWLIB:
| StartDate  | ExpirationDate | NotifyIfExpired | DaysFromExpire |
| 20.02.2002 | now            | true            | 1              |
Then I 'should' see that user 'U_UREEM_S01_1' received email for asset 'Fish Ad.mov' and usage right 'General' for Usage Expiry rights for days '1' with interval
Then I 'should' see that user 'U_UREEM_S01_2' received email for asset 'Fish Ad.mov' and usage right 'General' for Usage Expiry rights for days '1' with interval

Scenario: Update an usage rights of an asset to see an AssetUsageRightsExpireSoon email notification
Meta:@gdam
@gdamemails
Given I created the agency 'A_UREEM_S02_1' with default attributes
And I have enabled the Asset Usage rights expiry job to run every 2 mins
And created users with following fields:
| Email            | Role         | AgencyUnique  |Access|
| U_UREEM_S02_1    | agency.admin | A_UREEM_S02_1 |streamlined_library|
And logged in with details of 'U_UREEM_S02_1'
And I am on the library page for collection 'My Assets'NEWLIB
And uploaded file '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And added Usage Right 'General' for asset 'Fish1-Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate | NotifyIfExpired | DaysFromExpire |
| 20.02.2002 | deepFuture     | true            | 1              |
When I go to asset 'Fish1-Ad.mov' usage rights page in Library for collection 'Everything'NEWLIB
And edit entry of 'General' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
|EntryNumber | ExpirationDate |StartDate|
| 1          |  now           |20.02.2002|
Then I 'should' see that user 'U_UREEM_S02_1' received email for asset 'Fish1-Ad.mov' and usage right 'General' for Usage Expiry rights for days '1' with interval


Scenario: AssetUsageRightsExpireSoon email notification to a user from Partnered BU
Meta:@gdam
@gdamemails
Given I created the agency 'A_UREEM_S03_1' with default attributes
And I have enabled the Asset Usage rights expiry job to run every 2 mins
And I created the agency 'A_UREEM_S03_2' with default attributes
And added agency 'A_UREEM_S03_1' as a partner to agency 'A_UREEM_S03_2'
And created users with following fields:
| Email         | Role         | AgencyUnique  |Access|
| U_UREEM_S03_1 | agency.admin | A_UREEM_S03_1 |streamlined_library|
| U_UREEM_S03_2 | agency.user  | A_UREEM_S03_2 |streamlined_library|
And logged in with details of 'U_UREEM_S03_1'
And created 'C_UREEM_S01' category
And added users 'U_UREEM_S03_2' to category 'C_UREEM_S01' with role 'library.user' by users details
And I am on the library page for collection 'My Assets'NEWLIB
And uploaded file '/files/shortname.wav' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And logged in with details of 'U_UREEM_S03_2'
And added Usage Right 'General' for asset 'shortname.wav' for collection 'C_UREEM_S01' with following fieldsNEWLIB:
| StartDate  | ExpirationDate | NotifyIfExpired | DaysFromExpire |
| 20.02.2002 | now            | true            | 1              |
Then I 'should' see that user 'U_UREEM_S03_1' received email for asset 'shortname.wav' and usage right 'General' for Usage Expiry rights for days '1' with interval
Then I 'should' see that user 'U_UREEM_S03_2' received email for asset 'shortname.wav' and usage right 'General' for Usage Expiry rights for days '1' with interval

Scenario: Add multiple Usage rights that expire on different days
Meta:@gdam
@gdamemails
Given I created the agency 'A_UREEM_S04_1' with default attributes
And I have enabled the Asset Usage rights expiry job to run every 2 mins
And created users with following fields:
| Email         | Role         | AgencyUnique     |Access|
| U_UREEM_S04_1 | agency.admin | A_UREEM_S04_1    |streamlined_library|
And logged in with details of 'U_UREEM_S04_1'
And I am on the library page for collection 'My Assets'NEWLIB
And uploaded file '/files/Fish1-Ad.mp4' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And added Usage Right 'General' for asset 'Fish1-Ad.mp4' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate | NotifyIfExpired | DaysFromExpire |
| 20.02.2002 | deepFuture     | true            | 1              |
And waited for '2' seconds
And added Usage Right 'Countries' for asset 'Fish1-Ad.mp4' for collection 'My Assets' with following fieldsNEWLIB:
| Country | StartDate  | ExpirationDate | NotifyIfExpired | DaysFromExpire |
| Europe  | 20.02.2002 | now            | true            | 1              |
Then I 'should' see that user 'U_UREEM_S04_1' received email for asset 'Fish1-Ad.mp4' and usage right 'Countries' for Usage Expiry rights for days '1' with interval
And I 'should not' see that user 'U_UREEM_S04_1' received email for asset 'Fish1-Ad.mp4' and usage right 'General' for Usage Expiry rights for days '1' with interval

Scenario: Asset Usage rights Expire but the user hasn't subscribed to the email notifications
Meta:@gdam
@gdamemails
Given I created the agency 'A_UREEM_S05_1' with default attributes
And I have enabled the Asset Usage rights expiry job to run every 2 mins
And created users with following fields:
| Email            | Role            | AgencyUnique     |Access|
| U_UREEM_S05_1    | agency.admin    | A_UREEM_S05_1    |streamlined_library|
And logged in with details of 'U_UREEM_S05_1'
And set following notification settings for user:
| UserEmail        | SettingName                     | SettingState  |
| U_UREEM_S05_1    | assetUsageRightsExpireSoon      | off           |
And I am on the library page for collection 'My Assets'NEWLIB
And uploaded file '/files/13DV-CAPITAL-10.mpg' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And added Usage Right 'Countries' for asset '13DV-CAPITAL-10.mpg' for collection 'My Assets' with following fieldsNEWLIB:
| Country | StartDate  | ExpirationDate | NotifyIfExpired | DaysFromExpire |
| Europe  | 20.02.2002 | now            | true            | 1              |
Then I 'should not' see that user 'U_UREEM_S05_1' received email for asset '13DV-CAPITAL-10.mpg' and usage right 'Countries' for Usage Expiry rights for days '1' with interval

Scenario: Update an already expired Usage rights of an asset
Meta:@gdam
@library
Given I created the agency 'A_UREEM_S06_1' with default attributes
And I have enabled the Asset Usage rights expiry job to run every 2 mins
And created users with following fields:
| Email         | Role         | AgencyUnique     |Access|
| U_UREEM_S06_1 | agency.admin | A_UREEM_S06_1    |streamlined_library|
And logged in with details of 'U_UREEM_S06_1'
And I am on the library page for collection 'My Assets'NEWLIB
And uploaded file '/files/canon-journey.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And added Usage Right 'Countries' for asset 'canon-journey.mov' for collection 'My Assets' with following fieldsNEWLIB:
| Country | StartDate  | ExpirationDate       | NotifyIfExpired | DaysFromExpire |
| Europe  | 20.02.2002 | yesterday            | true            | 1              |
And I waited for '2' seconds
When I go to asset 'canon-journey.mov' usage rights page in Library for collection 'Everything'NEWLIB
And edit entry of 'Countries' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
|EntryNumber | ExpirationDate |StartDate|Country|
| 1          |  now           |20.02.2002|Europe|
Then I 'should' see that user 'U_UREEM_S06_1' received email for asset 'canon-journey.mov' and usage right 'Countries' for Usage Expiry rights for days '1' with interval

