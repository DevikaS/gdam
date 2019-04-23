Feature: Cost Rejection Rules in Cost module
Narrative:
In order to
As a CostOwner
I want to check Reject cost functionality


Scenario: Check Cost can be rejected at AIPE stage when pending for approvals in cost module by Brand Management Approver
Meta:@adcost
     @aipe
!--QA-722
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | AIPE  |
| DefaultCostProject | RCBACT1    | RCBACD1     | Aaron Royer (Grey)  | 60000                | Video        | Full Production  | RCBAATN1               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         | true  |
And I added cost item details for cost title 'RCBACT1' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I uploaded following supporting documents to cost title 'RCBACT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And I added below approvers for cost title 'RCBACT1':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And I 'Submit' the cost with title 'RCBACT1'
When cost with title 'RCBACT1' is 'Reject' on behalf of MyPurchases application with page refresh
And I am on cost overview page
Then I 'should' see following data for 'RCBACT1' cost item on Adcost overview page:
| Cost Stage | Cost Status            |
| Aipe       | Returned to Originator |


Scenario: Check Production Cost can be rejected at Original Estimate stage when pending for approval by technical approver
Meta:@adcost
     @adcostCriticalTests
!--QA-722, QA-849
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | RCBACT2    | RCBACD2     | Aaron Royer (Grey)  | 60000                | Video        | CGI/Animation    | RCBAATN2               | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And I added production details for cost title 'RCBACT2' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I added expected asset details for cost title 'RCBACT2':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | RCBAAT2      | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And I am on cost items page of cost title 'RCBACT2'
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | Music  |Please enter a 10-digit IO number |
| 20000              | 5000          | 3000   |1234567890                        |
And I uploaded following supporting documents to cost title 'RCBACT2':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And I added below approvers for cost title 'RCBACT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCBACT2'
And logged in with details of 'IPMuser'
And I am on cost review page of cost item with title 'RCBACT2'
When I click 'Request Changes' button and 'Confirm & Submit' on cost review page with following rejection msg 'Test Comments'
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'RCBACT2'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage              | Status                 |
| Original Estimate  | Returned to Originator |
And I 'should' see following fields of rejection detail in distribution details section on cost review page:
| Timestamp          | Stage                  | Comments       |
| Current Date       | Original Estimate      | Test Comments  |



Scenario: Check Production Cost can be rejected and reopened at Final Actual stage when rejected in Coupa by brand manager
Meta:@adcost
     @adcostSmokeUAT
     @adcostSmoke
!--QA-722
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | RCBACT3    | RCBACD3     | Aaron Royer (Grey)  | 60000                | Video        | Post Production Only | RCBAATN3               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And I added production details for cost title 'RCBACT3' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I added expected asset details for cost title 'RCBACT3':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | RCBAAT3      | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And I am on cost items page of cost title 'RCBACT3'
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 20000              | 5000          | 40000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'RCBACT3':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And I added below approvers for cost title 'RCBACT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCBACT3'
And logged in with details of 'IPMuser'
And I 'Approve' the cost with title 'RCBACT3'
And cost with title 'RCBACT3' is 'Approve' on behalf of MyPurchases application
And logged in with details of 'CostOwner'
And I 'NextStage' the cost with title 'RCBACT3'
And I filled Cost Line Items with following fields for cost title 'RCBACT3':
| Audio finalization | Offline edits |
| 30000              | 9000          |
And I uploaded following supporting documents to cost title 'RCBACT3':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And I added below approvers for cost title 'RCBACT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCBACT3'
And logged in with details of 'IPMuser'
And I 'Approve' the cost with title 'RCBACT3'
When cost with title 'RCBACT3' is 'Reject' on behalf of MyPurchases application
And login with details of 'CostOwner'
Then I 'should' see following data for 'RCBACT3' cost item on Adcost overview page:
| Cost Stage   | Cost Status            |
| Final Actual | Returned to Originator |
When I click 'Reopen' and 'Yes, reopen this cost' on title 'RCBACT3' from costs overview page
And I add below approvers for cost title 'RCBACT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCBACT3'
And I login with details of 'IPMuser'
And I 'Approve' the cost with title 'RCBACT3'
And cost with title 'RCBACT3' is 'Approve' on behalf of MyPurchases application
And login with details of 'CostOwner'
And I am on costs overview page
Then I 'should' see following data for 'RCBACT3' cost item on Adcost overview page:
| Cost Stage   | Cost Status |
| Final Actual | Approved    |


