!--NGN-1402
Feature:          Usage Rights - advanced search
Narrative:
In order to
As a              AgencyAdmin
I want to         check advanced search in categories by usage rights


Scenario: Check that Expiry in Days search criteria is absent in admin collection
Meta:@gdam
@library
Given I created 'C_URAS_S08' category
When I go to collection 'C_URAS_S08' on administration area collections page
Then I 'should not' see parameter in Usage Rights in category 'C_URAS_S08':
| UsageRight            | FilterKey      |
| Usage Rights - Expiry | Expire In Days |



Scenario: check that in advanced search results is displayed in library for collection with Usage Right criteteria 'Countries - Europe'
Meta:@gdam
@library
Given I created the agency 'A_URAS_S09' with default attributes
And created users with following fields:
| Email      | Role         | Agency     |Access|
| U_URAS_S09 | agency.admin | A_URAS_S09 |streamlined_library|
And logged in with details of 'U_URAS_S09'
And uploaded asset '/files/image10.jpg' into libraryNEWLIB
And uploaded asset '/files/image11.jpg' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add Usage Right 'Countries' for asset 'image10.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| Country | StartDate  | ExpirationDate |
| Europe  | 2 days ago | 2 days since   |
And add Usage Right 'Countries' for asset 'image11.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| Country     | StartDate  | ExpirationDate |
| Afghanistan | 2 days ago | 2 days since   |
And go to the Library page for collection 'My Assets'NEWLIB
And I click on filter link on Collection details for collection 'My Assets'NEWLIB
And I click expand Usage rights on current filter page
And I select 'Usage country' with value 'Europe' as filter collection 'My Assets'NEWLIB
And I add assets to 'sub' collection 'C_URAS_S09' from collection 'My Assets'NEWLIB
Then I 'should' see assets 'image10.jpg' in the collection 'C_URAS_S09'NEWLIB
Then I 'should not' see assets 'image11.jpg' in the collection 'C_URAS_S09'NEWLIB


Scenario: Check that applied advanced search criteria works for Usage Rights - Expiry
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         | Agency        |Access|
| <UserEmail> | agency.admin | DefaultAgency |streamlined_library|
And logged in with details of '<UserEmail>'
And uploaded following assetsNEWLIB:
| Name                        |
| /files/13DV-CAPITAL-10.mpg  |
| /files/GWGTestfile064v3.pdf |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And added Usage Right 'Countries' for asset '13DV-CAPITAL-10.mpg' for collection 'My Assets' with following fieldsNEWLIB:
| Country     | StartDate  | ExpirationDate |
| Afghanistan | 15.02.2010 | 02.02.2020     |
And added Usage Right 'General' for asset 'GWGTestfile064v3.pdf' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2010 | 02.02.2020     |
When I go to the Library page for collection 'My Assets'NEWLIB
And I click on filter link on Collection details for collection 'My Assets'NEWLIB
And I click expand Usage rights on current filter page
And I select usage rights date '<URFilterKey>' with value '<URFilterValue>' as filter collection 'My Assets'NEWLIB
And I add assets to 'sub' collection '<CollectionName>' from collection 'My Assets'NEWLIB
Then I 'should' see assets '<ExpectedAssetsTitles>' in the collection '<CollectionName>'NEWLIB
And I 'should' see asset count '<ExpectedAssetsCount>' in '<CollectionName>' NEWLIB

Examples:
| UserEmail     | CollectionName | URFilterKey                | URFilterValue| ExpectedAssetsCount | ExpectedAssetsTitles                     |
| U_URAS_S01_01 | C_URAS_S01_01  |  Usage Start Date          |02/15/10      | 1                   | 13DV-CAPITAL-10.mpg                      |
| U_URAS_S01_02 | C_URAS_S01_02  |  Usage End Date           |02/02/20    | 2                   | 13DV-CAPITAL-10.mpg,GWGTestfile064v3.pdf |




