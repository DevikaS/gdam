Feature:    Traffic Edit Order
Narrative:
In order to
As a              AgencyAdmin
I want to check edit order feature

Scenario:Check the order created using Master is editable by TTM
Meta:@traffic
!--QA-563
Given I created the following agency:
| Name     | A4User        |
| TEOA5 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| TEOU1_email | agency.admin | TEOA5     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TEOA5':
| Advertiser | Brand   | Sub Brand | Product |
| TEOAR1    | TEOBR1 | TEOSB1   | TEOPR1 |
When login with details of 'TEOU1_email'
And created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | TEOAR1    | TEOBR1 | TEOSB1      | TEOPR1 | TEOC1   | TEOCN_3      | 20       | 10/14/2022     | HD 1080i 25fps | TEOT1 | Already Supplied   | AOL:Standard |
And I open order item with following clock number 'TEOCN_3'
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee | Already Supplied | Message        | Deadline Date |
| TEOU1_email | should not       | automated test | 12/14/2022    |
And added usage right 'General' for order contains item with clock number 'TEOCN_3' with following fields:
| Start Date | Expire Date |
| 02/02/2022 | 02/02/2024  |
And created additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City     | Post Code | Country  |
| Physical | TEODN4        | TEOCnN4   | TEOCD4      | TEOSA4     | TEOC4 | TEOPC4 | TEOC4 |
And created for 'tv' order with item clock number 'TEOCN_3' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                     | Notes & Labels        | Express |
| Data DVD | TEODN4   | Avid DNxHD | HD 1080i 25fps | Compile 2        | 2          | TEODN4 TEOCnN4 TEOCD4 TEOSA4 TEOC4 TEOPC4 TEOC4 | automated test notes  | should  |
And completed order contains item with clock number 'TEOCN_3' with following fields:
| Job Number | PO Number |
| TEOJN4     | TEOPN4 |
When login with details of 'trafficManager'
And wait till order with clockNumber 'TEOCN_3' will be available in Traffic
And wait till order with clockNumber 'TEOCN_3' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TEOCN_3' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TEOCN_3' in Traffic
And click master arrived button on Traffic Order Edit page
And fill the following fields on master arrived traffic pop up:
| Tape number  | Comments        |
| 545          | Automation Test |
And edit order in traffic with the following fields:
| FieldName          | FieldValue    |
| Title              | ChangedName   |
| Advertiser         | TEOAR4        |
| Brand              | TEOBR4        |
| Sub Brand          | TEOSB4        |
| Product            | TEOP4         |
| Duration           | 22s           |
| First Air Date     |  12/16/2021   |
And fill following fields for usage right 'Countries' on order item page:
| Country        | Start Date | Expire Date |
| United Kingdom | 02/02/2022 | 02/02/2024  |
And save usage information for 'Countries' usage right on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard     |
|Talk Sport    |
And fill following fields for Additional Services section on order item page:
| No copies | Notes & Labels |
| 1        | Edited notes |
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait for '8' seconds
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TEOCN_3' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I 'should' see that OrderItem status was updated to value 'Media Received - Awaiting Ingestion' for order with ClockNumber 'TEOCN_3'
And I should see order item with clockNumber 'TEOCN_3' in traffic order list that have following data:
| Advertiser |Product|  Title       | Duration | First Air Date | Subtitles Required   |Tape number | Master Received Comment  |
| TEOAR4     | TEOP4 | ChangedName  | 22s      | 12/16/2021     | None                 | 545         | Automation Test         |
And I 'should' see destinations 'AOL,Talk Sport' for order item in Traffic List with clockNumber 'TEOCN_3'
And refresh the page
And enter search criteria 'TEOCN_3' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
And I 'should' see additional service 'TEODN4' for order item in Traffic List with clockNumber 'TEOCN_3'
And open edit page for order with Clock Number 'TEOCN_3' in Traffic
And should see following fields for usage right 'Countries' on order item page:
| Country        | Start Date | Expire Date |
| United Kingdom | 02/02/2022 | 02/02/2024  |


Scenario: check that auto code validation happens for clock number when metadata elements are edited during order creation and edited by traffic manager
Meta: @traffic
Given I created the following agency:
| Name   | A4User        |
| TEOA6 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| TEOU6| agency.admin | TEOA6       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TEOA6':
| Advertiser | Brand   | Sub Brand | Product |
| ADVERT8       | BRAND8     | SUBBRAND8   | PRODUCT8 |
| ADVERT7       | BRAND7     | SUBBRAND7   | PRODUCT7 |
And update custom code 'Clock number' of schema 'video' agency 'TEOA6' by following fields:
| Name    | Metadata Elements                        | Enabled |Sequential Number|
| TEOCUSCODE6 | Advertiser:3,Brand:2,Sub Brand:2,Title:3 | should  |4|
And logged in with details of 'TEOU6'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |Motivnummer|
| automated test info    | ADVERT8    | BRAND8 | SUBBRAND8   | PRODUCT8 | TEOC6 | 20       | 10/14/2022     | HD 1080i 25fps | TEOT6 | Already Supplied   | Travel Channel DE:Express |1|
When I open order item with next title 'TEOT6'
And generate 'auto code' value for Add information form on order item page
And edit following fields for Add information form on order item page:
| Advertiser | Brand      | Sub Brand  | Title     |Product|
| ADVERT7 | BRAND7 | SUBBRAND7 | EditTitle |PRODUCT7|
Then I 'should' see an error 'Please generate a new code' on order item page
When I fill following fields for Add information form on order item page:
| Clock Number|Duration|
| TEOCN6 |20|
And click Proceed button on order item page
And confirm order on Order Proceed page
And waited for finish place order with following item clock number 'TEOCN6' to A4
And login with details of 'trafficManager'
And I select 'All' tab in Traffic UI
And wait till order list will be loaded
And wait till order with clockNumber 'TEOCN6' will be available in Traffic
And wait till order with clockNumber 'TEOCN6' will have next status 'In Progress' in Traffic
And enter search criteria 'TEOCN6' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TEOCN6' in Traffic
And edit order in traffic with the following fields:
| FieldName          | FieldValue    |
| Title              | TrafficEdit   |
| Advertiser         | ADVERT6        |
| Brand              | BRAND6        |
| Sub Brand          | SUBBRAND6        |
| Product            | PRODUCT6         |
Then I 'should' see an error 'Please generate a new code' on order item page