Scenario: Check Usage Buyout Cost can be rejected and reopened at Original Estimate stage when pending for approvals in cost module by Brand Management Approver
Meta:@adcost
!--QA-722
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Film | Contract (celebrity & athletes) | RCBACT4    | RCBACD4     | Aaron Royer (Grey)  | RCBAATN4               | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'RCBACT4' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date  | End Date   | Exclusivity Category   |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018  | 12/12/2019 | Exclusivity Category 1 |
And I am on cost items page of cost title 'RCBACT4'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee |  Please enter a 10-digit IO number |
| 10000             | 10000                      |  1234567890                        |
And I uploaded following supporting documents to cost title 'RCBACT4':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And I added below approvers for cost title 'RCBACT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCBACT4'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'RCBACT4'
When login with details of  'IPMuser'
And I click 'Request Changes' and 'Confirm & Submit' on title 'RCBACT4' from costs overview page
And login with details of 'CostOwner'
And on cost review page of cost item with title 'RCBACT4'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage             | Status                 |
| Original Estimate | Returned to Originator |
When I click 'Reopen' button and 'Yes, reopen this cost' on cost review page
And I add below approvers for cost title 'RCBACT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCBACT4'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'RCBACT4'
And login with details of  'IPMuser'
And I 'Approve' the cost with title 'RCBACT4'
And cost with title 'RCBACT4' is 'Approve' on behalf of MyPurchases application
And login with details of 'CostOwner'
And I 'NextStage' the cost with title 'RCBACT4'
And I upload following supporting documents to cost title 'RCBACT4':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And I add below approvers for cost title 'RCBACT4':
| Technical Approver |
| IPMuser            |
And I 'Submit' the cost with title 'RCBACT4'
When login with details of  'IPMuser'
And I 'Approve' the cost with title 'RCBACT4'
And I login with details of 'CostOwner'
Then I 'should' see following data for 'RCBACT4' cost item on Adcost overview page:
| Cost Stage   | Cost Status |
| Final Actual | Approved    |


Scenario: Check Usage Buyout Cost can be rejected at Original Estimate Revision stage in Coupa
Meta:@adcost
!--QA-722
Given I am on costs overview page
And created a new 'buyout' cost on AdCosts overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Film | Contract (celebrity & athletes) | RCBACT5    | RCBACD5     | Aaron Royer (Grey)  | 9000                 | RCBAATN5               | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'RCBACT5' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date  | End Date   | Exclusivity Category   |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018  | 12/12/2019 | Exclusivity Category 1 |
And I am on cost items page of cost title 'RCBACT5'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee |  Please enter a 10-digit IO number |
| 10000             | 10000                      |  1234567890                        |
And I uploaded following supporting documents to cost title 'RCBACT5':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And I added below approvers for cost title 'RCBACT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCBACT5'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'RCBACT5'
And logged in with details of  'IPMuser'
And I 'Approve' the cost with title 'RCBACT5'
And cost with title 'RCBACT5' is 'Approve' on behalf of MyPurchases application
And logged in with details of  'CostOwner'
And I 'CreateRevision' the cost with title 'RCBACT5'
And I added cost item details for cost title 'RCBACT5' with 'USD' currency:
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 12000                      |
And I uploaded following supporting documents to cost title 'RCBACT5':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And I added below approvers for cost title 'RCBACT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCBACT5'
And logged in with details of  'IPMuser'
And I 'Approve' the cost with title 'RCBACT5'
When cost with title 'RCBACT5' is 'Reject' on behalf of MyPurchases application
Then I 'should' see following data for 'RCBACT5' cost item on Adcost overview page:
| Cost Stage       | Cost Status            |
| Current Revision | Returned to Originator |


Scenario: Check Production Cost can be rejected at First Presentation stage
Meta:@adcost
!--QA-722
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | RCBACT6    | RCBACD6     | Aaron Royer (Grey)  | 60000                | Video        | Full Production | RCBAATN6               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And I added production details for cost title 'RCBACT6' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I added expected asset details for cost title 'RCBACT6':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | RCBAAT6     | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | Japan   |
And I am on cost items page of cost title 'RCBACT6'
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 40000              | 20000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'RCBACT6':
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And I added below approvers for cost title 'RCBACT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCBACT6'
And logged in with details of 'IPMuser'
And I 'Approve' the cost with title 'RCBACT6'
And cost with title 'RCBACT6' is 'Approve' on behalf of MyPurchases application
And logged in with details of 'CostOwner'
And I 'NextStage' the cost with title 'RCBACT6'
And I uploaded following supporting documents to cost title 'RCBACT6':
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
And I added below approvers for cost title 'RCBACT6':
| Technical Approver |
| IPMuser            |
And I 'Submit' the cost with title 'RCBACT6'
And logged in with details of 'IPMuser'
And I clicked 'Request Changes' and 'Confirm & Submit' on title 'RCBACT6' from costs overview page
Then I 'should' see following data for 'RCBACT6' cost item on Adcost overview page:
| Cost Stage         | Cost Status            |
| First Presentation | Returned to Originator |


