!--ORD-2994
!--ORD-3065
Feature: User should be able to save as draft order on the Order Summary page
Narrative:
In order to:
As a AgencyAdmin
I want to check that user should be able to save as draft order on the Order Summary page

Scenario: check saving enetered information on Order Proceed page after save as draft order
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SDOOSPA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SDOOSPU1 | agency.admin | SDOOSPA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SDOOSPA1':
| Advertiser | Brand     | Sub Brand | Product   |
| SDOOSPAR1  | SDOOSPBR1 | SDOOSPSB1 | SDOOSPPR1 |
And logged in with details of 'SDOOSPU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Destination                 |
| automated test info    | SDOOSPAR1  | SDOOSPBR1 | SDOOSPSB1 | SDOOSPPR1 | SDOOSPC1 | SDOOSPCN1    | 20       | 10/14/2022     | HD 1080i 25fps | SDOOSPT1 | Aastha:Standard |
And I am on Order Proceed page for order contains order item with following clock number 'SDOOSPCN1'
When I fill following fields on Order Proceed page:
| Notify About Delivery | Notify About Passed QC | Order Confirmed Recipients | Job Number | PO Number |
| should                | should                 | SDOOSPU1                   | SDOOSPJN1  | SDOOSPPN1 |
And save as draft order on Order Proceed page
And go to Order Proceed page for order contains order item with following clock number 'SDOOSPCN1'
Then I should see following data for order on Order Proceed page:
| Notify About Delivery | Notify About Passed QC | Order Confirmed Recipients | Job Number | PO Number |
| should                | should                 | SDOOSPU1                   | SDOOSPJN1  | SDOOSPPN1 |

Scenario: check saving removed information on Order Proceed page after save as draft order
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SDOOSPA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SDOOSPU1 | agency.admin | SDOOSPA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SDOOSPA1':
| Advertiser | Brand     | Sub Brand | Product   |
| SDOOSPAR1  | SDOOSPBR1 | SDOOSPSB1 | SDOOSPPR1 |
And logged in with details of 'SDOOSPU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Destination                 |
| automated test info    | SDOOSPAR1  | SDOOSPBR1 | SDOOSPSB1 | SDOOSPPR1 | SDOOSPC2 | SDOOSPCN2    | 20       | 10/14/2022     | HD 1080i 25fps | SDOOSPT2 | Aastha:Standard |
And I am on Order Proceed page for order contains order item with following clock number 'SDOOSPCN2'
When I fill following fields on Order Proceed page:
| Notify About Delivery | Notify About Passed QC | Order Confirmed Recipients | Job Number | PO Number |
| should                | should                 | SDOOSPU2                   | SDOOSPJN2  | SDOOSPPN2 |
And save as draft order on Order Proceed page
And go to Order Proceed page for order contains order item with following clock number 'SDOOSPCN2'
And fill following fields on Order Proceed page:
| Notify About Delivery | Notify About Passed QC | Order Confirmed Recipients | Job Number | PO Number |
| should not            | should not             |                            |            |           |
And save as draft order on Order Proceed page
And go to Order Proceed page for order contains order item with following clock number 'SDOOSPCN2'
Then I should see following data for order on Order Proceed page:
| Notify About Delivery | Notify About Passed QC | Order Confirmed Recipients | Job Number | PO Number |
| should not            | should not             |                            |            |           |

Scenario: check saving empty fields on Order Proceed page after save as draft order
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| SDOOSPA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| SDOOSPU1 | agency.admin | SDOOSPA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SDOOSPA1':
| Advertiser | Brand     | Sub Brand | Product   |
| SDOOSPAR1  | SDOOSPBR1 | SDOOSPSB1 | SDOOSPPR1 |
And logged in with details of 'SDOOSPU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Destination                 |
| automated test info    | SDOOSPAR1  | SDOOSPBR1 | SDOOSPSB1 | SDOOSPPR1 | SDOOSPC3 | SDOOSPCN3    | 20       | 10/14/2022     | HD 1080i 25fps | SDOOSPT3 | Aastha:Standard |
And I am on Order Proceed page for order contains order item with following clock number 'SDOOSPCN3'
When I fill following fields on Order Proceed page:
| Notify About Delivery | Notify About Passed QC | Order Confirmed Recipients | Job Number | PO Number |
|                       |                        |                            |            |           |
And save as draft order on Order Proceed page
And go to Order Proceed page for order contains order item with following clock number 'SDOOSPCN3'
Then I should see following data for order on Order Proceed page:
| Notify About Delivery | Notify About Passed QC | Order Confirmed Recipients | Job Number | PO Number |
|                       |                        |                            |            |           |

