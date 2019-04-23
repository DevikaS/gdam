Feature: Increase Grand total in each stage submission
Narrative:
In order to
As a CycloneCostOwner
I want to check Cost creation and completion by increasing Grand total in each stage submission


Scenario: Check Cyclone cost completion for Video Content Type and Post Production with revisions in each stage
Meta:@adcost
     @costCreationWithRevisions
     @adcostCycloneCosts
!--QA-727
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number            | Cost Title  | Description  | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | CCPCVDCTCT1 | CCPCVDCTD1   | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | CCPCVDCTATN1           | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCPCVDCTCT1' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CCPCVDCTCT1':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CCPCVDCTAT1  | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CCPCVDCTCT1':
| Audio finalization | Offline edits | Agency travel |
| 8000               | 3000          | 3000          |
And uploaded following supporting documents to cost title 'CCPCVDCTCT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CCPCVDCTCT1':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CCPCVDCTCT1'
And I am on cost review page of cost item with title 'CCPCVDCTCT1'
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
And 'Approve' the cost with title 'CCPCVDCTCT1'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCVDCTCT1'
And I login with details of 'CycloneCostOwner'
And I 'CreateRevision' the cost with title 'CCPCVDCTCT1'
And add cost item details for cost title 'CCPCVDCTCT1' with 'USD' currency:
| Audio finalization | Offline edits | Agency travel |
| 8000               | 10000         | 3000          |
And I upload following supporting documents to cost title 'CCPCVDCTCT1':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCPCVDCTCT1'
And I am on cost review page of cost item with title 'CCPCVDCTCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Current Revision Local  | Current Revision |
| Offline edits                        | $ 3,000.00        | $ 10,000.00             | $ 10,000.00              |
| Audio finalization                   | $ 8,000.00        | $ 8,000.00              | $ 8,000.00               |
| SUBTOTAL POST PRODUCTION COST        | $ 11,000.00       | $ 18,000.00             | $ 18,000.00              |
| Agency travel                        | $ 3,000.00        | $ 3,000.00              | $ 3,000.00               |
| SUBTOTAL AGENCY COSTS                | $ 3,000.00        | $ 3,000.00              | $ 3,000.00               |
| Grand Total                          | $  14,000.00      | $  21,000.00            | $  21,000.00             |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 14000.00                    | 14000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCPCVDCTCT1'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCVDCTCT1'
And I login with details of 'CycloneCostOwner'
And I 'NextStage' the cost with title 'CCPCVDCTCT1'
And fill Cost Line Items with following fields for cost title 'CCPCVDCTCT1':
| Audio finalization | Offline edits | Agency travel |
| 5000               | 13000         | 4000          |
And I upload following supporting documents to cost title 'CCPCVDCTCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'CCPCVDCTCT1'
And I am on cost review page of cost item with title 'CCPCVDCTCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Final Actual Local | Final Actual |
| Offline edits                        | $ 3,000.00        | $ 13,000.00        | $ 13,000.00  |
| Audio finalization                   | $ 8,000.00        | $ 5,000.00         | $ 5,000.00   |
| SUBTOTAL POST PRODUCTION COST        | $ 11,000.00       | $ 18,000.00        | $ 18,000.00  |
| Agency travel                        | $ 3,000.00        | $ 4,000.00         | $ 4,000.00   |
| SUBTOTAL AGENCY COSTS                | $ 3,000.00        | $ 4,000.00         | $ 4,000.00   |
| Grand Total                          | $  14,000.00      | $  22,000.00       | $  22,000.00 |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 14000.00                    | 14000.00 |
| Final Actual      | 0.00                             | 22000.00                    | 22000.00 |


Scenario: Check Cyclone cost completion for Video Content Type and Full Production with revisions in each stage
Meta:@adcost
     @costCreationWithRevisions
     @adcostCycloneCosts
