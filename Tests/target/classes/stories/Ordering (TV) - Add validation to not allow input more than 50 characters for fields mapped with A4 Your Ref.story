!--ORD-3459
!--ORD-3920
Feature: Add validation to not allow input more than 50 characters for fields mapped with A4 Your Ref
Narrative:
In order to:
As a AgencyAdmin
I want to check validation to not allow input more than 50 characters for fields mapped with A4 Your Ref

Scenario: Check validation to not allow input more than 50 characters for SUJET/AKM field of Austria market mapped with A4 Your Ref in order item
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| AVNAICA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| AVNAICU1 | agency.admin | AVNAICA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVNAICA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 |
And logged in with details of 'AVNAICU1'
And create 'tv' order with market 'Austria' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | SUJET/AKM                                                         | Destination                 |
| automated test info    | AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 | AVNAICC1 | AVNAICCN1    | 20       | 12/14/2022     | HD 1080i 25fps | AVNAICT1 | Phantasy Sound Under Exclusive License to Because Music AVNAICSA1 | Neuer Sender AT HD:Standard |
When I open order item with following clock number 'AVNAICCN1'
And click active Proceed button on order item page
Then I 'should not' see Order Proceed page
And 'should' see validation error next to following field 'SUJET/AKM' for order item on Add information form

Scenario: Check validation to not allow input more than 50 characters for Campaign field of Argentina market mapped with A4 Your Ref in order item
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| AVNAICA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| AVNAICU1 | agency.admin | AVNAICA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVNAICA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 |
And logged in with details of 'AVNAICU1'
And create 'tv' order with market 'Argentina' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign                                                         | Clock Number | Duration | First Air Date | Format         | Title    | Destination          |
| automated test info    | AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 | Phantasy Sound Under Exclusive License to Because Music AVNAICC2 | AVNAICCN2    | 20       | 12/14/2022     | HD 1080i 25fps | AVNAICT2 | Telefe:Standard (US) |
When I open order item with following clock number 'AVNAICCN2'
And click active Proceed button on order item page
Then I 'should not' see Order Proceed page
And 'should' see validation error next to following field 'Campaign' for order item on Add information form

Scenario: Check validation to not allow input more than 50 characters for CAD# field of Australia market mapped with A4 Your Ref in order item
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| AVNAICA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| AVNAICU1 | agency.admin | AVNAICA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVNAICA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 |
And logged in with details of 'AVNAICU1'
And create 'tv' order with market 'Australia' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | CAD#                                                               | Destination     |
| automated test info    | AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 | AVNAICC3 | AVNAICCN3    | 20       | 12/14/2022     | HD 1080i 25fps | AVNAICT3 | Phantasy Sound Under Exclusive License to Because Music AVNAICCNo3 | Qantas:Standard |
When I open order item with following clock number 'AVNAICCN3'
And click active Proceed button on order item page
Then I 'should not' see Order Proceed page
And 'should' see validation error next to following field 'CAD#' for order item on Add information form

Scenario: Check validation to not allow input more than 50 characters for MBCID Code field of Belgium market mapped with A4 Your Ref in order item
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| AVNAICA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| AVNAICU1 | agency.admin | AVNAICA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVNAICA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 |
And logged in with details of 'AVNAICU1'
And create 'tv' order with market 'Belgium' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | MBCID Code                                                        | Destination                         |
| automated test info    | AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 | AVNAICC4 | AVNAICCN4    | 20       | 12/14/2022     | HD 1080i 25fps | AVNAICT4 | Phantasy Sound Under Exclusive License to Because Music AVNAICMC4 | Discovery Networks Benelux:Standard |
When I open order item with following clock number 'AVNAICCN4'
And click active Proceed button on order item page
Then I 'should not' see Order Proceed page
And 'should' see validation error next to following field 'MBCID Code' for order item on Add information form

Scenario: Check validation to not allow input more than 50 characters for Megatime Code field of Chile market mapped with A4 Your Ref in order item
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| AVNAICA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| AVNAICU1 | agency.admin | AVNAICA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVNAICA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 |
And logged in with details of 'AVNAICU1'
And create 'tv' order with market 'Chile' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Megatime Code                                                     | Destination                      |
| automated test info    | AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 | AVNAICC5 | AVNAICCN5    | 20       | 12/14/2022     | HD 1080i 25fps | AVNAICT5 | Phantasy Sound Under Exclusive License to Because Music AVNAICMC5 | Multichannel Chile:Standard (US) |
When I open order item with following clock number 'AVNAICCN5'
And click active Proceed button on order item page
Then I 'should not' see Order Proceed page
And 'should' see validation error next to following field 'Megatime Code' for order item on Add information form

Scenario: Check validation to not allow input more than 50 characters for Televisa ID field of Mexico market mapped with A4 Your Ref in order item
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| AVNAICA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| AVNAICU1 | agency.admin | AVNAICA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVNAICA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 |
And logged in with details of 'AVNAICU1'
And create 'tv' order with market 'Mexico' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Televisa ID                                                       | Destination          |
| automated test info    | AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 | AVNAICC6 | AVNAICCN6    | 20       | 12/14/2022     | HD 1080i 25fps | AVNAICT6 | Phantasy Sound Under Exclusive License to Because Music AVNAICTI6 | Meo TV:Standard (US) |
When I open order item with following clock number 'AVNAICCN6'
And click active Proceed button on order item page
Then I 'should not' see Order Proceed page
And 'should' see validation error next to following field 'Televisa ID' for order item on Add information form

