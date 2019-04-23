!--ORD-271
!--ORD-2199
Feature: Assign Transfer order
Narrative:
In order to:
As a AgencyAdmin
I want to check assign transfer order

Scenario: Editing info for the Transfer order after re-assign it
Meta: @ordering
!--BugRef--NGN-16944
Given I created the following agency:
| Name       | A4User        |
| OTVATOA1_1 | DefaultA4User |
| OTVATOA1_2 | DefaultA4User |
And added agency 'OTVATOA1_2' as a partner to agency 'OTVATOA1_1'
And created users with following fields:
| Email            | Role         | AgencyUnique |
| OTVATOU1_1_email | agency.admin | OTVATOA1_1   |
| OTVATOU1_2_email | agency.admin | OTVATOA1_2   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVATOA1_1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVATOAR1  | OTVATOBR1 | OTVATOSB1 | OTVATOPR1 |
And make 'Campaign' field from asset element project common schema available in Delivery for agencies 'OTVATOA1_1,OTVATOA1_2'
And logged in with details of 'OTVATOU1_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Destination                 |
| automated test info    | OTVATOAR1  | OTVATOBR1 | OTVATOSB1 | OTVATOPR1 | OTVATOC1 | OTVATOCN1    | 20       | 10/14/2022     | HD 1080i 25fps | OTVATOT1 | BSkyB Green Button:Standard |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City     | Post Code | Country  |
| Physical | OTVATODN1        | OTVATOCnN1   | OTVATOCD1       | OTVATOSA1      | OTVATOC1 | OTVATOPC1 | OTVATOC1 |
And create for 'tv' order with item clock number 'OTVATOCN1' additional services with following fields:
| Type     | Destination | Format     | Specification | Media Compile | No copies  | Delivery Details                                                     | Notes & Labels        | Express |
| Data DVD | OTVATODN1   | Avid DNxHD | SD NTSC 4x3   | Compile 1     | 1          | OTVATODN1 OTVATOCnN1 OTVATOCD1 OTVATOSA1 OTVATOC1 OTVATOPC1 OTVATOC1 | automated test notes  | should  |
And I am on View Draft Orders tab of 'tv' order on ordering page
When I select order with following item clock number 'OTVATOCN1' in 'draft' order list
And fill following fields for Transfer Order form on ordering page:
| Transfer to      | Message                     |
| OTVATOU1_2_email | autotest transfer message 1 |
And click Send button on Transfer Order form on ordering page
And login with details of 'OTVATOU1_2_email'
And go to View Draft Orders tab of 'tv' order on ordering page
And select order with following item clock number 'OTVATOCN1' in 'draft' order list
And fill following fields for Transfer Order form on ordering page:
| Transfer to      | Message                     |
| OTVATOU1_1_email | autotest transfer message 2 |
And click Send button on Transfer Order form on ordering page
And login with details of 'OTVATOU1_1_email'
And open order item with following clock number 'OTVATOCN1'
Then I should see 'enabled' Hold for approval button for active cover flow on order item page
And 'should' see Add Commercial button on order item page
And should see 'enabled' New master button for order item on Add media form
And should see 'enabled' Retrieve from Library button for order item at Add media to your order form
And should see 'enabled' Retrieve from Project button for order item at Add media to your order form
And 'should' see able to edit following fields 'Clock Number,Advertiser,Brand,Sub Brand,Product,Campaign,Title,Duration,First Air Date,Format,Subtitles Required,Additional Information' for order item on Add information form
And should see 'active' Select Broadcast Destinations section on order item page
And should see 'active' QC & Ingest Only button on order item page
And should see 'enabled' following fields 'Type,Destination,Format,Specification,Media Compile,No copies,Notes & Labels,Standard,Express' for order item on Additional Services section
And 'should' see Proceed button on order item page

Scenario: A Read-only content of order item page after transfer order
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name       | A4User        |
| OTVATOA1_1 | DefaultA4User |
| OTVATOA1_2 | DefaultA4User |
And added agency 'OTVATOA1_2' as a partner to agency 'OTVATOA1_1'
And created users with following fields:
| Email            | Role         | AgencyUnique |
| OTVATOU1_1_email | agency.admin | OTVATOA1_1   |
| OTVATOU1_2_email | agency.admin | OTVATOA1_2   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVATOA1_1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVATOAR1  | OTVATOBR1 | OTVATOSB1 | OTVATOPR1 |
And make 'Campaign' field from asset element project common schema available in Delivery for agencies 'OTVATOA1_1,OTVATOA1_2'
And logged in with details of 'OTVATOU1_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Destination                 |
| automated test info    | OTVATOAR1  | OTVATOBR1 | OTVATOSB1 | OTVATOPR1 | OTVATOC2 | OTVATOCN2    | 20       | 10/14/2022     | HD 1080i 25fps | OTVATOT2 | GEO News:Standard |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City     | Post Code | Country  |
| Physical | OTVATODN2        | OTVATOCnN2   | OTVATOCD2       | OTVATOSA2      | OTVATOC2 | OTVATOPC2 | OTVATOC2 |
And create for 'tv' order with item clock number 'OTVATOCN2' additional services with following fields:
| Type     | Destination | Format     | Specification | Media Compile | No copies  | Delivery Details                                                     | Notes & Labels        | Express |
| Data DVD | OTVATODN2   | Avid DNxHD | SD NTSC 4x3   | Compile 1     | 1          | OTVATODN2 OTVATOCnN2 OTVATOCD2 OTVATOSA2 OTVATOC2 OTVATOPC2 OTVATOC2 | automated test notes  | should  |
And transfered order contains item with clock number 'OTVATOCN2' to user 'OTVATOU1_2_email' with following message 'autotest transfer message'
When I open order item with following clock number 'OTVATOCN2'
Then I 'should not' see On Hold button on order item page
And 'should not' see Add Commercial button on order item page
And should see 'disabled' New master button for order item on Add media form
And should see 'disabled' Retrieve from Library button for order item at Add media to your order form
And should see 'disabled' Retrieve from Project button for order item at Add media to your order form
And 'should not' see able to edit following fields 'Clock Number,Advertiser,Brand,Sub Brand,Product,Campaign,Title,Duration,First Air Date,Format,Subtitles Required,Additional Information' for order item on Add information form
And should see 'active' Select Broadcast Destinations section on order item page
And should see 'inactive' QC & Ingest Only button on order item page
And should see 'disabled' following fields 'Type,Destination,Format,Specification,Media Compile,No copies,Delivery Details,Notes & Labels,Standard,Express' for order item on Additional Services section
And 'should not' see Proceed button on order item page

