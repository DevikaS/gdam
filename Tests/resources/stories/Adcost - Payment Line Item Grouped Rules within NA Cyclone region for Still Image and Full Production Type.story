Feature: Payment Group Line Item Rules for Cyclclone cost
Narrative:
In order to
As a CycloneCostOwner
I want to validate payment group line item rules for cycloe costs in North America region


Scenario: Check Cyclone Payment Line Group Rules for Video Content Type and Full Production type
Meta:@adcost
     @costCreationWithRevisions
     @paymentLineGroupRules
!--QA-697
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number            | Cost Title    | Description  | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | PLINCSIFPTCT1 | PLINCSIFPTD1 | Aaron Royer (Grey)  | 9000                 | Video        | Full Production | PLINCSIFPTATN1         | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PLINCSIFPTCT1' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'PLINCSIFPTCT1':
| Initiative | Country | Asset Title   | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | PLINCSIFPTAT1 | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'PLINCSIFPTCT1':
| Audio finalization | Offline edits | Agency travel | Talent fees |
| 8000               | 3000          | 3000          | 6000        |
And uploaded following supporting documents to cost title 'PLINCSIFPTCT1' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'PLINCSIFPTCT1':
| Technical Approver | Brand Management Approver |
| CostConsultant     | BrandManagementApprover   |
And I refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PLINCSIFPTCT1'
Then I should see following data in payment line items on payment summary page:
| Stage             | PRODUCTION COST | TALENT FEES | POST PRODUCTION COST | TECHNICAL FEE (IF APPLICABLE) | INSURANCE (IF NOT COVERED BY P&G) | OTHER COSTS | Cost Total |
| Original Estimate | 0.00            | 6000.00     | 11000.00             | 743.00                        | 0.00                              | 3000.00     | 20743.00   |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 6743.00                          | 5500.00                           | 8500.00                     | 20743.00 |
When I login with details of 'CostConsultant'
And 'Approve' the cost with title 'PLINCSIFPTCT1'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'PLINCSIFPTCT1'
And I login with details of 'CycloneCostOwner'
And I am on cost review page of cost item with title 'PLINCSIFPTCT1'
And click 'Create Revision' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PLINCSIFPTCT1':
| Audio finalization | Offline edits | Agency travel |
| 8000               | 10000         | 3000          |
And I upload following supporting documents to cost title 'PLINCSIFPTCT1':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'PLINCSIFPTCT1'
And I am on cost review page of cost item with title 'PLINCSIFPTCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 6743.00                          | 5500.00                           | 8500.00                     | 20743.00 |
When I login with details of 'CostConsultant'
And 'Approve' the cost with title 'PLINCSIFPTCT1'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'PLINCSIFPTCT1'
And I login with details of 'CycloneCostOwner'
And I am on cost review page of cost item with title 'PLINCSIFPTCT1'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PLINCSIFPTCT1':
| Audio finalization | Offline edits | Agency travel |
| 8000               | 10000         | 4000          |
And I upload following supporting documents to cost title 'PLINCSIFPTCT1':
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
| /files/EditWord.doc | Scope change approval form            |
And 'Submit' the cost with title 'PLINCSIFPTCT1'
And I am on cost review page of cost item with title 'PLINCSIFPTCT1'
Then I should see following data in payment line items on payment summary page:
| Stage              | PRODUCTION COST | TALENT FEES | POST PRODUCTION COST | TECHNICAL FEE (IF APPLICABLE) | INSURANCE (IF NOT COVERED BY P&G) | OTHER COSTS | Cost Total |
| First Presentation | 0.00            | 6000.00     | 18000.00             | 743.00                        | 0.00                              | 4000.00     | 28743.00   |
And 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 6743.00                          | 5500.00                           | 8500.00                     | 20743.00 |
| First Presentation | 6743.00                          | 9000.00                           | 13000.00                    | 28743.00 |
When I login with details of 'CostConsultant'
And 'Approve' the cost with title 'PLINCSIFPTCT1'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'PLINCSIFPTCT1'
And I login with details of 'CycloneCostOwner'
And I am on cost review page of cost item with title 'PLINCSIFPTCT1'
And click 'Create Revision' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PLINCSIFPTCT1':
| Talent fees | Offline edits |
| 3000        | 3000          |
And I upload following supporting documents to cost title 'PLINCSIFPTCT1':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'PLINCSIFPTCT1'
And I am on cost review page of cost item with title 'PLINCSIFPTCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 6743.00                          | 5500.00                           | 8500.00                     | 20743.00 |
| First Presentation | 6743.00                          | 9000.00                           | 13000.00                    | 28743.00 |
When I login with details of 'CostConsultant'
And 'Approve' the cost with title 'PLINCSIFPTCT1'
And login with details of 'CycloneCostOwner'
And I am on cost review page of cost item with title 'PLINCSIFPTCT1'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PLINCSIFPTCT1':
| Insurance (if not covered by P&G) |
| 3000                              |
And I upload following supporting documents to cost title 'PLINCSIFPTCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'PLINCSIFPTCT1'
And I am on cost review page of cost item with title 'PLINCSIFPTCT1'
Then I should see following data in payment line items on payment summary page:
| Stage              | PRODUCTION COST | TALENT FEES | POST PRODUCTION COST | TECHNICAL FEE (IF APPLICABLE) | INSURANCE (IF NOT COVERED BY P&G) | OTHER COSTS | Cost Total |
| Final Actual       | 0.00            | 3000.00     | 11000.00             | 743.00                        | 3000.00                           | 4000.00     | 21743.00   |
And 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 6743.00                          | 5500.00                           | 8500.00                     | 20743.00 |
| First Presentation | 6743.00                          | 9000.00                           | 13000.00                    | 28743.00 |
| Final Actual       | 6743.00                          | 9000.00                           | 6000.00                     | 21743.00 |


