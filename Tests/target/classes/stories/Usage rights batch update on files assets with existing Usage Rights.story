Feature:             Usage rights batch update on files assets with existing Usage Rights
Narrative:
In order to
As a                 AgencyAdmin
I want to            Usage rights batch update on files assets with existing Usage Rights


Scenario: Check that if user is adding Music AND Music already exists on file, Music will be added
Meta:@gdam
@projects
Given I created the following agency:
| Name         |
| A_LPTG_S07_4 |
And created users with following fields:
| Email        | Role         | Agency     |
| U_LPTG_S07_5 | agency.admin | A_LPTG_S07_4 |
And logged in with details of 'U_LPTG_S07_5'
And created 'P_LPTG_S01' project
And created '/F1' folder for project 'P_LPTG_S01'
And uploaded '/files/image10.jpg' file into '/F1' folder for 'P_LPTG_S01' project
And uploaded '/files/Fish1-Ad.mov' file into '/F1' folder for 'P_LPTG_S01' project
And uploaded '/files/audio01.mp3' file into '/F1' folder for 'P_LPTG_S01' project
And waited while preview is available in folder '/F1' on project 'P_LPTG_S01' files page
And selected files on project files page:
| FileName    |
| image10.jpg |
| Fish1-Ad.mov|
| audio01.mp3 |
And added Batch Usage Right 'Music' with following fields on opened Edit Usage Rights pop-up from project folder page:
| ArtistName  | TrackTitle      | StartDate  | ExpirationDate | Composer      | TrackNumber | RecordLabel  | SubLabel        | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails  | ContactDetails   |
| Randy Marsh | the best song 6 | 20.02.2002 | 02.02.2020     | Liane Cartman | 3           | testLabel 22 | testSubLabel 22 | black penguin        | Shelly Marsh | 123-ABH    | 111      | some details 22 | some contacts 22 |
And waited for '5' seconds
And selected files on project files page:
| FileName    |
| image10.jpg |
| Fish1-Ad.mov|
| audio01.mp3 |
When I add Batch Usage Right 'Music' with following fields on opened Edit Usage Rights pop-up from project folder page:
| ArtistName  | TrackTitle | StartDate  | ExpirationDate | Composer    | TrackNumber | RecordLabel  | SubLabel  | PublicationPublisher | Arranger | ISRCNumber | Duration | LicenseDetails  | ContactDetails |
| Andy Man    | new song   | 20.02.2012 | 22.12.2032     | Hanz Zimmer | 3           | Label_New    | SubLabeLd | WB                   | Empty    | 1113-434-3 | 120      | copyright       | Ukrainre       |
Then I 'should' see 'Music' usage rule with following fields on file 'audio01.mp3' and folder '/F1' and project 'P_LPTG_S01' Usage Rights page:
| ArtistName  | TrackTitle      | StartDate  | ExpirationDate | Composer      | TrackNumber | RecordLabel  | SubLabel        | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails  | ContactDetails   |
| Randy Marsh | the best song 6 | 20.02.2002 | 02.02.2020     | Liane Cartman | 3           | testLabel 22 | testSubLabel 22 | black penguin        | Shelly Marsh | 123-ABH    | 111      | some details 22 | some contacts 22 |
| Andy Man    | new song        | 20.02.2012 | 22.12.2032     | Hanz Zimmer   | 3           | Label_New    | SubLabeLd       | WB                   | Empty        | 1113-434-3 | 120      | copyright       | Ukrainre         |
And 'should' see 'Music' usage rule with following fields on file 'Fish1-Ad.mov' and folder '/F1' and project 'P_LPTG_S01' Usage Rights page:
| ArtistName  | TrackTitle      | StartDate  | ExpirationDate | Composer      | TrackNumber | RecordLabel  | SubLabel        | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails  | ContactDetails   |
| Randy Marsh | the best song 6 | 20.02.2002 | 02.02.2020     | Liane Cartman | 3           | testLabel 22 | testSubLabel 22 | black penguin        | Shelly Marsh | 123-ABH    | 111      | some details 22 | some contacts 22 |
| Andy Man    | new song        | 20.02.2012 | 22.12.2032     | Hanz Zimmer   | 3           | Label_New    | SubLabeLd       | WB                   | Empty        | 1113-434-3 | 120      | copyright       | Ukrainre         |


