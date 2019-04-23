!--NGN-2959 NGN-1402
Feature:          Asset - Usage Rights
Narrative:
In order to
As a              AgencyAdmin
I want to         Check usage rights for assets




Scenario: check creation of 'General' usage rights for library asset and activities listed
Meta:@gdam
     @library
!--QA-1150
!--QA-1135
Given updated the following agency:
| Name         | Labels                  |
| DefaultAgency | new-library-dev-version |
And I created users with following fields:
| Email      | Role         | Access          |
| U_LAUR_S01 | agency.admin | streamlined_library  |
And logged in with details of 'U_LAUR_S01'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And refreshed the page without delay
And waited for '2' seconds
Then I 'should' see 'No Usage Rights' on usage rights page for 'Fish Ad.mov' for collection 'My Assets' with following fields
When I add Usage Right 'General' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |
When I go to asset 'Fish Ad.mov' usage rights page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following data for usage type 'General' on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |
When click on activities icon
And refresh the page without delay
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName   | Message                | Value |
| U_LAUR_S01 |Usage Rights Updated by |       |

Scenario: check creation of 'Countries' usage rights for library asset and activities listed
Meta:@gdam
     @library
!--QA-1150
Given updated the following agency:
| Name         | Labels                  |
| DefaultAgency | new-library-dev-version |
And I created users with following fields:
| Email      | Role         | Access          |
| U_LAUR_S04 | agency.admin | streamlined_library  |
And logged in with details of 'U_LAUR_S04'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And refreshed the page without delay
And waited for '2' seconds
When I add Usage Right 'Countries' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |
When I go to asset 'Fish Ad.mov' usage rights page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following data for usage type 'Countries' on opened asset Usage Rights pageNEWLIB:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |
When click on activities icon
And refresh the page without delay
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName   | Message                | Value |
| U_LAUR_S04 |Usage Rights Updated by |       |

Scenario: check creation of 'Media Types' usage rigth for library asset
Meta:@gdam
     @library
!--QA-1149
Given updated the following agency:
| Name         | Labels                  |
| DefaultAgency | new-library-dev-version |
And I created users with following fields:
| Email      | Role         | Access          |
| U_LAUR_S07 | agency.admin | streamlined_library  |
And logged in with details of 'U_LAUR_S07'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And refreshed the page without delay
And waited for '2' seconds
When I add Usage Right 'Media Types' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| Type           | Comment      |
| Generic Master | test comment |
When I go to asset 'Fish Ad.mov' usage rights page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following data for usage type 'Media Types' on opened asset Usage Rights pageNEWLIB:
| Type           | Comment      |
| Generic Master | test comment |
When click on activities icon
And refresh the page without delay
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName   | Message                | Value |
| U_LAUR_S07 |Usage Rights Updated by |       |

Scenario: check creation of 'Visual Talent' usage rights for library asset and listing in Activities tab
Meta:@gdam
     @library
!--QA-1153
Given updated the following agency:
| Name         | Labels                  |
| DefaultAgency | new-library-dev-version |
And I created users with following fields:
| Email      | Role         | Access          |
| U_LAUR_S10 | agency.admin | streamlined_library  |
And logged in with details of 'U_LAUR_S10'
And uploaded asset '/files/_file1.gif' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And refreshed the page without delay
When I add Usage Right 'Visual Talent' for asset '_file1.gif' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And I wait for '2' seconds
Then I 'should' see following data for usage type 'Visual Talent' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
When click on activities icon
And refresh the page
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName   | Message                | Value |
| U_LAUR_S10 |Usage Rights Updated by |       |

Scenario: check creation of 'Music' usage rights for library asset and activity is listed
Meta:@gdam
     @library
!--QA-1150
Given updated the following agency:
| Name         | Labels                  |
| DefaultAgency | new-library-dev-version |
And I created users with following fields:
| Email      | Role         | Access                |
| U_LAUR_S13 | agency.admin |streamlined_library    |
And logged in with details of 'U_LAUR_S13'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And refreshed the page without delay
And waited for '2' seconds
When I add Usage Right 'Music' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
And refresh the page
Then I 'should' see following data for usage type 'Music' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
When click on activities icon
And refresh the page without delay
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName   | Message                | Value |
| U_LAUR_S13 |Usage Rights Updated by |       |

Scenario: check creation of 'Voice-over Artist' usage rights for library asset and listing the same in Activities tab
Meta:@gdam
    @library
