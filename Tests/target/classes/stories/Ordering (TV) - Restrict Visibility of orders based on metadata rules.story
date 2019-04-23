!--ORD-3541
!--ORD-3712
!--ORD-3759
!--ORD-4875
Feature: Restrict Visibility of orders based on metadata rules
Narrative:
In order to:
As a AgencyAdmin
I want to check restrict Visibility of orders based on metadata rules

Scenario: Check saving delivery access rules for default advertiser hierarchy
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| RVBOMRA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| RVBOMRU1_1 | agency.admin | RVBOMRA1     |
| RVBOMRU1_2 | agency.user  | RVBOMRA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RVBOMRA1':
| Advertiser | Brand     | Sub Brand | Product   |
| RVBOMRAR1  | RVBOMRBR1 | RVBOMRSB1 | RVBOMRPR1 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency 'RVBOMRA1' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'RVBOMRU1_1'
And I am on user 'RVBOMRU1_2' delivery page in administration area
When I fill following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition | Metadata Value |
| Advertiser     | Equal     | RVBOMRAR1      |
| Brand          | Not Equal | RVBOMRBR1      |
| Sub Brand      | Equal     | RVBOMRSB1      |
| Product        | Not Equal | RVBOMRPR1      |
And save delivery access rules on Delivery Access Rule Builder form
Then I should see following delivery access rules on users delivery page:
| Metadata Field | Condition | Metadata Value |
| Advertiser     | Equal     | RVBOMRAR1      |
| Brand          | Not Equal | RVBOMRBR1      |
| Sub Brand      | Equal     | RVBOMRSB1      |
| Product        | Not Equal | RVBOMRPR1      |

Scenario: Check removing delivery access rules on user delivery page
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| RVBOMRA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| RVBOMRU1_1 | agency.admin | RVBOMRA1     |
| RVBOMRU2_2 | agency.user  | RVBOMRA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RVBOMRA1':
| Advertiser | Brand     | Sub Brand | Product   |
| RVBOMRAR1  | RVBOMRBR1 | RVBOMRSB1 | RVBOMRPR1 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency 'RVBOMRA1' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'RVBOMRU1_1'
And I am on user 'RVBOMRU2_2' delivery page in administration area
When I fill following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition | Metadata Value |
| Advertiser     | Equal     | RVBOMRAR1      |
| Brand          | Not Equal | RVBOMRBR1      |
| Sub Brand      | Equal     | RVBOMRSB1      |
| Product        | Not Equal | RVBOMRPR1      |
And save delivery access rules on Delivery Access Rule Builder form
And delete delivery access rule with metadata fields 'Sub Brand,Product' on users delivery page
Then I 'should' see delivery access rules with following metadata fields 'Advertiser,Brand' on users delivery page
And 'should not' see delivery access rules with following metadata fields 'Sub Brand,Product' on users delivery page

Scenario: Check that only Mark as Advertiser catalogue structure is displayed in Delivery access rules in case default advertiser hierarchy
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| RVBOMRA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| RVBOMRU1_1 | agency.admin | RVBOMRA1     |
| RVBOMRU3_2 | agency.user  | RVBOMRA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RVBOMRA1':
| Advertiser | Brand     | Sub Brand | Product   |
| RVBOMRAR1  | RVBOMRBR1 | RVBOMRSB1 | RVBOMRPR1 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency 'RVBOMRA1' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'RVBOMRU1_1'
And I am on user 'RVBOMRU3_2' delivery page in administration area
Then I should see available following metadata fields 'Advertiser,Brand,Sub Brand,Product' for Metadata Field on Delivery Access Rule Builder form

Scenario: Check that only Mark as Advertiser catalogue structure is displayed in Delivery access rules in case custom advertiser hierarchy
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| RVBOMRA4 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| RVBOMRU4_1 | agency.admin | RVBOMRA4     |
| RVBOMRU4_2 | agency.user  | RVBOMRA4     |
And created following 'common' custom metadata fields for agency 'RVBOMRA4':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Sub Brand Custom  | Brand Custom      | true     | true                |
| CatalogueStructure | Product Custom    | Sub Brand Custom  | true     | true                |
And updated agency 'RVBOMRA4' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product |
| Advertiser Custom  | Product Custom  |
And updated metadatas 'Advertiser Custom,Brand Custom,Sub Brand Custom,Product Custom' in schema 'common' of agency 'RVBOMRA4' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'RVBOMRU4_1'
And I am on user 'RVBOMRU4_2' delivery page in administration area
Then I should see available following metadata fields 'Advertiser Custom,Brand Custom,Sub Brand Custom,Product Custom' for Metadata Field on Delivery Access Rule Builder form

Scenario: Check that only Mark as Advertiser catalogue structure is displayed in Delivery access rules in case rename custom advertiser hierarchy
!--ORD-5256
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| RVBOMRA5 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| RVBOMRU5_1 | agency.admin | RVBOMRA5     |
| RVBOMRU5_2 | agency.user  | RVBOMRA5     |
And created following 'common' custom metadata fields for agency 'RVBOMRA5':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Sub Brand Custom  | Brand Custom      | true     | true                |
| CatalogueStructure | Product Custom    | Sub Brand Custom  | true     | true                |
And updated agency 'RVBOMRA5' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product |
| Advertiser Custom  | Product Custom  |
And updated metadatas 'Advertiser Custom,Brand Custom,Sub Brand Custom,Product Custom' in schema 'common' of agency 'RVBOMRA5' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'RVBOMRU5_1'
And I am on the 'common custom' metadata page
When I click 'Advertiser Custom' button in 'common metadata' section on opened metadata page
And fill Description field with text 'Advertiser Custom New' on opened Settings and Customization tab
And save metadata field settings
And open available metadata page 'Available Metadata'
And click 'Brand Custom' button in 'common metadata' section on opened metadata page
And fill Description field with text 'Brand Custom New' on opened Settings and Customization tab
And save metadata field settings
And go to user 'RVBOMRU5_2' delivery page in administration area
Then I should see available following metadata fields 'Advertiser Custom New,Brand Custom New,Sub Brand Custom,Product Custom' for Metadata Field on Delivery Access Rule Builder form

