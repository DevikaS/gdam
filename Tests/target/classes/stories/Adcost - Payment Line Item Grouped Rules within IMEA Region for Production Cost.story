Feature: Payment Rules in Cost module
Narrative:
In order to
As a CostOwner
I want to check Payments group line items for each stage


Scenario: Check payment group line items for Video Content Type and Full Production with revisions in each stage
Meta:@adcost
     @costCreationWithRevisions
!--QA-727, QA-695
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number      | Cost Title   | Description   | Agency Producer/Art   | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject  | PLIGRIPCCT1  | PLIGRIPCD1    | Aaron Royer (Grey)    | 9000                 | Video        | Full Production | PLIGRIPCATN2           | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PLIGRIPCCT1' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'PLIGRIPCCT1':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | PLIGRIPCAT2   | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'PLIGRIPCCT1':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And uploaded following supporting documents to cost title 'PLIGRIPCCT1' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'PLIGRIPCCT1':
| Technical Approver | Coupa Requisitioner       |
| CostConsultant     | BrandManagementApprover   |
And I refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PLIGRIPCCT1'
Then I should see following data in payment line items on payment summary page:
| Stage             | PRODUCTION COST | POST PRODUCTION COST | TECHNICAL FEE (IF APPLICABLE) | INSURANCE (IF NOT COVERED BY P&G) | OTHER COSTS | Cost Total |
| Original Estimate | 0.00            | 11000.00             | 548.25                        | 0.00                              | 3000.00     | 14548.25   |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 548.25                           | 5500.00                           | 8500.00                     | 14548.25 |
When I login with details of 'CostConsultant'
And 'Approve' the cost with title 'PLIGRIPCCT1'
And cost with title 'PLIGRIPCCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PLIGRIPCCT1'
And click 'Create Revision' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PLIGRIPCCT1':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 10000         | 3000          | 1234567890                        |
And I upload following supporting documents to cost title 'PLIGRIPCCT1':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'PLIGRIPCCT1'
And I am on cost review page of cost item with title 'PLIGRIPCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 548.25                           | 5500.00                           | 8500.00                     | 14548.25 |
When I login with details of 'CostConsultant'
And 'Approve' the cost with title 'PLIGRIPCCT1'
And cost with title 'PLIGRIPCCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PLIGRIPCCT1'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PLIGRIPCCT1':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 10000         | 4000          | 1234567890                        |
And I upload following supporting documents to cost title 'PLIGRIPCCT1':
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
| /files/EditWord.doc | Scope change approval form            |
And 'Submit' the cost with title 'PLIGRIPCCT1'
And I am on cost review page of cost item with title 'PLIGRIPCCT1'
Then I should see following data in payment line items on payment summary page:
| Stage              | PRODUCTION COST | POST PRODUCTION COST | TECHNICAL FEE (IF APPLICABLE) | INSURANCE (IF NOT COVERED BY P&G) | OTHER COSTS | Cost Total |
| First Presentation | 0.00            | 18000.00             | 548.25                        | 0.00                              | 4000.00     | 22548.25   |
And 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 548.25                           | 5500.00                           | 8500.00                     | 14548.25 |
| First Presentation | 548.25                           | 9000.00                           | 13000.00                    | 22548.25 |
When I login with details of 'CostConsultant'
And 'Approve' the cost with title 'PLIGRIPCCT1'
And cost with title 'PLIGRIPCCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PLIGRIPCCT1'
And click 'Create Revision' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PLIGRIPCCT1':
| Talent fees | Offline edits |
| 3000        | 3000          |
And I upload following supporting documents to cost title 'PLIGRIPCCT1':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'PLIGRIPCCT1'
And I am on cost review page of cost item with title 'PLIGRIPCCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 548.25                           | 5500.00                           | 8500.00                     | 14548.25 |
| First Presentation | 548.25                           | 9000.00                           | 13000.00                    | 22548.25 |
When I login with details of 'CostConsultant'
And 'Approve' the cost with title 'PLIGRIPCCT1'
And login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PLIGRIPCCT1'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PLIGRIPCCT1':
| Insurance (if not covered by P&G) |
| 3000                              |
And I upload following supporting documents to cost title 'PLIGRIPCCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'PLIGRIPCCT1'
And I am on cost review page of cost item with title 'PLIGRIPCCT1'
Then I should see following data in payment line items on payment summary page:
| Stage              | PRODUCTION COST | POST PRODUCTION COST | TECHNICAL FEE (IF APPLICABLE) | INSURANCE (IF NOT COVERED BY P&G) | OTHER COSTS | Cost Total |
| Final Actual       | 3000.00         | 11000.00             | 548.25                        | 3000.00                           | 4000.00     | 21548.25   |
And 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 548.25                           | 5500.00                           | 8500.00                     | 14548.25 |
| First Presentation | 548.25                           | 9000.00                           | 13000.00                    | 22548.25 |
| Final Actual       | 548.25                           | 9000.00                           | 12000.00                    | 21548.25 |


Scenario: Check payment group line items for StillImage and Full Production with revisions in each stage
Meta:@adcost
     @costCreationWithRevisions
