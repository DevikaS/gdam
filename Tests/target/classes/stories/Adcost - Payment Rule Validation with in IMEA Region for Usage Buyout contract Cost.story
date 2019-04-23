Feature: Payment Rules in Cost module
Narrative:
In order to
As a CostOwner
I want to check Payments split for Usage Buyout cost within IMEA region


Scenario: Check payment split for cost greater than zero within IMEA region for Contract cost and Celebrity type
Meta:@adcost
     @paymentRules
     @adcostCriticalTests
     @adcostSmokeUAT
!--QA-685, rule no-112
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Contract (celebrity & athletes) | PRVIRUCCT1 | PRVIRUCCD1  | Aaron Royer (Grey)  | PRVIRUCATN1            | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'PRVIRUCCT1' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints  | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air  | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 90000          |
And added negotiated terms page for cost title 'PRVIRUCCT1' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'PRVIRUCCT1'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents via UI to cost title 'PRVIRUCCT1' and click continue:
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVIRUCCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'PRVIRUCCT1'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'PRVIRUCCT1'
And on cost review page of cost item with title 'PRVIRUCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVIRUCCT1'
Then should see AMQ receives below request for cost title 'PRVIRUCCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand | PRVIRUCCD1  | brandDescription |
When cost with title 'PRVIRUCCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVIRUCCT1'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVIRUCCT1':
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents via UI to cost title 'PRVIRUCCT1' and click continue:
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
| /files/EditWord.doc | Scope change approval form             |
And 'Submit' the cost with title 'PRVIRUCCT1'
And on cost review page of cost item with title 'PRVIRUCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVIRUCCT1'
And cost with title 'PRVIRUCCT1' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVIRUCCT1' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name      |
| 30000        | 30000          | USD      | 1234567890 | DefaultBrand  |PRVIRUCCD1   | brandDescription |


Scenario: Check payment split for cost greater than zero within IMEA region for Usage cost and Athletes type
Meta:@adcost
     @paymentRules
!--QA-685, rule no-112
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Athletes | Usage                 | PRVIRUCCT2 | PRVIRUCCD2  | Aaron Royer (Grey)  | PRVIRUCATN2            | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'PRVIRUCCT2' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints  | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air  | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And added negotiated terms page for cost title 'PRVIRUCCT2' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'PRVIRUCCT2'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRUCCT2':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVIRUCCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVIRUCCT2'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'PRVIRUCCT2'
And on cost review page of cost item with title 'PRVIRUCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVIRUCCT2'
Then should see AMQ receives below request for cost title 'PRVIRUCCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description | Basket Name      |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand  | PRVIRUCCD2  | brandDescription |
When cost with title 'PRVIRUCCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'PRVIRUCCT2'
And I add cost item details for cost title 'PRVIRUCCT2' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'PRVIRUCCT2':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And I 'Submit' the cost with title 'PRVIRUCCT2'
And on cost review page of cost item with title 'PRVIRUCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVIRUCCT2'
And cost with title 'PRVIRUCCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PRVIRUCCT2'
Then I should see AMQ receives below request for cost title 'PRVIRUCCT2' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name      |
| 30000        | 30000          | USD      | 1234567890 | DefaultBrand  |PRVIRUCCD2   | brandDescription |


Scenario: Check payment split for cost greater than zero within IMEA region for Buyout cost and Celebrity type
Meta:@adcost
     @paymentRules
!--QA-685, rule no-112
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Buyout                | PRVIRUCCT3 | PRVIRUCCD3  | Aaron Royer (Grey)  | PRVIRUCATN3            | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'PRVIRUCCT3' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 40000          |
And added negotiated terms page for cost title 'PRVIRUCCT3' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'PRVIRUCCT3'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRUCCT3':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVIRUCCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVIRUCCT3'
And on cost review page of cost item with title 'PRVIRUCCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVIRUCCT3'
Then should see AMQ receives below request for cost title 'PRVIRUCCT3' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description | Basket Name      |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand  | PRVIRUCCD3  | brandDescription |
When cost with title 'PRVIRUCCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'PRVIRUCCT3'
And I add cost item details for cost title 'PRVIRUCCT3' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'PRVIRUCCT3':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And I 'Submit' the cost with title 'PRVIRUCCT3'
And on cost review page of cost item with title 'PRVIRUCCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVIRUCCT3'
And cost with title 'PRVIRUCCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PRVIRUCCT3'
Then I should see AMQ receives below request for cost title 'PRVIRUCCT3' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name      |
| 30000        | 30000          | USD      | 1234567890 | DefaultBrand  |PRVIRUCCD3   | brandDescription |


Scenario: Check payment split for cost greater than zero within IMEA region for Contract cost and Film type
Meta:@adcost
     @paymentRules
!--QA-685, rule no-112
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Film | Contract (celebrity & athletes) | PRVIRUCCT4 | PRVIRUCCD4  | Aaron Royer (Grey)  | PRVIRUCATN4            | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'PRVIRUCCT4' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date  | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018  | 12/12/2019 | Exclusivity Category 1 | 30000          |
And I am on cost items page of cost title 'PRVIRUCCT4'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee |  Please enter a 10-digit IO number |
| 10000             | 10000                      |  1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRUCCT4':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVIRUCCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVIRUCCT4'
And on cost review page of cost item with title 'PRVIRUCCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVIRUCCT4'
Then should see AMQ receives below request for cost title 'PRVIRUCCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand | PRVIRUCCD4  | brandDescription |
When cost with title 'PRVIRUCCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'PRVIRUCCT4'
And I add cost item details for cost title 'PRVIRUCCT4' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'PRVIRUCCT4':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And I 'Submit' the cost with title 'PRVIRUCCT4'
And on cost review page of cost item with title 'PRVIRUCCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 30000.00                    | 30000.00 |