Scenario: Check changing delivery access rules on Deliver access rule builder form
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| RVBOMRA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| RVBOMRU1_1 | agency.admin | RVBOMRA1     |
| RVBOMRU6_2 | agency.user  | RVBOMRA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RVBOMRA1':
| Advertiser | Brand     | Sub Brand | Product   |
| RVBOMRAR1  | RVBOMRBR1 | RVBOMRSB1 | RVBOMRPR1 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency 'RVBOMRA1' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'RVBOMRU1_1'
And I am on user 'RVBOMRU6_2' delivery page in administration area
When I fill following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition | Metadata Value |
| Advertiser     | Equal     | RVBOMRAR1      |
| Brand          | Not Equal | RVBOMRBR1      |
And save delivery access rules on Delivery Access Rule Builder form
And refresh the page
And fill following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition | Metadata Value |
| Sub Brand      | Equal     | RVBOMRSB1      |
And save delivery access rules on Delivery Access Rule Builder window
And refresh the page without delay
Then I should see following delivery access rules on users delivery page:
| Metadata Field | Condition | Metadata Value |
| Sub Brand      | Equal     | RVBOMRSB1      |
| Brand          | Not Equal | RVBOMRBR1      |


Scenario: Check removing delivery access rules on Deliver access rule builder form
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| RVBOMRA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| RVBOMRU1_1 | agency.admin | RVBOMRA1     |
| RVBOMRU7_2 | agency.user  | RVBOMRA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RVBOMRA1':
| Advertiser | Brand     | Sub Brand | Product   |
| RVBOMRAR1  | RVBOMRBR1 | RVBOMRSB1 | RVBOMRPR1 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency 'RVBOMRA1' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'RVBOMRU1_1'
And I am on user 'RVBOMRU7_2' delivery page in administration area
When I fill following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition | Metadata Value |
| Advertiser     | Equal     | RVBOMRAR1      |
| Brand          | Not Equal | RVBOMRBR1      |
| Sub Brand      | Equal     | RVBOMRSB1      |
| Product        | Not Equal | RVBOMRPR1      |
And save delivery access rules on Delivery Access Rule Builder form
And refresh the page
And remove delivery access rule with metadata fields 'Brand,Product' on Delivery Access Rule Builder form
And save delivery access rules on Delivery Access Rule Builder window
Then I should see following delivery access rules on users delivery page:
| Metadata Field | Condition | Metadata Value |
| Advertiser     | Equal     | RVBOMRAR1      |
| Sub Brand      | Equal     | RVBOMRSB1      |

Scenario: Check that restrictions rules are working for draft orders in case default advertiser hierarchy
!--ORD-4875
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| <Agency> | DefaultA4User |
And created users with following fields:
| Email        | Role         | AgencyUnique |
| <FirstUser>  | agency.admin | <Agency>     |
| <SecondUser> | agency.user  | <Agency>     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser  | Brand       | Sub Brand   | Product     |
| RVBOMRAR8_1 | RVBOMRBR8_1 | RVBOMRSB8_1 | RVBOMRPR8_1 |
| RVBOMRAR8_2 | RVBOMRBR8_2 | RVBOMRSB8_2 | RVBOMRPR8_2 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency '<Agency>' by following fields:
| Make it common for order |
| should                   |
And logged in with details of '<FirstUser>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser  | Brand       | Sub Brand   | Product     | Clock Number       |
| RVBOMRAR8_1 | RVBOMRBR8_1 | RVBOMRSB8_1 | RVBOMRPR8_1 | <FirstClockNumber> |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser  | Brand       | Sub Brand   | Product     | Clock Number        |
| RVBOMRAR8_2 | RVBOMRBR8_2 | RVBOMRSB8_2 | RVBOMRPR8_2 | <SecondClockNumber> |
And I am on user '<SecondUser>' delivery page in administration area
When I fill following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition             | Metadata Value            |
| Advertiser     | <AdvertiserCondition> | <AdvertiserMetadataValue> |
| Brand          | <BrandCondition>      | <BrandMetadataValue>      |
| Sub Brand      | <SubbrandCondition>   | <SubbrandMetadataValue>   |
| Product        | <ProductCondition>    | <ProductMetadataValue>    |
And save delivery access rules on Delivery Access Rule Builder form
And login with details of '<SecondUser>'
And go to View Draft Orders tab of 'tv' order on ordering page
Then I '<FistShouldState>' see 'not own' order with following item clock number '<FirstClockNumber>' in 'draft' order list
And '<SecodShouldState>' see 'not own' order with following item clock number '<SecondClockNumber>' in 'draft' order list

Examples:
| Agency     | FirstUser    | SecondUser   | FirstClockNumber | SecondClockNumber | AdvertiserCondition | AdvertiserMetadataValue | BrandCondition | BrandMetadataValue | SubbrandCondition | SubbrandMetadataValue | ProductCondition | ProductMetadataValue | FistShouldState | SecodShouldState |
| RVBOMRA8_1 | RVBOMRU8_1_1 | RVBOMRU8_1_2 | RVBOMRCN8_1_1    | RVBOMRCN8_1_2     | Equal               | RVBOMRAR8_1             | Equal          | RVBOMRBR8_1        | Equal             | RVBOMRSB8_1           | Equal            | RVBOMRPR8_1          | should          | should not       |
| RVBOMRA8_2 | RVBOMRU8_2_1 | RVBOMRU8_2_2 | RVBOMRCN8_2_1    | RVBOMRCN8_2_2     | Not Equal           | RVBOMRAR8_1             | Not Equal      | RVBOMRBR8_1        | Not Equal         | RVBOMRSB8_1           | Not Equal        | RVBOMRPR8_1          | should not      | should           |
| RVBOMRA8_3 | RVBOMRU8_3_1 | RVBOMRU8_3_2 | RVBOMRCN8_3_1    | RVBOMRCN8_3_2     | Equal               | RVBOMRAR8_1             | Not Equal      | RVBOMRBR8_2        | Not Equal         | RVBOMRSB8_2           | Not Equal        | RVBOMRPR8_2          | should          | should not       |
| RVBOMRA8_4 | RVBOMRU8_4_1 | RVBOMRU8_4_2 | RVBOMRCN8_4_1    | RVBOMRCN8_4_2     | Equal               | RVBOMRAR8_2             | Equal          | RVBOMRBR8_2        | Not Equal         | RVBOMRSB8_1           | Not Equal        | RVBOMRPR8_1          | should not      | should           |
| RVBOMRA8_5 | RVBOMRU8_5_1 | RVBOMRU8_5_2 | RVBOMRCN8_5_1    | RVBOMRCN8_5_2     | Equal               | RVBOMRAR8_1             | Equal          | RVBOMRBR8_2        | Equal             | RVBOMRSB8_1           | Equal            | RVBOMRPR8_2          | should not      | should not       |
| RVBOMRA8_6 | RVBOMRU8_6_1 | RVBOMRU8_6_2 | RVBOMRCN8_6_1    | RVBOMRCN8_6_2     | Not Equal           | RVBOMRAR8_1             | Not Equal      | RVBOMRBR8_2        | Not Equal         | RVBOMRSB8_1           | Not Equal        | RVBOMRPR8_2          | should not      | should not       |

