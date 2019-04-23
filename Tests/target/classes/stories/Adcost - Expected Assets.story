Feature: Expected Asset Details
Narrative:
In order to
As a CostOwner
I want to add Expected Asset Details to a cost

Scenario: Check that edited expected asset details are shown correctly on cost review page
Meta:@adcost
     @expectedAssets
!--QA-827
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | EACT1      | EACD1       | Aaron Royer (Grey)  | 8000                 | Still Image  | Full Production | EAATN1                 | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'EACT1' with following fields:
| Talent Company      | Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Retouching Company  |
| GlobalDefaultVendor | GlobalDefaultVendor  | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | GlobalDefaultVendor |
When I add expected asset details for cost title 'EACT1':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | EAATN1      | Version | Digital          | 12/12/2019               | HD         | Yes      | Yes       | JAPAN   |
And I am on expected assets page of cost title 'EACT1'
Then I 'should' see following fields on expected assets section on AdCosts expected assets page:
| Initiative | Asset Title | Definition | Media / Touchpoint | OVAL    | First Air / Insertion Date | Scrapped | Airing Country / Region |
| Giggles    | EAATN1      | HD         | Digital            | Version | 12/12/2019                 | Yes      | JAPAN                   |
When I edit asset with title 'EAATN1_Editjghm1' in assets section with following fields:
| Asset Title | OVAL | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Airing Country / Region |
| EAATN1_Edit | Lift | Out of home      | 12/12/2019               | Yes      | Yes       | JAPAN                   |
Then I 'should' see following fields on expected assets section on AdCosts expected assets page:
| Initiative | Asset Title | Media / Touchpoint | OVAL | First Air / Insertion Date | Scrapped | Airing Country / Region |
| Giggles    | EAATN1_Edit | Out of home        | Lift | 12/12/2019                 | Yes      | JAPAN                   |
When I click 'Continue' button on Adcost system page
And I fill Cost Line Items with following fields:
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 4000                   | 2000       | 3000             | 1234567890                        |
And I upload following supporting documents to cost title 'EACT1' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And fill below approvers for cost title 'EACT1':
| Coupa Requisitioner       |
| BrandManagementApprover   |
And I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'EACT1'
Then I 'should' see following fields in expected assets section on Cost Review page:
| Initiative | Asset Title | Media / Touchpoint | OVAL | First Air / Insertion Date | Scrapped | Airing Country / Region |
| Giggles    | EAATN1_Edit | Out of home        | Lift | 12/12/2019                 | Yes      | JAPAN                   |


Scenario: Check that asset details can be deleted
Meta:@adcost
     @expectedAssets
!--QA-827
Given I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | EACT2      | EACD2       | Aaron Royer (Grey)  | 8000                 | Still Image  | Full Production | EAATN2                 | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
And added expected asset details for cost title 'EACT2':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | EAAT2       | Version | Digital          | 12/12/2019               | HD         | Yes      | Yes       | JAPAN   |
And added expected asset details for cost title 'EACT2':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | EAAT3       | Version | Digital          | 10/10/2029               | HD         | Yes      | Yes       | JAPAN   |
When I am on expected assets page of cost title 'EACT2'
Then I 'should' see Expected Assets or Deliverables count as '2' on Expected Assets page
When I click 'Delete' option for asset title 'EAAT2' in assets section on expected assets page
Then I 'should not' see asset details 'EAAT2' in expected assets section
And I 'should' see asset details 'EAAT3' in expected assets section
And I 'should' see Expected Assets or Deliverables count as '1' on Expected Assets page


Scenario: Check that cost can be created with duplicate expected assets
Meta:@adcost
     @expectedAssets
