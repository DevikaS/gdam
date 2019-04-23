Feature: Payment Rules in Cost module
Narrative:
In order to
As a CostOwner
I want to check Payments split for Traffic Distribution costs


Scenario: Check payment split for cost greater than zero within IMEA region for traffic distribution type cost
Meta:@adcost
     @paymentRules
!--QA-685, rule no-78
Given I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | PRVTDCCT1  | PRVTDCD1    | Aaron Royer (Grey)  | 30000                | PRVTDCATN6             | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
And I filled Cost Line Items with following fields for cost title 'PRVTDCCT1':
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 20000                          |  1234567890                       |
And added below approvers for cost title 'PRVTDCCT1':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When 'Submit' the cost with title 'PRVTDCCT1'
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Original Estimate' for cost title 'PRVTDCCT1'
And on cost review page of cost item with title 'PRVTDCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
Then should see AMQ receives below request for cost title 'PRVTDCCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description | Basket Name      |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand  | PRVTDCD1   | brandDescription |
When cost with title 'PRVTDCCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVTDCCT1'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVTDCCT1':
| Trafficking/Distribution Costs |
| 40000                          |
And 'Submit' the cost with title 'PRVTDCCT1'
And on cost review page of cost item with title 'PRVTDCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 40000.00                    | 40000.00 |
When cost with title 'PRVTDCCT1' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVTDCCT1' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name      |
| 40000        | 40000          | USD      | 1234567890 | DefaultBrand  |PRVTDCD1     | brandDescription |


Scenario: Check payment split for cost greater than zero within EUROPE region for for traffic distribution type cost
Meta:@adcost
     @paymentRules
!--QA-698, rule no-8
Given I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | PRVTDCCT2  | PRVTDCD2    | Aaron Royer (Grey) | 60000                | PRVTDCATN6             | Europe        | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
And I filled Cost Line Items with following fields for cost title 'PRVTDCCT2':
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 60000                          |  1234567890                       |
And added below approvers for cost title 'PRVTDCCT2':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When 'Submit' the cost with title 'PRVTDCCT2'
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Original Estimate' for cost title 'PRVTDCCT2'
And on cost review page of cost item with title 'PRVTDCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 60000.00                    | 60000.00 |
Then should see AMQ receives below request for cost title 'PRVTDCCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description | Basket Name      |
| 60000        | 0              | USD      | 1234567890 | DefaultBrand   | PRVTDCD2   | brandDescription |
When cost with title 'PRVTDCCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVTDCCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVTDCCT2':
| Trafficking/Distribution Costs |
| 50000                          |
And 'Submit' the cost with title 'PRVTDCCT2'
And on cost review page of cost item with title 'PRVTDCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 60000.00                    | 60000.00 |
| Final Actual      | 0.00                             | 50000.00                    | 50000.00 |
When cost with title 'PRVTDCCT2' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVTDCCT2' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name      |
| 50000        | 50000          | USD      | 1234567890 | DefaultBrand  |PRVTDCD2     | brandDescription |


Scenario: Check payment split for cost greater than zero within AAK region for traffic and distribution cost type
Meta:@adcost
     @paymentRules
!--QA-708, rule no-215
Given I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | PRVTDCCT3  | PRVTDCD3    | Aaron Royer (Grey)  | 30000                | PRVTDCATN6             | AAK           | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
And I filled Cost Line Items with following fields for cost title 'PRVTDCCT3':
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 30000                          |  1234567890                       |
And added below approvers for cost title 'PRVTDCCT3':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When 'Submit' the cost with title 'PRVTDCCT3'
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Original Estimate' for cost title 'PRVTDCCT3'
And on cost review page of cost item with title 'PRVTDCCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
Then should see AMQ receives below request for cost title 'PRVTDCCT3' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description | Basket Name      |
| 30000        | 0              | USD      | 1234567890 | DefaultBrand   | PRVTDCD3   | brandDescription |
When cost with title 'PRVTDCCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVTDCCT3'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVTDCCT3':
| Trafficking/Distribution Costs |
| 40000                          |
And 'Submit' the cost with title 'PRVTDCCT3'
And on cost review page of cost item with title 'PRVTDCCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
| Final Actual      | 0.00                             | 40000.00                    | 40000.00 |
When cost with title 'PRVTDCCT3' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVTDCCT3' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name      |
| 40000        | 40000          | USD      | 1234567890 | DefaultBrand  |PRVTDCD3     | brandDescription |


Scenario: Check payment split for cost greater than zero within JAPAN region for traffic and distribution cost type
Meta:@adcost
     @paymentRules