Scenario: Check Production Cost can be rejected at First Presentation Revision stage
Meta:@adcost
!--QA-722
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | RCBACT7    | RCBACD7     | Aaron Royer (Grey)  | 60000                | Video        | Full Production | RCBAATN7               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And I added production details for cost title 'RCBACT7' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I added expected asset details for cost title 'RCBACT7':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | RCBAAT7     | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | Japan   |
And I am on cost items page of cost title 'RCBACT7'
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 40000              | 20000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'RCBACT7':
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And I added below approvers for cost title 'RCBACT7':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCBACT7'
And logged in with details of 'IPMuser'
And I 'Approve' the cost with title 'RCBACT7'
And cost with title 'RCBACT7' is 'Approve' on behalf of MyPurchases application
And logged in with details of 'CostOwner'
And I 'NextStage' the cost with title 'RCBACT7'
And I uploaded following supporting documents to cost title 'RCBACT7':
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
And I added below approvers for cost title 'RCBACT7':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'RCBACT7'
And logged in with details of 'IPMuser'
And 'Approve' the cost with title 'RCBACT7'
And logged in with details of 'CostOwner'
And 'CreateRevision' the cost with title 'RCBACT7'
And I uploaded following supporting documents to cost title 'RCBACT7':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And I added below approvers for cost title 'RCBACT7':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'RCBACT7'
When login with details of 'IPMuser'
And 'Request Changes' the cost with title 'RCBACT7'
And login with details of 'CostOwner'
Then I 'should' see following data for 'RCBACT7' cost item on Adcost overview page:
| Cost Stage       | Cost Status            |
| Current Revision | Returned to Originator |


Scenario: Check Production Cost can be rejected multiple times at Final Actual stage by Cost Consultant
Meta:@adcost
!--QA-722, QA-849
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | RCBACT8    | RCBACD8     | Aaron Royer (Grey)  | 13000                | Video        | Full Production | RCBAATN8               | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And I added production details for cost title 'RCBACT8' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I added expected asset details for cost title 'RCBACT8':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | RCBAAT8     | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | Japan   |
And I am on cost items page of cost title 'RCBACT8'
And filled Cost Line Items with following fields:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 2000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'RCBACT8':
| FileName            | FormName                            |
| /files/EditWord.doc | Supplier winning bid (budget form)  |
| /files/EditWord.doc | P&G Communication Brief             |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script)|
And I added below approvers for cost title 'RCBACT8':
| Technical Approver | Coupa Requisitioner     |
| CostConsultant     | BrandManagementApprover |
And I 'Submit' the cost with title 'RCBACT8'
When I login with details of 'CostConsultant'
And I am on cost review page of cost item with title 'RCBACT8'
When I click 'Request Changes' button and 'Confirm & Submit' on cost review page with following rejection msg 'Test Comments1'
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'RCBACT8'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage             | Status                 |
| Original Estimate | Returned to Originator |
And I 'should' see following fields of rejection detail in distribution details section on cost review page:
| User Name       | Timestamp    | Stage             | Comments       |
| Cost Consultant | Current Date | Original Estimate | Test Comments1 |
When I 'Reopen' the cost with title 'RCBACT8'
And I 'Submit' the cost with title 'RCBACT8'
When login with details of 'CostConsultant'
And I 'Approve' the cost with title 'RCBACT8'
And cost with title 'RCBACT8' is 'Approve' on behalf of MyPurchases application
And login with details of 'CostOwner'
And I 'NextStage' the cost with title 'RCBACT8'
And I upload following supporting documents to cost title 'RCBACT8':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And I 'Submit' the cost with title 'RCBACT8'
And login with details of 'CostConsultant'
And I am on cost review page of cost item with title 'RCBACT8'
When I click 'Request Changes' button and 'Confirm & Submit' on cost review page with following rejection msg 'Test Comments2'
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'RCBACT8'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage        | Status                 |
| Final Actual | Returned to Originator |
And I 'should' see following fields of rejection detail in distribution details section on cost review page:
| User Name       | Timestamp    | Stage        | Comments       |
| Cost Consultant | Current Date | Final Actual | Test Comments2 |
When I 'Reopen' the cost with title 'RCBACT8'
And I 'Submit' the cost with title 'RCBACT8'
And login with details of 'CostConsultant'
And I am on cost review page of cost item with title 'RCBACT8'
When I click 'Request Changes' button and 'Confirm & Submit' on cost review page with following rejection msg 'Reject Comments 3'
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'RCBACT8'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage        | Status                 |
| Final Actual | Returned to Originator |
And I 'should' see following fields of rejection detail in distribution details section on cost review page:
| User Name       | Timestamp    | Stage        | Comments          |
| Cost Consultant | Current Date | Final Actual | Reject Comments 3 |
When I select '2' revision from 'Final Actual' beacon drop down on Cost Review page
Then I 'should' see following fields of rejection detail in distribution details section on cost review page:
| User Name | Timestamp    | Stage        | Comments       |
| Cost Consultant  | Current Date | Final Actual | Test Comments2 |
When I select '2' revision from 'Original Estimate' beacon drop down on Cost Review page
Then I 'should' see following fields of rejection detail in distribution details section on cost review page:
| User Name       | Timestamp    | Stage             | Comments       |
| Cost Consultant | Current Date | Original Estimate | Test Comments1 |