!--QA-746
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number            | Cost Title  | Description  | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | CCPCVDCTCT2  | CCPCVDCTD1  | Aaron Royer (Grey)  | 9000                 | Video        | Full Production | CCPCVDCTATN2           | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCPCVDCTCT2' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CCPCVDCTCT2':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CCPCVDCTAT2   | 10:10:10         | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CCPCVDCTCT2':
| Audio finalization | Offline edits | Agency travel |
| 8000               | 3000          | 3000          |
And uploaded following supporting documents to cost title 'CCPCVDCTCT2' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'CCPCVDCTCT2':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
And I refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'CCPCVDCTCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate Local | Original Estimate |
| Offline edits                        | $ 3,000.00             | $ 3,000.00       |
| Audio finalization                   | $ 8,000.00             | $ 8,000.00       |
| SUBTOTAL POST PRODUCTION COST        | $ 11,000.00            | $ 11,000.00      |
| Agency travel                        | $ 3,000.00             | $ 3,000.00       |
| SUBTOTAL AGENCY COSTS                | $ 3,000.00             | $ 3,000.00       |
| Grand Total                          | $  14,000.00           | $  14,000.00     |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 5500.00                           | 8500.00                     | 14000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCPCVDCTCT2'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCVDCTCT2'
And I login with details of 'CycloneCostOwner'
And I 'CreateRevision' the cost with title 'CCPCVDCTCT2'
And fill Cost Line Items with following fields for cost title 'CCPCVDCTCT2':
| Audio finalization | Offline edits | Agency travel |
| 8000               | 10000         | 3000          |
And I upload following supporting documents to cost title 'CCPCVDCTCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCPCVDCTCT2'
And I am on cost review page of cost item with title 'CCPCVDCTCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Current Revision Local           | Current Revision |
| Offline edits                        | $ 3,000.00        | $ 10,000.00                      | $ 10,000.00                |
| Audio finalization                   | $ 8,000.00        | $ 8,000.00                       | $ 8,000.00                 |
| SUBTOTAL POST PRODUCTION COST        | $ 11,000.00       | $ 18,000.00                      | $ 18,000.00                |
| Agency travel                        | $ 3,000.00        | $ 3,000.00                       | $ 3,000.00                 |
| SUBTOTAL AGENCY COSTS                | $ 3,000.00        | $ 3,000.00                       | $ 3,000.00                 |
| Grand Total                          | $  14,000.00      | $  21,000.00                     | $  21,000.00               |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 5500.00                           | 8500.00                     | 14000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCPCVDCTCT2'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCVDCTCT2'
And I login with details of 'CycloneCostOwner'
And I 'NextStage' the cost with title 'CCPCVDCTCT2'
And fill Cost Line Items with following fields for cost title 'CCPCVDCTCT2':
| Audio finalization | Offline edits | Agency travel |
| 8000               | 10000         | 4000          |
And I upload following supporting documents to cost title 'CCPCVDCTCT2':
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
| /files/EditWord.doc | Scope change approval form            |
And 'Submit' the cost with title 'CCPCVDCTCT2'
And I am on cost review page of cost item with title 'CCPCVDCTCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | First Presentation Local | First Presentation |
| Offline edits                        | $ 3,000.00        | $ 10,000.00              | $ 10,000.00        |
| Audio finalization                   | $ 8,000.00        | $ 8,000.00               | $ 8,000.00         |
| SUBTOTAL POST PRODUCTION COST        | $ 11,000.00       | $ 18,000.00              | $ 18,000.00        |
| Agency travel                        | $ 3,000.00        | $ 4,000.00               | $ 4,000.00         |
| SUBTOTAL AGENCY COSTS                | $ 3,000.00        | $ 4,000.00               | $ 4,000.00         |
| Grand Total                          | $  14,000.00      | $  22,000.00             | $  22,000.00       |
And 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 0.00                             | 5500.00                           | 8500.00                     | 14000.00 |
| First Presentation | 0.00                             | 9000.00                           | 13000.00                    | 22000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCPCVDCTCT2'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCVDCTCT2'
When I login with details of 'CycloneCostOwner'
And I 'CreateRevision' the cost with title 'CCPCVDCTCT2'
And fill Cost Line Items with following fields for cost title 'CCPCVDCTCT2':
| Talent fees | Offline edits |
| 3000        | 3000          |
And I upload following supporting documents to cost title 'CCPCVDCTCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCPCVDCTCT2'
And I am on cost review page of cost item with title 'CCPCVDCTCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Current Revision Local             | Current Revision |
| Talent fees                          | $ 0.00            | $ 3,000.00                         | $ 3,000.00                  |
| SUBTOTAL PRODUCTION COST             | $ 0.00            | $ 3,000.00                         | $ 3,000.00                  |
| Offline edits                        | $ 3,000.00        | $ 3,000.00                         | $ 3,000.00                  |
| Audio finalization                   | $ 8,000.00        | $ 8,000.00                         | $ 8,000.00                  |
| SUBTOTAL POST PRODUCTION COST        | $ 11,000.00       | $ 11,000.00                        | $ 11,000.00                 |
| Agency travel                        | $ 3,000.00        | $ 4,000.00                         | $ 4,000.00                  |
| SUBTOTAL AGENCY COSTS                | $ 3,000.00        | $ 4,000.00                         | $ 4,000.00                  |
| Grand Total                          | $  14,000.00      | $  18,000.00                       | $  18,000.00                |
And 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 0.00                             | 5500.00                           | 8500.00                     | 14000.00 |
| First Presentation | 0.00                             | 9000.00                           | 13000.00                    | 22000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCPCVDCTCT2'
And login with details of 'CycloneCostOwner'
And I 'NextStage' the cost with title 'CCPCVDCTCT2'
And I upload following supporting documents to cost title 'CCPCVDCTCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'CCPCVDCTCT2'
And I am on cost review page of cost item with title 'CCPCVDCTCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Final Actual Local | Final Actual |
| Talent fees                          | $ 0.00            | $ 3,000.00         | $ 3,000.00   |
| SUBTOTAL PRODUCTION COST             | $ 0.00            | $ 3,000.00         | $ 3,000.00   |
| Offline edits                        | $ 3,000.00        | $ 3,000.00         | $ 3,000.00   |
| Audio finalization                   | $ 8,000.00        | $ 8,000.00         | $ 8,000.00   |
| SUBTOTAL POST PRODUCTION COST        | $ 11,000.00       | $ 11,000.00        | $ 11,000.00  |
| Agency travel                        | $ 3,000.00        | $ 4,000.00         | $ 4,000.00   |
| SUBTOTAL AGENCY COSTS                | $ 3,000.00        | $ 4,000.00         | $ 4,000.00   |
| Grand Total                          | $  14,000.00      | $  18,000.00       | $  18,000.00 |
And 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 0.00                             | 5500.00                           | 8500.00                     | 14000.00 |
| First Presentation | 0.00                             | 9000.00                           | 13000.00                    | 22000.00 |
| Final Actual       | 0.00                             | 9000.00                           | 9000.00                     | 18000.00 |


