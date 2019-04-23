!--ORD-1898
!--ORD-1948
Feature: Ability to create order with Additonal services but without broadcast destinations or QC Ingest only
Narrative:
In order to:
As a AgencyAdmin
I want to check create order with Additonal services but without broadcast destinations or QC Ingest only

Scenario: Check order should not be proceeded when destinations or QC & Ingest Only button is not selected
Meta: @qaorderingsmoke
      @uatorderingsmoke
!--NGN-19470
Given I created the following agency:
| Name      | A4User        |
| OTVMASCA_Q1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASCU_Q1 | agency.user  | OTVMASCA_Q1    |
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASCA_Q1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVMASCAR_1 | OTVMASCBR_1 | OTVMASCSB_1 | OTVMASCPR_1 |
And on the global 'common custom' metadata page for agency 'OTVMASCA_Q1'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And logged in with details of 'OTVMASCU_Q1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product  | Campaign    | Clock Number   | Duration | First Air Date | Format         | Title       | Subtitles Required |
| automated test info    | OTVMASCAR_1 | OTVMASCBR_1 | OTVMASCSB_1 | OTVMASCPR_1 | OTVMASCC_Q1 | OTVMASCCN_Q1   | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASCT_Q1 | Already Supplied   |
And create additional destinations with following fields:
| Type     | Destination Name  | Contact Name   | Contact Details  | Street Address  | City         | Post Code     | Country     |  Market        |
| Physical | OTVMASCDN1_Q1     | OTVMASCCnN1_Q1 | OTVMASCCD1_Q1    | OTVMASCSA1_Q1   | OTVMASCC1_Q1 | OTVMASCPC1_Q1 | OTVMASCC1_Q1 | United Kingdom |
| Physical | OTVMASCDN1_Q2     | OTVMASCCnN1_Q2 | OTVMASCCD1_Q2    | OTVMASCSA1_Q2   | OTVMASCC1_Q2 | OTVMASCPC1_Q2 | OTVMASCC1_Q2 | United Kingdom |
When I open order item with following clock number 'OTVMASCCN_Q1'
And wait for '5' seconds
And fill following fields for Additional Services section on order item page with delay:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies | Notes & Labels         | Standard   | Express    |
| Data DVD | OTVMASCDN1_Q1 | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2         | automated test notes 1 | should     | should not |
| DVD      | OTVMASCDN1_Q2 | Auto-loop  | SD PAL 16x9    | Compile 1     | 1         | automated test notes 2 | should not | should     |
Then I 'should' see warning message 'Please add destinations or select QC&Ingest Only' on order item page on click proceed

Scenario: Check confirming order with Additional Services items
Meta: @qaorderingsmoke
      @uatorderingsmoke
      @orderingcrossbrowser
!--NGN-19470 --- Added QC & Ingest step below in addition
Given I created the following agency:
| Name      | A4User        |
| OTVMASCA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASCU1 | agency.user  | OTVMASCA1    |
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASCA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 |
And on the global 'common custom' metadata page for agency 'OTVMASCA1'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And logged in with details of 'OTVMASCU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required |
| automated test info    | OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 | OTVMASCC1 | OTVMASCCN1   | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASCT1 | Already Supplied   |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name  | Contact Details | Street Address | City        | Post Code    | Country     |  Market        |
| Physical | OTVMASCDN1_1     | OTVMASCCnN1_1 | OTVMASCCD1_1    | OTVMASCSA1_1   | OTVMASCC1_1 | OTVMASCPC1_1 | OTVMASCC1_1 | United Kingdom |
| Physical | OTVMASCDN1_2     | OTVMASCCnN1_2 | OTVMASCCD1_2    | OTVMASCSA1_2   | OTVMASCC1_2 | OTVMASCPC1_2 | OTVMASCC1_2 | United Kingdom |
When I open order item with following clock number 'OTVMASCCN1'
And wait for '5' seconds
And I do QC & Ingest Only for active order item at Select Broadcast Destinations
And fill following fields for Additional Services section on order item page:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies | Notes & Labels         | Standard   | Express    |
| Data DVD | OTVMASCDN1_1 | Avid DNxHD | HD 1080i 25fps | Compile 2     | 2         | automated test notes 1 | should     | should not |
| DVD      | OTVMASCDN1_2 | Auto-loop  | SD PAL 16x9    | Compile 1     | 1         | automated test notes 2 | should not | should     |
And click active Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number  |
| OTVMASCJN1 | OTVMASCPN1 |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number 'OTVMASCCN1' and following fields:
| Order# | DateTime    | Advertiser | Brand      | Sub Brand  | Product    | Market         | PO Number  | Job #      | NoClocks | Status        |
| Digit# | CurrentTime | OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 | United Kingdom | OTVMASCPN1 | OTVMASCJN1 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains clock number 'OTVMASCCN1' and items with following fields:
| Clock Number | Advertiser | Product    | Title     | First Air Date | Format         | Duration | Status        |
| OTVMASCCN1   | OTVMASCAR1 | OTVMASCPR1 | OTVMASCT1 | 08/14/2022     | HD 1080i 25fps | 20       | 0/2 Delivered |

