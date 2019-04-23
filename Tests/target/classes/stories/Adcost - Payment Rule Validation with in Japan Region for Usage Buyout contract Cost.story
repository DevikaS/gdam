Feature: Payment Rules in Cost module
Narrative:
In order to
As a CostOwner
I want to check Payments split for Usage Buyout cost within Japan region


Scenario: Check payment split for cost greater than zero within Japan region for Contract cost and Celebrity type
Meta:@adcost
     @paymentRules
!--QA-707, rule no-143
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Contract (celebrity & athletes) | PRVJRUCCT1 | PRVJRUCCD1  | Aaron Royer (Grey)  | PRVJRUCATN1            | Japan         | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'PRVJRUCCT1' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 40000          |
And added negotiated terms page for cost title 'PRVJRUCCT1' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'PRVJRUCCT1'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee |  Please enter a 10-digit IO number |
| 10000             | 10000                      |  1234567890                        |
And I uploaded following supporting documents to cost title 'PRVJRUCCT1':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVJRUCCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVJRUCCT1'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'PRVJRUCCT1'
And on cost review page of cost item with title 'PRVJRUCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVJRUCCT1'
Then should see AMQ receives below request for cost title 'PRVJRUCCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description | Basket Name      |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand | PRVJRUCCD1   | brandDescription |
When cost with title 'PRVJRUCCT1' is 'Approve' on behalf of MyPurchases application
And wait until cost status is 'Approved' and cost stage is 'Original Estimate' for cost title 'PRVJRUCCT1'
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'PRVJRUCCT1'
And I add cost item details for cost title 'PRVJRUCCT1' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'PRVJRUCCT1':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And add below approvers for cost title 'PRVJRUCCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'PRVJRUCCT1'
And on cost review page of cost item with title 'PRVJRUCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVJRUCCT1'
And cost with title 'PRVJRUCCT1' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVJRUCCT1' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name      |
| 30000        | 30000          | USD      | 1234567890 | DefaultBrand  |PRVJRUCCD1   | brandDescription |


Scenario: Check payment split for cost greater than zero within Japan region for Usage cost and Athletes type
Meta:@adcost
     @paymentRules
     @adcostCriticalTests
     @adcostSmokeUAT
     @GLMGCcodes
!--QA-707, rule no-143, QA-812
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Athletes | Usage                 | PRVJRUCCT2 | PRVJRUCCD2  | Aaron Royer (Grey)  | PRVJRUCATN2            | Japan         | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'PRVJRUCCT2' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 30000          |
And added negotiated terms page for cost title 'PRVJRUCCT2' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'PRVJRUCCT2'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee |  Please enter a 10-digit IO number |
| 10000             | 10000                      |  1234567890                        |
And I uploaded following supporting documents to cost title 'PRVJRUCCT2':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVJRUCCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVJRUCCT2'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'PRVJRUCCT2'
And on cost review page of cost item with title 'PRVJRUCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'PRVJRUCCT2'
Then should see AMQ receives below request for cost title 'PRVJRUCCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description | Basket Name      | CategoryId | Gl       |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand  | PRVJRUCCD2  | brandDescription | S80141903  | 33500003 |
When cost with title 'PRVJRUCCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'PRVJRUCCT2'
And I add cost item details for cost title 'PRVJRUCCT2' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'PRVJRUCCT2':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And add below approvers for cost title 'PRVJRUCCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'PRVJRUCCT2'
And on cost review page of cost item with title 'PRVJRUCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVJRUCCT2'
And cost with title 'PRVJRUCCT2' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVJRUCCT2' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name     |
| 30000        | 30000          | USD      | 1234567890 | DefaultBrand  |PRVJRUCCD2  | brandDescription |


Scenario: Check payment split for cost greater than zero within Japan region for Buyout cost and Celebrity type
Meta:@adcost
     @paymentRules
     @GLMGCcodes
     @adcostSmoke
!--QA-707, rule no-143, QA-812
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Buyout                | PRVJRUCCT3 | PRVJRUCCD3  | Aaron Royer (Grey)  | PRVJRUCATN3            | Japan         | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'PRVJRUCCT3' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And added negotiated terms page for cost title 'PRVJRUCCT3' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'PRVJRUCCT3'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee |  Please enter a 10-digit IO number |
| 10000             | 10000                      |  1234567890                        |
And I uploaded following supporting documents to cost title 'PRVJRUCCT3':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVJRUCCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVJRUCCT3'
And on cost review page of cost item with title 'PRVJRUCCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVJRUCCT3'
Then I should see AMQ receives below request for cost title 'PRVJRUCCT3' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description | Basket Name      | CategoryId | Gl       |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand  | PRVJRUCCD3   | brandDescription| S80141903  | 33500003 |
When cost with title 'PRVJRUCCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'PRVJRUCCT3'
And I add cost item details for cost title 'PRVJRUCCT3' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'PRVJRUCCT3':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And add below approvers for cost title 'PRVJRUCCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'PRVJRUCCT3'
And on cost review page of cost item with title 'PRVJRUCCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 30000.00                    | 30000.00 |