Scenario: Check that cost owner not able to change cost title and description after initial stage is approved
Meta:@adcost
!--QA-1041
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | RCBACT9    | RCBAD9      | Aaron Royer (Grey)| 10000                  | Digital Development | RCBAATN9               | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
And I added production details for cost title 'RCBACT9' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And I added expected asset details for cost title 'RCBACT9':
| Initiative | Asset Title | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | PRVJRPCAT2  | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'RCBACT9':
| Adaptation   | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 2000         | 8000            | 2000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'RCBACT9' and click continue:
| FileName            | FormName                            |
| /files/EditWord.doc | Supplier winning bid (budget form)  |
| /files/EditWord.doc | P&G Communication Brief             |
And added below approvers for cost title 'RCBACT9':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCBACT9'
And I logged in with details of 'IPMuser'
And 'Request Changes' the cost with title 'RCBACT9'
And I logged in with details of 'CostOwner'
When I click 'Reopen' and 'Yes, reopen this cost' on title 'RCBACT9' from costs overview page
And I edit cost for cost title 'RCBACT9' with following CostDetails:
| Cost Title    | Description   |
| RCBACT9-new   | RCBAD9-new    |
And I click 'Continue' button on Adcost system page
And I refresh the page without delay
And I 'Submit' the cost with title 'RCBACT9-new'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'RCBACT9-new'
And cost with title 'RCBACT9-new' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'RCBACT9-new'
And I am on cost details page of cost title 'RCBACT9-new'
Then I 'should not' able to edit the 'Cost Title' field on cost detail page for costTitle 'RCBACT9-new'
And I 'should not' able to edit the 'Description' field on cost detail page for costTitle 'RCBAD9-new'


Scenario: Check Cyclone cost can be rejected multiple times at different stages
Meta:@adcost
     @adcostCycloneCosts