Scenario: Check hold state for Additional Services items on order summary page
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASCA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASCU1 | agency.admin | OTVMASCA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASCA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 |
And logged in with details of 'OTVMASCU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required |
| automated test info    | OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 | OTVMASCC2 | OTVMASCCN2   | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASCT2 | Already Supplied   |
And hold for approval 'tv' order items with following clock numbers 'OTVMASCCN2'
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name  | Contact Details | Street Address | City        | Post Code    | Country     |     Market     |
| Physical | OTVMASCDN2_1     | OTVMASCCnN2_1 | OTVMASCCD2_1    | OTVMASCSA2_1   | OTVMASCC2_1 | OTVMASCPC2_1 | OTVMASCC2_1 | United Kingdom |
| Physical | OTVMASCDN2_2     | OTVMASCCnN2_2 | OTVMASCCD2_2    | OTVMASCSA2_2   | OTVMASCC2_2 | OTVMASCPC2_2 | OTVMASCC2_2 | United Kingdom |
And create for 'tv' order with item clock number 'OTVMASCCN2' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                          | Notes & Labels        | Standard   | Express    |
| Data DVD | OTVMASCDN2_1 | Avid DNxHD | Same as Master | Compile 1     | 1          | OTVMASCDN2_1 OTVMASCCnN2_1 OTVMASCCD2_1 OTVMASCSA2_1 OTVMASCC2_1 OTVMASCPC2_1 OTVMASCC2_1 | automated test notes  | should     | should not |
| DVD      | OTVMASCDN2_2 | Auto-loop  | SD PAL 16x9    | Compile 2     | 2          | OTVMASCDN2_2 OTVMASCCnN2_2 OTVMASCCD2_2 OTVMASCSA2_2 OTVMASCC2_2 OTVMASCPC2_2 OTVMASCC2_2 | automated test notes  | should not | should     |
And complete order contains item with clock number 'OTVMASCCN2' with following fields:
| Job Number | PO Number  |
| OTVMASCJN2 | OTVMASCPN2 |
When I go to Order Summary page for order contains item with following clock number 'OTVMASCCN2'
Then I should see clock delivery with following fields on 'tv' order summary page:
| Clock Number | Status        | Approve |
| OTVMASCCN2   | 0/2 Delivered | On hold |

