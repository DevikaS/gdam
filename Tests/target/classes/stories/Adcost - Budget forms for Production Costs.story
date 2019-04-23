Feature: Budget Forms in Cost module
Narrative:
In order to
As a CostOwner
I want to check budget form functionality


Scenario: Check that governance manager is able to upload and download the budget forms
Meta:@adcost
     @adcostBudgetForm
     @adcostCriticalTests
     @adcostSmokeUAT
     @adcostSmoke
!--QA-732
Given I am on costs overview page
And logged in with details of 'GovernanceManager'
When I click on 'Budget Form' under admin section
Then I should able to upload following budget form template in admin section:
| FileName                                  | FormName         |
| /files/TestAudioAllSummaryBudgetForm.xlsx | AudioAllSummary  |
Then I should able to download 'AudioAllSummary' template with 'TestAudioAllSummaryBudgetForm.xlsx' budget form


Scenario: Check that CostOwner is able to see budget form templates on cost overview page
Meta:@adcost
     @adcostBudgetForm
!--QA-732
Given I am on costs overview page
Then I 'should' see all budget form templates on cost overview page:
|   Budget Form Template Name                   |
| Audio - All - Summary                         |
| Audio - All - Summary And Detail              |
| Digital - All - Summary                       |
| Digital - All - Summary And Detail            |
| Still Image - All - Summary                   |
| Still Image - All - Summary And Detail        |
| Video - Full production - Summary             |
| Video - Full production - Summary And Detail  |
| Video - Post production - Summary             |
| Video - Post production - Summary And Detail  |


Scenario: Check that CostOwner is able to download budget form template from cost overview page
Meta:@adcost
     @adcostBudgetForm
     @adcostCriticalTests
     @adcostSmokeUAT
     @adcostSmoke
!--QA-732
Given I logged in with details of 'GovernanceManager'
And I clicked on 'Budget Form' under admin section
And upload following budget form template in admin section:
| FileName                                   | FormName         |
| /files/Audio - All - Summary Only (3).xlsx | AudioAllSummary  |
When I login with details of 'CostOwner'
And I am on cost overview page
Then I  should able to download 'Audio - All - Summary' form type and 'Audio - All - Summary Only (3).xlsx' budget form template from overview page


Scenario: Check that Cost Owner able to upload budget form from cost item page
Meta:@adcost
     @adcostBudgetForm
     @adcostCriticalTests
     @adcostSmokeUAT
     @adcostSmoke
!--QA-732
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | BFPCCT1    | BFPCD6      | Aaron Royer (Grey) | 20000                | Still Image  | Full Production | BFPCATN6               | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'BFPCCT1' with following fields:
| Talent Company      | Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Retouching Company  |
| GlobalDefaultVendor | GlobalDefaultVendor  | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | GlobalDefaultVendor |
And added expected asset details for cost title 'BFPCCT1':
| Initiative | Asset Title   |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | BFPCAT6       |  Version | Tv               | 12/12/2017               | Yes      | Yes       | Japan   |
When I upload following budget form on cost item section for cost title 'BFPCCT1':
| FileName                               | FormName              |
| /files/Still ImageFP summary only.xlsx | StillImageAllSummary  |
And I am on cost items page of cost title 'BFPCCT1'
Then I 'should' see following Cost Line Items populated on cost item page:
| Preproduction | Talent fees | Retouching | FX (Loss) & Gain | P&G insurance | Agency Travel |
| $ 20000.00    | $ 10000.00  | $ 25000.00 | $ 0.00           | $ 56000.00    | $ 30000.00    |


Scenario: Check that Cost Owner not able to upload incorrect budget form on cost item page
Meta:@adcost
     @adcostBudgetForm
!--QA-732
Given I am on costs overview page
When I create a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | BFPCCT2    | BFPCD2      | Aaron Royer (Grey) | 20000                | Still Image  | Full Production | BFPCATN6               | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And add production details for cost title 'BFPCCT2' with following fields:
| Talent Company      | Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Retouching Company  |
| GlobalDefaultVendor | GlobalDefaultVendor  | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | GlobalDefaultVendor |
And add expected asset details for cost title 'BFPCCT2':
| Initiative | Asset Title   |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | BFPCAT6       |  Version | Tv               | 12/12/2017               | Yes      | Yes       | Japan   |
Then I 'should not' able to upload following budget form on cost item section for cost title 'BFPCCT2':
| FileName                                  | FormName         |
| /files/TestAudioAllSummaryBudgetForm.xlsx | AudioAllSummary  |


Scenario: Check that cost owner not able to upload the budget form with changed currency after initial stage
Meta:@adcost
     @adcostBudgetForm
!--QA-732
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | BFPCCT3    | BFPCD6      | Aaron Royer (Grey)  | 20000                | Still Image  | Full Production | BFPCATN6               | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'BFPCCT3' with following fields:
| Talent Company      | Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Retouching Company  |
| GlobalDefaultVendor | GlobalDefaultVendor  | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | GlobalDefaultVendor |
And added expected asset details for cost title 'BFPCCT3':
| Initiative | Asset Title   |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | BFPCAT6       |  Version | Tv               | 12/12/2017               | Yes      | Yes       | Japan   |
And I upload following budget form on cost item section for cost title 'BFPCCT3':
| FileName                               | FormName              |
| /files/Still ImageFP summary only.xlsx | StillImageAllSummary  |
And I filled Cost Line Items with following fields for cost title 'BFPCCT3':
|  Please enter a 10-digit IO number |
|  1234567890                        |
And uploaded following supporting documents to cost title 'BFPCCT3' and click continue:
| FileName            | FormName                |
| /files/EditWord.doc | P&G Communication Brief |
And added below approvers for cost title 'BFPCCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'BFPCCT3'
And I logged in with details of 'IPMuser'
And 'Approve' the cost with title 'BFPCCT3'
And cost with title 'BFPCCT3' is 'Approve' on behalf of MyPurchases application
And I logged in with details of 'CostOwner'
When I 'NextStage' the cost with title 'BFPCCT3'
Then I 'should not' able to upload following budget form on cost item section for cost title 'BFPCCT3':
| FileName                                            | FormName              |
| /files/Still ImageFP summary only-DiffCurrency.xlsx | StillImageAllSummary  |
