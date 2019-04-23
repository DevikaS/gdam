Feature: Payment Rules in Cost module
Narrative:
In order to
As a CostOwner
I want to check Recall cost functionality


Scenario: Check Cost can be recalled at AIPE stage when pending for approvals in cost module by Brand Management Approver
Meta:@adcost
@aipe
!--QA-720
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | AIPE |
| DefaultCostProject | RCCOPACT1  | RCCOPACD1   | Aaron Royer (Grey)  | 60000                | Video        | Full Production  | RCCOPAATN1             | AAK           | DefaultCampaign | BFO          | USD - US Dollar         | true |
And I added cost item details for cost title 'RCCOPACT1' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I uploaded following supporting documents to cost title 'RCCOPACT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'RCCOPACT1':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And I 'Submit' the cost with title 'RCCOPACT1'
And I am on cost overview page
When I click 'Recall Cost' and 'Yes, recall this cost' on title 'RCCOPACT1' from costs overview page
Then I 'should' see following data for 'RCCOPACT1' cost item on Adcost overview page:
| Cost Stage | Cost Status      |
| Aipe       | Recall requested |
When cost with title 'RCCOPACT1' is 'Recall' on behalf of MyPurchases application with page refresh
Then I 'should' see following data for 'RCCOPACT1' cost item on Adcost overview page:
| Cost Stage | Cost Status   |
| Aipe       | Recalled      |


Scenario: Check Production Cost can be resubmitted when recalled at Original Estimate stage and reopened
Meta:@adcost
     @adcostCriticalTests
     @adcostSmokeUAT
     @adcostSmoke
!--QA-720
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | RCCOPACT2  | RCCOPACD2   | Aaron Royer (Grey)  | 60000                | Video        | CGI/Animation    | RCCOPAATN2             | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And I added production details for cost title 'RCCOPACT2' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I added expected asset details for cost title 'RCCOPACT2':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | RCCOPAAT2    | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And I am on cost items page of cost title 'RCCOPACT2'
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 20000              | 5000          | 40000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'RCCOPACT2':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'RCCOPACT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCCOPACT2'
And I am on cost review page of cost item with title 'RCCOPACT2'
And I refreshed the page without delay
When I click 'Recall Cost' button and 'Yes, recall this cost' on cost review page
Then I 'should' see following fields in cost stage section on cost review page:
| Stage             | Status   |
| Original Estimate | Recalled |
When I click 'Reopen' button and 'Yes, reopen this cost' on cost review page
And I 'Submit' the cost with title 'RCCOPACT2'
And I login with details of 'IPMuser'
And I 'Approve' the cost with title 'RCCOPACT2'
And cost with title 'RCCOPACT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'RCCOPACT2'
And I upload following supporting documents to cost title 'RCCOPACT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And I 'Submit' the cost with title 'RCCOPACT2'
And I login with details of 'IPMuser'
And I 'Approve' the cost with title 'RCCOPACT2'
And I am on cost review page of cost item with title 'RCCOPACT2'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage        | Status   |
| Final Actual | Approved |


Scenario: Check Production Cost can be resubmitted at Final Actual stage when recalled and reopened
Meta:@adcost
     @adcostCriticalTests
     @adcostSmokeUAT
     @adcostSmoke
!--QA-720
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | RCCOPACT3  | RCCOPACD3   | Aaron Royer (Grey)  | 60000                | Video        | Post Production Only | RCCOPAATN3             | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And I added production details for cost title 'RCCOPACT3' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I added expected asset details for cost title 'RCCOPACT3':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | RCCOPAAT2    | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And I am on cost items page of cost title 'RCCOPACT3'
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 20000              | 5000          | 40000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'RCCOPACT3':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'RCCOPACT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCCOPACT3'
And I logged in with details of 'IPMuser'
And I 'Approve' the cost with title 'RCCOPACT3'
And cost with title 'RCCOPACT3' is 'Approve' on behalf of MyPurchases application
And I logged in with details of 'CostOwner'
And I 'NextStage' the cost with title 'RCCOPACT3'
And I uploaded following supporting documents to cost title 'RCCOPACT3':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And added below approvers for cost title 'RCCOPACT3':
| Technical Approver |
| IPMuser            |
And I 'Submit' the cost with title 'RCCOPACT3'
And I wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Final Actual' for cost title 'RCCOPACT3'
When I 'Recall' the cost with title 'RCCOPACT3'
And I am on cost review page of cost item with title 'RCCOPACT3'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage        | Status   |
| Final Actual | Recalled |
When I 'Reopen' the cost with title 'RCCOPACT3'
And add below approvers for cost title 'RCCOPACT3':
| Technical Approver |
| IPMuser            |
And I 'Submit' the cost with title 'RCCOPACT3'
And I login with details of 'IPMuser'
And I 'Approve' the cost with title 'RCCOPACT3'
And I am on cost review page of cost item with title 'RCCOPACT3'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage        | Status   |
| Final Actual | Approved |