Scenario: Select Broadcast Destinations section should be expandable
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVATOA1_1 | DefaultA4User |
| OTVATOA1_2 | DefaultA4User |
And added agency 'OTVATOA1_2' as a partner to agency 'OTVATOA1_1'
And created users with following fields:
| Email            | Role         | AgencyUnique |
| OTVATOU1_1_email | agency.admin | OTVATOA1_1   |
| OTVATOU1_2_email | agency.admin | OTVATOA1_2   |
And logged in with details of 'OTVATOU1_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number | Destination                 |
| OTVATOCN3    | BSkyB Green Button:Standard |
And transfered order contains item with clock number 'OTVATOCN3' to user 'OTVATOU1_2_email' with following message 'autotest transfer message'
When I open order item with following clock number 'OTVATOCN3'
And expand 'Select Broadcast Destinations' section on order item page
Then I 'should' see expanded following sections 'Select Broadcast Destinations' on order item page

Scenario: check data of Additional Services section for assignee
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVATOA1_1 | DefaultA4User |
| OTVATOA1_2 | DefaultA4User |
And added agency 'OTVATOA1_2' as a partner to agency 'OTVATOA1_1'
And created users with following fields:
| Email            | Role         | AgencyUnique |
| OTVATOU1_1_email | agency.admin | OTVATOA1_1   |
| OTVATOU1_2_email | agency.admin | OTVATOA1_2   |
And logged in with details of 'OTVATOU1_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVATOCN4    |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City     | Post Code | Country  |
| Physical | OTVATODN4        | OTVATOCnN4   | OTVATOCD4       | OTVATOSA4      | OTVATOC4 | OTVATOPC4 | OTVATOC4 |
And create for 'tv' order with item clock number 'OTVATOCN4' additional services with following fields:
| Type     | Destination | Format     | Specification | Media Compile | No copies  | Delivery Details                                                     | Notes & Labels        | Express |
| Data DVD | OTVATODN4   | Avid DNxHD | SD NTSC 4x3   | Compile 1     | 1          | OTVATODN4 OTVATOCnN4 OTVATOCD4 OTVATOSA4 OTVATOC4 OTVATOPC4 OTVATOC4 | automated test notes  | should  |
And transfered order contains item with clock number 'OTVATOCN4' to user 'OTVATOU1_2_email' with following message 'autotest transfer message'
And logged in with details of 'OTVATOU1_2_email'
When I open order item with following clock number 'OTVATOCN4'
Then I should see following data for order item on Additional Services section:
| Type     | Destination | Format     | Specification | Media Compile | No copies  | Delivery Details                                                     | Notes & Labels         | Standard   | Express |
| Data DVD | OTVATODN4   | Avid DNxHD | SD NTSC 4x3   | Compile 1     | 1          | OTVATODN4 OTVATOCnN4 OTVATOCD4 OTVATOSA4 OTVATOC4 OTVATOPC4 OTVATOC4 | automated test notes   | should not | should  |

Scenario: check visibility Back button on order item page after assign order
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVATOA1_1 | DefaultA4User |
| OTVATOA1_2 | DefaultA4User |
And added agency 'OTVATOA1_2' as a partner to agency 'OTVATOA1_1'
And created users with following fields:
| Email            | Role         | AgencyUnique |
| OTVATOU1_1_email | agency.admin | OTVATOA1_1   |
| OTVATOU1_2_email | agency.admin | OTVATOA1_2   |
And logged in with details of 'OTVATOU1_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVATOCN5    |
And transfered order contains item with clock number 'OTVATOCN5' to user 'OTVATOU1_2_email' with following message 'autotest transfer message'
When I open order item with following clock number 'OTVATOCN5'
Then I 'should' see Back button on order item page
And should see following title 'Transferred Order View Only' on order item page

Scenario: check visibility Back button on order item page for first user
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVATOA1_1 | DefaultA4User |
| OTVATOA1_2 | DefaultA4User |
| OTVATOA1_3 | DefaultA4User |
And added agency 'OTVATOA1_2' as a partner to agency 'OTVATOA1_1'
And added agency 'OTVATOA1_3' as a partner to agency 'OTVATOA1_2'
And created users with following fields:
| Email            | Role         | AgencyUnique |
| OTVATOU1_1_email | agency.admin | OTVATOA1_1   |
| OTVATOU1_2_email | agency.admin | OTVATOA1_2   |
| OTVATOU1_3       | agency.admin | OTVATOA1_3   |
And logged in with details of 'OTVATOU1_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVATOCN6    |
And transfered order contains item with clock number 'OTVATOCN6' to user 'OTVATOU1_2_email' with following message 'autotest transfer message'
And logged in with details of 'OTVATOU1_2_email'
And transfered order contains item with clock number 'OTVATOCN6' to user 'OTVATOU1_3' with following message 'autotest transfer message'
And logged in with details of 'OTVATOU1_1_email'
When I open order item with following clock number 'OTVATOCN6'
Then I 'should' see Back button on order item page
And should see following title 'Transferred Order View Only' on order item page

