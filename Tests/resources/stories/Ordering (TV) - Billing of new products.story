!--ORD-2897
!--ORD-2979
!--ORD-2980
!--ORD-2981
!--ORD-3262
Feature: Billing of new products
Narrative:
In order to:
As a AgencyAdmin
I want to check billing of new products

Scenario: Service Subtitling
Meta: @ordering
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I created the following agency:
| Name  | A4User        | Country        | SAP ID       |
| BNPA1 | DefaultA4User | United Kingdom | DefaultSapID |
And created users with following fields:
| Email | Role         | AgencyUnique |
| BNPU1 | agency.admin | BNPA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'BNPA1':
| Advertiser | Brand  | Sub Brand | Product |
| BNPAR1     | BNPBR1 | BNPSB1    | BNPPR1  |
And logged in with details of 'BNPU1'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                 |
| automated test info    | BNPAR1     | BNPBR1 | BNPSB1    | BNPPR1  | BNPC1    | BNPCN1       | 20       | 10/14/2022     | HD 1080i 25fps | BNPT1 | BTI Studios        | BSkyB Green Button:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'BNPCN1'
Then I should see following Billing data on Order Proceed page:
| Item                               | QTY | Unit    | TotalPerItem | Subtotal | Tax    | Total   |
| SD Standard Normal (Digital)       | 1   | 100.00 | 100.00      | 142.00  | 29.82 | 171.82 |
| Subtitling: Standard (BTI Studios) | 1   | 42.00  | 42.00       | 142.00  | 29.82 | 171.82 |

Scenario: Service Additional Service
Meta: @ordering
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I created the following agency:
| Name  | A4User        | Country        | SAP ID       |
| BNPA1 | DefaultA4User | United Kingdom | DefaultSapID |
And created users with following fields:
| Email | Role         | AgencyUnique |
| BNPU1 | agency.admin | BNPA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'BNPA1':
| Advertiser | Brand  | Sub Brand | Product |
| BNPAR1     | BNPBR1 | BNPSB1    | BNPPR1  |
And logged in with details of 'BNPU1'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination                  |
| automated test info    | BNPAR1     | BNPBR1 | BNPSB1    | BNPPR1  | BNPC2    | BNPCN2       | 20       | 10/14/2022     | HD 1080i 25fps | BNPT2 | Adtext SD          | New Station - UK HD:Standard |
And create additional destinations with following fields:
| Type     | Destination Name | Contact Name | Contact Details | Street Address | City  | Post Code | Country |
| Physical | BNPDN2           | BNPCnN2      | BNPCD2          | BNPSA2         | BNPC2 | BNPPC2    | BNPC2   |
And create for 'tv' order with item clock number 'BNPCN2' additional services with following fields:
| Type     | Destination | Format     | Specification  | Media Compile | No copies  | Delivery Details                                | Notes & Labels        | Express |
| Data DVD | BNPDN2      | Avid DNxHD | HD 1080i 25fps | Compile 1     | 1          | BNPDN2 BNPCnN2 BNPCD2 BNPSA2 BNPC2 BNPPC2 BNPC2 | automated test notes  | should  |
When I go to Order Proceed page for order contains order item with following clock number 'BNPCN2'
Then I should see following Billing data on Order Proceed page:
| Item                                         | QTY | Unit   | TotalPerItem | Subtotal | Tax    | Total   |
| HD Standard Normal (Digital)                 | 1   | 80.00  | 80.00        | 154.00   | 32.34  | 186.34  |
| Subtitling: Standard (Adtext)                | 1   | 41.00  | 41.00        | 154.00   | 32.34  | 186.34  |
| Dubbing Service: Data DVD - Express Domestic | 1   | 33.00  | 33.00        | 154.00   | 32.34  | 186.34  |

Scenario: Service Auto-Conversion
Meta: @ordering
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I created the following agency:
| Name  | A4User        | Country        | SAP ID       |
| BNPA1 | DefaultA4User | United Kingdom | DefaultSapID |
And created users with following fields:
| Email | Role         | AgencyUnique |
| BNPU1 | agency.admin | BNPA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'BNPA1':
| Advertiser | Brand  | Sub Brand | Product |
| BNPAR1     | BNPBR1 | BNPSB1    | BNPPR1  |
And logged in with details of 'BNPU1'
And 'enable' Billing Service
And create 'tv' order with market 'India' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Destination         |
| automated test info    | BNPAR1     | BNPBR1 | BNPSB1    | BNPPR1  | BNPC3_1  | BNPCN3_1     | 20       | 10/14/2022     | HD 1080i 25fps | BNPT3_1 | Tatasky HD:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number | Subtitles Required | Destination                 |
| BNPCN3_2     | Adtext             | BSkyB Green Button:Standard |
And complete order contains item with clock number 'BNPCN3_1' with following fields:
| Job Number | PO Number |
| BNPJN3     | BNPPN3    |
And waited for '5' seconds
And add to 'tv' order item with clock number 'BNPCN3_2' following qc asset 'BNPT3_1' of collection 'My Assets'
And I am on Order Proceed page for order with market 'United Kingdom' and item with following clock number 'BNPCN3_1'
And waited for '1' seconds
When I fill following fields on Order Proceed page:
| Manage Format Conversions |
| should                    |
Then I should see following Billing data on Order Proceed page:
| Item                          | QTY | Unit    | TotalPerItem | Subtotal | Tax    | Total   |
| SD Standard Normal (Digital)  | 1   | 100.00 | 100.00      | 166.00  | 34.86 | 200.86 |
| Auto-conversion               | 1   | 66.00  | 66.00       | 166.00  | 34.86 | 200.86 |

Scenario: Service Archive
Meta: @ordering
      @billingSkip
!--As discussed with David we will not be testing SAP Price Models anymore as its done by SAP Team and we will just test the integration
Given I created the following agency:
| Name  | A4User        | Country        | SAP ID       |Save In Library |Allow To Save In Library|
| BNPA4 | DefaultA4User | United Kingdom | DefaultSapID |should          |should                  |
And created users with following fields:
| Email | Role         | AgencyUnique |
| BNPU4 | agency.admin | BNPA4        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'BNPA4':
| Advertiser | Brand  | Sub Brand | Product |
| BNPAR1     | BNPBR1 | BNPSB1    | BNPPR1  |
And logged in with details of 'BNPU4'
And 'enable' Billing Service
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Campaign | Clock Number | Duration | First Air Date | Format         | Title | Subtitles Required | Destination  |
| automated test info    | BNPAR1     | BNPBR1 | BNPSB1    | BNPPR1  | BNPC4    | BNPCN4       | 20       | 10/14/2022     | HD 1080i 25fps | BNPT4 | Adtext SD          | SAB:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'BNPCN4'
And wait for '3' seconds
And 'check' checkbox Archive for following clock number 'BNPCN4' of QC View summary on Order Proceed page
Then I should see following Billing data on Order Proceed page:
| Item                          | QTY | Unit    | TotalPerItem | Subtotal | Tax    | Total   |
| SD Standard Normal (Digital)  | 1   | 100.00 | 100.00      | 291.00  | 61.11 | 352.11 |
| Subtitling: Standard (Adtext) | 1   | 41.00  | 41.00       | 291.00  | 61.11 | 352.11 |
| Adbank - Standard             | 1   | 150.00 | 150.00      | 291.00  | 61.11 | 352.11 |