!--QA-827
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | EACT3      | EACD3       | Aaron Royer (Grey) | 20000                | Still Image  | Full Production | EAATN3                 | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'EACT3' with following fields:
| Talent Company      | Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Retouching Company  |
| GlobalDefaultVendor | GlobalDefaultVendor  | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | GlobalDefaultVendor |
And added expected asset details for cost title 'EACT3':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | EAAT3       | Version | streaming audio  | 12/12/2019               | HD         | Yes      | Yes       | JAPAN   |
And I am on expected assets page of cost title 'EACT3'
When I duplicate 'EAAT3' asset details on expected assets page
And I fill following fields on expected assets form page:
| Asset Title     | Get AD-Id |
| EAAT3_Duplicate | Yes       |
Then I 'should' see Expected Assets or Deliverables count as '2' on Expected Assets page
And I 'should' see following fields on expected assets section on AdCosts expected assets page:
| Initiative | Asset Title     | Media / Touchpoint | OVAL    | First Air / Insertion Date | Scrapped | Airing Country / Region |
| Giggles    | EAAT3           | streaming audio    | Version | 12/12/2019                 | Yes      | JAPAN                   |
| Giggles    | EAAT3_Duplicate | streaming audio    | Version | 12/12/2019                 | Yes      | JAPAN                   |
When I fill Cost Line Items with following fields for cost title 'EACT3':
| Preproduction | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000         | 12000      | 8000             | 1234567890                        |
And upload following supporting documents to cost title 'EACT3' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And add below approvers for cost title 'EACT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refresh the page without delay
And I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'EACT3'
Then I 'should' see following fields in expected assets section on Cost Review page:
| Initiative | Asset Title     | Media / Touchpoint | OVAL    | First Air / Insertion Date | Scrapped | Airing Country / Region |
| Giggles    | EAAT3           | streaming audio    | Version | 12/12/2019                 | Yes      | JAPAN                   |
| Giggles    | EAAT3_Duplicate | streaming audio    | Version | 12/12/2019                 | Yes      | JAPAN                   |
And I 'should' see Expected Assets or Deliverables count as '2' on Cost Review page


Scenario: Check that expected assets can be added during cost revision and next stage
Meta:@adcost
     @expectedAssets
!--QA-827
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | EACT4      | EAD4        | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | EAATN4                 | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'EACT4' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'EACT4':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | EAAT4       | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'EACT4':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And uploaded following supporting documents to cost title 'EACT4' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'EACT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'EACT4'
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'EACT4'
And cost with title 'EACT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'EACT4'
And click 'Create Revision' button and 'Confirm' on cost review page
And add expected asset details for cost title 'EACT4':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | EAAT5       | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And refresh the page without delay
And I add cost item details for cost title 'EACT4' with 'USD' currency:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 10000         | 3000          | 1234567890                        |
And I upload following supporting documents to cost title 'EACT4':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And 'Submit' the cost with title 'EACT4'
And on cost review page of cost item with title 'EACT4'
Then I 'should' see following fields in expected assets section on Cost Review page:
| Initiative | Asset Title | Media / Touchpoint | OVAL    | First Air / Insertion Date | Scrapped | Airing Country / Region |
| Giggles    | EAAT4       | Tv                 | Version | 31/12/2017                 | Yes      | JAPAN                   |
| Giggles    | EAAT5       | Tv                 | Version | 31/12/2017                 | Yes      | JAPAN                   |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'EACT4'
And cost with title 'EACT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'EACT4'
And click 'Next Stage' button and 'Confirm' on cost review page
And add expected asset details for cost title 'EACT4':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | EAAT6       | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And refresh the page without delay
And I fill Cost Line Items with following fields for cost title 'EACT4':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 5000               | 13000         | 4000          | 1234567890                        |
And I upload following supporting documents to cost title 'EACT4':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'EACT4'
And on cost review page of cost item with title 'EACT4'
Then I 'should' see following fields in expected assets section on Cost Review page:
| Initiative | Asset Title | Media / Touchpoint | OVAL    | First Air / Insertion Date | Scrapped | Airing Country / Region |
| Giggles    | EAAT4       | Tv                 | Version | 31/12/2017                 | Yes      | JAPAN                   |
| Giggles    | EAAT5       | Tv                 | Version | 31/12/2017                 | Yes      | JAPAN                   |
| Giggles    | EAAT6       | Tv                 | Version | 31/12/2017                 | Yes      | JAPAN                   |


Scenario: Check expected assets can be downloaded
Meta:@adcost
     @expectedAssets
!--QA-1066
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | EACT5      | EAD5        | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | EAATN5                 | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'EACT5' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
When I add expected asset details for cost title 'EACT5':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | EAAT7       | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
Then I 'should' see below information in downloaded Expected Assets for cost title 'EACT5':
| Initiative | Title | Duration | Media Type | O/V/A/L Type | First Air Date  | Scrapped | Airing Country/Region | Linked Usage Cost |
| Giggles    | EAAT7 | 10:10:10 | Tv         | Version      | 31/12/17        | True     | JAPAN                 |                   |