Scenario: Check that applied advanced search criteria works for Usage Rights - Countries
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         | Agency        |Access|
| <UserEmail> | agency.admin | DefaultAgency |streamlined_library|
And logged in with details of '<UserEmail>'
And uploaded following assetsNEWLIB:
| Name                        |
| /files/13DV-CAPITAL-10.mpg  |
| /files/test.mp3             |
| /files/128_shortname.jpg    |
| /files/video10s.avi         |
| /files/GWGTestfile064v3.pdf |
| /files/index.html           |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And added Usage Right 'Countries' for asset '13DV-CAPITAL-10.mpg' for collection 'My Assets' with following fieldsNEWLIB:
| Country     | StartDate  | ExpirationDate |
| Afghanistan | 15.02.2010 | 01.02.2020     |
And added Usage Right 'Countries' for asset 'test.mp3' for collection 'My Assets' with following fieldsNEWLIB:
| Country | StartDate  | ExpirationDate |
| Jordan  | 20.02.2010 | 02.02.2020     |
And added Usage Right 'Countries' for asset '128_shortname.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| Country     | StartDate  | ExpirationDate |
| Afghanistan | 20.02.2010 | 01.02.2020     |
And added Usage Right 'Countries' for asset 'video10s.avi' for collection 'My Assets' with following fieldsNEWLIB:
| Country | StartDate  | ExpirationDate |
| Jordan  | 15.02.2010 | 02.02.2020     |
And added Usage Right 'Countries' for asset 'GWGTestfile064v3.pdf' for collection 'My Assets' with following fieldsNEWLIB:
| Country | StartDate  | ExpirationDate |
| Jordan  | 15.02.2010 | 01.02.2020     |
And added Usage Right 'Countries' for asset 'index.html' for collection 'My Assets' with following fieldsNEWLIB:
| Country | StartDate  | ExpiresEveryDays |
| Lebanon | 20.02.2010 | 12               |
When I go to the Library page for collection 'My Assets'NEWLIB
And I click on filter link on Collection details for collection 'My Assets'NEWLIB
And I click expand Usage rights on current filter page
And I select 'Usage country' with value '<URFilterValue>' as filter collection 'My Assets'NEWLIB
And I add assets to 'sub' collection '<CollectionName>' from collection 'My Assets'NEWLIB
Then I 'should' see assets '<ExpectedAssetsTitles>' in the collection '<CollectionName>'NEWLIB
And I 'should' see asset count '<ExpectedAssetsCount>' in '<CollectionName>' NEWLIB

Examples:
| UserEmail     | CollectionName |  URFilterValue | ExpectedAssetsCount | ExpectedAssetsTitles                  |
| U_URAS_S02_01 | C_URAS_S02_01  |  Afghanistan   | 2                   | 13DV-CAPITAL-10.mpg,128_shortname.jpg |



