!--NGN-10472
Feature:          Usage Rights - metadata fields
Narrative:
In order to
As a              AgencyAdmin
I want to         Check usage rights metadata fields

Scenario: Check that file usage rights fields 'Start Date' and 'Expire Date' are mandatory for 'General' usage type
Meta:@gdam
@projects
Given I created 'P_URMD_S01' project
And created '/F_URMD_S01' folder for project 'P_URMD_S01'
And uploaded '/files/128_shortname.jpg' file into '/F_URMD_S01' folder for 'P_URMD_S01' project
And waited while transcoding is finished in folder '/F_URMD_S01' on project 'P_URMD_S01' files page
When I add 'General' usage rule with following fields on file '128_shortname.jpg' and folder '/F_URMD_S01' and project 'P_URMD_S01' Usage Rights page:
| StartDate | ExpirationDate |
|           |                |
Then I 'should' see fields 'StartDate,ExpirationDate' are marked as red on opened Usage Information popup


Scenario: Check that asset usage rights fields 'Country', 'Start Date' and 'Expire Date' are mandatory for 'Countries' usage type
Meta: @skip
      @gdam
!--10/08/2015 : Confirmed with Maria that this is a known issue and as per Maria this is expensive to fix at the moment and can be skipped
Given I created users with following fields:
| Email      | Role         |
| U_URMD_S02 | agency.admin |
And logged in with details of 'U_URMD_S02'
And uploaded file '/files/128_shortname.jpg' into my library
And waited while transcoding is finished in collection 'My Assets'
When I add Usage Right 'Countries' for asset '128_shortname.jpg' for collection 'My Assets' with following fields:
| Country | StartDate | ExpirationDate |
|         |           |                |
Then I 'should' see fields 'Country,StartDate,ExpirationDate' are marked as red on opened Usage Information popup


Scenario: Check that file usage rights fields 'Artist Name', 'Artist Role', 'Start Date' and 'Expire Date' are mandatory for 'Visual Talent' usage type
Meta:@gdam
@projects
Given I created 'P_URMD_S03' project
And created '/F_URMD_S03' folder for project 'P_URMD_S03'
And uploaded '/files/128_shortname.jpg' file into '/F_URMD_S03' folder for 'P_URMD_S03' project
And waited while transcoding is finished in folder '/F_URMD_S03' on project 'P_URMD_S03' files page
When I add 'Visual Talent' usage rule with following fields on file '128_shortname.jpg' and folder '/F_URMD_S03' and project 'P_URMD_S03' Usage Rights page:
| ArtistName | Role | StartDate | ExpirationDate |
|            |      |           |                |
Then I 'should' see fields 'ArtistName,Role,StartDate,ExpirationDate' are marked as red on opened Usage Information popup


Scenario: Check that asset usage rights fields 'Artist Name', 'Role', 'Start Date' and 'Expire Date' are mandatory for 'Voice-over Artist' usage type
Meta:@gdam
@library
Given I created users with following fields:
| Email      | Role         |Access|
| U_URMD_S04 | agency.admin |streamlined_library|
And logged in with details of 'U_URMD_S04'
And uploaded file '/files/128_shortname.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add Usage Right 'Voice-over Artist' for asset '128_shortname.jpg' for collection 'My Assets' with following fieldsNEWLIB:
|ClickSave| ArtistName | Role | StartDate | ExpirationDate | BaseFee | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
|false    |  |      |           |                | 10%     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
Then I 'should' see save button disabled on opened edit usage rights popupNEWLIB


Scenario: Check that file usage rights fields 'Artist', 'Track Title', 'Start Date' and 'Expire Date' are mandatory for 'Music' usage type
Meta:@gdam
@projects
Given I created 'P_URMD_S05' project
And created '/F_URMD_S05' folder for project 'P_URMD_S05'
And uploaded '/files/128_shortname.jpg' file into '/F_URMD_S05' folder for 'P_URMD_S05' project
And waited while transcoding is finished in folder '/F_URMD_S05' on project 'P_URMD_S05' files page
When I add 'Music' usage rule with following fields on file '128_shortname.jpg' and folder '/F_URMD_S05' and project 'P_URMD_S05' Usage Rights page:
| ArtistName | TrackTitle | StartDate | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
|            |            |           |                | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
Then I 'should' see fields 'Artist,TrackTitle' are marked as red on opened Usage Information popup


