Feature: User with permission can upload Assets in multiple BUs
Narrative:
In order to work with the system
As a AgencyAdmin
I want to upload Assets in multiple BUs


Scenario: Check that user could upload asset in another BU (different assets scheme video/audio/print)
Meta:@gdam
@library
Given I created the agency 'A_UWPCUAIMBU_S01_1' with default attributes
And created the agency 'A_UWPCUAIMBU_S01_2' with default attributes
And I created users with following fields:
| Email              | Role          | Agency             |Access|
| U_UWPCUAIMBU_S01_1 | agency.admin  | A_UWPCUAIMBU_S01_1 |streamlined_library|
| U_UWPCUAIMBU_S01_2 | agency.admin  | A_UWPCUAIMBU_S01_2 |streamlined_library|
And added agency 'A_UWPCUAIMBU_S01_1' as a partner to agency 'A_UWPCUAIMBU_S01_2'
And logged in with details of 'U_UWPCUAIMBU_S01_1'
And created following categories:
| Name             |
| C_UWPCUAIMBU_S01 |
And I added next users for following categories:
| CategoryName   | UserName            | RoleName      |
| C_UWPCUAIMBU_S01 | U_UWPCUAIMBU_S01_2| library.admin  |
And I edited user 'U_UWPCUAIMBU_S01_2' with following fields:
| Role          |
| agency.admin  |
And logged in with details of 'U_UWPCUAIMBU_S01_2'
When I upload following assets into following agenciesNEWLIB:
| Name              | AgencyName         |
| /files/<FileName> | A_UWPCUAIMBU_S01_1 |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see assets '<FileName>' in the collection 'Everything'NEWLIB
When I login with details of 'U_UWPCUAIMBU_S01_1'
And wait while preview is available in collection 'Everything'NEWLIB
And go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see assets '<FileName>' in the collection 'Everything'NEWLIB
When I go to the Library page for collection 'My Assets'NEWLIB
Then 'should not' see assets '<FileName>' in the collection 'My Assets'NEWLIB
Examples:
| FileName        |
| atCalcImage.jpg |
| audio06.mp3     |
| Fish-Ad.mov     |


Scenario: Check that user could upload asset from one upload pop-up to different BU's
Meta:@gdam
@library
Given I created the agency 'A_UWPCUAIMBU_S02_1' with default attributes
And created the agency 'A_UWPCUAIMBU_S02_2' with default attributes
And created the agency 'A_UWPCUAIMBU_S02_3' with default attributes
And I created users with following fields:
| Email              | Role          | Agency             |Access|
| U_UWPCUAIMBU_S02_1 | agency.admin  | A_UWPCUAIMBU_S02_1 |streamlined_library|
| U_UWPCUAIMBU_S02_2 | agency.admin  | A_UWPCUAIMBU_S02_2 |streamlined_library|
| U_UWPCUAIMBU_S02_3 | agency.admin  | A_UWPCUAIMBU_S02_3 |streamlined_library|
And added agency 'A_UWPCUAIMBU_S02_2,A_UWPCUAIMBU_S02_3' as a partner to agency 'A_UWPCUAIMBU_S02_1'
And logged in with details of 'U_UWPCUAIMBU_S02_1'
And created following categories:
| Name             |
| C_UWPCUAIMBU_S02 |
And I added next users for following categories:
| CategoryName   | UserName            | RoleName      |
| C_UWPCUAIMBU_S02 | U_UWPCUAIMBU_S02_2  | library.admin  |
| C_UWPCUAIMBU_S02 | U_UWPCUAIMBU_S02_3  | library.admin  |
And I edited user 'U_UWPCUAIMBU_S02_2' with following fields:
| Role          |
| agency.admin  |
And logged in with details of 'U_UWPCUAIMBU_S02_2'
When I upload following assets into following agenciesNEWLIB:
| Name                   | AgencyName         |
| /files/atCalcImage.jpg | A_UWPCUAIMBU_S02_1 |
| /files/Fish-Ad.mov     | A_UWPCUAIMBU_S02_3 |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see assets 'atCalcImage.jpg,Fish-Ad.mov' in the collection 'Everything'NEWLIB
When I login with details of 'U_UWPCUAIMBU_S02_1'
And wait while preview is available in collection 'Everything'NEWLIB
And I go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see assets 'atCalcImage.jpg' in the collection 'Everything'NEWLIB
And 'should not' see assets 'Fish-Ad.mov' in the collection 'Everything'NEWLIB
When I login with details of 'U_UWPCUAIMBU_S02_3'
And wait while preview is available in collection 'Everything'NEWLIB
And go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see assets 'Fish-Ad.mov' in the collection 'Everything'NEWLIB
And 'should' see assets 'atCalcImage.jpg' in the collection 'Everything'NEWLIB


