Feature: Increase Grand total in each stage submission
Narrative:
In order to
As a CycloneCostOwner
I want to check cyclone type Traffic Distribution cost

Scenario: Check cyclone Traffic Distribution cost completion within North America region
Meta:@adcost
     @costCreationWithRevisions
     @adcostCycloneCosts
!--QA-765
Given I am on costs overview page
And created a new 'Trafficking' cost on AdCosts overview page
And I filled Cost Details with following fields for 'Trafficking' cost:
| Project Number            | Cost Title    | Description    | Agency Producer/Art| Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCycloneCostProject | CCTDCNARCT1   | CCTDCNARD6     | Aaron Royer (Grey) | 50000                | CCTDCNARATN6           | North America | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | Original Estimate             |
When I fill Cost Line Items with following fields:
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 50000                          |  1234567890                       |
And I fill below approvers for cost title 'CCTDCNARCT1':
| Brand Management Approver |
| BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Original Estimate' for cost title 'CCTDCNARCT1'
And on cost review page of cost item with title 'CCTDCNARCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                   | Original Estimate Local | Original Estimate |
| Trafficking/Distribution Costs | $ 50,000.00             | $ 50,000.00       |
| SUBTOTAL DISTRIBUTION COSTS    | $ 50,000.00             | $ 50,000.00       |
| Grand Total                    | $  50,000.00            | $  50,000.00      |
When I login with details of 'BrandManagementApprover'
And I am on cost review page of cost item with title 'CCTDCNARCT1'
And click 'Approve' button and 'Approve' on cost review page
And I login with details of 'CycloneCostOwner'
And 'CreateRevision' the cost with title 'CCTDCNARCT1'
And I add cost item details for cost title 'CCTDCNARCT1' with 'USD' currency:
| Trafficking/Distribution Costs |
| 70000                          |
And I 'Submit' the cost with title 'CCTDCNARCT1'
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Current Revision' for cost title 'CCTDCNARCT1'
And on cost review page of cost item with title 'CCTDCNARCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                   | Original Estimate | Current Revision Local | Current Revision |
| Trafficking/Distribution Costs | $ 50,000.00       | $ 70,000.00            | $ 70,000.00      |
| SUBTOTAL DISTRIBUTION COSTS    | $ 50,000.00       | $ 70,000.00            | $ 70,000.00      |
| Grand Total                    | $  50,000.00      | $  70,000.00           | $  70,000.00     |
When I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCTDCNARCT1'
And I login with details of 'CycloneCostOwner'
And 'NextStage' the cost with title 'CCTDCNARCT1'
And I add cost item details for cost title 'CCTDCNARCT1' with 'USD' currency:
| Trafficking/Distribution Costs |
| 90000                          |
And 'Submit' the cost with title 'CCTDCNARCT1'
And on cost review page of cost item with title 'CCTDCNARCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                   | Original Estimate | Final Actual Local | Final Actual |
| Trafficking/Distribution Costs | $ 50,000.00       | $ 90,000.00        | $ 90,000.00  |
| SUBTOTAL DISTRIBUTION COSTS    | $ 50,000.00       | $ 90,000.00        | $ 90,000.00  |
| Grand Total                    | $  50,000.00      | $  90,000.00       | $  90,000.00 |


