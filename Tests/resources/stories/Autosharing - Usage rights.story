Feature:          Autosharing - Usage rights
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Autosharing Usage rights



Scenario: check removing for 'General' usage rule in autoshared asset 'Usage Rights'
Meta:@gdam
     @library
Given I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And created users with following fields:
| Email        | Role         | Agency      |Access|
| <User1> | agency.admin | <Agency1> |streamlined_library|
| <User2> | agency.admin | <Agency2> |streamlined_library|
| <TestedUser> | <GlobalRole> | <Agency2> |streamlined_library|
And logged in with details of '<User1>'
And uploaded file '<FilePath>' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C_AUR_S01_1' category
And on asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S01_1'NEWLIB
And added Usage Right 'General' with following fields on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2002 | 02.02.2020     |
And added agency '<Agency2>' to category 'C_AUR_S01_1' on Asset Categories and Permissions page
And logged in with details of '<User2>'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_AUR_S01_1' from agency '<Agency1>' pageNEWLIB
And I select asset '<AssetName>' for collection 'C_AUR_S01_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create '<LibRole>' role in 'library' group for advertiser '<Agency2>' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
And create 'C_AUR_S01_2' category
And add users '<TestedUser>' to category 'C_AUR_S01_2' with role '<LibRole>' by users details
And I login with details of '<TestedUser>'
And go to asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S01_2'NEWLIB
And delete entry of 'General' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
|  EntryNumber    |
| 1               |
Then I 'should not' see following data for usage type 'General' on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2002 | 02.02.2020     |

Examples:
| TestedUser   | GlobalRole  | FilePath            | AssetName    |Agency1    |Agency2    |User1       |User2       |LibRole   |
| TU_AUR_S01_1 | agency.user | /files/Fish1-Ad.mov | Fish1-Ad.mov |A_AUR_S01_1|A_AUR_S01_2|AU_AUR_S01_1|AU_AUR_S01_2|LR_AUR_S01_1|
| TU_AUR_S01_2 | guest.user  | /files/Fish2-Ad.mov | Fish2-Ad.mov |A_AUR_S01_2|A_AUR_S01_3|AU_AUR_S01_2|AU_AUR_S01_3|LR_AUR_S02_2|


Scenario: check removing for 'Countries' usage rule in autoshared asset 'Usage Rights'
Meta:@gdam
     @library
Given I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And created users with following fields:
| Email        | Role         | Agency      |Access|
| <User1> | agency.admin | <Agency1> |streamlined_library|
| <User2> | agency.admin | <Agency2> |streamlined_library|
| <TestedUser> | <GlobalRole> | <Agency2> |streamlined_library|
And logged in with details of '<User1>'
And uploaded file '<FilePath>' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets '<AssetName>'NEWLIB
And created 'C_AUR_S02_1' category
And on asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S02_1'NEWLIB
And added Usage Right 'Countries' with following fields on opened asset Usage Rights pageNEWLIB:
| Country | StartDate  | ExpirationDate |
| Ukraine | 20.02.2002 | 02.02.2020     |
And added agency '<Agency2>' to category 'C_AUR_S02_1' on Asset Categories and Permissions page
And logged in with details of '<User2>'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_AUR_S02_1' from agency '<Agency1>' pageNEWLIB
And I select asset '<AssetName>' for collection 'C_AUR_S02_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create '<LibRole>' role in 'library' group for advertiser '<Agency2>' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
And create 'C_AUR_S02_2' category
And add users '<TestedUser>' to category 'C_AUR_S02_2' with role '<LibRole>' by users details
And I login with details of '<TestedUser>'
And go to asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S02_2'NEWLIB
And delete entry of 'Countries' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
|  EntryNumber    |
| 1               |
Then I 'should not' see following data for usage type 'Countries' on opened asset Usage Rights pageNEWLIB:
| Country | StartDate  | ExpirationDate |
| Ukraine | 20.02.2002 | 02.02.2020     |

Examples:
| TestedUser   | GlobalRole  | FilePath            | AssetName    |Agency1    |Agency2    |User1       |User2       |LibRole   |
| TU_AUR_S02_1 | agency.user | /files/Fish1-Ad.mov | Fish1-Ad.mov |A_AUR_S02_1|A_AUR_S02_2|AU_AUR_S02_1|AU_AUR_S02_2|LR_AUR_S02_1|
| TU_AUR_S02_2 | guest.user  | /files/Fish2-Ad.mov | Fish2-Ad.mov |A_AUR_S02_2|A_AUR_S02_3|AU_AUR_S02_2|AU_AUR_S02_3|LR_AUR_S02_2|