Scenario: Check approving order with Additional Services items
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASCA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASCU1 | agency.admin | OTVMASCA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASCA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 |
And logged in with details of 'OTVMASCU1'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required |
| automated test info    | OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 | OTVMASCC3 | OTVMASCCN3   | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASCT3 | Already Supplied   |
And hold for approval 'tv' order items with following clock numbers 'OTVMASCCN3'
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name  | Contact Details | Street Address | City        | Post Code    | Country     |        Market       |
| Physical | OTVMASCDN3_1     | OTVMASCCnN3_1 | OTVMASCCD3_1    | OTVMASCSA3_1   | OTVMASCC3_1 | OTVMASCPC3_1 | OTVMASCC3_1 | Republic of Ireland |
| Physical | OTVMASCDN3_2     | OTVMASCCnN3_2 | OTVMASCCD3_2    | OTVMASCSA3_2   | OTVMASCC3_2 | OTVMASCPC3_2 | OTVMASCC3_2 | Republic of Ireland |
And create for 'tv' order with item clock number 'OTVMASCCN3' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                          | Notes & Labels        | Standard   | Express    |
| Data DVD | OTVMASCDN3_1 | Avid DNxHD | Same as Master | Compile 1     | 1          | OTVMASCDN3_1 OTVMASCCnN3_1 OTVMASCCD3_1 OTVMASCSA3_1 OTVMASCC3_1 OTVMASCPC3_1 OTVMASCC3_1 | automated test notes  | should     | should not |
| DVD      | OTVMASCDN3_2 | Auto-loop  | SD PAL 16x9    | Compile 2     | 2          | OTVMASCDN3_2 OTVMASCCnN3_2 OTVMASCCD3_2 OTVMASCSA3_2 OTVMASCC3_2 OTVMASCPC3_2 OTVMASCC3_2 | automated test notes  | should not | should     |
And complete order contains item with clock number 'OTVMASCCN3' with following fields:
| Job Number | PO Number  |
| OTVMASCJN3 | OTVMASCPN3 |
And waited for '10' seconds
And approve 'tv' order items with following clock numbers 'OTVMASCCN3'
When I go to View Held Orders tab of 'tv' order on ordering page
And refresh the page
Then I 'should not' see orders with following markets 'Republic of Ireland' in 'held' order list

Scenario: Check confirming order with Additional Broadcast destinantions and QC Ingest Only
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASCA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASCU1 | agency.admin | OTVMASCA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASCA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 |
And logged in with details of 'OTVMASCU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                 |
| automated test info    | OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 | OTVMASCC4_1 | OTVMASCCN4_1 | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASCT4_1 | Already Supplied   |                             |
| automated test info    | OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 | OTVMASCC4_2 | OTVMASCCN4_2 | 15       | 10/14/2022     | SD PAL 16x9    | OTVMASCT4_2 | Already Supplied   | BSkyB Green Button:Standard |
And enable QC & Ingest Only for 'tv' order for item with following clock number 'OTVMASCCN4_1'
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name  | Contact Details | Street Address | City        | Post Code    | Country     |    Market      |
| Physical | OTVMASCDN4_1     | OTVMASCCnN4_1 | OTVMASCCD4_1    | OTVMASCSA4_1   | OTVMASCC4_1 | OTVMASCPC4_1 | OTVMASCC4_1 | United Kingdom |
| Physical | OTVMASCDN4_2     | OTVMASCCnN4_2 | OTVMASCCD4_2    | OTVMASCSA4_2   | OTVMASCC4_2 | OTVMASCPC4_2 | OTVMASCC4_2 | United Kingdom |
And create for 'tv' order with item clock number 'OTVMASCCN4_1' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                          | Notes & Labels        | Standard |
| Data DVD | OTVMASCDN4_1 | Avid DNxHD | Same as Master | Compile 1     | 1          | OTVMASCDN4_1 OTVMASCCnN4_1 OTVMASCCD4_1 OTVMASCSA4_1 OTVMASCC4_1 OTVMASCPC4_1 OTVMASCC4_1 | automated test notes  | should   |
And create for 'tv' order with item clock number 'OTVMASCCN4_2' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                          | Notes & Labels        | Express  |
| DVD      | OTVMASCDN4_2 | Auto-loop  | HD 1080i 25fps | Compile 2     | 2          | OTVMASCDN4_2 OTVMASCCnN4_2 OTVMASCCD4_2 OTVMASCSA4_2 OTVMASCC4_2 OTVMASCPC4_2 OTVMASCC4_2 | automated test notes  | should   |
And complete order contains item with clock number 'OTVMASCCN4_1' with following fields:
| Job Number | PO Number  |
| OTVMASCJN4 | OTVMASCPN4 |
When I go to Order Summary page for order contains item with following clock number 'OTVMASCCN4_1'
Then I should see clock delivery 'OTVMASCCN4_1' contains destinations with following fields on 'tv' order summary page:
| Destination        | Status       | Time of Delivery | Priority |
| OTVMASCDN4_1       | Order Placed | -                | Standard |
And should see clock delivery 'OTVMASCCN4_2' contains destinations with following fields on 'tv' order summary page:
| Destination        | Status       | Time of Delivery | Priority |
| BSkyB Green Button | Order Placed | -                | Standard |
| OTVMASCDN4_2       | Order Placed | -                | Express  |
When I click ViewDeliveryReport button on the Order Summary Page
Then I should see that View 'Delivery' report opens for order with clock number 'OTVMASCCN4_1'

