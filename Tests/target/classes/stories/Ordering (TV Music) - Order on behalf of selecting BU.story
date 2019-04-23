!--ORD-1174
!--ORD-2837
Feature: Order on behalf of selecting BU
Narrative:
In order to:
As a AgencyAdmin
I want to check order on behalf

Scenario: check payer on order item page
Meta: @ordering
Given I created the following agency:
| Name    | A4User        | Country        | SAP ID       |
| OOBA1_1 | DefaultA4User | United Kingdom | DefaultSapID |
| OOBA1_2 | DefaultA4User | United Kingdom | DefaultSapID |
And added agency 'OOBA1_2' as a partner for agency 'OOBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OOBU1 | agency.admin | OOBA1_1      |
And logged in with details of 'OOBU1'
When I create 'tv' order on View Draft Orders tab with following invoicing organisation 'OOBA1_2'
Then I should see following invoicing organisation 'OOBA1_2' on order item page

Scenario: check payer after had changed it on order item page
Meta: @ordering
Given I created the following agency:
| Name    | A4User        | Country        | SAP ID       |
| OOBA1_1 | DefaultA4User | United Kingdom | DefaultSapID |
| OOBA1_2 | DefaultA4User | United Kingdom | DefaultSapID |
And added agency 'OOBA1_2' as a partner for agency 'OOBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OOBU1 | agency.admin | OOBA1_1      |
And logged in with details of 'OOBU1'
When I create 'tv' order on View Draft Orders tab with following invoicing organisation 'OOBA1_2'
And changed invoicing organisation to following 'OOBA1_1' on order item page
Then I should see following invoicing organisation 'OOBA1_1' on order item page

Scenario: check payer on the Order Summary page
Meta: @ordering
Given I created the following agency:
| Name    | A4User        | Country        | SAP ID       |
| OOBA1_1 | DefaultA4User | United Kingdom | DefaultSapID |
| OOBA1_2 | DefaultA4User | United Kingdom | DefaultSapID |
And added agency 'OOBA1_2' as a partner for agency 'OOBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OOBU1 | agency.admin | OOBA1_1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OOBA1_1':
| Advertiser | Brand  | Sub Brand | Product |
| OOBAR3     | OOBBR3 | OOBSB3    | OOBPR3  |
And logged in with details of 'OOBU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | OOBAR3     | OOBBR3 | OOBSB3    | OOBPR3  | OOBC3    | OOBCN3       | 20       | 10/14/2022     | HD 1080i 25fps | OOBT3 | Already Supplied   | BSkyB Green Button:Standard |
And add for order that contains item with clock number 'OOBCN3' following invoicing organisation 'OOBA1_2'
When I go to Order Proceed page for order contains order item with following clock number 'OOBCN3'
Then I should see next invoicing organisation 'OOBA1_2' on order proceed page

Scenario: check payer on the Order Summary page after had changed it
Meta: @ordering
Given I created the following agency:
| Name    | A4User        | Country        | SAP ID       |
| OOBA1_1 | DefaultA4User | United Kingdom | DefaultSapID |
| OOBA1_2 | DefaultA4User | United Kingdom | DefaultSapID |
And added agency 'OOBA1_2' as a partner for agency 'OOBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OOBU1 | agency.admin | OOBA1_1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OOBA1_1':
| Advertiser | Brand  | Sub Brand | Product |
| OOBAR3     | OOBBR3 | OOBSB3    | OOBPR3  |
And logged in with details of 'OOBU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | OOBAR3     | OOBBR3 | OOBSB3    | OOBPR3  | OOBC4    | OOBCN4       | 20       | 10/14/2022     | HD 1080i 25fps | OOBT4 | Already Supplied   | Aastha:Standard |
And add for order that contains item with clock number 'OOBCN4' following invoicing organisation 'OOBA1_2'
When I open order item with following clock number 'OOBCN4'
And changed invoicing organisation to following 'OOBA1_1' on order item page
And click Proceed button on order item page
Then I should see next invoicing organisation 'OOBA1_1' on order proceed page

