Feature: Grand Total Toast message and Vendor Details
Narrative:
In order to
As a CostOwner
I want to check Grand Total Toast message and Vendor Details


Scenario: Check that cost cannot be submitted if vendor label missing for an agency
Meta:@adcost
     @adcostEmails
!--QA-1111, bug # ADC-2648
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name   | A4User        | Country        | Labels                                          | Application Access    |
| TAVDBU | DefaultA4User | United Kingdom | GID_100000,PC_GBP,SMO_ASEAN GROUP,adcost,costPG | adcost,folders,adkits |
And created users with following fields and waited until replication to Cost Module:
| Email         | Role        | AgencyUnique | Access                                   |
| TAVDCostOwner | agency.user | TAVDBU      | dashboard,adkits,approvals,folders,adcost |
And added existing user 'TAVDCostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email         | User Role       | Approval limit | Access Type | Condition | NotificationBudgetRegionId |
| TAVDCostOwner | Agency Admin    |                | Client      | TAVDBU   |                             |
And logged in with details of 'TAVDCostOwner'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name        | Custom Code | Advertiser | Sector        | Brand        |
| TAVDProject | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| TAVDProject    | TAVDCT1    | TAVDCD1     | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | TAVDATN1               | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'TAVDCT1' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'TAVDCT1':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | TAVDAT1     | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'TAVDCT1':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 30000         | 1234567890                        |
And uploaded following supporting documents to cost title 'TAVDCT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'TAVDCT1':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
And I am on cost approval page of cost title 'TAVDCT1'
And refreshed the page without delay
When I click 'Submit' button on Adcost system page
Then I 'should' see 'Cost can't be submitted' pop up
And I 'should' see following data for 'TAVDCT1' cost item on Adcost overview page:
| Cost Stage        | Cost Status   | Approver      |
| Original Estimate | In Draft with | TAVDCostOwner |
And I 'should' see cost email notification for 'Technical Issue With Cost For Vendor Details' with field to 'adcostssupport@adstream.com' and subject 'TAVDCT1' contains following attributes:
| Cost Title |
| TAVDCT1    |


Scenario: Check toast message is visible when grand total is zero at Next stage
Meta:@adcost
!--QA-1111
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art  | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | TAVDCT2    | TAVDC2      | Lily Ross (Publicis) | 12000                | Still Image  | Post Production Only | TAVDATN2               | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'TAVDCT2' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'TAVDCT2':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | TAVDAT2     | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'TAVDCT2':
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000                  | 20000      | 10000            | 1234567890                        |
And I uploaded following supporting documents to cost title 'TAVDCT2':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'TAVDCT2':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
When 'Submit' the cost with title 'TAVDCT2'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'TAVDCT2'
And cost with title 'TAVDCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'TAVDCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
When I am on cost items page of cost title 'TAVDCT2'
When I fill Cost Line Items with following fields for cost title 'TAVDCT2':
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain |
| 0                      | 0          | 0                |
Then I 'should' see toast message as 'Grand total can't be 0' on budget page


Scenario: Check toast message is visible when grand total is zero at CR stage
Meta:@adcost
!--QA-1111
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art  | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | TAVDCT3    | TAVDCD3     | Lily Ross (Publicis) | 12000                | Still Image  | Post Production Only | TAVDATN3               | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'TAVDCT3' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'TAVDCT3':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | TAVDAT3     | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'TAVDCT3':
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000                  | 20000      | 10000            | 1234567890                        |
And I uploaded following supporting documents to cost title 'TAVDCT3':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'TAVDCT3':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
When 'Submit' the cost with title 'TAVDCT3'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'TAVDCT3'
And cost with title 'TAVDCT3' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'TAVDCT3'
And click 'Create Revision' button and 'Confirm' on cost review page
When I am on cost items page of cost title 'TAVDCT3'
When I fill Cost Line Items with following fields for cost title 'TAVDCT3':
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain |
| 0                      | 0          | 0                |
Then I 'should' see toast message as 'Grand total can't be 0' on budget page


Scenario: Check toast message is visible only when grand total is zero
Meta:@adcost
!--QA-1111
Given I logged in as 'CostOwner'
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Contract (celebrity & athletes) | TAVDCT4    | TAVDCD4     | Aaron Royer (Grey)  | TAVDATN4               | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
When I am on cost items page of cost title 'TAVDCT4'
And I fill Payment details section on cost items page with following details:
| Please enter a 10-digit IO number |
| 1234567890                        |
Then I 'should' see toast message as 'Grand total can't be 0' on budget page
When I click 'Continue' button on Adcost system page
Then I 'should' see toast message as 'Grand total can't be 0' on budget page
When I fill Payment details section on cost items page with following details:
| Base Compensation |
| 10000             |
Then I 'should not' see toast message 'Grand total can't be 0' visible on budget page