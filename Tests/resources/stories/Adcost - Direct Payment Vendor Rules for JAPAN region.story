Feature: Direct Vendor Payment Rules
Narrative:
In order to
As a GovernanceManager
I want to verify direct payment vendor rules functionality for JAPAN region


Scenario: Check Vendor payment split rules for cost greater than zero within JAPAN region for Audio and Post Production Only
Meta:@adcost
     @directPaymentRules
!--QA-706, rule no-86
Given I am on cost overview page
And I filled following data on vendor creation page to create new vendor:
|  Name           | Category             | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | ContentType | ProductionType      | TotalCostAmount | Rule name       | CostType  |
| DPVRJRVendor1   | Audio/Music Company  | DPVRJRSAP1      |  true               | true           | US Dollar        | CostTotal       |50                 | 100         | true                    | Japan        | Audio       | Post Production Only| 0               | DPVRJRDPRule    | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title     | Description    | Agency Producer/Art           | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region  | Campaign         | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRJRCT1      | DPVRJRCD1      |  Aldrin Anthony Galang (Grey) | 40000                | Audio        | Post Production Only | DPVRJRATN1             | Japan          | DefaultCampaign  | BFO          | USD - US Dollar         |
And filled Production Details with following fields for cost title 'DPVRJRCT1':
| Audio/Music Company   |
| DPVRJRVendor1;true    |
And added expected asset details for cost title 'DPVRJRCT1':
| Initiative | Country      | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | AAK          | DPVRJRAT4    | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'DPVRJRCT1':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 10000                 | 10000         | 10000       | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRJRCT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'DPVRJRCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'DPVRJRCT1'
And I am on cost review page of cost item with title 'DPVRJRCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 15000.00                         | 15000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'DPVRJRCT1'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRJRCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 30000        | 15000          | USD      | 1234567890 | DefaultBrand   | DPVRJRCD1    | brandDescription |
When cost with title 'DPVRJRCT1' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'DPVRJRCT1'
And I am on supporting documents of cost title 'DPVRJRCT1'
And I upload following supporting documents to cost title 'DPVRJRCT1' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'DPVRJRCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 15000.00                         | 15000.00                    | 30000.00 |


Scenario: Check payment split for cost greater than zero within JAPAN region for Digital type
Meta:@adcost
     @directPaymentRules
!--QA-706, rule no-17
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
|  Name          | Category                      | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | ContentType         | TotalCostAmount | Rule name       | CostType  |
|  DPVRJRVendor2 | DigitalDevelopmentCompany     | DPVRJRSAP2      |  true               | true           | USD              | CostTotal       | 0                 | 1           | true                    | Japan        | Digital Development | 0;GreaterThan   | DPVRJRDPRule2   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title   | Description  | Agency Producer/Art  | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRJRCT2    | DPVRJRCD2    | Aaron Royer (Grey)   | 50000                | Digital Development | DPVRJRATN2             | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'DPVRJRCT2' with following fields:
| Digital Development Company | Digital Development Company Activate Direct Billing |
| DPVRJRVendor2               | Yes                                                 |
And added expected asset details for cost title 'DPVRJRCT2':
| Initiative | Asset Title  | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | DPVRJRAT7    | Digital               | 12/12/2017               | Yes      | Yes       | IMEA   |
And filled Cost Line Items with following fields for cost title 'DPVRJRCT2':
| Adaptation   | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 30000        | 20000           | 10000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRJRCT2':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'DPVRJRCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'DPVRJRCT2'
And I am on cost review page of cost item with title 'DPVRJRCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 60000.00                    | 60000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'DPVRJRCT2'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRJRCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 60000        | 0              | USD      | 1234567890 | DefaultBrand   | DPVRJRCD2    | brandDescription |
When cost with title 'DPVRJRCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'DPVRJRCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And I upload following supporting documents to cost title 'DPVRJRCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'DPVRJRCT2'
And I am on cost review page of cost item with title 'DPVRJRCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 0.00                             | 60000.00                    | 60000.00 |


Scenario: Check payment split for cost greater than zero within JAPAN region for Still image and post production only
Meta:@adcost
     @directPaymentRules
