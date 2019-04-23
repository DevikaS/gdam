!-- NGN-12909
 Feature:          User can select Artist Name when adding Usage Rights
 Narrative:
 In order to
 As a              AgencyAdmin
 I want to         Check adding and create artist for Visual Talenr and Voice over artist Usage Rights



Scenario: Check that after select artist for UR specific fields are populated
Meta:@gdam
@library
Given I created the following agency:
| Name         |
| A_LPTG_S07 |
And created users with following fields:
| Email        | Role         | Agency     |Access|
| U_LPTG_S07_1 | agency.admin | A_LPTG_S07 |streamlined_library|
And logged in with details of 'U_LPTG_S07_1'
And I uploaded file '/files/Fish4-Ad.mov' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish4-Ad.mov'NEWLIB
When I add Usage Right 'Voice-over Artist' for asset 'Fish4-Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     | Eric Cartman  | 555-32-80 | eric-c@mail.com | test union | some info |
And add Usage Right 'Voice-over Artist' for asset 'Fish4-Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  |ClickSave|
| Randy Marsh | false|
Then I 'should' see filled following fields for usage type 'Voice-over Artist' on opened asset Usage Rights pop pageNEWLIB:
| ArtistName  |Agent         | AgentTel  | Email           | Union      |
|Randy Marsh  | Eric Cartman | 555-32-80 | eric-c@mail.com | test union |


Scenario: Check that artist added in current BU is not available for another BU
Meta:@gdam
@library
!-- NGN-13197
Given I created the following agency:
| Name           |
| A_LPTG_S07     |
| A_LPTG_S07_02  |
And created users with following fields:
| Email        | Role         | Agency        |Access|
| U_LPTG_S07_1 | agency.admin | A_LPTG_S07    |streamlined_library|
| U_LPTG_S07_2 | agency.admin | A_LPTG_S07_02 |streamlined_library|
And logged in with details of 'U_LPTG_S07_1'
And I uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And added Usage Right 'Visual Talent' for asset 'Fish1-Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And logged in with details of 'U_LPTG_S07_2'
And I uploaded file '/files/audio01.mp3' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
When add Usage Right 'Visual Talent' for asset 'audio01.mp3' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | ClickSave |
| Randy Marsh | false     |
Then I 'should not' see filled following fields for usage type 'Visual Talent' on opened asset Usage Rights pop pageNEWLIB:
| ArtistName  | Agent          | AgentTel  | Email           | Union      |
| Randy Marsh |  Eric Cartman  | 555-32-80 | eric-c@mail.com | test union |


Scenario: Check that you see artist name in dropdown in edit mode
Meta:@gdam
@library
!-- NGN-13194
Given I created the following agency:
| Name         |
| A_LPTG_S07 |
And created users with following fields:
| Email        | Role         | Agency     |Access|
| U_LPTG_S07_1 | agency.admin | A_LPTG_S07 |streamlined_library|
And logged in with details of 'U_LPTG_S07_1'
And I uploaded file '/files/image9.jpg' into my libraryNEWLIB
And I uploaded file '/files/audio01.mp3' into my libraryNEWLIB
And I uploaded file '/files/logo2.png' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And added Usage Right 'Voice-over Artist' for asset 'image9.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate | BaseFee | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Brad Pitt   | Artist  | 20.02.2002 | 02.02.2020     | 100%    | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And added Usage Right 'Voice-over Artist' for asset 'audio01.mp3' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role     | StartDate  | ExpirationDate | BaseFee | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Bad Boy     | Manager  | 20.02.2002 | 02.02.2020     | 12%     | Reg Danman   | 555-32-80 | reg-d@gmail.com | test union | some info |
When add Usage Right 'Voice-over Artist' for asset 'logo2.png' for collection 'My Assets' with following fieldsNEWLIB:
 |Role   | ClickSave |
 |Manager| false     |
Then I 'should' see 'Brad Pitt' artist details in Artist Name drop down field on opened asset Usage Rights pop pageNEWLIB




Scenario: Check that after edit info for existing artist data is updated
Meta:@gdam
@library
Given I created the following agency:
| Name         |
| A_LPTG_S07 |
And created users with following fields:
| Email        | Role         | Agency     |Access|
| U_LPTG_S07_1 | agency.admin | A_LPTG_S07 |streamlined_library|
And logged in with details of 'U_LPTG_S07_1'
And I uploaded file '/files/audio01.mp3' into my libraryNEWLIB
And I uploaded file '/files/120.600.gif' into my libraryNEWLIB
And I uploaded file '/files/image9.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And added Usage Right 'Voice-over Artist' for asset 'audio01.mp3' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Brad Pitt   | Artist  | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And added Usage Right 'Voice-over Artist' for asset '120.600.gif' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent          | AgentTel  | Email               | Union   | MoreInfo  |
| Brad Pitt   | Manager | 20.02.2002 | 02.02.2020     |  angelina jolie | 103-02-02 | angelina-g@mail.com | new     | some info |
When add Usage Right 'Voice-over Artist' for asset 'image9.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | ClickSave |
| Brad Pitt   | false     |
Then I 'should' see filled following fields for usage type 'Voice-over Artist' on opened asset Usage Rights pop pageNEWLIB:
| ArtistName  | Agent           | AgentTel  | Email               | Union   |
| Brad Pitt   |  angelina jolie | 103-02-02 | angelina-g@mail.com | new     |



Scenario: Check that after deletion UR with added artist it still available for adding
Meta:@gdam
@library
Given I created the following agency:
| Name         |
| A_LPTG_S07 |
And created users with following fields:
| Email        | Role         | Agency     |Access|
| U_LPTG_S07_1 | agency.admin | A_LPTG_S07 |streamlined_library|
And logged in with details of 'U_LPTG_S07_1'
And I uploaded file '/files/image9.jpg' into my libraryNEWLIB
And I uploaded file '/files/audio01.mp3' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And added Usage Right 'Voice-over Artist' for asset 'image9.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Brad Pitt   | Artist  | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And I waited for '2' seconds
When delete entry of 'Voice-over Artist' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
|  EntryNumber    |
| 1               |
And add Usage Right 'Voice-over Artist' for asset 'audio01.mp3' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | ClickSave |
| Brad Pitt   | false     |
And I wait for '2' seconds
Then I 'should' see filled following fields for usage type 'Voice-over Artist' on opened asset Usage Rights pop pageNEWLIB:
| ArtistName  | Agent        | AgentTel  | Email           | Union      |
| Brad Pitt   | Eric Cartman | 555-32-80 | eric-c@mail.com | test union |