Scenario: Check that restrictions rules are working for live orders in case default advertiser hierarchy
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| RVBOMRA9 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| RVBOMRU9_1 | agency.admin | RVBOMRA9     |
| RVBOMRU9_2 | agency.user  | RVBOMRA9     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RVBOMRA9':
| Advertiser  | Brand       | Sub Brand   | Product     |
| RVBOMRAR9_1 | RVBOMRBR9_1 | RVBOMRSB9_1 | RVBOMRPR9_1 |
| RVBOMRAR9_2 | RVBOMRBR9_2 | RVBOMRSB9_2 | RVBOMRPR9_2 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency 'RVBOMRA9' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'RVBOMRU9_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | RVBOMRAR9_1 | RVBOMRBR9_1 | RVBOMRSB9_1 | RVBOMRPR9_1 | RVBOMRC9_1 | RVBOMRCN9_1  | 20       | 10/14/2022     | HD 1080i 25fps | RVBOMRT9_1 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand       | Sub Brand   | Product     | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | RVBOMRAR9_2 | RVBOMRBR9_2 | RVBOMRSB9_2 | RVBOMRPR9_2 | RVBOMRC9_2 | RVBOMRCN9_2  | 20       | 10/14/2022     | HD 1080i 25fps | RVBOMRT9_2 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'RVBOMRCN9_1' with following fields:
| Job Number  | PO Number   |
| RVBOMRJN9_1 | RVBOMRPN9_1 |
And complete order contains item with clock number 'RVBOMRCN9_2' with following fields:
| Job Number  | PO Number   |
| RVBOMRJN9_2 | RVBOMRPN9_2 |
And I am on user 'RVBOMRU9_2' delivery page in administration area
When I fill following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition | Metadata Value |
| Advertiser     | Equal     | RVBOMRAR9_1    |
| Brand          | Equal     | RVBOMRBR9_1    |
| Sub Brand      | Not Equal | RVBOMRSB9_2    |
| Product        | Not Equal | RVBOMRPR9_2    |
And save delivery access rules on Delivery Access Rule Builder form
And login with details of 'RVBOMRU9_2'
And go to View Live Orders tab of 'tv' order on ordering page
Then I 'should' see 'not own' order with following item clock number 'RVBOMRCN9_1' in 'live' order list
And 'should not' see 'not own' order with following item clock number 'RVBOMRCN9_2' in 'live' order list

Scenario: Check that restrictions rules are working for draft orders in case custom advertiser hierarchy
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| RVBOMRA10 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| RVBOMRU10_1 | agency.admin | RVBOMRA10    |
| RVBOMRU10_2 | agency.user  | RVBOMRA10    |
And created following 'common' custom metadata fields for agency 'RVBOMRA10':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Sub Brand Custom  | Brand Custom      | true     | true                |
| CatalogueStructure | Product Custom    | Sub Brand Custom  | true     | true                |
And updated agency 'RVBOMRA10' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product |
| Advertiser Custom  | Product Custom  |
And updated metadatas 'Advertiser Custom,Brand Custom,Sub Brand Custom,Product Custom' in schema 'common' of agency 'RVBOMRA10' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'RVBOMRU10_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| RVBOMRCN10_1 |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| RVBOMRCN10_2 |
When I open order item with following clock number 'RVBOMRCN10_1'
And fill following custom advertiser hierarchy fields for Common Information section on order item page:
| Advertiser Custom | Brand Custom | Sub Brand Custom | Product Custom |
| RVBOMRAR10_1      | RVBOMRBR10_1 | RVBOMRSB10_1     | RVBOMRPR10_1   |
And save as draft order
And open order item with following clock number 'RVBOMRCN10_2'
And fill following custom advertiser hierarchy fields for Common Information section on order item page:
| Advertiser Custom | Brand Custom | Sub Brand Custom | Product Custom |
| RVBOMRAR10_2      | RVBOMRBR10_2 | RVBOMRSB10_2     | RVBOMRPR10_2   |
And save as draft order
And go to user 'RVBOMRU10_2' delivery page in administration area
And fill following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field    | Condition | Metadata Value |
| Advertiser Custom | Equal     | RVBOMRAR10_1   |
| Brand Custom      | Equal     | RVBOMRBR10_1   |
| Sub Brand Custom  | Not Equal | RVBOMRSB10_2   |
| Product Custom    | Not Equal | RVBOMRPR10_2   |
And save delivery access rules on Delivery Access Rule Builder form
And login with details of 'RVBOMRU10_2'
And go to View Draft Orders tab of 'tv' order on ordering page
Then I 'should' see 'not own' order with following item clock number 'RVBOMRCN10_1' in 'draft' order list
And 'should not' see 'not own' order with following item clock number 'RVBOMRCN10_2' in 'draft' order list

Scenario: Check that restrictions rules are working in case some of order items dont match the rules
!--ORD-3712
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| RVBOMRA11 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| RVBOMRU11_1 | agency.admin | RVBOMRA11    |
| RVBOMRU11_2 | agency.user  | RVBOMRA11    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RVBOMRA11':
| Advertiser   | Brand        | Sub Brand    | Product      |
| RVBOMRAR11_1 | RVBOMRBR11_1 | RVBOMRSB11_1 | RVBOMRPR11_1 |
| RVBOMRAR11_2 | RVBOMRBR11_2 | RVBOMRSB11_2 | RVBOMRPR11_2 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency 'RVBOMRA11' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'RVBOMRU11_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser   | Brand        | Sub Brand    | Product      | Clock Number |
| RVBOMRAR11_1 | RVBOMRBR11_1 | RVBOMRSB11_1 | RVBOMRPR11_1 | RVBOMRCN11_1 |
| RVBOMRAR11_2 | RVBOMRBR11_2 | RVBOMRSB11_2 | RVBOMRPR11_2 | RVBOMRCN11_2 |
And I am on user 'RVBOMRU11_2' delivery page in administration area
When I fill following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition | Metadata Value |
| Advertiser     | Equal     | RVBOMRAR11_1   |
| Brand          | Equal     | RVBOMRBR11_1   |
| Sub Brand      | Equal     | RVBOMRSB11_1   |
| Product        | Equal     | RVBOMRPR11_1   |
And save delivery access rules on Delivery Access Rule Builder form
And login with details of 'RVBOMRU11_2'
And go to View Draft Orders tab of 'tv' order on ordering page
Then I 'should not' see 'not own' order with following item clock number 'RVBOMRCN11_1' in 'draft' order list