Scenario: Check that applied advanced search criteria works for Usage Rights - Music
Meta:@skip
!--metadata fields for music not avialable in filter in new lib
Given I created users with following fields:
| Email       | Role         | Agency        |
| <UserEmail> | agency.admin | DefaultAgency |
And logged in with details of '<UserEmail>'
And uploaded following assets:
| Name                        |
| /files/13DV-CAPITAL-10.mpg  |
| /files/test.mp3             |
| /files/128_shortname.jpg    |
| /files/video10s.avi         |
| /files/GWGTestfile064v3.pdf |
| /files/index.html           |
And waited while transcoding is finished in collection 'My Assets'
And added Usage Right 'Music' for asset '13DV-CAPITAL-10.mpg' for collection 'My Assets' with following fields:
| ArtistName   | TrackTitle      | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel  | SubLabel        | PublicationPublisher | Arranger          | ISRCNumber | Duration | LicenseDetails  | ContactDetails   |
| Eric Cartman | the best song 1 | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel 11 | testSubLabel 11 | white penguin        | Gerald Broflovski | 123-ABC    | 111      | some details 11 | some contacts 11 |
And added Usage Right 'Music' for asset 'test.mp3' for collection 'My Assets' with following fields:
| ArtistName   | TrackTitle      | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel  | SubLabel        | PublicationPublisher | Arranger          | ISRCNumber | Duration | LicenseDetails  | ContactDetails   |
| Eric Cartman | the best song 2 | 20.02.2002 | 02.02.2020     | Sharon Marsh | 2           | testLabel 11 | testSubLabel 11 | white penguin        | Gerald Broflovski | 123-ABD    | 111      | some details 11 | some contacts 11 |
And added Usage Right 'Music' for asset '128_shortname.jpg' for collection 'My Assets' with following fields:
| ArtistName   | TrackTitle      | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel  | SubLabel        | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails  | ContactDetails   |
| Eric Cartman | the best song 3 | 20.02.2002 | 02.02.2020     | Sharon Marsh | 3           | testLabel 12 | testSubLabel 12 | white penguin        | Shelly Marsh | 123-ABE    | 111      | some details 12 | some contacts 12 |
And added Usage Right 'Music' for asset 'video10s.avi' for collection 'My Assets' with following fields:
| ArtistName  | TrackTitle      | StartDate  | ExpirationDate | Composer      | TrackNumber | RecordLabel  | SubLabel        | PublicationPublisher | Arranger          | ISRCNumber | Duration | LicenseDetails  | ContactDetails   |
| Randy Marsh | the best song 4 | 20.02.2002 | 02.02.2020     | Liane Cartman | 1           | testLabel 21 | testSubLabel 21 | black penguin        | Gerald Broflovski | 123-ABF    | 111      | some details 21 | some contacts 21 |
And added Usage Right 'Music' for asset 'GWGTestfile064v3.pdf' for collection 'My Assets' with following fields:
| ArtistName  | TrackTitle      | StartDate  | ExpirationDate | Composer      | TrackNumber | RecordLabel  | SubLabel        | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails  | ContactDetails   |
| Randy Marsh | the best song 5 | 20.02.2002 | 02.02.2020     | Liane Cartman | 2           | testLabel 22 | testSubLabel 22 | black penguin        | Shelly Marsh | 123-ABG    | 111      | some details 22 | some contacts 22 |
And added Usage Right 'Music' for asset 'index.html' for collection 'My Assets' with following fields:
| ArtistName  | TrackTitle      | StartDate  | ExpirationDate | Composer      | TrackNumber | RecordLabel  | SubLabel        | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails  | ContactDetails   |
| Randy Marsh | the best song 6 | 20.02.2002 | 02.02.2020     | Liane Cartman | 3           | testLabel 22 | testSubLabel 22 | black penguin        | Shelly Marsh | 123-ABH    | 111      | some details 22 | some contacts 22 |
When I create collection '<ConnectionName>' based on category 'My Assets' with following usage rights metadata:
| UsageRight           | FilterKey     | FilterValue     |
| Usage Rights - Music | <URFilterKey> | <URFilterValue> |
Then I 'should' see asset count '<ExpectedAssetsCount>' on opened Library page
And 'should' see assets with titles '<ExpectedAssetsTitles>' in the current collection

Examples:
| UserEmail     | ConnectionName | URFilterKey           | URFilterValue     | ExpectedAssetsCount | ExpectedAssetsTitles                           |
| U_URAS_S03_01 | C_URAS_S03_01  | Arranger              | Gerald Broflovski | 3                   | 13DV-CAPITAL-10.mpg,test.mp3,video10s.avi      |
| U_URAS_S03_02 | C_URAS_S03_02  | Artist                | Eric Cartman      | 3                   | 13DV-CAPITAL-10.mpg,test.mp3,128_shortname.jpg |
| U_URAS_S03_03 | C_URAS_S03_03  | Composer              | Liane Cartman     | 3                   | video10s.avi,GWGTestfile064v3.pdf,index.html   |
| U_URAS_S03_04 | C_URAS_S03_04  | Contact Details       | some contacts 21  | 1                   | video10s.avi                                   |
| U_URAS_S03_05 | C_URAS_S03_05  | ISRC Number           | 123-ABG           | 1                   | GWGTestfile064v3.pdf                           |
| U_URAS_S03_06 | C_URAS_S03_06  | License Details       | some details 12   | 1                   | 128_shortname.jpg                              |
| U_URAS_S03_07 | C_URAS_S03_07  | Publication Publisher | white penguin     | 3                   | 13DV-CAPITAL-10.mpg,test.mp3,128_shortname.jpg |
| U_URAS_S03_08 | C_URAS_S03_08  | Record Label          | testLabel 11      | 2                   | 13DV-CAPITAL-10.mpg,test.mp3                   |
| U_URAS_S03_09 | C_URAS_S03_09  | Sub Label             | testSubLabel 11   | 2                   | 13DV-CAPITAL-10.mpg,test.mp3                   |
| U_URAS_S03_10 | C_URAS_S03_10  | Track Number          | 2                 | 2                   | test.mp3,GWGTestfile064v3.pdf                  |
| U_URAS_S03_11 | C_URAS_S03_11  | Track Title           | the best song 4   | 1                   | video10s.avi                                   |


