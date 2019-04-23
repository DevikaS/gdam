Feature: Increase Grand total in each stage submission
Narrative:
In order to
As a CycloneCostOwner
I want to check Cost creation and completion by increasing Grand total in each stage submission

Scenario: Check Cyclone cost completion within North America region for Contract cost and Celebrity type
Meta:@adcost
     @costCreationWithRevisions
     @adcostSmokeUAT
     @adcostCycloneCosts
     @adcostSmoke
!--QA-746
Given I am on costs overview page
And created a new 'buyout' cost on AdCosts overview page
And I filled Cost Details with following fields for 'buyout' cost:
| Project Number            | New  | Approval stage for submission  | Type      | Usage/Buyout/Contract           | Cost Title  | Description  | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | true | Original Estimate              | Celebrity | Contract (celebrity & athletes) | CCUBCNARCT1 | CCUBCNARCD1  | Aaron Royer (Grey)   | CCUBCNARATN1           | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
And filled for UsageBuyout cost on buyout usage details page with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 9000           |
And filled for UsageBuyout cost on negotiated terms page with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And filled Cost Line Items with following fields for cost title 'CCUBCNARCT1':
| Base Compensation | Usage/Residuals/Buyout Fee | FX (Loss) & Gain |
| 10000             | 10000                      | -4000            |
And I uploaded following supporting documents to cost title 'CCUBCNARCT1' and click continue:
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CCUBCNARCT1':
| Brand Management Approver |
| BrandManagementApprover   |
And refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'CCUBCNARCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate Local | Original Estimate |
| Usage/Residuals/Buyout Fee           | $ 10,000.00             | $ 10,000.00       |
| Base Compensation                    | $ 10,000.00             | $ 10,000.00       |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00             | $ 20,000.00       |
| FX (Loss) & Gain                     | $ -4,000.00             | $ -4,000.00       |
| SUBTOTAL OTHER COSTS                 | $ -4,000.00             | $ -4,000.00       |
| Grand Total                          | $  16,000.00            | $  16,000.00      |
When I login with details of 'BrandManagementApprover'
And I am on cost review page of cost item with title 'CCUBCNARCT1'
And click 'Approve' button and 'Approve' on cost review page
And I login with details of 'CycloneCostOwner'
And 'CreateRevision' the cost with title 'CCUBCNARCT1'
And I fill Cost Line Items with following fields for cost title 'CCUBCNARCT1':
| Base Compensation | Usage/Residuals/Buyout Fee | FX (Loss) & Gain |
| 15000             | 15000                      | -4000            |
And I upload following supporting documents to cost title 'CCUBCNARCT1' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Scope change approval form         |
And I refresh the page without delay
And I 'Submit' the cost with title 'CCUBCNARCT1'
And on cost review page of cost item with title 'CCUBCNARCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Current Revision Local | Current Revision |
| Usage/Residuals/Buyout Fee           | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| Base Compensation                    | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00       | $ 30,000.00            | $ 30,000.00      |
| FX (Loss) & Gain                     | $ -4,000.00       | $ -4,000.00            | $ -4,000.00      |
| SUBTOTAL OTHER COSTS                 | $ -4,000.00       | $ -4,000.00            | $ -4,000.00      |
| Grand Total                          | $  16,000.00      | $  26,000.00           | $  26,000.00     |
When I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCUBCNARCT1'
And I login with details of 'CycloneCostOwner'
And 'NextStage' the cost with title 'CCUBCNARCT1'
And I fill Cost Line Items with following fields for cost title 'CCUBCNARCT1':
| Base Compensation | Usage/Residuals/Buyout Fee | FX (Loss) & Gain |
| 25000             | 25000                      | 2000             |
And I upload following supporting documents to cost title 'CCUBCNARCT1' and click continue:
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And I refresh the page without delay
And 'Submit' the cost with title 'CCUBCNARCT1'
And on cost review page of cost item with title 'CCUBCNARCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Final Actual Local | Final Actual |
| Usage/Residuals/Buyout Fee           | $ 10,000.00       | $ 25,000.00        | $ 25,000.00  |
| Base Compensation                    | $ 10,000.00       | $ 25,000.00        | $ 25,000.00  |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00       | $ 50,000.00        | $ 50,000.00  |
| FX (Loss) & Gain                     | $ -4,000.00       | $ 2,000.00         | $ 2,000.00   |
| SUBTOTAL OTHER COSTS                 | $ -4,000.00       | $ 2,000.00         | $ 2,000.00   |
| Grand Total                          | $  16,000.00      | $  52,000.00       | $  52,000.00 |


Scenario: Check Cyclone cost completion within North America region for Buyout cost and Athletes type
Meta:@adcost
     @costCreationWithRevisions
     @adcostCycloneCosts