Scenario: Check that restrictions rules are working in case all order items match the rules
!--ORD-3712
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| RVBOMRA11 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| RVBOMRU11_1 | agency.admin | RVBOMRA11    |
| RVBOMRU12_2 | agency.user  | RVBOMRA11    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RVBOMRA11':
| Advertiser   | Brand        | Sub Brand    | Product      |
| RVBOMRAR11_1 | RVBOMRBR11_1 | RVBOMRSB11_1 | RVBOMRPR11_1 |
| RVBOMRAR11_2 | RVBOMRBR11_2 | RVBOMRSB11_2 | RVBOMRPR11_2 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency 'RVBOMRA11' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'RVBOMRU11_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser   | Brand        | Sub Brand    | Product      | Clock Number |
| RVBOMRAR11_1 | RVBOMRBR11_1 | RVBOMRSB11_1 | RVBOMRPR11_1 | RVBOMRCN12_1 |
| RVBOMRAR11_2 | RVBOMRBR11_2 | RVBOMRSB11_2 | RVBOMRPR11_2 | RVBOMRCN12_2 |
And I am on user 'RVBOMRU12_2' delivery page in administration area
When I fill following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition | Metadata Value |
| Advertiser     | Equal     | RVBOMRAR11_1   |
| Brand          | Equal     | RVBOMRBR11_1   |
| Sub Brand      | Equal     | RVBOMRSB11_1   |
| Product        | Equal     | RVBOMRPR11_1   |
| Advertiser     | Equal     | RVBOMRAR11_2   |
| Brand          | Equal     | RVBOMRBR11_2   |
| Sub Brand      | Equal     | RVBOMRSB11_2   |
| Product        | Equal     | RVBOMRPR11_2   |
And save delivery access rules on Delivery Access Rule Builder form
And login with details of 'RVBOMRU12_2'
And go to View Draft Orders tab of 'tv' order on ordering page
Then I 'should' see 'not own' order with following item clock number 'RVBOMRCN12_1' in 'draft' order list

Scenario: Check that restrictions rules are working in case OR logic
!--ORD-4875
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| RVBOMRA13 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| RVBOMRU13_1 | agency.admin | RVBOMRA13    |
| RVBOMRU13_2 | agency.user  | RVBOMRA13    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RVBOMRA13':
| Advertiser   |
| RVBOMRAR13_1 |
| RVBOMRAR13_2 |
And updated metadatas 'Advertiser' in schema 'common' of agency 'RVBOMRA13' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'RVBOMRU13_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser   | Clock Number |
| RVBOMRAR13_1 | RVBOMRCN13_1 |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser   | Clock Number |
| RVBOMRAR13_2 | RVBOMRCN13_2 |
And I am on user 'RVBOMRU13_2' delivery page in administration area
When I fill following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition | Metadata Value |
| Advertiser     | Equal     | RVBOMRAR13_1   |
| Advertiser     | Equal     | RVBOMRAR13_2   |
And save delivery access rules on Delivery Access Rule Builder form
And login with details of 'RVBOMRU13_2'
And go to View Draft Orders tab of 'tv' order on ordering page
Then I 'should' see 'not own' order with following item clock number 'RVBOMRCN13_1,RVBOMRCN13_2' in 'draft' order list

Scenario: Check warning message displayed for Advertiser field when Delivery Access Rule is set
!--NGN-16215
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| <Agency> | DefaultA4User |
And created users with following fields:
| Email        | Role         | AgencyUnique |
| <FirstUser>  | agency.admin | <Agency>     |
| <SecondUser> | agency.user  | <Agency>     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser  | Brand       | Sub Brand   | Product     |
| RVBOMRAR14_1 | RVBOMRBR14_1 | RVBOMRSB14_1 | RVBOMRPR14_1 |
| RVBOMRAR14_2 | RVBOMRBR14_2 | RVBOMRSB14_2 | RVBOMRPR14_2 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency '<Agency>' by following fields:
| Make it common for order |
| should                   |
And logged in with details of '<FirstUser>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser  | Brand       | Sub Brand   | Product     | Clock Number       |
| RVBOMRAR14_1 | RVBOMRBR14_1 | RVBOMRSB14_1 | RVBOMRPR14_1 | <FirstClockNumber> |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser  | Brand       | Sub Brand   | Product     | Clock Number        |
| RVBOMRAR14_2 | RVBOMRBR14_2 | RVBOMRSB14_2 | RVBOMRPR14_2 | <SecondClockNumber> |
And I am on user '<SecondUser>' delivery page in administration area
When I fill following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition             | Metadata Value            |
| Advertiser     | <AdvertiserCondition> | <AdvertiserMetadataValue> |
| Brand          | <BrandCondition>      | <BrandMetadataValue>      |
| Sub Brand      | <SubbrandCondition>   | <SubbrandMetadataValue>   |
| Product        | <ProductCondition>    | <ProductMetadataValue>    |
And save delivery access rules on Delivery Access Rule Builder form
And login with details of '<SecondUser>'
And open order item with following clock number '<FirstClockNumber>'
And fill following fields for Add information form on order item page:
| Advertiser   |
| <Advertiser> |
Then I should see warning with message 'You are not allowed to place an order with this option.Please select different option' next following field '<WarningMessageFieldName>' on order item page

Examples:
| Agency      | FirstUser     | SecondUser    | FirstClockNumber | SecondClockNumber | AdvertiserCondition | AdvertiserMetadataValue | BrandCondition | BrandMetadataValue | SubbrandCondition | SubbrandMetadataValue | ProductCondition | ProductMetadataValue | Advertiser   | WarningMessageFieldName |
| RVBOMRA14_1 | RVBOMRU14_1_1 | RVBOMRU14_1_2 | RVBOMRCN14_1_1   | RVBOMRCN14_1_2    | Equal               | RVBOMRAR14_1            | Equal          | RVBOMRBR14_1       | Equal             | RVBOMRSB14_1          | Equal            | RVBOMRPR14_1         | RVBOMRAR14_2 | Advertiser              |


