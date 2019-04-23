!--NGN-16233 TVT-1654
Feature:          User with permission can edit order
Narrative:
In order to
As a              AgencyAdmin
I want to         Check order edit

Scenario: Check that user with 'tv_order.completed.edit' permission can see order-edit option only for LIVE & HELD orders
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| UWPCEOA_1 | DefaultA4User |
And created 'UWPCEOR_1' role with 'tv_order.completed.edit,tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'UWPCEOA_1'
And created users with following fields:
| Email     | Role      | AgencyUnique |
| UWPCEOU_1 | UWPCEOR_1 | UWPCEOA_1    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'UWPCEOA_1':
| Advertiser | Brand    | Sub Brand | Product  |
| UWPCEOAR   | UWPCEOBR | UWPCEOSB  | UWPCEOPR |
And logged in with details of 'UWPCEOU_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination     |
| automated test info    | UWPCEOAR   | UWPCEOBR | UWPCEOSB  | UWPCEOPR | UWPCEOC_1 | UWPCEOCN_1_1 | 20       | 10/14/2022     | HD 1080i 25fps | UWPCEOT_1 | None               | Aastha:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination     |
| automated test info    | UWPCEOAR   | UWPCEOBR | UWPCEOSB  | UWPCEOPR | UWPCEOC_2 | UWPCEOCN_1_2 | 20       | 10/14/2022     | HD 1080i 25fps | UWPCEOT_2 | None               | Aastha:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination     |
| automated test info    | UWPCEOAR   | UWPCEOBR | UWPCEOSB  | UWPCEOPR | UWPCEOC_3 | UWPCEOCN_1_3 | 20       | 10/14/2022     | HD 1080i 25fps | UWPCEOT_3 | None               | Aastha:Standard |
And hold for approval 'tv' order items with following clock numbers 'UWPCEOCN_1_1'
And complete order contains item with clock number 'UWPCEOCN_1_1' with following fields:
| Job Number  | PO Number   |
| UWPCEOJO1_1 | UWPCEOPO1_1 |
And waited for '10' seconds
And complete order contains item with clock number 'UWPCEOCN_1_2' with following fields:
| Job Number  | PO Number   |
| UWPCEOJO1_2 | UWPCEOPO1_2 |
Then I 'should' be able to edit 'tv' order in 'live' tab with item clock number 'UWPCEOCN_1_1'
And 'should' be able to edit 'tv' order in 'live' tab with item clock number 'UWPCEOCN_1_2'
When I select 'View Held Orders' tab on ordering page
Then I 'should' be able to edit 'tv' order in 'held' tab with item clock number 'UWPCEOCN_1_1'
When I select 'View Draft Orders' tab on ordering page
Then I 'shouldnot' be able to edit 'tv' order in 'draft' tab with item clock number 'UWPCEOCN_1_3'