Scenario: check visibility Back button on order item page for last user
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVATOA1_1 | DefaultA4User |
| OTVATOA1_2 | DefaultA4User |
| OTVATOA1_3 | DefaultA4User |
And added agency 'OTVATOA1_2' as a partner to agency 'OTVATOA1_1'
And added agency 'OTVATOA1_3' as a partner to agency 'OTVATOA1_2'
And created users with following fields:
| Email            | Role         | AgencyUnique |
| OTVATOU1_1_email | agency.admin | OTVATOA1_1   |
| OTVATOU1_2_email | agency.admin | OTVATOA1_2   |
| OTVATOU1_3       | agency.admin | OTVATOA1_3   |
And logged in with details of 'OTVATOU1_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVATOCN7    |
And transfered order contains item with clock number 'OTVATOCN7' to user 'OTVATOU1_2_email' with following message 'autotest transfer message'
And logged in with details of 'OTVATOU1_2_email'
And transfered order contains item with clock number 'OTVATOCN7' to user 'OTVATOU1_3' with following message 'autotest transfer message'
And logged in with details of 'OTVATOU1_3'
When I open order item with following clock number 'OTVATOCN7'
Then I 'should not' see Back button on order item page
And 'should not' see title on order item page

Scenario: check assigned order in list (for case new different CM catalogs)
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVATOA8_1 | DefaultA4User |
| OTVATOA8_2 | DefaultA4User |
And added agency 'OTVATOA8_2' as a partner to agency 'OTVATOA8_1'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVATOU8_1 | agency.admin | OTVATOA8_1   |
| OTVATOU8_2 | agency.admin | OTVATOA8_2   |
And created following 'common' custom metadata fields for agency 'OTVATOA8_1':
| FieldType          | Description         | Parent              | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom_1 |                     | true     | true                |
| CatalogueStructure | Brand Custom_1      | Advertiser Custom_1 | true     | true                |
| CatalogueStructure | Sub Brand Custom_1  | Brand Custom_1      | true     | true                |
| CatalogueStructure | Product Custom_1    | Sub Brand Custom_1  | true     | true                |
And created following 'common' custom metadata fields for agency 'OTVATOA8_2':
| FieldType          | Description         | Parent              | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom_2 |                     | true     | true                |
| CatalogueStructure | Brand Custom_2      | Advertiser Custom_2 | true     | true                |
| CatalogueStructure | Sub Brand Custom_2  | Brand Custom_2      | true     | true                |
| CatalogueStructure | Product Custom_2    | Sub Brand Custom_2  | true     | true                |
And updated agency 'OTVATOA8_1' by following marked as fields of schema 'common':
| Mark as Advertiser  | Mark as Product |
| Advertiser Custom_1 | Brand Custom_1  |
And updated agency 'OTVATOA8_2' by following marked as fields of schema 'common':
| Mark as Advertiser  | Mark as Product |
| Advertiser Custom_2 | Brand Custom_2  |
And logged in with details of 'OTVATOU8_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Campaign | Clock Number | Duration | First Air Date | Format         | Title    |
| automated test info    | OTVATOC8 | OTVATOCN8    | 20       | 10/14/2022     | HD 1080i 25fps | OTVATOT8 |
When I open order item with following clock number 'OTVATOCN8'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom_2 | Brand Custom_2 | Sub Brand Custom_2 | Product Custom_2 |
| OTVATOAR8           | OTVATOBR8      | OTVATOSB8          | OTVATOPR8        |
And save as draft order
And transfer order contains item with clock number 'OTVATOCN8' to user 'OTVATOU8_1' with following message 'autotest transfer message'
And login with details of 'OTVATOU8_1'
And go to View Draft Orders tab of 'tv' order on ordering page
Then I should see TV order in 'draft' order list with item clock number 'OTVATOCN8' and following fields:
| Order# | DateTime    | Advertiser | Brand     | Sub Brand | Product | Market         | NoClocks | Creator    | Owner      |
| Digit  | CurrentTime | OTVATOAR8  | OTVATOBR8 |           |         | United Kingdom | 1        | OTVATOU8_2 | OTVATOU8_1 |
And should see 'draft' order in 'tv' order list contains clock number 'OTVATOCN8' and items with following fields:
| Clock Number | Advertiser | Product   | Title    | First Air Date | Format         | Duration |
| OTVATOCN8    | OTVATOAR8  | OTVATOBR8 | OTVATOT8 | 10/14/2022     | HD 1080i 25fps | 20       |

