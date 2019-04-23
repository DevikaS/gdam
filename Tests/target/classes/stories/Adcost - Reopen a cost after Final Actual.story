Feature: Increase Grand total in each stage submission
Narrative:
In order to
As a CostOwner
I want to check Reopen cost after Final Actual functionality

Scenario: Check that cost owner for production cost can request reopen cost after final actual stage
Meta:@adcost
     @adcostSmokeUAT
     @adcostSmoke
!--QA-805
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | RCAFACT1   | RCAFAD4     | Christine Meyer (Leo Burnett) | 50000                | Digital Development | RCAFAATN4              | IMEA          | Campaign 1 | BFO          | USD - US Dollar         |
And added production details for cost title 'RCAFACT1' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And added expected asset details for cost title 'RCAFACT1':
| Initiative | Asset Title| Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | RCAFAAT4   | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'RCAFACT1':
| Adaptation | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 30000      | 20000           | 10000         | 1234567890                        |
And uploaded following supporting documents to cost title 'RCAFACT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And I am on cost approval page of cost title 'RCAFACT1'
And added below approvers for cost title 'RCAFACT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
And I clicked 'Submit' button and 'Send for approval' on approval Page
And I logged in with details of 'IPMuser'
And 'Approve' the cost with title 'RCAFACT1'
And cost with title 'RCAFACT1' is 'Approve' on behalf of MyPurchases application
And I logged in with details of 'CostOwner'
And I 'NextStage' the cost with title 'RCAFACT1'
And filled Cost Line Items with following fields for cost title 'RCAFACT1':
| Adaptation | Virtual Reality | P&G insurance |
| 40000      | 30000           | 20000         |
And I uploaded following supporting documents to cost title 'RCAFACT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And added below approvers for cost title 'RCAFACT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCAFACT1'
And I logged in with details of 'IPMuser'
And 'Approve' the cost with title 'RCAFACT1'
And cost with title 'RCAFACT1' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'RCAFACT1'
And I click 'Request Reopen' button and 'Yes, request this cost to be reopened' on cost review page
Then I 'should' see following fields in cost stage section on cost review page:
| Stage        | Status            |
| Final Actual | Pending reopening |
When I login with details of 'GovernanceManager'
And I am on cost review page of cost item with title 'RCAFACT1'
And I click 'Approve Reopen' button and 'Yes, reopen this cost' on cost review page
And I login with details of 'CostOwner'
And fill Cost Line Items with following fields for cost title 'RCAFACT1':
| Adaptation | Virtual Reality |
| 50000      | 50000           |
And 'Submit' the cost with title 'RCAFACT1'
And I am on cost review page of cost item with title 'RCAFACT1'
Then I should see 'Final Actual' stage with '2' version on Cost Review page
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'RCAFACT1'
And cost with title 'RCAFACT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost overview page
And I click 'Request Reopen' and 'Yes, request this cost to be reopened' on title 'RCAFACT1' from costs overview page
Then I 'should' see following data for 'RCAFACT1' cost item on Adcost overview page:
| Cost Stage   | Cost Status       |
| Final Actual | Pending reopening |
When I login with details of 'GovernanceManager'
And I click 'Approve Reopen' and 'Yes, reopen this cost' on title 'RCAFACT1' from costs overview page
And I login with details of 'CostOwner'
And fill Cost Line Items with following fields for cost title 'RCAFACT1':
| Adaptation | Virtual Reality |
| 55000      | 60000           |
And 'Submit' the cost with title 'RCAFACT1'
And I am on cost review page of cost item with title 'RCAFACT1'
Then I should see 'Final Actual' stage with '3' version on Cost Review page
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'RCAFACT1'
And cost with title 'RCAFACT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'RCAFACT1'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage        | Status   |
| Final Actual | Approved |



Scenario: Check that Costs final actual approved status not changed when governance manager reject the cost reopen request after Final actual stage
Meta:@adcost
!--QA-805
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | RCAFACT2   | RCAFAD2     | Christine Meyer (Leo Burnett) | 50000                | Digital Development | RCAFAATN4              | IMEA          | Campaign 1 | BFO          | USD - US Dollar         |
And added production details for cost title 'RCAFACT2' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And added expected asset details for cost title 'RCAFACT2':
| Initiative | Asset Title| Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | RCAFAAT4   | Digital               | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'RCAFACT2':
| Adaptation | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 30000      | 20000           | 10000         | 1234567890                        |
And uploaded following supporting documents to cost title 'RCAFACT2' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'RCAFACT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
And I clicked 'Submit' button and 'Send for approval' on approval Page
And I logged in with details of 'IPMuser'
And 'Approve' the cost with title 'RCAFACT2'
And cost with title 'RCAFACT2' is 'Approve' on behalf of MyPurchases application
And I logged in with details of 'CostOwner'
And I 'NextStage' the cost with title 'RCAFACT2'
And filled Cost Line Items with following fields for cost title 'RCAFACT2':
| Adaptation | Virtual Reality | P&G insurance |
| 40000      | 30000           | 20000         |
And I uploaded following supporting documents to cost title 'RCAFACT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And added below approvers for cost title 'RCAFACT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCAFACT2'
And I logged in with details of 'IPMuser'
And 'Approve' the cost with title 'RCAFACT2'
And cost with title 'RCAFACT2' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'RCAFACT2'
And I click 'Request Reopen' button and 'Yes, request this cost to be reopened' on cost review page
And I login with details of 'GovernanceManager'
And I am on cost review page of cost item with title 'RCAFACT2'
And I click 'Reject Reopen' button and 'Yes, reject the request' on cost review page
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'RCAFACT2'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage        | Status   |
| Final Actual | Approved |


Scenario: Check that cost owner for Traffic cost can request reopen cost after final actual stage
Meta:@adcost
     @paymentRules
!--QA-805
Given I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | RCAFACT3   | RCAFAD1     | Aaron Royer (Grey) | 30000                | RCAFAATN6              | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
And I filled Cost Line Items with following fields for cost title 'RCAFACT3':
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 20000                          |  1234567890                       |
And added below approvers for cost title 'RCAFACT3':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When 'Submit' the cost with title 'RCAFACT3'
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Original Estimate' for cost title 'RCAFACT3'
And on cost review page of cost item with title 'RCAFACT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When cost with title 'RCAFACT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'RCAFACT3'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'RCAFACT3':
| Trafficking/Distribution Costs |
| 40000                          |
And 'Submit' the cost with title 'RCAFACT3'
And on cost review page of cost item with title 'RCAFACT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 40000.00                    | 40000.00 |
When cost with title 'RCAFACT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost overview page
And I click 'Request Reopen' and 'Yes, request this cost to be reopened' on title 'RCAFACT3' from costs overview page
Then I 'should' see following data for 'RCAFACT3' cost item on Adcost overview page:
| Cost Stage   | Cost Status       |
| Final Actual | Pending reopening |
When I login with details of 'GovernanceManager'
And I click 'Approve Reopen' and 'Yes, reopen this cost' on title 'RCAFACT3' from costs overview page
And I login with details of 'CostOwner'
And fill Cost Line Items with following fields for cost title 'RCAFACT3':
| Trafficking/Distribution Costs |
| 50000                          |
And 'Submit' the cost with title 'RCAFACT3'
And I am on cost review page of cost item with title 'RCAFACT3'
Then I should see 'Final Actual' stage with '2' version on Cost Review page
When cost with title 'RCAFACT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'RCAFACT3'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage        | Status   |
| Final Actual | Approved |
