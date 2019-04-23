Feature: Increase Grand total in each stage submission
Narrative:
In order to
As a CycloneCostOwner
I want to check Cost creation and completion by increasing Grand total in each stage submission

Scenario: Check Cyclone cost completion for Still Image Content Type and Post Production with revisions in each stage
Meta:@adcost
     @costCreationWithRevisions
     @adcostCycloneCosts
!--QA-746, QA-810
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number            | Cost Title    | Description   | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number   | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | CCPCASICTCT1  | CCPCASICTD1   | Aaron Royer (Grey)  | 50000                | Still Image  | Post Production Only |  CCPCASICTATN1            | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCPCASICTCT1' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'CCPCASICTCT1':
| Initiative | Asset Title  | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CCPCASICTAT1 | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'CCPCASICTCT1':
| Artwork/packs | Retouching  | FX (Loss) & Gain |
| 10000         | 20000       | 10000            |
And uploaded following supporting documents to cost title 'CCPCASICTCT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CCPCASICTCT1':
| Technical Approver | Brand Management Approver |
| CostConsultant     | BrandManagementApprover   |
And refreshed the page without delay
And I am on cost approval page of cost title 'CCPCASICTCT1'
When I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'CCPCASICTCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                               | Original Estimate Local | Original Estimate |
| Artwork/packs                              | $ 10,000.00             | $ 10,000.00       |
| Retouching                                 | $ 20,000.00             | $ 20,000.00       |
| Subtotal Still Image Post Production cost  | $ 30,000.00             | $ 30,000.00       |
| FX (Loss) & Gain                           | $ 10,000.00             | $ 10,000.00       |
| Technical fee (if applicable)              | $ 158.00                | $ 158.00          |
| SUBTOTAL OTHER COSTS                       | $ 10,158.00             | $ 10,158.00       |
| Grand Total                                | $  40,158.00            | $  40,158.00      |
And I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 40158.00                    | 40158.00 |
When I login with details of 'CostConsultant'
And 'Approve' the cost with title 'CCPCASICTCT1'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCASICTCT1'
And I login with details of 'CycloneCostOwner'
And I 'CreateRevision' the cost with title 'CCPCASICTCT1'
And I add cost item details for cost title 'CCPCASICTCT1' with 'USD' currency:
| Artwork/packs | Retouching | FX (Loss) & Gain |
| 11000         | 20000      | 11000            |
And I upload following supporting documents to cost title 'CCPCASICTCT1':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCPCASICTCT1'
And I am on cost review page of cost item with title 'CCPCASICTCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                               | Original Estimate | Current Revision Local           | Current Revision |
| Artwork/packs                              | $ 10,000.00       | $ 11,000.00                      | $ 11,000.00      |
| Retouching                                 | $ 20,000.00       | $ 20,000.00                      | $ 20,000.00      |
| Subtotal Still Image Post Production cost  | $ 30,000.00       | $ 31,000.00                      | $ 31,000.00      |
| FX (Loss) & Gain                           | $ 10,000.00       | $ 11,000.00                      | $ 11,000.00      |
| Technical fee (if applicable)              | $ 158.00          | $ 158.00                         | $ 158.00         |
| SUBTOTAL OTHER COSTS                       | $ 10,158.00       | $ 11,158.00                      | $ 11,158.00      |
| Grand Total                                | $  40,158.00      | $  42,158.00                     | $  42,158.00     |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 40158.00                    | 40158.00 |
When I login with details of 'CostConsultant'
And 'Approve' the cost with title 'CCPCASICTCT1'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCASICTCT1'
And I login with details of 'CycloneCostOwner'
And I 'NextStage' the cost with title 'CCPCASICTCT1'
And I fill Cost Line Items with following fields for cost title 'CCPCASICTCT1':
| Artwork/packs | Retouching | FX (Loss) & Gain |
| 12000         | 20500      | 11100            |
And I upload following supporting documents to cost title 'CCPCASICTCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'CCPCASICTCT1'
And I am on cost review page of cost item with title 'CCPCASICTCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                               | Original Estimate | Final Actual Local | Final Actual |
| Artwork/packs                              | $ 10,000.00       | $ 12,000.00        | $ 12,000.00  |
| Retouching                                 | $ 20,000.00       | $ 20,500.00        | $ 20,500.00  |
| Subtotal Still Image Post Production cost  | $ 30,000.00       | $ 32,500.00        | $ 32,500.00  |
| FX (Loss) & Gain                           | $ 10,000.00       | $ 11,100.00        | $ 11,100.00  |
| Technical fee (if applicable)              | $ 158.00          | $ 158.00           | $ 158.00     |
| SUBTOTAL OTHER COSTS                       | $ 10,158.00       | $ 11,258.00        | $ 11,258.00  |
| Grand Total                                | $  40,158.00      | $  43,758.00       | $  43,758.00 |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 40158.00                    | 40158.00 |
| Final Actual      | 0.00                             | 43758.00                    | 43758.00 |


