Feature: Current Revision Version
Narrative:
In order to
As a CostOwner
I want to check Cost Current Reivision Version on Cost Review page


Scenario: Check that version selection from current revision beacon loads correct data on review page for Original Estimate Stage Production type
Meta:@adcost
     @costCreationWithRevisions
     @adcostSmokeUAT
     @adcostSmoke
!--QA-729
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art  | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CCRVCT1    | CCRVD1      | Lily Ross (Publicis) | 12000                | Still Image  | Post Production Only | CCRVATN1               | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCRVCT1' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'CCRVCT1':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CCRVAT1     | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'CCRVCT1':
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000                  | 20000      | 10000            | 1234567890                        |
And I uploaded following supporting documents to cost title 'CCRVCT1' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CCRVCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCT1'
And cost with title 'CCRVCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRVCT1'
And click 'Create Revision' button and 'Confirm' on cost review page
And add cost item details for cost title 'CCRVCT1' with 'USD' currency:
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain |
| 5000                   | 25000      | 0                |
And I upload following supporting documents to cost title 'CCRVCT1':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'CCRVCT1':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'CCRVCT1'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCT1'
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRVCT1'
And click 'Create Revision' button and 'Confirm' on cost review page
And add cost item details for cost title 'CCRVCT1' with 'USD' currency:
| Retouching | FX (Loss) & Gain | Agency Travel |
| 500        | 30000            | 5000          |
And I upload following supporting documents to cost title 'CCRVCT1':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'CCRVCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'CCRVCT1'
And I am on cost review page of cost item with title 'CCRVCT1'
When I select '1' revision from 'Current Revision' beacon drop down on Cost Review page
And I refresh the page without delay
Then I should see following data in cost section on Cost Review page:
| Section Name                               | Original Estimate | Current Revision Local         | Current Revision |
| Retouching                                 | $ 20,000.00       | $ 500.00                       | $ 500.00                 |
| SUBTOTAL STILL IMAGE POST PRODUCTION COST  | $ 20,000.00       | $ 500.00                       | $ 500.00                 |
| Agency Artwork / Packs                     | $ 10,000.00       | $ 5,000.00                     | $ 5,000.00               |
| Agency Travel                              | $ 0.00            | $ 5,000.00                     | $ 5,000.00               |
| SUBTOTAL AGENCY COSTS                      | $ 10,000.00       | $ 10,000.00                    | $ 10,000.00              |
| FX (Loss) & Gain                           | $ 10,000.00       | $ 30,000.00                    | $ 30,000.00              |
| SUBTOTAL OTHER COSTS                       | $ 10,000.00       | $ 30,000.00                    | $ 30,000.00              |
| Grand Total                                | $  40,000.00      | $  40,500.00                   | $  40,500.00             |
When I select '2' revision from 'Current Revision' beacon drop down on Cost Review page
Then I should see following data in cost section on Cost Review page:
| Section Name                               | Original Estimate | Current Revision Local         | Current Revision |
| Retouching                                 | $ 20,000.00       | $ 25,000.00                    | $ 25,000.00               |
| SUBTOTAL STILL IMAGE POST PRODUCTION COST  | $ 20,000.00       | $ 25,000.00                    | $ 25,000.00               |
| Agency Artwork / Packs                     | $ 10,000.00       | $ 5,000.00                     | $ 5,000.00                |
| Agency Travel                              | $ 0.00            | $ 0.00                         | $ 0.00                    |
| SUBTOTAL AGENCY COSTS                      | $ 10,000.00       | $ 5,000.00                     | $ 5,000.00                |
| FX (Loss) & Gain                           | $ 10,000.00       | $ 0.00                         | $ 0.00                    |
| SUBTOTAL OTHER COSTS                       | $ 10,000.00       | $ 0.00                         | $ 0.00                    |
| Grand Total                                | $  40,000.00      | $  30,000.00                   | $  30,000.00              |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCT1'
And cost with title 'CCRVCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRVCT1'
And click 'Create Revision' button and 'Confirm' on cost review page
And add cost item details for cost title 'CCRVCT1' with 'USD' currency:
| Retouching | FX (Loss) & Gain | Agency Travel |
| 500        | 30000            | 5000          |
And I upload following supporting documents to cost title 'CCRVCT1':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCRVCT1'
And I am on cost review page of cost item with title 'CCRVCT1'
When I select '1' revision from 'Current Revision' beacon drop down on Cost Review page
Then I should see following data in cost section on Cost Review page:
| Section Name                               | Original Estimate | Current Revision Local           | Current Revision |
| Retouching                                 | $ 20,000.00       | $ 500.00                         | $ 500.00                   |
| SUBTOTAL STILL IMAGE POST PRODUCTION COST  | $ 20,000.00       | $ 500.00                         | $ 500.00                   |
| Agency Artwork / Packs                     | $ 10,000.00       | $ 5,000.00                       | $ 5,000.00                 |
| Agency Travel                              | $ 0.00            | $ 5,000.00                       | $ 5,000.00                 |
| SUBTOTAL AGENCY COSTS                      | $ 10,000.00       | $ 10,000.00                      | $ 10,000.00                |
| FX (Loss) & Gain                           | $ 10,000.00       | $ 30,000.00                      | $ 30,000.00                |
| SUBTOTAL OTHER COSTS                       | $ 10,000.00       | $ 30,000.00                      | $ 30,000.00                |
| Grand Total                                | $  40,000.00      | $  40,500.00                     | $  40,500.00               |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCT1'
And cost with title 'CCRVCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRVCT1'
And click 'Create Revision' button and 'Confirm' on cost review page
And add cost item details for cost title 'CCRVCT1' with 'USD' currency:
| Retouching | FX (Loss) & Gain | Agency Travel |
| 500        | 30000            | 5000          |
And I upload following supporting documents to cost title 'CCRVCT1':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCRVCT1'
And I am on cost review page of cost item with title 'CCRVCT1'
When I select '1' revision from 'Current Revision' beacon drop down on Cost Review page
Then I should see following data in cost section on Cost Review page:
| Section Name                               | Original Estimate | Current Revision Local           | Current Revision |
| Retouching                                 | $ 20,000.00       | $ 500.00                         | $ 500.00                   |
| SUBTOTAL STILL IMAGE POST PRODUCTION COST  | $ 20,000.00       | $ 500.00                         | $ 500.00                   |
| Agency Artwork / Packs                     | $ 10,000.00       | $ 5,000.00                       | $ 5,000.00                 |
| Agency Travel                              | $ 0.00            | $ 5,000.00                       | $ 5,000.00                 |
| SUBTOTAL AGENCY COSTS                      | $ 10,000.00       | $ 10,000.00                      | $ 10,000.00                |
| FX (Loss) & Gain                           | $ 10,000.00       | $ 30,000.00                      | $ 30,000.00                |
| SUBTOTAL OTHER COSTS                       | $ 10,000.00       | $ 30,000.00                      | $ 30,000.00                |