!--QA-1153
Given updated the following agency:
| Name         | Labels                  |
| DefaultAgency | new-library-dev-version |
And I created users with following fields:
| Email      | Role         | Access           |
| U_LAUR_S16 | agency.admin | streamlined_library    |
And logged in with details of 'U_LAUR_S16'
And I am on the Library page for collection 'My Assets'NEWLIB
And uploaded asset '/files/logo3.png' into libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'logo3.png'NEWLIB
And refreshed the page
When I add Usage Right 'Voice-over Artist' for asset 'logo3.png' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Mars | Manager | 20.02.2002 | 02.02.2020     | Eric Cartman  | 555-32-80 | eric-c@mail.com | test union | some info |
And I wait for '2' seconds
Then I 'should' see following data for usage type 'Voice-over Artist' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate | Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Mars | Manager | 20.02.2002 | 02.02.2020     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
When click on activities icon
And refresh the page
Then I 'should' see the following activities on asset 'logo3.png' activity page for collection 'My Assets'NEWLIB:
| UserName   | Message                | Value |
| U_LAUR_S16 |Usage Rights Updated by |       |



Scenario: check creation of 'Other usage' usage rights for library asset
Meta:@gdam
    @library
!--QA-1149
Given updated the following agency:
| Name         | Labels                  |
| DefaultAgency | new-library-dev-version |
And I created users with following fields:
| Email      | Role         | Access             |
| U_LAUR_S19 | agency.admin |streamlined_library    |
And logged in with details of 'U_LAUR_S19'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And refreshed the page without delay
And waited for '2' seconds
When I add Usage Right 'Other usage' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| Comment      |
| test comment |
And refresh the page
Then I 'should' see following data for usage type 'Other usage' on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
When click on activities icon
And refresh the page without delay
Then I 'should' see the following activities on asset 'Fish Ad.mov' activity page for collection 'My Assets'NEWLIB:
| UserName   | Message                | Value |
| U_LAUR_S19 |Usage Rights Updated by |       |

Scenario: check you can edit 'Countries' usage rights for library asset and activities listed
Meta:@gdam
    @library
!--QA-1155
Given updated the following agency:
| Name         | Labels                  |
| DefaultAgency | new-library-dev-version |
And I created users with following fields:
| Email      | Role         | Access          |
| U_ECUR_S01 | agency.admin | streamlined_library  |
And logged in with details of 'U_ECUR_S01'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And refreshed the page without delay
And waited for '2' seconds
When I add Usage Right 'Countries' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |
When I go to asset 'Fish Ad.mov' usage rights page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following data for usage type 'Countries' on opened asset Usage Rights pageNEWLIB:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |
When edit entry of 'Countries' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
| Country    | StartDate  | ExpirationDate | EntryNumber   |
| Australia  | 02.02.2000 | 20.02.2010     |  1            |
When I go to asset 'Fish Ad.mov' usage rights page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following data for usage type 'Countries' on opened asset Usage Rights pageNEWLIB:
| Country    | StartDate  | ExpirationDate |
| Australia | 02.02.2000 | 20.02.2010      |
When click on activities icon
And refresh the page without delay
Then I 'should' see the '2' activities on asset 'Fish Ad.mov' activity page for collection 'My Assets':
| UserName   | Message                   | Value |
| U_ECUR_S01 |Usage Rights Updated by |       |

Scenario: check you can edit 'Music' usage rights for library asset and activities listed
Meta:@gdam
    @library
!--QA-1155
Given updated the following agency:
| Name         | Labels                  |
| DefaultAgency | new-library-dev-version |
And I created users with following fields:
| Email      | Role         | Access             |
| U_EMUUR_S1 | agency.admin |streamlined_library    |
And logged in with details of 'U_EMUUR_S1'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And refreshed the page without delay
And waited for '2' seconds
When I add Usage Right 'Music' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
And refresh the page
Then I 'should' see following data for usage type 'Music' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel     | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Randy Marsh | the best song | 20.02.2002 | 02.02.2020     | Sharon Marsh | 1           | testLabel   | testSubLabel | black penguin        | textArranger | 123-ABC    | 111      | some details   | some contacts  |
When edit entry of 'Music' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel      | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails | EntryNumber   |
| Tim Hoare   | the new song  | 20.02.2000 | 02.02.2024     | Joe Marsh    |2            | testABc     | testSubLabel2 | white penguin        | TTArranger | 123-XYZ    | 123      | new details    |  new contacts   | 1             |
And refresh the page
Then I 'should' see following data for usage type 'Music' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | TrackTitle    | StartDate  | ExpirationDate | Composer     | TrackNumber | RecordLabel | SubLabel      | PublicationPublisher | Arranger     | ISRCNumber | Duration | LicenseDetails | ContactDetails |
| Tim Hoare   | the new song  | 20.02.2000 | 02.02.2024     | Joe Marsh    |2            | testABc     | testSubLabel2 | white penguin        | TTArranger | 123-XYZ    | 123      | new details    |  new contacts   |
When click on activities icon
And refresh the page without delay
Then I 'should' see the '2' activities on asset 'Fish Ad.mov' activity page for collection 'My Assets':
| UserName   | Message                   | Value |
| U_EMUUR_S1 |Usage Rights Updated by |       |