Scenario: check removing for 'Media Types' usage rule in autoshared asset 'Usage Rights'
Meta:@gdam
     @library
Given I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And created users with following fields:
| Email        | Role         | Agency      |Access|
| <User1> | agency.admin | <Agency1> |streamlined_library|
| <User2> | agency.admin | <Agency2> |streamlined_library|
| <TestedUser> | <GlobalRole> | <Agency2> |streamlined_library|
And logged in with details of '<User1>'
And uploaded file '<FilePath>' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C_AUR_S03_1' category
And on asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S03_1'NEWLIB
And added Usage Right 'Media Types' with following fields on opened asset Usage Rights pageNEWLIB:
| Type           | Comment      |
| Generic Master | test comment |
And added agency '<Agency2>' to category 'C_AUR_S03_1' on Asset Categories and Permissions page
And logged in with details of '<User2>'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_AUR_S03_1' from agency '<Agency1>' pageNEWLIB
And I select asset '<AssetName>' for collection 'C_AUR_S03_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create '<LibRole>' role in 'library' group for advertiser '<Agency2>' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
And create 'C_AUR_S03_2' category
And add users '<TestedUser>' to category 'C_AUR_S03_2' with role '<LibRole>' by users details
And I login with details of '<TestedUser>'
And go to asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S03_2'NEWLIB
And delete entry of 'Media Types' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
|  EntryNumber    |
| 1               |
Then I 'should not' see following data for usage type 'Media Types' on opened asset Usage Rights pageNEWLIB:
| Type           | Comment      |
| Generic Master | test comment |

Examples:
| TestedUser   | GlobalRole  | FilePath            | AssetName    |Agency1     |Agency2    |User1       |User2       |LibRole   |
| TU_AUR_S03_1 | agency.user | /files/Fish1-Ad.mov | Fish1-Ad.mov |A_AUR_S03_1 |A_AUR_S03_2|AU_AUR_S03_1|AU_AUR_S03_2|LR_AUR_S03_1|
| TU_AUR_S03_2 | guest.user  | /files/Fish2-Ad.mov | Fish2-Ad.mov |A_AUR_S03_2|A_AUR_S03_3|AU_AUR_S03_2|AU_AUR_S03_3|LR_AUR_S03_2|


Scenario: check removing for 'Visual Talent' usage rule in autoshared asset 'Usage Rights'
Meta:@gdam
     @library
Given I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And created users with following fields:
| Email        | Role         | Agency      |Access|
| <User1> | agency.admin | <Agency1> |streamlined_library|
| <User2> | agency.admin | <Agency2> |streamlined_library|
| <TestedUser> | <GlobalRole> | <Agency2> |streamlined_library|
And logged in with details of '<User1>'
And uploaded file '<FilePath>' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets '<AssetName>'NEWLIB
And created 'C_AUR_S04_1' category
And on asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S04_1'NEWLIB
And added Usage Right 'Visual Talent' with following fields on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     |
And added agency '<Agency2>' to category 'C_AUR_S04_1' on Asset Categories and Permissions page
And logged in with details of '<User2>'
When I go to the collections page
And I refresh the page
And accept all assets on Shared Collection 'C_AUR_S04_1' from agency '<Agency1>' pageNEWLIB
And create '<LibRole>' role in 'library' group for advertiser '<Agency2>' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
And create 'C_AUR_S04_2' category
And add users '<TestedUser>' to category 'C_AUR_S04_2' with role '<LibRole>' by users details
And I login with details of '<TestedUser>'
And go to asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S04_2'NEWLIB
And delete entry of 'Visual Talent' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
|  EntryNumber    |
| 1               |
Then I 'should not' see following data for usage type 'Visual Talent' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     |

Examples:
| TestedUser   | GlobalRole  | FilePath            | AssetName    |Agency1    |Agency2    |User1       |User2       |LibRole   |
| TU_AUR_S04_1 | agency.user | /files/Fish1-Ad.mov | Fish1-Ad.mov |A_AUR_S04_1|A_AUR_S04_2|AU_AUR_S04_1|AU_AUR_S04_2|LR_AUR_S04_1|
| TU_AUR_S04_2 | guest.user  | /files/Fish2-Ad.mov | Fish2-Ad.mov |A_AUR_S04_2|A_AUR_S04_3|AU_AUR_S04_3|AU_AUR_S04_4|LR_AUR_S04_2|