Scenario: Check Usage Buyout Cost can be recalled at Original Estimate stage when pending for approvals in cost module by Technical Approver
Meta:@adcost
     @adcostCriticalTests
     @adcostSmokeUAT
     @adcostSmoke
!--QA-720
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Film | Contract (celebrity & athletes) | RCCOPACT4  | RCCOPACD4   | Aaron Royer (Grey)  | RCCOPAATN4             | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'RCCOPACT4' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date  | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018  | 12/12/2019 | Exclusivity Category 1 | 9000           |
And I am on cost items page of cost title 'RCCOPACT4'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee |  Please enter a 10-digit IO number |
| 10000             | 10000                      |  1234567890                        |
And I uploaded following supporting documents to cost title 'RCCOPACT4':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'RCCOPACT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCCOPACT4'
And I am on cost overview page
When I click 'Recall Cost' and 'Yes, recall this cost' on title 'RCCOPACT4' from costs overview page
Then I 'should' see following data for 'RCCOPACT4' cost item on Adcost overview page:
| Cost Stage        | Cost Status |
| Original Estimate | Recalled    |


Scenario: Check Usage Buyout Cost can be recalled at Original Estimate Revision stage when in pending for approval status
Meta:@adcost
!--QA-720
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Film | Contract (celebrity & athletes) | RCCOPACT5  | RCCOPACD5   | Aaron Royer (Grey)  | RCCOPAATN5             | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'RCCOPACT5' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date  | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018  | 12/12/2019 | Exclusivity Category 1 | 20000          |
And I am on cost items page of cost title 'RCCOPACT5'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee |  Please enter a 10-digit IO number |
| 10000             | 10000                      |  1234567890                        |
And I uploaded following supporting documents to cost title 'RCCOPACT5':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'RCCOPACT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCCOPACT5'
And I logged in with details of 'IPMuser'
And I 'Approve' the cost with title 'RCCOPACT5'
And cost with title 'RCCOPACT5' is 'Approve' on behalf of MyPurchases application
And I logged in with details of  'CostOwner'
And I 'CreateRevision' the cost with title 'RCCOPACT5'
And I added cost item details for cost title 'RCCOPACT5' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 12000                      |
And I uploaded following supporting documents to cost title 'RCCOPACT5':
| FileName            | FormName                           |
| /files/EditWord.doc | Scope change approval form         |
And I 'Submit' the cost with title 'RCCOPACT5'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Current Revision' for cost title 'RCCOPACT5'
When I 'Recall' the cost with title 'RCCOPACT5'
And I am on cost overview page
Then I 'should' see following data for 'RCCOPACT5' cost item on Adcost overview page:
| Cost Stage       | Cost Status |
| Current Revision | Recalled    |