Scenario: Check that applied advanced search criteria works for Usage Rights - Visual Talent
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         | Agency        |Access|
| <UserEmail> | agency.admin | DefaultAgency |streamlined_library|
And logged in with details of '<UserEmail>'
And uploaded following assetsNEWLIB:
| Name                        |
| /files/13DV-CAPITAL-10.mpg  |
| /files/128_shortname.jpg    |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And added Usage Right 'Visual Talent' for asset '13DV-CAPITAL-10.mpg' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName | Role     | StartDate  | ExpirationDate |
| Stan Marsh | Producer | 20.02.2002 | 02.02.2020     |
And added Usage Right 'Visual Talent' for asset '128_shortname.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName        | Role   | StartDate  | ExpirationDate |
| Gerald Broflovski | Lawyer | 20.02.2002 | 02.02.2020     |
When I go to the Library page for collection 'My Assets'NEWLIB
And I click on filter link on Collection details for collection 'My Assets'NEWLIB
And I click expand Usage rights on current filter page
And I wait for '2' seconds
And I select '<URFilterKey>' with value '<URFilterValue>' as filter collection 'My Assets'NEWLIB
And I wait for '2' seconds
And I add assets to 'sub' collection '<CollectionName>' from collection 'My Assets'NEWLIB
Then I 'should' see assets '<ExpectedAssetsTitles>' in the collection '<CollectionName>'NEWLIB
And I 'should' see asset count '<ExpectedAssetsCount>' in '<CollectionName>' NEWLIB

Examples:
| UserEmail     | CollectionName | URFilterKey | URFilterValue     | ExpectedAssetsCount | ExpectedAssetsTitles                                  |
| U_URAS_S04_01 | C_URAS_S04_01  | Visual Talent | Gerald Broflovski | 1                   | 128_shortname.jpg                                     |


Scenario: Check that applied advanced search criteria works for Usage Rights - Voice Over Artist
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role         | Agency        |Access|
| <UserEmail> | agency.admin | DefaultAgency |streamlined_library|
And logged in with details of '<UserEmail>'
And uploaded following assetsNEWLIB:
| Name                        |
| /files/128_shortname.jpg    |
| /files/video10s.avi         |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And added Usage Right 'Voice-over Artist' for asset '128_shortname.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate | BaseFee | Agent             | AgentTel  | Email             | Union         | MoreInfo     |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     | 0.0769% | Gerald Broflovski | 555-32-11 | gerald-b@mail.com | test union 11 | some info 11 |
And added Usage Right 'Voice-over Artist' for asset 'video10s.avi' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName   | Role   | StartDate  | ExpirationDate | BaseFee | Agent        | AgentTel  | Email           | Union         | MoreInfo     |
| Shelly Marsh | Artist | 20.02.2002 | 02.02.2020     | 0.0056% | Eric Cartman | 555-33-80 | eric-c@mail.com | test union 33 | some info 33 |
When I go to the Library page for collection 'My Assets'NEWLIB
And I click on filter link on Collection details for collection 'My Assets'NEWLIB
And I click expand Usage rights on current filter page
And I wait for '1' seconds
And I select '<URFilterKey>' with value '<URFilterValue>' as filter collection 'My Assets'NEWLIB
And I add assets to 'sub' collection '<CollectionName>' from collection 'My Assets'NEWLIB
Then I 'should' see assets '<ExpectedAssetsTitles>' in the collection '<CollectionName>'NEWLIB
And I 'should' see asset count '<ExpectedAssetsCount>' in '<CollectionName>' NEWLIB

Examples:
| UserEmail     | CollectionName | URFilterKey          | URFilterValue     | ExpectedAssetsCount | ExpectedAssetsTitles                   |
| U_URAS_S05_03 | C_URAS_S05_03  | Voice-over Artist     | Shelly Marsh      | 1                   | video10s.avi                           |


