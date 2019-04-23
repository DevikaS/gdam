!--ORD-3295
!--ORD-3393
!--ORD-4910
Feature: Subtitles Required should be disabled for QCed assets
Narrative:
In order to:
As a AgencyAdmin
I want to check that Subtitles Required is disabled for QCed assets

Scenario: Check that correct value is displayed and field is locked into Subtitles Required after Retrieve from Library
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SRSDQAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SRSDQAU1 | agency.admin | SRSDQAA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SRSDQAA1':
| Advertiser | Brand     | Sub Brand | Product   |
| SRSDQAAR1  | SRSDQABR1 | SRSDQASB1 | SRSDQAPR1 |
And logged in with details of 'SRSDQAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | SRSDQAAR1  | SRSDQABR1 | SRSDQASB1 | SRSDQAPR1 | SRSDQAC1 | SRSDQACN1_1  | 20       | 10/14/2022     | HD 1080i 25fps | SRSDQAT1 | Adtext SD          | BSkyB Green Button:Standard |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| SRSDQACN1_2  |
And complete order contains item with clock number 'SRSDQACN1_1' with following fields:
| Job Number | PO Number |
| SRSDQAJN1  | SRSDQAPN1 |
When I added to 'tv' order item with clock number 'SRSDQACN1_2' following qc asset 'SRSDQAT1' of collection 'My Assets'
And open order item with clock number 'SRSDQACN1_1' for order with market 'Republic of Ireland'
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Title    | Duration | First Air Date | Format      | Subtitles Required |
|                        | SRSDQAAR1  | SRSDQABR1 | SRSDQASB1 | SRSDQAPR1 | SRSDQAC1 | SRSDQACN1_1  | SRSDQAT1 | 20       | 10/14/2022     | SD PAL 16x9 | Already Supplied   |
And should see 'disabled' following fields 'Subtitles Required' for order item on Add information form

Scenario: Check that Adtext or BTI Studios values of Subtitles Required field are changed to Already Supplied value of Subtitles Required field
!--ORD-4909
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SRSDQAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SRSDQAU1 | agency.admin | SRSDQAA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SRSDQAA1':
| Advertiser | Brand     | Sub Brand | Product   |
| SRSDQAAR1  | SRSDQABR1 | SRSDQASB1 | SRSDQAPR1 |
And logged in with details of 'SRSDQAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number  | Duration | First Air Date | Format         | Title   | Subtitles Required  | Destination                 |
| automated test info    | SRSDQAAR1  | SRSDQABR1 | SRSDQASB1 | SRSDQAPR1 | SRSDQAC2 | <ClockNumber> | 20       | 10/14/2022     | HD 1080i 25fps | <Title> | <SubtitlesRequired> | BSkyB Green Button:Standard |
And create 'tv' order with market 'Spain' and items with following fields:
| Clock Number |
| SRSDQACN2_2  |
And complete order contains item with clock number '<ClockNumber>' with following fields:
| Job Number | PO Number |
| SRSDQAJN2  | SRSDQAPN2 |
And waited for '3' seconds
When I added to 'tv' order item with clock number 'SRSDQACN2_2' following qc asset '<Title>' of collection 'My Assets'
And open order item with clock number '<ClockNumber>' for order with market 'Spain'
Then I should see following data for order item on Add information form:
| Subtitles Required |
| Already Supplied   |

Examples:
| ClockNumber   | Title      | SubtitlesRequired |
| SRSDQACN2_1_1 | SRSDQAT2_1 | Adtext SD         |
| SRSDQACN2_1_2 | SRSDQAT2_2 | BTI Studios       |

Scenario: Check that Yes value of Subtitles Required field is changed to Already Supplied value of Subtitles Required field for markets that doesn't have Yes value after Retrieve from Library
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SRSDQAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SRSDQAU1 | agency.admin | SRSDQAA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SRSDQAA1':
| Advertiser | Brand     | Sub Brand | Product   |
| SRSDQAAR1  | SRSDQABR1 | SRSDQASB1 | SRSDQAPR1 |
And logged in with details of 'SRSDQAU1'
And create 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Clave     | Subtitles Required | Destination           |
| automated test info    | SRSDQAAR1  | SRSDQABR1 | SRSDQASB1 | SRSDQAPR1 | SRSDQAC3 | SRSDQACN3_1  | 20       | 10/14/2022     | HD 1080i 25fps | SRSDQAT3 | SRSDQACL3 | Yes                | Barcelona TV:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SRSDQACN3_2  |
And complete order contains item with clock number 'SRSDQACN3_1' with following fields:
| Job Number | PO Number |
| SRSDQAJN3  | SRSDQAPN3 |
When I added to 'tv' order item with clock number 'SRSDQACN3_2' following qc asset 'SRSDQAT3' of collection 'My Assets'
And open order item with clock number 'SRSDQACN3_1' for order with market 'United Kingdom'
Then I should see following data for order item on Add information form:
| Subtitles Required |
| Already Supplied   |