Scenario: check payer billing schema
!--ORD-2842
Meta: @ordering
Given I created the following agency:
| Name    | A4User        | Country        | SAP ID       |
| OOBA1_1 | DefaultA4User | United Kingdom | DefaultSapID |
| OOBA1_5 | DefaultA4User | United Kingdom | BM0005       |
And added agency 'OOBA1_5' as a partner for agency 'OOBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OOBU1 | agency.admin | OOBA1_1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OOBA1_1':
| Advertiser | Brand  | Sub Brand | Product |
| OOBAR3     | OOBBR3 | OOBSB3    | OOBPR3  |
And logged in with details of 'OOBU1'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | OOBAR3     | OOBBR3 | OOBSB3    | OOBPR3  | OOBC5    | OOBCN5       | 20       | 10/14/2022     | HD 1080i 25fps | OOBT5 | Already Supplied   | BSkyB Green Button:Standard |
And add for order that contains item with clock number 'OOBCN5' following invoicing organisation 'OOBA1_5'
When I go to Order Proceed page for order contains order item with following clock number 'OOBCN5'
Then I should see following Billing data on Order Proceed page:
| Item                         | QTY | Unit   | TotalPerItem | Subtotal | Tax   | Total  |
| SD Standard Normal (Digital) | 1   | 50.00  | 50.00        | 50.00    | 10.50 | 60.50  |


Scenario: check payer billing schema after had transferred order
!--ORD-2809
Meta: @ordering
@obug
!--NIR-784
Given I created the following agency:
| Name    | A4User        | Country        | SAP ID       |
| OOBA1_1 | DefaultA4User | United Kingdom | DefaultSapID |
| OOBA1_2 | DefaultA4User | United Kingdom | DefaultSapID |
And added agency 'OOBA1_2' as a partner for agency 'OOBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OOBU1 | agency.admin | OOBA1_1      |
| OOBU6 | agency.admin | OOBA1_2      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OOBA1_1':
| Advertiser | Brand  | Sub Brand | Product |
| OOBAR3     | OOBBR3 | OOBSB3    | OOBPR3  |
And logged in with details of 'OOBU1'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | OOBAR3     | OOBBR3 | OOBSB3    | OOBPR3  | OOBC6    | OOBCN6       | 20       | 10/14/2022     | HD 1080i 25fps | OOBT6 | Already Supplied   | BSkyB Green Button:Standard |
And add for order that contains item with clock number 'OOBCN6' following invoicing organisation 'OOBA1_2'
And transfered order contains item with clock number 'OOBCN6' to user 'OOBU6' with following message 'autotest transfer message'
And logged in with details of 'OOBU6'
When I go to Order Proceed page for order contains order item with following clock number 'OOBCN6'
Then I should see following Billing data on Order Proceed page:
| Item                         | QTY | Unit    | TotalPerItem | Subtotal | Tax    | Total   |
| SD Standard Normal (Digital) | 1   | 100.00 | 100.00      | 100.00  | 21.00 | 121.00 |

Scenario: check the Order Summary page for payer without possibility to view billing schema
Meta: @ordering
Given I created the following agency:
| Name    | A4User        | Country        | SAP ID       |
| OOBA7_1 | DefaultA4User | United Kingdom | DefaultSapID |
| OOBA7_2 | DefaultA4User | United Kingdom | DefaultSapID |
And added agency 'OOBA7_2' as a partner for agency 'OOBA7_1' with following fields:
| Can Bill | Can View   |
| should   | should not |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OOBU7 | agency.admin | OOBA7_1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OOBA7_1':
| Advertiser | Brand  | Sub Brand | Product |
| OOBAR7     | OOBBR7 | OOBSB7    | OOBPR7  |
And logged in with details of 'OOBU7'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | OOBAR7     | OOBBR7 | OOBSB7    | OOBPR7  | OOBC7    | OOBCN7       | 20       | 10/14/2022     | HD 1080i 25fps | OOBT7 | Already Supplied   | Aastha:Standard |
And add for order that contains item with clock number 'OOBCN7' following invoicing organisation 'OOBA7_2'
When I go to Order Proceed page for order contains order item with following clock number 'OOBCN7'
Then I should see next invoicing organisation 'OOBA7_2' on order proceed page
And 'should not' see Billing on Order Proceed page

