Feature: Billing Table
Narrative:
In order to
As a CycloneCostOwner
I want to check Billing table 


Scenario: Check that contract months are not editable for previous fiscal years
Meta:@adcost
     @adcostCycloneCosts
!--QA-749
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number            | New  | Approval stage for submission | Type     | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | true | OriginalEstimate              | Athletes | Contract (celebrity & athletes) | BTCT1      | BTCD1       | Aaron Royer (Grey)  | BTATN1                 | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
When I add UsageBuyout details for cost title 'BTCT1' with following fields:
| Name     | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | India            | not for air | yes, if yes specify category | 05/05/2017 | 05/05/2019 | Exclusivity Category 1 | 300000         |
And I am on cost items page of cost title 'BTCT1'
Then I 'should' see below fields in numberOfMonthsInContractTermPerFY in BillingExpensingTermsPerFinancialYear table:
| 2016/2017    | 2017/2018     | 2018/2019 |
| Not Editable | Not Editable  | Editable  |


Scenario: Check that billing table unavailable for Athletes and Contract type for non cyclone agency
Meta:@adcost
     @adcostCycloneCosts
!--QA-749
Given I logged in as 'CostOwner'
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type     | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Athletes | Contract (celebrity & athletes) | BTCT2      | BTCD2       | Aaron Royer (Grey)  | BTATN2                 | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
When I add UsageBuyout details for cost title 'BTCT2' with following fields:
| Name     | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | India            | not for air | yes, if yes specify category | 05/05/2017 | 05/05/2019 | Exclusivity Category 1 | 300000         |
And I am on cost items page of cost title 'BTCT2'
Then I 'should not' see billing table on cost items page


Scenario: Check that billing table unavailable for Athletes and Buyout type even though its cyclone agency
Meta:@adcost
     @adcostCycloneCosts
!--QA-749
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number            | New  | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | true | OriginalEstimate              | Athletes | Buyout                | BTCT3      | BTCD3       | Aaron Royer (Grey)  | BTATN3                 | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
When I add UsageBuyout details for cost title 'BTCT3' with following fields:
| Name     | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | India            | not for air | yes, if yes specify category | 05/05/2017 | 05/05/2019 | Exclusivity Category 1 | 300000         |
And I am on cost items page of cost title 'BTCT3'
Then I 'should not' see billing table on cost items page


Scenario: Check that billing table available only for North America region for cyclone agency
Meta:@adcost
     @adcostCycloneCosts
!--QA-749
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number            | New  | Approval stage for submission | Type     | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | true | OriginalEstimate              | Athletes | Contract (celebrity & athletes) | BTCT4      | BTCD4       | Aaron Royer (Grey)  | BTATN4                 | Greater China | DefaultCampaign |  BFO         | USD - US Dollar         |
When I add UsageBuyout details for cost title 'BTCT4' with following fields:
| Name     | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | India            | not for air | yes, if yes specify category | 05/05/2017 | 05/05/2019 | Exclusivity Category 1 | 300000         |
And I am on cost items page of cost title 'BTCT4'
Then I 'should not' see billing table on cost items page


Scenario: Check that values added to the billing table are auto mapped to the cost line items
Meta:@adcost
     @adcostCycloneCosts
     @@adcostSmoke
!--QA-749
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number            | New  | Approval stage for submission | Type      | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | true | OriginalEstimate              | Celebrity | Contract (celebrity & athletes) | BTCT5      | BTCD5       | Aaron Royer (Grey)  | BTATN5                 | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
And I added UsageBuyout details for cost title 'BTCT5' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 01/01/2019 | 12/12/2020 | Exclusivity Category 1 | 300000         |
And I am on cost items page of cost title 'BTCT5'
When I update billing table with below data for cost title 'BTCT5':
| Item description                                       | 2018/2019 | 2019/2020 | 2020/2021 |
| Base Compensation                                      | 1,000     | 0         | 0         |
| Pension & Health                                       | 2,000     | 0         | 0         |
| Bonus                                                  | 3,000     | 0         | 0         |
| Agency fee (PRE or other)                              | 4,000     | 0         | 0         |
| Other incurred costs (including non-reclaimable taxes) | 5,000     | 0         | 0         |
Then I 'should' see billing table updated as below for cost title 'BTCT5':
| Item description                                       | 2018/2019   | 2019/2020    | 2020/2021    | Total        |
| BALANCE FROM PRIOR FY/PREPAID                          | $0.00       | $-72,000.00  | $-222,000.00 | $-294,000.00 |
| Total billing for contract terms                       | $3,000.00   | $0.00        | $0.00        | $3,000.00    |
| Total billing for incurred costs, bonuses, etc.        | $12,000.00  | $0.00        | $0.00        | $12,000.00   |
| Total billing for contract terms & bonuses, etc.       | $15,000.00  | $0.00        | $0.00        | $15,000.00   |
| Expense per FY                                         | $87,000.00  | $150,000.00  | $75,000.00   | $312,000.00  |
| Balance to be moved to prepaid                         | $-72,000.00 | $-222,000.00 | $-297,000.00 | $-591,000.00 |
And 'should' following data for 'local' currency in Cost items section for cost title 'BTCT5:
| Item description              | Original Estimate local ($ - USD) |
| Negotiation/broker agency fee | $4,000.00                         |
| Other services & fees         | $5,000.00                         |
| Bonus (celebrity only)        | $3,000.00                         |
| Base Compensation             | $1,000.00                         |
| Pension & Health (e.g. SAG)   | $2,000.00                         |
And 'should' following data for 'default' currency in Cost items section for cost title 'BTCT5:
| Item description              | Original Estimate local ($ - USD) |
| Usage/Residuals/Buyout Fee    | $ 0.00                            |
| Negotiation/broker agency fee | $ 4,000.00                        |
| Other services & fees         | $ 5,000.00                        |
| Bonus (celebrity only)        | $ 3,000.00                        |
| Base Compensation             | $ 1,000.00                        |
| Pension & Health (e.g. SAG)   | $ 2,000.00                        |
And 'should' see following fields in Cost items section for cost title 'BTCT5:
| FieldName                     | State    |
| Usage/Residuals/Buyout Fee    | Enabled  |
| Negotiation/broker agency fee | Disabled |
| Other services & fees         | Disabled |
| Bonus (celebrity only)        | Disabled |
| Base Compensation             | Disabled |
| Pension & Health (e.g. SAG)   | Disabled |


