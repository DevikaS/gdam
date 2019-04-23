Feature: Increase Grand total in each stage submission
Narrative:
In order to
As a CostOwner
I want to check Cost creation and completion by increasing Grand total in each stage submission


Scenario: Check cost completion for StillImage Content Type and Post Production with two revisions in OE Stage
Meta:@adcost
     @costCreationWithRevisions
     @adcostSmokeUAT
!--QA-727
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art  | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CCRCGTCT1  | CCRCGTD5    | Lily Ross (Publicis) | 12000                | Still Image  | Post Production Only | CCRCGTATN5             | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCRCGTCT1' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'CCRCGTCT1':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CCRCGTAT5   | Version | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'CCRCGTCT1':
| Artwork/packs | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000         | 20000      | 10000            | 1234567890                        |
And I uploaded following supporting documents to cost title 'CCRCGTCT1' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CCRCGTCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'CCRCGTCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                              | Original Estimate Local | Original Estimate |
| Retouching                                | $ 20,000.00             | $ 20,000.00       |
| Artwork/packs                             | $ 10,000.00             | $ 10,000.00       |
| SUBTOTAL STILL IMAGE POST PRODUCTION COST | $ 30,000.00             | $ 30,000.00       |
| FX (Loss) & Gain                          | $ 10,000.00             | $ 10,000.00       |
| SUBTOTAL OTHER COSTS                      | $ 10,000.00             | $ 10,000.00       |
| Grand Total                               | $  40,000.00            | $  40,000.00      |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRCGTCT1'
And cost with title 'CCRCGTCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRCGTCT1'
And click 'Create Revision' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'CCRCGTCT1':
| Artwork/packs | Retouching | FX (Loss) & Gain |
| 5000          | 25000      | 0                |
And I upload following supporting documents to cost title 'CCRCGTCT1':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'CCRCGTCT1':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'CCRCGTCT1'
And I am on cost review page of cost item with title 'CCRCGTCT1'
And refresh the page without delay
Then I should see following data in cost section on Cost Review page:
| Section Name                              | Original Estimate | Current Revision Local | Current Revision |
| Retouching                                | $ 20,000.00       | $ 25,000.00            | $ 25,000.00      |
| Artwork/packs                             | $ 10,000.00       | $ 5,000.00             | $ 5,000.00       |
| SUBTOTAL STILL IMAGE POST PRODUCTION COST | $ 30,000.00       | $ 30,000.00            | $ 30,000.00      |
| FX (Loss) & Gain                          | $ 10,000.00       | $ 0.00                 | $ 0.00           |
| SUBTOTAL OTHER COSTS                      | $ 10,000.00       | $ 0.00                 | $ 0.00           |
| Grand Total                               | $  40,000.00      | $  30,000.00           | $  30,000.00     |
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 40000.00                    | 40000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRCGTCT1'
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRCGTCT1'
And click 'Create Revision' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'CCRCGTCT1':
| Retouching | FX (Loss) & Gain | Agency Travel |
| 500        | 30000            | 5000          |
And I upload following supporting documents to cost title 'CCRCGTCT1':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'CCRCGTCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'CCRCGTCT1'
And I am on cost review page of cost item with title 'CCRCGTCT1'
And refresh the page without delay
Then I should see following data in cost section on Cost Review page:
| Section Name                              | Original Estimate | Current Revision Local | Current Revision |
| Retouching                                | $ 20,000.00       | $ 500.00               | $ 500.00         |
| Artwork/packs                             | $ 10,000.00       | $ 5,000.00             | $ 5,000.00       |
| SUBTOTAL STILL IMAGE POST PRODUCTION COST | $ 30,000.00       | $ 5,500.00             | $ 5,500.00       |
| Agency Travel                             | $ 0.00            | $ 5,000.00             | $ 5,000.00       |
| SUBTOTAL AGENCY COSTS                     | $ 0.00            | $ 5,000.00             | $ 5,000.00       |
| FX (Loss) & Gain                          | $ 10,000.00       | $ 30,000.00            | $ 30,000.00      |
| SUBTOTAL OTHER COSTS                      | $ 10,000.00       | $ 30,000.00            | $ 30,000.00      |
| Grand Total                               | $  40,000.00      | $  40,500.00           | $  40,500.00     |
When I login with details of 'IPMuser'
And I am on costs overview page
And 'Approve' the cost with title 'CCRCGTCT1'
Then I should see AMQ receives below request for cost title 'CCRCGTCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 40500        | 0              | USD      | 1234567890 | DefaultBrand | CCRCGTD5    | brandDescription |
When cost with title 'CCRCGTCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRCGTCT1'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'CCRCGTCT1':
| Retouching | FX (Loss) & Gain | Agency Travel |
| 500        | 31000            | 5000          |
And I upload following supporting documents to cost title 'CCRCGTCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And add below approvers for cost title 'CCRCGTCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'CCRCGTCT1'
And I am on cost review page of cost item with title 'CCRCGTCT1'
Then I should see following data in cost section on Cost Review page:
| Section Name                              | Original Estimate | Final Actual Local | Final Actual |
| Retouching                                | $ 20,000.00       | $ 500.00           | $ 500.00     |
| Artwork/packs                             | $ 10,000.00       | $ 5,000.00         | $ 5,000.00   |
| SUBTOTAL STILL IMAGE POST PRODUCTION COST | $ 30,000.00       | $ 5,500.00         | $ 5,500.00   |
| Agency Travel                             | $ 0.00            | $ 5,000.00         | $ 5,000.00   |
| SUBTOTAL AGENCY COSTS                     | $ 0.00            | $ 5,000.00         | $ 5,000.00   |
| FX (Loss) & Gain                          | $ 10,000.00       | $ 31,000.00        | $ 31,000.00  |
| SUBTOTAL OTHER COSTS                      | $ 10,000.00       | $ 31,000.00        | $ 31,000.00  |
| Grand Total                               | $  40,000.00      | $  41,500.00       | $  41,500.00 |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 40000.00                    | 40000.00 |
| Final Actual      | 0.00                             | 41500.00                    | 41500.00 |