Scenario: Check that if user is adding Other AND Other already exists on file, Other will be added
Meta:@gdam
@projects
Given I created the following agency:
| Name         |
| A_LPTG_S07_4 |
And created users with following fields:
| Email        | Role         | Agency     |
| U_LPTG_S07_5 | agency.admin | A_LPTG_S07_4 |
And logged in with details of 'U_LPTG_S07_5'
And created 'P_LPTG_S02' project
And created '/F1' folder for project 'P_LPTG_S02'
And uploaded '/files/image10.jpg' file into '/F1' folder for 'P_LPTG_S02' project
And uploaded '/files/Fish1-Ad.mov' file into '/F1' folder for 'P_LPTG_S02' project
And uploaded '/files/audio01.mp3' file into '/F1' folder for 'P_LPTG_S02' project
And waited while preview is available in folder '/F1' on project 'P_LPTG_S02' files page
And selected files on project files page:
| FileName    |
| image10.jpg |
| Fish1-Ad.mov|
| audio01.mp3 |
And added Batch Usage Right 'Other usage' with following fields on opened Edit Usage Rights pop-up from project folder page:
| Comment        |
| URC_URAS_S06_1 |
And waited for '5' seconds
And selected files on project files page:
| FileName    |
| image10.jpg |
| Fish1-Ad.mov|
| audio01.mp3 |
When I add Batch Usage Right 'Other usage' with following fields on opened Edit Usage Rights pop-up from project folder page:
| Comment        |
| UNIQ_Comment   |
Then I 'should' see 'Other usage' usage rule with following fields on file 'image10.jpg' and folder '/F1' and project 'P_LPTG_S02' Usage Rights page:
| Comment        |
| URC_URAS_S06_1 |
| UNIQ_Comment   |
And 'should' see 'Other usage' usage rule with following fields on file 'Fish1-Ad.mov' and folder '/F1' and project 'P_LPTG_S02' Usage Rights page:
| Comment        |
| URC_URAS_S06_1 |
| UNIQ_Comment   |


Scenario: Check that if user is adding Media AND Media already exists on file, Media will be updated
Meta:@gdam
@projects
!--NGN-14027
!--NGN-14008
Given I created the following agency:
| Name         |
| A_LPTG_S07_4 |
And created users with following fields:
| Email        | Role         | Agency     |
| U_LPTG_S07_5 | agency.admin | A_LPTG_S07_4 |
And logged in with details of 'U_LPTG_S07_5'
And created 'P_LPTG_S02' project
And created '/F2' folder for project 'P_LPTG_S02'
And uploaded '/files/voiceclip.mp4' file into '/F2' folder for 'P_LPTG_S02' project
And uploaded '/files/Fish1-Ad.mov' file into '/F2' folder for 'P_LPTG_S02' project
And waited while preview is available in folder '/F2' on project 'P_LPTG_S02' files page
And selected files on project files page:
| FileName      |
| voiceclip.mp4 |
| Fish1-Ad.mov  |
And added Batch Usage Right 'Media Types' with following fields on opened Edit Usage Rights pop-up from project folder page:
| Type           | Comment         |
| Generic Master | tv test comment |
And waited for '5' seconds
And selected files on project files page:
| FileName      |
| voiceclip.mp4 |
| Fish1-Ad.mov  |
When I add Batch Usage Right 'Media Types' with following fields on opened Edit Usage Rights pop-up from project folder page:
| Type           | Comment |
| Generic Master | 1+1     |
Then I 'should' see 'Media Types' usage rule with following fields on file 'voiceclip.mp4' and folder '/F2' and project 'P_LPTG_S02' Usage Rights page:
| Type           | Comment |
| Generic Master | 1+1     |
And 'should' see 'Media Types' usage rule with following fields on file 'Fish1-Ad.mov' and folder '/F2' and project 'P_LPTG_S02' Usage Rights page:
| Type           | Comment |
| Generic Master | 1+1     |
And 'should not' see 'Media Types' usage rule with following fields on file 'Fish1-Ad.mov' and folder '/F2' and project 'P_LPTG_S02' Usage Rights page:
| Type           | Comment         |
| Generic Master | tv test comment |
And 'should not' see 'Media Types' usage rule with following fields on file 'voiceclip.mp4' and folder '/F2' and project 'P_LPTG_S02' Usage Rights page:
| Type           | Comment         |
| Generic Master | tv test comment |


