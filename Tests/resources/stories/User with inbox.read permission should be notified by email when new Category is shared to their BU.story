!--NGN-9524
Feature:          User with inbox.read permission should be notified by email when new Category is shared to their BU
BookNarrative:
In order to
As a              AgencyAdmin
I want to         check that user with inbox.read permission is notified by email when new Category is shared to their BU

Scenario: Check that email is recieved only by users with inbox.read permission (all user types)
Meta: @gdam
      @gdamemails
Given I created the agency 'A_UIRPNBE_S01' with default attributes
And created the agency '<AgencyName>' with default attributes
And created users with following fields:
| Email          | Role         | Agency        |
| AU_UIRPNBE_S01 | agency.admin | A_UIRPNBE_S01 |
| <UserEmail>    | <GlobalRole> | <AgencyName>  |
When I login with details of '<UserEmail>'
And set following notification settings for user:
| UserEmail      | SettingName           | SettingState |
| <UserEmail>    | assetFilterShared     | on           |
And I login with details of 'AU_UIRPNBE_S01'
And create '<CollectionName>' category
And shared next agencies for following categories:
| CategoryName     | AgencyName   |
| <CollectionName> | <AgencyName> |
When I login with details of '<UserEmail>'
Then I '<Condition>' see email notification for 'Category sharing' with field to '<UserEmail>' and subject 'Collection has been shared with' contains following attributes:
| UserName1      | Agency        | UserName    | CategoryName     |
| AU_UIRPNBE_S01 | A_UIRPNBE_S01 | <UserEmail> | <CollectionName> |

Examples:
| UserEmail       | GlobalRole   | AgencyName      | CollectionName  | Condition  |
| U_UIRPNBE_S01_1 | agency.admin | A_UIRPNBE_S01_1 | C_UIRPNBE_S01_1 | should     |
| U_UIRPNBE_S01_2 | agency.user  | A_UIRPNBE_S01_2 | C_UIRPNBE_S01_2 | should not |
| U_UIRPNBE_S01_3 | guest.user   | A_UIRPNBE_S01_3 | C_UIRPNBE_S01_3 | should not |


Scenario: Check that email is recieved for all users with inbox.read permission
Meta: @gdam
      @gdamemails
Given I created the agency 'A_UIRPNBE_S02_1' with default attributes
And created the agency 'A_UIRPNBE_S02_2' with default attributes
And created users with following fields:
| Email           | Role         | Agency          |
| AU_UIRPNBE_S02  | agency.admin | A_UIRPNBE_S02_1 |
| U_UIRPNBE_S02_1 | agency.admin | A_UIRPNBE_S02_2 |
And I logged in with details of 'U_UIRPNBE_S02_1'
And set following notification settings for user:
| UserEmail      | SettingName           | SettingState |
| U_UIRPNBE_S02_1| assetFilterShared     | on           |
And logged in with details of 'AU_UIRPNBE_S02'
And created 'C_UIRPNBE_S02' category
And shared next agencies for following categories:
| CategoryName  | AgencyName      |
| C_UIRPNBE_S02 | A_UIRPNBE_S02_2 |
When I login with details of 'U_UIRPNBE_S02_1'
Then I 'should' see email notification for 'Category sharing' with field to 'U_UIRPNBE_S02_1' and subject 'Collection has been shared with' contains following attributes:
| UserName1      | Agency          | UserName        | CategoryName  |
| AU_UIRPNBE_S02 | A_UIRPNBE_S02_1 | U_UIRPNBE_S02_1 | C_UIRPNBE_S02 |


Scenario: Check that after share category on BU in which for all user roles doesn't enabled inbox.read, users from this BU shouldn't recive email notification
Meta: @gdam
      @gdamemails
Given I created the agency 'A_UIRPNBE_S03_1' with default attributes
And created the agency 'A_UIRPNBE_S03_2' with default attributes
And created users with following fields:
| Email           | Role         | Agency          |
| AU_UIRPNBE_S03  | agency.admin | A_UIRPNBE_S03_1 |
| U_UIRPNBE_S03_1 | agency.admin | A_UIRPNBE_S03_2 |
| U_UIRPNBE_S03_2 | agency.user  | A_UIRPNBE_S03_2 |
| U_UIRPNBE_S03_3 | guest.user   | A_UIRPNBE_S03_2 |
And logged in with details of 'AU_UIRPNBE_S03'
And created 'C_UIRPNBE_S03' category
And shared next agencies for following categories:
| CategoryName  | AgencyName      |
| C_UIRPNBE_S03 | A_UIRPNBE_S03_2 |
When I login with details of 'U_UIRPNBE_S03_1'
Then I 'should not' see email notification for 'Category sharing' with field to 'U_UIRPNBE_S03_2' and subject 'Collection has been shared with' contains following attributes:
| UserName1      | Agency          | UserName        | CategoryName  |
| AU_UIRPNBE_S03 | A_UIRPNBE_S03_1 | U_UIRPNBE_S03_2 | C_UIRPNBE_S03 |
Then I 'should not' see email notification for 'Category sharing' with field to 'U_UIRPNBE_S03_3' and subject 'Collection has been shared with' contains following attributes:
| UserName1      | Agency          | UserName        | CategoryName  |
| AU_UIRPNBE_S03 | A_UIRPNBE_S03_1 | U_UIRPNBE_S03_3 | C_UIRPNBE_S03 |