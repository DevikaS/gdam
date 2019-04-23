Feature: Reassign Owner by Agency Admin
Narrative:
In order to
As a CostOwner
I want to check reassign cost owner functionality


Scenario: Check that only agency admin can reassign the cost owner for production cost
Meta:@adcost
!--QA-1039
Given I created users with following fields and waited until replication to Cost Module:
| Email          | Role        | Agency        | Access                                    |
| RCOAACostOwner | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'RCOAACostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email          | User Role    | Approval limit | Access Type | Condition |
| RCOAACostOwner | Agency Owner |                | Client      | RCOAABU   |
And I am on costs overview page
When I create a new 'production' cost with following CostDetails:
| Project Number      | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject  | RCOAACT1   | RCOAACD1    | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | RCOAAATN1              | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And add production details for cost title 'RCOAACT1' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And add expected asset details for cost title 'RCOAACT1':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | RCOAATAT1    | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
When I update the cost owner field in quick view for cost title 'RCOAACT1' with new owner 'RCOAACostOwner'
Then I 'should' see following data for 'RCOAACT1' cost item on Adcost overview page:
| Cost Status   | Approver       |
| In Draft with | RCOAACostOwner |
When I am on cost review page of cost item with title 'RCOAACT1'
Then I 'should' land on cost review page for cost title 'RCOAACT1'
And I 'should' see following data in 'Cost Details' section on Cost Review page:
| Agency Cost Creator  |
| CostOwner            |
When I login with details of 'RCOAACostOwner'
Then I 'should not' see edit cost owner icon for cost title 'RCOAACT1' in quick view option
When I fill Cost Line Items with following fields for cost title 'RCOAACT1':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And upload following supporting documents to cost title 'RCOAACT1' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And add below approvers for cost title 'RCOAACT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'RCOAACT1'
And I am on cost overview page
Then I 'should' see following data for 'RCOAACT1' cost item on Adcost overview page:
| Cost Stage         | Cost Status         | Approver  |
| Original Estimate  | Pending Approval by | IPMuser   |
When I am on cost review page of cost item with title 'RCOAACT1'
Then I 'should' see following data in 'Cost Details' section on Cost Review page:
| Agency Cost Creator  |
| CostOwner            |


Scenario: Check that only agency admin can reassign the cost owner for usage buyout cost
Meta:@adcost
!--QA-1039
Given I created users with following fields and waited until replication to Cost Module:
| Email            | Role        | Agency        | Access                                    |
| RCOAACostOwner   | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
| RCOAACostOwner_1 | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'RCOAACostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email            | User Role    | Approval limit | Access Type | Condition |
| RCOAACostOwner   | Agency Owner |                | Client      | RCOAABU   |
| RCOAACostOwner_1 | Agency Owner |                | Client      | RCOAABU   |
And I am on costs overview page
When I create a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Athletes | Usage                 | RCOAACT2   | RCOAACD2    | Aaron Royer (Grey)  | RCOAAATN2              | Japan         | DefaultCampaign |  BFO         | USD - US Dollar         |
And I update the cost owner field in quick view for cost title 'RCOAACT2' with new owner 'RCOAACostOwner'
Then I 'should' see new owner as 'RCOAACostOwner' on quick view option for cost title 'RCOAACT2'
When I close quick view popup
Then I 'should' see following data for 'RCOAACT2' cost item on Adcost overview page:
| Cost Status   | Approver       |
| In Draft with | RCOAACostOwner |
Then I see below users under quick view option for cost title 'RCOAACT2':
| Users            | Condition  |
| RCOAACostOwner_1 | should     |
When I am on cost review page of cost item with title 'RCOAACT2'
Then I 'should' land on cost review page for cost title 'RCOAACT2'
And I 'should' see following data in 'Cost Details' section on Cost Review page:
| Agency Cost Creator  |
| CostOwner            |
When I login with details of 'RCOAACostOwner'
Then I 'should not' see edit cost owner icon for cost title 'RCOAACT2' in quick view option
When I am on usage buyout page of cost title 'RCOAACT2'
And add UsageBuyout details for cost title 'RCOAACT2' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 30000          |
And add negotiated terms page for cost title 'RCOAACT2' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'RCOAACT2'
And I fill Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee |  Please enter a 10-digit IO number |
| 10000             | 10000                      |  1234567890                        |
And I upload following supporting documents to cost title 'RCOAACT2':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And add below approvers for cost title 'RCOAACT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'RCOAACT2'
And I login with details of 'CostOwner'
And I update the cost owner field in quick view for cost title 'RCOAACT2' with new owner 'RCOAACostOwner_1'
Then I 'should' see new owner as 'RCOAACostOwner_1' on quick view option for cost title 'RCOAACT2'
When I am on cost review page of cost item with title 'RCOAACT2'
Then I 'should' see following data in 'Cost Details' section on Cost Review page:
| Agency Cost Creator  |
| CostOwner            |
When I login with details of 'IPMuser'
And I 'Approve' the cost with title 'RCOAACT2'
And cost with title 'RCOAACT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'RCOAACostOwner_1'
Then I 'should not' see edit cost owner icon for cost title 'RCOAACT2' in quick view option
When I 'NextStage' the cost with title 'RCOAACT2'
And I upload following supporting documents to cost title 'RCOAACT2':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
And 'Submit' the cost with title 'RCOAACT2'
And I am on cost overview page
And refresh the page without delay
Then I 'should' see following data for 'RCOAACT2' cost item on Adcost overview page:
| Cost Stage   | Cost Status         | Approver  |
| Final Actual | Pending Approval by | IPMuser   |