Scenario: Check that applied advanced search criteria works for Usage Rights - Other Usage
Meta:@skip
!--metadata for other usage not avaialable in filter in new lib
Given I created users with following fields:
| Email       | Role         | Agency        |
| <UserEmail> | agency.admin | DefaultAgency |
And logged in with details of '<UserEmail>'
And uploaded following assets:
| Name                        |
| /files/13DV-CAPITAL-10.mpg  |
| /files/test.mp3             |
| /files/128_shortname.jpg    |
| /files/video10s.avi         |
| /files/GWGTestfile064v3.pdf |
| /files/index.html           |
And waited while transcoding is finished in collection 'My Assets'
And added Usage Right 'Other usage' for asset '13DV-CAPITAL-10.mpg' for collection 'My Assets' with following fields:
| Comment        |
| URC_URAS_S06_1 |
And added Usage Right 'Other usage' for asset 'test.mp3' for collection 'My Assets' with following fields:
| Comment        |
| URC_URAS_S06_2 |
And added Usage Right 'Other usage' for asset 'video10s.avi' for collection 'My Assets' with following fields:
| Comment        |
| URC_URAS_S06_3 |
And added Usage Right 'Other usage' for asset 'GWGTestfile064v3.pdf' for collection 'My Assets' with following fields:
| Comment        |
| URC_URAS_S06_4 |
And added Usage Right 'Other usage' for asset 'index.html' for collection 'My Assets' with following fields:
| Comment        |
| URC_URAS_S06_1 |
When I create collection '<ConnectionName>' based on category 'My Assets' with following usage rights metadata:
| UsageRight                 | FilterKey     | FilterValue     |
| Usage Rights - Other Usage | <URFilterKey> | <URFilterValue> |
Then I 'should' see asset count '<ExpectedAssetsCount>' on opened Library page
And 'should' see assets with titles '<ExpectedAssetsTitles>' in the current collection

Examples:
| UserEmail     | ConnectionName | URFilterKey | URFilterValue  | ExpectedAssetsCount | ExpectedAssetsTitles           |
| U_URAS_S06_01 | C_URAS_S06_01  | Comment     | URC_URAS_S06_1 | 2                   | 13DV-CAPITAL-10.mpg,index.html |


Scenario: Check that in advanced search results is displayed proper expired assets that covered the criterion Expire in days (Expire Date) (Expire Rage)
Meta:@skip
!--Expire in days(expire period) not implemented for Voice-over Artist in new lib
Given I created users with following fields:
| Email       | Role         | Agency        |
| <UserEmail> | agency.admin | DefaultAgency |
And logged in with details of '<UserEmail>'
And uploaded following assets:
| Name                        |
| /files/13DV-CAPITAL-10.mpg  |
| /files/test.mp3             |
| /files/128_shortname.jpg    |
| /files/video10s.avi         |
| /files/GWGTestfile064v3.pdf |
| /files/index.html           |
And waited while transcoding is finished in collection 'My Assets'
And added Usage Right 'Countries' for asset '13DV-CAPITAL-10.mpg' for collection 'My Assets' with following fields:
| Country     | StartDate  | ExpirationDate |
| Afghanistan | 15.02.2010 | 02.02.2020     |
And added Usage Right 'General' for asset 'GWGTestfile064v3.pdf' for collection 'My Assets' with following fields:
| StartDate  | ExpirationDate |
| 20.02.2010 | 02.02.2020     |
And added Usage Right 'Voice-over Artist' for asset 'index.html' for collection 'My Assets' with following fields:
| ArtistName   | Role   | StartDate | ExpiresEveryDays |
| Eric Cartman | Artist | Today     | 12               |
When I created filter based on category 'My Assets' with following usage rights metadata:
| UsageRight            | FilterKey     | FilterValue     |
| Usage Rights - Expiry | <URFilterKey> | <URFilterValue> |
Then I 'should' see asset count '<ExpectedAssetsCount>' on opened Library page
And 'should' see assets with titles '<ExpectedAssetsTitles>' in the current collection