Scenario: Check that if user is adding Media AND Media already exists on file, Media will be added
Meta:@gdam
@projects
!--NGN-14027
!--NGN-14008
Given I created the following agency:
| Name         |
| A_LPTG_S07_4 |
And created users with following fields:
| Email        | Role         | Agency     |
| U_LPTG_S07_5 | agency.admin | A_LPTG_S07_4 |
And logged in with details of 'U_LPTG_S07_5'
And created 'P_LPTG_S02' project
And created '/F3' folder for project 'P_LPTG_S02'
And uploaded '/files/voiceclip.mp4' file into '/F3' folder for 'P_LPTG_S02' project
And uploaded '/files/Fish1-Ad.mov' file into '/F3' folder for 'P_LPTG_S02' project
And waited while preview is available in folder '/F3' on project 'P_LPTG_S02' files page
And selected files on project files page:
| FileName      |
| voiceclip.mp4 |
| Fish1-Ad.mov  |
And added Batch Usage Right 'Media Types' with following fields on opened Edit Usage Rights pop-up from project folder page:
| Type           | Comment         |
| Generic Master | tv test comment |
And waited for '5' seconds
And selected files on project files page:
| FileName      |
| voiceclip.mp4 |
| Fish1-Ad.mov  |
When I add Batch Usage Right 'Media Types' with following fields on opened Edit Usage Rights pop-up from project folder page:
| Type          | Comment |
| Cinema Master | Komod   |
Then I 'should' see 'Media Types' usage rule with following fields on file 'voiceclip.mp4' and folder '/F3' and project 'P_LPTG_S02' Usage Rights page:
| Type           | Comment         |
| Generic Master | tv test comment |
| Cinema Master  | Komod           |
And 'should' see 'Media Types' usage rule with following fields on file 'Fish1-Ad.mov' and folder '/F3' and project 'P_LPTG_S02' Usage Rights page:
| Type           | Comment         |
| Generic Master | tv test comment |
| Cinema Master  | Komod           |

Scenario: Check that if user is adding General usage rights on assets with already existing General UR, General usage rights will be updated
Meta:@gdam
@library
Given I created the following agency:
| Name         |
| A_LPTG_S07_4 |
And created users with following fields:
| Email        | Role         | Agency     |Access|
| U_LPTG_S07_1 | agency.admin | A_LPTG_S07_4 |streamlined_library|
And logged in with details of 'U_LPTG_S07_1'
And I uploaded file '/files/image10.jpg' into my libraryNEWLIB
And I uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And I uploaded file '/files/audio01.mp3' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
And selected asset 'image10.jpg,Fish1-Ad.mov,audio01.mp3' in the 'My Assets' library pageNEWLIB
When I open Add Usage Rights Popup from collection 'My Assets' pageNEWLIB
And I add batch Usage Right 'General' with following fields on opened asset Usage Rights page from collection 'My Assets'NEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2002 | 02.02.2020     |
And select asset 'image10.jpg,Fish1-Ad.mov,audio01.mp3' in the 'My Assets' library pageNEWLIB
And I open Add Usage Rights Popup from collection 'My Assets' pageNEWLIB
And I add batch Usage Right 'General' with following fields on opened asset Usage Rights page from collection 'My Assets'NEWLIB:
| StartDate  | ExpirationDate |
| 31.12.2004 | 29.05.2027     |
Then I 'should' see following data for usage type 'General' on asset 'Fish1-Ad.mov' usage rights page for collection 'My Assets'NEWLIB:
| StartDate  | ExpirationDate |
| 31.12.2004 | 29.05.2027     |
And I 'should' see following data for usage type 'General' on asset 'image10.jpg' usage rights page for collection 'My Assets'NEWLIB:
| StartDate  | ExpirationDate |
| 31.12.2004 | 29.05.2027     |
And I 'should not' see following data for usage type 'General' on asset 'audio01.mp3' usage rights page for collection 'My Assets'NEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2002 | 02.02.2020     |
And I 'should not' see following data for usage type 'General' on asset 'image10.jpg' usage rights page for collection 'My Assets'NEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2002 | 02.02.2020     |


