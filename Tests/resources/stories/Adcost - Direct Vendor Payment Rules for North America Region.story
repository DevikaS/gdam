Feature: Direct payment vendor Rules
Narrative:
In order to
As a GovernanceManager
I want to direct payment vendor rules for North America Region


Scenario: Check Direct Payment Vendor Rules for Still Image Content Type and Full Production
Meta:@adcost
     @directPaymentRules
     @adcostCycloneCosts
!--QA-700, rule no-194
Given I am on cost overview page
And I filled following data on vendor creation page to create new vendor:
|  Name            | Category               | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion  | ContentType | ProductionType      | TotalCostAmount | Rule name        | CostType  |
| DVPRNARVendor1   | Photographer Company   | DVPRNARSAP1     |  true               | true           | US Dollar        | CostTotal       | 0                 | 100         | true                    | North America | Still Image | Full Production     | 0               | DVPRNARDPRule1   | Production|
And I logged in with details of 'CycloneCostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number            | Cost Title    | Description  | Agency Producer/Art| Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | DVPRNARCT1    | DVPRNARD1    | Aaron Royer (Grey) | 20000                | Still Image  | Full Production | DVPRNARATN1            | North America | Campaign 1 | BFO          | USD - US Dollar         |
And added production details for cost title 'DVPRNARCT1' with following fields:
| Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Photographer Company Activate Direct Billing |
| DVPRNARVendor1       | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | Yes                                          |
And added expected asset details for cost title 'DVPRNARCT1':
| Initiative | Asset Title |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | DVPRNARAT6  |  Version | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'DVPRNARCT1':
| Preproduction | Retouching | FX (Loss) & Gain   |
| 10000         | 12000      | 8000               |
And uploaded following supporting documents to cost title 'DVPRNARCT1':
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
And added below approvers for cost title 'DVPRNARCT1':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'DVPRNARCT1'
And on cost review page of cost item with title 'DVPRNARCT1'
Then 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'DVPRNARCT1'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'DVPRNARCT1'
And I login with details of 'CycloneCostOwner'
And I 'NextStage' the cost with title 'DVPRNARCT1'
And I upload following supporting documents to cost title 'DVPRNARCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'DVPRNARCT1'
And I am on cost review page of cost item with title 'DVPRNARCT1'
Then 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate  | 0.00                             | 30000.00                    | 30000.00 |
| Final Actual       | 0.00                             | 30000.00                    | 30000.00 |


Scenario: Check Direct Payment Vendor Rules for Audio and Post production type cost
Meta:@adcost
     @directPaymentRules
     @adcostCycloneCosts
!--QA-700, ruleno-186
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
|  Name            | Category              | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion   | ContentType | ProductionType      | TotalCostAmount | Rule name      | CostType  |
| DVPRNARVendor2   | AudioMusicCompany     | DVPRNARSAP2     |  true               | true           | USD              | CostTotal       |1                  | 1           | true                    | North America  | Audio       | Post Production Only| 0;GreaterThan   | DVPRNARDPRule2 | Production|
And I logged in with details of 'CycloneCostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number            | Cost Title | Description   | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number   | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | DVPRNARCT2 | DVPRNARD2     | Aaron Royer (Grey)  | 50000                | Audio        | Post Production Only |  DVPRNARATN7              | North America | Campaign 1 | BFO          | USD - US Dollar         |
And added production details for cost title 'DVPRNARCT2' with following fields:
| Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company | Music Company Activate Direct Billing |
| 01/07/2019     | 2              | India             | New Delhi      | DVPRNARVendor2      | Yes                                   |
And added expected asset details for cost title 'DVPRNARCT2':
| Initiative | Country      | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | DVPRNARAT2   | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'DVPRNARCT2':
| VO recording sessions | P&G insurance | Talent fees |
| 10000                 | 10000         | 10000       |
And uploaded following supporting documents to cost title 'DVPRNARCT2':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'DVPRNARCT2':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'DVPRNARCT2'
And I am on cost review page of cost item with title 'DVPRNARCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 0.00                        | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'DVPRNARCT2'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'DVPRNARCT2'
And I login with details of 'CycloneCostOwner'
And I 'NextStage' the cost with title 'DVPRNARCT2'
And I fill Cost Line Items with following fields for cost title 'DVPRNARCT2':
| VO recording sessions | P&G insurance | Talent fees |
| 25000                 | 18000         | 17000       |
And I upload following supporting documents to cost title 'DVPRNARCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'DVPRNARCT2'
And I am on cost review page of cost item with title 'DVPRNARCT2'
Then 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                             | 0.00                    | 30000.00 |
| Final Actual      | 30000.00                             | 30000.00                | 60000.00 |


