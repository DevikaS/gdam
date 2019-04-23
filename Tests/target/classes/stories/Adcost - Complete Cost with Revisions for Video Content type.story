Feature: Increase Grand total in each stage submission
Narrative:
In order to
As a CostOwner
I want to check Cost creation and completion by increasing Grand total in each stage submission


Scenario: Check cost completion for Video Content Type and Post Production with revisions in each stage
Meta:@adcost
     @costCreationWithRevisions
     @adcostSmokeUAT
!--QA-727
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CCRVCTCT1  | CCRVCTD1    | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | CCRVCTATN1             | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCRVCTCT1' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CCRVCTCT1':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CCRVCTAT1   | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CCRVCTCT1':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And uploaded following supporting documents to cost title 'CCRVCTCT1' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CCRVCTCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CCRVCTCT1'
And I am on cost review page of cost item with title 'CCRVCTCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate Local | Original Estimate |
| Offline edits                        | $ 3,000.00             | $ 3,000.00       |
| Audio finalization                   | $ 8,000.00             | $ 8,000.00       |
| SUBTOTAL POST PRODUCTION COST        | $ 11,000.00            | $ 11,000.00      |
| Agency travel                        | $ 3,000.00             | $ 3,000.00       |
| SUBTOTAL AGENCY COSTS                | $ 3,000.00             | $ 3,000.00       |
| Grand Total                          | $  14,000.00           | $  14,000.00     |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 14000.00                    | 14000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCTCT1'
And cost with title 'CCRVCTCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRVCTCT1'
And click 'Create Revision' button and 'Confirm' on cost review page
And I add cost item details for cost title 'CCRVCTCT1' with 'USD' currency:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 10000         | 3000          | 1234567890                        |
And I upload following supporting documents to cost title 'CCRVCTCT1':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCRVCTCT1'
And I am on cost review page of cost item with title 'CCRVCTCT1'
And refresh the page without delay
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate | Current Revision Local | Current Revision |
| Offline edits                 | $ 3,000.00        | $ 10,000.00            | $ 10,000.00      |
| Audio finalization            | $ 8,000.00        | $ 8,000.00             | $ 8,000.00       |
| SUBTOTAL POST PRODUCTION COST | $ 11,000.00       | $ 18,000.00            | $ 18,000.00      |
| Agency travel                 | $ 3,000.00        | $ 3,000.00             | $ 3,000.00       |
| SUBTOTAL AGENCY COSTS         | $ 3,000.00        | $ 3,000.00             | $ 3,000.00       |
| Grand Total                   | $  14,000.00      | $  21,000.00           | $  21,000.00     |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 14000.00                    | 14000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCTCT1'
And cost with title 'CCRVCTCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRVCTCT1'
And click 'Next Stage' button and 'Confirm' on cost review page
And I fill Cost Line Items with following fields for cost title 'CCRVCTCT1':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 5000               | 13000         | 4000          | 1234567890                        |
And I upload following supporting documents to cost title 'CCRVCTCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'CCRVCTCT1'
And I am on cost review page of cost item with title 'CCRVCTCT1'
And refresh the page without delay
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate | Final Actual Local | Final Actual |
| Offline edits                 | $ 3,000.00        | $ 13,000.00        | $ 13,000.00  |
| Audio finalization            | $ 8,000.00        | $ 5,000.00         | $ 5,000.00   |
| SUBTOTAL POST PRODUCTION COST | $ 11,000.00       | $ 18,000.00        | $ 18,000.00  |
| Agency travel                 | $ 3,000.00        | $ 4,000.00         | $ 4,000.00   |
| SUBTOTAL AGENCY COSTS         | $ 3,000.00        | $ 4,000.00         | $ 4,000.00   |
| Grand Total                   | $  14,000.00      | $  22,000.00       | $  22,000.00 |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 14000.00                    | 14000.00 |
| Final Actual      | 0.00                             | 22000.00                    | 22000.00 |


Scenario: Check cost completion for Video Content Type and Full Production with revisions in each stage
Meta:@adcost
     @costCreationWithRevisions
     @adcostCriticalTests
     @adcostSmokeUAT
     @adcostSmoke