Scenario: check that auto code validation happens on order creation page when navigating to different page after edit then back to order creation
Meta: @traffic
      @tbug
!--This scenario will fail due to bug NIR-980
Given I created the following agency:
| Name   | A4User        |
| TEOA7 | DefaultA4User |
And created users with following fields:
| Email  | Role         | AgencyUnique |
| TEOU7| agency.admin | TEOA7       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TEOA7':
| Advertiser | Brand   | Sub Brand | Product |
| ADVERT8      | BRAND8    | SUBBRAND8   | PRODUCT8 |
| ADVERT9       | BRAND9     | SUBBRAND9   | PRODUCT9 |
And update custom code 'Clock number' of schema 'video' agency 'TEOA7' by following fields:
| Name    | Metadata Elements                        | Enabled |Sequential Number|
| TEOCUSCODE7 | Advertiser:3,Brand:2,Sub Brand:2,Title:3 | should  |3|
And logged in with details of 'TEOU7'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |Motivnummer|
| automated test info    | ADVERT8    | BRAND8 | SUBBRAND8   | PRODUCT8 | TEOC7 | 20       | 10/14/2022     | HD 1080i 25fps | TEOT7 | Already Supplied   | Travel Channel DE:Express |1|
When I open order item with next title 'TEOT7'
And generate 'auto code' value for Add information form on order item page
And edit following fields for Add information form on order item page:
Title|Duration|
|EditTitle|10|
Then I 'should' see an error 'Please generate a new code' on order item page
When I edit following fields for Add information form on order item page:
|Title|
|SecondEdit|
And go to View Draft Orders tab of 'tv' order on ordering page
And I open order item with next title 'SecondEdit'
And click Proceed button on order item page
Then I 'should' see an error 'Please generate a new code' on order item page

Scenario: Check that Traffic manager can update Job and PO number for completed order
Meta:@traffic
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser   | Brand        | Sub Brand    | Product     |
| TMUJPONJNAD1 | TMUJPONJNBR1 | TMUJPONJNSB1 | TMUJPONJNP1 |
And logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser       | Brand        | Sub Brand       | Product      | Campaign  | Clock Number  | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination          | Motivnummer |
| automated test info    | TMUJPONJNAD1     | TMUJPONJNBR1 | TMUJPONJNSB1    | TMUJPONJNP1  | TTVBTVSC1 | TMUJNPON      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Facebook DE:Standard | 1           |
And complete order contains item with clock number 'TMUJNPON' with following fields:
| Job Number | PO Number |
| TMCOJO2    | TMCOPO2   |
And wait for finish place order with following item clock number 'TMUJNPON' to A4
And ingested assests through A5 with following fields:
| agencyName    | clockNumber  |
| DefaultAgency | TMUJNPON     |
And logged in with details of 'trafficManager'
And I selected 'All' tab in Traffic UI
And waited till order with clockNumber 'TMUJNPON' will be available in Traffic
And waited till order item with clockNumber 'TMUJNPON' will have next status for 'TVC Ingested OK' in Traffic
And waited till order with clockNumber 'TMUJNPON' will have next status 'Completed' in Traffic
And entered search criteria 'TMUJNPON' in simple search form on Traffic Order List page
And waited for '2' seconds
When open order details with clockNumber 'TMUJNPON' from Traffic UI
And edit and 'save' Job Number with 'TMUJOBNUM' on traffic order details page for clock 'TMUJNPON'
Then I 'should' see success message as 'item updated successfully' displayed on order details page is Traffic
When edit and 'save' PO Number with 'TMUPONUM' on traffic order details page for clock 'TMUJNPON'
Then I 'should' see success message as 'item updated successfully' displayed on order details page is Traffic
When I open Traffic Order List page
And I select 'All' tab in Traffic UI
Then I 'should' see below information on traffic order page for clock 'TMUJNPON':
|PO Number     | Job Number  |
| TMUPONUM     | TMUJOBNUM   |
When I login with details of 'AgencyAdmin'
And I go to Order Summary page for order contains item with following clock number 'TMUJNPON'
Then I should see the following information for clock number 'TMUJNPON' on order summary page:
| Job Number  | PO Number     |
| TMUJOBNUM   | TMUPONUM      |