Scenario: Check that if user is adding Visual/Voice Over artist that DOES NOT exist on asset, Visual/Voice Over artist will be added
Meta:@gdam
@library
Given I created the following agency:
| Name         |
| A_LPTG_S07_4 |
And created users with following fields:
| Email        | Role         | Agency     |Access|
| U_LPTG_S07_21 | agency.admin | A_LPTG_S07_4 |streamlined_library|
And logged in with details of 'U_LPTG_S07_21'
And I uploaded file '/files/image10.jpg' into my libraryNEWLIB
And I uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And I uploaded file '/files/audio01.mp3' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
And selected asset 'image10.jpg,Fish1-Ad.mov,audio01.mp3' in the 'My Assets' library pageNEWLIB
When I open Add Usage Rights Popup from collection 'My Assets' pageNEWLIB
And I add batch Usage Right 'Voice-over Artist' with following fields on opened asset Usage Rights page from collection 'My Assets'NEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| RandyMarsh | Manager | 20.02.2002 | 02.02.2020     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And select asset 'image10.jpg,Fish1-Ad.mov,audio01.mp3' in the 'My Assets' library pageNEWLIB
And I open Add Usage Rights Popup from collection 'My Assets' pageNEWLIB
And I add batch Usage Right 'Voice-over Artist' with following fields on opened asset Usage Rights page from collection 'My Assets'NEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| MystyLogan | PM      | 15.11.2003 | 12.04.2023     |  NeEric man   | 553-32-80 | NeEric@mail.com |  union     | new info  |
And I wait for '2' seconds
Then I 'should' see following data for usage type 'Voice-over Artist' on asset 'Fish1-Ad.mov' usage rights page for collection 'My Assets'NEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| MystyLogan | PM      | 15.11.2003 | 12.04.2023     |  NeEric man   | 553-32-80 | NeEric@mail.com |  union     | new info  |
| RandyMarsh | Manager | 20.02.2002 | 02.02.2020     | Eric Cartman  | 555-32-80 | eric-c@mail.com | test union | some info |
And 'should' see following data for usage type 'Voice-over Artist' on asset 'audio01.mp3' usage rights page for collection 'My Assets'NEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate | Agent         | AgentTel  | Email           | Union      | MoreInfo  |
| MystyLogan | PM      | 15.11.2003 | 12.04.2023     |  NeEric man   | 553-32-80 | NeEric@mail.com |  union     | new info  |
| RandyMarsh | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And 'should' see following data for usage type 'Voice-over Artist' on asset 'image10.jpg' usage rights page for collection 'My Assets'NEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| MystyLogan | PM      | 15.11.2003 | 12.04.2023     |  NeEric man   | 553-32-80 | NeEric@mail.com |  union     | new info  |
| RandyMarsh | Manager | 20.02.2002 | 02.02.2020     | Eric Cartman  | 555-32-80 | eric-c@mail.com | test union | some info |

Scenario: Check that if  user is adding Visual/Voice Over artist that already exists on asset, Visual/Voice Over artist will be updated
Meta:@gdam
@library
Given I created the following agency:
| Name         |
| A_LPTG_S07_4 |
And created users with following fields:
| Email        | Role         | Agency     |Access|
| U_LPTG_S07_3 | agency.admin | A_LPTG_S07_4 |streamlined_library|
And logged in with details of 'U_LPTG_S07_3'
And I uploaded file '/files/image10.jpg' into my libraryNEWLIB
And I uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And I uploaded file '/files/audio01.mp3' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
And selected asset 'image10.jpg,Fish1-Ad.mov,audio01.mp3' in the 'My Assets' library pageNEWLIB
When I open Add Usage Rights Popup from collection 'My Assets' pageNEWLIB
And I add batch Usage Right 'Voice-over Artist' with following fields on opened asset Usage Rights page from collection 'My Assets'NEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And select asset 'image10.jpg,Fish1-Ad.mov,audio01.mp3' in the 'My Assets' library pageNEWLIB
And I open Add Usage Rights Popup from collection 'My Assets' pageNEWLIB
And I add batch Usage Right 'Voice-over Artist' with following fields on opened asset Usage Rights page from collection 'My Assets'NEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | PM      | 15.11.2003 | 12.04.2023     |  NeEric man   | 553-32-80 | NeEric@mail.com |  union     | new info  |
Then I 'should' see following data for usage type 'Voice-over Artist' on asset 'Fish1-Ad.mov' usage rights page for collection 'My Assets'NEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | PM      | 15.11.2003 | 12.04.2023     |  NeEric man   | 553-32-80 | NeEric@mail.com |  union     | new info  |
And 'should' see following data for usage type 'Voice-over Artist' on asset 'audio01.mp3' usage rights page for collection 'My Assets'NEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | PM      | 15.11.2003 | 12.04.2023     |  NeEric man   | 553-32-80 | NeEric@mail.com |  union     | new info  |
And 'should not' see following data for usage type 'Voice-over Artist' on asset 'Fish1-Ad.mov' usage rights page for collection 'My Assets'NEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And 'should not' see following data for usage type 'Voice-over Artist' on asset 'audio01.mp3' usage rights page for collection 'My Assets'NEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And 'should not' see following data for usage type 'Voice-over Artist' on asset 'image10.jpg' usage rights page for collection 'My Assets'NEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |


