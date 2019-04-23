Feature: Increase Grand total in each stage submission for Traffic Distribution
Narrative:
In order to
As a CostOwner
I want to check Cost creation and completion by increasing Grand total in each stage submission

Scenario: Check Traffic Distribution cost completion with revisions in each stage
Meta:@adcost
     @costCreationWithRevisions
     @adcostCriticalTests
!--QA-826
Given I am on costs overview page
And created a new 'Trafficking' cost on AdCosts overview page
And I filled Cost Details with following fields for 'Trafficking' cost:
| Project Number     | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | CCRTDCT1   | CCRTDDC1    | Aaron Royer (Grey) | 50000                | CCRTDATN6              | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | Original Estimate             |
And I filled Cost Line Items with following fields:
| Trafficking/Distribution Costs | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 52000                          | -2000            |  1234567890                       |
And filled below approvers for cost title 'CCRTDCT1':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Original Estimate' for cost title 'CCRTDCT1'
And on cost review page of cost item with title 'CCRTDCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                   | Original Estimate Local | Original Estimate |
| Trafficking/Distribution Costs | $ 52,000.00             | $ 52,000.00       |
| SUBTOTAL DISTRIBUTION COSTS    | $ 52,000.00             | $ 52,000.00       |
| FX (Loss) & Gain               | $ -2,000.00             | $ -2,000.00       |
| SUBTOTAL OTHER COSTS           | $ -2,000.00             | $ -2,000.00       |
| Grand Total                    | $  50,000.00            | $  50,000.00      |
And I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 50000.00                    | 50000.00 |
When cost with title 'CCRTDCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'CreateRevision' the cost with title 'CCRTDCT1'
And I add cost item details for cost title 'CCRTDCT1' with 'USD' currency:
| Trafficking/Distribution Costs |
| 72000                          |
And I 'Submit' the cost with title 'CCRTDCT1'
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Current Revision' for cost title 'CCRTDCT1'
And on cost review page of cost item with title 'CCRTDCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                   | Original Estimate | Current Revision Local | Current Revision |
| Trafficking/Distribution Costs | $ 52,000.00       | $ 72,000.00            | $ 72,000.00      |
| SUBTOTAL DISTRIBUTION COSTS    | $ 52,000.00       | $ 72,000.00            | $ 72,000.00      |
| FX (Loss) & Gain               | $ -2,000.00       | $ -2,000.00            | $ -2,000.00      |
| SUBTOTAL OTHER COSTS           | $ -2,000.00       | $ -2,000.00            | $ -2,000.00      |
| Grand Total                    | $  50,000.00      | $  70,000.00           | $  70,000.00     |
And I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 50000.00                    | 50000.00 |
When cost with title 'CCRTDCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'CCRTDCT1'
And I add cost item details for cost title 'CCRTDCT1' with 'USD' currency:
| Trafficking/Distribution Costs | FX (Loss) & Gain |
| 90000                          | 3000             |
And 'Submit' the cost with title 'CCRTDCT1'
And on cost review page of cost item with title 'CCRTDCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                   | Original Estimate | Final Actual Local | Final Actual |
| Trafficking/Distribution Costs | $ 52,000.00       | $ 90,000.00        | $ 90,000.00  |
| SUBTOTAL DISTRIBUTION COSTS    | $ 52,000.00       | $ 90,000.00        | $ 90,000.00  |
| FX (Loss) & Gain               | $ -2,000.00       | $ 3,000.00         | $ 3,000.00   |
| SUBTOTAL OTHER COSTS           | $ -2,000.00       | $ 3,000.00         | $ 3,000.00   |
| Grand Total                    | $  50,000.00      | $  93,000.00       | $  93,000.00 |
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 50000.00                    | 50000.00 |
| Final Actual      | 0.00                             | 93000.00                    | 93000.00 |