!--QA-746
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number           | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title  | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject| true | OriginalEstimate              | Athletes  | Buyout                | CCUBCNARCT2 | CCUBCNARCD1 | Aaron Royer (Grey)  | CCUBCNARATN2           | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CCUBCNARCT2' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And added negotiated terms page for cost title 'CCUBCNARCT2' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And filled Cost Line Items with following fields for cost title 'CCUBCNARCT2':
| Base Compensation | Usage/Residuals/Buyout Fee |
| 10000             | 10000                      |
And I uploaded following supporting documents to cost title 'CCUBCNARCT2':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CCUBCNARCT2':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CCUBCNARCT2'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'CCUBCNARCT2'
And on cost review page of cost item with title 'CCUBCNARCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate Local  | Original Estimate |
| Usage/Residuals/Buyout Fee           | $ 10,000.00              | $ 10,000.00       |
| Base Compensation                    | $ 10,000.00              | $ 10,000.00       |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00              | $ 20,000.00       |
| Grand Total                          | $  20,000.00             | $  20,000.00      |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCUBCNARCT2'
When I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCUBCNARCT2'
And I login with details of 'CycloneCostOwner'
And 'CreateRevision' the cost with title 'CCUBCNARCT2'
And I add cost item details for cost title 'CCUBCNARCT2' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'CCUBCNARCT2':
| FileName            | FormName                           |
| /files/EditWord.doc | Scope change approval form         |
And I 'Submit' the cost with title 'CCUBCNARCT2'
And on cost review page of cost item with title 'CCUBCNARCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Current Revision Local | Current Revision |
| Usage/Residuals/Buyout Fee           | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| Base Compensation                    | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00       | $ 30,000.00            | $ 30,000.00      |
| Grand Total                          | $  20,000.00      | $  30,000.00           | $  30,000.00     |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCUBCNARCT2'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCUBCNARCT2'
And I login with details of 'CycloneCostOwner'
And 'NextStage' the cost with title 'CCUBCNARCT2'
And I add cost item details for cost title 'CCUBCNARCT2' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 25000             | 25000                      |
And I upload following supporting documents to cost title 'CCUBCNARCT2':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And 'Submit' the cost with title 'CCUBCNARCT2'
And on cost review page of cost item with title 'CCUBCNARCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Final Actual Local | Final Actual |
| Usage/Residuals/Buyout Fee           | $ 10,000.00       | $ 25,000.00        | $ 25,000.00  |
| Base Compensation                    | $ 10,000.00       | $ 25,000.00        | $ 25,000.00  |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00       | $ 50,000.00        | $ 50,000.00  |
| Grand Total                          | $  20,000.00      | $  50,000.00       | $  50,000.00 |


Scenario: Check Cyclone cost completion within North America region for Usage cost and Celebrity type
Meta:@adcost
     @costCreationWithRevisions
     @adcostCycloneCosts
!--QA-746
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number            | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title  | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | true | OriginalEstimate              | Celebrity | Usage                 | CCUBCNARCT3 | CCUBCNARCD1 | Aaron Royer (Grey)  | CCUBCNARATN1           | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CCUBCNARCT3' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And added negotiated terms page for cost title 'CCUBCNARCT3' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And filled Cost Line Items with following fields for cost title 'CCUBCNARCT3':
| Base Compensation | Usage/Residuals/Buyout Fee |
| 10000             | 10000                      |
And I uploaded following supporting documents to cost title 'CCUBCNARCT3':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CCUBCNARCT3':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CCUBCNARCT3'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'CCUBCNARCT3'
And on cost review page of cost item with title 'CCUBCNARCT3'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate Local | Original Estimate |
| Usage/Residuals/Buyout Fee           | $ 10,000.00             | $ 10,000.00       |
| Base Compensation                    | $ 10,000.00             | $ 10,000.00       |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00             | $ 20,000.00       |
| Grand Total                          | $  20,000.00            | $  20,000.00      |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCUBCNARCT3'
When I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCUBCNARCT3'
And I login with details of 'CycloneCostOwner'
And 'CreateRevision' the cost with title 'CCUBCNARCT3'
And I add cost item details for cost title 'CCUBCNARCT3' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'CCUBCNARCT3':
| FileName            | FormName                           |
| /files/EditWord.doc | Scope change approval form         |
And I 'Submit' the cost with title 'CCUBCNARCT3'
And on cost review page of cost item with title 'CCUBCNARCT3'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Current Revision Local | Current Revision |
| Usage/Residuals/Buyout Fee           | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| Base Compensation                    | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00       | $ 30,000.00            | $ 30,000.00      |
| Grand Total                          | $  20,000.00      | $  30,000.00           | $  30,000.00     |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCUBCNARCT3'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCUBCNARCT3'
And I login with details of 'CycloneCostOwner'
And 'NextStage' the cost with title 'CCUBCNARCT3'
And I add cost item details for cost title 'CCUBCNARCT3' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 25000             | 25000                      |
And I upload following supporting documents to cost title 'CCUBCNARCT3':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And 'Submit' the cost with title 'CCUBCNARCT3'
And on cost review page of cost item with title 'CCUBCNARCT3'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Final Actual Local | Final Actual |
| Usage/Residuals/Buyout Fee           | $ 10,000.00       | $ 25,000.00        | $ 25,000.00  |
| Base Compensation                    | $ 10,000.00       | $ 25,000.00        | $ 25,000.00  |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00       | $ 50,000.00        | $ 50,000.00  |
| Grand Total                          | $  20,000.00      | $  50,000.00       | $  50,000.00 |