Scenario: Check cost completion for Digital Content Type with revisions in each stage
Meta:@adcost
     @costCreationWithRevisions
     @adcostSmokeUAT
     @adcostSmoke
!--QA-727
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CCRCGTCT2  | CCRCGTD4    | Christine Meyer (Leo Burnett) | 50000                | Digital Development | CCRCGTATN4             | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCRCGTCT2' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And added expected asset details for cost title 'CCRCGTCT2':
| Initiative | Asset Title| Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CCRCGTAT4  | Tv               | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'CCRCGTCT2':
| Adaptation   | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 30000        | 20000           | 10000         | 1234567890                        |
And uploaded following supporting documents to cost title 'CCRCGTCT2':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CCRCGTCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CCRCGTCT2'
And I am on cost review page of cost item with title 'CCRCGTCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                          | Original Estimate Local | Original Estimate |
| Adaptation                            | $ 30,000.00             | $ 30,000.00       |
| SUBTOTAL DIGITAL PRODUCTION COST      | $ 30,000.00             | $ 30,000.00       |
| Virtual Reality                       | $ 20,000.00             | $ 20,000.00       |
| SUBTOTAL DIGITAL POST PRODUCTION COST | $ 20,000.00             | $ 20,000.00       |
| P&G insurance                         | $ 10,000.00             | $ 10,000.00       |
| SUBTOTAL OTHER COSTS                  | $ 10,000.00             | $ 10,000.00       |
| Grand Total                           | $  60,000.00            | $  60,000.00      |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 30000.00                    | 60000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRCGTCT2'
And cost with title 'CCRCGTCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRCGTCT2'
And click 'Create Revision' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'CCRCGTCT2':
| Adaptation   | Virtual Reality | P&G insurance |
| 32000        | 25000           | 13000         |
And I upload following supporting documents to cost title 'CCRCGTCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'CCRCGTCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'CCRCGTCT2'
And I am on cost review page of cost item with title 'CCRCGTCT2'
And refresh the page without delay
Then I should see following data in cost section on Cost Review page:
| Section Name                          | Original Estimate | Current Revision Local | Current Revision |
| Adaptation                            | $ 30,000.00       | $ 32,000.00            | $ 32,000.00      |
| SUBTOTAL DIGITAL PRODUCTION COST      | $ 30,000.00       | $ 32,000.00            | $ 32,000.00      |
| Virtual Reality                       | $ 20,000.00       | $ 25,000.00            | $ 25,000.00      |
| SUBTOTAL DIGITAL POST PRODUCTION COST | $ 20,000.00       | $ 25,000.00            | $ 25,000.00      |
| P&G insurance                         | $ 10,000.00       | $ 13,000.00            | $ 13,000.00      |
| SUBTOTAL OTHER COSTS                  | $ 10,000.00       | $ 13,000.00            | $ 13,000.00      |
| Grand Total                           | $  60,000.00      | $  70,000.00           | $  70,000.00     |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 30000.00                    | 60000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRCGTCT2'
And cost with title 'CCRCGTCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRCGTCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'CCRCGTCT2':
| Adaptation   | Virtual Reality | P&G insurance | FX (Loss) & Gain |
| 40000        | 30000           | 20000         | -5000            |
And I upload following supporting documents to cost title 'CCRCGTCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And add below approvers for cost title 'CCRCGTCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'CCRCGTCT2'
And I am on cost review page of cost item with title 'CCRCGTCT2'
Then I should see following data in cost section on Cost Review page:
| Section Name                          | Original Estimate | Final Actual Local | Final Actual |
| Adaptation                            | $ 30,000.00       | $ 40,000.00        | $ 40,000.00  |
| SUBTOTAL DIGITAL PRODUCTION COST      | $ 30,000.00       | $ 40,000.00        | $ 40,000.00  |
| Virtual Reality                       | $ 20,000.00       | $ 30,000.00        | $ 30,000.00  |
| SUBTOTAL DIGITAL POST PRODUCTION COST | $ 20,000.00       | $ 30,000.00        | $ 30,000.00  |
| P&G insurance                         | $ 10,000.00       | $ 20,000.00        | $ 20,000.00  |
| FX (Loss) & Gain                      | $ 0.00            | $ -5,000.00        | $ -5,000.00  |
| SUBTOTAL OTHER COSTS                  | $ 10,000.00       | $ 15,000.00        | $ 15,000.00  |
| Grand Total                           | $  60,000.00      | $  85,000.00       | $  85,000.00 |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 30000.00                    | 60000.00 |
| Final Actual      | 30000.00                         | 55000.00                    | 85000.00 |