!--QA-727
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number      | Cost Title | Description | Agency Producer/Art  | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject  | CCRVCTCT2  | CCRVCTD1    | Aaron Royer (Grey)   | 9000                 | Video        | Full Production | CCRVCTATN2             | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCRVCTCT2' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CCRVCTCT2':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CCRVCTAT2   | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CCRVCTCT2':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And uploaded following supporting documents to cost title 'CCRVCTCT2' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'CCRVCTCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'CCRVCTCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate Local | Original Estimate |
| Offline edits                 | $ 3,000.00              | $ 3,000.00        |
| Audio finalization            | $ 8,000.00              | $ 8,000.00        |
| SUBTOTAL POST PRODUCTION COST | $ 11,000.00             | $ 11,000.00       |
| Agency travel                 | $ 3,000.00              | $ 3,000.00        |
| SUBTOTAL AGENCY COSTS         | $ 3,000.00              | $ 3,000.00        |
| Grand Total                   | $  14,000.00            | $  14,000.00      |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 5500.00                           | 8500.00                     | 14000.00 |
When I login with details of 'IPMuser'
And I am on costs overview page
And 'Approve' the cost with title 'CCRVCTCT2'
Then I should see AMQ receives below request for cost title 'CCRVCTCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 14000        | 0              | USD      | 1234567890 | DefaultBrand | CCRVCTD1    | brandDescription |
When cost with title 'CCRVCTCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRVCTCT2'
And click 'Create Revision' button and 'Confirm' on cost review page
And I add cost item details for cost title 'CCRVCTCT2' with 'USD' currency:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 10000         | 3000          | 1234567890                        |
And I upload following supporting documents to cost title 'CCRVCTCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCRVCTCT2'
And I am on cost review page of cost item with title 'CCRVCTCT2'
And refresh the page without delay
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate | Current Revision Local | Current Revision |
| Offline edits                 | $ 3,000.00        | $ 10,000.00            | $ 10,000.00      |
| Audio finalization            | $ 8,000.00        | $ 8,000.00             | $ 8,000.00       |
| SUBTOTAL POST PRODUCTION COST | $ 11,000.00       | $ 18,000.00            | $ 18,000.00      |
| Agency travel                 | $ 3,000.00        | $ 3,000.00             | $ 3,000.00       |
| SUBTOTAL AGENCY COSTS         | $ 3,000.00        | $ 3,000.00             | $ 3,000.00       |
| Grand Total                   | $  14,000.00      | $  21,000.00           | $  21,000.00     |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 5500.00                           | 8500.00                     | 14000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCTCT2'
Then I should see AMQ receives below request for cost title 'CCRVCTCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 21000        | 0              | USD      | 1234567890 | DefaultBrand | CCRVCTD1    | brandDescription |
When cost with title 'CCRVCTCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRVCTCT2'
And I 'NextStage' the cost with title 'CCRVCTCT2'
And I fill Cost Line Items with following fields for cost title 'CCRVCTCT2':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 10000         | 4000          | 1234567890                        |
And I upload following supporting documents to cost title 'CCRVCTCT2':
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
| /files/EditWord.doc | Scope change approval form            |
And 'Submit' the cost with title 'CCRVCTCT2'
And I am on cost review page of cost item with title 'CCRVCTCT2'
And refresh the page without delay
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 0.00                             | 5500.00                           | 8500.00                     | 14000.00 |
| First Presentation | 0.00                             | 9000.00                           | 13000.00                    | 22000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCTCT2'
Then I should see AMQ receives below request for cost title 'CCRVCTCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 22000        | 9000           | USD      | 1234567890 | DefaultBrand | CCRVCTD1    | brandDescription |
When cost with title 'CCRVCTCT2' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'CCRVCTCT2' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand       | Description | Basket Name      |
| 22000        | 9000           | USD      | 1234567890 | DefaultBrand | CCRVCTD1    | brandDescription |
When I login with details of 'CostOwner'
And I 'CreateRevision' the cost with title 'CCRVCTCT2'
And I add cost item details for cost title 'CCRVCTCT2' with 'USD' currency:
| Talent fees | Offline edits |
| 3000        | 3000          |
And I upload following supporting documents to cost title 'CCRVCTCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCRVCTCT2'
And I am on cost review page of cost item with title 'CCRVCTCT2'
And wait for '3' seconds
And refresh the page without delay
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate | Current Revision Local | Current Revision |
| Talent fees                   | $ 0.00            | $ 3,000.00             | $ 3,000.00       |
| SUBTOTAL PRODUCTION COST      | $ 0.00            | $ 3,000.00             | $ 3,000.00       |
| Offline edits                 | $ 3,000.00        | $ 3,000.00             | $ 3,000.00       |
| Audio finalization            | $ 8,000.00        | $ 8,000.00             | $ 8,000.00       |
| SUBTOTAL POST PRODUCTION COST | $ 11,000.00       | $ 11,000.00            | $ 11,000.00      |
| Agency travel                 | $ 3,000.00        | $ 4,000.00             | $ 4,000.00       |
| SUBTOTAL AGENCY COSTS         | $ 3,000.00        | $ 4,000.00             | $ 4,000.00       |
| Grand Total                   | $  14,000.00      | $  18,000.00           | $  18,000.00     |
And 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 0.00                             | 5500.00                           | 8500.00                     | 14000.00 |
| First Presentation | 0.00                             | 9000.00                           | 13000.00                    | 22000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCTCT2'
And login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRVCTCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And I upload following supporting documents to cost title 'CCRVCTCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'CCRVCTCT2'
And wait for '3' seconds
And I am on cost review page of cost item with title 'CCRVCTCT2'
And refresh the page without delay
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate | Final Actual Local | Final Actual |
| Talent fees                   | $ 0.00            | $ 3,000.00         | $ 3,000.00   |
| SUBTOTAL PRODUCTION COST      | $ 0.00            | $ 3,000.00         | $ 3,000.00   |
| Offline edits                 | $ 3,000.00        | $ 3,000.00         | $ 3,000.00   |
| Audio finalization            | $ 8,000.00        | $ 8,000.00         | $ 8,000.00   |
| SUBTOTAL POST PRODUCTION COST | $ 11,000.00       | $ 11,000.00        | $ 11,000.00  |
| Agency travel                 | $ 3,000.00        | $ 4,000.00         | $ 4,000.00   |
| SUBTOTAL AGENCY COSTS         | $ 3,000.00        | $ 4,000.00         | $ 4,000.00   |
| Grand Total                   | $  14,000.00      | $  18,000.00       | $  18,000.00 |
And 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 0.00                             | 5500.00                           | 8500.00                     | 14000.00 |
| First Presentation | 0.00                             | 9000.00                           | 13000.00                    | 22000.00 |
| Final Actual       | 0.00                             | 9000.00                           | 9000.00                     | 18000.00 |