Scenario: check removing for 'Voice-over Artist' usage rule in autoshared asset 'Usage Rights'
Meta:@gdam
     @library
Given I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And created users with following fields:
| Email        | Role         | Agency      |Access|
| <User1> | agency.admin | <Agency1> |streamlined_library|
| <User2> | agency.admin | <Agency2> |streamlined_library|
| <TestedUser> | <GlobalRole> | <Agency2> |streamlined_library|
And logged in with details of '<User1>'
And uploaded file '<FilePath>' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C_AUR_S05_1' category
And on asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S05_1'NEWLIB
And added Usage Right 'Voice-over Artist' with following fields on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And added agency '<Agency2>' to category 'C_AUR_S05_1' on Asset Categories and Permissions page
And logged in with details of '<User2>'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_AUR_S05_1' from agency '<Agency1>' pageNEWLIB
And I select asset '<AssetName>' for collection 'C_AUR_S05_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create '<LibRole>' role in 'library' group for advertiser '<Agency2>' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
And create 'C_AUR_S05_2' category
And add users '<TestedUser>' to category 'C_AUR_S05_2' with role '<LibRole>' by users details
When I login with details of '<TestedUser>'
And go to asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S05_2'NEWLIB
And delete entry of 'Voice-over Artist' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
|  EntryNumber    |
| 1               |
Then I 'should not' see following data for usage type 'Voice-over Artist' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |

Examples:
| TestedUser   | GlobalRole  | FilePath            | AssetName    |Agency1    |Agency2    |User1       |User2       |LibRole   |
| TU_AUR_S05_1 | agency.user | /files/Fish1-Ad.mov | Fish1-Ad.mov |A_AUR_S05_1|A_AUR_S05_2|AU_AUR_S05_1|AU_AUR_S05_2|LR_AUR_S05_1|
| TU_AUR_S05_2 | guest.user  | /files/Fish2-Ad.mov | Fish2-Ad.mov |A_AUR_S05_2|A_AUR_S05_3|AU_AUR_S05_2|AU_AUR_S05_3|LR_AUR_S05_2|


Scenario: check removing for 'Music' usage rule in autoshared asset 'Usage Rights'
Meta:@gdam
     @library
Given I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And created users with following fields:
| Email        | Role         | Agency      |Access|
| <User1> | agency.admin | <Agency1> |streamlined_library|
| <User2> | agency.admin | <Agency2> |streamlined_library|
| <TestedUser> | <GlobalRole> | <Agency2> |streamlined_library|
And logged in with details of '<User1>'
And uploaded file '<FilePath>' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C_AUR_S06_1' category
And on asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S06_1'NEWLIB
And added Usage Right 'Music' with following fields on opened asset Usage Rights pageNEWLIB:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
And added agency '<Agency2>' to category 'C_AUR_S06_1' on Asset Categories and Permissions page
And logged in with details of '<User2>'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_AUR_S06_1' from agency '<Agency1>' pageNEWLIB
And I select asset '<AssetName>' for collection 'C_AUR_S06_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create '<LibRole>' role in 'library' group for advertiser '<Agency2>' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
And create 'C_AUR_S06_2' category
And add users '<TestedUser>' to category 'C_AUR_S06_2' with role '<LibRole>' by users details
And I login with details of '<TestedUser>'
And go to asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S06_2'NEWLIB
And delete entry of 'Music' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
|  EntryNumber    |
| 1               |
Then I 'should not' see following data for usage type 'Music' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |

Examples:
| TestedUser   | GlobalRole  | FilePath            | AssetName    |Agency1    |Agency2    |User1       |User2       |LibRole   |
| TU_AUR_S06_1 | agency.user | /files/Fish1-Ad.mov | Fish1-Ad.mov |A_AUR_S06_1|A_AUR_S06_2|AU_AUR_S06_1|AU_AUR_S06_2|LR_AUR_S06_1|
| TU_AUR_S06_2 | guest.user  | /files/Fish2-Ad.mov | Fish2-Ad.mov |A_AUR_S06_2|A_AUR_S06_3|AU_AUR_S06_2|AU_AUR_S06_3|LR_AUR_S06_2|