Scenario: Check that uploaded asset is available in search
Meta:@gdam
@library
Given I created the agency 'A_UWPCUAIMBU_S03_1' with default attributes
And created the agency 'A_UWPCUAIMBU_S03_2' with default attributes
Given I created users with following fields:
| Email              | Role          | Agency             |Access|
| U_UWPCUAIMBU_S03_1 | agency.admin  | A_UWPCUAIMBU_S03_1 |streamlined_library,dashboard|
| U_UWPCUAIMBU_S03_2 | agency.admin  | A_UWPCUAIMBU_S03_2 |streamlined_library,dashboard|
And added agency 'A_UWPCUAIMBU_S03_2' as a partner to agency 'A_UWPCUAIMBU_S03_1'
And logged in with details of 'U_UWPCUAIMBU_S03_1'
And created following categories:
| Name             |
| C_UWPCUAIMBU_S03 |
And I added next users for following categories:
| CategoryName   | UserName            | RoleName      |
| C_UWPCUAIMBU_S03 | U_UWPCUAIMBU_S03_2  | library.admin  |
And I edited user 'U_UWPCUAIMBU_S03_2' with following fields:
| Role          |
| agency.admin  |
And logged in with details of 'U_UWPCUAIMBU_S03_2'
When I upload following assets into following agenciesNEWLIB:
| Name                   | AgencyName         |
| /files/atCalcImage.jpg | A_UWPCUAIMBU_S03_1 |
| /files/Fish-Ad.mov     | A_UWPCUAIMBU_S03_1 |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see assets 'atCalcImage.jpg,Fish-Ad.mov' in the collection 'Everything'NEWLIB
When I login with details of 'U_UWPCUAIMBU_S03_1'
And I go to Dashboard page
And search by text 'Fish-Ad'
Then I 'should' see search object 'Fish-Ad.mov' with type 'Assets' after wrap according to search 'Fish-Ad' with 'Name' type
When search by text 'atCalcImage'
Then I 'should' see search object 'atCalcImage.jpg' with type 'Assets' after wrap according to search 'atCalcImage' with 'Name' type


Scenario: Check that uploaded asset could be edited (schema should be of current BU and different media types )
Meta:@gdam
@library
Given I created the agency 'A_UWPCUAIMBU_S04_1' with default attributes
And created the agency 'A_UWPCUAIMBU_S04_2' with default attributes
And created following 'common' custom metadata fields for agency 'A_UWPCUAIMBU_S04_1':
| FieldType          | Description            | Choices                                         |
| Dropdown           | DDF UWPCCPIABU S04 1   | DDFV UWPCCPIABU S04 1 1,DDFV UWPCCPIABU S04 1 2 |
| catalogueStructure | CS UWPCCPIABU S04 1   | CS UWPCCPIABU S04 1 1,CS UWPCCPIABU S04 1 2 |
| RadioButtons       | RBF UWPCCPIABU S04 1   | RBFV UWPCCPIABU S04 1 1,RBFV UWPCCPIABU S04 1 2 |
Given I created users with following fields:
| Email              | Role          | Agency             |Access|
| U_UWPCUAIMBU_S04_1 | agency.admin  | A_UWPCUAIMBU_S04_1 |streamlined_library|
| U_UWPCUAIMBU_S04_2 | agency.admin  | A_UWPCUAIMBU_S04_2 |streamlined_library|
And added agency 'A_UWPCUAIMBU_S04_2' as a partner to agency 'A_UWPCUAIMBU_S04_1'
And logged in with details of 'U_UWPCUAIMBU_S04_1'
And created following categories:
| Name             |
| C_UWPCUAIMBU_S04 |
And I added next users for following categories:
| CategoryName   | UserName            | RoleName      |
| C_UWPCUAIMBU_S04 | U_UWPCUAIMBU_S04_2  | library.admin  |
And I edited user 'U_UWPCUAIMBU_S04_2' with following fields:
| Role          |
| agency.admin  |
And logged in with details of 'U_UWPCUAIMBU_S04_2'
When I upload following assets into following agenciesNEWLIB:
| Name              | AgencyName         |
| /files/<FileName> | A_UWPCUAIMBU_S04_1 |
And wait while transcoding is finished in collection 'My Assets'NEWLIB
And go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see assets '<FileName>' in the collection 'Everything'NEWLIB
When I login with details of 'U_UWPCUAIMBU_S04_1'
And wait while preview is available in collection 'Everything'NEWLIB
And I go to asset '<FileName>' info page in Library for collection 'Everything'NEWLIB
And I 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName             | FieldValue                |
| RBF UWPCCPIABU S04 1  | RBFV UWPCCPIABU S04 1 2   |
| DDF UWPCCPIABU S04 1  | DDFV UWPCCPIABU S04 1 2   |
| CS UWPCCPIABU S04 1  | CS UWPCCPIABU S04 1 2   |
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName | FieldValue |
| RBF UWPCCPIABU S04 1  | RBFV UWPCCPIABU S04 1 2   |
| DDF UWPCCPIABU S04 1  | DDFV UWPCCPIABU S04 1 2   |
| CS UWPCCPIABU S04 1  | CS UWPCCPIABU S04 1 2   |

