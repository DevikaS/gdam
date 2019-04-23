!--ORD-1113
!--ORD-1579
Feature: Copy button within concertina sections
Narrative:
In order to:
As a AgencyAdmin
I want to check correct copy action within concertina sections

Scenario: Copy To All for Add Information section filling manually fields
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name      | A4User        |
| OTVCBWSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVCBWSU1 | agency.admin | OTVCBWSA1    |
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCBWSA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVCBWSAR1 | OTVCBWSBR1 | OTVCBWSSB1 | OTVCBWSP1 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVCBWSA1'
And on the global 'common custom' metadata page for agency 'OTVCBWSA1'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And logged in with details of 'OTVCBWSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVCBWSCN1_1 |
| OTVCBWSCN1_2 |
When I open order item with following clock number 'OTVCBWSCN1_1'
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Title       | Duration | First Air Date | Format         | Subtitles Required |
| automated test info    | OTVCBWSAR1 | OTVCBWSBR1 | OTVCBWSSB1 | OTVCBWSP1 | OTVCBWSC1 | OTVCBWSCN1_1 | OTVCBWST1_1 | 20       | 12/14/2022     | HD 1080i 25fps | Already Supplied   |
And copy data from 'Add information' section of order item page to all other items
And select '2' order item with following clock number 'OTVCBWSCN1_1' on cover flow
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Title       | Duration | First Air Date | Format         | Subtitles Required |
| automated test info    | OTVCBWSAR1 | OTVCBWSBR1 | OTVCBWSSB1 | OTVCBWSP1 | OTVCBWSC1 | OTVCBWSCN1_1 | OTVCBWST1_1 | 20       | 12/14/2022     | HD 1080i 25fps | Already Supplied   |


Scenario: Copy To All for Add Information section filling manually fields in Library
!--ORD-3202
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVCBWSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| OTVCBWSU1 | agency.admin | OTVCBWSA1    |streamlined_library|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCBWSA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVCBWSAR1 | OTVCBWSBR1 | OTVCBWSSB1 | OTVCBWSP1 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVCBWSA1'
And logged in with details of 'OTVCBWSU1'
And uploaded following assetsNEWLIB:
| Name                |
| /files/Fish1-Ad.mov |
And waited while transcoding is finished in collection 'My Assets'NEWLIB
When I 'save' asset 'Fish1-Ad.mov' info of collection 'My Assets' by following informationNEWLIB:
| FieldName    | FieldValue       |
| Title        | Fish1-Ad-new.mov |
| Clock number | OTVCBWSCN2_1     |
| Screen       | Music Promo      |
| Air Date     | 12/14/22       |
| Advertiser   | OTVCBWSAR1       |
| Brand        | OTVCBWSBR1       |
| Sub Brand    | OTVCBWSSB1       |
| Product      | OTVCBWSP1        |
And created 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code    |
| OTVCBWSCN2_2 |
| OTVCBWSCN2_3 |
And added to 'music' order item with isrc code 'OTVCBWSCN2_2' following asset 'Fish1-Ad-new.mov' of collection 'My Assets'
And open order item with following isrc code 'OTVCBWSCN2_1'
And copy data from 'Add information' section of order item page to all other items
And select '2' order item with following isrc code 'OTVCBWSCN2_1' on cover flow
Then I should see following data for order item on Add information form:
| Additional Information | Record Company | Brand      | Sub Brand  | Label     | Artist | ISRC Code    | Title            | Release Date | Format  |
|                        | OTVCBWSAR1     | OTVCBWSBR1 | OTVCBWSSB1 | OTVCBWSP1 |        | OTVCBWSCN2_1 | Fish1-Ad-new.mov | 12/14/2022   |         |


Scenario: Copy to All action for Add Information section from empty asset to QC asset
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVCBWSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVCBWSU1 | agency.admin | OTVCBWSA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCBWSA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVCBWSAR1 | OTVCBWSBR1 | OTVCBWSSB1 | OTVCBWSP1 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVCBWSA1'
And logged in with details of 'OTVCBWSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVCBWSAR1 | OTVCBWSBR1 | OTVCBWSSB1 | OTVCBWSP1 | OTVCBWSC3 | OTVCBWSCN3_1 | 20       | 12/14/2022     | HD 1080i 25fps | OTVCBWST3 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OTVCBWSCN3_1' with following fields:
| Job Number | PO Number  |
| OTVCBWSJN3 | OTVCBWSPN3 |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| OTVCBWSCN3_2 |
| OTVCBWSCN3_3 |
And add to 'tv' order item with clock number 'OTVCBWSCN3_3' following qc asset 'OTVCBWST3' of collection 'My Assets'
When I open order item with clock number 'OTVCBWSCN3_1' for order with market 'Republic of Ireland'
And fill following fields for Add information form on order item page:
| Additional Information |
| automated test info    |
And select order item with following clock number 'OTVCBWSCN3_2' on cover flow
And copy data from 'Add information' section of order item page to all other items
And select order item with clock number 'OTVCBWSCN3_1' on cover flow for order with market 'Republic of Ireland'
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Title     | Duration | First Air Date | Format      | Subtitles Required |
|                        | OTVCBWSAR1 | OTVCBWSBR1 | OTVCBWSSB1 | OTVCBWSP1 | OTVCBWSC3 | OTVCBWSCN3_1 | OTVCBWST3 | 20       |                | SD PAL 16x9 | Already Supplied   |

