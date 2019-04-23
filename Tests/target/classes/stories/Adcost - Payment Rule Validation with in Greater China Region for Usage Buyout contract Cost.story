Feature: Payment Rules in Cost module
Narrative:
In order to
As a CostOwner
I want to check Payments split for Usage Buyout cost within Greater China region


Scenario: Check Original estimated payment split for cost greater than zero within Greater China region for Contract cost and Celebrity type
Meta:@adcost
     @paymentRules
!--QA-705, rule no-64
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract           | Cost Title  | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency  |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Contract (celebrity & athletes) | PRVGCRUCCT1 | PRVGCRUCCD1 | Aaron Royer (Grey)  | PRVGCRUCATN1           | Greater China | DefaultCampaign |  BFO         | USD - US Dollar          |
And added UsageBuyout details for cost title 'PRVGCRUCCT1' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints   | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air   | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 9000           |
And added negotiated terms page for cost title 'PRVGCRUCCT1' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'PRVGCRUCCT1'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVGCRUCCT1':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVGCRUCCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'PRVGCRUCCT1'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'PRVGCRUCCT1'
And on cost review page of cost item with title 'PRVGCRUCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVGCRUCCT1'
And click 'Approve' button and 'Approve' on cost review page
Then should see AMQ receives below request for cost title 'PRVGCRUCCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand | PRVGCRUCCD1 | brandDescription |
When cost with title 'PRVGCRUCCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVGCRUCCT1'
And click 'Next Stage' button and 'Confirm' on cost review page
And I add cost item details for cost title 'PRVGCRUCCT1' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'PRVGCRUCCT1':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And add below approvers for cost title 'PRVGCRUCCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'PRVGCRUCCT1'
And on cost review page of cost item with title 'PRVGCRUCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'PRVGCRUCCT1'
And I click 'Approve' button and 'Approve' on cost review page
And cost with title 'PRVGCRUCCT1' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVGCRUCCT1' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 30000        | 30000          | USD      | 1234567890 | DefaultBrand | PRVGCRUCCD1  | brandDescription |


Scenario: Check Original estimated payment split for cost greater than zero within Greater China region for Usage cost and Athletes type
Meta:@adcost
     @paymentRules
!--QA-705, rule no-64
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title  | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency  |
| DefaultCostProject | true | OriginalEstimate              | Athletes | Usage                 | PRVGCRUCCT2 | PRVGCRUCCD2 | Aaron Royer (Grey)  | PRVGCRUCATN2           | Greater China | DefaultCampaign |  BFO         | USD - US Dollar          |
And added UsageBuyout details for cost title 'PRVGCRUCCT2' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints   | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air   | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And added negotiated terms page for cost title 'PRVGCRUCCT2' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'PRVGCRUCCT2'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVGCRUCCT2':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVGCRUCCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'PRVGCRUCCT2'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'PRVGCRUCCT2'
And on cost review page of cost item with title 'PRVGCRUCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVGCRUCCT2'
Then should see AMQ receives below request for cost title 'PRVGCRUCCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand | PRVGCRUCCD1 | brandDescription |
When cost with title 'PRVGCRUCCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'PRVGCRUCCT2'
And add cost item details for cost title 'PRVGCRUCCT2' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'PRVGCRUCCT2':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And add below approvers for cost title 'PRVGCRUCCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'PRVGCRUCCT2'
And on cost review page of cost item with title 'PRVGCRUCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'PRVGCRUCCT2'
And cost with title 'PRVGCRUCCT2' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVGCRUCCT2' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 30000        | 30000          | USD      | 1234567890 | DefaultBrand | PRVGCRUCCD2  | brandDescription |



Scenario: Check Original estimated payment split for cost greater than zero within Greater China region for Buyout cost and Celebrity type
Meta:@adcost
     @paymentRules
!--QA-705, rule no-64
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title  | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency  |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Buyout                | PRVGCRUCCT3 | PRVGCRUCCD3 | Aaron Royer (Grey)  | PRVGCRUCATN3           | Greater China | DefaultCampaign |  BFO         | USD - US Dollar          |
And added UsageBuyout details for cost title 'PRVGCRUCCT3' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 30000          |
And added negotiated terms page for cost title 'PRVGCRUCCT3' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'PRVGCRUCCT3'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 20000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVGCRUCCT3':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVGCRUCCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVGCRUCCT3'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'PRVGCRUCCT3'
And on cost review page of cost item with title 'PRVGCRUCCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'PRVGCRUCCT3'
Then should see AMQ receives below request for cost title 'PRVGCRUCCT3' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 30000        | 0              | USD      | 1234567890 | DefaultBrand | PRVGCRUCCD1 | brandDescription |
When cost with title 'PRVGCRUCCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'PRVGCRUCCT3'
And add cost item details for cost title 'PRVGCRUCCT3' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 25000             | 25000                      |
And I upload following supporting documents to cost title 'PRVGCRUCCT3':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And I 'Submit' the cost with title 'PRVGCRUCCT3'
And on cost review page of cost item with title 'PRVGCRUCCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 0.00                             | 50000.00                    | 50000.00 |
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'PRVGCRUCCT3'
And cost with title 'PRVGCRUCCT3' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVGCRUCCT3' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 50000        | 50000          | USD      | 1234567890 | DefaultBrand | PRVGCRUCCD3  | brandDescription |