Scenario: Check validation to not allow input more than 50 characters for SUISA field of Switzerland market mapped with A4 Your Ref in order item
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| AVNAICA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| AVNAICU1 | agency.admin | AVNAICA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVNAICA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 |
And logged in with details of 'AVNAICU1'
And create 'tv' order with market 'Switzerland' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Suisa                                                            | Destination       |
| automated test info    | AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 | AVNAICC7 | AVNAICCN7    | 20       | 12/14/2022     | HD 1080i 25fps | AVNAICT7 | Phantasy Sound Under Exclusive License to Because Music AVNAICS7 | Tele Top:Standard |
When I open order item with following clock number 'AVNAICCN7'
And click active Proceed button on order item page
Then I 'should not' see Order Proceed page
And 'should' see validation error next to following field 'Suisa' for order item on Add information form

Scenario: Check validation to not allow input more than 50 characters for RIF Code field of Venezuela market mapped with A4 Your Ref in order item
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| AVNAICA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| AVNAICU1 | agency.admin | AVNAICA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVNAICA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 |
And logged in with details of 'AVNAICU1'
And create 'tv' order with market 'Venezuela' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | RIF Code                                                          | Destination              |
| automated test info    | AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 | AVNAICC8 | AVNAICCN8    | 20       | 12/14/2022     | HD 1080i 25fps | AVNAICT8 | Phantasy Sound Under Exclusive License to Because Music AVNAICRC8 | Televen SD:Standard (US) |
When I open order item with following clock number 'AVNAICCN8'
And click active Proceed button on order item page
Then I 'should not' see Order Proceed page
And 'should' see validation error next to following field 'RIF Code' for order item on Add information form

Scenario: check proceed action if not required field is empty
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| AVNAICA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| AVNAICU1 | agency.admin | AVNAICA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVNAICA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 |
And logged in with details of 'AVNAICU1'
And create 'tv' order with market 'Belgium' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Destination                         |
| automated test info    | AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 | AVNAICC9 | AVNAICCN9    | 20       | 12/14/2022     | HD 1080i 25fps | AVNAICT9 | Discovery Networks Benelux:Standard |
When I open order item with following clock number 'AVNAICCN9'
And click Proceed button on order item page
Then I 'should' see Order Proceed page

Scenario: Check validation to not allow input more than 50 characters for fields mapped with A4 Your Ref in qc-ed asset
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| AVNAICA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| AVNAICU1 | agency.admin | AVNAICA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVNAICA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 |
And logged in with details of 'AVNAICU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 | AVNAICC10 | AVNAICCN10_1 | 20       | 10/14/2022     | HD 1080i 25fps | AVNAICT10 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'Belgium' and items with following fields:
| Clock Number | MBCID Code                                                         | Destination                         |
| AVNAICCN10_2 | Phantasy Sound Under Exclusive License to Because Music AVNAICMC10 | Discovery Networks Benelux:Standard |
And complete order contains item with clock number 'AVNAICCN10_1' with following fields:
| Job Number | PO Number  |
| AVNAICJN10 | AVNAICPN10 |
And add to 'tv' order item with clock number 'AVNAICCN10_2' following qc asset 'AVNAICT10' of collection 'My Assets'
When I open order item with clock number 'AVNAICCN10_1' for order with market 'Belgium'
And click active Proceed button on order item page
Then I 'should not' see Order Proceed page
And 'should' see validation error next to following field 'MBCID Code' for order item on Add information form

Scenario: Check validation to not allow input more than 50 characters for fields mapped with A4 Your Ref in asset
!--market field wont be displayed in asset edit form on new lib which is expected behaviour
!--ORD-4012
Meta: @ordering
     @skip
Given I created the following agency:
| Name     | A4User        |
| AVNAICA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| AVNAICU1 | agency.admin | AVNAICA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'AVNAICA1':
| Advertiser | Brand     | Sub Brand | Product   |
| AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 |
And logged in with details of 'AVNAICU1'
And create 'tv' order with market 'Belgium' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Destination                         |
| automated test info    | AVNAICAR1  | AVNAICBR1 | AVNAICSB1 | AVNAICPR1 | AVNAICC11 | AVNAICCN11   | 20       | 12/14/2022     | HD 1080i 25fps | Discovery Networks Benelux:Standard |
And uploaded following assets:
| Name                 |
| /files/Fish1-Ad.mov  |
And waiting while transcoding is finished in collection 'My Assets' for asset 'Fish1-Ad.mov'
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following information:
| FieldName  | FieldValue                                                         |
| Market     | Belgium                                                            |
| MBCID Code | Phantasy Sound Under Exclusive License to Because Music AVNAICMC11 |
And added to 'tv' order item with clock number 'AVNAICCN11' following asset 'Fish1-Ad.mov' of collection 'My Assets'
And open order item with following clock number 'AVNAICCN11'
And click active Proceed button on order item page
Then I 'should' see Order Proceed page