Scenario: Check that file usage rights field 'Expire in days' is mandatory for usage types with this field
Meta:@gdam
@projects
Given I created '<ProjectName>' project
And created '/F_URMD_S06' folder for project '<ProjectName>'
And uploaded '/files/128_shortname.jpg' file into '/F_URMD_S06' folder for '<ProjectName>' project
And waited while transcoding is finished in folder '/F_URMD_S06' on project '<ProjectName>' files page
When I add '<UsageRuleName>' usage rule with following fields on file '128_shortname.jpg' and folder '/F_URMD_S06' and project '<ProjectName>' Usage Rights page:
| StartDate  | ExpiresEveryDays | Country    | Role         | ArtistName  | TrackTitle    | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails | Role    | BaseFee | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| 02.02.2002 |                  | Antarctica | neutral role | Randy Marsh | the best song | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  | Manager | 10%     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
Then I 'should' see fields 'ExpiresEveryDays' are marked as red on opened Usage Information popup

Examples:
| ProjectName  | UsageRuleName     |
| P_URMD_S06_1 | General           |
| P_URMD_S06_2 | Countries         |
| P_URMD_S06_3 | Visual Talent     |
| P_URMD_S06_4 | Voice-over Artist |



Scenario: Check that asset usage rights notification settings fields are common for all usage types
Meta:@gdam
@library
Given I uploaded file '/files/128_shortname.jpg' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset '128_shortname.jpg' usage rights page in Library for collection 'My Assets'NEWLIB
Then I '<Should>' see notification settings fields area for usage rule '<UsageRuleName>' on Usage Information popupNEWLIB

Examples:
| UsageRuleName     | Should     |
| General           | should     |
| Countries         | should     |
| Media Types       | should not |
| Visual Talent     | should     |
| Voice-over Artist | should     |
| Music             | should     |
| Other usage       | should not |


Scenario: Check that you can select multiple countries for 'Countries' usage rights
Meta:@gdam
@library
Given I created users with following fields:
| Email      | Role         |Access|
| U_URMD_S09 | agency.admin |streamlined_library|
And logged in with details of 'U_URMD_S09'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add Usage Right 'Countries' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| Country                    | StartDate  | ExpirationDate |
| Ukraine,Russian Federation | 02.02.2002 | 20.02.2002     |
Then I 'should' see following data for usage type 'Countries' on opened asset Usage Rights pageNEWLIB:
| Country | StartDate  | ExpirationDate |
| Ukraine | 02.02.2002 | 20.02.2002     |
And I 'should' see following data for usage type 'Countries' on opened asset Usage Rights pageNEWLIB:
| Country            | StartDate  | ExpirationDate |
| Russian Federation | 02.02.2002 | 20.02.2002     |




Scenario: Check that edit is individual for each country after multiple adding
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         |Access|
| U_URMD_S010 | agency.admin |streamlined_library|
And logged in with details of 'U_URMD_S010'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add Usage Right 'Countries' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| Country                    | StartDate  | ExpirationDate |
| Ukraine,Russian Federation | 02.02.2002 | 20.02.2002     |
Then I should see following count '2' of edit forms for 'Countries' on opened usage rights pageNEWLIB