Scenario: Check billing table shows fiscal years with budget split for Celebrity and Contract
Meta:@adcost
     @adcostCycloneCosts
!--QA-749
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number            | New  | Approval stage for submission | Type      | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | true | OriginalEstimate              | Celebrity | Contract (celebrity & athletes) | BTCT6      | BTCD6       | Aaron Royer (Grey)  | BTATN6                 | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
When I add UsageBuyout details for cost title 'BTCT6' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 01/01/2019 | 12/12/2020 | Exclusivity Category 1 | 300000         |
And add negotiated terms page for cost title 'BTCT6' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'BTCT6'
Then I 'should' see billing table updated as below for cost title 'BTCT6':
| Item description                                 | 2018/2019   | 2019/2020    | 2020/2021    | Total        |
| BALANCE FROM PRIOR FY/PREPAID                    | $0.00       | $-75,000.00  | $-225,000.00 | $-300,000.00 |
| Total billing for contract terms                 | $0.00       | $0.00        | $0.00        | $0.00        |
| Total billing for incurred costs, bonuses, etc.  | $0.00       | $0.00        | $0.00        | $0.00        |
| Total billing for contract terms & bonuses, etc. | $0.00       | $0.00        | $0.00        | $0.00        |
| Expense per FY                                   | $75,000.00  | $150,000.00  | $75,000.00   | $300,000.00  |
| Balance to be moved to prepaid                   | $-75,000.00 | $-225,000.00 | $-300,000.00 | $-600,000.00 |
And 'should' see below numberOfMonthsInContractTermPerFY in BillingExpensingTermsPerFinancialYear table for cost title 'BTCT6':
| Item description                      | 2018/2019 | 2019/2020 | 2020/2021 | Total |
| No. of months in contract term per FY | 6         | 12        | 6         | 24.00 |
When I update billing table with below data for cost title 'BTCT6':
| Item description  | 2018/2019 | 2019/2020 | 2020/2021 |
| Base Compensation | 10,000    | 0         | 0         |
| Pension & Health  | 10,000    | 0         | 0         |
Then I 'should' see billing table updated as below for cost title 'BTCT6':
| Item description                                 | 2018/2019   | 2019/2020    | 2020/2021    | Total        |
| BALANCE FROM PRIOR FY/PREPAID                    | $0.00       | $-55,000.00  | $-205,000.00 | $-260,000.00 |
| Total billing for contract terms                 | $20,000.00  | $0.00        | $0.00        | $20,000.00   |
| Total billing for incurred costs, bonuses, etc.  | $0.00       | $0.00        | $0.00        | $0.00        |
| Total billing for contract terms & bonuses, etc. | $20,000.00  | $0.00        | $0.00        | $20,000.00   |
| Expense per FY                                   | $75,000.00  | $150,000.00  | $75,000.00   | $300,000.00  |
| Balance to be moved to prepaid                   | $-55,000.00 | $-205,000.00 | $-280,000.00 | $-540,000.00 |
And 'should' following data for 'local' currency in Cost items section for cost title 'BTCT6:
| Item description            | Original Estimate local ($ - USD) |
| Base Compensation           | $10,000.00                        |
| Pension & Health (e.g. SAG) | $10,000.00                        |
And 'should' following data for 'default' currency in Cost items section for cost title 'BTCT6:
| Item description            | Original Estimate default ($ - USD) |
| Base Compensation           | $ 10,000.00                         |
| Pension & Health (e.g. SAG) | $ 10,000.00                         |
And 'should' see following fields in Cost items section for cost title 'BTCT6:
| FieldName                   | State    |
| Base Compensation           | Disabled |
| Pension & Health (e.g. SAG) | Disabled |
When I update numberOfMonthsInContractTermPerFY in BillingExpensingTermsPerFinancialYear table for cost title 'BTCT6':
| Item description                      | 2018/2019 | 2019/2020 | 2020/2021 |
| No. of months in contract term per FY | 7         | 10        | 7         |
Then I 'should' see billing table updated as below for cost title 'BTCT6':
| Item description                                 | 2018/2019   | 2019/2020    | 2020/2021    | Total         |
| BALANCE FROM PRIOR FY/PREPAID                    | $0.00       | $-67,500.00  | $-192,500.00 | $-260,000.00  |
| Total billing for contract terms                 | $20,000.00  | $0.00        | $0.00        | $20,000.00    |
| Total billing for incurred costs, bonuses, etc.  | $0.00       | $0.00        | $0.00        | $0.00         |
| Total billing for contract terms & bonuses, etc. | $20,000.00  | $0.00        | $0.00        | $20,000.00    |
| Expense per FY                                   | $87,500.00  | $125,000.00  | $87,500.00   | $300,000.00   |
| Balance to be moved to prepaid                   | $-67,500.00 | $-192,500.00 | $-280,000.00 | $-540,000.00  |
When I fill Cost Line Items with following fields:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I upload following supporting documents to cost title 'BTCT6':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And add below approvers for cost title 'BTCT6':
| Brand Management Approver |
| BrandManagementApprover   |
And 'Submit' the cost with title 'BTCT6'
And on cost review page of cost item with title 'BTCT6'
Then I 'should' see following data in billing table on Cost Review page for cost title 'BTCT6':
| Item description                                       | 2018/2019   | 2019/2020    | 2020/2021    | Total        |
| BALANCE FROM PRIOR FY/PREPAID                          | $0.00       | $-67,500.00  | $-192,500.00 | $-260,000.00 |
| No. of months in contract term per FY                  | 7.00        | 10.00        | 7.00         | 24.00        |
| Base Compensation                                      | $10,000.00  | $0.00        | $0.00        | $10,000.00   |
| Pension & Health                                       | $10,000.00  | $0.00        | $0.00        | $10,000.00   |
| Total billing for contract terms                       | $20,000.00  | $0.00        | $0.00        | $20,000.00   |
| Bonus                                                  | $0.00       | $0.00        | $0.00        | $0.00        |
| Agency fee (PRE or other)                              | $0.00       | $0.00        | $0.00        | $0.00        |
| Other incurred costs (including non-reclaimable taxes) | $0.00       | $0.00        | $0.00        | $0.00        |
| Total billing for incurred costs, bonuses, etc.        | $0.00       | $0.00        | $0.00        | $0.00        |
| Total billing for contract terms & bonuses, etc.       | $20,000.00  | $0.00        | $0.00        | $20,000.00   |
| Expense per FY                                         | $87,500.00  | $125,000.00  | $87,500.00   | $300,000.00  |
| Balance to be moved to prepaid                         | $-67,500.00 | $-192,500.00 | $-280,000.00 | $-540,000.00 |
And should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate Local ($ - USD) | Original Estimate ($ - USD) |
| Base Compensation                    | $ 10,000.00                       | $ 10,000.00                 |
| Pension & Health (e.g. SAG)          | $ 10,000.00                       | $ 10,000.00                 |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00                       | $ 20,000.00                 |
| Grand Total                          | $  20,000.00                      | $  20,000.00                |


