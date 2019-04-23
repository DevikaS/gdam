!--NGN-2959 NGN-1402 NGN-8320
Feature:          Usage Rights - saving one after actions on files and assets
Narrative:
In order to
As a              AgencyAdmin
I want to         Check usage rights for files

Scenario: check saving of usage rigth for file moved from library
Meta:@gdam
@library
Given I created users with following fields:
| Email         | Role         |Access|
| U_URSAAFA_S01 | agency.admin |streamlined_library,folders|
And logged in with details of 'U_URSAAFA_S01'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I added Usage Right 'Music' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
And created 'P_URSAAFA_S01' project
And created '/F_URSAAFA_S01' folder for project 'P_URSAAFA_S01'
When I add following asset 'Fish Ad.mov' of collection 'My Assets' to project 'P_URSAAFA_S01' folder '/F_URSAAFA_S01'NEWLIB
Then I 'should' see 'Music' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_URSAAFA_S01' and project 'P_URSAAFA_S01' Usage Rights page:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |




Scenario: check saving of usage rigth for new file version
Meta:@gdam
@projects
Given I created 'P_URSAAFA_S03' project
And created '/F_URSAAFA_S03' folder for project 'P_URSAAFA_S03'
And uploaded '/files/Fish Ad.mov' file into '/F_URSAAFA_S03' folder for 'P_URSAAFA_S03' project
And waited while transcoding is finished in folder '/F_URSAAFA_S03' on project 'P_URSAAFA_S03' files page
And added 'Music' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_URSAAFA_S03' and project 'P_URSAAFA_S03' Usage Rights page:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
When I upload new file version '/files/Fish1-Ad.mov' for file 'Fish Ad.mov' into '/F_URSAAFA_S03' folder for 'P_URSAAFA_S03' project
And refresh the page
Then I 'should' see 'Music' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_URSAAFA_S03' and project 'P_URSAAFA_S03' Usage Rights page:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |



Scenario: check saving of usage rigth for asset restored from trash
Meta:@gdam
@library
Given I created users with following fields:
| Email         | Role         |Access|
| U_URSAAFA_S02 | agency.admin |streamlined_library|
And logged in with details of 'U_URSAAFA_S02'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And added Usage Right 'Music' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
And on the library page for collection 'My Assets'NEWLIB
And selected asset 'Fish Ad.mov' in the 'My Assets' library pageNEWLIB
And I removed asset in 'My Assets' library page
When I restore assets 'Fish Ad.mov' from library trash pageNEWLIB
Then I 'should' see following data for usage type 'Music' on asset 'Fish Ad.mov' usage rights page for collection 'My Assets'NEWLIB:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |


Scenario: check saving of usage rigth for asset moved from project
Meta:@gdam
@projects
Given I created users with following fields:
| Email         | Role         |Access|
| U_URSAAFA_S04 | agency.admin |streamlined_library,folders|
And logged in with details of 'U_URSAAFA_S04'
And created 'P_URSAAFA_S04' project
And created '/F_URSAAFA_S04' folder for project 'P_URSAAFA_S04'
And uploaded '/files/Fish Ad.mov' file into '/F_URSAAFA_S04' folder for 'P_URSAAFA_S04' project
And waited while transcoding is finished in folder '/F_URSAAFA_S04' on project 'P_URSAAFA_S04' files page
And added 'Music' usage rule with following fields on file 'Fish Ad.mov' and folder '/F_URSAAFA_S04' and project 'P_URSAAFA_S04' Usage Rights page:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
When I move file 'Fish Ad.mov' from project 'P_URSAAFA_S04' folder '/F_URSAAFA_S04' to new library page
Then I 'should' see following data for usage type 'Music' on asset 'Fish Ad.mov' usage rights page for collection 'My Assets'NEWLIB:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