Scenario: Check Cyclone cost completion for Still Image Content Type and Full Production with revisions in each stage
Meta:@adcost
     @costCreationWithRevisions
     @adcostCriticalTests
     @adcostSmokeUAT
     @adcostCycloneCosts
     @adcostSmoke
!--QA-746
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number            | Cost Title    | Description    | Agency Producer/Art| Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | CCPCASICTCT2  | CCPCASICTD2    | Aaron Royer (Grey) | 20000                | Still Image  | Full Production | CCPCASICTATN2          | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCPCASICTCT2' with following fields:
| Talent Company      | Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Retouching Company  |
| GlobalDefaultVendor | GlobalDefaultVendor  | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | GlobalDefaultVendor |
And added expected asset details for cost title 'CCPCASICTCT2':
| Initiative | Asset Title  | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CCPCASICTAT2 | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'CCPCASICTCT2':
| Preproduction | Retouching | FX (Loss) & Gain |
| 10000         | 12000      | 8000             |
And uploaded following supporting documents to cost title 'CCPCASICTCT2' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
And added below approvers for cost title 'CCPCASICTCT2':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'CCPCASICTCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                               | Original Estimate Local | Original Estimate |
| Preproduction                              | $ 10,000.00            | $ 10,000.00      |
| SUBTOTAL STILL IMAGE PRODUCTION COST       | $ 10,000.00            | $ 10,000.00      |
| Retouching                                 | $ 12,000.00            | $ 12,000.00      |
| Subtotal Still Image Post Production cost  | $ 12,000.00            | $ 12,000.00      |
| FX (Loss) & Gain                           | $ 8,000.00             | $ 8,000.00       |
| SUBTOTAL OTHER COSTS                       | $ 8,000.00             | $ 8,000.00       |
| Grand Total                                | $  30,000.00           | $  30,000.00     |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 5000.00                          | 11000.00                          | 14000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCPCASICTCT2'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCASICTCT2'
And I login with details of 'CycloneCostOwner'
And I 'CreateRevision' the cost with title 'CCPCASICTCT2'
And add cost item details for cost title 'CCPCASICTCT2' with 'USD' currency:
| Talent fees   | Artwork/packs | P&G insurance      |
| 10000         | 12000         | 8000               |
And I upload following supporting documents to cost title 'CCPCASICTCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCPCASICTCT2'
And I am on cost review page of cost item with title 'CCPCASICTCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                               | Original Estimate | Current Revision Local           | Current Revision |
| Preproduction                              | $ 10,000.00       | $ 10,000.00                      | $ 10,000.00                |
| Talent fees                                | $ 0.00            | $ 10,000.00                      | $ 10,000.00                |
| SUBTOTAL STILL IMAGE PRODUCTION COST       | $ 10,000.00       | $ 20,000.00                      | $ 20,000.00                |
| Retouching                                 | $ 12,000.00       | $ 12,000.00                      | $ 12,000.00                |
| Artwork/packs                              | $ 0.00            | $ 12,000.00                      | $ 12,000.00                |
| Subtotal Still Image Post Production cost  | $ 12,000.00       | $ 24,000.00                      | $ 24,000.00                |
| FX (Loss) & Gain                           | $ 8,000.00        | $ 8,000.00                       | $ 8,000.00                 |
| P&G insurance                              | $ 0.00            | $ 8,000.00                       | $ 8,000.00                 |
| SUBTOTAL OTHER COSTS                       | $ 8,000.00        | $ 16,000.00                      | $ 16,000.00                |
| Grand Total                                | $  30,000.00      | $  60,000.00                     | $  60,000.00               |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 5000.00                          | 11000.00                          | 14000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCPCASICTCT2'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCASICTCT2'
And I login with details of 'CycloneCostOwner'
And I 'NextStage' the cost with title 'CCPCASICTCT2'
And fill Cost Line Items with following fields for cost title 'CCPCASICTCT2':
| Talent fees   | Artwork/packs | P&G insurance      |
| 11000         | 15000         | 9000               |
And I upload following supporting documents to cost title 'CCPCASICTCT2':
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
| /files/EditWord.doc | Scope change approval form            |
And 'Submit' the cost with title 'CCPCASICTCT2'
And I am on cost review page of cost item with title 'CCPCASICTCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                               | Original Estimate | First Presentation Local | First Presentation |
| Preproduction                              | $ 10,000.00       | $ 10,000.00              | $ 10,000.00        |
| Talent fees                                | $ 0.00            | $ 11,000.00              | $ 11,000.00        |
| SUBTOTAL STILL IMAGE PRODUCTION COST       | $ 10,000.00       | $ 21,000.00              | $ 21,000.00        |
| Retouching                                 | $ 12,000.00       | $ 12,000.00              | $ 12,000.00        |
| Artwork/packs                              | $ 0.00            | $ 15,000.00              | $ 15,000.00        |
| Subtotal Still Image Post Production cost  | $ 12,000.00       | $ 27,000.00              | $ 27,000.00        |
| FX (Loss) & Gain                           | $ 8,000.00        | $ 8,000.00               | $ 8,000.00         |
| P&G insurance                              | $ 0.00            | $ 9,000.00               | $ 9,000.00         |
| SUBTOTAL OTHER COSTS                       | $ 8,000.00        | $ 17,000.00              | $ 17,000.00        |
| Grand Total                                | $  30,000.00      | $  65,000.00             | $  65,000.00       |
And 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 5000.00                          | 11000.00                          | 14000.00                    | 30000.00 |
| First Presentation | 5000.00                          | 29500.00                          | 30500.00                    | 65000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCPCASICTCT2'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCASICTCT2'
When I login with details of 'CycloneCostOwner'
And I 'CreateRevision' the cost with title 'CCPCASICTCT2'
And fill Cost Line Items with following fields for cost title 'CCPCASICTCT2':
| Insurance (if not covered by P&G) | Agency Travel |
| 10000                             | 5000          |
And I upload following supporting documents to cost title 'CCPCASICTCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCPCASICTCT2'
And I am on cost review page of cost item with title 'CCPCASICTCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                               | Original Estimate | Current Revision Local           | Current Revision|
| Preproduction                              | $ 10,000.00       | $ 10,000.00                      | $ 10,000.00                |
| Talent fees                                | $ 0.00            | $ 11,000.00                      | $ 11,000.00                |
| Insurance (if not covered by P&G)          | $ 0.00            | $ 10,000.00                      | $ 10,000.00                |
| SUBTOTAL STILL IMAGE PRODUCTION COST       | $ 10,000.00       | $ 31,000.00                      | $ 31,000.00                |
| Retouching                                 | $ 12,000.00       | $ 12,000.00                      | $ 12,000.00                |
| Artwork/packs                              | $ 0.00            | $ 15,000.00                      | $ 15,000.00                |
| Subtotal Still Image Post Production cost  | $ 12,000.00       | $ 27,000.00                      | $ 27,000.00                |
| Agency Travel                              | $ 0.00            | $ 5,000.00                       | $ 5,000.00                 |
| SUBTOTAL AGENCY COSTS                      | $ 0.00            | $ 5,000.00                       | $ 5,000.00                 |
| FX (Loss) & Gain                           | $ 8,000.00        | $ 8,000.00                       | $ 8,000.00                 |
| P&G insurance                              | $ 0.00            | $ 9,000.00                       | $ 9,000.00                 |
| SUBTOTAL OTHER COSTS                       | $ 8,000.00        | $ 17,000.00                      | $ 17,000.00                |
| Grand Total                                | $  30,000.00      | $  80,000.00                     | $  80,000.00               |
And 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 5000.00                          | 11000.00                          | 14000.00                    | 30000.00 |
| First Presentation | 5000.00                          | 29500.00                          | 30500.00                    | 65000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCPCASICTCT2'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCASICTCT2'
And login with details of 'CycloneCostOwner'
And I 'NextStage' the cost with title 'CCPCASICTCT2'
And I upload following supporting documents to cost title 'CCPCASICTCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'CCPCASICTCT2'
And I am on cost review page of cost item with title 'CCPCASICTCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                               | Original Estimate | Final Actual Local | Final Actual   |
| Preproduction                              | $ 10,000.00       | $ 10,000.00        | $ 10,000.00    |
| Talent fees                                | $ 0.00            | $ 11,000.00        | $ 11,000.00    |
| Insurance (if not covered by P&G)          | $ 0.00            | $ 10,000.00        | $ 10,000.00    |
| SUBTOTAL STILL IMAGE PRODUCTION COST       | $ 10,000.00       | $ 31,000.00        | $ 31,000.00    |
| Retouching                                 | $ 12,000.00       | $ 12,000.00        | $ 12,000.00    |
| Artwork/packs                              | $ 0.00            | $ 15,000.00        | $ 15,000.00    |
| Subtotal Still Image Post Production cost  | $ 12,000.00       | $ 27,000.00        | $ 27,000.00    |
| Agency Travel                              | $ 0.00            | $ 5,000.00         | $ 5,000.00     |
| SUBTOTAL AGENCY COSTS                      | $ 0.00            | $ 5,000.00         | $ 5,000.00     |
| FX (Loss) & Gain                           | $ 8,000.00        | $ 8,000.00         | $ 8,000.00     |
| P&G insurance                              | $ 0.00            | $ 9,000.00         | $ 9,000.00     |
| SUBTOTAL OTHER COSTS                       | $ 8,000.00        | $ 17,000.00        | $ 17,000.00    |
| Grand Total                                | $  30,000.00      | $  80,000.00       | $  80,000.00   |
Then 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | First Presentation payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 5000.00                          | 11000.00                          | 14000.00                    | 30000.00 |
| First Presentation | 5000.00                          | 29500.00                          | 30500.00                    | 65000.00 |
| Final Actual       | 5000.00                          | 29500.00                          | 45500.00                    | 80000.00 |