Scenario: Check Production Cost can be recalled at First Presentation stage when in pending approval status
Meta:@adcost
!--QA-720
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | RCCOPACT6  | RCCOPACD6   | Aaron Royer (Grey)  | 60000                | Video        | Full Production | RCCOPAATN6             | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And I added production details for cost title 'RCCOPACT6' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I added expected asset details for cost title 'RCCOPACT6':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | RCCOPAAT6    | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | Japan   |
And I am on cost items page of cost title 'RCCOPACT6'
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 40000              | 20000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'RCCOPACT6':
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'RCCOPACT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCCOPACT6'
And I logged in with details of 'IPMuser'
And I 'Approve' the cost with title 'RCCOPACT6'
And cost with title 'RCCOPACT6' is 'Approve' on behalf of MyPurchases application
And I logged in with details of 'CostOwner'
And I 'NextStage' the cost with title 'RCCOPACT6'
And I uploaded following supporting documents to cost title 'RCCOPACT6':
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
And added below approvers for cost title 'RCCOPACT6':
| Technical Approver |
| IPMuser            |
And I 'Submit' the cost with title 'RCCOPACT6'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'First Presentation' for cost title 'RCCOPACT6'
When I 'Recall' the cost with title 'RCCOPACT6'
And I am on cost overview page
Then I 'should' see following data for 'RCCOPACT6' cost item on Adcost overview page:
| Cost Stage         | Cost Status |
| First Presentation | Recalled    |


Scenario: Check Production Cost can be recalled at First Presentation Revision stage when in pending approval status
Meta:@adcost
!--QA-721
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | RCCOPACT7  | RCCOPACD7   | Aaron Royer (Grey)  | 60000                | Video        | Full Production | RCCOPAATN7             | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And I added production details for cost title 'RCCOPACT7' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I added expected asset details for cost title 'RCCOPACT7':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | RCCOPAAT7    | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | Japan   |
And I am on cost items page of cost title 'RCCOPACT7'
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 40000              | 20000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'RCCOPACT7':
| FileName            | FormName                            |
| /files/EditWord.doc | Supplier winning bid (budget form)  |
| /files/EditWord.doc | P&G Communication Brief             |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script)|
And added below approvers for cost title 'RCCOPACT7':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCCOPACT7'
And I logged in with details of 'IPMuser'
And I 'Approve' the cost with title 'RCCOPACT7'
And cost with title 'RCCOPACT7' is 'Approve' on behalf of MyPurchases application
And I logged in with details of 'CostOwner'
And I 'NextStage' the cost with title 'RCCOPACT7'
And I uploaded following supporting documents to cost title 'RCCOPACT7':
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
And added below approvers for cost title 'RCCOPACT7':
| Technical Approver |
| IPMuser            |
And I 'Submit' the cost with title 'RCCOPACT7'
And I logged in with details of 'IPMuser'
And I 'Approve' the cost with title 'RCCOPACT7'
And I logged in with details of 'CostOwner'
And I 'CreateRevision' the cost with title 'RCCOPACT7'
And I added cost item details for cost title 'RCCOPACT7' with 'USD' currency:
| Audio finalization | Agency travel |
| 50000              | 9000          |
And I uploaded following supporting documents to cost title 'RCCOPACT7':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And added below approvers for cost title 'RCCOPACT7':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCCOPACT7'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Current Revision' for cost title 'RCCOPACT7'
When I 'Recall' the cost with title 'RCCOPACT7'
And I am on cost overview page
Then I 'should' see following data for 'RCCOPACT7' cost item on Adcost overview page:
| Cost Stage       | Cost Status |
| Current Revision | Recalled    |


Scenario: Check Cost can not be recalled When user selects no for recall cost confirmation
Meta:@adcost
 !--QA-720
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | RCCOPACT8  | RCCOPACD8   | Aaron Royer (Grey)  | 60000                | Video        | Full Production  | RCCOPAATN8             | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And I added production details for cost title 'RCCOPACT8' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I added expected asset details for cost title 'RCCOPACT8':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | RCCOPAAT7   | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | Japan   |
And I am on cost items page of cost title 'RCCOPACT8'
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 40000              | 20000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'RCCOPACT8':
| FileName            | FormName                                    |
| /files/EditWord.doc | Supplier winning bid (budget form)          |
| /files/EditWord.doc | P&G Communication Brief                     |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script)|
And added below approvers for cost title 'RCCOPACT8':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCCOPACT8'
And I am on cost overview page
When I click 'Recall Cost' and 'No' on title 'RCCOPACT8' from costs overview page
Then I 'should' see following data for 'RCCOPACT8' cost item on Adcost overview page:
| Stage             | Status                       |
| Original Estimate | Pending Approval by IPM User |