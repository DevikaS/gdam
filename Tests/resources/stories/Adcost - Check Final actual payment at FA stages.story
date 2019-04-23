Feature: Check Final actual payment at FA stages
Narrative:
In order to
As a CostOwner
I want to check final actual payment

Scenario: Check Final actual payment on different FA stages for Production Cost
Meta:@adcost
!--QA-1177
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number      | Cost Title    | Description | Agency Producer/Art           | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject  | CFAPAFASCT1   | CFAPAFASD1  | Christine Meyer (Leo Burnett) | 70000                | Digital Development | VRSCRATN4              | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CFAPAFASCT1' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And added expected asset details for cost title 'CFAPAFASCT1':
| Initiative | Asset Title| Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | VRSCRAT1   | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'CFAPAFASCT1':
| Adaptation   | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 10000        | 20000           | 10000         | 1234567890                        |
And uploaded following supporting documents to cost title 'CFAPAFASCT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And I am on cost approval page of cost title 'CFAPAFASCT1'
And added below approvers for cost title 'CFAPAFASCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
And I clicked 'Submit' button and 'Send for approval' on approval Page
When I login with details of 'IPMuser'
When I 'Approve' the cost with title 'CFAPAFASCT1'
When cost with title 'CFAPAFASCT1' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'CFAPAFASCT1'
And fill Cost Line Items with following fields for cost title 'CFAPAFASCT1':
| Adaptation   | Virtual Reality |
| 15000        | 20000           |
And I upload following supporting documents to cost title 'CFAPAFASCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And I 'Submit' the cost with title 'CFAPAFASCT1'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'CFAPAFASCT1'
And cost with title 'CFAPAFASCT1' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'CFAPAFASCT1' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount    | Currency | IO Number  | Brand        |Description  | Basket Name      |
| 45000        | 45000             | USD      | 1234567890 | DefaultBrand |CFAPAFASD1   | brandDescription |
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CFAPAFASCT1'
And I click 'Request Reopen' button and 'Yes, request this cost to be reopened' on cost review page
When I login with details of 'GovernanceManager'
And I am on cost review page of cost item with title 'CFAPAFASCT1'
And I click 'Approve Reopen' button and 'Yes, reopen this cost' on cost review page
When I login with details of 'CostOwner'
And fill Cost Line Items with following fields for cost title 'CFAPAFASCT1':
| Adaptation   | Virtual Reality |
| 13000        | 20000           |
And 'Submit' the cost with title 'CFAPAFASCT1'
And I am on cost review page of cost item with title 'CFAPAFASCT1'
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'CFAPAFASCT1'
And cost with title 'CFAPAFASCT1' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'CFAPAFASCT1' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount    | Currency | IO Number  | Brand         |Description  | Basket Name      |
| 43000        | -2000             | USD      | 1234567890 | DefaultBrand  |CFAPAFASD1   | brandDescription |
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CFAPAFASCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual      | 0.00                             | 43000.00                    | 43000.00 |
When I click 'Request Reopen' button and 'Yes, request this cost to be reopened' on cost review page
When I login with details of 'GovernanceManager'
And I am on cost review page of cost item with title 'CFAPAFASCT1'
And I click 'Approve Reopen' button and 'Yes, reopen this cost' on cost review page
When I login with details of 'CostOwner'
And fill Cost Line Items with following fields for cost title 'CFAPAFASCT1':
| Adaptation   | Virtual Reality |
| 16000        | 22000           |
And 'Submit' the cost with title 'CFAPAFASCT1'
And I am on cost review page of cost item with title 'CFAPAFASCT1'
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'CFAPAFASCT1'
And cost with title 'CFAPAFASCT1' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'CFAPAFASCT1' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount    | Currency | IO Number  | Brand         |Description  | Basket Name      |
| 48000        | 5000              | USD      | 1234567890 | DefaultBrand  |CFAPAFASD1   | brandDescription |
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CFAPAFASCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual      | 0.00                             | 48000.00                    | 48000.00 |


