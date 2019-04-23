!--NGN-8649
Feature:          User with inbox.read permission can Reject shared files from Inbox
BookNarrative:
In order to
As a              AgencyAdmin
I want to         check that user with inbox.read permission can Reject shared files from Inbox



Scenario: Check that several assets could be rejected
Meta:@gdam
@library
Given I created the agency 'A_UIRPRSF_S01_1' with default attributes
And created the agency 'A_UIRPRSF_S01_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_UIRPRSF_S01_2 | new-library-dev-version |
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPRSF_S01_1 | agency.admin | A_UIRPRSF_S01_1 |streamlined_library,library|
| U_UIRPRSF_S01_2 | agency.admin | A_UIRPRSF_S01_2 |streamlined_library,library|
And logged in with details of 'U_UIRPRSF_S01_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_UIRPRSF_S01' category
And shared next agencies for following categories:
| CategoryName  | AgencyName      |
| C_UIRPRSF_S01 | A_UIRPRSF_S01_2 |
When I login with details of 'U_UIRPRSF_S01_2'
And I go to the collections page
And I click shared collection 'C_UIRPRSF_S01' on the collection page for Agency 'A_UIRPRSF_S01_1'NEWLIB
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov' for collection 'C_UIRPRSF_S01' in the collections page
And I click 'reject' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
Then I 'should not' see assets with titles 'Fish1-Ad.mov,Fish2-Ad.mov' in Shared Category 'C_UIRPRSF_S01'
And I 'should not' see assets with titles 'Fish1-Ad.mov,Fish2-Ad.mov' in the collection 'Everything'NEWLIB


Scenario: Check that rejected assets doesn't affect original assets in Sender's library in any way
Meta:@gdam
@library
Given I created the agency 'A_UIRPRSF_S02_1' with default attributes
And created the agency 'A_UIRPRSF_S02_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_UIRPRSF_S02_2 | new-library-dev-version |
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPRSF_S02_1 | agency.admin | A_UIRPRSF_S02_1 |streamlined_library,library|
| U_UIRPRSF_S02_2 | agency.admin | A_UIRPRSF_S02_2 |streamlined_library,library|
And logged in with details of 'U_UIRPRSF_S02_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_UIRPRSF_S02' category
And shared next agencies for following categories:
| CategoryName  | AgencyName      |
| C_UIRPRSF_S02 | A_UIRPRSF_S02_2 |
When I login with details of 'U_UIRPRSF_S02_2'
And I go to the collections page
And I click shared collection 'C_UIRPRSF_S02' on the collection page for Agency 'A_UIRPRSF_S02_1'NEWLIB
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov' for collection 'C_UIRPRSF_S02' in the collections page
And I click 'reject' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And login with details of 'U_UIRPRSF_S02_1'
And go to the Library page for collection 'My Assets'NEWLIB
And I refresh the page
Then I 'should' see assets with titles 'Fish1-Ad.mov,Fish2-Ad.mov' in the collection 'My Assets'NEWLIB
When I go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see assets with titles 'Fish1-Ad.mov,Fish2-Ad.mov' in the collection 'Everything'NEWLIB



Scenario: Check that if Sender BU shares another category, where assets previously deleted from Inbox are available, these assets should show in new category. User can delete them again if necessary.
Meta:@gdam
@library
Given I created the agency 'A_UIRPRSF_S03_1' with default attributes
And created the agency 'A_UIRPRSF_S03_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_UIRPRSF_S03_2 | new-library-dev-version |
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPRSF_S03_1 | agency.admin | A_UIRPRSF_S03_1 |streamlined_library,library|
| U_UIRPRSF_S03_2 | agency.admin | A_UIRPRSF_S03_2 |streamlined_library,library|
And logged in with details of 'U_UIRPRSF_S03_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And uploaded file '/files/Fish2-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_UIRPRSF_S03_1' category
And created 'C_UIRPRSF_S03_2' category
And shared next agencies for following categories:
| CategoryName    | AgencyName      |
| C_UIRPRSF_S03_1 | A_UIRPRSF_S03_2 |
When I login with details of 'U_UIRPRSF_S03_2'
And I go to the collections page
And I refresh the page
When I go to the Shared Collection 'C_UIRPRSF_S03_1' from agency 'A_UIRPRSF_S03_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov' for collection 'C_UIRPRSF_S03_1' in the collections page
And I click 'reject' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
And login with details of 'U_UIRPRSF_S03_1'
And shared next agencies for following categories:
| CategoryName    | AgencyName      |
| C_UIRPRSF_S03_2 | A_UIRPRSF_S03_2 |
And I login with details of 'U_UIRPRSF_S03_2'
And I go to the collections page
And I refresh the page
When I go to the Shared Collection 'C_UIRPRSF_S03_2' from agency 'A_UIRPRSF_S03_1' pageNEWLIB
And I select asset 'Fish1-Ad.mov,Fish2-Ad.mov' for collection 'C_UIRPRSF_S03_2' in the collections page
And I click 'reject' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
Then I 'should not' see assets with titles 'Fish1-Ad.mov,Fish2-Ad.mov' in the collection 'Everything'NEWLIB

Scenario: Check that rejected file is removed from inbox and doesn't appear in library
Meta:@gdam
@library
Given I created the agency 'A_UIRPRSF_S04_1' with default attributes
And created the agency 'A_UIRPRSF_S04_2' with default attributes
And updated the following agency:
| Name           | Labels                  |
| A_UIRPRSF_S04_2 | new-library-dev-version |
And created users with following fields:
| Email           | Role         | Agency          |Access|
| U_UIRPRSF_S04_1 | agency.admin | A_UIRPRSF_S04_1 |streamlined_library,library|
| U_UIRPRSF_S04_2 | agency.admin | A_UIRPRSF_S04_2 |streamlined_library,library|
And logged in with details of 'U_UIRPRSF_S04_1'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And created 'C_UIRPRSF_S04' category
And shared next agencies for following categories:
| CategoryName  | AgencyName      |
| C_UIRPRSF_S04 | A_UIRPRSF_S04_2 |
When I login with details of 'U_UIRPRSF_S04_2'
And I go to the collections page
And I click shared collection 'C_UIRPRSF_S04' on the collection page for Agency 'A_UIRPRSF_S04_1'NEWLIB
And I select asset 'Fish1-Ad.mov' for collection 'C_UIRPRSF_S04' in the collections page
And I click 'reject' button for the asset of the shared category on the collection page
And I click 'Yes' button in accept reject assets popup
Then I 'should not' see assets with titles 'Fish1-Ad.mov' in Shared Category 'C_UIRPRSF_S04'
And I 'should not' see assets with titles 'Fish1-Ad.mov' in the collection 'Everything'NEWLIB





