Feature: Payment Rules in Cost module
Narrative:
In order to
As a CostOwner
I want to check delete cost functionality


Scenario: Check Cost can be deleted at AIPE stage when cost is in draft status
Meta:@adcost
     @aipe
!--QA-719
Given I logged in with details of 'CostOwner'
And I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type | Production Type  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | AIPE  |
| DefaultCostProject | DCCOCT1    | DCCOCD1     | Christine Meyer (Leo Burnett) | 60000                | Video        | Full Production  | DCCOATN1               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         | true  |
And I added cost item details for cost title 'DCCOCT1' with 'USD' currency:
| Please enter a 10-digit IO number |
| 1234567890                        |
And I uploaded following supporting documents to cost title 'DCCOCT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And I added below approvers for cost title 'DCCOCT1':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When I am on cost overview page
And I click 'Delete Cost' and 'YES, DELETE THIS COST' on title 'DCCOCT1' from costs overview page
Then I 'should not' see 'DCCOCT1' cost item on overview page


Scenario: Check Production Cost can be deleted at Original Estimate stage when in draft status or not submitted
Meta:@adcost
     @adcostCriticalTests
     @adcostSmokeUAT
     @adcostSmoke
!--QA-719
Given I logged in with details of 'CostOwner'
And I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type | Production Type  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | DCCOCT2    | DCCOCD2     | Christine Meyer (Leo Burnett) | 60000                | Video        | CGI/Animation    | DCCOATN2               | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And I added production details for cost title 'DCCOCT2' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I added expected asset details for cost title 'DCCOCT2':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | DCCOAT2      | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
When I 'Delete' the cost with title 'DCCOCT2'
And I am on cost overview page
Then I 'should not' see 'DCCOCT2' cost item on overview page


Scenario: Check Usage Buyout Cost can be deleted at FinalActual stage when in draft status
Meta:@adcost
!--QA-719
Given I logged in with details of 'CostOwner'
And I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Film | Contract (celebrity & athletes) | DCCOCT3    | DCCOCD3     | Lily Ross (Publicis)| DCCOATN3               | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'DCCOCT3' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints    | Exclusivity                  | Start Date  | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air    | yes, if yes specify category | 12/12/2018  | 12/12/2019 | Exclusivity Category 1 | 9000           |
When I 'Delete' the cost with title 'DCCOCT3'
And I am on cost overview page
Then I 'should not' see 'DCCOCT3' cost item on overview page