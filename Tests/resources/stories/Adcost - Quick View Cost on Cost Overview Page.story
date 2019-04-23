Feature: Payment Rules in Cost module
Narrative:
In order to
As a CostOwner
I want to check Quick View cost functionality


Scenario: Check production Cost can be quick viewed on Cost overview page
Meta:@adcost
     @adcostSmokeUAT
     @adcostSmoke
!--QA-811
Given I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name     | Custom Code | Advertiser | Sector        | Brand        |
| QVCCOPP1 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| QVCCOPP1       | QVCCOPCT1  | QVCCOPCD1   | Aaron Royer (Grey)  | 60000                | Video        | CGI/Animation    | QVCCOPATN1             | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And I added production details for cost title 'QVCCOPCT1' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I added expected asset details for cost title 'QVCCOPCT1':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | QVCCOPAT1    | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And I am on cost items page of cost title 'QVCCOPCT1'
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | CGI/animation | Please enter a 10-digit IO number |
| 20000              | 5000          | 40000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'QVCCOPCT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And I am on cost approval page of cost title 'QVCCOPCT1'
And added below approvers for cost title 'QVCCOPCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I refreshed the page without delay
When I click 'Submit' button and 'Send for approval' on approval Page
Then I 'should' see following data for cost title 'QVCCOPCT1' in quick view option:
| Cost Title | Description | Cost Owner | Stage             | Status              | Approver | Company | Brand        | Campaign        | Agency            | Project  |
| QVCCOPCT1  | QVCCOPCD1   | CostOwner  | Original Estimate | Pending Approval by | IPMuser  | P&G     | DefaultBrand | DefaultCampaign | another qa agency | QVCCOPP1 |
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'QVCCOPCT1'
And cost with title 'QVCCOPCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'QVCCOPCT1'
And I upload following supporting documents to cost title 'QVCCOPCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And I 'Submit' the cost with title 'QVCCOPCT1'
And I login with details of 'IPMuser'
And I 'Approve' the cost with title 'QVCCOPCT1'
Then I 'should' see following data for cost title 'QVCCOPCT1' in quick view option:
| Cost Title | Description | Cost Owner | Stage        | Status    | Company | Brand        | Campaign        | Agency            | Project  |
| QVCCOPCT1  | QVCCOPCD1   | CostOwner  | Final Actual | Approved  | P&G     | DefaultBrand | DefaultCampaign | another qa agency | QVCCOPP1 |


Scenario: Check Usage Buyout Cost can be quick viewed on cost overview page
Meta:@adcost
!--QA-811
Given I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name     | Custom Code | Advertiser | Sector        | Brand        |
| QVCCOPP2 | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number | New  | Approval stage for submission | Type | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| QVCCOPP2       | true | OriginalEstimate              | Film | Contract (celebrity & athletes) | QVCCOPCT2  | QVCCOPCD2   | Aaron Royer (Grey)  | QVCCOPATN2             | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'QVCCOPCT2' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date  | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018  | 12/12/2019 | Exclusivity Category 1 | 20000          |
And I am on cost items page of cost title 'QVCCOPCT2'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee |  Please enter a 10-digit IO number |
| 10000             | 10000                      |  1234567890                        |
And I uploaded following supporting documents to cost title 'QVCCOPCT2':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'QVCCOPCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I am on cost approval page of cost title 'QVCCOPCT2'
And I refreshed the page without delay
And I clicked 'Submit' button and 'Send for approval' on approval Page
And I logged in with details of 'IPMuser'
And I 'Approve' the cost with title 'QVCCOPCT2'
And cost with title 'QVCCOPCT2' is 'Approve' on behalf of MyPurchases application
And I logged in with details of  'CostOwner'
And I 'CreateRevision' the cost with title 'QVCCOPCT2'
And I added cost item details for cost title 'QVCCOPCT2' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 12000                      |
And I uploaded following supporting documents to cost title 'QVCCOPCT2':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And I 'Submit' the cost with title 'QVCCOPCT2'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Current Revision' for cost title 'QVCCOPCT2'
Then I 'should' see following data for cost title 'QVCCOPCT2' in quick view option:
| Cost Title | Description  | Cost Owner | Stage            | Status              | Approver | Company | Brand        | Campaign        | Agency            | Project  |
| QVCCOPCT2  | QVCCOPCD2    | CostOwner  | Current Revision | Pending Approval by | IPMuser  | P&G     | DefaultBrand | DefaultCampaign | another qa agency | QVCCOPP2 |