!--QA-706, rule no-134
Given I am on cost overview page
And I filled following data on vendor creation page to create new vendor:
|  Name         | Category               | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | ContentType | ProductionType      | TotalCostAmount | Rule name       | CostType  |
| DPVRJRVendor3 | Photographer Company   | DPVRJRSAP3      |  true               | true           | US Dollar        | CostTotal       |100                | 100         | true                    | Japan        | Still Image | Post Production Only| 0               | DPVRJRDPRule3   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRJRCT3  | DPVRJRCD3   | Aaron Royer (Grey)  | 10000                | Still Image  | Post Production Only | DPVRJRATN3             | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
And filled Production Details with following fields for cost title 'DPVRJRCT3':
| Photographer Company  |
| DPVRJRVendor3;true    |
And added expected asset details for cost title 'DPVRJRCT3':
| Initiative | Asset Title |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country         |
| Giggles    | DPVRJRAT3   |  Version | Digital          | 12/12/2017               | Yes      | Yes       | Greater China   |
And filled Cost Line Items with following fields for cost title 'DPVRJRCT3':
| Agency Artwork / Packs | Retouching      | FX (Loss) & Gain   | Please enter a 10-digit IO number |
| 10000                  | 20000           | 10000              | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRJRCT3':
| FileName            | FormName                            |
| /files/EditWord.doc | Supplier winning bid (budget form)  |
| /files/EditWord.doc | P&G Communication Brief             |
And I added  below approvers for cost title 'DPVRJRCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'DPVRJRCT3'
And on cost review page of cost item with title 'DPVRJRCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 40000.00                         | 0.00                        | 40000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'DPVRJRCT3'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRJRCT3' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 40000        | 40000          | USD      | 1234567890 | DefaultBrand | DPVRJRCD3   | brandDescription |
When cost with title 'DPVRJRCT3' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And on cost review page of cost item with title 'DPVRJRCT3'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'DPVRJRCT3':
| Agency Artwork / Packs | Retouching      | FX (Loss) & Gain   |
| 15000                  | 20000           | 15000              |
And I upload following supporting documents to cost title 'DPVRJRCT3':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'DPVRJRCT3'
And on cost review page of cost item with title 'DPVRJRCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 40000.00                         | 0.00                        | 40000.00 |
| Final Actual      | 40000.00                         | 10000.00                    | 50000.00 |


Scenario: Check payment split for cost more than zero within JAPAN region for Audio content type and Full production
Meta:@adcost
     @directPaymentRules
!--QA-706, rule no-119
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
|  Name         | Category         | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion  | ContentType | ProductionType   | TotalCostAmount | Rule name       | CostType  |
| DPVRJRVendor4 | TalentCompany    | DPVRJRSAP4      |  true               | true           | GBP              | CostTotal       | 0.5                | 1           | true                    | Japan        | Audio       | Full Production   |0;GreaterThan   | DPVRJRDPRule4   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art         | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRJRCT4   | DPVRJRCD14  | Adam Furman (Leo Burnett)   | 20000                | Audio        | Full Production | DPVRJRATN4             | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'DPVRJRCT4' with following fields:
| Talent Company  | Recording Date | Recording Days | Recording Country | Recording City | Talent Company Activate Direct Billing |
| DPVRJRVendor4   | 01/07/2019     | 2              | India             | New Delhi      | Yes                                    |
And added expected asset details for cost title 'DPVRJRCT4':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | DPVRJRAT4   | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'DPVRJRCT4':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 25000                 | 35000         | 20000       | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRJRCT4':
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'DPVRJRCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'DPVRJRCT4'
And on cost review page of cost item with title 'DPVRJRCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 40000.00                         | 40000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'DPVRJRCT4'
And I click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRJRCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 80000        | 40000          | GBP      | 1234567890 | DefaultBrand  | DPVRJRCD14  |
When cost with title 'DPVRJRCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'DPVRJRCT4'
And I click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'DPVRJRCT4':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 35000                 | 35000         | 30000       | 1234567890                        |
And I upload following supporting documents to cost title 'DPVRJRCT4':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And add below approvers for cost title 'DPVRJRCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'DPVRJRCT4'
And on cost review page of cost item with title 'DPVRJRCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total  |
| Original Estimate | 40000.00                             | 40000.00                    | 80000.00  |
| Final Actual      | 40000.00                             | 60000.00                    | 100000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'DPVRJRCT4'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRJRCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 100000       | 60000          | GBP      | 1234567890 | DefaultBrand  | DPVRJRCD14  |
When cost with title 'DPVRJRCT4' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'DPVRJRCT4' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 100000       | 60000          | GBP      | 1234567890 | DefaultBrand  | DPVRJRCD14  |