Scenario: Check warning message displayed for Brand field when Delivery Access Rule is set
!--NGN-16215
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| <Agency> | DefaultA4User |
And created users with following fields:
| Email        | Role         | AgencyUnique |
| <FirstUser>  | agency.admin | <Agency>     |
| <SecondUser> | agency.user  | <Agency>     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser   | Brand        | Sub Brand    | Product      |
| RVBOMRAR15_1 | RVBOMRBR15_1 | RVBOMRSB15_1 | RVBOMRPR15_1 |
| RVBOMRAR15_2 | RVBOMRBR15_2 | RVBOMRSB15_2 | RVBOMRPR15_2 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency '<Agency>' by following fields:
| Make it common for order |
| should                   |
And logged in with details of '<FirstUser>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser   | Brand        | Sub Brand    | Product      | Clock Number       |
| RVBOMRAR15_1 | RVBOMRBR15_1 | RVBOMRSB15_1 | RVBOMRPR15_1 | <FirstClockNumber> |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser   | Brand        | Sub Brand    | Product      | Clock Number        |
| RVBOMRAR15_2 | RVBOMRBR15_2 | RVBOMRSB15_2 | RVBOMRPR15_2 | <SecondClockNumber> |
And I am on user '<SecondUser>' delivery page in administration area
When I fill following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition             | Metadata Value            |
| Advertiser     | <AdvertiserCondition> | <AdvertiserMetadataValue> |
| Brand          | <BrandCondition>      | <BrandMetadataValue>      |
| Sub Brand      | <SubbrandCondition>   | <SubbrandMetadataValue>   |
| Product        | <ProductCondition>    | <ProductMetadataValue>    |
And save delivery access rules on Delivery Access Rule Builder form
And login with details of '<SecondUser>'
And open order item with following clock number '<FirstClockNumber>'
And fill following fields for Add information form on order item page:
| Advertiser   |
| <Advertiser> |
And fill following fields for Add information form on order item page:
| Brand   |
| <Brand> |
Then I should see warning with message 'You are not allowed to place an order with this option.Please select different option' next following field '<WarningMessageFieldName>' on order item page

Examples:
| Agency      | FirstUser     | SecondUser    | FirstClockNumber | SecondClockNumber | AdvertiserCondition | AdvertiserMetadataValue | BrandCondition | BrandMetadataValue | SubbrandCondition | SubbrandMetadataValue | ProductCondition | ProductMetadataValue | Advertiser   | Brand        | WarningMessageFieldName |
| RVBOMRA15_1 | RVBOMRU15_1_1 | RVBOMRU15_1_2 | RVBOMRCN15_1_1   | RVBOMRCN15_1_2    | Equal               | RVBOMRAR15_1            | Equal          | RVBOMRBR15_1       | Equal             | RVBOMRSB15_1          | Equal            | RVBOMRPR15_1         | RVBOMRAR15_2 | RVBOMRBR15_2 | Brand                   |


Scenario: Check warning message displayed for SubBrand field when Delivery Access Rule is set
!--NGN-16215
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| <Agency> | DefaultA4User |
And created users with following fields:
| Email        | Role         | AgencyUnique |
| <FirstUser>  | agency.admin | <Agency>     |
| <SecondUser> | agency.user  | <Agency>     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser   | Brand        | Sub Brand    | Product      |
| RVBOMRAR16_1 | RVBOMRBR16_1 | RVBOMRSB16_1 | RVBOMRPR16_1 |
| RVBOMRAR16_2 | RVBOMRBR16_2 | RVBOMRSB16_2 | RVBOMRPR16_2 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency '<Agency>' by following fields:
| Make it common for order |
| should                   |
And logged in with details of '<FirstUser>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser   | Brand        | Sub Brand    | Product      | Clock Number       |
| RVBOMRAR16_1 | RVBOMRBR16_1 | RVBOMRSB16_1 | RVBOMRPR16_1 | <FirstClockNumber> |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser   | Brand        | Sub Brand    | Product      | Clock Number        |
| RVBOMRAR16_2 | RVBOMRBR16_2 | RVBOMRSB16_2 | RVBOMRPR16_2 | <SecondClockNumber> |
And I am on user '<SecondUser>' delivery page in administration area
When I fill following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition             | Metadata Value            |
| Advertiser     | <AdvertiserCondition> | <AdvertiserMetadataValue> |
| Brand          | <BrandCondition>      | <BrandMetadataValue>      |
| Sub Brand      | <SubbrandCondition>   | <SubbrandMetadataValue>   |
| Product        | <ProductCondition>    | <ProductMetadataValue>    |
And save delivery access rules on Delivery Access Rule Builder form
And login with details of '<SecondUser>'
And open order item with following clock number '<FirstClockNumber>'
And fill following fields for Add information form on order item page:
| Advertiser   | Brand   | Sub Brand  |
| <Advertiser> | <Brand> | <Subbrand> |
Then I should see warning with message 'You are not allowed to place an order with this option.Please select different option' next following field '<WarningMessageFieldName>' on order item page

Examples:
| Agency      | FirstUser     | SecondUser    | FirstClockNumber | SecondClockNumber | AdvertiserCondition | AdvertiserMetadataValue | BrandCondition | BrandMetadataValue | SubbrandCondition | SubbrandMetadataValue | ProductCondition | ProductMetadataValue | Advertiser   | Brand        | Subbrand     | WarningMessageFieldName |
| RVBOMRA16_1 | RVBOMRU16_1_1 | RVBOMRU16_1_2 | RVBOMRCN16_1_1   | RVBOMRCN16_1_2    | Equal               | RVBOMRAR16_1            | Equal          | RVBOMRBR16_1       | Equal             | RVBOMRSB16_1          | Equal            | RVBOMRPR16_1         | RVBOMRAR16_2 | RVBOMRBR16_2 | RVBOMRSB16_2 | Sub_Brand               |