Scenario: Check that only agency admin can reassign the cost owner for traffic distribution cost
Meta:@adcost
!--QA-1039
Given I created users with following fields and waited until replication to Cost Module:
| Email          | Role        | Agency        | Access                                    |
| RCOAACostOwner | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'RCOAACostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email          | User Role    | Approval limit | Access Type | Condition |
| RCOAACostOwner | Agency Owner |                | Client      | RCOAABU   |
And I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | RCOAACT3   | RCOAACD3    | Aaron Royer (Grey)  | 30000                | RCOAAATN3              | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
When I update the cost owner field in quick view for cost title 'RCOAACT3' with new owner 'RCOAACostOwner'
Then I 'should' see new owner as 'RCOAACostOwner' on quick view option for cost title 'RCOAACT3'
When I close quick view popup
Then I 'should' see following data for 'RCOAACT3' cost item on Adcost overview page:
| Cost Status   | Approver       |
| In Draft with | RCOAACostOwner |
When I open cost item with title 'RCOAACT3' from costs overview page
Then I 'should' land on cost review page for cost title 'RCOAACT3'
And I 'should' see following data in 'Cost Details' section on Cost Review page:
| Agency Cost Creator  |
| CostOwner            |
When I login with details of 'RCOAACostOwner'
And I am on cost items page of cost title 'RCOAACT3'
And I fill Cost Line Items with following fields for cost title 'RCOAACT3':
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 20000                          |  1234567890                       |
And add below approvers for cost title 'RCOAACT3':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And I 'Submit' the cost with title 'RCOAACT3'
And I am on cost overview page
Then I 'should' see following data for 'RCOAACT3' cost item on Adcost overview page:
| Cost Stage         | Cost Status            |
| Original Estimate  | Pending Brand Approval |


Scenario: Check that agency admin can reassign the other agency admins and himself as cost owner from the same agency for production cost
Meta:@adcost
     @adcostSmokeUAT
     @adcostSmoke
!--QA-1075,QA-2554
Given I created users with following fields and waited until replication to Cost Module:
| Email            | Role        | Agency        | Access                                    |
| RCOAACostOwner | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And added existing user 'RCOAACostOwner' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email            | User Role    | Approval limit | Access Type | Condition |
| RCOAACostOwner | Agency Admin |                | Client      | RCOAABU   |
And I am on costs overview page
When I create a new 'production' cost with following CostDetails:
| Project Number      | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject  | RCOAACT4   | RCOAACD4    | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | RCOAAATN4              | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And add production details for cost title 'RCOAACT4' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And add expected asset details for cost title 'RCOAACT4':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | RCOAATAT4    | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
When I update the cost owner field in quick view for cost title 'RCOAACT4' with new owner 'RCOAACostOwner'
Then I 'should' see following history data for cost title 'RCOAACT4' in quick view option:
| Name            | Assigned Till |
| CostOwner       | Today         |
| RCOAACostOwner  |               |
When I login with details of 'RCOAACostOwner'
And I fill Cost Line Items with following fields for cost title 'RCOAACT4':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And upload following supporting documents to cost title 'RCOAACT4' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And add below approvers for cost title 'RCOAACT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'RCOAACT4'
And I login with details of 'CostOwner'
And I update the cost owner field in quick view for cost title 'RCOAACT4' with new owner 'CostOwner'
Then I 'should' see following history data for cost title 'RCOAACT4' in quick view option:
| Name            | Assigned Till |
| CostOwner       | Today         |
| RCOAACostOwner  | Today         |
| CostOwner       |               |