Scenario: check saving information on Order Proceed page after saving as draft order and then transfering it
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| SDOOSPA4_1 | DefaultA4User |
| SDOOSPA4_2 | DefaultA4User |
And added agency 'SDOOSPA4_2' as a partner to agency 'SDOOSPA4_1'
And created users with following fields:
| Email            | Role         | AgencyUnique |
| SDOOSPU4_1_email | agency.admin | SDOOSPA4_1   |
| SDOOSPU4_2_email | agency.admin | SDOOSPA4_2   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SDOOSPA4_1':
| Advertiser | Brand     | Sub Brand | Product   |
| SDOOSPAR4  | SDOOSPBR4 | SDOOSPSB4 | SDOOSPPR4 |
And logged in with details of 'SDOOSPU4_1_email'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Destination                 |
| automated test info    | SDOOSPAR4  | SDOOSPBR4 | SDOOSPSB4 | SDOOSPPR4 | SDOOSPC4 | SDOOSPCN4    | 20       | 10/14/2022     | HD 1080i 25fps | SDOOSPT4 | Aastha:Standard |
And I am on Order Proceed page for order contains order item with following clock number 'SDOOSPCN4'
When I fill following fields on Order Proceed page:
| Notify About Delivery | Notify About Passed QC | Order Confirmed Recipients       | Job Number | PO Number |
| should                | should                 | SDOOSPU4_1_email                 | SDOOSPJN4  | SDOOSPPN4 |
And save as draft order on Order Proceed page
And go to Order Proceed page for order contains order item with following clock number 'SDOOSPCN4'
And fill following fields for Transfer Order form on Order Proceed page:
| Transfer to      | Message                   |
| SDOOSPU4_2_email | autotest transfer message |
And click Send button on Transfer Order form on Order Proceed page
And login with details of 'SDOOSPU4_2_email'
And go to Order Proceed page for order contains order item with following clock number 'SDOOSPCN4'
Then I should see following data for order on Order Proceed page:
| Notify About Delivery | Notify About Passed QC | Order Confirmed Recipients       | Job Number | PO Number |
| should                | should                 | SDOOSPU4_1_email                 | SDOOSPJN4  | SDOOSPPN4 |

Scenario: check saving information in Live order list after confirming order when had saved as draft before transfered it on Order Proceed page
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| SDOOSPA4_1 | DefaultA4User |
| SDOOSPA4_2 | DefaultA4User |
And added agency 'SDOOSPA4_2' as a partner to agency 'SDOOSPA4_1'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| SDOOSPU5_1 | agency.admin | SDOOSPA4_1   |
| SDOOSPU5_2 | agency.admin | SDOOSPA4_2   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SDOOSPA4_1':
| Advertiser | Brand     | Sub Brand | Product   |
| SDOOSPAR4  | SDOOSPBR4 | SDOOSPSB4 | SDOOSPPR4 |
And logged in with details of 'SDOOSPU5_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | SDOOSPAR4  | SDOOSPBR4 | SDOOSPSB4 | SDOOSPPR4 | SDOOSPC5 | SDOOSPCN5    | 20       | 10/14/2022     | HD 1080i 25fps | SDOOSPT5 | Already Supplied   | Aastha:Standard |
And I am on Order Proceed page for order contains order item with following clock number 'SDOOSPCN5'
When I fill following fields on Order Proceed page:
| Notify About Delivery | Notify About Passed QC | Order Confirmed Recipients | Job Number | PO Number |
| should                | should                 | SDOOSPU5_1                 | SDOOSPJN5  | SDOOSPPN5 |
And save as draft order on Order Proceed page
And transfer order contains item with clock number 'SDOOSPCN5' to user 'SDOOSPU5_2' with following message 'autotest transfer message'
And login with details of 'SDOOSPU5_2'
And go to Order Proceed page for order contains order item with following clock number 'SDOOSPCN5'
And confirm order on Order Proceed page
Then I should see TV order in 'live' order list with item clock number 'SDOOSPCN5' and following fields:
| Order# | DateTime    | Advertiser | Brand     | Sub Brand | Product   | Market         | PO Number | Job #     | NoClocks | Status        |
| Digit  | CurrentTime | SDOOSPAR4  | SDOOSPBR4 | SDOOSPSB4 | SDOOSPPR4 | United Kingdom | SDOOSPPN5 | SDOOSPJN5 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains clock number 'SDOOSPCN5' and items with following fields:
| Clock Number | Advertiser | Product   | Title    | First Air Date | Format         | Duration | Status        |
| SDOOSPCN5    | SDOOSPAR4  | SDOOSPPR4 | SDOOSPT5 | 10/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |

Scenario: check saving information on Order Summary page for live order when had saved as draft before transfered and confirmed it
Meta: @ordering
Given I created the following agency:
| Name       | A4User        |
| SDOOSPA4_1 | DefaultA4User |
| SDOOSPA4_2 | DefaultA4User |
And added agency 'SDOOSPA4_2' as a partner to agency 'SDOOSPA4_1'
And created users with following fields:
| Email      | Role         | AgencyUnique |
| SDOOSPU5_1 | agency.admin | SDOOSPA4_1   |
| SDOOSPU5_2 | agency.admin | SDOOSPA4_2   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'SDOOSPA4_1':
| Advertiser | Brand     | Sub Brand | Product   |
| SDOOSPAR4  | SDOOSPBR4 | SDOOSPSB4 | SDOOSPPR4 |
And logged in with details of 'SDOOSPU5_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | SDOOSPAR4  | SDOOSPBR4 | SDOOSPSB4 | SDOOSPPR4 | SDOOSPC6 | SDOOSPCN6    | 20       | 10/14/2022     | HD 1080i 25fps | SDOOSPT6 | Already Supplied   | Aastha:Standard |
And I am on Order Proceed page for order contains order item with following clock number 'SDOOSPCN6'
When I fill following fields on Order Proceed page:
| Notify About Delivery | Notify About Passed QC | Order Confirmed Recipients | Job Number | PO Number |
| should                | should                 | SDOOSPU5_1                 | SDOOSPJN6  | SDOOSPPN6 |
And save as draft order on Order Proceed page
And transfer order contains item with clock number 'SDOOSPCN6' to user 'SDOOSPU5_2' with following message 'autotest transfer message'
And login with details of 'SDOOSPU5_2'
And go to Order Proceed page for order contains order item with following clock number 'SDOOSPCN6'
And confirm order on Order Proceed page
And go to Order Summary page for order contains item with following clock number 'SDOOSPCN6'
Then I should see for order contains item with clock number 'SDOOSPCN6' following summary information on order summary page:
| Order Number | Organisation | Date Submitted | Created By | Job Number | PO Number | Flag           | Market         |
| Dijit        | SDOOSPA4_1   | DateSubmitted  | CreatedBy  | SDOOSPJN6  | SDOOSPPN6 | United Kingdom | United Kingdom |
And should see clock delivery with following fields on 'tv' order summary page:
| Clock Number | Advertiser | Brand     | Sub Brand | Product   | Title    | First Air Date | Format         | Duration | Status        |
| SDOOSPCN6    | SDOOSPAR4  | SDOOSPBR4 | SDOOSPSB4 | SDOOSPPR4 | SDOOSPT6 | 10/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |
And should see clock delivery 'SDOOSPCN6' contains destinations with following fields on 'tv' order summary page:
| Destination        | Status       | Time of Delivery | Priority |
| Aastha             | Order Placed | -                | Standard |