Scenario: check removing for 'Other usage' usage rule in autoshared asset 'Usage Rights'
Meta:@gdam
     @library
Given I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And created users with following fields:
| Email        | Role         | Agency      |Access|
| <User1> | agency.admin | <Agency1> |streamlined_library|
| <User2> | agency.admin | <Agency2> |streamlined_library|
| <TestedUser> | <GlobalRole> | <Agency2> |streamlined_library|
And logged in with details of '<User1>'
And uploaded file '<FilePath>' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C_AUR_S07_1' category
And on asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S07_1'NEWLIB
And added Usage Right 'Other usage' with following fields on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
And added agency '<Agency2>' to category 'C_AUR_S07_1' on Asset Categories and Permissions page
And logged in with details of '<User2>'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_AUR_S07_1' from agency '<Agency1>' pageNEWLIB
And I select asset '<AssetName>' for collection 'C_AUR_S07_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create '<LibRole>' role in 'library' group for advertiser '<Agency2>' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
And create 'C_AUR_S07_2' category
And add users '<TestedUser>' to category 'C_AUR_S07_2' with role '<LibRole>' by users details
When I login with details of '<TestedUser>'
And go to asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S07_2'NEWLIB
And delete entry of 'Other usage' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
|  EntryNumber    |
| 1               |
Then I 'should not' see following data for usage type 'Other usage' on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |

Examples:
| TestedUser   | GlobalRole  | FilePath            | AssetName    |Agency1    |Agency2    |User1       |User2       |LibRole   |
| TU_AUR_S07_1 | agency.user | /files/Fish1-Ad.mov | Fish1-Ad.mov |A_AUR_S07_1|A_AUR_S07_2|AU_AUR_S07_1|AU_AUR_S07_2|LR_AUR_S07_1|
| TU_AUR_S07_2 | guest.user  | /files/Fish2-Ad.mov | Fish2-Ad.mov |A_AUR_S07_2|A_AUR_S07_3|AU_AUR_S07_2|AU_AUR_S07_3|LR_AUR_S07_2|



Scenario: check saving for all usage rules in autoshared asset 'Usage Rights'
Meta: @skip
      @gdam
Given I created the agency 'A_AUR_S08_1' with default attributes
And created the agency 'A_AUR_S08_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency      |
| AU_AUR_S08_1 | agency.admin | A_AUR_S08_1 |
| AU_AUR_S08_2 | agency.admin | A_AUR_S08_2 |
| <TestedUser> | <GlobalRole> | A_AUR_S08_2 |
And logged in with details of 'AU_AUR_S08_1'
And uploaded file '<FilePath>' into my library
And waited while preview is available in collection 'My Assets'
And created 'C_AUR_S08_1' category
And on asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S08_1'
And added Usage Right 'General' with following fields on opened asset Usage Rights page:
| StartDate  | ExpirationDate |
| 20.02.2002 | 02.02.2020     |
And added Usage Right 'Countries' with following fields on opened asset Usage Rights page:
| Country | StartDate  | ExpirationDate |
| Ukraine | 20.02.2002 | 02.02.2020     |
And added Usage Right 'Media Types' with following fields on opened asset Usage Rights page:
| Type | Comment      |
| TV   | test comment |
And added Usage Right 'Visual Talent' with following fields on opened asset Usage Rights page:
| ArtistName  | Role    | StartDate  | ExpirationDate |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     |
And added Usage Right 'Voice-over Artist' with following fields on opened asset Usage Rights page:
| ArtistName  | Role    | StartDate  | ExpirationDate | BaseFee | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     | 10%     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And added Usage Right 'Music' with following fields on opened asset Usage Rights page:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
And added Usage Right 'Other usage' with following fields on opened asset Usage Rights page:
| Comment      |
| test comment |
And added agency 'A_AUR_S08_2' to category 'C_AUR_S08_1' on Asset Categories and Permissions page
And logged in with details of 'AU_AUR_S08_2'
And accepted all assets on Shared Collection 'C_AUR_S08_1' from agency 'A_AUR_S08_1' page
And created 'LR_AUR_S08' role in 'library' group for advertiser 'A_AUR_S08_2' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
And created 'C_AUR_S08_2' category
And added users '<TestedUser>' to category 'C_AUR_S08_2' with role 'LR_AUR_S08' by users details
When I login with details of '<TestedUser>'
And go to asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S08_2'
Then I 'should' see following data for usage type 'General' on opened asset Usage Rights page:
| StartDate  | ExpirationDate |
| 20.02.2002 | 02.02.2020     |
And 'should' see following data for usage type 'Countries' on opened asset Usage Rights page:
| Country | StartDate  | ExpirationDate |
| Ukraine | 20.02.2002 | 02.02.2020     |
And 'should' see following data for usage type 'Media Types' on opened asset Usage Rights page:
| Type | Comment      |
| TV   | test comment |
And 'should' see following data for usage type 'Visual Talent' on opened asset Usage Rights page:
| ArtistName  | Role    | StartDate  | ExpirationDate |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     |
And 'should' see following data for usage type 'Voice-over Artist' on opened asset Usage Rights page:
| ArtistName  | Role    | StartDate  | ExpirationDate | BaseFee | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     | 10%     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And 'should' see following data for usage type 'Music' on opened asset Usage Rights page:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
And 'should' see following data for usage type 'Other usage' on opened asset Usage Rights page:
| Comment      |
| test comment |