Scenario: Check payment split for cost greater than zero within Japan region for Contract cost and Film type
Meta:@adcost
     @paymentRules
!--QA-707, rule no-143
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Film | Contract (celebrity & athletes) | PRVJRUCCT4 | PRVJRUCCD4  | Aaron Royer (Grey)  | PRVJRUCATN4            | Japan         | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'PRVJRUCCT4' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 90000          |
And I am on cost items page of cost title 'PRVJRUCCT4'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVJRUCCT4':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVJRUCCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVJRUCCT4'
And on cost review page of cost item with title 'PRVJRUCCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVJRUCCT4'
And cost with title 'PRVJRUCCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'PRVJRUCCT4'
And add cost item details for cost title 'PRVJRUCCT4' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'PRVJRUCCT4':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And add below approvers for cost title 'PRVJRUCCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'PRVJRUCCT4'
And on cost review page of cost item with title 'PRVJRUCCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVJRUCCT4'
And cost with title 'PRVJRUCCT4' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVJRUCCT4' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name    |
| 30000        | 30000          | USD      | 1234567890 | DefaultBrand |PRVJRUCCD4  | brandDescription |


Scenario: Check payment split for cost greater than zero within Japan region for Usage cost and Actor type
Meta:@adcost
     @paymentRules
     @adcostCriticalTests
     @adcostSmokeUAT
     @GLMGCcodes
     @adcostSmoke
!--QA-707, rule no-143, QA-812
Given I am on costs overview page
And created a new 'buyout' cost on AdCosts overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type  | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Actor | Usage                 | PRVJRUCCT5 | PRVJRUCCD5  | Aaron Royer (Grey)  | PRVJRUCATN5            | Japan         | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'PRVJRUCCT5' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 30000          |
And I am on cost items page of cost title 'PRVJRUCCT5'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVJRUCCT5':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVJRUCCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVJRUCCT5'
And on cost review page of cost item with title 'PRVJRUCCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVJRUCCT5'
And cost with title 'PRVJRUCCT5' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'PRVJRUCCT5'
And I add cost item details for cost title 'PRVJRUCCT5' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'PRVJRUCCT5':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And add below approvers for cost title 'PRVJRUCCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'PRVJRUCCT5'
And on cost review page of cost item with title 'PRVJRUCCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVJRUCCT5'
And cost with title 'PRVJRUCCT5' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVJRUCCT5' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name      | CategoryId | Gl       |
| 30000        | 30000          | USD      | 1234567890 | DefaultBrand  |PRVJRUCCD5   | brandDescription | S80141903  | 33500003 |


Scenario: Check payment split for cost greater than zero within Japan region for Buyout cost and Model type
Meta:@adcost
     @paymentRules
!--QA-707, rule no-143
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type  | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Model | Buyout                | PRVJRUCCT6 | PRVJRUCCD6  | Aaron Royer (Grey)  | PRVJRUCATN6            | Japan         | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'PRVJRUCCT6' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And I am on cost items page of cost title 'PRVJRUCCT6'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVJRUCCT6':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVJRUCCT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'PRVJRUCCT6'
And on cost review page of cost item with title 'PRVJRUCCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVJRUCCT6'
Then should see AMQ receives below request for cost title 'PRVJRUCCT6' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description | Basket Name      |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand | PRVJRUCCD6   | brandDescription |
When cost with title 'PRVJRUCCT6' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'PRVJRUCCT6'
And I add cost item details for cost title 'PRVJRUCCT6' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'PRVJRUCCT6':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And add below approvers for cost title 'PRVJRUCCT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'PRVJRUCCT6'
And on cost review page of cost item with title 'PRVJRUCCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 30000.00                    | 30000.00 |


Scenario: Check Final actual payment split for cost greater than zero within Japan region for Contract cost and music type
Meta:@adcost
     @paymentRules
!--QA-707, rule no-143 , QA-871
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type  | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | FinalActual                   | Music | Contract (celebrity & athletes) | PRVJRUCCT7 | PRVJRUCCD7  | Aaron Royer (Grey)   | PRVJRUCATN7            | Japan         | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'PRVJRUCCT7' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Music Type | Rights       | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | Composed   | Instrumental | 30000          |
And I am on cost items page of cost title 'PRVJRUCCT7'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 20000             | 20000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVJRUCCT7':
| FileName            | FormName                               |
| /files/EditWord.doc | Brief/Call for work                    |
| /files/EditWord.doc | Signed contract or letter of extension |
And added below approvers for cost title 'PRVJRUCCT7':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVJRUCCT7'
And on cost review page of cost item with title 'PRVJRUCCT7'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Final Actual payment amount | PO Total |
| Final Actual | 40000.00                    | 40000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVJRUCCT7'
And cost with title 'PRVJRUCCT7' is 'Approve' on behalf of MyPurchases application
And I am on cost review page of cost item with title 'PRVJRUCCT7'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage        | Status   |
| Final Actual | Approved |