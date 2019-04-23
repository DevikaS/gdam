!--NGN-9975
Feature:          User to whom Admin shared Parent Collection should automatically see child collections as well
Narrative:
In order to
As a              AgencyAdmin
I want to         check correct work of share collection


Scenario: Check that after share parent collection (that include child) share user has correct permissions on child and user does not see anything outside of their collections
Meta: @skip
      @gdam
Given I created the agency 'USWASPCSASCCAW_A1' with default attributes
And created users with following fields:
| Email               | Role         | AgencyUnique      |
| USWASPCSASCCAW6_E01 | agency.admin | USWASPCSASCCAW_A1 |
| USWASPCSASCCAW6_E02 | agency.admin | USWASPCSASCCAW_A1 |
And logged in with details of 'USWASPCSASCCAW6_E01'
And created 'test_col_5_1' category
And I created child category 'test_col_5_2' of category 'test_col_5_1'
And I created child category 'test_col_5_3' of category 'test_col_5_2'
And I created child category 'test_col_5_4' of category 'test_col_5_3'
And uploaded asset '/files/120.600.gif' into library
And waited while transcoding is finished in collection 'My Assets'
And added following assets '120.600.gif' to collection 'test_col_5_2' from collection 'My Assets'
And added users 'USWASPCSASCCAW6_E02' for category 'test_col_5_3' with role 'library.user'
When login with details of 'USWASPCSASCCAW6_E02'
And go to  Library page for collection 'Everything'
Then should see count '0' of assets on the current preview page



Scenario: Check that after share parent (that include childs) to Another BU share user won't see child collections
Meta: @gdam
@library
Given I logged in as 'GlobalAdmin'
And I created the agency 'USWASPCSASCCAW_A1' with default attributes
And created the agency 'USWASPCSASCCAW_A2' with default attributes
And created users with following fields:
| Email               | Role         | AgencyUnique      |Access|
| USWASPCSASCCAW8_E01 | agency.admin | USWASPCSASCCAW_A1 |streamlined_library|
| USWASPCSASCCAW8_E02 | agency.admin | USWASPCSASCCAW_A2 |streamlined_library|
And added following partners 'USWASPCSASCCAW_A2' to agency 'USWASPCSASCCAW_A1' on partners page
And logged in with details of 'USWASPCSASCCAW8_E01'
And created 'test_col_7_1' category
And I created child category 'test_col_7_2' of category 'test_col_7_1'
And created child category 'test_col_7_3' of category 'test_col_7_2'
And created child category 'test_col_7_4' of category 'test_col_7_3'
And I am on collection 'test_col_7_1' on administration area collections page
When add following business unit 'USWASPCSASCCAW_A2' with category 'test_col_7_2'
And login with details of 'USWASPCSASCCAW8_E02'
And I go to the collections page
And I refresh the page
Then I 'should' see collection 'test_col_7_2' from agency 'USWASPCSASCCAW_A1' on inbox shared collectionNEWLIB
And I 'should not' see collection 'test_col_7_3' from agency 'USWASPCSASCCAW_A1' on inbox shared collectionNEWLIB
And I 'should not' see collection 'test_col_7_4' from agency 'USWASPCSASCCAW_A1' on inbox shared collectionNEWLIB


Scenario: Check that after share only parent collection (Parent more than 5 sub collection and 5 sub-sub collections) parent child and subchilds will be visible for share user
Meta:@gdam
@library
Given I created the agency 'USWASPCSASCCAW_A1' with default attributes
And created users with following fields:
| Email              | Role         | AgencyUnique      |Access|
| USWASPCSASCCAW_E01 | agency.admin | USWASPCSASCCAW_A1 |streamlined_library,library|
| USWASPCSASCCAW_E02 | agency.user  | USWASPCSASCCAW_A1 |streamlined_library,library|
And logged in with details of 'USWASPCSASCCAW_E01'
And created 'test_col_1_1' category
And I created child category 'test_col_1_2' of category 'test_col_1_1'
And I created child category 'test_col_1_3' of category 'test_col_1_2'
And I created child category 'test_col_1_4' of category 'test_col_1_3'
And added users 'USWASPCSASCCAW_E02' for category 'test_col_1_1' with role 'library.user'
When login with details of 'USWASPCSASCCAW_E02'
And I go to the collections page
Then I 'should' see series of sub collections 'test_col_1_1,test_col_1_2,test_col_1_3,test_col_1_4' under agency 'USWASPCSASCCAW_A1'NEWLIB