Scenario: Check Final actual payment on different FA stages for Buyout cost and Celebrity type
Meta:@adcost
!--QA-1177
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Buyout                | CFAPAFASCT2 | CFAPAFASD2 | Aaron Royer (Grey)  | PRVJRUCATN3            | Japan         | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CFAPAFASCT2' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And added negotiated terms page for cost title 'CFAPAFASCT2' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'CFAPAFASCT2'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee |  Please enter a 10-digit IO number |
| 10000             | 10000                      |  1234567890                        |
And I uploaded following supporting documents to cost title 'CFAPAFASCT2':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CFAPAFASCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CFAPAFASCT2'
And on cost review page of cost item with title 'CFAPAFASCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CFAPAFASCT2'
Then I should see AMQ receives below request for cost title 'CFAPAFASCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description | Basket Name      | CategoryId | Gl       |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand  | CFAPAFASD2   | brandDescription| S80141903  | 33500003 |
When cost with title 'CFAPAFASCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'CFAPAFASCT2'
And I add cost item details for cost title 'CFAPAFASCT2' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'CFAPAFASCT2':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And add below approvers for cost title 'CFAPAFASCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'CFAPAFASCT2'
And on cost review page of cost item with title 'CFAPAFASCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CFAPAFASCT2'
And cost with title 'CFAPAFASCT2' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'CFAPAFASCT2' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount    | Currency | IO Number  | Brand         |Description  | Basket Name      |
| 30000        | 30000             | USD      | 1234567890 | DefaultBrand  |CFAPAFASD2   | brandDescription |
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CFAPAFASCT2'
And I click 'Request Reopen' button and 'Yes, request this cost to be reopened' on cost review page
And I login with details of 'GovernanceManager'
And I am on cost review page of cost item with title 'CFAPAFASCT2'
And I click 'Approve Reopen' button and 'Yes, reopen this cost' on cost review page
When I login with details of 'CostOwner'
And I add cost item details for cost title 'CFAPAFASCT2' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 20000             | 15000                      |
And 'Submit' the cost with title 'CFAPAFASCT2'
And I am on cost review page of cost item with title 'CFAPAFASCT2'
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'CFAPAFASCT2'
And cost with title 'CFAPAFASCT2' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'CFAPAFASCT2' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount    | Currency | IO Number  | Brand         |Description  | Basket Name      |
| 35000        | 5000              | USD      | 1234567890 | DefaultBrand  |CFAPAFASD2   | brandDescription |
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CFAPAFASCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual      | 0.00                             | 35000.00                    | 35000.00 |
When I click 'Request Reopen' button and 'Yes, request this cost to be reopened' on cost review page
And I login with details of 'GovernanceManager'
And I am on cost review page of cost item with title 'CFAPAFASCT2'
And I click 'Approve Reopen' button and 'Yes, reopen this cost' on cost review page
When I login with details of 'CostOwner'
And I add cost item details for cost title 'CFAPAFASCT2' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 20000             | 9000                       |
And 'Submit' the cost with title 'CFAPAFASCT2'
And I am on cost review page of cost item with title 'CFAPAFASCT2'
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'CFAPAFASCT2'
And cost with title 'CFAPAFASCT2' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'CFAPAFASCT2' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount    | Currency | IO Number  | Brand         |Description  | Basket Name      |
| 29000        | -6000             | USD      | 1234567890 | DefaultBrand  |CFAPAFASD2   | brandDescription |
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CFAPAFASCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual      | 0.00                             | 29000.00                    | 29000.00 |


Scenario: Check Final actual payment on different FA stages for traffic distribution type cost
Meta:@adcost
!--QA-1177
Given I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art  | Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | CFAPAFASCT3| CFAPAFASD3    | Aaron Royer (Grey) | 60000                | PRVTDCATN6             | Europe        | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
And I filled Cost Line Items with following fields for cost title 'CFAPAFASCT3':
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 60000                          |  1234567890                       |
And added below approvers for cost title 'CFAPAFASCT3':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When 'Submit' the cost with title 'CFAPAFASCT3'
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Original Estimate' for cost title 'CFAPAFASCT3'
And on cost review page of cost item with title 'CFAPAFASCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 60000.00                    | 60000.00 |
Then should see AMQ receives below request for cost title 'CFAPAFASCT3' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description | Basket Name      |
| 60000.0      | 0.0            | USD      | 1234567890 | DefaultBrand  | CFAPAFASD3  | brandDescription |
When cost with title 'CFAPAFASCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'CFAPAFASCT3'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'CFAPAFASCT3':
| Trafficking/Distribution Costs |
| 50000                          |
And 'Submit' the cost with title 'CFAPAFASCT3'
And on cost review page of cost item with title 'CFAPAFASCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 60000.00                    | 60000.00 |
| Final Actual      | 0.00                             | 50000.00                    | 50000.00 |
When cost with title 'CFAPAFASCT3' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'CFAPAFASCT3' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name      |
| 50000        | 50000          | USD      | 1234567890 | DefaultBrand  |CFAPAFASD3   | brandDescription |
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CFAPAFASCT3'
And I click 'Request Reopen' button and 'Yes, request this cost to be reopened' on cost review page
When I login with details of 'GovernanceManager'
And I am on cost review page of cost item with title 'CFAPAFASCT3'
And I click 'Approve Reopen' button and 'Yes, reopen this cost' on cost review page
When I login with details of 'CostOwner'
And fill Cost Line Items with following fields for cost title 'CFAPAFASCT3':
| Trafficking/Distribution Costs |
| 45000                          |
And 'Submit' the cost with title 'CFAPAFASCT3'
And I am on cost review page of cost item with title 'CFAPAFASCT3'
And cost with title 'CFAPAFASCT3' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'CFAPAFASCT3' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount    | Currency | IO Number  | Brand         |Description  | Basket Name      |
| 45000        | -5000             | USD      | 1234567890 | DefaultBrand  |CFAPAFASD3   | brandDescription |
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CFAPAFASCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual      | 0.00                             | 45000.00                    | 45000.00 |
When I click 'Request Reopen' button and 'Yes, request this cost to be reopened' on cost review page
When I login with details of 'GovernanceManager'
And I am on cost review page of cost item with title 'CFAPAFASCT3'
And I click 'Approve Reopen' button and 'Yes, reopen this cost' on cost review page
When I login with details of 'CostOwner'
And fill Cost Line Items with following fields for cost title 'CFAPAFASCT3':
| Trafficking/Distribution Costs |
| 60000                          |
And 'Submit' the cost with title 'CFAPAFASCT3'
And I am on cost review page of cost item with title 'CFAPAFASCT3'
And cost with title 'CFAPAFASCT3' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'CFAPAFASCT3' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount    | Currency | IO Number  | Brand           |Description  | Basket Name      |
| 60000        | 15000             | USD      | 1234567890 | DefaultBrand    |CFAPAFASD3   | brandDescription |
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CFAPAFASCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual      | 0.00                             | 60000.00                    | 60000.00 |



