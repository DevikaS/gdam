!--NGN-3580 NGN-5078
Feature:          Library - Asset activity
Narrative:
In order to
As a              AgencyAdmin
I want to         Check asset activity

Scenario: Check that activities are available for all users without dependency to permissions
Meta:@gdam
@@library
Given I created the agency '<Agency>' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |Access|
| <AdminUser>  | agency.admin | <Agency>     |streamlined_library|
| <TestedUser> | <GlobalRole> | <Agency>     |streamlined_library|
And logged in with details of '<AdminUser>'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And created '<LibRole>' role with 'asset.read' permissions in 'library' group for advertiser '<Agency>'
And created 'C_LAA_S09' category
And added users '<TestedUser>' for category 'C_LAA_S09' with role '<LibRole>'
And logged in with details of '<TestedUser>'
When I go to asset 'Fish Ad.mov' info page in Library for collection 'C_LAA_S09'NEWLIB
And wait for '3' seconds
And I go to asset 'Fish Ad.mov' activity page in Library for collection 'C_LAA_S09'NEWLIB
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'C_LAA_S09'NEWLIB:
| UserName     | Message        | Value |
| <AdminUser>  | Uploaded by |       |
| <TestedUser> | Viewed by   |       |

Examples:
| Agency      | AdminUser    | TestedUser   | GlobalRole   | LibRole      |
| A_LAA_S09_1 | AU_LAA_S09_1 | TU_LAA_S09_1 | agency.admin | LR_LAA_S09_1 |
| A_LAA_S09_2 | AU_LAA_S09_2 | TU_LAA_S09_2 | agency.user  | LR_LAA_S09_2 |
| A_LAA_S09_3 | AU_LAA_S09_3 | TU_LAA_S09_3 | guest.user   | LR_LAA_S09_3 |



Scenario: Check that multiselect of Activities and removal of selection displays list of Activities
Meta:@gdam
@library
!--QA-926
Given I created users with following fields:
| FirstName | LastName | Email     | Role         |Access               |
| Clyde     | Donovan  | U_MARA_S01 | agency.admin |library,streamlined_library  |
When I login with details of 'U_MARA_S01'
And upload file '/files/Fish Ad.mov' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I go to asset 'Fish Ad.mov' activity page in Library for collection 'My Assets'NEWLIB
And I search on activity page in Library:
|ActivityType                   |
|Uploaded asset                 |
|Uploaded assets                |
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName   | Message                | Value |
| U_MARA_S01 | Uploaded by            |       |
When I remove activities in activity page in Library:
|ActivityType                   |
|Uploaded asset                 |
|Uploaded assets                |
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName   | Message                | Value |
| U_MARA_S01 | Uploaded by            |       |
| U_MARA_S01 | Viewed by              |       |
| U_MARA_S01 | Asset transcoded by    |       |

Scenario: Check default activities displayed on Activity tab of asset without selection User and Activity Type
Meta:@gdam
@library
!--QA-926
Given I created users with following fields:
| FirstName | LastName | Email     | Role         |Access               |
| Clyde     | Donovan  | U_DAD_S01 | agency.admin |library,streamlined_library  |
When I login with details of 'U_DAD_S01'
And I upload following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/Fish Ad.mov         |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I go to asset 'Fish Ad.mov' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName  | Message                | Value |
| U_DAD_S01 | Uploaded by            |       |

Scenario: Check different activities displayed on Activity tab of asset based upon selection of Activity Type and User
Meta:@gdam
@library
!--QA-926
Given I created users with following fields:
| FirstName | LastName | Email     | Role         |Access               |
| Clyde     | Donovan  | U_LAA_S01 | agency.admin |library,streamlined_library  |
When I login with details of 'U_LAA_S01'
And I upload following assetsNEWLIB:
| Name                       |
| /files/Fish Ad.mov         |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And I go to asset 'Fish Ad.mov' activity page in Library for collection 'My Assets'NEWLIB
And I search on activity page in Library:
|ActivityType   |
|<ActivityType> |
And I enter user name 'U_LAA_S01' on activity page in Library
Then I '<Condition>' see the following activities on asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName  | Message        | Value |
| U_LAA_S01 | <Message>      |       |

Examples:
| ActivityType       | Message             |   Condition          |
|Created asset from project file |  Created asset       |   should not         |
| Uploaded asset     | Uploaded by         |   should             |
|Preview transcoded  | Asset transcoded by |   should             |