Scenario: Check warning message displayed for Product field when Delivery Access Rule is set
!--NGN-16215
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| <Agency> | DefaultA4User |
And created users with following fields:
| Email        | Role         | AgencyUnique |
| <FirstUser>  | agency.admin | <Agency>     |
| <SecondUser> | agency.user  | <Agency>     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser   | Brand        | Sub Brand    | Product      |
| RVBOMRAR17_1 | RVBOMRBR17_1 | RVBOMRSB17_1 | RVBOMRPR17_1 |
| RVBOMRAR17_2 | RVBOMRBR17_2 | RVBOMRSB17_2 | RVBOMRPR17_2 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency '<Agency>' by following fields:
| Make it common for order |
| should                   |
And logged in with details of '<FirstUser>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser   | Brand        | Sub Brand    | Product      | Clock Number       |
| RVBOMRAR17_1 | RVBOMRBR17_1 | RVBOMRSB17_1 | RVBOMRPR17_1 | <FirstClockNumber> |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Advertiser   | Brand        | Sub Brand    | Product      | Clock Number        |
| RVBOMRAR17_2 | RVBOMRBR17_2 | RVBOMRSB17_2 | RVBOMRPR17_2 | <SecondClockNumber> |
And I am on user '<SecondUser>' delivery page in administration area
When I fill following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition             | Metadata Value            |
| Advertiser     | <AdvertiserCondition> | <AdvertiserMetadataValue> |
| Brand          | <BrandCondition>      | <BrandMetadataValue>      |
| Sub Brand      | <SubbrandCondition>   | <SubbrandMetadataValue>   |
| Product        | <ProductCondition>    | <ProductMetadataValue>    |
And save delivery access rules on Delivery Access Rule Builder form
And login with details of '<SecondUser>'
And open order item with following clock number '<FirstClockNumber>'
And fill following fields for Add information form on order item page:
| Advertiser   | Brand   | Sub Brand  | Product   |
| <Advertiser> | <Brand> | <Subbrand> | <Product> |
Then I should see warning with message 'You are not allowed to place an order with this option.Please select different option' next following field '<WarningMessageFieldName>' on order item page

Examples:
| Agency      | FirstUser     | SecondUser    | FirstClockNumber | SecondClockNumber | AdvertiserCondition | AdvertiserMetadataValue | BrandCondition | BrandMetadataValue | SubbrandCondition | SubbrandMetadataValue | ProductCondition | ProductMetadataValue | Advertiser   | Brand        | Subbrand     | Product      | WarningMessageFieldName |
| RVBOMRA17_1 | RVBOMRU17_1_1 | RVBOMRU17_1_2 | RVBOMRCN17_1_1   | RVBOMRCN17_1_2    | Equal               | RVBOMRAR17_1            | Equal          | RVBOMRBR17_1       | Equal             | RVBOMRSB17_1          | Equal            | RVBOMRPR17_1         | RVBOMRAR17_2 | RVBOMRBR17_2 | RVBOMRSB17_2 | RVBOMRPR17_2 | Product                 |



Scenario: Check order can't be placed with incorrect Delivery Access Rule fields and also warns user with warning messsage
!--NGN-16215
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| <Agency> | DefaultA4User |
And created users with following fields:
| Email        | Role         | AgencyUnique |
| <FirstUser>  | agency.admin | <Agency>     |
| <SecondUser> | agency.user  | <Agency>     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser  | Brand       | Sub Brand   | Product     |
| RVBOMRAR18_1 | RVBOMRBR18_1 | RVBOMRSB18_1 | RVBOMRPR18_1 |
| RVBOMRAR18_2 | RVBOMRBR18_2 | RVBOMRSB18_2 | RVBOMRPR18_2 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency '<Agency>' by following fields:
| Make it common for order |
| should                   |
And logged in with details of '<FirstUser>'
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product      | Campaign | Clock Number       | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination     |
| automated test info    | RVBOMRAR18_1 | RVBOMRBR18_1 | RVBOMRSB18_1 | RVBOMRPR18_1 | RVBOMRC  | <FirstClockNumber> | 20       | 10/14/2022     | HD 1080i 25fps | RVBOMRT | None               | Aastha:Standard |
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product      | Campaign | Clock Number        | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination     |
| automated test info    | RVBOMRAR18_2 | RVBOMRBR18_2 | RVBOMRSB18_2 | RVBOMRPR18_2 | RVBOMRC  | <SecondClockNumber> | 20       | 10/14/2022     | HD 1080i 25fps | RVBOMRT | None               | Aastha:Standard |
And I am on user '<SecondUser>' delivery page in administration area
When I fill following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition             | Metadata Value            |
| Advertiser     | <AdvertiserCondition> | <AdvertiserMetadataValue> |
| Brand          | <BrandCondition>      | <BrandMetadataValue>      |
| Sub Brand      | <SubbrandCondition>   | <SubbrandMetadataValue>   |
| Product        | <ProductCondition>    | <ProductMetadataValue>    |
And save delivery access rules on Delivery Access Rule Builder form
And login with details of '<SecondUser>'
And open order item with following clock number '<FirstClockNumber>'
And fill following fields for Add information form on order item page:
| Advertiser   | Brand   | Sub Brand  | Product   |
| <Advertiser> | <Brand> | <Subbrand> | <Product> |
And click active Proceed button on order item page
Then I should see warning with message 'You are not allowed to place an order with this option.Please select different option' next following field '<WarningMessageFieldName>' on order item page

Examples:
| Agency      | FirstUser     | SecondUser    | FirstClockNumber | SecondClockNumber | AdvertiserCondition | AdvertiserMetadataValue | BrandCondition | BrandMetadataValue | SubbrandCondition | SubbrandMetadataValue | ProductCondition | ProductMetadataValue | Advertiser   | Brand        | Subbrand     | Product      | WarningMessageFieldName |
| RVBOMRA18_1 | RVBOMRU18_1_1 | RVBOMRU18_1_2 | RVBOMRCN18_1_1   | RVBOMRCN18_1_2    | Equal               | RVBOMRAR18_1            | Equal          | RVBOMRBR18_1       | Equal             | RVBOMRSB18_1          | Equal            | RVBOMRPR18_1         | RVBOMRAR18_2 | RVBOMRBR18_2 | RVBOMRSB18_2 | RVBOMRPR18_2 | Product                 |

Scenario: Check that secondary BU admin can view Delivery tab for BU1 user
!--NGN-16218
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| RVBOMRA20_1 | DefaultA4User |
| RVBOMRA20_2 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| RVBOMRU4_1 | agency.admin | RVBOMRA20_1       |
| RVBOMRU4_2 | agency.admin | RVBOMRA20_2       |
And created 'RVBOMRR1' role with 'asset_filter_collection.create,asset_filter_collection_break.create,dictionary.add_on_the_fly,dictionary.read,enum.read,role.read,tv_order.read' permissions in 'global' group for advertiser 'RVBOMRA20_2'
And added existing user 'RVBOMRU4_1' to agency 'RVBOMRA20_2' with role 'agency.admin'
And logged in with details of 'RVBOMRU4_2'
And on user 'RVBOMRU4_2' delivery page in administration area
And refreshed the page without delay
And edited for user 'RVBOMRU4_1' agency with custom role 'RVBOMRR1'
And refreshed the page without delay
And on user 'RVBOMRU4_1' delivery page in administration area
Then I 'should' see delivery tab for 'RVBOMRU4_1' user in administration area