Scenario: check Add Information section for assignee after assign order (for case new different CM catalogs)
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| OTVATOA9_1 | DefaultA4User |
| OTVATOA9_2 | DefaultA4User |
And added agency 'OTVATOA9_2' as a partner to agency 'OTVATOA9_1'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVATOU9_1 | agency.admin | OTVATOA9_1   |
| OTVATOU9_2 | agency.admin | OTVATOA9_2   |
And created following 'common' custom metadata fields for agency 'OTVATOA9_1':
| FieldType          | Description         | Parent              | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom_1 |                     | true     | true                |
| CatalogueStructure | Brand Custom_1      | Advertiser Custom_1 | true     | true                |
| CatalogueStructure | Sub Brand Custom_1  | Brand Custom_1      | true     | true                |
| CatalogueStructure | Product Custom_1    | Sub Brand Custom_1  | true     | true                |
And created following 'common' custom metadata fields for agency 'OTVATOA9_2':
| FieldType          | Description         | Parent              | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom_2 |                     | true     | true                |
| CatalogueStructure | Brand Custom_2      | Advertiser Custom_2 | true     | true                |
| CatalogueStructure | Sub Brand Custom_2  | Brand Custom_2      | true     | true                |
| CatalogueStructure | Product Custom_2    | Sub Brand Custom_2  | true     | true                |
And updated agency 'OTVATOA9_1' by following marked as fields of schema 'common':
| Mark as Advertiser  | Mark as Product |
| Advertiser Custom_1 | Brand Custom_1  |
And updated agency 'OTVATOA9_2' by following marked as fields of schema 'common':
| Mark as Advertiser  | Mark as Product |
| Advertiser Custom_2 | Brand Custom_2  |
And logged in with details of 'OTVATOU9_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Campaign | Clock Number | Duration | First Air Date | Format         | Title    |
| automated test info    | OTVATOC9 | OTVATOCN9    | 20       | 10/14/2022     | HD 1080i 25fps | OTVATOT9 |
When I open order item with following clock number 'OTVATOCN9'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom_2 | Brand Custom_2 | Sub Brand Custom_2 | Product Custom_2 |
| OTVATOAR9           | OTVATOBR9      | OTVATOSB9          | OTVATOPR9        |
And save as draft order
And transfer order contains item with clock number 'OTVATOCN9' to user 'OTVATOU9_1' with following message 'autotest transfer message'
And login with details of 'OTVATOU9_1'
And open order item with following clock number 'OTVATOCN9'
Then I should see following data for order item on Add information form:
| Additional Information | Campaign | Clock Number | Duration | First Air Date | Format         | Title    |
| automated test info    | OTVATOC9 | OTVATOCN9    | 20       | 10/14/2022     | HD 1080i 25fps | OTVATOT9 |
And should see following custom advertiser hierarchy fields data for order item on Add information form:
| Advertiser Custom_2 | Brand Custom_2 | Sub Brand Custom_2 | Product Custom_2 |
| OTVATOAR9           | OTVATOBR9      | OTVATOSB9          | OTVATOPR9        |

Scenario: check Add Information section of assigned order after edit it
Meta: @ordering
Given I created the following agency:
| Name        | A4User        |
| OTVATOA10_1 | DefaultA4User |
| OTVATOA10_2 | DefaultA4User |
And added agency 'OTVATOA10_2' as a partner to agency 'OTVATOA10_1'
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVATOU10_1 | agency.admin | OTVATOA10_1  |
| OTVATOU10_2 | agency.admin | OTVATOA10_2  |
And created following 'common' custom metadata fields for agency 'OTVATOA10_1':
| FieldType          | Description         | Parent              | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom_1 |                     | true     | true                |
| CatalogueStructure | Brand Custom_1      | Advertiser Custom_1 | true     | true                |
| CatalogueStructure | Sub Brand Custom_1  | Brand Custom_1      | true     | true                |
| CatalogueStructure | Product Custom_1    | Sub Brand Custom_1  | true     | true                |
And created following 'common' custom metadata fields for agency 'OTVATOA10_2':
| FieldType          | Description         | Parent              | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom_2 |                     | true     | true                |
| CatalogueStructure | Brand Custom_2      | Advertiser Custom_2 | true     | true                |
| CatalogueStructure | Sub Brand Custom_2  | Brand Custom_2      | true     | true                |
| CatalogueStructure | Product Custom_2    | Sub Brand Custom_2  | true     | true                |
And updated agency 'OTVATOA10_1' by following marked as fields of schema 'common':
| Mark as Advertiser  | Mark as Product |
| Advertiser Custom_1 | Brand Custom_1  |
And updated agency 'OTVATOA10_2' by following marked as fields of schema 'common':
| Mark as Advertiser  | Mark as Product |
| Advertiser Custom_2 | Brand Custom_2  |
And logged in with details of 'OTVATOU10_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       |
| automated test info 2  | OTVATOC10_2 | OTVATOCN10_2 | 20       | 10/14/2022     | HD 1080i 25fps | OTVATOT10_2 |
When I open order item with following clock number 'OTVATOCN10_2'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom_2 | Brand Custom_2 | Sub Brand Custom_2 | Product Custom_2 |
| OTVATOAR10_2        | OTVATOBR10_2   | OTVATOSB10_2       | OTVATOPR10_2     |
And save as draft order
And transfer order contains item with clock number 'OTVATOCN10_2' to user 'OTVATOU10_1' with following message 'autotest transfer message'
And login with details of 'OTVATOU10_1'
And open order item with following clock number 'OTVATOCN10_2'
And fill following fields for Add information form on order item page:
| Additional Information | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       |
| automated test info 1  | OTVATOC10_1 | OTVATOCN10_1 | 15       | 11/14/2022     | HD 1080i 25fps | OTVATOT10_1 |
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom_2 | Brand Custom_2 | Sub Brand Custom_2 | Product Custom_2 |
| OTVATOAR10_1        | OTVATOBR10_1   | OTVATOSB10_1       | OTVATOPR10_1     |
And save as draft order
And open order item with following clock number 'OTVATOCN10_1'
Then I should see following data for order item on Add information form:
| Additional Information | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       |
| automated test info 1  | OTVATOC10_1 | OTVATOCN10_1 | 15       | 11/14/2022     | HD 1080i 25fps | OTVATOT10_1 |
And should see following custom advertiser hierarchy fields data for order item on Add information form:
| Advertiser Custom_2 | Brand Custom_2 | Sub Brand Custom_2 | Product Custom_2 |
| OTVATOAR10_1        | OTVATOBR10_1   | OTVATOSB10_1       | OTVATOPR10_1     |