Examples:
| TestedUser   | GlobalRole  | FilePath            | AssetName    |
| TU_AUR_S08_1 | agency.user | /files/Fish1-Ad.mov | Fish1-Ad.mov |
| TU_AUR_S08_2 | guest.user  | /files/Fish2-Ad.mov | Fish2-Ad.mov |


Scenario: check saving for usage rule in autoshared asset 'Usage Rights' after page refresh
Meta:@gdam
     @library
Given I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And created users with following fields:
| Email        | Role         | Agency      |Access|
| <User1> | agency.admin | <Agency1> |streamlined_library|
| <User2> | agency.admin | <Agency2> |streamlined_library|
| <TestedUser> | <GlobalRole> | <Agency2> |streamlined_library|
And logged in with details of '<User1>'
And uploaded file '<FilePath>' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C_AUR_S09_1' category
And added agency '<Agency2>' to category 'C_AUR_S09_1' on Asset Categories and Permissions page
And logged in with details of '<User2>'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_AUR_S09_1' from agency '<Agency1>' pageNEWLIB
And I select asset '<AssetName>' for collection 'C_AUR_S09_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create '<LibRole>' role in 'library' group for advertiser '<Agency2>' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
And create 'C_AUR_S09_2' category
And add users '<TestedUser>' to category 'C_AUR_S09_2' with role '<LibRole>' by users details
When I login with details of '<TestedUser>'
And go to asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S09_2'NEWLIB
And add Usage Right 'General' with following fields on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2002 | 02.02.2020     |
And refresh the page
Then I 'should' see following data for usage type 'General' on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2002 | 02.02.2020     |

Examples:
| TestedUser   | GlobalRole  | FilePath            | AssetName    |Agency1     |Agency2    |User1       |User2       |LibRole   |
| TU_AUR_S09_1 | agency.user | /files/Fish1-Ad.mov | Fish1-Ad.mov |A_AUR_S09_1|A_AUR_S09_2|AU_AUR_S09_1|AU_AUR_S09_2|LR_AUR_S09_1|
| TU_AUR_S09_2 | guest.user  | /files/Fish2-Ad.mov | Fish2-Ad.mov |A_AUR_S09_2|A_AUR_S09_3|AU_AUR_S09_2|AU_AUR_S09_3|LR_AUR_S09_2|


Scenario: check saving for usage rule in autoshared asset 'Usage Rights' before and after asset sharing
Meta:@gdam
     @library
Given I created the agency '<Agency1>' with default attributes
And created the agency '<Agency2>' with default attributes
And created users with following fields:
| Email        | Role         | Agency      |Access|
| <User1> | agency.admin | <Agency1> |streamlined_library|
| <User2> | agency.admin | <Agency2> |streamlined_library|
| <TestedUser> | <GlobalRole> | <Agency2> |streamlined_library|
And logged in with details of '<User1>'
And uploaded file '<FilePath>' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets '<AssetName>'NEWLIB
And created 'C_AUR_S10_1' category
And on asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S10_1'NEWLIB
And added Usage Right 'General' with following fields on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2002 | 02.02.2020     |
And added agency '<Agency2>' to category 'C_AUR_S10_1' on Asset Categories and Permissions page
And logged in with details of '<User2>'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_AUR_S10_1' from agency '<Agency1>' pageNEWLIB
And I select asset '<AssetName>' for collection 'C_AUR_S10_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And create '<LibRole>' role in 'library' group for advertiser '<Agency2>' with following permissions:
| Permission                 |
| asset_filter_category.read |
| asset.read                 |
| asset.write                |
| asset.usage_rights.read    |
| asset.usage_rights.write   |
And create 'C_AUR_S10_2' category
And add users '<TestedUser>' to category 'C_AUR_S10_2' with role '<LibRole>' by users details
When I login with details of '<TestedUser>'
And go to asset '<AssetName>' usage rights page in Library for collection 'C_AUR_S10_2'NEWLIB
Then I 'should' see following data for usage type 'General' on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2002 | 02.02.2020     |