Scenario: check you can edit 'Other usage' usage rights for library asset
Meta:@gdam
     @library
!--QA-1154
Given updated the following agency:
| Name         | Labels                  |
| DefaultAgency | new-library-dev-version |
And I created users with following fields:
| Email      | Role         | Access             |
| U_EOUR_S19 | agency.admin |streamlined_library    |
And logged in with details of 'U_EOUR_S19'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And refreshed the page without delay
And waited for '2' seconds
When I add Usage Right 'Other usage' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| Comment      |
| test comment |
And refresh the page
Then I 'should' see following data for usage type 'Other usage' on opened asset Usage Rights pageNEWLIB:
| Comment      |
| test comment |
When edit entry of 'Other usage' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
| Comment      | EntryNumber     |
| new comment  | 1               |
And wait for '2' seconds
Then I 'should' see following data for usage type 'Other usage' on opened asset Usage Rights pageNEWLIB:
| Comment      |
| new comment |


Scenario: check that you can edit 'Media Types' usage rigth for library asset
Meta:@gdam
    @library
!--QA-1154
Given updated the following agency:
| Name         | Labels                  |
| DefaultAgency | new-library-dev-version |
And I created users with following fields:
| Email      | Role         | Access          |
| U_EMTUR_S07 | agency.admin | streamlined_library  |
And logged in with details of 'U_EMTUR_S07'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And refreshed the page without delay
And waited for '2' seconds
When I add Usage Right 'Media Types' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| Type           | Comment      |
| Generic Master | test comment |
Then I 'should' see following data for usage type 'Media Types' on opened asset Usage Rights pageNEWLIB:
| Type           | Comment      |
| Generic Master | test comment |
When edit entry of 'Media Types' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
| Comment      | EntryNumber     |
| new comment  | 1               |
And wait for '2' seconds
Then I 'should' see following data for usage type 'Media Types' on opened asset Usage Rights pageNEWLIB:
| Type           | Comment      |
| Generic Master | new comment |

Scenario: check that you can edit the usage rights for library asset for Visual Talent Usage Rights
Meta:@gdam
    @library
!--QA-1156
Given updated the following agency:
| Name          | Labels                  |
| DefaultAgency | new-library-dev-version |
And I created users with following fields:
| Email        | Role         | Access            |
| U_LUVTUR_S24 | agency.admin | streamlined_library    |
And logged in with details of 'U_LUVTUR_S24'
And uploaded asset '/files/logo2.png' into libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'logo2.png'NEWLIB
And refreshed the page
And added Usage Right 'Visual Talent' for asset 'logo2.png' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| David | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And waited for '2' seconds
Then I 'should' see following data for usage type 'Visual Talent' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| David | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
When edit entry of 'Visual Talent' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role       | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |  EntryNumber    |
| George   | Technician | 20.02.2022 | 02.02.2024     |  Add Cartman  | 555-00-80 | abc@mail.com    | test abc   | test info | 1               |
And wait for '2' seconds
Then I 'should' see following data for usage type 'Visual Talent' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| George   | Technician | 20.02.2022 | 02.02.2024     |  Add Cartman  | 555-00-80 | abc@mail.com    | test abc   | test info |
When click on activities icon
And I refresh the page
Then I 'should' see the '2' activities on asset 'logo2.png' activity page for collection 'My Assets':
| UserName     | Message                   | Value |
| U_LUVTUR_S24 |Usage Rights Updated by |       |

Scenario: check that you can edit the usage rights for library asset for General Usage Rights and activities listed
Meta:@gdam
    @library