Scenario: Order in read-only state for all agency admin in BU
Meta: @ordering
@skip
!--NGN-19063 has been closed with following commentAssign Order workflow is not compatible with new ACL and is not supportable in its current implementation. It needs to be completely reimplemented. It does not make sense to invest time in fixing this particular bug.
Given I created the following agency:
| Name        | A4User        |
| OTVATOA1_1  | DefaultA4User |
| OTVATOA1_2  | DefaultA4User |
And added agency 'OTVATOA1_2' as a partner to agency 'OTVATOA1_1'
And created users with following fields:
| Email            | Role         | AgencyUnique |
| OTVATOU1_1_email | agency.admin | OTVATOA1_1   |
| OTVATOU1_2_email | agency.admin | OTVATOA1_2   |
| OTVATOU11_3      | agency.admin | OTVATOA1_1   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVATOA1_1':
| Advertiser | Brand     | Sub Brand | Product   |
| OTVATOAR1  | OTVATOBR1 | OTVATOSB1 | OTVATOPR1 |
And logged in with details of 'OTVATOU1_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Destination                 |
| automated test info    | OTVATOAR1  | OTVATOBR1 | OTVATOSB1 | OTVATOPR1 | OTVATOC11 | OTVATOCN11   | 20       | 10/14/2022     | HD 1080i 25fps | OTVATOT11 | BSkyB Green Button:Standard |
And transfered order contains item with clock number 'OTVATOCN11' to user 'OTVATOU1_2_email' with following message 'autotest transfer message'
And logged in with details of 'OTVATOU11_3'
When I open order item with following clock number 'OTVATOCN11'
Then I 'should not' see On Hold button on order item page
And 'should not' see Add Commercial button on order item page
And should see 'disabled' New master button for order item on Add media form
And should see 'disabled' Retrieve from Library button for order item at Add media to your order form
And should see 'disabled' Retrieve from Project button for order item at Add media to your order form
And 'should not' see able to edit following fields 'Clock Number,Advertiser,Brand,Sub Brand,Product,Campaign,Title,Duration,First Air Date,Format,Subtitles Required,Additional Information' for order item on Add information form
And should see 'active' Select Broadcast Destinations section on order item page
And should see 'inactive' QC & Ingest Only button on order item page
And should see 'disabled' following fields 'Type,Destination,Format,Specification,Media Compile,No copies,Delivery Details,Notes & Labels,Standard,Express' for order item on Additional Services section
And 'should not' see Proceed button on order item page

Scenario: check Add Information section for creator
Meta: @ordering
Given I created the following agency:
| Name        | A4User        |
| OTVATOA12_1 | DefaultA4User |
| OTVATOA12_2 | DefaultA4User |
And added agency 'OTVATOA12_2' as a partner to agency 'OTVATOA12_1'
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVATOU12_1 | agency.admin | OTVATOA12_1  |
| OTVATOU12_2 | agency.admin | OTVATOA12_2  |
And created following 'common' custom metadata fields for agency 'OTVATOA12_1':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Sub Brand Custom  | Brand Custom      | true     | true                |
| CatalogueStructure | Product Custom    | Sub Brand Custom  | true     | true                |
And updated agency 'OTVATOA12_1' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product |
| Advertiser Custom  | Brand Custom    |
And logged in with details of 'OTVATOU12_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     |
| automated test info    | OTVATOC12 | OTVATOCN12   | 20       | 10/14/2022     | HD 1080i 25fps | OTVATOT12 |
When I open order item with following clock number 'OTVATOCN12'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Sub Brand Custom | Product Custom |
| OTVATOAR12        | OTVATOBR12   | OTVATOSB12       | OTVATOPR12     |
And save as draft order
And transfer order contains item with clock number 'OTVATOCN12' to user 'OTVATOU12_2' with following message 'autotest transfer message'
And open order item with following clock number 'OTVATOCN12'
Then I should see following read-only 'common' data for order item on Add information form:
| Additional Information | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     |
| automated test info    | OTVATOC12 | OTVATOCN12   | 20       | 10/14/2022     | HD 1080i 25fps | OTVATOT12 |
And should see following read-only 'custom' data for order item on Add information form:
| Advertiser Custom | Brand Custom | Sub Brand Custom | Product Custom |
| OTVATOAR12        | OTVATOBR12   | OTVATOSB12       | OTVATOPR12     |

Scenario: check order in list after confirm (for case new CM catalogs)
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVATOA13 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVATOU13 | agency.admin | OTVATOA13    |
And created following 'common' custom metadata fields for agency 'OTVATOA13':
| FieldType          | Description       | Parent            | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom |                   | true     | true                |
| CatalogueStructure | Brand Custom      | Advertiser Custom | true     | true                |
| CatalogueStructure | Sub Brand Custom  | Brand Custom      | true     | true                |
| CatalogueStructure | Product Custom    | Sub Brand Custom  | true     | true                |
And updated agency 'OTVATOA13' by following marked as fields of schema 'common':
| Mark as Advertiser | Mark as Product |
| Advertiser Custom  | Product Custom  |
And logged in with details of 'OTVATOU13'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVATOC13 | OTVATOCN13   | 20       | 10/14/2022     | HD 1080i 25fps | OTVATOT13 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'OTVATOCN13'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom | Brand Custom | Sub Brand Custom | Product Custom |
| OTVATOAR13        | OTVATOBR13   | OTVATOSB13       | OTVATOPR13     |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number  |
| OTVATOJN13 | OTVATOPN13 |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number 'OTVATOCN13' and following fields:
| Order# | DateTime    | Advertiser | Brand      | Sub Brand  | Product    | Market         | PO Number  | Job #      | NoClocks | Status        |
| Digit  | CurrentTime | OTVATOAR13 | OTVATOBR13 | OTVATOSB13 | OTVATOPR13 | United Kingdom | OTVATOPN13 | OTVATOJN13 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains clock number 'OTVATOCN13' and items with following fields:
| Clock Number | Advertiser | Product    | Title     | First Air Date | Format         | Duration | Status        |
| OTVATOCN13   | OTVATOAR13 | OTVATOPR13 | OTVATOT13 | 10/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |

