Feature: TimeStamps
Narrative:
In order to
As a CostOwner
I want to check timestamps in cost module


Scenario: Check timestamps for modified and created and submitted at OE stage
Meta:@adcost
     @timeStamps
!--QA-1080
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | TSVCT1     | TSVCD1      | Aaron Royer (Grey)  | 50000                | Still Image  | Post Production Only |  TSVATN1                | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'TSVCT1' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'TSVCT1':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | TSVAT1      | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'TSVCT1':
| Artwork/packs | Retouching  | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000         | 20000       | 10000            | 1234567890                        |
And uploaded following supporting documents to cost title 'TSVCT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'TSVCT1':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
When I 'Submit' the cost with title 'TSVCT1'
Then I 'should' see following data for 'TSVCT1' cost item on Adcost overview page:
| TimeStamp |
| Today     |
When I open cost item with title 'TSVCT1' from costs overview page
Then I 'should' following timestamps on cost review page for cost title 'TSVCT1':
| Created | Submitted |
| Today   | Today     |


Scenario: Check timestamps for modified and created and submitted at CR Stage
Meta:@adcost
     @timeStamps
!--QA-1080
Given I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title  | Description  | Agency Producer/Art | Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | TSVCT2      | TSVDC2       | Aaron Royer (Grey)  | 30000                | TSVATN2                | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
And I filled Cost Line Items with following fields for cost title 'TSVCT2':
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 52000                          | 1234567890                        |
And added below approvers for cost title 'TSVCT2':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When I 'Submit' the cost with title 'TSVCT2'
And cost with title 'TSVCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'CreateRevision' the cost with title 'TSVCT2'
And I add cost item details for cost title 'TSVCT2' with 'USD' currency:
| Trafficking/Distribution Costs |
| 72000                          |
And I 'Submit' the cost with title 'TSVCT2'
Then I 'should' see following data for 'TSVCT2' cost item on Adcost overview page:
| TimeStamp |
| Today     |
When I open cost item with title 'TSVCT2' from costs overview page
Then I 'should' following timestamps on cost review page for cost title 'TSVCT2':
| Created | Submitted |
| Today   | Today     |


Scenario: Check timestamps for modified and created and submitted at next stage
Meta:@adcost
     @timeStamps
!--QA-1080
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art  | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | TSVCT3     | TSVCD3      | Aaron Royer (Grey)   | 9000                 | Video        | Full Production | TSVATN2                | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'TSVCT3' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2022       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'TSVCT3':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | TSVAT2      | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'TSVCT3':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And uploaded following supporting documents to cost title 'TSVCT3' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'TSVCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
And I login with details of 'IPMuser'
And I am on costs overview page
And 'Approve' the cost with title 'TSVCT3'
And cost with title 'TSVCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'TSVCT3'
And I 'NextStage' the cost with title 'TSVCT3'
And I fill Cost Line Items with following fields for cost title 'TSVCT3':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 10000         | 4000          | 1234567890                        |
And I upload following supporting documents to cost title 'TSVCT3':
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
| /files/EditWord.doc | Scope change approval form            |
And 'Submit' the cost with title 'TSVCT3'
Then I 'should' see following data for 'TSVCT3' cost item on Adcost overview page:
| TimeStamp |
| Today     |
When I open cost item with title 'TSVCT3' from costs overview page
Then I 'should' following timestamps on cost review page for cost title 'TSVCT3':
| Created | Submitted |
| Today   | Today     |