Scenario: Check Cyclone cost completion for Audio Content Type and Post Production with revisions in each stage
Meta:@adcost
     @costCreationWithRevisions
     @adcostCycloneCosts
!--QA-746
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number            | Cost Title    | Description   | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number   | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | CCPCASICTCT3  | CCPCASICTD7   | Aaron Royer (Grey)  | 50000                | Audio        | Post Production Only |  CCPCASICTATN7            | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCPCASICTCT3' with following fields:
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And added expected asset details for cost title 'CCPCASICTCT3':
| Initiative | Country      | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | CCPCASICTAT7 | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CCPCASICTCT3':
| VO recording sessions | P&G insurance | Talent fees |
| 10000                 | 10000         | 10000       |
And uploaded following supporting documents to cost title 'CCPCASICTCT3':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CCPCASICTCT3':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CCPCASICTCT3'
And I am on cost review page of cost item with title 'CCPCASICTCT3'
Then I should see following data in cost section on Cost Review page:
| Section Name                | Original Estimate Local | Original Estimate |
| VO recording sessions       | $ 10,000.00            | $ 10,000.00      |
| Talent fees                 | $ 10,000.00            | $ 10,000.00      |
| SUBTOTAL STUDIO COSTS       | $ 20,000.00            | $ 20,000.00      |
| P&G insurance               | $ 10,000.00            | $ 10,000.00      |
| SUBTOTAL OTHER COSTS        | $ 10,000.00            | $ 10,000.00      |
| Grand Total                 | $  30,000.00           | $  30,000.00     |
And I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCPCASICTCT3'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCASICTCT3'
And I login with details of 'CycloneCostOwner'
And I 'CreateRevision' the cost with title 'CCPCASICTCT3'
And I add cost item details for cost title 'CCPCASICTCT3' with 'USD' currency:
| VO recording sessions | P&G insurance | Talent fees |
| 20000                 | 15000         | 15000       |
And I upload following supporting documents to cost title 'CCPCASICTCT3':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCPCASICTCT3'
And I am on cost review page of cost item with title 'CCPCASICTCT3'
Then I should see following data in cost section on Cost Review page:
| Section Name                | Original Estimate | Current Revision Local           | Current Revision |
| VO recording sessions       | $ 10,000.00       | $ 20,000.00                      | $ 20,000.00                |
| Talent fees                 | $ 10,000.00       | $ 15,000.00                      | $ 15,000.00                |
| SUBTOTAL STUDIO COSTS       | $ 20,000.00       | $ 35,000.00                      | $ 35,000.00                |
| P&G insurance               | $ 10,000.00       | $ 15,000.00                      | $ 15,000.00                |
| SUBTOTAL OTHER COSTS        | $ 10,000.00       | $ 15,000.00                      | $ 15,000.00                |
| Grand Total                 | $  30,000.00      | $  50,000.00                     | $  50,000.00               |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCPCASICTCT3'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCASICTCT3'
And I login with details of 'CycloneCostOwner'
And I 'NextStage' the cost with title 'CCPCASICTCT3'
And I fill Cost Line Items with following fields for cost title 'CCPCASICTCT3':
| VO recording sessions | P&G insurance | Talent fees |
| 25000                 | 18000         | 17000       |
And I upload following supporting documents to cost title 'CCPCASICTCT3':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'CCPCASICTCT3'
And I am on cost review page of cost item with title 'CCPCASICTCT3'
Then I should see following data in cost section on Cost Review page:
| Section Name                | Original Estimate | Final Actual Local | Final Actual |
| VO recording sessions       | $ 10,000.00       | $ 25,000.00        | $ 25,000.00  |
| Talent fees                 | $ 10,000.00       | $ 17,000.00        | $ 17,000.00  |
| SUBTOTAL STUDIO COSTS       | $ 20,000.00       | $ 42,000.00        | $ 42,000.00  |
| P&G insurance               | $ 10,000.00       | $ 18,000.00        | $ 18,000.00  |
| SUBTOTAL OTHER COSTS        | $ 10,000.00       | $ 18,000.00        | $ 18,000.00  |
| Grand Total                 | $  30,000.00      | $  60,000.00       | $  60,000.00 |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
| Final Actual      | 0.00                             | 60000.00                    | 60000.00 |