Scenario: Check that after share only sub collection(sub collection include childs) for share user will be visible sub collecion and childs and parent-not
Meta:@gdam
@library
Given I created the agency 'USWASPCSASCCAW_A1' with default attributes
And created users with following fields:
| Email               | Role         | AgencyUnique      |Access|
| USWASPCSASCCAW2_E01 | agency.admin | USWASPCSASCCAW_A1 |streamlined_library,library|
| USWASPCSASCCAW2_E02 | agency.user  | USWASPCSASCCAW_A1 |streamlined_library,library|
And logged in with details of 'USWASPCSASCCAW2_E01'
And created 'test_col_2_1' category
And I created child category 'test_col_2_2' of category 'test_col_2_1'
And I created child category 'test_col_2_3' of category 'test_col_2_2'
And I created child category 'test_col_2_4' of category 'test_col_2_3'
And added users 'USWASPCSASCCAW2_E02' for category 'test_col_2_3' with role 'library.user'
When login with details of 'USWASPCSASCCAW2_E02'
And I go to the collections page
Then I 'should' see series of sub collections 'test_col_2_3,test_col_2_4' under agency 'USWASPCSASCCAW_A1'NEWLIB
And I 'should not' see series of sub collections 'test_col_2_1,test_col_2_2' under agency 'USWASPCSASCCAW_A1'NEWLIB


Scenario: Check that if shared parent that has child will be removed parent shouldn't be visible for share user but child should
Meta:@gdam
@library
Given I created the agency 'USWASPCSASCCAW_A1' with default attributes
And created users with following fields:
| Email               | Role         | AgencyUnique      |Access|
| USWASPCSASCCAW3_E01 | agency.admin | USWASPCSASCCAW_A1 |streamlined_library,library|
| USWASPCSASCCAW3_E02 | agency.user  | USWASPCSASCCAW_A1 |streamlined_library,library|
And logged in with details of 'USWASPCSASCCAW3_E01'
And created 'test_col_3_1' category
And I created child category 'test_col_3_2' of category 'test_col_3_1'
And I created child category 'test_col_3_3' of category 'test_col_3_2'
And I created child category 'test_col_3_4' of category 'test_col_3_3'
And added users 'USWASPCSASCCAW3_E02' for category 'test_col_3_2' with role 'library.user'
And removed category 'test_col_3_2' from Collection page in admin area
When login with details of 'USWASPCSASCCAW3_E02'
And I go to the collections page
Then I 'should not' see series of sub collections 'test_col_3_1,test_col_3_2,test_col_3_3,test_col_3_4' under agency 'USWASPCSASCCAW_A1'NEWLIB