Scenario: Check that secondary BU admin can't see Delivery access rules set for user in another BU
!--NGN-16218
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| RVBOMRA21_1 | DefaultA4User |
| RVBOMRA21_2 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| RVBOMRU5_1 | agency.admin | RVBOMRA21_1       |
| RVBOMRU5_2 | agency.admin | RVBOMRA21_2       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RVBOMRA21_1':
| Advertiser | Brand   | Sub Brand | Product |
| RVBOMRAD1    | RVBOMRBR1 | RVBOMRSB1   | RVBOMRPR1 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency 'RVBOMRA21_1' by following fields:
| Make it common for order |
| should                   |
And created 'RVBOMRR1' role with 'asset_filter_collection.create,asset_filter_collection_break.create,dictionary.add_on_the_fly,dictionary.read,enum.read,role.read,tv_order.read' permissions in 'global' group for advertiser 'RVBOMRA21_2'
And added existing user 'RVBOMRU5_1' to agency 'RVBOMRA21_2' with role 'agency.admin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RVBOMRA21_2':
| Advertiser | Brand   | Sub Brand | Product |
| RVBOMRAD2    | RVBOMRBR2 | RVBOMRSB2   | RVBOMRPR2 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency 'RVBOMRA21_2' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'RVBOMRU5_2'
And on user 'RVBOMRU5_2' delivery page in administration area
And refreshed the page without delay
And edited for user 'RVBOMRU5_1' agency with custom role 'RVBOMRR1'
And refreshed the page without delay
And logged in with details of 'RVBOMRU5_1'
And on user 'RVBOMRU5_1' delivery page in administration area
And filled following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition | Metadata Value |
| Advertiser     | Equal     | RVBOMRAD1        |
| Brand          | Equal     | RVBOMRBR1        |
| Sub Brand      | Not Equal | RVBOMRSB1        |
| Product        | Not Equal | RVBOMRPR1        |
And saved delivery access rules on Delivery Access Rule Builder window
When I login with details of 'RVBOMRU5_2'
And go to user 'RVBOMRU5_1' delivery page in administration area
Then I 'should not' see delivery access rules with following metadata fields 'Advertiser,Brand,Sub Brand,Product' on users delivery page

Scenario: Check that secondary BU admin can add Delivery access rules for user in another BU
!--NGN-16218
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| RVBOMRA22_1 | DefaultA4User |
| RVBOMRA22_2 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| RVBOMRU6_1 | agency.admin | RVBOMRA22_1       |
| RVBOMRU6_2 | agency.admin | RVBOMRA22_2       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RVBOMRA22_1':
| Advertiser | Brand   | Sub Brand | Product |
| RVBOMRAD1    | RVBOMRBR1 | RVBOMRSB1   | RVBOMRPR1 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency 'RVBOMRA22_1' by following fields:
| Make it common for order |
| should                   |
And created 'RVBOMRR1' role with 'asset_filter_collection.create,asset_filter_collection_break.create,dictionary.add_on_the_fly,dictionary.read,enum.read,role.read,tv_order.read' permissions in 'global' group for advertiser 'RVBOMRA22_2'
And added existing user 'RVBOMRU6_1' to agency 'RVBOMRA22_2' with role 'agency.admin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RVBOMRA22_2':
| Advertiser | Brand   | Sub Brand | Product |
| RVBOMRAD2    | RVBOMRBR2 | RVBOMRSB2   | RVBOMRPR2 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency 'RVBOMRA22_2' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'RVBOMRU6_2'
And on user 'RVBOMRU6_2' delivery page in administration area
And refreshed the page without delay
And edited for user 'RVBOMRU6_1' agency with custom role 'RVBOMRR1'
And refreshed the page without delay
And logged in with details of 'RVBOMRU6_1'
And on user 'RVBOMRU6_1' delivery page in administration area
And filled following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition | Metadata Value |
| Advertiser     | Equal     | RVBOMRAD1        |
| Brand          | Equal     | RVBOMRBR1        |
| Sub Brand      | Not Equal | RVBOMRSB1        |
| Product        | Not Equal | RVBOMRPR1        |
And saved delivery access rules on Delivery Access Rule Builder window
When I login with details of 'RVBOMRU6_2'
And go to user 'RVBOMRU6_1' delivery page in administration area
And fill following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition | Metadata Value |
| Advertiser     | Equal     | RVBOMRAD2        |
| Brand          | Equal     | RVBOMRBR2        |
| Sub Brand      | Not Equal | RVBOMRSB2        |
| Product        | Not Equal | RVBOMRPR2        |
And save delivery access rules on Delivery Access Rule Builder window
And refresh the page without delay
Then I should see following delivery access rules on users delivery page:
| Metadata Field | Condition | Metadata Value |
| Advertiser     | Equal     | RVBOMRAD2        |
| Brand          | Equal     | RVBOMRBR2        |
| Sub Brand      | Not Equal | RVBOMRSB2        |
| Product        | Not Equal | RVBOMRPR2        |