Scenario: Check Direct Payment Vendor Rules within JAPAN for Still Image Content Type and Full Production
Meta:@adcost
     @directPaymentRules
!--QA-706, rule no-130
Given I am on cost overview page
And 'created' vendor with following VendorDetails:
|  Name            | Category                | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion  | ContentType | ProductionType  | TotalCostAmount | Rule name       | CostType  |
| DPVRJRVendor5    | PhotographyCompany      | DPVRJRSAP5      |  true               | true           | INR              | CostTotal       | 0                 | 1            | true                   | Japan         | Still Image | Full Production | 0;GreaterThan   | DPVRJRDPRule5   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number    | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject| DPVRJRCT5  | DPVRJRD5    | Aaron Royer (Grey) | 20000                | Still Image  | Full Production | DPVRJRATN5             | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'DPVRJRCT5' with following fields:
| Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Photographer Company Activate Direct Billing |
| DPVRJRVendor5        | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | Yes                                          |
And added expected asset details for cost title 'DPVRJRCT5':
| Initiative | Asset Title |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | DPVRJRAT5  |  Version  | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'DPVRJRCT5':
| Preproduction | Retouching | FX (Loss) & Gain   | Please enter a 10-digit IO number |
| 4000000       | 800000     | 4000000            | 1234567890                        |
And uploaded following supporting documents to cost title 'DPVRJRCT5':
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
And added below approvers for cost title 'DPVRJRCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'DPVRJRCT5'
And on cost review page of cost item with title 'DPVRJRCT5'
Then 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 8800000.00                  | 8800000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'DPVRJRCT5'
And cost with title 'DPVRJRCT5' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'DPVRJRCT5'
And I upload following supporting documents to cost title 'DPVRJRCT5':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'DPVRJRCT5'
And I am on cost review page of cost item with title 'DPVRJRCT5'
Then 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | Final Actual payment amount | PO Total   |
| Original Estimate  | 0.00                             | 8800000.00                  | 8800000.00 |
| Final Actual       | 0.00                             | 8800000.00                  | 8800000.00 |


Scenario: Check Vendor payment split rules should not apply when vendor for different region but same content and production type is selected on production detail page
Meta:@adcost
     @directPaymentRules
Given I am on cost overview page
And 'created' vendor with following VendorDetails:
|  Name           | Category          | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | ContentType | ProductionType      | TotalCostAmount | Rule name       | CostType  |
| DPVRJRVendor6   | AudioMusicCompany | DPVRJRSAP6      |  true               | true           | USD              | CostTotal       |1                  | 1           | true                    | IMEA         | Audio       | Post Production Only| 0;GreaterThan   | DPVRJRDPRule6   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title     | Description    | Agency Producer/Art              | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region  | Campaign         | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRJRCT6      | DPVRJRCD6      |  Aldrin Anthony Galang (Grey)    | 50000                | Audio        | Post Production Only | DPVRJRATN6             | Japan          | DefaultCampaign  | BFO          | USD - US Dollar         |
And filled Production Details with following fields for cost title 'DPVRJRCT6':
| Audio/Music Company   |
| DPVRJRVendor6;true    |
And added expected asset details for cost title 'DPVRJRCT6':
| Initiative | Country | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | AAK     | DPVRJRAT6    | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'DPVRJRCT6':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 20000                 | 20000         | 20000       | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRJRCT6':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'DPVRJRCT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'DPVRJRCT6'
And I am on cost review page of cost item with title 'DPVRJRCT6'
Then I 'should not' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 60000.00                         | 0.00                        | 60000.00 |