Scenario: Check cost completion for Audio Content Type and Post Production with revisions in each stage
Meta:@adcost
     @costCreationWithRevisions
!--QA-727
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CCRCGTCT3  | CCRCGTD7    | Christine Meyer (Leo Burnett) | 50000                | Audio        | Post Production Only |  CCRCGTATN7             | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCRCGTCT3' with following fields:
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And added expected asset details for cost title 'CCRCGTCT3':
| Initiative | Country      | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | CCRCGTAT7    | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CCRCGTCT3':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 10000                 | 10000         | 10000       | 1234567890                        |
And uploaded following supporting documents to cost title 'CCRCGTCT3':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CCRCGTCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CCRCGTCT3'
And I am on cost review page of cost item with title 'CCRCGTCT3'
Then I should see following data in cost section on Cost Review page:
| Section Name          | Original Estimate Local | Original Estimate |
| VO recording sessions | $ 10,000.00             | $ 10,000.00       |
| Talent fees           | $ 10,000.00             | $ 10,000.00       |
| SUBTOTAL STUDIO COSTS | $ 20,000.00             | $ 20,000.00       |
| P&G insurance         | $ 10,000.00             | $ 10,000.00       |
| SUBTOTAL OTHER COSTS  | $ 10,000.00             | $ 10,000.00       |
| Grand Total           | $  30,000.00            | $  30,000.00      |
And I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRCGTCT3'
And cost with title 'CCRCGTCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRCGTCT3'
And click 'Create Revision' button and 'Confirm' on cost review page
And I add cost item details for cost title 'CCRCGTCT3' with 'USD' currency:
| VO recording sessions | P&G insurance | Talent fees |
| 20000                 | 15000         | 15000       |
And I upload following supporting documents to cost title 'CCRCGTCT3':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'CCRCGTCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'CCRCGTCT3'
And I am on cost review page of cost item with title 'CCRCGTCT3'
And refresh the page without delay
Then I should see following data in cost section on Cost Review page:
| Section Name          | Original Estimate | Current Revision Local | Current Revision |
| VO recording sessions | $ 10,000.00       | $ 20,000.00            | $ 20,000.00      |
| Talent fees           | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| SUBTOTAL STUDIO COSTS | $ 20,000.00       | $ 35,000.00            | $ 35,000.00      |
| P&G insurance         | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| SUBTOTAL OTHER COSTS  | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| Grand Total           | $  30,000.00      | $  50,000.00           | $  50,000.00     |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRCGTCT3'
And cost with title 'CCRCGTCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRCGTCT3'
And click 'Next Stage' button and 'Confirm' on cost review page
And I fill Cost Line Items with following fields for cost title 'CCRCGTCT3':
| VO recording sessions | P&G insurance | Talent fees |
| 25000                 | 18000         | 17000       |
And I upload following supporting documents to cost title 'CCRCGTCT3':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And add below approvers for cost title 'CCRCGTCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'CCRCGTCT3'
And I am on cost review page of cost item with title 'CCRCGTCT3'
And refresh the page without delay
Then I should see following data in cost section on Cost Review page:
| Section Name          | Original Estimate | Final Actual Local | Final Actual |
| VO recording sessions | $ 10,000.00       | $ 25,000.00        | $ 25,000.00  |
| Talent fees           | $ 10,000.00       | $ 17,000.00        | $ 17,000.00  |
| SUBTOTAL STUDIO COSTS | $ 20,000.00       | $ 42,000.00        | $ 42,000.00  |
| P&G insurance         | $ 10,000.00       | $ 18,000.00        | $ 18,000.00  |
| SUBTOTAL OTHER COSTS  | $ 10,000.00       | $ 18,000.00        | $ 18,000.00  |
| Grand Total           | $  30,000.00      | $  60,000.00       | $  60,000.00 |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
| Final Actual      | 0.00                             | 60000.00                    | 60000.00 |