Scenario: Check Cyclone cost completion for Audio Content Type and Full Production with revisions in each stage
Meta:@adcost
     @costCreationWithRevisions
     @adcostCycloneCosts
!--QA-746, QA-810
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number            | Cost Title    | Description   | Agency Producer/Art  | Target Budget Amount | Content Type | Production Type |  Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | CCPCASICTCT4  | CCPCASICTD8   | Aaron Royer (Grey)   | 50000                | Audio        | Full Production |  CCPCASICTATN8          | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCPCASICTCT4' with following fields:
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And added expected asset details for cost title 'CCPCASICTCT4':
| Initiative | Country      | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | CCPCASICTAT8   | 10:10:10        | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CCPCASICTCT4':
| VO recording sessions | P&G insurance | Talent fees |
| 10000                 | 10000         | 10000       |
And uploaded following supporting documents to cost title 'CCPCASICTCT4':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'CCPCASICTCT4':
| Technical Approver | Brand Management Approver |
| CostConsultant     | BrandManagementApprover   |
And refreshed the page without delay
And I am on cost approval page of cost title 'CCPCASICTCT4'
When I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'CCPCASICTCT4'
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate Local | Original Estimate |
| VO recording sessions         | $ 10,000.00             | $ 10,000.00       |
| Talent fees                   | $ 10,000.00             | $ 10,000.00       |
| SUBTOTAL STUDIO COSTS         | $ 20,000.00             | $ 20,000.00       |
| P&G insurance                 | $ 10,000.00             | $ 10,000.00       |
| SUBTOTAL OTHER COSTS          | $ 10,153.00             | $ 10,153.00       |
| Technical fee (if applicable) | $ 153.00                | $ 153.00          |
| Grand Total                   | $  30,153.00            | $  30,153.00      |
And I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30153.00                    | 30153.00 |
When I login with details of 'CostConsultant'
And 'Approve' the cost with title 'CCPCASICTCT4'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCASICTCT4'
And I login with details of 'CycloneCostOwner'
And I 'CreateRevision' the cost with title 'CCPCASICTCT4'
And I add cost item details for cost title 'CCPCASICTCT4' with 'USD' currency:
| Talent fees |
| 15000       |
And I upload following supporting documents to cost title 'CCPCASICTCT4':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'CCPCASICTCT4':
| Technical Approver | Brand Management Approver |
| CostConsultant     | BrandManagementApprover   |
And 'Submit' the cost with title 'CCPCASICTCT4'
And I am on cost review page of cost item with title 'CCPCASICTCT4'
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate | Current Revision Local | Current Revision |
| VO recording sessions         | $ 10,000.00       | $ 10,000.00            | $ 10,000.00      |
| Talent fees                   | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| SUBTOTAL STUDIO COSTS         | $ 20,000.00       | $ 25,000.00            | $ 25,000.00      |
| P&G insurance                 | $ 10,000.00       | $ 10,000.00            | $ 10,000.00      |
| Technical fee (if applicable) | $ 153.00          | $ 153.00               | $ 153.00         |
| SUBTOTAL OTHER COSTS          | $ 10,153.00       | $ 10,153.00            | $ 10,153.00      |
| Grand Total                   | $  30,153.00      | $  35,153.00           | $  35,153.00     |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30153.00                    | 30153.00 |
When I login with details of 'CostConsultant'
And 'Approve' the cost with title 'CCPCASICTCT4'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'CCPCASICTCT4'
And I login with details of 'CycloneCostOwner'
And I 'NextStage' the cost with title 'CCPCASICTCT4'
And fill Cost Line Items with following fields for cost title 'CCPCASICTCT4':
| VO recording sessions |
| 15000                 |
And I upload following supporting documents to cost title 'CCPCASICTCT4':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'CCPCASICTCT4'
And I am on cost review page of cost item with title 'CCPCASICTCT4'
Then I should see following data in cost section on Cost Review page:
| Section Name                  | Original Estimate | Final Actual Local | Final Actual |
| VO recording sessions         | $ 10,000.00       | $ 15,000.00        | $ 15,000.00  |
| Talent fees                   | $ 10,000.00       | $ 15,000.00        | $ 15,000.00  |
| SUBTOTAL STUDIO COSTS         | $ 20,000.00       | $ 30,000.00        | $ 30,000.00  |
| P&G insurance                 | $ 10,000.00       | $ 10,000.00        | $ 10,000.00  |
| Technical fee (if applicable) | $ 153.00          | $ 153.00           | $ 153.00     |
| SUBTOTAL OTHER COSTS          | $ 10,153.00       | $ 10,153.00        | $ 10,153.00  |
| Grand Total                   | $  30,153.00      | $  40,153.00       | $  40,153.00 |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30153.00                    | 30153.00 |
| Final Actual      | 0.00                             | 40153.00                    | 40153.00 |