Examples:
| FileName        |
| atCalcImage.jpg |
| Fish-Ad.mov     |
| GWGTest2.pdf    |


Scenario: Check that in uploaded asset could be added relationship
Meta:@gdam
@library
Given I created the agency 'A_UWPCUAIMBU_S05_1' with default attributes
And created the agency 'A_UWPCUAIMBU_S05_2' with default attributes
Given I created users with following fields:
| Email              | Role          | Agency             |Access|
| U_UWPCUAIMBU_S05_1 | agency.admin  | A_UWPCUAIMBU_S05_1 |streamlined_library|
| U_UWPCUAIMBU_S05_2 | agency.admin  | A_UWPCUAIMBU_S05_2 |streamlined_library|
And added agency 'A_UWPCUAIMBU_S05_2' as a partner to agency 'A_UWPCUAIMBU_S05_1'
And logged in with details of 'U_UWPCUAIMBU_S05_1'
And created following categories:
| Name             |
| C_UWPCUAIMBU_S05 |
And I added next users for following categories:
| CategoryName   | UserName            | RoleName      |
| C_UWPCUAIMBU_S05 | U_UWPCUAIMBU_S05_2  | library.admin  |
And I edited user 'U_UWPCUAIMBU_S05_2' with following fields:
| Role          |
| agency.admin  |
And logged in with details of 'U_UWPCUAIMBU_S05_2'
When I upload following assets into following agenciesNEWLIB:
| Name                   | AgencyName         |
| /files/atCalcImage.jpg | A_UWPCUAIMBU_S05_1 |
And I login with details of 'U_UWPCUAIMBU_S05_1'
And wait while preview is available in collection 'Everything'NEWLIB
And attache new file '/files/120.600.gif' into collection 'Everything' for asset 'atCalcImage.jpg' on attachment assets pageNEWLIB
And go to asset 'atCalcImage.jpg' info page in Library for collection 'Everything' on attachment assets pageNEWLIB
Then I 'should' see following count '1' of assets on attachment assets pageNEWLIB

Scenario: Check that in uploaded asset could be added relationship
Meta:@uitobe
@library
@gdam
Given I created the agency 'A_UWPCUAIMBU_S06_1' with default attributes
And created the agency 'A_UWPCUAIMBU_S06_2' with default attributes
Given I created users with following fields:
| Email              | Role          | Agency             |
| U_UWPCUAIMBU_S06_1 | agency.admin  | A_UWPCUAIMBU_S06_1 |
| U_UWPCUAIMBU_S06_2 | agency.admin  | A_UWPCUAIMBU_S06_2 |
And added agency 'A_UWPCUAIMBU_S06_2' as a partner to agency 'A_UWPCUAIMBU_S06_1'
And logged in with details of 'U_UWPCUAIMBU_S06_1'
And created following categories:
| Name             |
| C_UWPCUAIMBU_S06 |
And I added next users for following categories:
| CategoryName   | UserName            | RoleName      |
| C_UWPCUAIMBU_S06 | U_UWPCUAIMBU_S06_2  | library.admin  |
And I edited user 'U_UWPCUAIMBU_S06_2' with following fields:
| Role          |
| agency.admin  |
And logged in with details of 'U_UWPCUAIMBU_S06_2'
When I upload following assets into following agencies:
| Name                   | AgencyName         |
| /files/atCalcImage.jpg | A_UWPCUAIMBU_S06_1 |
| /files/logo1.gif       | A_UWPCUAIMBU_S06_1 |
| /files/_file1.gif      | A_UWPCUAIMBU_S06_1 |
| /images/logo.gif       | A_UWPCUAIMBU_S06_1 |
And I login with details of 'U_UWPCUAIMBU_S06_1'
When wait while preview is available in collection 'Everything'
And go to asset 'atCalcImage.jpg' info page in Library for collection 'Everything' on related assets page
And type related asset '.gif' on related assets page on pop-up
And select following related files 'logo1.gif,_file1.gif,logo.gif' on related asset pop-up
Then I should see following count '3' of related files on assets pop-up