!--QA-1155
Given updated the following agency:
| Name          | Labels                  |
| DefaultAgency | new-library-dev-version |
And I created users with following fields:
| Email      | Role         | Access            |
| U_LAUR_S24 | agency.admin | streamlined_library    |
And logged in with details of 'U_LAUR_S24'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And refreshed the page without delay
And waited for '2' seconds
And added Usage Right 'General' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2024     |
And waited for '2' seconds
And added Usage Right 'General' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 01.02.2003 | 20.02.2025    |
And waited for '2' seconds
Then I 'should' see following data for usage type 'General' on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2024     |
When edit entry of 'General' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate | EntryNumber    |
| 02.02.2022 | 28.02.2025     | 1              |
And wait for '2' seconds
Then I 'should' see following data for usage type 'General' on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2022 | 28.02.2025     |
When I go to asset 'Fish Ad.mov' activity page in Library for collection 'My Assets'NEWLIB
Then I 'should' see the '3' activities on asset 'Fish Ad.mov' activity page for collection 'My Assets':
| UserName   | Message                   | Value |
| U_LAUR_S24 |Usage Rights Updated by |       |

Scenario: check that you can edit the usage rights for library asset for Voice-over Artist Usage Rights
Meta:@gdam
    @library
!--QA-1156
Given updated the following agency:
| Name          | Labels                  |
| DefaultAgency | new-library-dev-version |
And I created users with following fields:
| Email        | Role         | Access            |
| U_LUVARUR_S24 | agency.admin | streamlined_library    |
And logged in with details of 'U_LUVARUR_S24'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
And added Usage Right 'Voice-over Artist' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate | Agent   | AgentTel  | Email           | Union      | MoreInfo  |
| Ran  Marsh | Manager | 20.02.2002 | 02.02.2020     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And I waited for '2' seconds
When edit entry of 'Voice-over Artist' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |  EntryNumber    |
| Tom Hanks   | Manager | 20.02.2022 | 02.02.2024     |  Add Cartman  | 555-00-80 | abc@mail.com    | test abc   | test info | 1               |
And I wait for '2' seconds
Then I 'should' see following data for usage type 'Voice-over Artist' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Tom Hanks | Manager | 20.02.2022 | 02.02.2024     |  Add Cartman  | 555-00-80 | abc@mail.com    | test abc   | test info |




Scenario: Check you need to have asset.usage_rights.write to remove a Usage right
Meta:@gdam
    @library
!--QA-1152
Given I created '<roleName>' role with '<Permissions>' permissions in 'library' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email   | Role        | Access               |
| <email> |  <roleName> | streamlined_library   |
When I login with details of '<email>'
And upload following assetsNEWLIB:
| Name             |
| /images/logo.gif |
And refresh the page without delay
And wait for '2' seconds
When I go to asset 'logo.gif' usage rights page in Library for collection 'My Assets'NEWLIB
Then I '<Should>' see add button for usage rights option
When I add Usage Right 'General' for asset 'logo.gif' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |
Then I '<Should>' see remove button for 'General' usage rights option:
|  EntryNumber    |
| 1               |

Examples:
| email     | roleName  | Permissions              | Should     |
| ACURPU4_1 | ACURP4_1  |asset.usage_rights.write  | should     |

Scenario: check that you can delete the usage rights for library asset for Voice-over Artist Usage Rights
Meta:@gdam
    @library
!--QA-1152
Given updated the following agency:
| Name          | Labels                  |
| DefaultAgency | new-library-dev-version |
And I created users with following fields:
| Email        | Role         | Access            |
| U_DUR_S02 | agency.admin | streamlined_library    |
And logged in with details of 'U_DUR_S02'
And uploaded asset '/files/image9.jpg' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And refreshed the page
And added Usage Right 'Voice-over Artist' for asset 'image9.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate | Agent   | AgentTel  | Email           | Union      | MoreInfo  |
| ChristianBale | Manager | 20.02.2002 | 02.02.2020     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And added Usage Right 'Voice-over Artist' for asset 'image9.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| NicolasCage   | Manager | 20.02.2022 | 02.02.2024     |  Add Cartman  | 555-00-80 | abc@mail.com    | test abc   | test info |
And I waited for '2' seconds
Then I 'should' see following data for usage type 'Voice-over Artist' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| ChristianBale   | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And I 'should' see following data for usage type 'Voice-over Artist' on opened asset Usage Rights pageNEWLIB:
| NicolasCage   | Manager | 20.02.2022 | 02.02.2024     |  Add Cartman  | 555-00-80 | abc@mail.com    | test abc   | test info |
When delete entry of 'Voice-over Artist' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
|  EntryNumber    |
| 1               |
And I wait for '2' seconds
Then I 'should' see following data for usage type 'Voice-over Artist' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| ChristianBale   | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And I 'should not' see following data for usage type 'Voice-over Artist' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| NicolasCage   | Manager | 20.02.2022 | 02.02.2024     |  Add Cartman  | 555-00-80 | abc@mail.com    | test abc   | test info |