Scenario: Check Direct Payment Vendor Rules for Digital Content Type with revisions in each stage
Meta:@adcost
     @directPaymentRules
     @adcostCycloneCosts
!--QA-700, ruleno-190
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
|  Name         | Category                  | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion   | ContentType         | TotalCostAmount | Rule name      | CostType  |
| DPVRVendor3   | DigitalDevelopmentCompany | DVPRNARSAP3     |  true               | true           | USD              | CostTotal       | 0.5               | 1           | true                     | North America | Digital Development | 0;GreaterThan   | DVPRNARDPRule3 | Production|
And I logged in with details of 'CycloneCostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number            | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | DVPRNARCT3  | DVPRNARD3   | Aaron Royer (Grey)  | 50000                | Digital Development | DVPRNARATN3            | North America | Campaign 1 | BFO          | USD - US Dollar         |
And added production details for cost title 'DVPRNARCT3' with following fields:
| Digital Development Company | Digital Development Company Activate Direct Billing |
| DPVRVendor3                 | Yes                                                 |
And added expected asset details for cost title 'DVPRNARCT3':
| Initiative | Asset Title| Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | DVPRNARAT3 | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'DVPRNARCT3':
| Adaptation   | Virtual Reality | P&G insurance |
| 10000        | 10000           | 10000         |
And uploaded following supporting documents to cost title 'DVPRNARCT3':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'DVPRNARCT3':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'DVPRNARCT3'
And I am on cost review page of cost item with title 'DVPRNARCT3'
Then 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 15000.00                         | 15000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'DVPRNARCT3'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'DVPRNARCT3'
And I login with details of 'CycloneCostOwner'
And I 'NextStage' the cost with title 'DVPRNARCT3'
And fill Cost Line Items with following fields for cost title 'DVPRNARCT3':
| Adaptation   | Virtual Reality | P&G insurance |
| 20000        | 10000           | 20000         |
And I upload following supporting documents to cost title 'DVPRNARCT3':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'DVPRNARCT3'
And I am on cost review page of cost item with title 'DVPRNARCT3'
Then 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 15000.00                         | 15000.00                    | 30000.00 |
| Final Actual      | 15000.00                         | 35000.00                    | 50000.00 |


Scenario: Check Direct paymen rules for Still Image Content Type and Post Production
Meta:@adcost
     @directPaymentRules
     @adcostCycloneCosts