Scenario: Check that version selection from current revision beacon loads correct data on review page for First Presentation Stage Production type
Meta:@adcost
     @costCreationWithRevisions
!--QA-729
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art  | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CCRVCT2    | CCRVD1      | Aaron Royer (Grey)   | 9000                 | Video        | Full Production | CCRVATN2               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCRVCT2' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CCRVCT2':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CCRVAT2     | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'CCRVCT2':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And uploaded following supporting documents to cost title 'CCRVCT2' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'CCRVCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
And I login with details of 'IPMuser'
And I am on costs overview page
And 'Approve' the cost with title 'CCRVCT2'
And cost with title 'CCRVCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRVCT2'
And I 'NextStage' the cost with title 'CCRVCT2'
And I add cost item details for cost title 'CCRVCT2' with 'USD' currency:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 10000         | 4000          | 1234567890                        |
And I upload following supporting documents to cost title 'CCRVCT2':
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
| /files/EditWord.doc | Scope change approval form            |
And 'Submit' the cost with title 'CCRVCT2'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCT2'
And cost with title 'CCRVCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost overview page
And I 'CreateRevision' the cost with title 'CCRVCT2'
And I add cost item details for cost title 'CCRVCT2' with 'USD' currency:
| Talent fees | Offline edits |
| 3000        | 3000          |
And I upload following supporting documents to cost title 'CCRVCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCRVCT2'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCT2'
And cost with title 'CCRVCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost overview page
And I 'CreateRevision' the cost with title 'CCRVCT2'
And I add cost item details for cost title 'CCRVCT2' with 'USD' currency:
| Talent fees | Offline edits |
| 3000        | 2000          |
And I upload following supporting documents to cost title 'CCRVCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCRVCT2'
And I am on cost review page of cost item with title 'CCRVCT2'
When I select '1' revision from 'Current Revision' beacon drop down on Cost Review page
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Current Revision Local           | Current Revision |
| Talent fees                          | $ 3,000.00                       | $ 3,000.00                |
| SUBTOTAL PRODUCTION COST             | $ 3,000.00                       | $ 3,000.00                |
| Offline edits                        | $ 2,000.00                       | $ 2,000.00                |
| Audio finalization                   | $ 8,000.00                       | $ 8,000.00                |
| SUBTOTAL POST PRODUCTION COST        | $ 10,000.00                      | $ 10,000.00               |
| Agency travel                        | $ 4,000.00                       | $ 4,000.00                |
| SUBTOTAL AGENCY COSTS                | $ 4,000.00                       | $ 4,000.00                |
| Grand Total                          | $  17,000.00                     | $  17,000.00              |
When I select '2' revision from 'Current Revision' beacon drop down on Cost Review page
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Current Revision Local           | Current Revision |
| Talent fees                          | $ 3,000.00                       | $ 3,000.00                 |
| SUBTOTAL PRODUCTION COST             | $ 3,000.00                       | $ 3,000.00                 |
| Offline edits                        | $ 3,000.00                       | $ 3,000.00                 |
| Audio finalization                   | $ 8,000.00                       | $ 8,000.00                 |
| SUBTOTAL POST PRODUCTION COST        | $ 11,000.00                      | $ 11,000.00                |
| Agency travel                        | $ 4,000.00                       | $ 4,000.00                 |
| SUBTOTAL AGENCY COSTS                | $ 4,000.00                       | $ 4,000.00                 |
| Grand Total                          | $  18,000.00                     | $  18,000.00               |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCT2'
And cost with title 'CCRVCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost overview page
And I 'CreateRevision' the cost with title 'CCRVCT2'
And I add cost item details for cost title 'CCRVCT2' with 'USD' currency:
| Talent fees | Offline edits |
| 3000        | 3000          |
And I upload following supporting documents to cost title 'CCRVCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCRVCT2'
And I am on cost review page of cost item with title 'CCRVCT2'
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCT2'
And cost with title 'CCRVCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost overview page
And I 'CreateRevision' the cost with title 'CCRVCT2'
And I add cost item details for cost title 'CCRVCT2' with 'USD' currency:
| Talent fees | Offline edits |
| 2000        | 3000          |
And I upload following supporting documents to cost title 'CCRVCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCRVCT2'
And I am on cost review page of cost item with title 'CCRVCT2'
When I select '1' revision from 'Current Revision' beacon drop down on Cost Review page
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Current Revision Local          | Current Revision |
| Talent fees                          | $ 2,000.00                      | $ 2,000.00                |
| SUBTOTAL PRODUCTION COST             | $ 2,000.00                      | $ 2,000.00                |
| Offline edits                        | $ 3,000.00                      | $ 3,000.00                |
| Audio finalization                   | $ 8,000.00                      | $ 8,000.00                |
| SUBTOTAL POST PRODUCTION COST        | $ 11,000.00                     | $ 11,000.00               |
| Agency travel                        | $ 4,000.00                      | $ 4,000.00                |
| SUBTOTAL AGENCY COSTS                | $ 4,000.00                      | $ 4,000.00                |
| Grand Total                          | $  17,000.00                    | $  17,000.00              |


