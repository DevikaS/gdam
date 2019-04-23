Feature: ACL
Narrative:
In order to
As a GlobalAdmin
I want to check ACL agency BU functionality


Scenario: Check that user with Agency role can only view costs from same agency
Meta:@adcost
     @adcostACL
!--QA-733, ADC-1771,
Given I logged in as 'GlobalAdmin'
And created the following agency:
| Name     | A4User        | Country        | Labels                                                               | Application Access    |
| AACLAUBU | DefaultA4User | United Kingdom | GID_100000,PGSAPVENDORID_VH8888,PC_GBP,SMO_ASEAN GROUP,adcost,costPG | adcost,folders,adkits |
And created users with following fields and waited until replication to Cost Module:
| Email                           | Role        | AgencyUnique | Access                                    |
| AACLAUAgencyAdmin1              | agency.user | AACLAUBU     | dashboard,adkits,approvals,folders,adcost |
| AACLAUAgencyFinanceManager      | agency.user | AACLAUBU     | dashboard,adkits,approvals,folders,adcost |
| AACLAUCentralAdaptationSupplier | agency.user | AACLAUBU     | dashboard,adkits,approvals,folders,adcost |
And added existing user 'AACLAUAgencyAdmin1' to agency 'DefaultAgency' with role 'agency.user'
And assigned user with following access in cost module:
| Email                           | User Role                   | Approval limit | Access Type | Condition |
| AACLAUAgencyAdmin1              | Agency Admin                |                | Client      | AACLAUBU  |
| AACLAUAgencyFinanceManager      | Agency Finance Manager      |                | Client      | AACLAUBU  |
| AACLAUCentralAdaptationSupplier | Central Adaptation Supplier |                | Client      | AACLAUBU  |
And logged in with details of 'AACLAUAgencyAdmin1'
And I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name          | Custom Code | Advertiser | Sector        | Brand        |
| AACLAUProject | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region  | Campaign        | Organisation | Agency Payment Currency |
| AACLAUProject  | AACLAUCT1  | AACLAUD1    | Christine Meyer (Leo Burnett) | 20000                | Digital Development | AACLAUATN1             | AAK            | DefaultCampaign | BFO          | USD - US Dollar         |
When I login with details of 'CostOwner'
And I create a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art           | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region  | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | AACLAUCT2  | AACLAUD2    | Christine Meyer (Leo Burnett) | 20000                | Digital Development | AACLAUATN2             | AAK            | DefaultCampaign | BFO          | USD - US Dollar         |
And I am on costs overview page
Then I 'should not' see 'AACLAUCT1' cost item on Adcost overview page
And I 'should' see 'AACLAUCT2' cost item on Adcost overview page
When I login with details of 'AgencyOwner'
And I am on cost overview page
Then I 'should not' see 'AACLAUCT1' cost item on Adcost overview page
And I 'should' see 'AACLAUCT2' cost item on Adcost overview page
When I login with details of 'AACLAUAgencyAdmin1'
And I am on cost overview page
Then I 'should' see 'AACLAUCT1' cost item on Adcost overview page
And I 'should not' see 'AACLAUCT2' cost item on Adcost overview page
When I login with details of 'CostOwner'
And I am on cost overview page
Then I 'should not' see 'AACLAUCT1' cost item on Adcost overview page
And I 'should' see 'AACLAUCT2' cost item on Adcost overview page
When I login with details of 'AACLAUAgencyFinanceManager'
And I am on cost overview page
Then I 'should' see 'AACLAUCT1' cost item on Adcost overview page
And I 'should not' see 'AACLAUCT2' cost item on Adcost overview page
When I login with details of 'AACLAUCentralAdaptationSupplier'
And I am on cost overview page
Then I 'should' see 'AACLAUCT1' cost item on Adcost overview page
And I 'should not' see 'AACLAUCT2' cost item on Adcost overview page


Scenario: Check that cost owner able to see pre populated fields on cost review page
Meta:@adcost
     @adcostACL
!--QA-733, QA-1071, ADC-1772
Given I logged in with details of 'CostOwner'
And I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art  | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | AACLAUCT4  | AACLAUCD4   | Lily Ross (Publicis) | 55000                | Video        | Full Production | AACLAUATN4             | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'AACLAUCT4' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'AACLAUCT4':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | AACLAUAT1   | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'AACLAUCT4':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 40000              | 20000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'AACLAUCT4' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'AACLAUCT4':
| Technical Approver | Coupa Requisitioner     |
| IPMuser            | BrandManagementApprover |
And I 'Submit' the cost with title 'AACLAUCT4'
When I am on cost review page of cost item with title 'AACLAUCT4'
Then I 'should' see following data in 'Cost Details' section on Cost Review page:
| Agency Name | Agency Location | Agency Cost Creator | Project Name       | Brand        | Sector        |
| CostOwner   | AFGHANISTAN     | CostOwner           | DefaultCostProject | DefaultBrand | DefaultSector |


Scenario: Check that cost consultant can only view Costs they been invited to approve
Meta:@adcost
     @adcostACL
!--QA-733, ADC-1784
Given created users with following fields and waited until replication to Cost Module:
| Email                 | Role        | Agency        | Access                                    |
| AnotherCostConsultant | agency.user | AnotherAgency | dashboard,adkits,approvals,folders,adcost |
And I assigned user with following access in cost module:
| Email                 | User Role       | Approval limit | Access Type | Condition  |
| AnotherCostConsultant | Cost Consultant |                | Client      | AACLAUBU_1 |
And I logged in with details of 'CostOwner'
And I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art  | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | AACLAUCT5  | AACLAUCD5   | Lily Ross (Publicis) | 2000                 | Still Image  | Full Production | AACLAUATN5             | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'AACLAUCT5' with following fields:
| Talent Company      | Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Retouching Company  |
| GlobalDefaultVendor | GlobalDefaultVendor  | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | GlobalDefaultVendor |
And added expected asset details for cost title 'AACLAUCT5':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | AACLAUAT2   | Version | PR/Influencer    | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'AACLAUCT5':
| Preproduction | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 8000          | 2000       | 3000             | 1234567890                        |
And I uploaded following supporting documents to cost title 'AACLAUCT5' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
When I add below approvers for cost title 'AACLAUCT5':
| Technical Approver    | Coupa Requisitioner     |
| AnotherCostConsultant | BrandManagementApprover |
And I 'Submit' the cost with title 'AACLAUCT5'
And I login with details of 'AnotherCostConsultant'
And I am on cost overview page
Then I 'should' see '1' cost on overview page
And I 'should' see 'AACLAUCT5' cost item on Adcost overview page


Scenario: Check that cost owner able to see pre populated fields on cost detail page
Meta:@adcost
!--QA-733, QA-1071, ADC-1772
Given I logged in with details of 'CostOwner'
And I am on costs overview page
When I create a new 'production' cost on AdCosts overview page
Then I 'should' see following fields popoulated on cost deatil page for any new cost:
| Agency Name | Agency Location | Agency Cost Creator |
| CostOwner   | Afghanistan     | CostOwner           |
When I fill following fields on cost details page:
| Project Number     |
| DefaultCostProject |
Then I 'should' see following fields popoulated on cost deatil page for any new cost:
| Project Name       | Brand        | Sector        | Project Number     |
| DefaultCostProject | DefaultBrand | DefaultSector | DefaultCostProject |