Scenario: Check the list of  activities on the Asset Activity page
Meta:@gdam
@@library
!--QA-926
Given I created users with following fields:
| FirstName | LastName | Email     | Role         |Access               |
| Clyde     | Donovan  | U_LAA_S02 | agency.admin |library,streamlined_library  |
When I login with details of 'U_LAA_S02'
And upload file '/files/Fish Ad.mov' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
Then I 'should' see the following activities under All activities dropdown for asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
|Activity    |
|Added asset to presentation    |
|Added asset to work request    |
|Cancelled                      |
|Created asset                  |
|Created asset from project file |
|Deleted asset                 |
|Deleted attachment(s)         |
|Delivered                      |
|Directly shared asset downloaded |
|Downloaded asset master         |
|Downloaded asset master from presentation  |
|Downloaded asset proxy         |
|Downloaded asset proxy from presentation   |
|Downloaded assets              |
|Downloaded attachment          |
|Downloaded storyboards         |
|Ingested                       |
|Preview transcode failed       |
|Preview transcoded             |
|Previewed Asset                |
|Shared asset                   |
|Shared asset with invite       |
|Shared asset with public link  |
|Shared assets                  |
|Shared assets with invite      |
|Synchronized                   |
|Transcoded                     |
|Unshared asset                 |
|Updated attachment(s)          |
|Updated metadata               |
|Upload failed                  |
|Uploaded asset                 |
|Uploaded assets                |
|Uploaded attachment(s)         |
|Usage rights will expire soon for asset   |

Scenario: User can see Activity about Upload and Secure Share user in Asset Activity tab
Meta: @gdam
@@library
Given I created users with following fields:
| Email         | Role         |Access               |
| AU_SSOFAA_S17 | agency.admin |library,streamlined_library  |
| U_SSOFAA_S17  | agency.user  |library,streamlined_library  |
And logged in with details of 'AU_SSOFAA_S17'
And set following notification settings for users:
| UserEmail    | SettingName   | SettingState |
| U_SSOFAA_S17 | Assets Shared | on           |
And uploaded file '/files/Fish Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add secure share for asset 'Fish Ad.mov' from collection 'My Assets' to following usersNEWLIB:
| UserEmails   | DownloadOriginal |
| U_SSOFAA_S17 | true             |
And I go to asset 'Fish Ad.mov' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName      | Message     | Value |
| AU_SSOFAA_S17 | Uploaded by |       |
| AU_SSOFAA_S17 | Shared by   |       |



Scenario: Check that edit metadata activity appears on Activity tab of asset
Meta:@gdam
@@library
!--QA-926
Given I created users with following fields:
| FirstName | LastName | Email     | Role         | Access               |
| Craig     | Tucker   | U_EAM_S02 | agency.admin |library,streamlined_library  |
When I login with details of 'U_EAM_S02'
And upload file '/files/Fish Ad.mov' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And 'save' asset 'Fish Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName | FieldValue |
| Clock number | CNLAA1  |
| Title     | New Ad.mov     |
And wait for '2' seconds
And I go to asset 'New Ad.mov' activity page in Library for collection 'My Assets'NEWLIB
And I search on activity page in Library:
|ActivityType         |
|Updated metadata     |
And I enter user name 'U_EAM_S02' on activity page in Library
Then I 'should' see the following activities on asset 'New Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName  | Message             | Value |
| U_EAM_S02 | Metadata Updated by |       |


Scenario: Check that played file activity appears on Activity tab of asset
Meta: @gdam
      @@library
      !--QA-926
Given I created users with following fields:
| FirstName | LastName | Email     | Role         | Access              |
| Tweek     | Tweak    | U_LAA_S04 | agency.admin |library,streamlined_library  |
When I login with details of 'U_LAA_S04'
And upload file '/files/Fish Ad.mov' into libraryNEWLIB
And wait while preview is available in collection 'My Assets'NEWLIB
And play clip on asset 'Fish Ad.mov' activity page for category 'My Assets'NEWLIB
And I go to asset 'Fish Ad.mov' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName  | Message      | Value |
| U_LAA_S04 | Asset transcoded by  |       |



Scenario: Check that download activity appears on Activity tab of asset
Meta:@gdam
@@library
Given I created users with following fields:
| FirstName | LastName | Email     | Role         | Access              |
| Timmy     | Burch    | U_LAA_S05 | agency.admin |library,streamlined_library  |
When I login with details of 'U_LAA_S05'
And upload file '/files/Fish Ad.mov' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And go to asset 'Fish Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And 'download original' on opened asset info pageNEWLIB
And I go to asset 'Fish Ad.mov' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName  | Message                 | Value |
| U_LAA_S05 | Downloaded by |       |



Scenario: Check that add to presentation activity appears on Activity tab of asset
Meta:@gdam
@@library
Given I created users with following fields:
| FirstName | LastName | Email     | Role         |Access|
| Bradley   | Biggle   | U_LAA_S06 | agency.admin |streamlined_library,presentations|
When I login with details of 'U_LAA_S06'
And upload file '/files/Fish Ad.mov' into libraryNEWLIB
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And go to the Library page for collection 'My Assets'NEWLIB
And I add assets 'Fish Ad.mov' to new presentation 'P_LAA_S06' from collection 'My Assets' pageNEWLIB
And I go to asset 'Fish Ad.mov' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName  | Message                     | Value     |
| U_LAA_S06 | Added to Presentation by |  |