!--QA-849
Given I logged in with details of 'CycloneCostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number            | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | RCBACT10   | RCBAD10     | Aaron Royer (Grey)  | 50000                | Still Image  | Post Production Only |  RCBAATN10              | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'RCBACT10' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'RCBACT10':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | RCBAAT10    | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'RCBACT10':
| Artwork/packs | Retouching  | FX (Loss) & Gain |
| 10000         | 20000       | 10000            |
And uploaded following supporting documents to cost title 'RCBACT10':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'RCBACT10':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'RCBACT10'
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'RCBACT10'
When I click 'Request Changes' button and 'Confirm & Submit' on cost review page with following rejection msg 'Test Comments'
And I login with details of 'CycloneCostOwner'
And I am on cost review page of cost item with title 'RCBACT10'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage             | Status                 |
| Original Estimate | Returned to Originator |
And I 'should' see following fields of rejection detail in distribution details section on cost review page:
| User Name  | Timestamp    | Stage             | Comments       |
| IPM User   | Current Date | Original Estimate | Test Comments  |
When I 'Reopen' the cost with title 'RCBACT10'
And I 'Submit' the cost with title 'RCBACT10'
And login with details of 'IPMuser'
And I am on cost review page of cost item with title 'RCBACT10'
When I click 'Request Changes' button and 'Confirm & Submit' on cost review page with following rejection msg 'Reject Comments 2'
And I login with details of 'CycloneCostOwner'
And I am on cost review page of cost item with title 'RCBACT10'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage             | Status                 |
| Original Estimate | Returned to Originator |
And I 'should' see following fields of rejection detail in distribution details section on cost review page:
| User Name | Timestamp    | Stage             | Comments          |
| IPM User  | Current Date | Original Estimate | Reject Comments 2 |
When I select '2' revision from 'Original Estimate' beacon drop down on Cost Review page
Then I 'should' see following fields of rejection detail in distribution details section on cost review page:
| User Name | Timestamp    | Stage             | Comments      |
| IPM User  | Current Date | Original Estimate | Test Comments |
When I 'Reopen' the cost with title 'RCBACT10'
And I 'Submit' the cost with title 'RCBACT10'
And login with details of 'IPMuser'
And 'Approve' the cost with title 'RCBACT10'
And I login with details of 'BrandManagementApprover'
And I am on cost review page of cost item with title 'RCBACT10'
And I click 'Request Changes' button and 'Confirm & Submit' on cost review page with following rejection msg 'Reject Comments 3'
And I login with details of 'CycloneCostOwner'
And I am on cost review page of cost item with title 'RCBACT10'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage             | Status                 |
| Original Estimate | Returned to Originator |
And I 'should' see following fields of rejection detail in distribution details section on cost review page:
| User Name                 | Timestamp    | Stage             | Comments          |
| Brand Management Approver | Current Date | Original Estimate | Reject Comments 3 |
When I 'Reopen' the cost with title 'RCBACT10'
And I 'Submit' the cost with title 'RCBACT10'
And login with details of 'IPMuser'
And 'Approve' the cost with title 'RCBACT10'
And I login with details of 'BrandManagementApprover'
And I 'Approve' the cost with title 'RCBACT10'
And I login with details of 'CycloneCostOwner'
And I 'CreateRevision' the cost with title 'RCBACT10'
And I add cost item details for cost title 'RCBACT10' with 'USD' currency:
| Artwork/packs | Retouching | FX (Loss) & Gain |
| 15000         | 20000      | 15000            |
And I upload following supporting documents to cost title 'RCBACT10':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'RCBACT10'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'RCBACT10'
And I login with details of 'BrandManagementApprover'
And I am on cost review page of cost item with title 'RCBACT10'
And I click 'Request Changes' button and 'Confirm & Submit' on cost review page with following rejection msg 'Reject Comments 4'
And I login with details of 'CycloneCostOwner'
And I am on cost review page of cost item with title 'RCBACT10'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage            | Status                 |
| Current Revision | Returned to Originator |
And I 'should' see following fields of rejection detail in distribution details section on cost review page:
| User Name                 | Timestamp    | Stage             | Comments          |
| Brand Management Approver | Current Date | Current Revision  | Reject Comments 4 |
When I 'Reopen' the cost with title 'RCBACT10'
And I 'Submit' the cost with title 'RCBACT10'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'RCBACT10'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'RCBACT10'
And I login with details of 'CycloneCostOwner'
And I 'NextStage' the cost with title 'RCBACT10'
And I upload following supporting documents to cost title 'RCBACT10':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'RCBACT10'
And login with details of 'IPMuser'
And I am on cost review page of cost item with title 'RCBACT10'
When I click 'Request Changes' button and 'Confirm & Submit' on cost review page with following rejection msg 'Reject Comments 5'
And I login with details of 'CycloneCostOwner'
And I am on cost review page of cost item with title 'RCBACT10'
Then I 'should' see following fields in cost stage section on cost review page:
| Stage        | Status                 |
| Final Actual | Returned to Originator |
And I 'should' see following fields of rejection detail in distribution details section on cost review page:
| User Name | Timestamp    | Stage        | Comments          |
| IPM User  | Current Date | Final Actual | Reject Comments 5 |
When I select '2' revision from 'Current Revision' beacon drop down on Cost Review page
Then I 'should' see following fields of rejection detail in distribution details section on cost review page:
| User Name                 | Timestamp    | Stage             | Comments          |
| Brand Management Approver | Current Date | Current Revision  | Reject Comments 4 |
When I select '2' revision from 'Original Estimate' beacon drop down on Cost Review page
Then I 'should' see following fields of rejection detail in distribution details section on cost review page:
| User Name                 | Timestamp    | Stage             | Comments          |
| Brand Management Approver | Current Date | Original Estimate | Reject Comments 3 |
When I select '3' revision from 'Original Estimate' beacon drop down on Cost Review page
Then I 'should' see following fields of rejection detail in distribution details section on cost review page:
| User Name | Timestamp    | Stage             | Comments          |
| IPM User  | Current Date | Original Estimate | Reject Comments 2 |