Scenario: Check confirming order with Additional Broadcast destinantions using Copy Current function
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASCA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASCU1 | agency.admin | OTVMASCA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASCA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 |
And logged in with details of 'OTVMASCU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                 |
| automated test info    | OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 | OTVMASCC5_1 | OTVMASCCN5_1 | 15       | 10/14/2022     | SD PAL 16x9    | OTVMASCT5_1 | Already Supplied   | Aastha:Standard |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name  | Contact Details | Street Address | City        | Post Code    | Country     |     Market     |
| Physical | OTVMASCDN5_1     | OTVMASCCnN5_1 | OTVMASCCD5_1    | OTVMASCSA5_1   | OTVMASCC5_1 | OTVMASCPC5_1 | OTVMASCC5_1 | United Kingdom |
| Physical | OTVMASCDN5_2     | OTVMASCCnN5_2 | OTVMASCCD5_2    | OTVMASCSA5_2   | OTVMASCC5_2 | OTVMASCPC5_2 | OTVMASCC5_2 | United Kingdom |
And create for 'tv' order with item clock number 'OTVMASCCN5_1' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                          | Notes & Labels        | Standard |
| Data DVD | OTVMASCDN5_1 | Avid DNxHD | Same as Master | Compile 1     | 1          | OTVMASCDN5_1 OTVMASCCnN5_1 OTVMASCCD5_1 OTVMASCSA5_1 OTVMASCC5_1 OTVMASCPC5_1 OTVMASCC5_1 | automated test notes  | should   |
When I open order item with following clock number 'OTVMASCCN5_1'
And 'copy current' order item by Add Commercial button on order item page
And fill following fields for Add information form on order item page:
| Clock Number | Title       |
| OTVMASCCN5_2 | OTVMASCT5_2 |
And fill following fields for Additional Services section on order item page:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies | Notes & Labels       | Express |
| DVD      | OTVMASCDN5_2 | Auto-loop  | SD PAL 16x9    | Compile 2     | 2         | automated test notes | should  |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number  |
| OTVMASCJN5 | OTVMASCPN5 |
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number 'OTVMASCCN5_1' and following fields:
| Order# | DateTime    | Advertiser | Brand      | Sub Brand  | Product    | Market         | PO Number  | Job #      | NoClocks | Status        |
| Digit# | CurrentTime | OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 | United Kingdom | OTVMASCPN5 | OTVMASCJN5 | 2        | 0/2 Delivered |