!--QA-700, ruleno-199
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
|  Name          | Category               | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | ContentType | ProductionType      | TotalCostAmount | Rule name     | CostType  |
| DPVRNARVendor4 | PhotographyCompany     | DVPRNARSAP4     |  true               | true           | USD              | CostTotal       |1                  | 1           | true                    | North America| Still Image | Post Production Only| 0;GreaterThan   | DVPRNARDPRule4 | Production|
And I logged in with details of 'CycloneCostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number            | Cost Title    | Description   | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number   | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCycloneCostProject | DVPRNARCT4    | DVPRNARD4     | Aaron Royer (Grey)  | 50000                | Still Image  | Post Production Only |  DVPRNARATN4              | North America | Campaign 1 | BFO          | USD - US Dollar         |
And added production details for cost title 'DVPRNARCT4' with following fields:
| Photographer Company |Photographer Company Activate Direct Billing |
| DPVRNARVendor4       |Yes                                          |
And added expected asset details for cost title 'DVPRNARCT4':
| Initiative | Asset Title    | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | DVPRNARAT4     | Version | Digital          | 12/12/2017               | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'DVPRNARCT4':
| Agency Artwork / Packs | Retouching      | FX (Loss) & Gain   |
| 10000                  | 20000           | 10000              |
And uploaded following supporting documents to cost title 'DVPRNARCT4':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'DVPRNARCT4':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'DVPRNARCT4'
And I am on cost review page of cost item with title 'DVPRNARCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 40000.00                        | 0.00                        | 40000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'DVPRNARCT4'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'DVPRNARCT4'
And I login with details of 'CycloneCostOwner'
And I 'NextStage' the cost with title 'DVPRNARCT4'
And fill Cost Line Items with following fields for cost title 'DVPRNARCT4':
| Agency Artwork / Packs | Retouching      | FX (Loss) & Gain   |
| 15000                  | 30000           | 15000              |
And I upload following supporting documents to cost title 'DVPRNARCT4':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'DVPRNARCT4'
And I am on cost review page of cost item with title 'DVPRNARCT4'
Then 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 40000.00                         | 0.00                        | 40000.00 |
| Final Actual      | 40000.00                         | 20000.00                    | 60000.00 |


Scenario: Check Direct payment rules for Audio Content Type and Full Production
Meta:@adcost
     @directPaymentRules
     @adcostCycloneCosts
!--QA-700, ruleno-183
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
|  Name          | Category      | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion  | ContentType | ProductionType   | TotalCostAmount | Rule name        | CostType  |
| DPVRNARVendor5 | TalentCompany | DVPRNARSAP5     |  true               | true           | GBP              | CostTotal       | 0.5               | 1           | true                    | North America | Audio       | Full Production  |0;GreaterThan    | DVPRNARDPRule5   | Production|
And I logged in with details of 'CycloneCostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number           | Cost Title    | Description   | Agency Producer/Art  | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
|DefaultCycloneCostProject | DVPRNARCT5    | DVPRNARD5     | Aaron Royer (Grey)   | 50000                | Audio        | Full Production      | DVPRNARATN5             | North America | Campaign 1 | BFO          | USD - US Dollar         |
And added production details for cost title 'DVPRNARCT5' with following fields:
| Talent Company  | Recording Date | Recording Days | Recording Country | Recording City | Talent Company Activate Direct Billing |
| DPVRNARVendor5  | 01/07/2019     | 2              | India             | New Delhi      | Yes                                    |
And added expected asset details for cost title 'DVPRNARCT5':
| Initiative | Country      | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | DVPRNARAT5   | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'DVPRNARCT5':
| VO recording sessions | P&G insurance | Talent fees |
| 10000                 | 10000         | 10000       |
And uploaded following supporting documents to cost title 'DVPRNARCT5':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'DVPRNARCT5':
| Technical Approver | Brand Management Approver |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'DVPRNARCT5'
And I am on cost review page of cost item with title 'DVPRNARCT5'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 15000.00                         | 15000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'DVPRNARCT5'
And I login with details of 'BrandManagementApprover'
And 'Approve' the cost with title 'DVPRNARCT5'
And I login with details of 'CycloneCostOwner'
And I 'NextStage' the cost with title 'DVPRNARCT5'
And I fill Cost Line Items with following fields for cost title 'DVPRNARCT5':
| VO recording sessions | P&G insurance | Talent fees |
| 25000                 | 18000         | 17000       |
And I upload following supporting documents to cost title 'DVPRNARCT5':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'DVPRNARCT5'
And I am on cost review page of cost item with title 'DVPRNARCT5'
Then 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 15000.00                         | 15000.00                    | 30000.00 |
| Final Actual      | 15000.00                         | 45000.00                    | 60000.00 |