Scenario: Check Original estimated payment split for cost greater than zero within Greater China region for Contract cost and Film type
Meta:@adcost
     @paymentRules
!--QA-705, rule no-64
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type | Usage/Buyout/Contract           | Cost Title  | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Film | Contract (celebrity & athletes) | PRVGCRUCCT4 | PRVGCRUCCD4 | Aaron Royer (Grey)  | PRVGCRUCATN4           | Greater China | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'PRVGCRUCCT4' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints  | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air  | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And I am on cost items page of cost title 'PRVGCRUCCT4'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVGCRUCCT4':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVGCRUCCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVGCRUCCT4'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'PRVGCRUCCT4'
And on cost review page of cost item with title 'PRVGCRUCCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'PRVGCRUCCT4'
Then should see AMQ receives below request for cost title 'PRVGCRUCCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand | PRVGCRUCCD4 | brandDescription |
When cost with title 'PRVGCRUCCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'PRVGCRUCCT4'
And I add cost item details for cost title 'PRVGCRUCCT4' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'PRVGCRUCCT4':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And add below approvers for cost title 'PRVGCRUCCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'PRVGCRUCCT4'
And on cost review page of cost item with title 'PRVGCRUCCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'PRVGCRUCCT4'
And cost with title 'PRVGCRUCCT4' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVGCRUCCT4' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 30000        | 30000          | USD      | 1234567890 | DefaultBrand | PRVGCRUCCD4  | brandDescription |


Scenario: Check Original estimated payment split for cost greater than zero within Greater China region for Usage cost and Actor type
Meta:@adcost
     @paymentRules
!--QA-705, rule no-64
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type  | Usage/Buyout/Contract | Cost Title  | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Actor | Usage                 | PRVGCRUCCT5 | PRVGCRUCCD5 | Aaron Royer (Grey)  | PRVGCRUCATN5           | Greater China | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'PRVGCRUCCT5' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And I am on cost items page of cost title 'PRVGCRUCCT5'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVGCRUCCT5':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVGCRUCCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVGCRUCCT5'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'PRVGCRUCCT5'
And on cost review page of cost item with title 'PRVGCRUCCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'PRVGCRUCCT5'
Then should see AMQ receives below request for cost title 'PRVGCRUCCT5' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand | PRVGCRUCCD5 | brandDescription |
When cost with title 'PRVGCRUCCT5' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'PRVGCRUCCT5'
And I add cost item details for cost title 'PRVGCRUCCT5' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'PRVGCRUCCT5':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And add below approvers for cost title 'PRVGCRUCCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'PRVGCRUCCT5'
And on cost review page of cost item with title 'PRVGCRUCCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'PRVGCRUCCT5'
And cost with title 'PRVGCRUCCT5' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVGCRUCCT5' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 30000        | 30000          | USD      | 1234567890 | DefaultBrand | PRVGCRUCCD5  | brandDescription |


Scenario: Check Original estimated payment split for cost greater than zero within Greater China region for Buyout cost and Model type
Meta:@adcost
     @paymentRules
!--QA-705, rule no-64
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type  | Usage/Buyout/Contract | Cost Title  | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Model | Buyout                | PRVGCRUCCT6 | PRVGCRUCCD6 | Aaron Royer (Grey)  | PRVGCRUCATN6           | Greater China | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'PRVGCRUCCT6' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 9000           |
And I am on cost items page of cost title 'PRVGCRUCCT6'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVGCRUCCT6':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVGCRUCCT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVGCRUCCT6'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'PRVGCRUCCT6'
And on cost review page of cost item with title 'PRVGCRUCCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'PRVGCRUCCT6'
Then should see AMQ receives below request for cost title 'PRVGCRUCCT6' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand | PRVGCRUCCD6 | brandDescription |
When cost with title 'PRVGCRUCCT6' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'PRVGCRUCCT6'
And I add cost item details for cost title 'PRVGCRUCCT6' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'PRVGCRUCCT6':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And add below approvers for cost title 'PRVGCRUCCT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'PRVGCRUCCT6'
And on cost review page of cost item with title 'PRVGCRUCCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'PRVGCRUCCT6'
And cost with title 'PRVGCRUCCT6' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVGCRUCCT6' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      |
| 30000        | 30000          | USD      | 1234567890 | DefaultBrand | PRVGCRUCCD6  | brandDescription |