Scenario: check assigned order in list after edit Add Information section
Meta: @ordering
Given I created the following agency:
| Name        | A4User        |
| OTVATOA14_1 | DefaultA4User |
| OTVATOA14_2 | DefaultA4User |
And added agency 'OTVATOA14_2' as a partner to agency 'OTVATOA14_1'
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVATOU14_1 | agency.admin | OTVATOA14_1  |
| OTVATOU14_2 | agency.admin | OTVATOA14_2  |
And created following 'common' custom metadata fields for agency 'OTVATOA14_1':
| FieldType          | Description         | Parent              | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom_1 |                     | true     | true                |
| CatalogueStructure | Brand Custom_1      | Advertiser Custom_1 | true     | true                |
| CatalogueStructure | Sub Brand Custom_1  | Brand Custom_1      | true     | true                |
| CatalogueStructure | Product Custom_1    | Sub Brand Custom_1  | true     | true                |
And created following 'common' custom metadata fields for agency 'OTVATOA14_2':
| FieldType          | Description         | Parent              | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom_2 |                     | true     | true                |
| CatalogueStructure | Brand Custom_2      | Advertiser Custom_2 | true     | true                |
| CatalogueStructure | Sub Brand Custom_2  | Brand Custom_2      | true     | true                |
| CatalogueStructure | Product Custom_2    | Sub Brand Custom_2  | true     | true                |
And updated agency 'OTVATOA14_1' by following marked as fields of schema 'common':
| Mark as Advertiser  | Mark as Product |
| Advertiser Custom_1 | Brand Custom_1  |
And updated agency 'OTVATOA14_2' by following marked as fields of schema 'common':
| Mark as Advertiser  | Mark as Product |
| Advertiser Custom_2 | Brand Custom_2  |
And logged in with details of 'OTVATOU14_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       |
| automated test info 2  | OTVATOC14_2 | OTVATOCN14_2 | 20       | 10/14/2022     | HD 1080i 25fps | OTVATOT14_2 |
When I open order item with following clock number 'OTVATOCN14_2'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom_2 | Brand Custom_2 | Sub Brand Custom_2 | Product Custom_2 |
| OTVATOAR14_2        | OTVATOBR14_2   | OTVATOSB14_2       | OTVATOPR14_2     |
And save as draft order
And transfer order contains item with clock number 'OTVATOCN14_2' to user 'OTVATOU14_1' with following message 'autotest transfer message'
And login with details of 'OTVATOU14_1'
And open order item with following clock number 'OTVATOCN14_2'
And fill following fields for Add information form on order item page:
| Additional Information | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       |
| automated test info 1  | OTVATOC14_1 | OTVATOCN14_1 | 15       | 11/14/2022     | HD 1080i 25fps | OTVATOT14_1 |
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom_2 | Brand Custom_2 | Sub Brand Custom_2 | Product Custom_2 |
| OTVATOAR14_1        | OTVATOBR14_1   | OTVATOSB14_1       | OTVATOPR14_1     |
And save as draft order
And refresh the page without delay
Then I should see TV order in 'draft' order list with item clock number 'OTVATOCN14_1' and following fields:
| Order# | DateTime    | Advertiser   | Brand        | Sub Brand | Product | Market         | NoClocks | Creator     | Owner       |
| Digit  | CurrentTime | OTVATOAR14_1 | OTVATOBR14_1 |           |         | United Kingdom | 1        | OTVATOU14_2 | OTVATOU14_1 |
And should see 'draft' order in 'tv' order list contains clock number 'OTVATOCN14_1' and items with following fields:
| Clock Number | Advertiser   | Product      | Title       | First Air Date | Format         | Duration |
| OTVATOCN14_1 | OTVATOAR14_1 | OTVATOBR14_1 | OTVATOT14_1 | 11/14/2022     | HD 1080i 25fps | 15       |

