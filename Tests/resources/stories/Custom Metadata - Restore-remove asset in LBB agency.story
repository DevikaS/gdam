!--NGN-7287
Feature:          Custom Metadata - Restore-remove asset in LBB agency
Narrative:        QA internal task
In order to
As a              GlobalAdmin
I want to         check proper saving and displaying custom metadata in case to remove and restore asset


Scenario: Check that custom data of audio asset is correctly displayed for removed asset opened in Trash bin
Meta:@gdam
@library
Given I created the agency 'A_CMRRA_S01' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_CMRRA_S01':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_CMRRA_S01 | BR_CMRRA_S01 | SBR_CMRRA_S01 | PR_CMRRA_S01 |
And created users with following fields:
| Email       | Role         | AgencyUnique |Access|
| U_CMRRA_S01 | agency.admin | A_CMRRA_S01  |streamlined_library|
And logged in with details of 'U_CMRRA_S01'
And uploaded file '/files/audio01.mp3' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'audio01.mp3' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue    |
| Advertiser | ADV_CMRRA_S01 |
| Brand      | BR_CMRRA_S01  |
| Sub Brand  | SBR_CMRRA_S01 |
| Product    | PR_CMRRA_S01  |
| Product    | PR_CMRRA_S01  |
And I go to the Library page for collection 'My Assets'NEWLIB
And select asset 'audio01.mp3' in the 'My Assets' library pageNEWLIB
And I remove asset in 'My Assets' library page
And I go to library trash pageNEWLIB
And click asset 'audio01.mp3' on library trash pageNEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName  | FieldValue    |
| Advertiser | ADV_CMRRA_S01 |
| Brand      | BR_CMRRA_S01  |
| Sub Brand  | SBR_CMRRA_S01 |
| Product    | PR_CMRRA_S01  |


Scenario: Check that custom data of video asset is saved in case to remove and restore it
Meta:@gdam
@bug
@library
!--UIR-1069
Given I created the agency 'A_CMRRA_S02' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_CMRRA_S02':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_CMRRA_S02 | BR_CMRRA_S02 | SBR_CMRRA_S02 | PR_CMRRA_S02 |
And created users with following fields:
| Email       | Role         | AgencyUnique |Access|
| U_CMRRA_S02 | agency.admin | A_CMRRA_S02  |streamlined_library|
And logged in with details of 'U_CMRRA_S02'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'Fish Ad.mov' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | ADV_CMRRA_S02                    |
| Brand                       | BR_CMRRA_S02                     |
| Sub Brand                   | SBR_CMRRA_S02                    |
| Product                     | PR_CMRRA_S02                     |
| Campaign                    | LBB Campaign                     |
| Title                       | Tortoise Ad.mov                  |
| Category                    | Food                             |
| Air Date                    | 12/12/15                         |
| Shoot Dates                 | 12/12/15                         |
| Country                     | Austria                          |
| Screen                      | Spot                             |
| Clock number                | Clk918                           |
And I go to the Library page for collection 'My Assets'NEWLIB
And select asset 'Tortoise Ad.mov' in the 'My Assets' library pageNEWLIB
And I remove asset in 'My Assets' library page
And I restore assets 'Tortoise Ad.mov' from library trash pageNEWLIB
And go to asset 'Tortoise Ad.mov' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | ADV_CMRRA_S02                    |
| Brand                       | BR_CMRRA_S02                     |
| Sub Brand                   | SBR_CMRRA_S02                    |
| Product                     | PR_CMRRA_S02                     |
| Campaign                    | LBB Campaign                     |
| Title                       | Tortoise Ad.mov                  |
| Category                    | Food                             |
| Air Date                    | 12/12/2015                       |
| Shoot Dates                 | 12/12/2015                       |
| Country                     | Austria                          |
| Screen                      | Spot                             |

Scenario: Check that custom data is saved in case to remove and restore print file
Meta:@gdam
@library
@bug
!--UIR-1069
Given I created the agency 'A_CMRRA_S03' with default attributes
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_CMRRA_S03':
| Advertiser    | Brand        | Sub Brand     | Product      |
| ADV_CMRRA_S03 | BR_CMRRA_S03 | SBR_CMRRA_S03 | PR_CMRRA_S03 |
And created users with following fields:
| Email       | Role         | AgencyUnique |Access|
| U_CMRRA_S03 | agency.admin | A_CMRRA_S03  |streamlined_library|
And logged in with details of 'U_CMRRA_S03'
And uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
And 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | ADV_CMRRA_S03                    |
| Brand                       | BR_CMRRA_S03                     |
| Sub Brand                   | SBR_CMRRA_S03                    |
| Product                     | PR_CMRRA_S03                     |
| Campaign                    | LBB Campaign                     |
| Title                       | Print Ad.pdf                     |
| Country                     | Austria                          |
| Category                    | Food                             |
And I go to the Library page for collection 'My Assets'NEWLIB
And select asset 'Print Ad.pdf' in the 'My Assets' library pageNEWLIB
And I remove asset in 'My Assets' library page
And I restore assets 'Print Ad.pdf' from library trash pageNEWLIB
And go to asset 'Print Ad.pdf' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                   | FieldValue                       |
| Advertiser                  | ADV_CMRRA_S03                    |
| Brand                       | BR_CMRRA_S03                     |
| Sub Brand                   | SBR_CMRRA_S03                    |
| Product                     | PR_CMRRA_S03                     |
| Campaign                    | LBB Campaign                     |
| Title                       | Print Ad.pdf                     |
| Country                     | Austria                          |
| Category                    | Food                             |