Scenario: Check Final actual payment split for cost greater than zero within Greater China region for Usage Buyout Contract cost and music type
Meta:@adcost
     @paymentRules
!--QA-705, rule no-64
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type  | Usage/Buyout/Contract           | Cost Title  | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency  |
| DefaultCostProject | true | FinalActual                   | Music | Contract (celebrity & athletes) | PRVGCRUCCT7 | PRVGCRUCCD7 | Aaron Royer (Grey)  | PRVGCRUCATN7           | Greater China | DefaultCampaign |  BFO         | USD - US Dollar          |
And added UsageBuyout details for cost title 'PRVGCRUCCT7' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints   | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Music Type | Rights       | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air   | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | Composed   | Instrumental | 20000          |
And I am on cost items page of cost title 'PRVGCRUCCT7'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 20000             | 20000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVGCRUCCT7':
| FileName            | FormName                               |
| /files/EditWord.doc | Brief/Call for work                    |
| /files/EditWord.doc | Signed contract or letter of extension |
And added below approvers for cost title 'PRVGCRUCCT7':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVGCRUCCT7'
And on cost review page of cost item with title 'PRVGCRUCCT7'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage       | Final Actual payment amount | PO Total |
| Final Actual| 40000.00                    | 40000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PRVGCRUCCT7'
When cost with title 'PRVGCRUCCT7' is 'Approve' on behalf of MyPurchases application
And I am on cost review page of cost item with title 'PRVGCRUCCT7'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage        | Status   |
| Final Actual | Approved |


Scenario: Check Direct Final Actual payment split for cost less than ten thousand within Greater China region for Buyout cost and Celebrity type
Meta:@adcost
     @paymentRules
!--QA-871
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title  | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency  |
| DefaultCostProject | true | FinalActual                   | Celebrity | Buyout                | PRVGCRUCCT8 | PRVGCRUCCD8 | Aaron Royer (Grey)  | PRVGCRUCATN8           | Greater China | DefaultCampaign |  BFO         | USD - US Dollar          |
And added UsageBuyout details for cost title 'PRVGCRUCCT8' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 8000           |
And added negotiated terms page for cost title 'PRVGCRUCCT8' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'PRVGCRUCCT8'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 5000              | 4000                       | 1234567890                        |
And I uploaded following supporting documents to cost title 'PRVGCRUCCT8':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'PRVGCRUCCT8':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When I 'Submit' the cost with title 'PRVGCRUCCT8'
And I am on cost review page of cost item with title 'PRVGCRUCCT8'
And cost with title 'PRVGCRUCCT8' is 'Approve' on behalf of MyPurchases application
And refresh the page without delay
Then I 'should' see following fields in cost stage section on cost review page:
| Stage        | Status   |
| Final Actual | Approved |


Scenario: Check dropdown values for MediaTouchpoints field in UsageBuyoutDetails page for Buyout cost
Meta:@adcost
!--QA-1062
Given I am on costs overview page
When I create a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title  | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Athletes  | Buyout                | PRVGCRUCCT9 | PRVGCRUCCD9 | Aaron Royer (Grey)  | PRVGCRUCATN9           | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
Then I 'should' see fields contain following values on buyout usage details page for cost title1 'PRVGCRUCCT9':
| Media/Touchpoints                                                                                                  |
| Cinema; Digital; Direct to consumer; In-store; not for air; Out of home; PR/Influencer; Radio; streaming audio; Tv |


Scenario: Check dropdown values for MediaTouchpoints field in UsageBuyoutDetails page for Usage cost
Meta:@adcost
!--QA-1062
Given I am on costs overview page
When I create a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title   | Description  | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Athletes  | Usage                 | PRVGCRUCCT10 | PRVGCRUCCD10 | Aaron Royer (Grey)  | PRVGCRUCATN10          | North America | DefaultCampaign |  BFO         | USD - US Dollar         |
Then I 'should' see fields contain following values on buyout usage details page for cost title1 'PRVGCRUCCT10':
| Media/Touchpoints                                                                                                  |
| Cinema; Digital; Direct to consumer; In-store; not for air; Out of home; PR/Influencer; Radio; streaming audio; Tv |

Scenario: Check dropdown values for MediaTouchpoints field in UsageBuyoutDetails page for Contract cost
Meta:@adcost
!--QA-1062
Given I am on costs overview page
When I create a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract           | Cost Title  | Description   | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency  |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Contract (celebrity & athletes) | PRVGCRUCCT11 | PRVGCRUCCD11 | Aaron Royer (Grey)  | PRVGCRUCATN11          | Greater China | DefaultCampaign |  BFO         | USD - US Dollar          |
Then I 'should' see fields contain following values on buyout usage details page for cost title1 'PRVGCRUCCT11':
| Media/Touchpoints                                                                                                  |
| Cinema; Digital; Direct to consumer; In-store; not for air; Out of home; PR/Influencer; Radio; streaming audio; Tv |