Scenario: Check current revision loads correct data on review page for First Presentation Stage Buyout type
Meta:@adcost
     @costCreationWithRevisions
!--QA-729
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Athletes  | Buyout                | CCRVCT3    | CCRVCD1     | Lily Ross (Publicis) | CCRVATN2               | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CCRVCT3' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And added negotiated terms page for cost title 'CCRVCT3' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'CCRVCT3'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'CCRVCT3':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'CCRVCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'CCRVCT3'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCT3'
And cost with title 'CCRVCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost overview page
And 'CreateRevision' the cost with title 'CCRVCT3'
And I add cost item details for cost title 'CCRVCT3' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 16000             | 15000                      |
And I upload following supporting documents to cost title 'CCRVCT3':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'CCRVCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'CCRVCT3'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCT3'
And cost with title 'CCRVCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost overview page
And 'CreateRevision' the cost with title 'CCRVCT3'
And I add cost item details for cost title 'CCRVCT3' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 14000                      |
And I upload following supporting documents to cost title 'CCRVCT3':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'CCRVCT3':
| Technical Approver |
| IPMuser            |
And I 'Submit' the cost with title 'CCRVCT3'
And on cost review page of cost item with title 'CCRVCT3'
When I select '1' revision from 'Current Revision' beacon drop down on Cost Review page
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Original Estimate | Current Revision Local | Current Revision |
| Usage/Residuals/Buyout Fee           | $ 10,000.00       | $ 14,000.00            | $ 14,000.00      |
| Base Compensation                    | $ 10,000.00       | $ 15,000.00            | $ 15,000.00      |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 20,000.00       | $ 29,000.00            | $ 29,000.00      |
| Grand Total                          | $  20,000.00      | $  29,000.00           | $  29,000.00     |
When I select '2' revision from 'Current Revision' beacon drop down on Cost Review page
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Current Revision Local | Current Revision |
| Usage/Residuals/Buyout Fee           | $ 15,000.00            | $ 15,000.00      |
| Base Compensation                    | $ 16,000.00            | $ 16,000.00      |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 31,000.00            | $ 31,000.00      |
| Grand Total                          | $  31,000.00           | $  31,000.00     |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCT3'
And I login with details of 'CostOwner'
And I am on cost overview page
And 'CreateRevision' the cost with title 'CCRVCT3'
And I add cost item details for cost title 'CCRVCT3' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 16000             | 15000                      |
And I upload following supporting documents to cost title 'CCRVCT3':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'CCRVCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'CCRVCT3'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCT3'
And cost with title 'CCRVCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'CreateRevision' the cost with title 'CCRVCT3'
And I add cost item details for cost title 'CCRVCT3' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'CCRVCT3':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'CCRVCT3':
| Technical Approver |
| IPMuser            |
And I 'Submit' the cost with title 'CCRVCT3'
And on cost review page of cost item with title 'CCRVCT3'
When I select '1' revision from 'Current Revision' beacon drop down on Cost Review page
Then I should see following data in cost section on Cost Review page:
| Section Name                         | Current Revision Local | Current Revision |
| Usage/Residuals/Buyout Fee           | $ 15,000.00            | $ 15,000.00      |
| Base Compensation                    | $ 15,000.00            | $ 15,000.00      |
| SUBTOTAL USAGE/BUYOUT/CONTRACT COSTS | $ 30,000.00            | $ 30,000.00      |
| Grand Total                          | $  30,000.00           | $  30,000.00     |