Examples:
| TestedUser   | GlobalRole  | FilePath            | AssetName    |Agency1     |Agency2    |User1       |User2       |LibRole   |
| TU_AUR_S10_1 | agency.user | /files/Fish1-Ad.mov | Fish1-Ad.mov |A_AUR_S10_1|A_AUR_S10_2|AU_AUR_S10_1|AU_AUR_S10_2|LR_AUR_S10_1|
| TU_AUR_S10_2 | guest.user  | /files/Fish2-Ad.mov | Fish2-Ad.mov |A_AUR_S10_2|A_AUR_S10_3|AU_AUR_S10_2|AU_AUR_S10_3|LR_AUR_S10_2|


Scenario: Check usage rights after accept
Meta:@gdam
     @library
Given I created the agency 'A_AUR_S11_1' with default attributes
And created the agency 'A_AUR_S11_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency      |Access|
| AU_AUR_S11_1 | agency.admin | A_AUR_S11_1 |streamlined_library|
| AU_AUR_S11_2 | agency.admin | A_AUR_S11_2 |streamlined_library|
And logged in with details of 'AU_AUR_S11_1'
And uploaded file '/files/128_shortname.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C_AUR_S11_1' category
And on asset '128_shortname.jpg' usage rights page in Library for collection 'C_AUR_S11_1'NEWLIB
And added Usage Right 'General' with following fields on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2002 | 02.02.2020     |
And added agency 'A_AUR_S11_2' to category 'C_AUR_S11_1' on Asset Categories and Permissions page
And logged in with details of 'AU_AUR_S11_2'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_AUR_S11_1' from agency 'A_AUR_S11_1' pageNEWLIB
And I select asset '128_shortname.jpg' for collection 'C_AUR_S11_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And I go to asset '128_shortname.jpg' usage rights page in Library for collection 'Everything'NEWLIB
Then I 'should' see following data for usage type 'General' on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2002 | 02.02.2020     |

Scenario: Check that asset download buttons is hidden if usage rights are expired
Meta:@gdam
     @library
Given I created the agency 'A_AUR_S12_1' with default attributes
And created the agency 'A_AUR_S12_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency      |Access|
| AU_AUR_S12_1 | agency.admin | A_AUR_S12_1 |streamlined_library|
| AU_AUR_S12_2 | agency.admin | A_AUR_S12_2 |streamlined_library|
And logged in with details of 'AU_AUR_S12_1'
And uploaded file '/files/128_shortname.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C_AUR_S12_1' category
And on asset '128_shortname.jpg' usage rights page in Library for collection 'C_AUR_S12_1'NEWLIB
And added Usage Right 'General' with following fields on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2002 | Yesterday      |
And added agency 'A_AUR_S12_2' to category 'C_AUR_S12_1' on Asset Categories and Permissions page
And logged in with details of 'AU_AUR_S12_2'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_AUR_S12_1' from agency 'A_AUR_S12_1' pageNEWLIB
And I select asset '128_shortname.jpg' for collection 'C_AUR_S12_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And I go to asset '128_shortname.jpg' info page in Library for collection 'Everything'NEWLIB
Then I 'should not' see 'Download' button on opened asset info pageNEWLIB


Scenario: Check that user can edit usage rights after accept
Meta:@gdam
     @library