Scenario: Check adding multiple countries on batch update Usage Rights form (files in folder)
Meta:@gdam
@projects
Given I created 'P_UMRD_S11' project
And created '/F_URMD_S11' folder for project 'P_UMRD_S11'
And uploaded '/files/128_shortname.jpg' file into '/F_URMD_S11' folder for 'P_UMRD_S11' project
And uploaded '/files/Fish Ad.mov' file into '/F_URMD_S11' folder for 'P_UMRD_S11' project
And waited while transcoding is finished in folder '/F_URMD_S11' on project 'P_UMRD_S11' files page
And selected files on project files page:
| FileName          |
| 128_shortname.jpg |
| Fish Ad.mov       |
When I add Batch Usage Right 'Countries' with following fields on opened Edit Usage Rights pop-up from project folder page:
| Country                    | StartDate  | ExpirationDate |
| Ukraine,Germany            | 02.02.2014 | 20.02.2015     |
And refresh the page
Then I 'should' see 'Countries' usage rule with following fields on file '128_shortname.jpg' and folder '/F_URMD_S11' and project 'P_UMRD_S11' Usage Rights page:
| Country | StartDate  | ExpirationDate |
| Ukraine | 02.02.2014 | 20.02.2015     |
And I 'should' see 'Countries' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_URMD_S11' and project 'P_UMRD_S11' Usage Rights page:
| Country | StartDate  | ExpirationDate |
| Germany | 02.02.2014 | 20.02.2015     |

Scenario: Check that asset is shown with usage indicator when usage rights has not started yet
Meta:@gdam
@library
Given logged in with details of 'AgencyAdmin'
And uploaded file '/files/128_shortname.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add Usage Right 'General' for asset '128_shortname.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| tomorrow | 20.02.2024     |
Then I 'should' see usage expired text 'Usage rights expired or not yet started' on opened asset usage rights pageNEWLIB
When I go to the Library page for collection 'My Assets'NEWLIB
Then I 'should' see usage rights indicator type 'not yet started' for asset '128_shortname.jpg' in collection 'My Assets'NEWLIB

Scenario: Check that asset is shown with usage indicator when usage rights are in use on list view
Meta:@gdam
@library
Given logged in with details of 'AgencyAdmin'
And uploaded file '/files/logo1.gif' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add Usage Right 'General' for asset 'logo1.gif' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 2 days ago | 2 days since     |
When I go to the Library page for collection 'My Assets'NEWLIB
Then I 'should' see usage rights indicator type 'Available for Use' for asset 'logo1.gif' in collection 'My Assets'NEWLIB
When I switch to 'list' view from the collection 'My Assets' pageNEWLIB
Then I 'should' see usage rights indicator type 'Available for Use' for asset 'logo1.gif' in collection 'My Assets' on list viewNEWLIB

Scenario: Check that asset is shown with usage indicator when usage rights has already expired
Meta:@gdam
@library
Given logged in with details of 'AgencyAdmin'
And uploaded file '/files/logo2.png' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add Usage Right 'General' for asset 'logo2.png' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 12.12.2012     |
Then I 'should' see usage expired text 'Usage rights expired or not yet started' on opened asset usage rights pageNEWLIB
When I go to the Library page for collection 'My Assets'NEWLIB
Then I 'should' see usage rights indicator type 'expired' for asset 'logo2.png' in collection 'My Assets'NEWLIB


Scenario: Check that asset is shown with usage rights text on all tabs(asset info,Relationship,attachemnts,Usage rights)
Meta:@gdam
@library
Given logged in with details of 'AgencyAdmin'
And uploaded file '/files/logo3.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add Usage Right 'General' for asset 'logo3.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| tomorrow | 20.02.2024     |
When I go to asset 'logo3.jpg' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see usage expired text 'Usage rights expired or not yet started' on opened asset info pageNEWLIB
When I go to asset 'logo3.jpg' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see usage expired text 'Usage rights expired or not yet started' on opened asset activity pageNEWLIB
When go to asset 'logo3.jpg' info page in Library for collection 'My Assets' on attachment assets pageNEWLIB
Then I 'should' see usage expired text 'Usage rights expired or not yet started' on opened asset attachment pageNEWLIB
When I go to asset 'logo3.jpg' related projects info page in Library for collection 'My Assets' NEWLIB
Then I 'should' see usage expired text 'Usage rights expired or not yet started' on opened asset related project pageNEWLIB