Scenario: check assigned order on View Media Details page after edit Add Information section
Meta: @ordering
Given I created the following agency:
| Name        | A4User        |
| OTVATOA15_1 | DefaultA4User |
| OTVATOA15_2 | DefaultA4User |
And added agency 'OTVATOA15_2' as a partner to agency 'OTVATOA15_1'
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVATOU15_1 | agency.admin | OTVATOA15_1  |
| OTVATOU15_2 | agency.admin | OTVATOA15_2  |
And created following 'common' custom metadata fields for agency 'OTVATOA15_1':
| FieldType          | Description         | Parent              | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom_1 |                     | true     | true                |
| CatalogueStructure | Brand Custom_1      | Advertiser Custom_1 | true     | true                |
| CatalogueStructure | Sub Brand Custom_1  | Brand Custom_1      | true     | true                |
| CatalogueStructure | Product Custom_1    | Sub Brand Custom_1  | true     | true                |
And created following 'common' custom metadata fields for agency 'OTVATOA15_2':
| FieldType          | Description         | Parent              | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom_2 |                     | true     | true                |
| CatalogueStructure | Brand Custom_2      | Advertiser Custom_2 | true     | true                |
| CatalogueStructure | Sub Brand Custom_2  | Brand Custom_2      | true     | true                |
| CatalogueStructure | Product Custom_2    | Sub Brand Custom_2  | true     | true                |
And updated agency 'OTVATOA15_1' by following marked as fields of schema 'common':
| Mark as Advertiser  | Mark as Product |
| Advertiser Custom_1 | Brand Custom_1  |
And updated agency 'OTVATOA15_2' by following marked as fields of schema 'common':
| Mark as Advertiser  | Mark as Product |
| Advertiser Custom_2 | Brand Custom_2  |
And logged in with details of 'OTVATOU15_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                 |
| automated test info 2  | OTVATOC15_2 | OTVATOCN15_2 | 20       | 10/14/2022     | HD 1080i 25fps | OTVATOT15_2 | Already Supplied   | Aastha:Standard |
When I open order item with following clock number 'OTVATOCN15_2'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom_2 | Brand Custom_2 | Sub Brand Custom_2 | Product Custom_2 |
| OTVATOAR15_2        | OTVATOBR15_2   | OTVATOSB15_2       | OTVATOPR15_2     |
And save as draft order
And transfer order contains item with clock number 'OTVATOCN15_2' to user 'OTVATOU15_1' with following message 'autotest transfer message'
And login with details of 'OTVATOU15_1'
And open order item with following clock number 'OTVATOCN15_2'
And fill following fields for Add information form on order item page:
| Additional Information | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       |
| automated test info 1  | OTVATOC15_1 | OTVATOCN15_1 | 15       | 11/14/2022     | HD 1080i 25fps | OTVATOT15_1 |
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom_2 | Brand Custom_2 | Sub Brand Custom_2 | Product Custom_2 |
| OTVATOAR15_1        | OTVATOBR15_1   | OTVATOSB15_1       | OTVATOPR15_1     |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number  |
| OTVATOJN15 | OTVATOPN15 |
And confirm order on Order Proceed page
And go to View Media Details page for order contains item with following clock number 'OTVATOCN15_1'
Then I should see following media information on View Media Details page:
| Clock Number | Advertiser   | Brand        | Sub Brand | Product | Title       | Duration | First Air Date | Additional Details    | Video Format                                | Aspect Ratio | Video Standard |
| OTVATOCN15_1 | OTVATOAR15_1 | OTVATOBR15_1 |           |         | OTVATOT15_1 | 15       | 11/14/2022     | automated test info 1 | Broadcast SD PAL 16x9 Program Stream master | 16x9         | 720x576i@25fps |
And should see destination delivered for order contains item with clock number 'OTVATOCN15_1' with following fields:
| Order # | Destination        | Date Ordered  | Ordered by  | Status       |
| Digit   | Aastha             | DateSubmitted | OTVATOU15_1 | Order Placed |

Scenario: check advertiser hierarhy for creator after back to order list (for case new different CM catalogs)
Meta: @ordering
Given I created the following agency:
| Name        | A4User        |
| OTVATOA16_1 | DefaultA4User |
| OTVATOA16_2 | DefaultA4User |
And added agency 'OTVATOA16_2' as a partner to agency 'OTVATOA16_1'
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVATOU16_1 | agency.admin | OTVATOA16_1  |
| OTVATOU16_2 | agency.admin | OTVATOA16_2  |
And created following 'common' custom metadata fields for agency 'OTVATOA16_1':
| FieldType          | Description         | Parent              | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom_1 |                     | true     | true                |
| CatalogueStructure | Brand Custom_1      | Advertiser Custom_1 | true     | true                |
| CatalogueStructure | Sub Brand Custom_1  | Brand Custom_1      | true     | true                |
| CatalogueStructure | Product Custom_1    | Sub Brand Custom_1  | true     | true                |
And created following 'common' custom metadata fields for agency 'OTVATOA16_2':
| FieldType          | Description         | Parent              | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom_2 |                     | true     | true                |
| CatalogueStructure | Brand Custom_2      | Advertiser Custom_2 | true     | true                |
| CatalogueStructure | Sub Brand Custom_2  | Brand Custom_2      | true     | true                |
| CatalogueStructure | Product Custom_2    | Sub Brand Custom_2  | true     | true                |
And updated agency 'OTVATOA16_1' by following marked as fields of schema 'common':
| Mark as Advertiser  | Mark as Product |
| Advertiser Custom_1 | Brand Custom_1  |
And updated agency 'OTVATOA16_2' by following marked as fields of schema 'common':
| Mark as Advertiser  | Mark as Product |
| Advertiser Custom_2 | Brand Custom_2  |
And logged in with details of 'OTVATOU16_2'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     |
| automated test info    | OTVATOC16 | OTVATOCN16   | 20       | 10/14/2022     | HD 1080i 25fps | OTVATOT16 |
When I open order item with following clock number 'OTVATOCN16'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom_2 | Brand Custom_2 | Sub Brand Custom_2 | Product Custom_2 |
| OTVATOAR16          | OTVATOBR16     | OTVATOSB16         | OTVATOPR16       |
And save as draft order
And transfer order contains item with clock number 'OTVATOCN16' to user 'OTVATOU16_1' with following message 'autotest transfer message'
And open order item with following clock number 'OTVATOCN16'
And back to ordering page from order item page
Then I should see TV order in 'draft' order list with item clock number 'OTVATOCN16' and following fields:
| Order# | DateTime    | Advertiser | Brand      | Sub Brand  | Product    | Market         | NoClocks | Creator     | Owner       |
| Digit  | CurrentTime | OTVATOAR16 | OTVATOBR16 | OTVATOSB16 | OTVATOPR16 | United Kingdom | 1        | OTVATOU16_2 | OTVATOU16_1 |
And should see 'draft' order in 'tv' order list contains clock number 'OTVATOCN16' and items with following fields:
| Clock Number | Advertiser | Product    | Title     | First Air Date | Format         | Duration |
| OTVATOCN16   | OTVATOAR16 | OTVATOBR16 | OTVATOT16 | 10/14/2022     | HD 1080i 25fps | 20       |