Given I created the agency 'A_AUR_S13_1' with default attributes
And created the agency 'A_AUR_S13_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency      |Access|
| AU_AUR_S13_1 | agency.admin | A_AUR_S13_1 |streamlined_library|
| AU_AUR_S13_2 | agency.admin | A_AUR_S13_2 |streamlined_library|
And logged in with details of 'AU_AUR_S13_1'
And uploaded file '/files/128_shortname.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C_AUR_S13_1' category
And on asset '128_shortname.jpg' usage rights page in Library for collection 'C_AUR_S13_1'NEWLIB
And added Usage Right 'General' with following fields on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2002 | 20.02.2020     |
And added agency 'A_AUR_S13_2' to category 'C_AUR_S13_1' on Asset Categories and Permissions page
And logged in with details of 'AU_AUR_S13_2'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_AUR_S13_1' from agency 'A_AUR_S13_1' pageNEWLIB
And I select asset '128_shortname.jpg' for collection 'C_AUR_S13_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And go to asset '128_shortname.jpg' usage rights page in Library for collection 'Everything'NEWLIB
And edit entry of 'General' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
| EntryNumber | StartDate  | ExpirationDate |
| 1           | 12.12.2012 | 22.02.2022     |
Then I 'should' see following data for usage type 'General' on asset '128_shortname.jpg' usage rights page for collection 'Everything'NEWLIB:
| StartDate  | ExpirationDate |
| 12.12.2012 | 22.02.2022     |


Scenario: Check that user can remove usage rights after accept
Meta:@gdam
     @library
Given I created the agency 'A_AUR_S14_1' with default attributes
And created the agency 'A_AUR_S14_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency      |Access|
| AU_AUR_S14_1 | agency.admin | A_AUR_S14_1 |streamlined_library|
| AU_AUR_S14_2 | agency.admin | A_AUR_S14_2 |streamlined_library|
And logged in with details of 'AU_AUR_S14_1'
And uploaded file '/files/128_shortname.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C_AUR_S14_1' category
And on asset '128_shortname.jpg' usage rights page in Library for collection 'C_AUR_S14_1'NEWLIB
And added Usage Right 'General' with following fields on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2002 | 20.02.2020     |
And added agency 'A_AUR_S14_2' to category 'C_AUR_S14_1' on Asset Categories and Permissions page
And logged in with details of 'AU_AUR_S14_2'
When I go to the collections page
And I refresh the page
And I go to the Shared Collection 'C_AUR_S14_1' from agency 'A_AUR_S14_1' pageNEWLIB
And I select asset '128_shortname.jpg' for collection 'C_AUR_S14_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And go to asset '128_shortname.jpg' usage rights page in Library for collection 'Everything'NEWLIB
And delete entry of 'General' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
|  EntryNumber    |
| 1               |
Then I 'should not' see following data for usage type 'General' on asset '128_shortname.jpg' usage rights page for collection 'Everything'NEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2002     |





Scenario: Check that user can find asset by UR after accept
Meta:@gdam
     @library
Given I created the agency 'A_AUR_S15_1' with default attributes
And created the agency 'A_AUR_S15_2' with default attributes
And created users with following fields:
| Email        | Role         | Agency      |Access|
| AU_AUR_S15_1 | agency.admin | A_AUR_S15_1 |streamlined_library|
| AU_AUR_S15_2 | agency.admin | A_AUR_S15_2 |streamlined_library|
And logged in with details of 'AU_AUR_S15_1'
And uploaded file '/files/128_shortname.jpg' into my libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
And created 'C_AUR_S15_1' category
And on asset '128_shortname.jpg' usage rights page in Library for collection 'C_AUR_S15_1'NEWLIB
And added Usage Right 'General' with following fields on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 20.02.2002 | 20.02.2020     |
And added agency 'A_AUR_S15_2' to category 'C_AUR_S15_1' on Asset Categories and Permissions page
And logged in with details of 'AU_AUR_S15_2'
When I go to the collections page
And I go to the Shared Collection 'C_AUR_S15_1' from agency 'A_AUR_S15_1' pageNEWLIB
And I select asset '128_shortname.jpg' for collection 'C_AUR_S15_1' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And I go to the Library page for collection 'My Assets'NEWLIB
And I click on filter link on Collection details for collection 'My Assets'NEWLIB
And I click expand Usage rights on current filter page
And I select usage rights date 'Usage End Date' with value '02/20/20 ' as filter collection 'My Assets'NEWLIB
And I add assets to 'sub' collection 'C_AUR_S15_2' from collection 'My Assets'NEWLIB
Then I 'should' see assets '128_shortname.jpg' in the collection 'C_AUR_S15_2'NEWLIB
And I 'should' see asset count '1' in 'C_AUR_S15_2' NEWLIB

