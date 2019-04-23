!--NGN-10626
Feature:          Global Admin - Auto-accept shared categories
Narrative:
In order to
As a              GlobalAdmin
I want to         Check that global admin can setup auto-accept shared categories for BU


Scenario: check that auto-accept is false by default
Meta:@globaladmin
     @gdam
Given I created the agency 'A_GAAASC_S01' with default attributes
And logged in with details of 'GlobalAdmin'
When I go to agency 'A_GAAASC_S01' overview page
Then I 'should' see following fields on agency overview page:
| FieldName                     | FieldValue |
| Auto accept shared categories | false      |


Scenario: check that Global Admin can set up BU to auto-accept shared categories (in BU details add button Auto Accept)
Meta:@globaladmin
     @gdam
Given I created the agency 'A_GAAASC_S02' with default attributes
And created users with following fields:
| Email        | Role         | Agency       |
| U_GAAASC_S02 | agency.admin | A_GAAASC_S02 |
When I update agency 'A_GAAASC_S02' with following fields on agency overview page:
| FieldName                     | FieldValue   |
| Auto accept shared categories | U_GAAASC_S02 |
And refresh the page
Then I 'should' see following fields on agency overview page:
| FieldName                     | FieldValue   |
| Auto accept shared categories | U_GAAASC_S02 |



Scenario: check that assets from shared category automatically are not visible for library user when auto-accept is off
Meta:@gdam
     @library
Given I created the agency 'A_GAAASC_S03_1' with default attributes
And created the agency 'A_GAAASC_S03_2' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| U_GAAASC_S03_1 | agency.admin | A_GAAASC_S03_1 |streamlined_library,library|
| U_GAAASC_S03_2 | agency.admin | A_GAAASC_S03_2 |streamlined_library,library|
And updated agency 'A_GAAASC_S03_2' with following fields on agency overview page:
| FieldName                     | FieldValue |
| Auto accept shared categories |            |
And logged in with details of 'U_GAAASC_S03_1'
And created 'C_GAAASC_S03' category
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName     |
| C_GAAASC_S03 | A_GAAASC_S03_2 |
When I login with details of 'U_GAAASC_S03_2'
And I go to the Library page for collection 'Everything'NEWLIB
Then I 'should not' see assets 'image10.jpg' in the collection 'Everything'NEWLIB


Scenario: check that assets from shared category automatically are visible in everything for agency admin when auto-accept is on (first job)
Meta:@gdam
     @library
Given I created the agency 'A_GAAASC_S04_1' with default attributes
And created the agency 'A_GAAASC_S04_2' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| U_GAAASC_S04_1 | agency.admin | A_GAAASC_S04_1 |streamlined_library,library|
| U_GAAASC_S04_2 | agency.admin | A_GAAASC_S04_2 |streamlined_library,library|
And logged in with details of 'U_GAAASC_S04_1'
And created 'C_GAAASC_S04' category
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName     |
| C_GAAASC_S04 | A_GAAASC_S04_2 |
And I logged in as 'GlobalAdmin'
And updated agency 'A_GAAASC_S04_2' with following fields on agency overview page:
| FieldName                     | FieldValue     |
| Auto accept shared categories | U_GAAASC_S04_2 |
When I login with details of 'U_GAAASC_S04_2'
And go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see assets 'image10.jpg' in the collection 'Everything'NEWLIB


Scenario: check that assets from shared category automatically are visible in everything for agency admin when auto-accept is on (second job)
Meta:@gdam
     @library
Given I created the agency 'A_GAAASC_S05_1' with default attributes
And created the agency 'A_GAAASC_S05_2' with default attributes
And created users with following fields:
| Email          | Role         | Agency         |Access|
| U_GAAASC_S05_1 | agency.admin | A_GAAASC_S05_1 |streamlined_library,library|
| U_GAAASC_S05_2 | agency.admin | A_GAAASC_S05_2 |streamlined_library,library|
And I logged in as 'GlobalAdmin'
And updated agency 'A_GAAASC_S05_2' with following fields on agency overview page:
| FieldName                     | FieldValue     |
| Auto accept shared categories | U_GAAASC_S05_2 |
And updated agency 'A_GAAASC_S05_2' trigger repeat interval
And waited for '90' seconds
And logged in with details of 'U_GAAASC_S05_1'
And created 'C_GAAASC_S05' category
And uploaded file '/files/image10.jpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And shared next agencies for following categories:
| CategoryName | AgencyName     |
| C_GAAASC_S05 | A_GAAASC_S05_2 |
And waited for '30' seconds
When I login with details of 'U_GAAASC_S05_2'
And go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see assets 'image10.jpg' in the collection 'Everything'NEWLIB