Scenario: check that you can delete  'Visual Talent' usage rigth for library asset
Meta:@gdam
    @library
!--QA-1152
Given I created users with following fields:
| Email      | Role         | Access          |
| U_DUR_S01 | agency.admin | streamlined_library  |
And logged in with details of 'U_DUR_S01'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And refreshed the page without delay
And waited for '2' seconds
When I add Usage Right 'Visual Talent' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
When I go to asset 'Fish Ad.mov' usage rights page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following data for usage type 'Visual Talent' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
When delete entry of 'Visual Talent' usage rule with following fields on opened asset Usage Rights pageNEWLIB:
|  EntryNumber    |
| 1               |
When I go to asset 'Fish Ad.mov' usage rights page in Library for collection 'My Assets'NEWLIB
Then I 'should not' see following data for usage type 'Visual Talent' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Randy Marsh | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |


Scenario: check creation of usage rights for library asset for multiple entries
Meta:@gdam
    @library
!--QA-1136
Given updated the following agency:
| Name          | Labels                  |
| DefaultAgency | new-library-dev-version |
And I created users with following fields:
| Email      | Role         | Access            |
| U_LAUR_S241 | agency.admin | streamlined_library    |
And logged in with details of 'U_LAUR_S241'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And refreshed the page without delay
And waited for '3' seconds
And added Usage Right 'General' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2024     |
And waited for '2' seconds
And added Usage Right 'General' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 01.02.2002 | 22.02.2020     |
And waited for '2' seconds
And added Usage Right 'Countries' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |
And waited for '2' seconds
And added Usage Right 'Countries' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2004 | 20.02.2022    |
When I go to asset 'Fish Ad.mov' usage rights page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following data for usage type 'Countries' on opened asset Usage Rights pageNEWLIB:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |
| Antarctica | 02.02.2004 | 20.02.2022    |
And I 'should' see following data for usage type 'General' on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2024     |
| 01.02.2002 | 22.02.2020     |


Scenario: check creation of usage rights for library asset for different Groups
Meta:@gdam
    @library
!--QA-1135
Given updated the following agency:
| Name          | Labels                  |
| DefaultAgency | new-library-dev-version |
And I created users with following fields:
| Email      | Role         | Access            |
| U_LAUR_S35 | agency.admin | streamlined_library    |
And logged in with details of 'U_LAUR_S35'
And uploaded asset '/files/Fish9-Ad.mov' into libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish9-Ad.mov'NEWLIB
And refreshed the page
And added Usage Right 'General' for asset 'Fish9-Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |
And added Usage Right 'Countries' for asset 'Fish9-Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |
And added Usage Right 'Media Types' for asset 'Fish9-Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| Type           | Comment      |
| Generic Master | test comment |
And added Usage Right 'Visual Talent' for asset 'Fish9-Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Robert | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And added Usage Right 'Voice-over Artist' for asset 'Fish9-Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate | Agent   | AgentTel  | Email           | Union      | MoreInfo  |
| Russel | Manager | 20.02.2002 | 02.02.2020     | Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
When I go to asset 'Fish9-Ad.mov' usage rights page in Library for collection 'My Assets'NEWLIB
And wait for '2' seconds
Then I 'should' see following data for usage type 'Visual Talent' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Robert | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
And I 'should' see following data for usage type 'Media Types' on opened asset Usage Rights pageNEWLIB:
| Type           | Comment      |
| Generic Master | test comment |
And I 'should' see following data for usage type 'General' on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |
And I 'should' see following data for usage type 'Countries' on opened asset Usage Rights pageNEWLIB:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |
And I 'should' see following data for usage type 'Voice-over Artist' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate | Agent   | AgentTel     | Email           | Union      | MoreInfo  |
| Russel | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |



Scenario: check creation of usage rights for library asset after page refresh
Meta:@gdam
    @library