Scenario: Check cost completion for Audio Content Type and Full Production with revisions in each stage
Meta:@adcost
     @costCreationWithRevisions
     @adcostSmokeUAT
     @adcostSmoke
!--QA-727
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type | Production Type    |  Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CCRCGTCT4  | CCRCGTD8    | Christine Meyer (Leo Burnett) | 50000                | Audio        | Full Production    |  CCRCGTATN8             | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCRCGTCT4' with following fields:
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And added expected asset details for cost title 'CCRCGTCT4':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | CCRCGTAT8   | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CCRCGTCT4':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 10000                 | 10000         | 10000       | 1234567890                        |
And uploaded following supporting documents to cost title 'CCRCGTCT4':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'CCRCGTCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CCRCGTCT4'
And I am on cost review page of cost item with title 'CCRCGTCT4'
Then I should see following data in cost section on Cost Review page:
| Section Name                       | Original Estimate Local | Original Estimate |
| STUDIO COSTS;VO recording sessions | $ 10,000.00             | $ 10,000.00       |
| STUDIO COSTS;Talent fees           | $ 10,000.00             | $ 10,000.00       |
| STUDIO COSTS;SUBTOTAL STUDIO COSTS | $ 20,000.00             | $ 20,000.00       |
| OTHER COSTS;P&G insurance          | $ 10,000.00             | $ 10,000.00       |
| OTHER COSTS;SUBTOTAL OTHER COSTS   | $ 10,000.00             | $ 10,000.00       |
| Grand Total                        | $  30,000.00            | $  30,000.00      |
And I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRCGTCT4'
And cost with title 'CCRCGTCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRCGTCT4'
And click 'Create Revision' button and 'Confirm' on cost review page
And I add cost item details for cost title 'CCRCGTCT4' with 'USD' currency:
| VO recording sessions | P&G insurance | Talent fees |
| 20000                 | 15000         | 15000       |
And I upload following supporting documents to cost title 'CCRCGTCT4':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'CCRCGTCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'CCRCGTCT4'
And I am on cost review page of cost item with title 'CCRCGTCT4'
And refresh the page without delay
Then I should see following data in cost section on Cost Review page:
| Section Name                       | Original Estimate | Current Revision Local | Current Revision |
| STUDIO COSTS;VO recording sessions | $ 10,000.00       | $ 20,000.00            | $ 20,000.00      |
| STUDIO COSTS;Talent fees           | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| STUDIO COSTS;SUBTOTAL STUDIO COSTS | $ 20,000.00       | $ 35,000.00            | $ 35,000.00      |
| OTHER COSTS;P&G insurance          | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| OTHER COSTS;SUBTOTAL OTHER COSTS   | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| Grand Total                        | $  30,000.00      | $  50,000.00           | $  50,000.00     |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRCGTCT4'
And cost with title 'CCRCGTCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRCGTCT4'
And click 'Next Stage' button and 'Confirm' on cost review page
And I fill Cost Line Items with following fields for cost title 'CCRCGTCT4':
| VO recording sessions | P&G insurance | Talent fees |
| 25000                 | 18000         | 17000       |
And I upload following supporting documents to cost title 'CCRCGTCT4':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And add below approvers for cost title 'CCRCGTCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'CCRCGTCT4'
And I am on cost review page of cost item with title 'CCRCGTCT4'
And refresh the page without delay
Then I should see following data in cost section on Cost Review page:
| Section Name                       | Original Estimate | Final Actual Local | Final Actual |
| STUDIO COSTS;VO recording sessions | $ 10,000.00       | $ 25,000.00        | $ 25,000.00  |
| STUDIO COSTS;Talent fees           | $ 10,000.00       | $ 17,000.00        | $ 17,000.00  |
| STUDIO COSTS;SUBTOTAL STUDIO COSTS | $ 20,000.00       | $ 42,000.00        | $ 42,000.00  |
| OTHER COSTS;P&G insurance          | $ 10,000.00       | $ 18,000.00        | $ 18,000.00  |
| OTHER COSTS;SUBTOTAL OTHER COSTS   | $ 10,000.00       | $ 18,000.00        | $ 18,000.00  |
| Grand Total                        | $  30,000.00      | $  60,000.00       | $  60,000.00 |
And 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
| Final Actual      | 0.00                             | 60000.00                    | 60000.00 |