Scenario: Copy To All for Add Information section from QC to empty asset
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVCBWSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVCBWSU1 | agency.admin | OTVCBWSA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCBWSA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVCBWSAR1 | OTVCBWSBR1 | OTVCBWSSB1 | OTVCBWSP1 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVCBWSA1'
And logged in with details of 'OTVCBWSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVCBWSAR1 | OTVCBWSBR1 | OTVCBWSSB1 | OTVCBWSP1 | OTVCBWSC4 | OTVCBWSCN4_1 | 20       | 12/14/2022     | HD 1080i 25fps | OTVCBWST4 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'OTVCBWSCN4_1' with following fields:
| Job Number | PO Number  |
| OTVCBWSJN4 | OTVCBWSPN4 |
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Clock Number |
| OTVCBWSCN4_2 |
| OTVCBWSCN4_3 |
And add to 'tv' order item with clock number 'OTVCBWSCN4_2' following qc asset 'OTVCBWST4' of collection 'My Assets'
When I open order item with clock number 'OTVCBWSCN4_1' for order with market 'Republic of Ireland'
And fill following fields for Add information form on order item page:
| Additional Information |
| automated test info    |
And copy data from 'Add information' section of order item page to all other items
And select '2' order item with clock number 'OTVCBWSCN4_1' on cover flow for order with market 'Republic of Ireland'
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Title     | Duration | First Air Date | Format      | Subtitles Required |
| automated test info    | OTVCBWSAR1 | OTVCBWSBR1 | OTVCBWSSB1 | OTVCBWSP1 | OTVCBWSC4 | OTVCBWSCN4_1 | OTVCBWST4 | 20       | 12/14/2022     | SD PAL 16x9 | Already Supplied   |

Scenario: Copy To All for Select Broadcast destination items
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name      | A4User        |
| OTVCBWSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVCBWSU1 | agency.admin | OTVCBWSA1    |
And logged in with details of 'OTVCBWSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number | Destination                                           |
| OTVCBWSCN5_1 | GEO News:Standard;ABN:Standard              |
| OTVCBWSCN5_2 |                                                       |
When I open order item with following clock number 'OTVCBWSCN5_1'
And copy data from 'Select Broadcast Destinations' section of order item page to all other items
And select order item with following clock number 'OTVCBWSCN5_2' on cover flow
Then I 'should' see selected following destinations for order item on Select Broadcast Destinations form:
| Standard     |
| GEO News;ABN |

Scenario:  Validation for Clock Number for Add information section
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVCBWSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVCBWSU1 | agency.admin | OTVCBWSA1    |
And logged in with details of 'OTVCBWSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVCBWSCN6_1 |
| OTVCBWSCN6_2 |
When I open order item with following clock number 'OTVCBWSCN6_1'
And copy data from 'Add information' section of order item page to all other items
Then I 'should' see warning icon next following fields 'Clock Number' for order item on Add information form
When I select '2' order item with following clock number 'OTVCBWSCN6_1' on cover flow
Then I 'should' see warning icon next following fields 'Clock Number' for order item on Add information form

Scenario: Functionality Copy to all appears if order items count more then one
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVCBWSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVCBWSU1 | agency.admin | OTVCBWSA1    |
And logged in with details of 'OTVCBWSU1'
And create '<OrderType>' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
Then I 'should not' see Copy to All link next to following sections 'Add information,Select Broadcast Destinations' on order item page

Examples:
| OrderType | ClockNumber  |
| tv        | OTVCBWSCN7_1 |
| music     | OTVCBWSCN7_2 |

Scenario: Copy QC and Ingest only state to the second order item
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVCBWSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVCBWSU1 | agency.admin | OTVCBWSA1    |
And logged in with details of 'OTVCBWSU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVCBWSCN8_1 |
| OTVCBWSCN8_2 |
And enable QC & Ingest Only for 'tv' order for item with following clock number 'OTVCBWSCN8_1'
When I open order item with following clock number 'OTVCBWSCN8_1'
And copy data from 'Select Broadcast Destinations' section of order item page to all other items
And select order item with following clock number 'OTVCBWSCN8_2' on cover flow
Then I should see 'inactive' QC & Ingest Only button on order item page

Scenario: Complete order if you use Copy to All functionality for Add information and Select Broadcast Destination sections

Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVCBWSA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVCBWSU1 | agency.admin | OTVCBWSA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVCBWSA1':
| Advertiser | Brand      | Sub Brand  | Product   |
| OTVCBWSAR1 | OTVCBWSBR1 | OTVCBWSSB1 | OTVCBWSP1 |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVCBWSA1'
And logged in with details of 'OTVCBWSU1'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand      | Sub Brand  | Label     | Artist      | ISRC Code    | Release Date | Format         | Title     | Destination     |
| automated test info    | OTVCBWSAR1     | OTVCBWSBR1 | OTVCBWSSB1 | OTVCBWSP1 | OTVCBWSC9_1 | OTVCBWSCN9_1 | 12/14/2022   | HD 1080i 25fps | OTVCBWST9 | Aastha:Standard |
|                        |                |            |            |           |             | OTVCBWSCN9_2 |              |                |           |                 |
When I open order item with following isrc code 'OTVCBWSCN9_1'
And copy data from 'Add information,Select Broadcast Destinations' sections of order item page to all other items
And select '2' order item with following isrc code 'OTVCBWSCN9_1' on cover flow
And fill following fields for Add information form on order item page:
| ISRC Code    | Artist      |
| OTVCBWSCN9_2 | OTVCBWSC9_2 |
And refresh the page without delay
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number  |
| OTVCBWSJN9 | OTVCBWSPN9 |
And confirm order on Order Proceed page
Then I should see Music 'live' order in order list with following fields:
| Order# | DateTime    | Record Company | Market         | PO Number  | Job #      | NoClocks | Status        |
| Digit  | CurrentTime | OTVCBWSAR1     | United Kingdom | OTVCBWSPN9 | OTVCBWSJN9 | 2        | 0/2 Delivered |