Scenario: Check that value of Subtitles Required field is correct after Retrieving from Library and changing market
!--ORD-3391
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SRSDQAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SRSDQAU1 | agency.admin | SRSDQAA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SRSDQAA1':
| Advertiser | Brand     | Sub Brand | Product   |
| SRSDQAAR1  | SRSDQABR1 | SRSDQASB1 | SRSDQAPR1 |
And logged in with details of 'SRSDQAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | SRSDQAAR1  | SRSDQABR1 | SRSDQASB1 | SRSDQAPR1 | SRSDQAC4 | SRSDQACN4_1  | 20       | 10/14/2022     | HD 1080i 25fps | SRSDQAT4 | Adtext SD          | BSkyB Green Button:Standard |
And create 'tv' order with market 'Switzerland' and items with following fields:
| Clock Number |
| SRSDQACN4_2  |
And complete order contains item with clock number 'SRSDQACN4_1' with following fields:
| Job Number | PO Number |
| SRSDQAJN4  | SRSDQAPN4 |
When I added to 'tv' order item with clock number 'SRSDQACN4_2' following qc asset 'SRSDQAT4' of collection 'My Assets'
And open order item with clock number 'SRSDQACN4_1' for order with market 'Switzerland'
And select following market 'United Kingdom' on order item page
Then I should see following data for order item on Add information form:
| Subtitles Required |
| Already Supplied   |

Scenario: Check that None value is specified into Subtitles Required field if user retrieves qc-ed asset without specified Subtitles Required for market that has this field
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SRSDQAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SRSDQAU1 | agency.admin | SRSDQAA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SRSDQAA1':
| Advertiser | Brand     | Sub Brand | Product   |
| SRSDQAAR1  | SRSDQABR1 | SRSDQASB1 | SRSDQAPR1 |
And logged in with details of 'SRSDQAU1'
And create 'tv' order with market 'Spain' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Clave     | Destination           |
| automated test info    | SRSDQAAR1  | SRSDQABR1 | SRSDQASB1 | SRSDQAPR1 | SRSDQAC5 | SRSDQACN5_1  | 20       | 10/14/2022     | HD 1080i 25fps | SRSDQAT5 | SRSDQACL5 | Barcelona TV:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| SRSDQACN5_2  |
And complete order contains item with clock number 'SRSDQACN5_1' with following fields:
| Job Number | PO Number |
| SRSDQAJN5  | SRSDQAPN5 |
When I added to 'tv' order item with clock number 'SRSDQACN5_2' following qc asset 'SRSDQAT5' of collection 'My Assets'
And open order item with clock number 'SRSDQACN5_1' for order with market 'United Kingdom'
Then I should see following data for order item on Add information form:
| Subtitles Required |
| None               |

Scenario: Check that after retrieving asset with specified Yes value in closed captions field from Library value in Closed Captions Required field is equal to Already Supplied
!--ORD-4909
Meta: @ordering
!--NGN-16974--new bug logged
Given I created the following agency:
| Name     | A4User        |
| SRSDQAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SRSDQAU1 | agency.admin | SRSDQAA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SRSDQAA1':
| Advertiser | Brand     | Sub Brand | Product   |
| SRSDQAAR1  | SRSDQABR1 | SRSDQASB1 | SRSDQAPR1 |
And logged in with details of 'SRSDQAU1'
And create 'tv' order with market 'Australia' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                      |
| automated test info    | SRSDQAAR1  | SRSDQABR1 | SRSDQASB1 | SRSDQAPR1 | SRSDQAC6 | SRSDQACN6_1  | 20       | 10/14/2022     | HD 1080i 25fps | SRSDQAT6 | Yes                | SBS National:Standard |
And create 'tv' order with market 'Australia' and items with following fields:
| Clock Number |
| SRSDQACN6_2  |
And complete order contains item with clock number 'SRSDQACN6_1' with following fields:
| Job Number | PO Number |
| SRSDQAJN6  | SRSDQAPN6 |
When I added to 'tv' order item with clock number 'SRSDQACN6_2' following qc asset 'SRSDQAT6' of collection 'My Assets'
And open order item with clock number 'SRSDQACN6_1' for order with market 'Australia'
Then I should see following data for order item on Add information form:
| Subtitles Required |
| Already Supplied   |


Scenario: Check that after creation clone with another video specification of asset with Adtext or BTI Studios value of Subtitles Required of original QC-ed asset is changed to Already Supplied as well
!--ORD-4909
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SRSDQAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |Access|
| SRSDQAU1 | agency.admin | SRSDQAA1     |streamlined_library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SRSDQAA1':
| Advertiser | Brand     | Sub Brand | Product   |
| SRSDQAAR1  | SRSDQABR1 | SRSDQASB1 | SRSDQAPR1 |
And logged in with details of 'SRSDQAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info 1  | SRSDQAAR1  | SRSDQABR1 | SRSDQASB1 | SRSDQAPR1 | SRSDQAC9 | SRSDQACN9_1  | 20       | 10/14/2022     | HD 1080i 25fps | SRSDQAT9 | Adtext SD          | BSkyB Green Button:Standard |
And create 'tv' order with market 'Australia' and items with following fields:
| Clock Number | Destination                      |
| SRSDQACN9_2  | SBS National:Standard            |
And complete order contains item with clock number 'SRSDQACN9_1' with following fields:
| Job Number  | PO Number   |
| SRSDQAJN9_1 | SRSDQAPN9_1 |
And add to 'tv' order item with clock number 'SRSDQACN9_2' following qc asset 'SRSDQAT9' of collection 'My Assets'
And complete order with market 'Australia' with following fields:
| Job Number  | PO Number   |
| SRSDQAJN9_2 | SRSDQAPN9_2 |
And waited for '5' seconds
When I go to asset 'SRSDQAT9' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see following 'custom metadata' fields on opened asset info pageNEWLIB:
| FieldName                | FieldValue       |
| Subtitles Required       | Already Supplied |
| Closed Captions Required | Already Supplied |