Scenario: Check that user with 'tv_order.completed.edit' permission can save the order after editing it (Edit Section: Add information, Broadcast, Additional Services)
!--FAB-276 scenaio might fail because of open bug
Meta: @ordering
@obug
Given I created the following agency:
| Name      | A4User        |
| UWPCEOA_2 | DefaultA4User |
And created 'UWPCEOR_2' role with 'tv_order.completed.edit,tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'UWPCEOA_2'
And created users with following fields:
| Email     | Role      | AgencyUnique |
| UWPCEOU_2 | UWPCEOR_2 | UWPCEOA_2    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'UWPCEOA_2':
| Advertiser | Brand     | Sub Brand | Product   |
| UWPCEOAR1  | UWPCEOBR1 | UWPCEOSB1 | UWPCEOPR1 |
| UWPCEOAR2  | UWPCEOBR2 | UWPCEOSB2 | UWPCEOPR2 |
And logged in with details of 'UWPCEOU_2'
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City       | Post Code   | Country    |  Market        |
| Physical | UWPCEODN1        | UWPCEOCnN1_1 | UWPCEOCD1_1     | UWPCEOSA1_1    | UWPCEOC1_1 | UWPCEOPC1_1 | UWPCEOC1_1 | United Kingdom |
| Physical | UWPCEODN2        | UWPCEOCnN1_1 | UWPCEOCD1_1     | UWPCEOSA1_1    | UWPCEOC1_1 | UWPCEOPC1_1 | UWPCEOC1_1 | United Kingdom |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                                       |
| automated test info    | UWPCEOAR1  | UWPCEOBR1 | UWPCEOSB1 | UWPCEOPR1 | UWPCEOC_1 | UWPCEOCN_2_1 | 20       | 10/14/2022     | HD 1080i 25fps | UWPCEOT_1 | None               | Aastha:Standard;Talk Sport:Standard;AOL:Standard  |
And create for 'tv' order with item clock number 'UWPCEOCN_2_1' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                 | Notes & Labels        | Standard   | Express |
| Data DVD | UWPCEODN1    | Avid DNxHD | Same as Master | Compile 1     | 1          | UWPCEODN1 UWPCEOCnN1_1 UWPCEOCD1_1 UWPCEOSA1_1 UWPCEOC1_1 UWPCEOPC1_1 UWPCEOC1_1 | automated test notes  | should not | should  |
And create for 'tv' order with item clock number 'UWPCEOCN_2_1' production additional services with following fields:
| Type       | Notes                |
| Tagging SD | automated test notes |
And hold for approval 'tv' order items with following clock numbers 'UWPCEOCN_2_1'
And complete order contains item with clock number 'UWPCEOCN_2_1' with following fields:
| Job Number  | PO Number   |
| UWPCEOJO1_1 | UWPCEOPO1_1 |
And waited for '10' seconds
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                                      |
| automated test info    | UWPCEOAR1  | UWPCEOBR1 | UWPCEOSB1 | UWPCEOPR1 | UWPCEOC_2 | UWPCEOCN_2_2 | 20       | 10/14/2022     | HD 1080i 25fps | UWPCEOT_2 | None               | Aastha:Standard;Talk Sport:Standard;AOL:Standard |
And create for 'tv' order with item clock number 'UWPCEOCN_2_2' additional services with following fields:
| Type     | Destination  | Format     | Specification  | Media Compile | No copies  | Delivery Details                                                                 | Notes & Labels        | Standard   | Express |
| Data DVD | UWPCEODN2    | Avid DNxHD | Same as Master | Compile 1     | 1          | UWPCEODN1 UWPCEOCnN1_1 UWPCEOCD1_1 UWPCEOSA1_1 UWPCEOC1_1 UWPCEOPC1_1 UWPCEOC1_1 | automated test notes  | should not | should  |
And create for 'tv' order with item clock number 'UWPCEOCN_2_2' production additional services with following fields:
| Type       | Notes                |
| Reslate SD | automated test notes |
And complete order contains item with clock number 'UWPCEOCN_2_2' with following fields:
| Job Number  | PO Number   |
| UWPCEOJO1_2 | UWPCEOPO1_2 |
And wait for finish place order with following item clock number 'UWPCEOCN_2_2' to A4
When I go to View Live Orders tab of 'TV' order on ordering page
And select 'UWPCEOCN_2_2' for edit in 'live' tab
And refresh the page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign  | Clock Number           | Duration | First Air Date | Format         | Title          | Subtitles Required |
| automated test info    | UWPCEOAR2  | UWPCEOBR2 | UWPCEOSB2 | UWPCEOPR2 | UWPCEOC_2 | UWPCEOCN_2_2_OrderEdit | 10       | 10/14/2024     | HD 1080i 25fps | UWPCEOT_2_Edit | None               |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Express |
| ABN     |
And cancel following destinations for Select Broadcast Destinations form on order item page 'AOL'
And fill following fields for Additional Services section on order item page:
| Type     | Destination | Format     | Specification  | Media Compile | No copies | Notes & Labels       | Standard |
| Data DVD | UWPCEODN2   | Avid DNxHD | HD 1080i 25fps | Compile 2     | 1         | automated test notes | should   |
And fill following fields for Production Services of Additional Services section on order item page:
| Type       | Notes                  |
| Reslate SD | automated test notes 1 |
And click Proceed button on order item page
And confirm the order after order edit on Order summary page
Then I should see 'live' order in 'tv' order list contains clock number 'UWPCEOCN_2_2_OrderEdit' and items with following fields:
| Clock Number           | Advertiser | Product   | Title          | First Air Date | Format         | Duration | Status        |
| UWPCEOCN_2_2_OrderEdit | UWPCEOAR2  | UWPCEOPR2 | UWPCEOT_2_Edit | 10/14/2024     | HD 1080i 25fps | 10       | 0/5 Delivered |
When I go to Order Summary page for order contains item with following clock number 'UWPCEOCN_2_2_OrderEdit'
Then I should see clock delivery with following fields on 'tv' order summary page:
| Clock Number           | Advertiser | Brand     | Sub Brand | Product   | Title          | First Air Date | Format         | Duration | Status        | Approve |
| UWPCEOCN_2_2_OrderEdit | UWPCEOAR2  | UWPCEOBR2 | UWPCEOSB2 | UWPCEOPR2 | UWPCEOT_2_Edit | 10/14/2024     | HD 1080i 25fps | 10       | 0/5 Delivered |         |
Then I 'should' see that following destinations 'AOL' are cancelled for clock delivery 'UWPCEOCN_2_2_OrderEdit' on 'tv' order summary page
And should see clock delivery 'UWPCEOCN_2_2_OrderEdit' contains destinations with following fields on 'tv' order summary page:
| Destination | Status       | Time of Delivery | Priority |
| ABN         | Order Placed | -                | Express  |
| Aastha      | Order Placed | -                | Standard |
| Talk Sport  | Order Placed | -                | Standard |
| UWPCEODN2   | Order Placed | -                | Standard |
| Reslate SD  | Order Placed | -                |          |
When I go to View Draft Orders tab of 'tv' order on ordering page
And select 'View Held Orders' tab on ordering page
And select 'UWPCEOCN_2_1' for edit in 'held' tab
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign  | Clock Number           | Duration | First Air Date | Format         | Title          | Subtitles Required |
| automated test info    | UWPCEOAR2  | UWPCEOBR2 | UWPCEOSB2 | UWPCEOPR2 | UWPCEOC_2 | UWPCEOCN_2_1_OrderEdit | 10       | 10/14/2024     | HD 1080i 25fps | UWPCEOT_2_Edit | None               |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Express |
| ABN     |
And cancel following destinations for Select Broadcast Destinations form on order item page 'AOL'
And fill following fields for Additional Services section on order item page:
| Type     | Destination | Format     | Specification  | Media Compile | No copies | Notes & Labels       | Express |
| Data DVD | UWPCEODN1   | Avid DNxHD | HD 1080i 25fps | Compile 2     | 1         | automated test notes | should  |
And fill following fields for Production Services of Additional Services section on order item page:
| Type       | Notes                  |
| Tagging SD | automated test notes 1 |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number    | PO Number     |
| UWPCEOJO1_1_E | UWPCEOPO1_1_E |
And confirm the order after order edit on Order summary page
Then I should see 'live' order in 'tv' order list contains clock number 'UWPCEOCN_2_1_OrderEdit' and items with following fields:
| Clock Number           | Advertiser | Product   | Title          | First Air Date | Format         | Duration | Status        |
| UWPCEOCN_2_1_OrderEdit | UWPCEOAR2  | UWPCEOPR2 | UWPCEOT_2_Edit | 10/14/2024     | HD 1080i 25fps | 10       | 0/5 Delivered |
When I go to Order Summary page for order contains item with following clock number 'UWPCEOCN_2_1_OrderEdit'
Then I should see clock delivery with following fields on 'tv' order summary page:
| Clock Number           | Advertiser | Brand     | Sub Brand | Product   | Title          | First Air Date | Format         | Duration | Status        | Approve |
| UWPCEOCN_2_1_OrderEdit | UWPCEOAR2  | UWPCEOBR2 | UWPCEOSB2 | UWPCEOPR2 | UWPCEOT_2_Edit | 10/14/2024     | HD 1080i 25fps | 10       | 0/5 Delivered | On hold |
And should see clock delivery 'UWPCEOCN_2_1_OrderEdit' contains destinations with following fields on 'tv' order summary page:
| Destination | Status       | Time of Delivery | Priority |
| ABN         | Order Placed | -                | Express  |
| Aastha      | Order Placed | -                | Standard |
| Talk Sport  | Order Placed | -                | Standard |
| UWPCEODN1   | Order Placed | -                | Express  |
| Tagging SD  | Order Placed | -                |          |
When I go to View Draft Orders tab of 'tv' order on ordering page
And select 'View Held Orders' tab on ordering page
Then I should see TV order in 'held' order list with item clock number 'UWPCEOCN_2_1_OrderEdit' and following fields:
| Order# | DateTime    | Advertiser | PO Number     | Job #         | NoClocks | Status        |
| Digit  | CurrentTime | UWPCEOAR2  | UWPCEOPO1_1_E | UWPCEOJO1_1_E | 1        | 0/1 Delivered |