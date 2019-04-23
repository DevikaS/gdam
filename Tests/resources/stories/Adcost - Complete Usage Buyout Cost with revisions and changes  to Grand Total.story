Feature: Increase Grand total in each stage submission
Narrative:
In order to
As a CostOwner
I want to check Cost creation and completion by increasing Grand total in each stage submission


Scenario: Check cost completion for Contract cost and Celebrity type
Meta:@adcost
     @costCreationWithRevisions
     @adcostCriticalTests
     @adcostSmokeUAT
!--QA-727
Given I am on costs overview page
And created a new 'buyout' cost on AdCosts overview page
And I filled Cost Details with following fields for 'buyout' cost:
| Project Number     | New  | Approval stage for submission  | Type      | Usage/Buyout/Contract           | Cost Title  | Description  | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | Original Estimate              | Celebrity | Contract (celebrity & athletes) | CUBCRCGTCT1 | CUBCRCGTCD1  | Lily Ross (Publicis) | CUBCRCGTATN1           | Japan         | DefaultCampaign |  BFO         | USD - US Dollar         |
And filled for UsageBuyout cost on buyout usage details page with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 9000           |
And filled for UsageBuyout cost on negotiated terms page with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'CUBCRCGTCT1'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'CUBCRCGTCT1' and click continue:
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And filled below approvers for cost title 'CUBCRCGTCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'CUBCRCGTCT1'
And on cost review page of cost item with title 'CUBCRCGTCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate Local | Original Estimate |
| Usage/Residuals/Buyout Fee           | $ 10,000.00             | $ 10,000.00       |
| Base Compensation                    | $ 10,000.00             | $ 10,000.00       |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00             | $ 20,000.00       |
| Grand Total                          | $  20,000.00            | $  20,000.00      |
And I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'CUBCRCGTCT1'
And click 'Approve' button and 'Approve' on cost review page
And cost with title 'CUBCRCGTCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'CreateRevision' the cost with title 'CUBCRCGTCT1'
And I add cost item details for cost title 'CUBCRCGTCT1' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'CUBCRCGTCT1':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'CUBCRCGTCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'CUBCRCGTCT1'
And on cost review page of cost item with title 'CUBCRCGTCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Current Revision Local | Current Revision |
| Usage/Residuals/Buyout Fee           | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| Base Compensation                    | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00       | $ 30,000.00            | $ 30,000.00      |
| Grand Total                          | $  20,000.00      | $  30,000.00           | $  30,000.00     |
And I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CUBCRCGTCT1'
And cost with title 'CUBCRCGTCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'CUBCRCGTCT1'
And I add cost item details for cost title 'CUBCRCGTCT1' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 25000             | 25000                      |
And I upload following supporting documents to cost title 'CUBCRCGTCT1':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And add below approvers for cost title 'CUBCRCGTCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'CUBCRCGTCT1'
And on cost review page of cost item with title 'CUBCRCGTCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Final Actual Local | Final Actual |
| Usage/Residuals/Buyout Fee           | $ 10,000.00       | $ 25,000.00        | $ 25,000.00  |
| Base Compensation                    | $ 10,000.00       | $ 25,000.00        | $ 25,000.00  |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00       | $ 50,000.00        | $ 50,000.00  |
| Grand Total                          | $  20,000.00      | $  50,000.00       | $  50,000.00 |
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 50000.00                    | 50000.00 |


Scenario: Check complete cost completion for Buyout cost and Athletes type
Meta:@adcost
     @costCreationWithRevisions
     @adcostSmokeUAT
     @adcostSmoke
!--QA-727
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title  | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Athletes  | Buyout                | CUBCRCGTCT2 | CUBCRCGTCD2 | Lily Ross (Publicis) | CUBCRCGTATN2           | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CUBCRCGTCT2' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And added negotiated terms page for cost title 'CUBCRCGTCT2' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'CUBCRCGTCT2'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'CUBCRCGTCT2':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CUBCRCGTCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CUBCRCGTCT2'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'CUBCRCGTCT2'
And on cost review page of cost item with title 'CUBCRCGTCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate Local | Original Estimate |
| Usage/Residuals/Buyout Fee           | $ 10,000.00             | $ 10,000.00       |
| Base Compensation                    | $ 10,000.00             | $ 10,000.00       |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00             | $ 20,000.00       |
| Grand Total                          | $  20,000.00            | $  20,000.00      |
And I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CUBCRCGTCT2'
And cost with title 'CUBCRCGTCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'CreateRevision' the cost with title 'CUBCRCGTCT2'
And I add cost item details for cost title 'CUBCRCGTCT2' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'CUBCRCGTCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'CUBCRCGTCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'CUBCRCGTCT2'
And on cost review page of cost item with title 'CUBCRCGTCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Current Revision Local | Current Revision |
| Usage/Residuals/Buyout Fee           | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| Base Compensation                    | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00       | $ 30,000.00            | $ 30,000.00      |
| Grand Total                          | $  20,000.00      | $  30,000.00           | $  30,000.00     |
And I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CUBCRCGTCT2'
And cost with title 'CUBCRCGTCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'CUBCRCGTCT2'
And I add cost item details for cost title 'CUBCRCGTCT2' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 25000             | 25000                      |
And I upload following supporting documents to cost title 'CUBCRCGTCT2':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And add below approvers for cost title 'CUBCRCGTCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'CUBCRCGTCT2'
And on cost review page of cost item with title 'CUBCRCGTCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Final Actual Local | Final Actual |
| Usage/Residuals/Buyout Fee           | $ 10,000.00       | $ 25,000.00        | $ 25,000.00  |
| Base Compensation                    | $ 10,000.00       | $ 25,000.00        | $ 25,000.00  |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00       | $ 50,000.00        | $ 50,000.00  |
| Grand Total                          | $  20,000.00      | $  50,000.00       | $  50,000.00 |
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 50000.00                    | 50000.00 |


