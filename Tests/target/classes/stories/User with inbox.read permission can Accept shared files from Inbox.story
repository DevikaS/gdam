!--NGN-9525
Feature:          User with inbox.read permission can Accept shared files from Inbox
BookNarrative:
In order to
As a              AgencyAdmin
I want to         check that user with inbox.read permission can Accept shared files from Inbox


Scenario: Check that asset dissapears from inbox and appears in library with preview
Meta: @gdam
@library
Given I created the agency 'A_UIRPASF_S01_1' with default attributes
And created the agency 'A_UIRPASF_S01_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_UIRPASF_S01_2 | new-library-dev-version |
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPASF_S01_1 | agency.admin | A_UIRPASF_S01_1 |streamlined_library,library|
| U_UIRPASF_S01_2 | agency.admin | A_UIRPASF_S01_2 |streamlined_library,library|
And logged in with details of 'U_UIRPASF_S01_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_UIRPASF_S01' category
And shared next agencies for following categories:
| CategoryName  | AgencyName      |
| C_UIRPASF_S01 | A_UIRPASF_S01_2 |
When I login with details of 'U_UIRPASF_S01_2'
And I go to the collections page
And I click shared collection 'C_UIRPASF_S01' on the collection page for Agency 'A_UIRPASF_S01_1'NEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_UIRPASF_S01' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
Then I 'should not' see assets with titles 'Fish1-Ad.mov' in Shared Category 'C_UIRPASF_S01'
When I go to the Library pageNEWLIB
Then I 'should' see assets with titles 'Fish1-Ad.mov' in the collection 'Everything'NEWLIB


Scenario: Check accept button from asset details
Meta: @gdam
@library
Given I created the agency 'A_UIRPASF_S02_1' with default attributes
And created the agency 'A_UIRPASF_S02_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_UIRPASF_S02_2 | new-library-dev-version |
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPASF_S02_1 | agency.admin | A_UIRPASF_S02_1 |streamlined_library,library|
| U_UIRPASF_S02_2 | agency.admin | A_UIRPASF_S02_2 |streamlined_library,library|
And logged in with details of 'U_UIRPASF_S02_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_UIRPASF_S02' category
And shared next agencies for following categories:
| CategoryName  | AgencyName      |
| C_UIRPASF_S02 | A_UIRPASF_S02_2 |
When I login with details of 'U_UIRPASF_S02_2'
And I go to the collections page
And I click shared collection 'C_UIRPASF_S02' on the collection page for Agency 'A_UIRPASF_S02_1'NEWLIB
And click asset 'Fish1-Ad.mov' on the collection page
And I click 'accept' button for the asset of the shared category on the asset info page
And I click 'yes' button in accept reject assets in assets info page
Then I 'should not' see assets 'Fish1-Ad.mov' on Shared collection pageNEWLIB
When I go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see assets with titles 'Fish1-Ad.mov' in the collection 'Everything'NEWLIB

Scenario: Check that several assets could be accepted
Meta: @gdam
@library
Given I created the agency 'A_UIRPASF_S03_1' with default attributes
And created the agency 'A_UIRPASF_S03_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_UIRPASF_S03_2 | new-library-dev-version |
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPASF_S03_1 | agency.admin | A_UIRPASF_S03_1 |streamlined_library,library|
| U_UIRPASF_S03_2 | agency.admin | A_UIRPASF_S03_2 |streamlined_library,library|
And logged in with details of 'U_UIRPASF_S03_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_UIRPASF_S03' category
And shared next agencies for following categories:
| CategoryName  | AgencyName      |
| C_UIRPASF_S03 | A_UIRPASF_S03_2 |
When I login with details of 'U_UIRPASF_S03_2'
And I go to the collections page
And I click shared collection 'C_UIRPASF_S03' on the collection page for Agency 'A_UIRPASF_S03_1'NEWLIB
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov' for collection 'C_UIRPASF_S03' in the collections page
And I click 'accept' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
Then I 'should not' see assets with titles 'Fish1-Ad.mov,Fish2-Ad.mov' in Shared Category 'C_UIRPASF_S03'
When I go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see assets with titles 'Fish1-Ad.mov,Fish2-Ad.mov' in the collection 'Everything'NEWLIB




Scenario: Check that shared category doesn't visible in library
Meta: @gdam
@library
Given I created the agency 'A_UIRPASF_S04_1' with default attributes
And created the agency 'A_UIRPASF_S04_2' with default attributes
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPASF_S04_1 | agency.admin | A_UIRPASF_S04_1 |streamlined_library,library|
| U_UIRPASF_S04_2 | agency.admin | A_UIRPASF_S04_2 |streamlined_library,library|
And logged in with details of 'U_UIRPASF_S04_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_UIRPASF_S04' category
And shared next agencies for following categories:
| CategoryName  | AgencyName      |
| C_UIRPASF_S04 | A_UIRPASF_S04_2 |
When I login with details of 'U_UIRPASF_S04_2'
When I go to the collections page
Then I 'should not' see list of collections 'C_UIRPASF_S04' on the collection pageNEWLIB