Scenario: Check Cyclone Payment Line Group Rules for Still Image Content Type and Full Production type
Meta:@adcost
     @costCreationWithRevisions
     @paymentLineGroupRules
!--QA-697
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number            | Cost Title     | Description  | Agency Producer/Art| Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | PLINCSIFPTCT2  | PLINCSIFPTD2 | Aaron Royer (Grey) | 20000                | Still Image  | Full Production | PLINCSIFPTATN2         | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PLINCSIFPTCT2' with following fields:
| Talent Company      | Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Retouching Company  |
| GlobalDefaultVendor | GlobalDefaultVendor  | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | GlobalDefaultVendor |
And added expected asset details for cost title 'PLINCSIFPTCT2':
| Initiative | Asset Title  | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | PLINCSIFPTAT2 | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'PLINCSIFPTCT2':
| Preproduction | Insurance (if not covered by P&G) | Retouching | Agency Travel | FX (Loss) & Gain |
| 30000         | 12000                             | 36000      | 10000         | 8000             |
And uploaded following supporting documents to cost title 'PLINCSIFPTCT2' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
And added below approvers for cost title 'PLINCSIFPTCT2':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PLINCSIFPTCT2'
Then I should see following data in payment line items on payment summary page:
| Stage             | STILL IMAGE PRODUCTION COST | TALENT FEES | STILL IMAGE POST PRODUCTION COST | TECHNICAL FEE (IF APPLICABLE) | INSURANCE (IF NOT COVERED BY P&G) | OTHER COSTS | Cost Total |
| Original Estimate | 30000.00                    | 0.00        | 36000.00                         | 0.00                          | 12000.00                          | 18000.00    | 96000.00   |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total  |
| Original Estimate | 27000.00                         | 33000.00                          | 36000.00                    | 96000.00  |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PLINCSIFPTCT2'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'PLINCSIFPTCT2'
And I login with details of 'CycloneCostOwner'
And I 'CreateRevision' the cost with title 'PLINCSIFPTCT2'
And add cost item details for cost title 'PLINCSIFPTCT2' with 'USD' currency:
| Talent fees   | Artwork/packs | P&G insurance      |
| 10000         | 12000         | 8000               |
And I upload following supporting documents to cost title 'PLINCSIFPTCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'PLINCSIFPTCT2'
And I am on cost review page of cost item with title 'PLINCSIFPTCT2'
Then 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total  |
| Original Estimate | 27000.00                         | 33000.00                          | 36000.00                    | 96000.00  |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PLINCSIFPTCT2'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'PLINCSIFPTCT2'
And I login with details of 'CycloneCostOwner'
And I 'NextStage' the cost with title 'PLINCSIFPTCT2'
And fill Cost Line Items with following fields for cost title 'PLINCSIFPTCT2':
| Talent fees   | Artwork/packs | P&G insurance      |
| 11000         | 14000         | 9000               |
And I upload following supporting documents to cost title 'PLINCSIFPTCT2':
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
| /files/EditWord.doc | Scope change approval form            |
And 'Submit' the cost with title 'PLINCSIFPTCT2'
And I am on cost review page of cost item with title 'PLINCSIFPTCT2'
Then I should see following data in payment line items on payment summary page:
| Stage              | STILL IMAGE PRODUCTION COST | TALENT FEES | STILL IMAGE POST PRODUCTION COST | TECHNICAL FEE (IF APPLICABLE) | INSURANCE (IF NOT COVERED BY P&G) | OTHER COSTS | Cost Total |
| First Presentation | 30000.00                    | 11000.00    | 50000.00                         | 0.00                          | 12000.00                          | 27000.00    | 130000.00  |
And I 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 27000.00                         | 33000.00                          | 36000.00                    | 96000.00 |
| First Presentation | 27000.00                         | 51000.00                          | 52000.00                    | 130000.00|
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PLINCSIFPTCT2'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'PLINCSIFPTCT2'
When I login with details of 'CycloneCostOwner'
And I 'CreateRevision' the cost with title 'PLINCSIFPTCT2'
And fill Cost Line Items with following fields for cost title 'PLINCSIFPTCT2':
| Insurance (if not covered by P&G) | Agency Travel |
| 10000                             | 5000          |
And I upload following supporting documents to cost title 'PLINCSIFPTCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'PLINCSIFPTCT2'
And I am on cost review page of cost item with title 'PLINCSIFPTCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 27000.00                         | 33000.00                          | 36000.00                    | 96000.00 |
| First Presentation | 27000.00                         | 51000.00                          | 52000.00                    | 130000.00|
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PLINCSIFPTCT2'
And login with details of 'CycloneCostOwner'
And I 'NextStage' the cost with title 'PLINCSIFPTCT2'
And I upload following supporting documents to cost title 'PLINCSIFPTCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'PLINCSIFPTCT2'
And I am on cost review page of cost item with title 'PLINCSIFPTCT2'
Then I should see following data in payment line items on payment summary page:
| Stage        | STILL IMAGE PRODUCTION COST | TALENT FEES | STILL IMAGE POST PRODUCTION COST | TECHNICAL FEE (IF APPLICABLE) | INSURANCE (IF NOT COVERED BY P&G) | OTHER COSTS | Cost Total |
| Final Actual | 30000.00                    | 11000.00    | 50000.00                         | 0.00                          | 10000.00                          | 22000.00    | 123000.00  |
And 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 27000.00                         | 33000.00                          | 36000.00                    | 96000.00 |
| First Presentation | 27000.00                         | 51000.00                          | 52000.00                    | 130000.00|
| Final Actual       | 27000.00                         | 51000.00                          | 45000.00                    | 123000.00|