Scenario: Check pulling data to the Delivery Draft Report with Additional Services items
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASCA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASCU1 | agency.admin | OTVMASCA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASCA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 |
And logged in with details of 'OTVMASCU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign    | Clock Number | Duration | First Air Date | Format         | Title       | Subtitles Required | Destination                 |
| automated test info    | OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 | OTVMASCC6_1 | OTVMASCCN6_1 | 20       | 08/14/2022     | HD 1080i 25fps | OTVMASCT6_1 | Already Supplied   |                             |
| automated test info    | OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 | OTVMASCC6_2 | OTVMASCCN6_2 | 15       | 10/14/2022     | SD PAL 16x9    | OTVMASCT6_2 | Already Supplied   | BSkyB Green Button:Standard |
And enable QC & Ingest Only for 'tv' order for item with following clock number 'OTVMASCCN6_1'
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name  | Contact Details | Street Address | City        | Post Code    | Country     |     Market     |
| Physical | OTVMASCDN6_1     | OTVMASCCnN6_1 | OTVMASCCD6_1    | OTVMASCSA6_1   | OTVMASCC6_1 | OTVMASCPC6_1 | OTVMASCC6_1 | United Kingdom |
| Physical | OTVMASCDN6_2     | OTVMASCCnN6_2 | OTVMASCCD6_2    | OTVMASCSA6_2   | OTVMASCC6_2 | OTVMASCPC6_2 | OTVMASCC6_2 | United Kingdom |
And create for 'tv' order with item clock number 'OTVMASCCN6_1' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                          | Notes & Labels        | Standard |
| Data DVD | OTVMASCDN6_1 | Avid DNxHD | Same as Master | Compile 1     | 1          | OTVMASCDN6_1 OTVMASCCnN6_1 OTVMASCCD6_1 OTVMASCSA6_1 OTVMASCC6_1 OTVMASCPC6_1 OTVMASCC6_1 | automated test notes  | should   |
And create for 'tv' order with item clock number 'OTVMASCCN6_2' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                          | Notes & Labels        | Express  |
| DVD      | OTVMASCDN6_2 | Auto-loop  | HD 1080i 25fps | Compile 2     | 2          | OTVMASCDN6_2 OTVMASCCnN6_2 OTVMASCCD6_2 OTVMASCSA6_2 OTVMASCC6_2 OTVMASCPC6_2 OTVMASCC6_2 | automated test notes  | should   |
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand      | Sub Brand  | Product    | Title       | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Additional Service Type | Additional Service Destination | Notes & Labels       | Additional Service Format | No copies | Media Compile | Additional Service Level |
| OTVMASCCN6_1 |            |           | 2                 | 1                 | United Kingdom | OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 | OTVMASCT6_1 | 20       | HD 1080i 25fps |                 |               | 08/14/2022     | No      | automated test info |             | Already Supplied   | 1               | Data DVD                | OTVMASCDN6_1                   | automated test notes | Avid DNxHD                | 1         | Compile 1     | Standard                 |
And should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand      | Sub Brand  | Product    | Title       | Duration | Format      | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Destination Group | Destination        | Service Level | Additional Service Type | Additional Service Destination | Notes & Labels       | Additional Service Format | No copies | Media Compile | Additional Service Level |
| OTVMASCCN6_2 |            |           | 2                 | 2                 | United Kingdom | OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 | OTVMASCT6_2 | 15       | SD PAL 16x9 |                 |               | 10/14/2022     | No      | automated test info |             | Already Supplied   | 3               | BSkyB             | BSkyB Green Button | Standard      | DVD                     | OTVMASCDN6_2                   | automated test notes | Auto-loop                 | 2         | Compile 2     | Express                  |

Scenario: Check non-cyrylic characters in Delivery Draft Report with Additional Services items
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVMASCA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVMASCU1 | agency.admin | OTVMASCA1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMASCA1':
| Advertiser | Brand      | Sub Brand  | Product    |
| OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 |
And logged in with details of 'OTVMASCU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 | OTVMASCC7 | OTVMASCCN7   | 15       | 10/14/2022     | SD PAL 16x9    | OTVMASCT7 | Already Supplied   | BSkyB Green Button:Standard |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City      | Post Code  | Country   |      Market    |
| Physical | OTVMASCDN7       | OTVMASCCnN7  | OTVMASCCD7      | OTVMASCSA7     | OTVMASCC7 | OTVMASCPC7 | OTVMASCC7 | United Kingdom |
And create for 'tv' order with item clock number 'OTVMASCCN7' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                            | Notes & Labels | Standard |
| Data DVD | OTVMASCDN7  | Avid DNxHD | Same as Master | Compile 1     | 1          | OTVMASCDN7 OTVMASCCnN7 OTVMASCCD7 OTVMASCSA7 OTVMASCC7 OTVMASCPC7 OTVMASCC7 | 自動測試        | should   |
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country        | Advertiser | Brand      | Sub Brand  | Product    | Title     | Duration | Format      | Delivery Method | Deadline Date | First Air Date | Archive | Note                | Attachments | Subtitles Required | Delivery Points | Additional Service Type | Additional Service Destination | Notes & Labels | Additional Service Format | No copies | Media Compile | Additional Service Level |
| OTVMASCCN7   |            |           | 1                 | 1                 | United Kingdom | OTVMASCAR1 | OTVMASCBR1 | OTVMASCSB1 | OTVMASCPR1 | OTVMASCT7 | 15       | SD PAL 16x9 |                 |               | 10/14/2022     | No      | automated test info |             | Already Supplied   | 2               | Data DVD                | OTVMASCDN7                     | 自動測試        | Avid DNxHD                | 1         | Compile 1     | Standard                 |