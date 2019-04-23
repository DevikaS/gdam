!--NGN-9744
Feature:          User with inbox.read permission can see Inbox organised by Sender
BookNarrative:
In order to
As a              AgencyAdmin
I want to         check that user with inbox.read permission can see Inbox organised by Sender

Scenario: Check that if 5 categories have been shared from 5 BU to Another BU than in inbox categories will be organised by Sender
Meta: @gdam
@library
Given I created the agency 'A_UIRPSIOS_S01' with default attributes
And created the agency 'A_UIRPSIOS_S01_1' with default attributes
And created the agency 'A_UIRPSIOS_S01_2' with default attributes
And created the agency 'A_UIRPSIOS_S01_3' with default attributes
And created the agency 'A_UIRPSIOS_S01_4' with default attributes
And created the agency 'A_UIRPSIOS_S01_5' with default attributes
And created users with following fields:
| Email            | Role         | Agency           |Access|
| U_UIRPSIOS_S01   | agency.admin | A_UIRPSIOS_S01   |streamlined_library|
| U_UIRPSIOS_S01_1 | agency.admin | A_UIRPSIOS_S01_1 |streamlined_library|
| U_UIRPSIOS_S01_2 | agency.admin | A_UIRPSIOS_S01_2 |streamlined_library|
| U_UIRPSIOS_S01_3 | agency.admin | A_UIRPSIOS_S01_3 |streamlined_library|
| U_UIRPSIOS_S01_4 | agency.admin | A_UIRPSIOS_S01_4 |streamlined_library|
| U_UIRPSIOS_S01_5 | agency.admin | A_UIRPSIOS_S01_5 |streamlined_library|
And logged in with details of 'U_UIRPSIOS_S01_1'
And created 'C_UIRPSIOS_S01_1' category
And shared next agencies for following categories:
| CategoryName     | AgencyName     |
| C_UIRPSIOS_S01_1 | A_UIRPSIOS_S01 |
And logged in with details of 'U_UIRPSIOS_S01_2'
And created 'C_UIRPSIOS_S01_2' category
And shared next agencies for following categories:
| CategoryName     | AgencyName     |
| C_UIRPSIOS_S01_2 | A_UIRPSIOS_S01 |
And logged in with details of 'U_UIRPSIOS_S01_3'
And created 'C_UIRPSIOS_S01_3' category
And shared next agencies for following categories:
| CategoryName     | AgencyName     |
| C_UIRPSIOS_S01_3 | A_UIRPSIOS_S01 |
And logged in with details of 'U_UIRPSIOS_S01_4'
And created 'C_UIRPSIOS_S01_4' category
And shared next agencies for following categories:
| CategoryName     | AgencyName     |
| C_UIRPSIOS_S01_4 | A_UIRPSIOS_S01 |
And logged in with details of 'U_UIRPSIOS_S01_5'
And created 'C_UIRPSIOS_S01_5' category
And shared next agencies for following categories:
| CategoryName     | AgencyName     |
| C_UIRPSIOS_S01_5 | A_UIRPSIOS_S01 |
When I login with details of 'U_UIRPSIOS_S01'
And I go to the collections page
And I refresh the page
Then I 'should' see collection 'C_UIRPSIOS_S01_1' from agency 'A_UIRPSIOS_S01_1' on inbox shared collectionNEWLIB
And I 'should' see collection 'C_UIRPSIOS_S01_2' from agency 'A_UIRPSIOS_S01_2' on inbox shared collectionNEWLIB
And I 'should' see collection 'C_UIRPSIOS_S01_3' from agency 'A_UIRPSIOS_S01_3' on inbox shared collectionNEWLIB
And I 'should' see collection 'C_UIRPSIOS_S01_4' from agency 'A_UIRPSIOS_S01_4' on inbox shared collectionNEWLIB
And I 'should' see collection 'C_UIRPSIOS_S01_5' from agency 'A_UIRPSIOS_S01_5' on inbox shared collectionNEWLIB

!-- NGN-15037 - Confirmed with Maria this is invalid
Scenario: Check that if 1 categories with 5 childs (each child has sub child, at all 5 levels) shared to BU, that in inbox categories should be proper organised
Meta: @skip
      @gdam
Given I created the agency 'A_UIRPSIOS_S02' with default attributes
And created the agency 'A_UIRPSIOS_S02_1' with default attributes
And created users with following fields:
| Email            | Role         | Agency           |
| U_UIRPSIOS_S02   | agency.admin | A_UIRPSIOS_S02   |
| U_UIRPSIOS_S02_1 | agency.admin | A_UIRPSIOS_S02_1 |
And logged in with details of 'U_UIRPSIOS_S02_1'
And created 'C_UIRPSIOS_S02_1' category
And created child category 'C_UIRPSIOS_S02_2' of category 'C_UIRPSIOS_S02_1'
And created child category 'C_UIRPSIOS_S02_3' of category 'C_UIRPSIOS_S02_2'
And created child category 'C_UIRPSIOS_S02_4' of category 'C_UIRPSIOS_S02_3'
And created child category 'C_UIRPSIOS_S02_5' of category 'C_UIRPSIOS_S02_4'
And shared next agencies for following categories:
| CategoryName     | AgencyName     |
| C_UIRPSIOS_S02_1 | A_UIRPSIOS_S02 |
And logged in with details of 'U_UIRPSIOS_S02'
Then I 'should' see that following collections in BU on Shared collections page:
| ParentName       | ChildName        |
| A_UIRPSIOS_S02_1 | C_UIRPSIOS_S02_1 |
| C_UIRPSIOS_S02_1 | C_UIRPSIOS_S02_2 |
| C_UIRPSIOS_S02_2 | C_UIRPSIOS_S02_3 |
| C_UIRPSIOS_S02_3 | C_UIRPSIOS_S02_4 |
| C_UIRPSIOS_S02_4 | C_UIRPSIOS_S02_5 |


Scenario: Check that if shared category have been unshared, than in inbox category should dissapear
Meta: @gdam
@library
Given I created the agency 'A_UIRPSIOS_S03' with default attributes
And created the agency 'A_UIRPSIOS_S03_1' with default attributes
And created users with following fields:
| Email            | Role         | Agency           |Access|
| U_UIRPSIOS_S03   | agency.admin | A_UIRPSIOS_S03   |streamlined_library|
| U_UIRPSIOS_S03_1 | agency.admin | A_UIRPSIOS_S03_1 ||streamlined_library|
And logged in with details of 'U_UIRPSIOS_S03_1'
And created 'C_UIRPSIOS_S03_1' category
And created child category 'C_UIRPSIOS_S03_2' of category 'C_UIRPSIOS_S03_1'
And created child category 'C_UIRPSIOS_S03_3' of category 'C_UIRPSIOS_S03_2'
And created child category 'C_UIRPSIOS_S03_4' of category 'C_UIRPSIOS_S03_3'
And created child category 'C_UIRPSIOS_S03_5' of category 'C_UIRPSIOS_S03_4'
And shared next agencies for following categories:
| CategoryName     | AgencyName     |
| C_UIRPSIOS_S03_1 | A_UIRPSIOS_S03 |
When I remove agency 'A_UIRPSIOS_S03' for category 'C_UIRPSIOS_S03_1'
And login with details of 'U_UIRPSIOS_S03'
And I go to the collections page
Then I should not see shared collection expandableNEWLIB