Scenario: Check cost completion within North America region for Usage cost and Celebrity type
Meta:@adcost
     @costCreationWithRevisions
!--QA-727
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title  | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Usage                 | CUBCRCGTCT3 | CUBCRCGTCD3 | Lily Ross (Publicis) | CUBCRCGTATN1           | Greater China | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CUBCRCGTCT3' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And added negotiated terms page for cost title 'CUBCRCGTCT3' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'CUBCRCGTCT3'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'CUBCRCGTCT3':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CUBCRCGTCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CUBCRCGTCT3'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'CUBCRCGTCT3'
And on cost review page of cost item with title 'CUBCRCGTCT3'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate Local | Original Estimate |
| Usage/Residuals/Buyout Fee           | $ 10,000.00             | $ 10,000.00       |
| Base Compensation                    | $ 10,000.00             | $ 10,000.00       |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00             | $ 20,000.00       |
| Grand Total                          | $  20,000.00            | $  20,000.00      |
And I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CUBCRCGTCT3'
And cost with title 'CUBCRCGTCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'CreateRevision' the cost with title 'CUBCRCGTCT3'
And I add cost item details for cost title 'CUBCRCGTCT3' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'CUBCRCGTCT3':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'CUBCRCGTCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'CUBCRCGTCT3'
And on cost review page of cost item with title 'CUBCRCGTCT3'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Current Revision Local | Current Revision |
| Usage/Residuals/Buyout Fee           | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| Base Compensation                    | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00       | $ 30,000.00            | $ 30,000.00      |
| Grand Total                          | $  20,000.00      | $  30,000.00           | $  30,000.00     |
And I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CUBCRCGTCT3'
And cost with title 'CUBCRCGTCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'CUBCRCGTCT3'
And I add cost item details for cost title 'CUBCRCGTCT3' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 25000             | 25000                      |
And I upload following supporting documents to cost title 'CUBCRCGTCT3':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And add below approvers for cost title 'CUBCRCGTCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'CUBCRCGTCT3'
And on cost review page of cost item with title 'CUBCRCGTCT3'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Final Actual Local | Final Actual |
| Usage/Residuals/Buyout Fee           | $ 10,000.00       | $ 25,000.00        | $ 25,000.00  |
| Base Compensation                    | $ 10,000.00       | $ 25,000.00        | $ 25,000.00  |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00       | $ 50,000.00        | $ 50,000.00  |
| Grand Total                          | $  20,000.00      | $  50,000.00       | $  50,000.00 |
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 50000.00                    | 50000.00 |


Scenario: Check cost completion in Final Actual stage for Usage cost and Celebrity type
Meta:@adcost
     @costCreationWithRevisions
!--QA-727
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title  | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | FinalActual                   | Celebrity | Usage                 | CUBCRCGTCT4 | CUBCRCGTCD4 | Lily Ross (Publicis) | CUBCRCGTATN1           | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CUBCRCGTCT4' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And added negotiated terms page for cost title 'CUBCRCGTCT4' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'CUBCRCGTCT4'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 25000             | 25000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'CUBCRCGTCT4':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CUBCRCGTCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CUBCRCGTCT4'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Final Actual' for cost title 'CUBCRCGTCT4'
And on cost review page of cost item with title 'CUBCRCGTCT4'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Final Actual Local | Final Actual |
| Usage/Residuals/Buyout Fee           | $ 25,000.00        | $ 25,000.00  |
| Base Compensation                    | $ 25,000.00        | $ 25,000.00  |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 50,000.00        | $ 50,000.00  |
| Grand Total                          | $  50,000.00       | $  50,000.00 |
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Final Actual payment amount | PO Total |
| Final Actual | 50000.00                    | 50000.00 |