Scenario: Check orders on delivery page as per Delivery access rules settings
!--NGN-16218
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| RVBOMRA23_1 | DefaultA4User |
| RVBOMRA23_2 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| RVBOMRU7_1 | agency.admin | RVBOMRA23_1       |
| RVBOMRU7_2 | agency.admin | RVBOMRA23_2       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RVBOMRA23_1':
| Advertiser | Brand   | Sub Brand | Product |
| RVBOMRAD1    | RVBOMRBR1 | RVBOMRSB1   | RVBOMRPR1 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency 'RVBOMRA23_1' by following fields:
| Make it common for order |
| should                   |
And created 'RVBOMRR1' role with 'asset_filter_collection.create,asset_filter_collection_break.create,dictionary.add_on_the_fly,dictionary.read,enum.read,role.read,tv_order.read' permissions in 'global' group for advertiser 'RVBOMRA23_2'
And added existing user 'RVBOMRU7_1' to agency 'RVBOMRA23_2' with role 'agency.admin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'RVBOMRA23_2':
| Advertiser  | Brand       | Sub Brand   | Product     |
| RVBOMRAD2_1 | RVBOMRBR2_1 | RVBOMRSB2_1 | RVBOMRPR2_1 |
| RVBOMRAD2_2 | RVBOMRBR2_2 | RVBOMRSB2_2 | RVBOMRPR2_2 |
And updated metadatas 'Advertiser,Brand,Sub Brand,Product' in schema 'common' of agency 'RVBOMRA23_2' by following fields:
| Make it common for order |
| should                   |
And logged in with details of 'RVBOMRU7_2'
And on user 'RVBOMRU7_2' delivery page in administration area
And refreshed the page without delay
And edited for user 'RVBOMRU7_1' agency with custom role 'RVBOMRR1'
And refreshed the page without delay
And logged in with details of 'RVBOMRU7_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination     |
| automated test info    | RVBOMRAD1  | RVBOMRBR1 | RVBOMRSB1 | RVBOMRPR1 | RVBOMRC1 | RVBOMRCN1    | 20       | 10/14/2022     | HD 1080i 25fps | RVBOMRT1 | None               | Aastha:Standard |
And complete order contains item with clock number 'RVBOMRCN1' with following fields:
| Job Number | PO Number |
| RVBOMRJO1  | RVBOMRPO1 |
When I login with details of 'RVBOMRU7_2'
And go to user 'RVBOMRU7_1' delivery page in administration area
And fill following fields for Delivery Access Rule Builder form on users delivery page:
| Metadata Field | Condition | Metadata Value |
| Advertiser     | Equal     | RVBOMRAD2_1    |
| Brand          | Equal     | RVBOMRBR2_1    |
| Sub Brand      | Equal     | RVBOMRSB2_1    |
| Product        | Equal     | RVBOMRPR2_1    |
And save delivery access rules on Delivery Access Rule Builder window
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination   |
| automated test info    | RVBOMRAD2_1  | RVBOMRBR2_1 | RVBOMRSB2_1 | RVBOMRPR2_1 | RVBOMRC2_1 | RVBOMRCN2_1    | 20       | 10/14/2022     | HD 1080i 25fps | RVBOMRT2_1 | None               | Aastha:Standard |
And completed order contains item with clock number 'RVBOMRCN2_1' with following fields:
| Job Number | PO Number |
| RVBOMRJO2_1  | RVBOMRPO2_1 |
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination   |
| automated test info    | RVBOMRAD2_2  | RVBOMRBR2_2 | RVBOMRSB2_2 | RVBOMRPR2_2 | RVBOMRC2_2 | RVBOMRCN2_2    | 20       | 10/14/2022     | HD 1080i 25fps | RVBOMRT2_2 | None               | Aastha:Standard |
And completed order contains item with clock number 'RVBOMRCN2_2' with following fields:
| Job Number | PO Number |
| RVBOMRJO2_2  | RVBOMRPO2_2 |
And go to View Live Orders tab of 'tv' order on ordering page
Then I should see TV order in 'live' order list with item title 'RVBOMRT2_1' and following fields:
| Order# | DateTime    | Advertiser | Brand     | Sub Brand | Product   | Market         | PO Number | Job #     | NoClocks | Status        |
| Digit  | CurrentTime | RVBOMRAD2_1  | RVBOMRBR2_1 | RVBOMRSB2_1 | RVBOMRPR2_1 | United Kingdom | RVBOMRPO2_1 | RVBOMRJO2_1 | 1        | 0/1 Delivered |
And should see TV order in 'live' order list with item title 'RVBOMRT2_2' and following fields:
| Order# | DateTime    | Advertiser | Brand     | Sub Brand | Product   | Market         | PO Number | Job #     | NoClocks | Status        |
| Digit  | CurrentTime | RVBOMRAD2_2  | RVBOMRBR2_2 | RVBOMRSB2_2 | RVBOMRPR2_2 | United Kingdom | RVBOMRPO2_2 | RVBOMRJO2_2 | 1        | 0/1 Delivered |
When I login with details of 'RVBOMRU7_1'
And go to View Live Orders tab of 'tv' order on ordering page
Then I should see TV order in 'live' order list with item title 'RVBOMRT1' and following fields:
| Order# | DateTime    | Advertiser | Brand   | Sub Brand | Product | Market         | PO Number | Job #   | NoClocks | Status        |
| Digit  | CurrentTime | RVBOMRAD1    | RVBOMRBR1 | RVBOMRSB1   | RVBOMRPR1 | United Kingdom | RVBOMRPO1   | RVBOMRJO1 | 1        | 0/1 Delivered |
And should see TV order in 'live' order list with item title 'RVBOMRT2_1' and following fields:
| Order# | DateTime    | Advertiser | Brand     | Sub Brand | Product   | Market         | PO Number | Job #     | NoClocks | Status        |
| Digit  | CurrentTime | RVBOMRAD2_1  | RVBOMRBR2_1 | RVBOMRSB2_1 | RVBOMRPR2_1 | United Kingdom | RVBOMRPO2_1 | RVBOMRJO2_1 | 1        | 0/1 Delivered |
And 'should not' see order items with following clock numbers 'RVBOMRC2_2' in 'live' order list for 'tv' order with market 'United Kingdom'

Scenario: Check BU admin can build Delivery Access Rules based on Common for Order fields
Meta: @ordering
!--NGN-16220 (Scenarios for Catalogue structure already covered above)
Given I created the following agency:
| Name      | A4User        |
| RVBOMRA19 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| RVBOMRU19 | agency.admin | RVBOMRA19    |
And logged in with details of 'RVBOMRU19'
And I am on the global 'common custom' metadata page for agency 'RVBOMRA19'
And created 'Dropdown' custom metadata field with following information on opened metadata page:
| Description     | MultipleChoices | Mark As Product | Descendants | Delivery |
| Dropdown Custom | should          | should          | drop1,drop2 | should   |
And updated metadatas 'Dropdown Custom' in schema 'common' of agency 'RVBOMRA19' by following fields:
| Make it common for order |
| should                   |
And I am on user 'RVBOMRU19' delivery page in administration area
Then I should see available following metadata fields 'Dropdown Custom' for Metadata Field on Delivery Access Rule Builder form
When I fill following fields for Delivery Access Rule Builder form on users delivery page without wrapping current session ID:
| Metadata Field  | Condition | Metadata Value |
| Dropdown Custom | Equal     | drop1          |
And save delivery access rules on Delivery Access Rule Builder form
Then I should see following delivery access rules on users delivery page without wrapping current session ID:
| Metadata Field  | Condition | Metadata Value |
| Dropdown Custom | Equal     | drop1          |