!--QA-727, QA-695
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description  | Agency Producer/Art           | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | PLIGRIPCCT2 | PLIGRIPCD4   | Christine Meyer (Leo Burnett) | 20000                | Still Image  | Full Production | PLIGRIPCATN6           | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'PLIGRIPCCT2' with following fields:
| Talent Company      | Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Retouching Company  |
| GlobalDefaultVendor | GlobalDefaultVendor  | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | GlobalDefaultVendor |
And added expected asset details for cost title 'PLIGRIPCCT2':
| Initiative | Asset Title  |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | PLIGRIPCAT6  |  Version | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'PLIGRIPCCT2':
| Preproduction | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000         | 12000      | 8000             | 1234567890                        |
And uploaded following supporting documents to cost title 'PLIGRIPCCT2' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'PLIGRIPCCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'PLIGRIPCCT2'
Then I should see following data in payment line items on payment summary page:
| Stage             | STILL IMAGE PRODUCTION COST | STILL IMAGE POST PRODUCTION COST | TECHNICAL FEE (IF APPLICABLE) | INSURANCE (IF NOT COVERED BY P&G) | OTHER COSTS | Cost Total |
| Original Estimate | 10000.00                    | 12000.00                         | 0.00                          | 0.00                              | 8000.00     | 30000.00   |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 5000.00                          | 11000.00                          | 14000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PLIGRIPCCT2'
And cost with title 'PLIGRIPCCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PLIGRIPCCT2'
And click 'Create Revision' button and 'Confirm' on cost review page
And add cost item details for cost title 'PLIGRIPCCT2' with 'USD' currency:
| Talent fees   | Artwork/packs | P&G insurance      | Please enter a 10-digit IO number |
| 10000         | 12000         | 8000               | 1234567890                        |
And I upload following supporting documents to cost title 'PLIGRIPCCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'PLIGRIPCCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'PLIGRIPCCT2'
And I am on cost review page of cost item with title 'PLIGRIPCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 5000.00                          | 11000.00                          | 14000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PLIGRIPCCT2'
And cost with title 'PLIGRIPCCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PLIGRIPCCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'PLIGRIPCCT2':
| Talent fees   | Artwork/packs | P&G insurance      | Please enter a 10-digit IO number |
| 11000         | 15000         | 9000               | 1234567890                        |
And I upload following supporting documents to cost title 'PLIGRIPCCT2':
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
| /files/EditWord.doc | Scope change approval form            |
And add below approvers for cost title 'PLIGRIPCCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'PLIGRIPCCT2'
And I am on cost review page of cost item with title 'PLIGRIPCCT2'
Then I should see following data in payment line items on payment summary page:
| Stage              | STILL IMAGE PRODUCTION COST | STILL IMAGE POST PRODUCTION COST | TECHNICAL FEE (IF APPLICABLE) | INSURANCE (IF NOT COVERED BY P&G) | OTHER COSTS | Cost Total |
| First Presentation | 21000.00                    | 27000.00                         | 0.00                          | 0.00                              | 17000.00    | 65000.00   |
And 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 5000.00                          | 11000.00                          | 14000.00                    | 30000.00 |
| First Presentation | 5000.00                          | 29500.00                          | 30500.00                    | 65000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PLIGRIPCCT2'
And cost with title 'PLIGRIPCCT2' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PLIGRIPCCT2'
And click 'Create Revision' button and 'Confirm' on cost review page
And add cost item details for cost title 'PLIGRIPCCT2' with 'USD' currency:
| Insurance (if not covered by P&G) |  Agency Travel | Please enter a 10-digit IO number |
| 10000                             | 5000           | 1234567890                        |
And I upload following supporting documents to cost title 'PLIGRIPCCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'PLIGRIPCCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'PLIGRIPCCT2'
And I am on cost review page of cost item with title 'PLIGRIPCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 5000.00                          | 11000.00                          | 14000.00                    | 30000.00 |
| First Presentation | 5000.00                          | 29500.00                          | 30500.00                    | 65000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'PLIGRIPCCT2'
And cost with title 'PLIGRIPCCT2' is 'Approve' on behalf of MyPurchases application
And login with details of 'CostOwner'
And I am on cost review page of cost item with title 'PLIGRIPCCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And I upload following supporting documents to cost title 'PLIGRIPCCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'PLIGRIPCCT2':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'PLIGRIPCCT2'
And I am on cost review page of cost item with title 'PLIGRIPCCT2'
Then I should see following data in payment line items on payment summary page:
| Stage              | STILL IMAGE PRODUCTION COST | STILL IMAGE POST PRODUCTION COST | TECHNICAL FEE (IF APPLICABLE) | INSURANCE (IF NOT COVERED BY P&G) | OTHER COSTS | Cost Total |
| Final Actual       | 21000.00                    | 27000.00                         | 0.00                          | 10000.00                          | 22000.00    | 80000.00   |
And I 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 5000.00                          | 11000.00                          | 14000.00                    | 30000.00 |
| First Presentation | 5000.00                          | 29500.00                          | 30500.00                    | 65000.00 |
| Final Actual       | 5000.00                          | 29500.00                          | 45500.00                    | 80000.00 |