Given updated the following agency:
| Name         | Labels                  |
| DefaultAgency | new-library-dev-version |
And I created users with following fields:
| Email      | Role         | Access            |
| U_LAUR_S34 | agency.admin | streamlined_library    |
And logged in with details of 'U_LAUR_S34'
And uploaded asset '/files/Fish Ad.mov' into libraryNEWLIB
And waited while preview is visible on library page for collection 'My Assets' for assets 'Fish Ad.mov'NEWLIB
And refreshed the page
And waited for '2' seconds
And added Usage Right 'General' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |
And waited for '2' seconds
And added Usage Right 'Media Types' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| Type           | Comment      |
| Generic Master | test comment |
And added Usage Right 'Countries' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |
And added Usage Right 'Visual Talent' for asset 'Fish Ad.mov' for collection 'My Assets' with following fieldsNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Danzel | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |
When I go to asset 'Fish Ad.mov' usage rights page in Library for collection 'My Assets'NEWLIB
And I refresh the page
Then I 'should' see following data for usage type 'General' on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |
And I 'should' see following data for usage type 'Media Types' on opened asset Usage Rights pageNEWLIB:
| Type           | Comment      |
| Generic Master | test comment |
And I 'should' see following data for usage type 'Countries' on opened asset Usage Rights pageNEWLIB:
| Country    | StartDate  | ExpirationDate |
| Antarctica | 02.02.2002 | 20.02.2020     |
And I 'should' see following data for usage type 'Visual Talent' on opened asset Usage Rights pageNEWLIB:
| ArtistName  | Role    | StartDate  | ExpirationDate |  Agent        | AgentTel  | Email           | Union      | MoreInfo  |
| Danzel | Manager | 20.02.2002 | 02.02.2020     |  Eric Cartman | 555-32-80 | eric-c@mail.com | test union | some info |


Scenario: Check that visibility of Add button and listing of Usage rights in the library depends on 'Usage Rights' permission
Meta:@gdam
     @library
!--QA-1135
Given I created '<roleName>' role with '<Permissions>' permissions in 'library' group for advertiser 'DefaultAgency'
And created users with following fields:
| Email   | Role        | Access               |
| <email> | agency.user | streamlined_library   |
And I created following categories:
| Name     | Advertiser    |
| AVABBUR1 | DefaultAgency |
And uploaded following assetsNEWLIB:
| Name                   |
| /files/Fish1-Ad.mov    |
And waited while transcoding is finished in collection 'AVABBUR1'NEWLIB
And refreshed the page without delay
And waited for '2' seconds
And added Usage Right 'General' for asset 'Fish1-Ad.mov' for collection 'AVABBUR1' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |
And added next users for following categories:
| CategoryName  | UserName | RoleName   |
| AVABBUR1      | <email>  | <roleName> |
When login with details of '<email>'
When I go to asset 'Fish1-Ad.mov' usage rights page in Library for collection 'AVABBUR1'NEWLIB
And wait for '2' seconds
Then '<Should>' see add button for usage rights option
And I '<Condition>' see following data for usage type 'General' on opened asset Usage Rights pageNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |


Examples:
| email       | roleName    | Permissions                                     | Should        | Id         | Condition   |
| AVABBURU4_1 | AVABBURR4_1 | asset.read,asset.write,asset.usage_rights.read  | should not    | AVABBURD4_1 | should     |
| AVABBURU4_2 | AVABBURR4_2 | asset.read,asset.write,asset.usage_rights.write | should        | AVABBURD4_2 | should not  |


Scenario: Check that asset metadata is editable when usage right is added
Meta:@gdam
    @library
Given I created users with following fields:
| Email      | Role         |Access|
| U_LAUR_S242 | agency.admin |streamlined_library|
And logged in with details of 'U_LAUR_S242'
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And added Usage Right 'General' for asset 'image10.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| StartDate  | ExpirationDate |
| 02.02.2002 | 20.02.2020     |
When I go to asset 'image10.jpg' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue   |
| Title      | IMG LAUR S24 |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName  | FieldValue   |
| Title      | IMG LAUR S24 |




Scenario: check creation of 'Countries' usage rigth with value 'Europe' for library asset
Meta:@gdam
    @library
Given I created users with following fields:
| Email      | Role         |Access|
| U_LAUR_S25 | agency.admin |streamlined_library|
And logged in with details of 'U_LAUR_S25'
And uploaded asset '/files/image10.jpg' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I add Usage Right 'Countries' for asset 'image10.jpg' for collection 'My Assets' with following fieldsNEWLIB:
| Country | StartDate  | ExpirationDate |
| Europe  | 2 days ago | 2 days since   |
Then I 'should' see following data for usage type 'Countries' on asset 'image10.jpg' usage rights page for collection 'My Assets'NEWLIB:
| Country | StartDate  | ExpirationDate |
| Europe  | 2 days ago | 2 days since   |