Scenario: check invoicing organisation on the Order Summary page after confirming order
Meta: @ordering
Given I created the following agency:
| Name    | A4User        | Country        | SAP ID       |
| OOBA1_1 | DefaultA4User | United Kingdom | DefaultSapID |
| OOBA1_2 | DefaultA4User | United Kingdom | DefaultSapID |
And added agency 'OOBA1_2' as a partner for agency 'OOBA1_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OOBU1 | agency.admin | OOBA1_1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OOBA1_1':
| Advertiser | Brand  | Sub Brand | Product |
| OOBAR3     | OOBBR3 | OOBSB3    | OOBPR3  |
And logged in with details of 'OOBU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | OOBAR3     | OOBBR3 | OOBSB3    | OOBPR3  | OOBC8    | OOBCN8       | 20       | 10/14/2022     | HD 1080i 25fps | OOBT8 | Already Supplied   | BSkyB Green Button:Standard |
And add for order that contains item with clock number 'OOBCN8' following invoicing organisation 'OOBA1_2'
And complete order contains item with clock number 'OOBCN8' with following fields:
| Job Number | PO Number |
| OOBJN8     | OOBPN8    |
When I go to Order Summary page for order contains item with following clock number 'OOBCN8'
Then I should see for order contains item with clock number 'OOBCN8' following summary information on order summary page:
| Order Number | Organisation | Date Submitted | Created By | Job Number | PO Number | Flag           | Market         | Invoiced Organisation |
| Dijit        | OOBA1_1      | DateSubmitted  | CreatedBy  | OOBJN8     | OOBPN8    | United Kingdom | United Kingdom | OOBA1_2               |


Scenario: check payer view billing on a live order
!--ORD-2842
Meta: @ordering
Given I created the following agency:
| Name    | A4User        | Country        | SAP ID       |
| OOBA2_1 | DefaultA4User | United Kingdom | DefaultSapID |
| OOBA2_5 | DefaultA4User | United Kingdom | BM0005       |
And added agency 'OOBA2_5' as a partner for agency 'OOBA2_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And created users with following fields:
| Email | Role         | AgencyUnique |
| OOBU4 | agency.admin | OOBA2_1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OOBA2_1':
| Advertiser | Brand  | Sub Brand | Product |
| OOBAR4     | OOBBR4 | OOBSB4    | OOBPR4  |
And logged in with details of 'OOBU4'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | OOBAR4     | OOBBR4 | OOBSB4    | OOBPR4  | OOBC4    | OOBCN9       | 20       | 10/14/2022     | HD 1080i 25fps | OOBT9 | Already Supplied   | BSkyB Green Button:Standard |
And add for order that contains item with clock number 'OOBCN9' following invoicing organisation 'OOBA2_5'
When I go to Order Proceed page for order contains order item with following clock number 'OOBCN9'
Then I should see following Billing data on Order Proceed page:
| Item                         | QTY | Unit   | TotalPerItem | Subtotal | Tax   | Total  |
| SD Standard Normal (Digital) | 1   | 50.00  | 50.00       | 50.00   | 10.50 | 60.50 |
When I completed order contains item with clock number 'OOBCN9' with following fields:
| Job Number | PO Number |
| OOBJN4     | OOBPN4   |
And wait for '5' seconds
And waited for finish place order with following item clock number 'OOBCN9' to A4
And I go to Order Summary page for order contains item with following clock number 'OOBCN9'
And I click View Billing button on the Order Summary Page
Then I should see that View 'Billing' report opens for order with clock number 'OOBCN9'
Then I should see following Billing data on View Billing page specific to clocks:
|clock         | Item                                     | QTY   | Unit   | TotalPerItem | Subtotal | Tax    | Total |
|OOBCN9        |SD Standard Normal (Digital)              | 1     | 50.00  | 50.00        | 50.00    | 10.50  | 60.50 |