Scenario: Check Cyclone cost completion for Video Content Type and CGI Animation with revisions in each stage
Meta:@adcost
     @costCreationWithRevisions
     @adcostCycloneCosts
!--QA-746
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number            | Cost Title  | Description | Agency Producer/Art   | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | CCPCVDCTCT3 | CCPCVDCTD3   | Aaron Royer (Grey)   | 9000                 | Video        | CGI/Animation   | CCPCVDCTATN3           | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCPCVDCTCT3' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CCPCVDCTCT3':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CCPCVDCTAT1  | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CCPCVDCTCT3':
| Audio finalization | Offline edits | Agency travel |
| 8000               | 3000          | 3000          |
And uploaded following supporting documents to cost title 'CCPCVDCTCT3':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CCPCVDCTCT3':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CCPCVDCTCT3'
And I am on cost review page of cost item with title 'CCPCVDCTCT3'
Then I should see following data in cost section on Cost Review page:
| Section Name                   | Original Estimate Local | Original Estimate |
| Offline edits                  | $ 3,000.00             | $ 3,000.00       |
| Audio finalization             | $ 8,000.00             | $ 8,000.00       |
| SUBTOTAL POST PRODUCTION COST  | $ 11,000.00            | $ 11,000.00      |
| Agency travel                  | $ 3,000.00             | $ 3,000.00       |
| SUBTOTAL AGENCY COSTS          | $ 3,000.00             | $ 3,000.00       |
| Grand Total                    | $  14,000.00           | $  14,000.00     |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 14000.00                    | 14000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCPCVDCTCT3'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCVDCTCT3'
And I login with details of 'CycloneCostOwner'
And I 'CreateRevision' the cost with title 'CCPCVDCTCT3'
And fill Cost Line Items with following fields for cost title 'CCPCVDCTCT3':
| Audio finalization | Offline edits | Agency travel |
| 8000               | 10000         | 3000          |
And I upload following supporting documents to cost title 'CCPCVDCTCT3':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCPCVDCTCT3'
And I am on cost review page of cost item with title 'CCPCVDCTCT3'
Then I should see following data in cost section on Cost Review page:
| Section Name                   | Original Estimate | Current Revision Local | Current Revision |
| Offline edits                  | $ 3,000.00        | $ 10,000.00            | $ 10,000.00                |
| Audio finalization             | $ 8,000.00        | $ 8,000.00             | $ 8,000.00                 |
| SUBTOTAL POST PRODUCTION COST  | $ 11,000.00       | $ 18,000.00            | $ 18,000.00                |
| Agency travel                  | $ 3,000.00        | $ 3,000.00             | $ 3,000.00                 |
| SUBTOTAL AGENCY COSTS          | $ 3,000.00        | $ 3,000.00             | $ 3,000.00                 |
| Grand Total                    | $  14,000.00      | $  21,000.00           | $  21,000.00               |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 14000.00                    | 14000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCPCVDCTCT3'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCVDCTCT3'
And I login with details of 'CycloneCostOwner'
And I 'NextStage' the cost with title 'CCPCVDCTCT3'
And fill Cost Line Items with following fields for cost title 'CCPCVDCTCT3':
| Audio finalization | Offline edits | Agency travel |
| 5000               | 13000         | 4000          |
And I upload following supporting documents to cost title 'CCPCVDCTCT3':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'CCPCVDCTCT3'
And I am on cost review page of cost item with title 'CCPCVDCTCT3'
Then I should see following data in cost section on Cost Review page:
| Section Name                   | Original Estimate | Final Actual Local | Final Actual |
| Offline edits                  | $ 3,000.00        | $ 13,000.00        | $ 13,000.00  |
| Audio finalization             | $ 8,000.00        | $ 5,000.00         | $ 5,000.00   |
| SUBTOTAL POST PRODUCTION COST  | $ 11,000.00       | $ 18,000.00        | $ 18,000.00  |
| Agency travel                  | $ 3,000.00        | $ 4,000.00         | $ 4,000.00   |
| SUBTOTAL AGENCY COSTS          | $ 3,000.00        | $ 4,000.00         | $ 4,000.00   |
| Grand Total                    | $  14,000.00      | $  22,000.00       | $  22,000.00 |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 14000.00                    | 14000.00 |
| Final Actual      | 0.00                             | 22000.00                    | 22000.00 |