Scenario: Check that if user is adding Country that already exists on asset , Country will be updated
Meta:@gdam
@library
Given I created the following agency:
| Name         |
| A_LPTG_S07_4 |
And created users with following fields:
| Email        | Role         | Agency     |Access|
| U_LPTG_S07_4 | agency.admin | A_LPTG_S07_4 |streamlined_library|
And logged in with details of 'U_LPTG_S07_4'
And I uploaded file '/files/image10.jpg' into my libraryNEWLIB
And I uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And I uploaded file '/files/audio01.mp3' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
And selected asset 'image10.jpg,Fish1-Ad.mov,audio01.mp3' in the 'My Assets' library pageNEWLIB
When I open Add Usage Rights Popup from collection 'My Assets' pageNEWLIB
And I add batch Usage Right 'Countries' with following fields on opened asset Usage Rights page from collection 'My Assets'NEWLIB:
| Country | StartDate  | ExpirationDate |
| Ukraine | 20.02.2002 | 02.02.2020     |
And select asset 'image10.jpg,Fish1-Ad.mov,audio01.mp3' in the 'My Assets' library pageNEWLIB
And I open Add Usage Rights Popup from collection 'My Assets' pageNEWLIB
And I add batch Usage Right 'Countries' with following fields on opened asset Usage Rights page from collection 'My Assets'NEWLIB:
| Country | StartDate  | ExpirationDate |
| Ukraine | 20.02.2005 | 02.02.2022     |
Then I 'should' see following data for usage type 'Countries' on asset 'Fish1-Ad.mov' usage rights page for collection 'My Assets'NEWLIB:
| Country | StartDate  | ExpirationDate |
| Ukraine | 20.02.2005 | 02.02.2022     |
And 'should' see following data for usage type 'Countries' on asset 'audio01.mp3' usage rights page for collection 'My Assets'NEWLIB:
| Country | StartDate  | ExpirationDate |
| Ukraine | 20.02.2005 | 02.02.2022     |
And 'should not' see following data for usage type 'Countries' on asset 'image10.jpg' usage rights page for collection 'My Assets'NEWLIB:
| Country | StartDate  | ExpirationDate |
| Ukraine | 20.02.2002 | 02.02.2020     |
And 'should not' see following data for usage type 'Countries' on asset 'audio01.mp3' usage rights page for collection 'My Assets'NEWLIB:
| Country | StartDate  | ExpirationDate |
| Ukraine | 20.02.2002 | 02.02.2020     |


Scenario: Check that if user is adding Country that does not already exist on asset, Country will be added
Meta:@gdam
@library
Given I created the following agency:
| Name         |
| A_LPTG_S07_4 |
And created users with following fields:
| Email        | Role         | Agency     |Access|
| U_LPTG_S07_5 | agency.admin | A_LPTG_S07_4 |streamlined_library|
And logged in with details of 'U_LPTG_S07_5'
And I uploaded file '/files/image10.jpg' into my libraryNEWLIB
And I uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And I uploaded file '/files/audio01.mp3' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And I have refreshed the page
And selected asset 'image10.jpg,Fish1-Ad.mov,audio01.mp3' in the 'My Assets' library pageNEWLIB
When I open Add Usage Rights Popup from collection 'My Assets' pageNEWLIB
And I add batch Usage Right 'Countries' with following fields on opened asset Usage Rights page from collection 'My Assets'NEWLIB:
| Country | StartDate  | ExpirationDate |
| Ukraine   | 20.02.2002 | 02.02.2020     |
And select asset 'image10.jpg,Fish1-Ad.mov,audio01.mp3' in the 'My Assets' library pageNEWLIB
And I open Add Usage Rights Popup from collection 'My Assets' pageNEWLIB
And I add batch Usage Right 'Countries' with following fields on opened asset Usage Rights page from collection 'My Assets'NEWLIB:
| Country | StartDate  | ExpirationDate |
| Andorra | 20.02.2005 | 02.02.2022     |
Then I 'should' see following data for usage type 'Countries' on asset 'Fish1-Ad.mov' usage rights page for collection 'My Assets'NEWLIB:
| Country   | StartDate  | ExpirationDate |
| Andorra   | 20.02.2005 | 02.02.2022     |
| Ukraine   | 20.02.2002 | 02.02.2020     |
And 'should' see following data for usage type 'Countries' on asset 'audio01.mp3' usage rights page for collection 'My Assets'NEWLIB:
| Country   | StartDate  | ExpirationDate |
| Andorra   | 20.02.2005 | 02.02.2022     |
| Ukraine   | 20.02.2002 | 02.02.2020     |
And 'should' see following data for usage type 'Countries' on asset 'image10.jpg' usage rights page for collection 'My Assets'NEWLIB:
| Country   | StartDate  | ExpirationDate |
| Andorra   | 20.02.2005 | 02.02.2022     |
| Ukraine   | 20.02.2002 | 02.02.2020     |




