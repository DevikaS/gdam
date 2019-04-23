!--NGN-10988
Feature:          Create Work Request from Library Assets
Narrative:
In order to
As a              AgencyAdmin
I want to         check creation of Work Request from library assets

Lifecycle:
Before:
Given updated the following agency:
| Name     |   Labels  |
| DefaultAgency  | new-library-dev-version,dubbing_services,nVerge,FTP,Physical |


Scenario: Check that 'Create New Work Request' form appears after click on 'Add to Work Request' button
Meta:@gdam
	  @library
Given I uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'image10.jpg' in the 'Everything' library pageNEWLIB
And click Add to Work Request button on 'Everything' library page
Then I 'should' be on the Create New Work Request popup on 'Everything' pageNEWLIB


Scenario: Check mandatory fields on 'Create New Work Request' form
Meta:@gdam
	  @library
Given I uploaded file '/files/image10.jpg' into my libraryNEWLIB
When I select asset 'image10.jpg' in the 'Everything' library pageNEWLIB
And click Add to Work Request button on 'Everything' library page
And I wait for '3' seconds
Then I 'should' see metadata field 'Name,Start date,End date' marked as required on New Worflow Request popup on 'Everything' page



Scenario: Check creation Work Request with non default mandatory fields in CCM schema (e.g Advertisers' family)
Meta:@gdam
	  @projects
Given I created the agency 'A_CWRFLA_S04' with default attributes
And created users with following fields:
| Email        | Role         | Agency       | Access              |
| U_CWRFLA_S04 | agency.admin | A_CWRFLA_S04 | streamlined_library,adkits,folders |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_CWRFLA_S04':
| Advertiser     | Brand        | Sub Brand     | Product      |
| ADV CWRFLA S04 | B CWRFLA S04 | SB CWRFLA S04 | P CWRFLA S04 |
And logged in with details of 'U_CWRFLA_S04'
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
And I have refreshed the page
When I select asset 'image10.jpg' in the 'Everything' library pageNEWLIB
And click Add to Work Request button on 'Everything' library page
And fill following fields on Create New Work Request popup on 'Everything' pagNEWLIB:
| FieldName  | FieldValue     |
| Start date | Today          |
| End date   | Tomorrow       |
| Name       | WR_CWRFLA_S04  |
| Media type | Broadcast      |
And I go to work request 'WR_CWRFLA_S04' overview page
Then I 'should' see following fields on opened Work Request Overview page:
| FieldName  | FieldValue     |
| Name       | WR_CWRFLA_S04  |
| Media type | Broadcast      |


Scenario: Check adding T&C for Work Request
Meta:@gdam
	  @projects
Given I created the agency 'A_CWRFLA_S05' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |  Access              |
| U_CWRFLA_S05 | agency.admin | A_CWRFLA_S05 |streamlined_library,adkits,folders |
And logged in with details of 'U_CWRFLA_S05'
And on the T&C page
And enabled current terms and conditions for projects on opened T&C page
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When I select asset 'image10.jpg' in the 'My Assets' library pageNEWLIB
And click Add to Work Request button on 'My Assets' library page
And fill following fields on Create New Work Request popup on 'My Assets' pagNEWLIB:
| FieldName          | FieldValue     |
| Name               | WR_CWRFLA_S05  |
| Media type         | Broadcast      |
| Start date         | Today          |
| End date           | Tomorrow       |
| Terms & Conditions | TnC CWRFLA S05 |
| Job number               | JN_01  |
Then 'should' see agency Terms and Conditions text 'TnC CWRFLA S05' on opened Terms and Conditions popup


Scenario: Check that you can assign project owner on 'Create New Work Request' form
Meta:@gdam
@bug
@projects
!--UIR-1043
Given I created users with following fields:
| Email        |  Access              |
| U_CWRFLA_S06 | streamlined_library,library,adkits,folders |
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'image10.jpg' in the 'Everything' library pageNEWLIB
And click Add to Work Request button on 'Everything' library page
And fill following fields on Create New Work Request popup on 'Everything' pagNEWLIB:
| FieldName    |  FieldValue    |
| Work request project administrators | U_CWRFLA_S06 |
| Name         |  WR_CWRFLA_S06 |
| Media type   |  Broadcast     |
| Start date   |  Today         |
| End date     |  Tomorrow      |
Then I 'should' see following fields on opened Work Request Overview page:
| FieldName      | FieldValue                |
| Name           | WR_CWRFLA_S06             |
| Project Owners | AgencyAdmin,U_CWRFLA_S06  |

Scenario: Check that created Work Request is in unpublished state
Meta:@gdam
@projects
Given I uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When I select asset 'image10.jpg' in the 'My Assets' library pageNEWLIB
And click Add to Work Request button on 'My Assets' library page
And fill following fields on Create New Work Request popup on 'My Assets' pagNEWLIB:
| FieldName  | FieldValue    |
| Name       | WR_CWRFLA_S07_11 |
| Media type | Broadcast     |
| Start date | Today         |
| End date   | Tomorrow      |
And I wait for '2' seconds
And I go to work request 'WR_CWRFLA_S07_11' overview page
Then I 'should' see 'Publish' button on Work Request 'WR_CWRFLA_S07_11' Overview page



Scenario: Check that selected assets copied to 'Originals' folder of Work Request
Meta:@gdam
@projects
Given I uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When I select asset 'image10.jpg' in the 'My Assets' library pageNEWLIB
And click Add to Work Request button on 'My Assets' library page
And fill following fields on Create New Work Request popup on 'My Assets' pagNEWLIB:
| FieldName  | FieldValue    |
| Name       | WR_CWRFLA_S08 |
| Media type | Broadcast     |
| Start date | Today         |
| End date   | Tomorrow      |
Then I 'should' see file 'image10.jpg' on work request 'WR_CWRFLA_S08' folder '/Originals' files page


Scenario: Check permission on file added to Work Request
Meta:@gdam
@projects
Given I uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When I select asset 'image10.jpg' in the 'My Assets' library pageNEWLIB
And click Add to Work Request button on 'My Assets' library page
And fill following fields on Create New Work Request popup on 'My Assets' pagNEWLIB:
| FieldName  | FieldValue    |
| Name       | WR_CWRFLA_S09 |
| Media type | Broadcast     |
| Start date | Today         |
| End date   | Tomorrow      |
And I go to work request 'WR_CWRFLA_S09' overview page
And go to file 'image10.jpg' info page in folder '/Originals' work request 'WR_CWRFLA_S09'
Then I 'should' see Edit link on opened asset info page

Scenario: Check download master/proxy from Work Request
Meta:@gdam
@projects
Given I created 'GR_CWRFLA_S10' role in 'global' group for advertiser 'DefaultAgency' with following permissions:
| Permission                     |
| adkit.create                   |
| adkit.delete                   |
| adkit.read                     |
| adkit.write                    |
| agency_team.read               |
| asset.create                   |
| asset_filter_collection.create |
| dictionary.read                |
| enum.create                    |
| enum.read                      |
| enum.write                     |
| group.agency_enums.read        |
| presentation.create            |
| project.create                 |
| project_template.create        |
| role.read                      |
| user.invite                    |
| user.read                      |
| user_group.read                |
And created users with following fields:
| Email       | Role          | Access          |
| <UserEmail> | GR_CWRFLA_S10 | folders,streamlined_library,adkits |
And created '<LibraryRole>' role in 'library' group for advertiser 'DefaultAgency' with following permissions:
| Permission                 |
| asset.read                 |
| asset.share                |
| asset.write                |
| asset_filter_category.read |
| proxy.download             |
| <Permission>               |
And created 'C_CWRFLA_S10' category
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'C_CWRFLA_S10'NEWLIB
And added users '<UserEmail>' for category 'C_CWRFLA_S10' with role '<LibraryRole>'
And logged in with details of '<UserEmail>'
And I am on the Library page for collection 'C_CWRFLA_S10'NEWLIB
And I have refreshed the page
And I selected asset 'image10.jpg' in the 'C_CWRFLA_S10' library pageNEWLIB
And clicked Add to Work Request button on 'C_CWRFLA_S10' library page
And I filled following fields on Create New Work Request popup on 'C_CWRFLA_S10' pageNEWLIB:
| FieldName  | FieldValue        |
| Name       | <WorkRequestName> |
| Media type | Broadcast         |
| Start date | Today             |
| End date   | Tomorrow          |
When I go to work request '<WorkRequestName>' overview page
Then I '<Condition>' see Download Original button on file 'image10.jpg' info page in folder '/Originals' work request '<WorkRequestName>'
And '<Condition>' see Download link for 'original' type on Download popup on file 'image10.jpg' info page for work request '<WorkRequestName>' folder '/Originals'
When I go to work request '<WorkRequestName>' folder '/Originals' page
And select file 'image10.jpg' on work request files page
Then I '<Condition>' see Download link for 'original' type on Download popup for work request '<WorkRequestName>' folder '/Originals'

Examples:
| UserEmail      | LibraryRole     | Permission    | WorkRequestName | Condition  |
| U_CWRFLA_S10_1 | LR_CWRFLA_S10_1 | file.download | WR_CWRFLA_S10_1 | should     |
| U_CWRFLA_S10_2 | LR_CWRFLA_S10_2 |               | WR_CWRFLA_S10_2 | should not |





Scenario: Check sharing folder in Work Request (whole folder hierarchy)
Meta:@gdam
@projects
Given I created users with following fields:
| Email        | Role        | Access          |
| U_CWRFLA_S11 | agency.user | library,folders |
And created 'WR_CWRFLA_S11' work request
And created '/PF_CWRFLA_S11/CF_CWRFLA_S11_11/CF_CWRFLA_S11_12' folder for work request 'WR_CWRFLA_S11'
And created '/PF_CWRFLA_S11/CF_CWRFLA_S11_21/CF_CWRFLA_S11_22' folder for work request 'WR_CWRFLA_S11'
And I am on work request 'WR_CWRFLA_S11' folder '/PF_CWRFLA_S11' page
When I open share popup in work request 'WR_CWRFLA_S11' for folder '/PF_CWRFLA_S11' from root work request
And fill Share window of project folder for following users:
| User         | Role         | ExpiredDate | ShouldAccess |
| U_CWRFLA_S11 | Project User |             | should       |
And click element 'Add' on page 'ShareWindow'
And login with details of 'U_CWRFLA_S11'
Then I 'should' see following folders in 'WR_CWRFLA_S11' work request:
| folder                                           |
| /PF_CWRFLA_S11/CF_CWRFLA_S11_11/CF_CWRFLA_S11_12 |
| /PF_CWRFLA_S11/CF_CWRFLA_S11_21/CF_CWRFLA_S11_22 |


Scenario: Check sharing folder in Work Request to user from another BU
Meta:@gdam
@projects
Given I created the agency 'A_CWRFLA_S12' with default attributes
And created users with following fields:
| Email        | Role        | Access          | Agency       |
| U_CWRFLA_S12 | agency.user | library,folders | A_CWRFLA_S12 |
And created 'WR_CWRFLA_S12' work request
And created '/PF_CWRFLA_S12/CF_CWRFLA_S12_11/CF_CWRFLA_S12_12' folder for work request 'WR_CWRFLA_S12'
And created '/PF_CWRFLA_S12/CF_CWRFLA_S12_21/CF_CWRFLA_S12_22' folder for work request 'WR_CWRFLA_S12'
And I am on work request 'WR_CWRFLA_S12' folder '/PF_CWRFLA_S12' page
When I open share popup in work request 'WR_CWRFLA_S12' for folder '/PF_CWRFLA_S12' from root work request
And fill Share window of project folder for following users:
| User         | Role         | ExpiredDate | ShouldAccess |
| U_CWRFLA_S12 | Project User |             | should       |
And click element 'Add' on page 'ShareWindow'
And login with details of 'U_CWRFLA_S12'
Then I 'should' see following folders in 'WR_CWRFLA_S12' work request:
| folder                                           |
| /PF_CWRFLA_S12/CF_CWRFLA_S12_11/CF_CWRFLA_S12_12 |
| /PF_CWRFLA_S12/CF_CWRFLA_S12_21/CF_CWRFLA_S12_22 |


Scenario: Check Work Request search
Meta:@gdam
@projects
!--NGN-10651 NGN-10733
Given I created the agency 'A_CWRFLA_S13' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |
| U_CWRFLA_S13 | agency.admin | A_CWRFLA_S13 |
And logged in with details of 'U_CWRFLA_S13'
And created 'WR_CWRFLA_S13 1' work request
And created 'WR_CWRFLA_S13 2' work request
And created 'WR_CWRFLA_S13 3' work request
And created '/F_CWRFLA_S13' folder for work request 'WR_CWRFLA_S13 1'
And created '/F_CWRFLA_S13' folder for work request 'WR_CWRFLA_S13 2'
And created '/F_CWRFLA_S13' folder for work request 'WR_CWRFLA_S13 3'
When I search by text 'WR_CWRFLA_S13'
And click show all link for global user search
Then I 'should' see following projects on the project search page 'WR_CWRFLA_S13 1,WR_CWRFLA_S13 2,WR_CWRFLA_S13 3'


Scenario: Check Work Request search at copying file (Project - Work Request)
Meta:@gdam
@projects
!--NGN-10787
Given I created the agency 'A_CWRFLA_S14' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |
| U_CWRFLA_S14 | agency.admin | A_CWRFLA_S14 |
And logged in with details of 'U_CWRFLA_S14'
And created 'P_CWRFLA_S14' project
And created '/F_CWRFLA_S14' folder for project 'P_CWRFLA_S14'
And uploaded '/files/image10.jpg' file into '/F_CWRFLA_S14' folder for 'P_CWRFLA_S14' project
And created 'WR_CWRFLA_S14 1' work request
And created 'WR_CWRFLA_S14 2' work request
And created 'WR_CWRFLA_S14 3' work request
And created '/F_CWRFLA_S14' folder for work request 'WR_CWRFLA_S14 1'
And created '/F_CWRFLA_S14' folder for work request 'WR_CWRFLA_S14 2'
And created '/F_CWRFLA_S14' folder for work request 'WR_CWRFLA_S14 3'
And created '/F_CWRFLA_S14' folder for work request 'WR_CWRFLA_S14 1'
And waited while transcoding is finished in folder '/F_CWRFLA_S14' on project 'P_CWRFLA_S14' files page
And I am on project 'P_CWRFLA_S14' folder '/F_CWRFLA_S14' page
When I click on Want to copy files to another project link on move/copy file 'image10.jpg' popup
And I type 'WR_CWRFLA_S14' in search field on move/copy file popup
Then I should see 'WR_CWRFLA_S14 1,WR_CWRFLA_S14 2,WR_CWRFLA_S14 3' are available for selecting in search projects on move/copy file popup


Scenario: Check Work Request search at moving file (Project - Work Request)
Meta:@gdam
@projects
!--NGN-10787
Given I created the agency 'A_CWRFLA_S15' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |
| U_CWRFLA_S15 | agency.admin | A_CWRFLA_S15 |
And logged in with details of 'U_CWRFLA_S15'
And created 'P_CWRFLA_S15' project
And created '/F_CWRFLA_S15' folder for project 'P_CWRFLA_S15'
And uploaded '/files/image10.jpg' file into '/F_CWRFLA_S15' folder for 'P_CWRFLA_S15' project
And created 'WR_CWRFLA_S15 1' work request
And created 'WR_CWRFLA_S15 2' work request
And created 'WR_CWRFLA_S15 3' work request
And created '/F_CWRFLA_S15' folder for work request 'WR_CWRFLA_S15 1'
And created '/F_CWRFLA_S15' folder for work request 'WR_CWRFLA_S15 2'
And created '/F_CWRFLA_S15' folder for work request 'WR_CWRFLA_S15 3'
And created '/F_CWRFLA_S15' folder for work request 'WR_CWRFLA_S15 1'
And waited while transcoding is finished in folder '/F_CWRFLA_S15' on project 'P_CWRFLA_S15' files page
And I am on project 'P_CWRFLA_S15' folder '/F_CWRFLA_S15' page
When I click on Want to move files to another project link on move/copy file 'image10.jpg' popup
And I type 'WR_CWRFLA_S15' in search field on move/copy file popup
Then I should see 'WR_CWRFLA_S15 1,WR_CWRFLA_S15 2,WR_CWRFLA_S15 3' are available for selecting in search projects on move/copy file popup


Scenario: Check Work Request search at moving assets to project (move to Work Request from Library)
Meta:@gdam
@library
!--NGN-10651 NGN-10733
Given I created the agency 'A_CWRFLA_S16' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |Access|
| U_CWRFLA_S16 | agency.admin | A_CWRFLA_S16 |streamlined_library,adkits,folders|
And logged in with details of 'U_CWRFLA_S16'
And created 'CWRFLA Project' project
And created '/F_CWRFLA_S16' folder for project 'CWRFLA Project'
And created 'CWRFLA Work Request' work request
And created '/F_CWRFLA_S16' folder for project 'CWRFLA Work Request'
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When I go to the library page for collection 'My Assets'NEWLIB
Then I 'should' see following search results for text 'CWRFLA' while adding asset 'image10.jpg' from collection 'My Assets' pageNEWLIB:
|SearchResults|
|CWRFLA Work Request   |
|CWRFLA Project   |



Scenario: Check that uploaded brief file appears in 'Brief' folder
Meta:@gdam
@projects
When I open Create New Work Request popup
And fill following fields on Create New Work Request popup:
| FieldName  | FieldValue     |
| Name       | WR_CWRFLA_S17  |
| Media type | Broadcast      |
| Start date | Today          |
| End date   | Tomorrow       |
And upload brief '/files/image10.jpg' on opened create work request popup
And click Save button on opened Create Work Request popup
And wait while transcoding is finished on Work request 'WR_CWRFLA_S17' in folder '/Brief' for 'image10.jpg' file
Then I 'should' see file 'image10.jpg' on work request 'WR_CWRFLA_S17' folder '/Brief' files page


Scenario: Check that button delete is present next to 'Brief' field
Meta:@gdam
@projects
When I open Create New Work Request popup
And upload brief '/files/image10.jpg' on opened create work request popup
Then I 'should' see remove button next to uploaded brief on Work Request edit popup


Scenario: Check assets having common metadata are auto populated when adding to new work request
Meta:@gdam
@projects
Given I created the following agency:
| Name         | A4User        |
| A_CWRFLA_S18 | DefaultA4User |
And created users with following fields:
| Email        | Role         | AgencyUnique |Access|
| U_CWRFLA_S18 | agency.admin | A_CWRFLA_S18 |folders,adkits,streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_CWRFLA_S18':
| Advertiser | Brand     | Sub Brand | Product   |
| CWRFLAAR1  | CWRFLABR1 | CWRFLASB1 | CWRFLAPR1 |
And logged in with details of 'U_CWRFLA_S18'
And I uploaded following assetsNEWLIB:
| Name                |
| /files/Fish Ad.mov  |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When I 'save' asset 'Fish Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName  | FieldValue |
| Advertiser | CWRFLAAR1  |
| Brand      | CWRFLABR1  |
| Sub Brand  | CWRFLASB1  |
| Product    | CWRFLAPR1  |
| Clock number    | CWR_C1  |
And 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName  | FieldValue |
| Advertiser | CWRFLAAR1  |
| Brand      | CWRFLABR1  |
| Sub Brand  | CWRFLASB1  |
| Product    | CWRFLAPR1  |
| Clock number    | CWR_C2  |
And I select asset 'Fish Ad.mov,Fish1-Ad.mov' in the 'My Assets'  library pageNEWLIB
Then I 'should' see following fields with value on work request popup from collection 'My Assets'NEWLIB:
| FieldName  | FieldValue     |
| Advertiser | CWRFLAAR1  |
| Brand      | CWRFLABR1  |
| Sub Brand  | CWRFLASB1  |
| Product    | CWRFLAPR1  |
When I fill following fields on Create New Work Request popup on 'My Assets' pagNEWLIB:
| FieldName  | FieldValue     |
| Name       | WR_CWRFLA_S18  |
| Media type | Broadcast      |
| Start date | Today          |
| End date   | Tomorrow       |
And I go to work request 'WR_CWRFLA_S18' overview page
Then I 'should' see following fields on opened Work Request Overview page:
| FieldName  | FieldValue    |
| Name       | WR_CWRFLA_S18 |
| Advertiser | CWRFLAAR1     |
| Brand      | CWRFLABR1     |
| Sub Brand  | CWRFLASB1     |
| Product    | CWRFLAPR1     |


Scenario: Check assets not having common metadata shouldn't auto populate when adding to new work request
Meta:@gdam
@projects
Given I created the following agency:
| Name         | A4User        |
| A_CWRFLA_S19 | DefaultA4User |
And created users with following fields:
| Email        | Role         | AgencyUnique |Access|
| U_CWRFLA_S19 | agency.admin | A_CWRFLA_S19 |folders,adkits,streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_CWRFLA_S19':
| Advertiser | Brand     | Sub Brand | Product   |
| CWRFLAAR1  | CWRFLABR1 | CWRFLASB1 | CWRFLAPR1 |
| CWRFLAAR2  | CWRFLABR2 | CWRFLASB2 | CWRFLAPR2 |
And logged in with details of 'U_CWRFLA_S19'
And I uploaded following assetsNEWLIB:
| Name                |
| /files/Fish Ad.mov  |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When I 'save' asset 'Fish Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName  | FieldValue |
| Advertiser | CWRFLAAR1  |
| Brand      | CWRFLABR1  |
| Sub Brand  | CWRFLASB1  |
| Product    | CWRFLAPR1  |
And I refresh the page
And 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName  | FieldValue |
| Advertiser | CWRFLAAR2  |
| Brand      | CWRFLABR2  |
| Sub Brand  | CWRFLASB2  |
| Product    | CWRFLAPR2  |
And I select asset 'Fish Ad.mov,Fish1-Ad.mov' in the 'My Assets'  library pageNEWLIB
Then I 'should' see following fields with value on work request popup from collection 'My Assets'NEWLIB:
| FieldName  | FieldValue |
| Advertiser |            |
| Brand      |            |
| Sub Brand  |            |
| Product    |            |
When I fill following fields on Create New Work Request popup on 'My Assets' pagNEWLIB:
| FieldName  | FieldValue     |
| Name       | WR_CWRFLA_S19  |
| Media type | Broadcast      |
| Start date | Today          |
| End date   | Tomorrow       |
And I go to work request 'WR_CWRFLA_S19' overview page
Then I 'should' see following fields on opened Work Request Overview page:
| FieldName  | FieldValue    |
| Name       | WR_CWRFLA_S19 |
And 'should not' see following fields on opened Work Request Overview page:
| FieldName  | FieldValue    |
| Advertiser |               |
| Brand      |               |
| Sub Brand  |               |
| Product    |               |

Scenario: Check assets having common metadata which are auto populated on new work request pop-up can be changed
Meta:@gdam
@projects
Given I created the following agency:
| Name         | A4User        |
| A_CWRFLA_S20 | DefaultA4User |
And created users with following fields:
| Email        | Role         | AgencyUnique |Access|
| U_CWRFLA_S20 | agency.admin | A_CWRFLA_S20 |folders,adkits,streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'A_CWRFLA_S20':
| Advertiser | Brand     | Sub Brand | Product   |
| CWRFLAAR1  | CWRFLABR1 | CWRFLASB1 | CWRFLAPR1 |
| CWRFLAAR2  | CWRFLABR2| CWRFLASB2 | CWRFLAPR2|
And logged in with details of 'U_CWRFLA_S20'
And I uploaded following assetsNEWLIB:
| Name                |
| /files/Fish Ad.mov  |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When I 'save' asset 'Fish Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName  | FieldValue |
| Advertiser | CWRFLAAR1  |
| Brand      | CWRFLABR1  |
| Sub Brand  | CWRFLASB1  |
| Product    | CWRFLAPR1  |
And 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName  | FieldValue |
| Advertiser | CWRFLAAR1  |
| Brand      | CWRFLABR1  |
| Sub Brand  | CWRFLASB1  |
| Product    | CWRFLAPR1  |
And I select asset 'Fish Ad.mov,Fish1-Ad.mov' in the 'My Assets'  library pageNEWLIB
And I click Add to Work Request button on 'My Assets' library page
And I fill following fields on Create New Work Request popup on 'My Assets' pagNEWLIB:
| FieldName  | FieldValue     |
| Advertiser |  CWRFLAAR2              |
| Brand      |  CWRFLABR2              |
| Sub Brand  |  CWRFLASB2              |
| Product    |   CWRFLAPR2             |
| Name       | WR_CWRFLA_S20  |
| Media type | Broadcast      |
| Start date | Today          |
| End date   | Tomorrow       |
And I go to work request 'WR_CWRFLA_S20' overview page
Then I 'should' see following fields on opened Work Request Overview page:
| FieldName  | FieldValue    |
| Name       | WR_CWRFLA_S20 |
| Advertiser |   CWRFLAAR2            |
| Brand      |    CWRFLABR2           |
| Sub Brand  |    CWRFLASB2           |
| Product    |    CWRFLAPR2           |

Scenario: Check that created Work Request is not in unpublished state when it is published
Meta:@gdam
@projects
Given I uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And I have refreshed the page
When I select asset 'image10.jpg' in the 'My Assets' library pageNEWLIB
And click Add to Work Request button on 'My Assets' library page
And fill following fields on Create New Work Request popup on 'My Assets' pagNEWLIB:
| FieldName  | FieldValue    |
| Name       | WR_CWRFLA_S07_1 |
| Media type | Broadcast     |
| Start date | Today         |
| End date   | Tomorrow      |
| Publish Immediately   | true      |
And I go to work request 'WR_CWRFLA_S07_1' overview page
Then I 'should' see 'Unpublish' button on Work Request Template 'WR_CWRFLA_S07_1' Overview page