Scenario: check advertiser hierarhy under assignee for music order
Meta: @ordering
Given I created the following agency:
| Name        | A4User        |
| OTVATOA17_1 | DefaultA4User |
| OTVATOA17_2 | DefaultA4User |
And added agency 'OTVATOA17_2' as a partner to agency 'OTVATOA17_1'
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVATOU17_1 | agency.admin | OTVATOA17_1  |
| OTVATOU17_2 | agency.admin | OTVATOA17_2  |
And created following 'common' custom metadata fields for agency 'OTVATOA17_1':
| FieldType          | Description         | Parent              | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom_1 |                     | true     | true                |
| CatalogueStructure | Brand Custom_1      | Advertiser Custom_1 | true     | true                |
| CatalogueStructure | Sub Brand Custom_1  | Brand Custom_1      | true     | true                |
| CatalogueStructure | Product Custom_1    | Sub Brand Custom_1  | true     | true                |
And created following 'common' custom metadata fields for agency 'OTVATOA17_2':
| FieldType          | Description         | Parent              | AddOnFly | AvailableInDelivery |
| CatalogueStructure | Advertiser Custom_2 |                     | true     | true                |
| CatalogueStructure | Brand Custom_2      | Advertiser Custom_2 | true     | true                |
| CatalogueStructure | Sub Brand Custom_2  | Brand Custom_2      | true     | true                |
| CatalogueStructure | Product Custom_2    | Sub Brand Custom_2  | true     | true                |
And updated agency 'OTVATOA17_1' by following marked as fields of schema 'common':
| Mark as Advertiser  | Mark as Product |
| Advertiser Custom_1 | Brand Custom_1  |
And updated agency 'OTVATOA17_2' by following marked as fields of schema 'common':
| Mark as Advertiser  | Mark as Product |
| Advertiser Custom_2 | Brand Custom_2  |
And logged in with details of 'OTVATOU17_2'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Campaign    | ISRC Code    | Title       | Release Date | Format         |
| automated test info    | OTVATOC17_2 | OTVATOCN17_2 | OTVATOT17_2 | 10/14/2022   | HD 1080i 25fps |
When I open order item with following isrc code 'OTVATOCN17_2'
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom_2 | Brand Custom_2 | Sub Brand Custom_2 | Product Custom_2 |
| OTVATOAR17_2        | OTVATOBR17_2   | OTVATOSB17_2       | OTVATOPR17_2     |
And save as draft order
And transfer order contains item with isrc code 'OTVATOCN17_2' to user 'OTVATOU17_1' with following message 'autotest transfer message'
And login with details of 'OTVATOU17_1'
And open order item with following isrc code 'OTVATOCN17_2'
And fill following fields for Add information form on order item page:
| Additional Information | Campaign    | ISRC Code    | Title       | Release Date | Format         |
| automated test info    | OTVATOC17_1 | OTVATOCN17_1 | OTVATOT17_1 | 11/14/2022   | HD 1080i 25fps |
And fill following custom advertiser hierarchy fields for Add information form on order item page:
| Advertiser Custom_2 | Brand Custom_2 | Sub Brand Custom_2 | Product Custom_2 |
| OTVATOAR17_1        | OTVATOBR17_1   | OTVATOSB17_1       | OTVATOPR17_1     |
And save as draft order
And refresh the page without delay
Then I should see Music order in 'draft' order list with item isrc code 'OTVATOCN17_1' and following fields:
| Order# | DateTime    | Advertiser   | Brand        | Sub Brand | Product | Market         | NoClocks | Creator     | Owner       |
| Digit  | CurrentTime | OTVATOAR17_1 | OTVATOBR17_1 |           |         | United Kingdom | 1        | OTVATOU17_2 | OTVATOU17_1 |
And should see 'draft' order in 'music' order list contains isrc code 'OTVATOCN17_1' and items with following fields:
| ISRC Code    | Advertiser   | Product      | Campaign    | Title       | Release Date | Format         |
| OTVATOCN17_1 | OTVATOAR17_1 | OTVATOBR17_1 | OTVATOC17_1 | OTVATOT17_1 | 11/14/2022   | HD 1080i 25fps |

Scenario: check proceeding transferred order which has custom drop down field
!--ORD-4577
Meta: @ordering
Given I am logged in as 'GlobalAdmin'
And created the following agency:
| Name        | A4User        |
| OTVATOA18_1 | DefaultA4User |
| OTVATOA18_2 | DefaultA4User |
And added agency 'OTVATOA18_2' as a partner to agency 'OTVATOA18_1'
And created users with following fields:
| Email       | Role         | AgencyUnique |
| OTVATOU18_1 | agency.admin | OTVATOA18_1  |
| OTVATOU18_2 | agency.admin | OTVATOA18_2  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVATOA18_1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVATOAR18 | OTVATOBR18 | OTVATOSB18 | OTVATOPR18 |
And I am on the global 'video asset' metadata page for agency 'OTVATOA18_1'
And refreshed the page without delay
And created 'Dropdown' custom metadata field with following information on opened metadata page:
| Description      | Delivery | Compulsory | Descendants |
| custom-dropdown1 | should   | should     | drop1,drop2 |
And logged in with details of 'OTVATOU18_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVATOAR18 | OTVATOBR18 | OTVATOSB18 | OTVATOPR18 | OTVATOC18 | OTVATOCN18   | 20       | 10/14/2022     | HD 1080i 25fps | OTVATOT18 | Already Supplied   | Aastha:Standard |
When open order item with following clock number 'OTVATOCN18'
And fill following fields for Additional information section on order item page:
| custom-dropdown1 |
| drop1            |
And save as draft order
And transfer order contains item with clock number 'OTVATOCN18' to user 'OTVATOU18_2' with following message 'autotest transfer message'
And login with details of 'OTVATOU18_2'
And open order item with following clock number 'OTVATOCN18'
And click Proceed button on order item page
Then I 'should' see Order Proceed page