Scenario: Check that if child 2 and 3 will be shared and then child 2 will be removed child 1 and 2 should not be visible but child 3 and 4 should
Meta:@gdam
@library
Given I created the agency 'USWASPCSASCCAW_A1' with default attributes
And created users with following fields:
| Email               | Role         | AgencyUnique      |Access|
| USWASPCSASCCAW4_E01 | agency.admin | USWASPCSASCCAW_A1 |streamlined_library,library|
| USWASPCSASCCAW4_E02 | agency.user  | USWASPCSASCCAW_A1 |streamlined_library,library|
And logged in with details of 'USWASPCSASCCAW4_E01'
And created 'test_col_3_1' category
And I created child category 'test_col_3_2' of category 'test_col_3_1'
And I created child category 'test_col_3_3' of category 'test_col_3_2'
And I created child category 'test_col_3_4' of category 'test_col_3_3'
And added users 'USWASPCSASCCAW4_E02' for category 'test_col_3_2' with role 'library.user'
And added users 'USWASPCSASCCAW4_E02' for category 'test_col_3_3' with role 'library.user'
And removed category 'test_col_3_2' from Collection page in admin area
When login with details of 'USWASPCSASCCAW4_E02'
And I go to the collections page
Then I 'should' see series of sub collections 'test_col_3_3,test_col_3_4' under agency 'USWASPCSASCCAW_A1'NEWLIB
And I 'should not' see series of sub collections 'test_col_3_1,test_col_3_2' under agency 'USWASPCSASCCAW_A1'NEWLIB

Scenario: Check that after share child collection parent collection aren't visible for share user and child visible
Meta:@gdam
@library
Given I created the agency 'USWASPCSASCCAW_A1' with default attributes
And created users with following fields:
| Email               | Role         | AgencyUnique      |Access|
| USWASPCSASCCAW5_E01 | agency.admin | USWASPCSASCCAW_A1 |streamlined_library,library|
| USWASPCSASCCAW5_E02 | agency.user  | USWASPCSASCCAW_A1 |streamlined_library,library|
And logged in with details of 'USWASPCSASCCAW5_E01'
And created 'test_col_4_1' category
And I created child category 'test_col_4_2' of category 'test_col_4_1'
And I created child category 'test_col_4_3' of category 'test_col_4_2'
And I created child category 'test_col_4_4' of category 'test_col_4_3'
And added users 'USWASPCSASCCAW5_E02' for category 'test_col_4_3' with role 'library.user'
When login with details of 'USWASPCSASCCAW5_E02'
And I go to the collections page
Then I 'should' see series of sub collections 'test_col_4_3,test_col_4_4' under agency 'USWASPCSASCCAW_A1'NEWLIB
And I 'should not' see series of sub collections 'test_col_4_1,test_col_4_2' under agency 'USWASPCSASCCAW_A1'NEWLIB

Scenario: Check that after share subchild share user couldn't find assets from parend collection via global search
Meta: @gdam
@library
Given I created the agency 'USWASPCSASCCAW_A1' with default attributes
And created users with following fields:
| Email               | Role         | AgencyUnique      |Access|
| USWASPCSASCCAW7_E01 | agency.admin | USWASPCSASCCAW_A1 |streamlined_library,dashboard|
| USWASPCSASCCAW7_E02 | agency.user  | USWASPCSASCCAW_A1 |streamlined_library,dashboard|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'USWASPCSASCCAW_A1':
| Advertiser | Brand  | Sub Brand  | Product  |
| adv1       | brand1 | sub-brand1 | product1 |
And logged in with details of 'USWASPCSASCCAW7_E01'
And uploaded file '/files/Fish Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'My Assets'NEWLIB
And on asset 'Fish Ad.mov' info page in Library for collection 'Everything'NEWLIB
When 'save' asset info by following information on opened asset info pageNEWLIB:
| FieldName  | FieldValue |
| Advertiser | adv1       |
| Clock number | Clk_adv1       |
And create 'col1' category
And go to administration area collections page
And set to collection 'col1' following metadata:
| key        | value  |
| Advertiser | adv1   |
And I create collection 'col2' based on collection 'col1' on administration area with following metadata:
| key   | value   |
| Brand | brand1  |
And I create collection 'col3' based on collection 'col2' on administration area with following metadata:
| key       | value      |
| Sub Brand | sub-brand1 |
And go to administration area collections page
And add users 'USWASPCSASCCAW7_E02' for category 'col2' with role 'library.user'
When login with details of 'USWASPCSASCCAW7_E02'
And I go to Dashboard page
And search by text 'Fish Ad.mov'
Then I 'should not' see search object 'Fish Ad.mov'