Scenario: Check Cyclone cost completion for Digital Content Type with revisions in each stage
Meta:@adcost
     @costCreationWithRevisions
     @adcostCycloneCosts
!--QA-746
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number            | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | CCPCVDCTCT4 | CCPCVDCTD4  | Aaron Royer (Grey)  | 50000                | Digital Development | CCPCVDCTATN4           | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCPCVDCTCT4' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And added expected asset details for cost title 'CCPCVDCTCT4':
| Initiative | Asset Title| Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CCPCVDCTAT4 | Tv               | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'CCPCVDCTCT4':
| Adaptation   | Virtual Reality | P&G insurance |
| 30000        | 20000           | 10000         |
And uploaded following supporting documents to cost title 'CCPCVDCTCT4':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CCPCVDCTCT4':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CCPCVDCTCT4'
And I am on cost review page of cost item with title 'CCPCVDCTCT4'
Then I should see following data in cost section on Cost Review page:
| Section Name                           | Original Estimate Local | Original Estimate |
| Adaptation                             | $ 30,000.00            | $ 30,000.00      |
| SUBTOTAL DIGITAL PRODUCTION COST       | $ 30,000.00            | $ 30,000.00      |
| Virtual Reality                        | $ 20,000.00            | $ 20,000.00      |
| SUBTOTAL DIGITAL POST PRODUCTION COST  | $ 20,000.00            | $ 20,000.00      |
| P&G insurance                          | $ 10,000.00            | $ 10,000.00      |
| SUBTOTAL OTHER COSTS                   | $ 10,000.00            | $ 10,000.00      |
| Grand Total                            | $  60,000.00           | $  60,000.00     |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 30000.00                    | 60000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCPCVDCTCT4'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCVDCTCT4'
And I login with details of 'CycloneCostOwner'
And I 'CreateRevision' the cost with title 'CCPCVDCTCT4'
And fill Cost Line Items with following fields for cost title 'CCPCVDCTCT4':
| Adaptation   | Virtual Reality | P&G insurance |
| 32000        | 25000           | 13000         |
And I upload following supporting documents to cost title 'CCPCVDCTCT4':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCPCVDCTCT4'
And I am on cost review page of cost item with title 'CCPCVDCTCT4'
Then I should see following data in cost section on Cost Review page:
| Section Name                           | Original Estimate | Current Revision Local | Current Revision |
| Adaptation                             | $ 30,000.00       | $ 32,000.00                      | $ 32,000.00                |
| SUBTOTAL DIGITAL PRODUCTION COST       | $ 30,000.00       | $ 32,000.00                      | $ 32,000.00                |
| Virtual Reality                        | $ 20,000.00       | $ 25,000.00                      | $ 25,000.00                |
| SUBTOTAL DIGITAL POST PRODUCTION COST  | $ 20,000.00       | $ 25,000.00                      | $ 25,000.00                |
| P&G insurance                          | $ 10,000.00       | $ 13,000.00                      | $ 13,000.00                |
| SUBTOTAL OTHER COSTS                   | $ 10,000.00       | $ 13,000.00                      | $ 13,000.00                |
| Grand Total                            | $  60,000.00      | $  70,000.00                     | $  70,000.00               |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 30000.00                    | 60000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCPCVDCTCT4'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCVDCTCT4'
And I login with details of 'CycloneCostOwner'
And I 'NextStage' the cost with title 'CCPCVDCTCT4'
And fill Cost Line Items with following fields for cost title 'CCPCVDCTCT4':
| Adaptation   | Virtual Reality | P&G insurance |
| 40000        | 30000           | 20000         |
And I upload following supporting documents to cost title 'CCPCVDCTCT4':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'CCPCVDCTCT4'
And I am on cost review page of cost item with title 'CCPCVDCTCT4'
Then I should see following data in cost section on Cost Review page:
| Section Name                           | Original Estimate | Final Actual Local | Final Actual |
| Adaptation                             | $ 30,000.00       | $ 40,000.00        | $ 40,000.00  |
| SUBTOTAL DIGITAL PRODUCTION COST       | $ 30,000.00       | $ 40,000.00        | $ 40,000.00  |
| Virtual Reality                        | $ 20,000.00       | $ 30,000.00        | $ 30,000.00  |
| SUBTOTAL DIGITAL POST PRODUCTION COST  | $ 20,000.00       | $ 30,000.00        | $ 30,000.00  |
| P&G insurance                          | $ 10,000.00       | $ 20,000.00        | $ 20,000.00  |
| SUBTOTAL OTHER COSTS                   | $ 10,000.00       | $ 20,000.00        | $ 20,000.00  |
| Grand Total                            | $  60,000.00      | $  90,000.00       | $  90,000.00 |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 30000.00                    | 60000.00 |
| Final Actual      | 30000.00                         | 60000.00                    | 90000.00 |