!--QA-824
Given I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title | Description  | Agency Producer/Art| Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | PRVTDCCT4  | PRVTDCD4     | Aaron Royer (Grey) | 30000                | PRVTDCATN6             | Japan         | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
And I filled Cost Line Items with following fields for cost title 'PRVTDCCT4':
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 20000                          |  1234567890                       |
And added below approvers for cost title 'PRVTDCCT4':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When 'Submit' the cost with title 'PRVTDCCT4'
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Original Estimate' for cost title 'PRVTDCCT4'
And on cost review page of cost item with title 'PRVTDCCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
Then should see AMQ receives below request for cost title 'PRVTDCCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description | Basket Name      |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand   | PRVTDCD4   | brandDescription |
When cost with title 'PRVTDCCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVTDCCT4'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVTDCCT4':
| Trafficking/Distribution Costs |
| 40000                          |
And 'Submit' the cost with title 'PRVTDCCT4'
And on cost review page of cost item with title 'PRVTDCCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 40000.00                    | 40000.00 |
When cost with title 'PRVTDCCT4' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVTDCCT4' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name      |
| 40000        | 40000          | USD      | 1234567890 | DefaultBrand  |PRVTDCD4     | brandDescription |


Scenario: Check payment split for cost greater than zero within Greater China region for traffic and distribution cost type
Meta:@adcost
     @paymentRules
!--QA-825
Given I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | PRVTDCCT5  | PRVTDCD5    | Aaron Royer (Grey) | 30000                | PRVTDCATN6             | Greater China | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
And I filled Cost Line Items with following fields for cost title 'PRVTDCCT5':
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 20000                          |  1234567890                       |
And added below approvers for cost title 'PRVTDCCT5':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When 'Submit' the cost with title 'PRVTDCCT5'
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Original Estimate' for cost title 'PRVTDCCT5'
And on cost review page of cost item with title 'PRVTDCCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
Then should see AMQ receives below request for cost title 'PRVTDCCT5' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description | Basket Name      |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand   | PRVTDCD5   | brandDescription |
When cost with title 'PRVTDCCT5' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'PRVTDCCT5'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PRVTDCCT5':
| Trafficking/Distribution Costs |
| 40000                          |
And 'Submit' the cost with title 'PRVTDCCT5'
And on cost review page of cost item with title 'PRVTDCCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 40000.00                    | 40000.00 |
When cost with title 'PRVTDCCT5' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'PRVTDCCT5' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name      |
| 40000        | 40000          | USD      | 1234567890 | DefaultBrand  |PRVTDCD5     | brandDescription |


Scenario: Check payment split at Direct final actual stage for cost less than ten thousand within Greater China region for traffic and distribution cost type
Meta:@adcost
     @devopstests
!--QA-871
Given I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title  | Description  | Agency Producer/Art| Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | PRVTDCCT6   | PRVTDCD6     | Aaron Royer (Grey) | 9000                 | PRVTDCATN6             | Greater China | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | FinalActual                   |
And I filled Cost Line Items with following fields for cost title 'PRVTDCCT6':
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 9000                           |  1234567890                       |
And added below approvers for cost title 'PRVTDCCT6':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When 'Submit' the cost with title 'PRVTDCCT6'
And cost with title 'PRVTDCCT6' is 'Approve' on behalf of MyPurchases application
And I am on cost review page of cost item with title 'PRVTDCCT6'
And refresh the page without delay
Then I 'should' see following fields in cost stage section on cost review page:
| Stage        | Status   |
| Final Actual | Approved |


Scenario: Check approver rule for trafficking cost at FinalActual for total Greater than and equal to zero
Meta:@adcost
     @approverRules
!--QA-641
Given I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title  | Description  | Agency Producer/Art| Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | PRVTDCCT7   | PRVTDCD7     | Aaron Royer (Grey) | 9000                 | PRVTDCATN7             | Greater China | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | FinalActual                   |
And I filled Cost Line Items with following fields for cost title 'PRVTDCCT7':
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 9000                           |  1234567890                       |
Then I 'should' see below approvers on approval form page for cost title 'PRVTDCCT7':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And I 'should not' see 'technical' approver section on cost approval page


Scenario: Check approver rule for trafficking cost for total Greater than and equal to zero
Meta:@adcost
     @approverRules
!--QA-641
Given I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title  | Description  | Agency Producer/Art| Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | PRVTDCCT8   | PRVTDCD8     | Aaron Royer (Grey) | 9000                 | PRVTDCATN8             | Greater China | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
And I filled Cost Line Items with following fields for cost title 'PRVTDCCT8':
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 9000                           |  1234567890                       |
Then I 'should' see below approvers on approval form page for cost title 'PRVTDCCT8':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And I 'should not' see 'technical' approver section on cost approval page