Scenario: Check that cost can be submitted with no end date or perpetuity
Meta:@adcost
     @abug
!--QA-1102, ADC-2834
Given I am on costs overview page
And created a new 'buyout' cost on AdCosts overview page
And I filled Cost Details with following fields for 'buyout' cost:
| Project Number     | New  | Approval stage for submission  | Type      | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | Original Estimate              | Celebrity | Contract (celebrity & athletes) | BTCT7      | BTCD7       | Lily Ross (Publicis) | BTATN7                 | Japan         | DefaultCampaign |  BFO         | USD - US Dollar         |
And filled for UsageBuyout cost on buyout usage details page with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | No End date/Perpetuity | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | check                  | Exclusivity Category 1 | 9000           |
And I clicked 'Previous' button on Adcost form page
Then I 'should' see fields in following state:
| End Date | Contract Period (In Months) |
| disabled | ng-empty                    |
When I click 'Continue' button on Adcost form page
And fill for UsageBuyout cost on negotiated terms page with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'BTCT7'
And I fill Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I upload following supporting documents to cost title 'BTCT7' and click continue:
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And fill below approvers for cost title 'BTCT7':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I click 'Submit' button and 'Send for approval' on approval Page
Then I 'should' see following data for 'BTCT7' cost item on Adcost overview page:
| Cost Stage        | Cost Status         | Approver  |
| Original Estimate | Pending Approval by | IPMuser   |