Scenario: Check that delete activity appears on Activity tab of asset
Meta:@gdam
@@library
Given I created users with following fields:
| FirstName | LastName | Email     | Role         | Access              |
| Bebe      | Stevens  | U_LAA_S07 | agency.admin | library,streamlined_library  |
And I logged in with details of 'U_LAA_S07'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I am on the Library page for collection 'My Assets'NEWLIB
And selected asset 'Fish Ad.mov' in the 'My Assets' library pageNEWLIB
And I removed asset in 'My Assets' library page
When I go to library trash pageNEWLIB
And I click asset 'Fish Ad.mov' on library trash pageNEWLIB
And I click on activities icon
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName  | Message       | Value |
| U_LAA_S07 | Deleted by |       |
When I restore assets 'Fish Ad.mov' from library trash pageNEWLIB
And I go to asset 'Fish Ad.mov' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName  | Message       | Value |
| U_LAA_S07 | Undeleted by |       |


Scenario: Check that activities are available for all users without dependency to permissions
Meta:@gdam
@@library
!--QA-926
Given I created the agency '<Agency>' with default attributes
And created users with following fields:
| Email        | Role         | AgencyUnique |Access               |
| <AdminUser>  | agency.admin | <Agency>     |library,streamlined_library  |
| <TestedUser> | <GlobalRole> | <Agency>     |library,streamlined_library  |
And logged in with details of '<AdminUser>'
And uploaded file '/files/Fish Ad.mov' into library
And waited while transcoding is finished in collection 'Everything'NEWLIB
And created '<LibRole>' role with 'asset.read' permissions in 'library' group for advertiser '<Agency>'
And created 'C_LAA_S09' category
And added users '<TestedUser>' for category 'C_LAA_S09' with role '<LibRole>'
And logged in with details of '<TestedUser>'
When I go to asset 'Fish Ad.mov' activity page in Library for collection 'C_LAA_S09'NEWLIB
And wait for '3' seconds
And refresh the page
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'C_LAA_S09'NEWLIB:
| UserName     | Message        | Value |
| <AdminUser>  | Uploaded by    |       |
| <TestedUser> | Viewed by      |       |

Examples:
| Agency      | AdminUser    | TestedUser   | GlobalRole   | LibRole      |
| A_LAA_S09_1 | AU_LAA_S09_1 | TU_LAA_S09_1 | agency.admin | LR_LAA_S09_1 |
| A_LAA_S09_2 | AU_LAA_S09_2 | TU_LAA_S09_2 | agency.user  | LR_LAA_S09_2 |
| A_LAA_S09_3 | AU_LAA_S09_3 | TU_LAA_S09_3 | guest.user   | LR_LAA_S09_3 |



Scenario: Check that impersonate information is recorded on activities
Meta:@gdam
@@library
Given I created the following agency:
| Name    | A4User        | Application Access     |
| IMPA1 | DefaultA4User | library,streamlined_library  |
And created users with following fields:
| Email   | Role         | AgencyUnique |  Access      |
| IMPU1 | agency.admin   | IMPA1      | library,streamlined_library |
| IMPU2 | agency.admin   | IMPA1      | library,streamlined_library |
And logged in with details of 'IMPU1'
When I go to the Library page for collection 'Everything'NEWLIB
And I upload file '/files/image9.jpg' into my libraryNEWLIB
And I wait while transcoding is finished in collection 'Everything'NEWLIB
And I logout from account
And I am login as 'GlobalAdmin'
And I wait for '2' seconds
And I impersonate me as user 'IMPU2' on opened page
And I go to asset 'image9.jpg' info page in library for collection 'Everything' impersonated as 'IMPU2'NEWLIB
Then I 'should' see the activities on asset 'image9.jpg' activity page for collection 'Everything' impersonated as 'IMPU2'NEWLIB:
| UserName     | Message                     | Value                       |
| IMPU2 | Viewed by |  (Impersonated by administrator user: ga.forqaautomation) |


Scenario: Check that Usage rights activity appears on Activity tab of asset
Meta:@gdam
@@library
Given I created users with following fields:
| Email      | Role         |Access             |
| U_URI_S04 | agency.admin |streamlined_library|
And logged in with details of 'U_URI_S04'
And uploaded file '/files/logo3.png' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add Usage Right 'General' for asset 'logo3.png' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 12.12.2012     |
And I go to asset 'logo3.png' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the following activities on asset 'logo3.png' activity page for collection 'My Assets'NEWLIB:
| UserName  | Message                     | Value     |
| U_URI_S04 | Usage Rights Updated by |  |

