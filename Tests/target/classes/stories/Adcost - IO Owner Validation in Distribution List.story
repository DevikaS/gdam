Feature: IO owner in Cost module
Narrative:
In order to
As a CostOwner
I want to validate IO Owner field in Distrubution List of a cost


Scenario: check that correct IO Owner is visible for production cost after cost is approved from COUPA
Meta:@adcost
!--QA-830, QA-1175
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | IOOVDLCT1  | IOOVDLD1    | Christine Meyer (Leo Burnett) | 50000                | Digital Development | IOOVDLATN1             | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'IOOVDLCT1' with following fields:
| Digital Development Company |
| GlobalDefaultVendor         |
And added expected asset details for cost title 'IOOVDLCT1':
| Initiative | Asset Title| Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | IOOVDLAT1   | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'IOOVDLCT1':
| Adaptation | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 1000       | 2000            | 1000          | 1234567890                        |
And uploaded following supporting documents to cost title 'IOOVDLCT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And I am on cost approval page of cost title 'IOOVDLCT1'
And added below approvers for cost title 'IOOVDLCT1':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And I 'Submit' the cost with title 'IOOVDLCT1'
When cost with title 'IOOVDLCT1' is 'Approve' on behalf of MyPurchases application by passing payload values:
| I/O# Owner          |
| AutoIOowner@pg.com  |
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'IOOVDLCT1'
Then I 'should' see IO Owner section on cost review page
And I 'should' see 'AutoIOowner@pg.com' email in io owner is hyperlinked on cost review page
And I 'should' see following data in 'I/O# Owner' section on Cost Review page:
| I/O# Owner                 | I/O# Owner TimeStamp |
| email   AutoIOowner@pg.com | Current Date         |


Scenario: check that correct IO Owner is visible for usage buyout cost after cost is approved from COUPA
Meta:@adcost
     @paymentRules
!--QA-830, QA-1175
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency  |
| DefaultCostProject | true | OriginalEstimate              | Athletes | Usage                 | IOOVDLCT2  | IOOVDLCD2   | Aaron Royer (Grey)  | IOOVDLATN2             | Greater China | DefaultCampaign |  BFO         | USD - US Dollar          |
And added UsageBuyout details for cost title 'IOOVDLCT2' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints   | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air   | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And added negotiated terms page for cost title 'IOOVDLCT2' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'IOOVDLCT2'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'IOOVDLCT2':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'IOOVDLCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'IOOVDLCT2'
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'IOOVDLCT2'
And cost with title 'IOOVDLCT2' is 'Approve' on behalf of MyPurchases application by passing payload values:
| I/O# Owner          |
| AutoIOowner@pg.com  |
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'IOOVDLCT2'
Then I 'should' see IO Owner section on cost review page
And I 'should' see 'AutoIOowner@pg.com' email in io owner is hyperlinked on cost review page
And I 'should' see following data in 'I/O# Owner' section on Cost Review page:
| I/O# Owner                 | I/O# Owner TimeStamp |
| email   AutoIOowner@pg.com | Current Date         |


Scenario: Check that IO Owner section is not visible for cyclone cost after cost is approved from brand manager
Meta:@adcost
!-- QA-829
Given I logged in with details of 'CycloneCostOwner'
And I am on costs overview page
And created a new 'Trafficking' cost with following CostDetails:
| Project Number            | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCycloneCostProject | IOOVDLCT3  | IOOVDLCD3   | Aaron Royer (Grey) | 50000                | IOOVDLATN3             | North America | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
When I am on cost items page of cost title 'IOOVDLCT3'
And I fill Cost Line Items with following fields:
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 80000                          |  1234567890                       |
And I fill below approvers for cost title 'IOOVDLCT3':
| Brand Management Approver |
| BrandManagementApprover   |
And 'Submit' the cost with title 'IOOVDLCT3'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'IOOVDLCT3'
And I login with details of 'CycloneCostOwner'
And I am on cost review page of cost item with title 'IOOVDLCT3'
Then I 'should not' see IO Owner section on cost review page