Scenario: Check payment split for cost greater than zero within IMEA region for Usage cost and Actor type
Meta:@adcost
     @paymentRules
!--QA-685, rule no-112
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type  | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Actor | Usage                 | PRVIRUCCT5 | PRVIRUCCD5  | Aaron Royer (Grey)  | PRVIRUCATN5            | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'PRVIRUCCT5' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date  | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018  | 12/12/2019 | Exclusivity Category 1 | 20000          |
And I am on cost items page of cost title 'PRVIRUCCT5'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee |  Please enter a 10-digit IO number |
| 10000             | 10000                      |  1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRUCCT5':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVIRUCCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVIRUCCT5'
And on cost review page of cost item with title 'PRVIRUCCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVIRUCCT5'
And cost with title 'PRVIRUCCT5' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'PRVIRUCCT5'
And add cost item details for cost title 'PRVIRUCCT5' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'PRVIRUCCT5':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And I 'Submit' the cost with title 'PRVIRUCCT5'
And on cost review page of cost item with title 'PRVIRUCCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 30000.00                    | 30000.00 |


Scenario: Check payment split for cost greater than zero within IMEA region for Buyout cost and Model type
Meta:@adcost
     @paymentRules
     @adcostCriticalTests
     @adcostSmokeUAT
     @adcostSmoke
!--QA-685, rule no-112
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type  | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Model | Buyout                | PRVIRUCCT6 | PRVIRUCCD6  | Aaron Royer (Grey)  | PRVIRUCATN6            | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'PRVIRUCCT6' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date  | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018  | 12/12/2019 | Exclusivity Category 1 | 6000           |
And I am on cost items page of cost title 'PRVIRUCCT6'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee |  Please enter a 10-digit IO number |
| 10000             | 10000                      |  1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRUCCT6':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVIRUCCT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVIRUCCT6'
And on cost review page of cost item with title 'PRVIRUCCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVIRUCCT6'
Then should see AMQ receives below request for cost title 'PRVIRUCCT6' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand | PRVIRUCCD6  | brandDescription |
When cost with title 'PRVIRUCCT6' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'PRVIRUCCT6'
And I add cost item details for cost title 'PRVIRUCCT6' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'PRVIRUCCT6':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And I 'Submit' the cost with title 'PRVIRUCCT6'
And on cost review page of cost item with title 'PRVIRUCCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVIRUCCT6'
And cost with title 'PRVIRUCCT6' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PRVIRUCCT6'
Then I should see AMQ receives below request for cost title 'PRVIRUCCT6' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name      |
| 30000        | 30000          | USD      | 1234567890 | DefaultBrand  |PRVIRUCCD6   | brandDescription |


Scenario: Check Final actual payment split for cost greater than zero within IMEA region for Contract cost and music type
Meta:@adcost
     @paymentRules
!--QA-705, rule no-112 , QA-871
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type  | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | FinalActual                   | Music | Contract (celebrity & athletes) | PRVIRUCCT7 | PRVIRUCCD7  | Aaron Royer (Grey)  | PRVIRUCATN7            | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'PRVIRUCCT7' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Music Type | Rights       | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | Composed   | Instrumental | 80000          |
And I am on cost items page of cost title 'PRVIRUCCT7'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 20000             | 20000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRUCCT7':
| FileName            | FormName                               |
| /files/EditWord.doc | Brief/Call for work                    |
| /files/EditWord.doc | Signed contract or letter of extension |
And added below approvers for cost title 'PRVIRUCCT7':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'PRVIRUCCT7'
And on cost review page of cost item with title 'PRVIRUCCT7'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Final Actual payment amount | PO Total |
| Final Actual | 40000.00                    | 40000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVIRUCCT7'
And cost with title 'PRVIRUCCT7' is 'Approve' on behalf of MyPurchases application
And I am on cost review page of cost item with title 'PRVIRUCCT7'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage        | Status     |
| Final Actual | Approved   |


Scenario: Check Direct Final Actual payment split for cost less than ten thousand within IMEA region for Usage cost and Celebrity type
Meta:@adcost
     @paymentRules
!--QA-871
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title  | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency  |
| DefaultCostProject | true | FinalActual                   | Celebrity | Usage                 | PRVIRUCCT8  | PRVIRUCCD8  | Aaron Royer (Grey)  | PRVIRUCATN8            | Greater China | DefaultCampaign |  BFO         | USD - US Dollar          |
And added UsageBuyout details for cost title 'PRVIRUCCT8' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 8000           |
And added negotiated terms page for cost title 'PRVIRUCCT8' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'PRVIRUCCT8'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 5000              | 4000                       | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVIRUCCT8':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVIRUCCT8':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVIRUCCT8'
And cost with title 'PRVIRUCCT8' is 'Approve' on behalf of MyPurchases application
And I am on cost overview page
Then I 'should' see following data for 'PRVIRUCCT8' cost item on Adcost overview page:
| Cost Stage   | Cost Status   |
| Final Actual | Approved      |