Examples:
| UserEmail    | ConnectionName | URFilterKey    | URFilterValue | ExpectedAssetsCount | ExpectedAssetsTitles                     |
| U_URAS_S07_1 | C_URAS_S07_1   | Start Date     | 15.02.2010    | 1                   | 13DV-CAPITAL-10.mpg                      |
| U_URAS_S07_2 | C_URAS_S07_2   | Expire Date    | 02.02.2020    | 2                   | 13DV-CAPITAL-10.mpg,GWGTestfile064v3.pdf |
| U_URAS_S07_3 | C_URAS_S07_3   | Expire In Days | 15            | 1                   | index.html                               |


Scenario: check that in advanced search results is displayed proper in library for Usage Right criteteria 'Countries - Europe'
Meta:@gdam
@library
Given I created the agency 'A_URAS_S08' with default attributes
And created users with following fields:
| Email      | Role         | Agency     |Access|
| U_URAS_S08 | agency.admin | A_URAS_S08 |streamlined_library|
And logged in with details of 'U_URAS_S08'
And uploaded asset '/files/image10.jpg' into libraryNEWLIB
And uploaded asset '/files/image11.jpg' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add Usage Right 'Countries' for asset 'image10.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| Country | StartDate  | ExpirationDate |
| Europe  | 2 days ago | 2 days since   |
And add Usage Right 'Countries' for asset 'image11.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| Country     | StartDate  | ExpirationDate |
| Afghanistan | 2 days ago | 2 days since   |
And I go to the Library page for collection 'My Assets'NEWLIB
And I click on filter link on Collection details for collection 'My Assets'NEWLIB
And I click expand Usage rights on current filter page
And I select 'Usage country' with value 'Europe' as filter collection 'My Assets'NEWLIB
Then I 'should' see assets 'image10.jpg' in the collection 'My Assets'NEWLIB
Then I 'should not' see assets 'image11.jpg' in the collection 'My Assets'NEWLIB



Scenario: Check that Assets with added UR could be visible in advanced search by Usage country filters from library assets
Meta:@gdam
@library
Given I created the following agency:
| Name         |
| A_LPTG_S08 |
And created users with following fields:
| Email        | Role         | Agency     |Access|
| U_LPTG_S07_3 | agency.admin | A_LPTG_S08 |streamlined_library|
And logged in with details of 'U_LPTG_S07_3'
And I am on the Library page for collection 'My Assets'NEWLIB
And I uploaded file '/files/image10.jpg' into my libraryNEWLIB
And I uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And I uploaded file '/files/audio01.mp3' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
And selected asset 'image10.jpg,Fish1-Ad.mov,audio01.mp3' in the 'My Assets' library pageNEWLIB
When I open Add Usage Rights Popup from collection 'My Assets' pageNEWLIB
And I add batch Usage Right 'Countries' with following fields on opened asset Usage Rights page from collection 'My Assets'NEWLIB:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |
And go to the Library page for collection 'Everything'NEWLIB
And I click expand Usage rights on current filter page
And I select 'Usage country' with value 'Antarctica' as filter collection 'Everything'NEWLIB
And I add assets to 'new' collection 'C_LPTG_S07' from collection 'Everything'NEWLIB
Then I 'should' see assets 'image10.jpg,Fish1-Ad.mov,audio01.mp3' in the collection 'C_LPTG_S07'NEWLIB
And I 'should' see asset count '3' in 'C_LPTG_S07' NEWLIB


Scenario: Check that applied advanced search criteria works for Usage Rights start and end date from library assets
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
And uploaded following assetsNEWLIB:
| Name                        |
| /files/13DV-CAPITAL-10.mpg  |
| /files/GWGTestfile064v3.pdf |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And added Usage Right 'Countries' for asset '13DV-CAPITAL-10.mpg' for collection 'My Assets' with following fieldsNEWLIB:
| Country     | StartDate  | ExpirationDate |
| Afghanistan | 15.02.2010 | 17.02.2020     |
And added Usage Right 'General' for asset 'GWGTestfile064v3.pdf' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2010 | 17.02.2020     |
When I go to the Library page for collection 'Everything'NEWLIB
And I click expand Usage rights on current filter page
And I wait for '2' seconds
And I select usage rights date '<URFilterKey>' with value '<URFilterValue>' as filter collection 'Everything'NEWLIB
And I wait for '2' seconds
And I add assets to 'new' collection '<CollectionName>' from collection 'Everything'NEWLIB
Then I 'should' see assets '<ExpectedAssetsTitles>' in the collection '<CollectionName>'NEWLIB
And I 'should' see asset count '<ExpectedAssetsCount>' in '<CollectionName>' NEWLIB