Scenario: Check that Cost consultant technical fee is removed from the Original Estimate cost stage before the cost stage has been fully approved by approvers
Meta:@adcost
!--QA-810
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number            | Cost Title  | Description  | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | CCPCVDCTCT5  | CCPCVDCTD5  | Aaron Royer (Grey)  | 9000                 | Video        | Full Production | CCPCVDCTATN5           | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCPCVDCTCT5' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CCPCVDCTCT5':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CCPCVDCTAT5   | 10:10:10         | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CCPCVDCTCT5':
| Audio finalization | Offline edits | Agency travel |
| 8000               | 3000          | 3000          |
And uploaded following supporting documents to cost title 'CCPCVDCTCT5' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'CCPCVDCTCT5':
| Technical Approver | Brand Management Approver |
| CostConsultant     | BrandManagementApprover   |
And I refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'CCPCVDCTCT5'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate Local | Original Estimate |
| Offline edits                        | $ 3,000.00             | $ 3,000.00       |
| Audio finalization                   | $ 8,000.00             | $ 8,000.00       |
| SUBTOTAL POST PRODUCTION COST        | $ 11,000.00            | $ 11,000.00      |
| Agency travel                        | $ 3,000.00             | $ 3,000.00       |
| SUBTOTAL AGENCY COSTS                | $ 3,000.00             | $ 3,000.00       |
| Technical fee (if applicable)        | $ 743.00               | $ 743.00         |
| Grand Total                          | $  14,743.00           | $  14,743.00     |
When 'Recall' the cost with title 'CCPCVDCTCT5'
And 'Reopen' the cost with title 'CCPCVDCTCT5'
And I am on cost approval page of cost title 'CCPCVDCTCT5'
And I 'Delete' approver 'CostConsultant' from 'technical' approver section on approvals page
And fill below approvers for cost title 'CCPCVDCTCT5':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'CCPCVDCTCT5'
And on cost review page of cost item with title 'CCPCVDCTCT5'
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate Local | Original Estimate |
| Offline edits                        | $ 3,000.00             | $ 3,000.00         |
| Audio finalization                   | $ 8,000.00             | $ 8,000.00         |
| SUBTOTAL POST PRODUCTION COST        | $ 11,000.00            | $ 11,000.00        |
| Agency travel                        | $ 3,000.00             | $ 3,000.00         |
| SUBTOTAL AGENCY COSTS                | $ 3,000.00             | $ 3,000.00         |
| Technical fee (if applicable)        | $ 0.00                 | $ 0.00             |
| Grand Total                          | $  14,000.00           | $  14,000.00       |