Scenario: Check that current revision beacon shows correct status for Approval or reject actions
Meta:@adcost
     @costCreationWithRevisions
!--QA-729, ADC-2208
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art  | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | CCRVCT4    | CCRVD4      | Lily Ross (Publicis) | 12000                | Still Image  | Post Production Only | CCRVATN4               | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CCRVCT4' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'CCRVCT4':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | CCRVAT4     | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'CCRVCT4':
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000                  | 20000      | 10000            | 1234567890                        |
And I uploaded following supporting documents to cost title 'CCRVCT4' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'CCRVCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCT4'
And cost with title 'CCRVCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRVCT4'
And click 'Create Revision' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'CCRVCT4':
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain |
| 5000                   | 25000      | 0                |
And I upload following supporting documents to cost title 'CCRVCT4':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'CCRVCT4'
And I login with details of 'IPMuser'
And 'Request Changes' the cost with title 'CCRVCT4'
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRVCT4'
Then I 'should' see status as 'Returned' in 'Current Revision' beacon on Cost Review page
And should see Current Revision as '1' on Cost Review page
When I click 'Reopen' button and 'Yes, reopen this cost' on cost review page
And fill Cost Line Items with following fields for cost title 'CCRVCT4':
| Retouching | FX (Loss) & Gain | Agency Travel |
| 500        | 30000            | 5000          |
And I upload following supporting documents to cost title 'CCRVCT4':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'CCRVCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'CCRVCT4'
And I am on cost review page of cost item with title 'CCRVCT4'
Then I 'should' see status as 'Pending;Returned' in 'Current Revision' beacon on Cost Review page
And should see Current Revision as '2' on Cost Review page
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCT4'
And cost with title 'CCRVCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRVCT4'
Then I 'should' see status as 'Approved;Returned' in 'Current Revision' beacon on Cost Review page
When I click 'Create Revision' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'CCRVCT4':
| Retouching | FX (Loss) & Gain | Agency Travel |
| 1000        | 30000           | 5000          |
And I upload following supporting documents to cost title 'CCRVCT4':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'CCRVCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'CCRVCT4'
And I am on cost review page of cost item with title 'CCRVCT4'
Then I 'should' see status as 'Pending;Approved;Returned' in 'Current Revision' beacon on Cost Review page
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCT4'
And cost with title 'CCRVCT4' is 'Reject' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRVCT4'
Then I 'should' see status as 'Returned;Approved;Returned' in 'Current Revision' beacon on Cost Review page
When I click 'Reopen' button and 'Yes, reopen this cost' on cost review page
And fill Cost Line Items with following fields for cost title 'CCRVCT4':
| Retouching | FX (Loss) & Gain | Agency Travel |
| 2500       | 30000            | 10000         |
And I upload following supporting documents to cost title 'CCRVCT4':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And add below approvers for cost title 'CCRVCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'CCRVCT4'
And I am on cost review page of cost item with title 'CCRVCT4'
Then I 'should' see status as 'Pending;Returned;Approved;Returned' in 'Current Revision' beacon on Cost Review page
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'CCRVCT4'
And cost with title 'CCRVCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'CCRVCT4'
Then I 'should' see status as 'Approved;Returned;Approved;Returned' in 'Current Revision' beacon on Cost Review page