Examples:
| UserEmail     | CollectionName | URFilterKey                | URFilterValue| ExpectedAssetsCount | ExpectedAssetsTitles                     |
| U_URAS_S01_01 | C_URAS_S01_01  |  Usage Start Date          |02/15/10      | 1                   | 13DV-CAPITAL-10.mpg                      |
| U_URAS_S01_02 | C_URAS_S01_02  |  Usage End Date           |02/17/20    | 2                   | 13DV-CAPITAL-10.mpg,GWGTestfile064v3.pdf |

Scenario: Check that applied advanced search criteria works for Usage Rights - Visual Talent from library assets page
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
And uploaded following assetsNEWLIB:
| Name                        |
| /files/13DV-CAPITAL-10.mpg  |
| /files/128_shortname.jpg    |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And added Usage Right 'Visual Talent' for asset '13DV-CAPITAL-10.mpg' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName | Role     | StartDate  | ExpirationDate |
| Stan Marsh | Producer | 20.02.2002 | 02.02.2020     |
And added Usage Right 'Visual Talent' for asset '128_shortname.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName        | Role   | StartDate  | ExpirationDate |
| Gerald Broflovski | Lawyer | 20.02.2002 | 02.02.2020     |
When I go to the Library page for collection 'Everything'NEWLIB
And I click expand Usage rights on current filter page
And I wait for '1' seconds
And I select '<URFilterKey>' with value '<URFilterValue>' as filter collection 'Everything'NEWLIB
And I add assets to 'new' collection '<CollectionName>' from collection 'Everything'NEWLIB
Then I 'should' see assets '<ExpectedAssetsTitles>' in the collection '<CollectionName>'NEWLIB
And I 'should' see asset count '<ExpectedAssetsCount>' in '<CollectionName>' NEWLIB

Examples:
| UserEmail     | CollectionName | URFilterKey | URFilterValue     | ExpectedAssetsCount | ExpectedAssetsTitles                                  |
| U_URAS_S04_01 | C_URAS_S04_01  | Visual Talent | Gerald Broflovski | 1                   | 128_shortname.jpg                                     |

Scenario: Check that applied advanced search criteria works for Usage Rights - Voice Over Artist from library assets page
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
And uploaded following assetsNEWLIB:
| Name                        |
| /files/128_shortname.jpg    |
| /files/video10s.avi         |
And waited while preview is visible on library page for collection 'My Assets' for assets '128_shortname.jpg,video10s.avi'NEWLIB
And added Usage Right 'Voice-over Artist' for asset '128_shortname.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate | BaseFee | Agent             | AgentTel  | Email             | Union         | MoreInfo     |
|  Kate Winslet | Manager | 20.02.2002 | 02.02.2020     | 0.0769% | Gerald Broflovski | 555-32-11 | gerald-b@mail.com | test union 11 | some info 11 |
And added Usage Right 'Voice-over Artist' for asset 'video10s.avi' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName   | Role   | StartDate  | ExpirationDate | BaseFee | Agent        | AgentTel  | Email           | Union         | MoreInfo     |
| Sandra Bullock | Artist | 20.02.2002 | 02.02.2020     | 0.0056% | Eric Cartman | 555-33-80 | eric-c@mail.com | test union 33 | some info 33 |
When I go to the Library page for collection 'Everything'NEWLIB
And I click expand Usage rights on current filter page
And I wait for '1' seconds
And I select '<URFilterKey>' with value '<URFilterValue>' as filter collection 'Everything'NEWLIB
And I add assets to 'new' collection '<CollectionName>' from collection 'Everything'NEWLIB
Then I 'should' see assets '<ExpectedAssetsTitles>' in the collection '<CollectionName>'NEWLIB
And I 'should' see asset count '<ExpectedAssetsCount>' in '<CollectionName>' NEWLIB

Examples:
| UserEmail     | CollectionName | URFilterKey          | URFilterValue     | ExpectedAssetsCount | ExpectedAssetsTitles                   |
| U_URAS_S05_03 | C_URAS_S05_03  | Voice-over Artist     | Sandra Bullock      | 1                   | video10s.avi                           |