Scenario: Check cost completion for Video Content Type and CGI/Animation with revisions in each stage
Meta:@adcost
     @costCreationWithRevisions
!--QA-727
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject  | CCRVCTCT3  | CCRVCTD3    | Aaron Royer (Grey) | 9000                 | Video        | CGI/Animation   | CCRVCTATN3             | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCRVCTCT3' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CCRVCTCT3':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CCRVCTAT1   | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CCRVCTCT3':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And uploaded following supporting documents to cost title 'CCRVCTCT3':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CCRVCTCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CCRVCTCT3'
And I am on cost review page of cost item with title 'CCRVCTCT3'
Then I should see following data in cost section on Cost Review page:
| Section Name                   | Original Estimate Local | Original Estimate |
| Offline edits                  | $ 3,000.00              | $ 3,000.00        |
| Audio finalization             | $ 8,000.00              | $ 8,000.00        |
| SUBTOTAL POST PRODUCTION COST  | $ 11,000.00             | $ 11,000.00       |
| Agency travel                  | $ 3,000.00              | $ 3,000.00        |
| SUBTOTAL AGENCY COSTS          | $ 3,000.00              | $ 3,000.00        |
| Grand Total                    | $  14,000.00            | $  14,000.00      |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 14000.00                    | 14000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCTCT3'
And cost with title 'CCRVCTCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'CreateRevision' the cost with title 'CCRVCTCT3'
And fill Cost Line Items with following fields for cost title 'CCRVCTCT3':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 10000         | 3000          | 1234567890                        |
And I upload following supporting documents to cost title 'CCRVCTCT3':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCRVCTCT3'
And I am on cost review page of cost item with title 'CCRVCTCT3'
Then I should see following data in cost section on Cost Review page:
| Section Name                   | Original Estimate | Current Revision Local | Current Revision |
| Offline edits                  | $ 3,000.00        | $ 10,000.00            | $ 10,000.00      |
| Audio finalization             | $ 8,000.00        | $ 8,000.00             | $ 8,000.00       |
| SUBTOTAL POST PRODUCTION COST  | $ 11,000.00       | $ 18,000.00            | $ 18,000.00      |
| Agency travel                  | $ 3,000.00        | $ 3,000.00             | $ 3,000.00       |
| SUBTOTAL AGENCY COSTS          | $ 3,000.00        | $ 3,000.00             | $ 3,000.00       |
| Grand Total                    | $  14,000.00      | $  21,000.00           | $  21,000.00     |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 14000.00                    | 14000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCTCT3'
And cost with title 'CCRVCTCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRVCTCT3'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'CCRVCTCT3':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 5000               | 13000         | 4000          | 1234567890                        |
And I upload following supporting documents to cost title 'CCRVCTCT3':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'CCRVCTCT3'
And I am on cost review page of cost item with title 'CCRVCTCT3'
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate | Final Actual Local | Final Actual |
| Offline edits                 | $ 3,000.00        | $ 13,000.00        | $ 13,000.00  |
| Audio finalization            | $ 8,000.00        | $ 5,000.00         | $ 5,000.00   |
| SUBTOTAL POST PRODUCTION COST | $ 11,000.00       | $ 18,000.00        | $ 18,000.00  |
| Agency travel                 | $ 3,000.00        | $ 4,000.00         | $ 4,000.00   |
| SUBTOTAL AGENCY COSTS         | $ 3,000.00        | $ 4,000.00         | $ 4,000.00   |
| Grand Total                   | $  14,000.00      | $  22,000.00       | $  22,000.00 |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 14000.00                    | 14000.00 |
| Final Actual      | 0.00                             | 22000.00                    | 22000.00 |