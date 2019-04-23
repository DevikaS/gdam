Feature: Direct Vendor Payment Rules
Narrative:
In order to
As a GovernanceManager
I want to verify direct payment vendor rules functionality for Latin America region


Scenario: Check Vendor payment split rules for cost greater than zero within Latin America region for Audio and Post Production Only
Meta:@adcost
     @directPaymentRules
     @adcostSmokeUAT
!--QA-702, rule no-152
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
|  Name           | Category             | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion   | ContentType | ProductionType      | TotalCostAmount | Rule name        | CostType  |
| DPVRLARVendor1  | AudioMusicCompany    | DPVRLARSAP1     |  true               | true           | USD              | CostTotal       |0.5                 | 1          | true                    | Latin America  | Audio       | Post Production Only| 0;GreaterThan   | DPVRLARDPRule    | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title     | Description    | Agency Producer/Art              | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign                        | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRLARCT1     | DPVRLARCD1     |  Aldrin Anthony Galang (Grey)    | 40000                | Audio        | Post Production Only | DPVRLARATN1             | Latin America| 376 Flexball eComm (Shave Care) | BFO          | USD - US Dollar         |
And filled Production Details with following fields for cost title 'DPVRLARCT1':
| Audio/Music Company |
| DPVRLARVendor1;true |
And added expected asset details for cost title 'DPVRLARCT1':
| Initiative | Country      | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | AAK          | DPVRLARAT1   | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'DPVRLARCT1':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 10000                 | 10000         | 10000       | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRLARCT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'DPVRLARCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'DPVRLARCT1'
And I am on cost review page of cost item with title 'DPVRLARCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 15000.00                         | 15000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'DPVRLARCT1'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRLARCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 30000        | 15000          | USD      | 1234567890 | DefaultBrand   | DPVRLARCD1   | brandDescription |
When cost with title 'DPVRLARCT1' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'DPVRLARCT1'
And I upload following supporting documents to cost title 'DPVRLARCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And I 'Submit' the cost with title 'DPVRLARCT1'
And I am on cost review page of cost item with title 'DPVRLARCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 15000.00                         | 15000.00                    | 30000.00 |


Scenario: Check payment split for cost greater than zero within Latin America region for Digital type
Meta:@adcost
     @paymentRules
!--QA-702, rule no-159
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
|  Name          | Category                      | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion  | ContentType         | TotalCostAmount | Rule name        | CostType  |
|  DPVRLARVendor2 | DigitalDevelopmentCompany    | DPVRLARSAP2     |  true               | true           | USD              | CostTotal       | 1                 | 1           | true                    | Latin America | Digital Development | 0;GreaterThan   | DPVRLARDPRule2   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title   | Description  | Agency Producer/Art  | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRLARCT2   | DPVRLARCD2   | Aaron Royer (Grey)   | 50000                | Digital Development | DPVRLARATN2            | Latin America | Campaign 1 | BFO          | USD - US Dollar         |
And added production details for cost title 'DPVRLARCT2' with following fields:
| Digital Development Company | Digital Development Company Activate Direct Billing |
| DPVRLARVendor2              | Yes                                                 |
And added expected asset details for cost title 'DPVRLARCT2':
| Initiative | Asset Title  | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | DPVRLARAT2   | Digital               | 12/12/2017               | Yes      | Yes       | IMEA   |
And filled Cost Line Items with following fields for cost title 'DPVRLARCT2':
| Adaptation   | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 30000        | 20000           | 10000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRLARCT2':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'DPVRLARCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'DPVRLARCT2'
And I am on cost review page of cost item with title 'DPVRLARCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 60000.00                         | 0.00                        | 60000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'DPVRLARCT2'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRLARCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 60000        | 60000          | USD      | 1234567890 | DefaultBrand   | DPVRLARCD2   | brandDescription |
When cost with title 'DPVRLARCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'DPVRLARCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And I upload following supporting documents to cost title 'DPVRLARCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'DPVRLARCT2'
And I am on cost review page of cost item with title 'DPVRLARCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 60000.00                         | 0.00                        | 60000.00 |


Scenario: Check direct vendor payment split for cost greater than zero within Latin America region for Still image and post production only
Meta:@adcost
     @paymentRules
!--QA-702, rule no-166
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
|  Name          | Category           | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion   | ContentType | ProductionType      | TotalCostAmount | Rule name        | CostType  |
| DPVRLARVendor3 | PhotographyCompany | DPVRLARSAP3     |  true               | true           | USD              | CostTotal       | 1                 | 1           | true                    | Latin America  | Still Image | Post Production Only| 0;GreaterThan   | DPVRLARDPRule3   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRLARCT3 | DPVRLARCD3  | Aaron Royer (Grey)  | 10000                | Still Image  | Post Production Only | DPVRLARATN3            | Latin America | Campaign 1 | BFO          | USD - US Dollar         |
And filled Production Details with following fields for cost title 'DPVRLARCT3':
| Photographer Company  |
| DPVRLARVendor3;true   |
And added expected asset details for cost title 'DPVRLARCT3':
| Initiative | Asset Title |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country         |
| Giggles    | DPVRLARAT3  |  Version | Digital          | 12/12/2017               | Yes      | Yes       | Latin America   |
And filled Cost Line Items with following fields for cost title 'DPVRLARCT3':
| Agency Artwork / Packs | Retouching      | FX (Loss) & Gain   | Please enter a 10-digit IO number |
| 10000                  | 20000           | 10000              | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRLARCT3':
| FileName            | FormName                            |
| /files/EditWord.doc | Supplier winning bid (budget form)  |
| /files/EditWord.doc | P&G Communication Brief             |
And added below approvers for cost title 'DPVRLARCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'DPVRLARCT3'
And on cost review page of cost item with title 'DPVRLARCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 40000.00                         | 0.00                        | 40000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'DPVRLARCT3'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRLARCT3' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 40000        | 40000          | USD      | 1234567890 | DefaultBrand | DPVRLARCD3  | brandDescription |
When cost with title 'DPVRLARCT3' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And on cost review page of cost item with title 'DPVRLARCT3'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'DPVRLARCT3':
| Agency Artwork / Packs | Retouching      | FX (Loss) & Gain   |
| 10000                  | 20000           | 10000              |
And I upload following supporting documents to cost title 'DPVRLARCT3':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'DPVRLARCT3'
And on cost review page of cost item with title 'DPVRLARCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 40000.00                         | 0.00                        | 40000.00 |
| Final Actual      | 40000.00                         | 0.00                        | 40000.00 |


Scenario: Check payment split for cost more than zero within Latin America region for Audio content type and Full production
Meta:@adcost
     @paymentRules
!--QA-702, rule no-48
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
|  Name          | Category         | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion  | ContentType | ProductionType   | TotalCostAmount | Rule name        | CostType  |
| DPVRLARVendor4 | TalentCompany    | DPVRLARSAP4     |  true               | true           | GBP              | CostTotal       | 0.5               | 1           | true                    | Latin America | Audio       | Full Production   |0;GreaterThan   | DPVRLARDPRule4   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title   | Description  | Agency Producer/Art         | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign                          | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRLARCT4   | DPVRLARCD14  | Adam Furman (Leo Burnett)   | 20000                | Audio        | Full Production | DPVRLARATN4             | Latin America| 007 Initiative (Head & Shoulders) | BFO          | USD - US Dollar         |
And added production details for cost title 'DPVRLARCT4' with following fields:
| Talent Company  | Recording Date | Recording Days | Recording Country | Recording City | Talent Company Activate Direct Billing |
| DPVRLARVendor4  | 01/07/2019     | 2              | India             | New Delhi      | Yes                                    |
And added expected asset details for cost title 'DPVRLARCT4':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | DPVRLARAT4  | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'DPVRLARCT4':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 25000                 | 35000         | 20000       | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRLARCT4':
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'DPVRLARCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'DPVRLARCT4'
And on cost review page of cost item with title 'DPVRLARCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 40000.00                         | 40000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'DPVRLARCT4'
And I click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRLARCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 80000        | 40000          | GBP      | 1234567890 | DefaultBrand  | DPVRLARCD14 |
When cost with title 'DPVRLARCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'DPVRLARCT4'
And I click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'DPVRLARCT4':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 35000                 | 35000         | 30000       | 1234567890                        |
And I upload following supporting documents to cost title 'DPVRLARCT4':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And add below approvers for cost title 'DPVRLARCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'DPVRLARCT4'
And on cost review page of cost item with title 'DPVRLARCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total  |
| Original Estimate | 40000.00                             | 40000.00                    | 80000.00  |
| Final Actual      | 40000.00                             | 60000.00                    | 100000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'DPVRLARCT4'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRLARCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 100000       | 60000          | GBP      | 1234567890 | DefaultBrand  | DPVRLARCD4  |
When cost with title 'DPVRLARCT4' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'DPVRLARCT4' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 100000       | 60000          | GBP      | 1234567890 | DefaultBrand  | DPVRLARCD4  |


Scenario: Check Direct Payment Vendor Rules within Latin America for Still Image Content Type and Full Production
Meta:@adcost
     @adcostCriticalTests
     @adcostSmokeUAT
     @adcostCycloneCosts
!--QA-702
Given I am on cost overview page
And 'created' vendor with following VendorDetails:
|  Name            | Category               | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion  | ContentType | ProductionType   | TotalCostAmount | Rule name        | CostType  |
| DPVRLARVendor5   | PhotographyCompany     | DPVRLARSAP5     |  true               | true           | INR              | CostTotal       | 0                 | 1           | true                    | Latin America | Still Image | Full Production  | 0;GreaterThan   | DPVRLARDPRule5   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number    | Cost Title    | Description    | Agency Producer/Art| Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject| DPVRLARCT5    | DPVRLARD5     | Aaron Royer (Grey) | 20000                | Still Image  | Full Production | DPVRLARATN5             | Latin America| Campaign 1 | BFO          | USD - US Dollar         |
And added production details for cost title 'DPVRLARCT5' with following fields:
| Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Photographer Company Activate Direct Billing |
| DPVRLARVendor5       | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | Yes                                          |
And added expected asset details for cost title 'DPVRLARCT5':
| Initiative | Asset Title |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | DPVRLARAT5  |  Version | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'DPVRLARCT5':
| Preproduction | Retouching | FX (Loss) & Gain   | Please enter a 10-digit IO number |
| 4000000       | 800000     | 4000000            | 1234567890                        |
And uploaded following supporting documents to cost title 'DPVRLARCT5':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'DPVRLARCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'DPVRLARCT5'
And on cost review page of cost item with title 'DPVRLARCT5'
Then 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total   |
| Original Estimate | 0.00                             | 8800000.00                  | 8800000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'DPVRLARCT5'
And cost with title 'DPVRLARCT5' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'DPVRLARCT5'
And I upload following supporting documents to cost title 'DPVRLARCT5':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'DPVRLARCT5'
And I am on cost review page of cost item with title 'DPVRLARCT5'
Then 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | Final Actual payment amount | PO Total   |
| Original Estimate  | 0.00                             | 8800000.00                  | 8800000.00 |
| Final Actual       | 0.00                             | 8800000.00                  | 8800000.00 |


Scenario: Check Usage vendor fields not visible for production cost on cost item page
Meta:@adcost
     @directPaymentRules
Given I logged in with details of 'CostOwner'
And I am on cost overview page
And created a new 'production' cost with following CostDetails:
| Project Number    | Cost Title | Description   | Agency Producer/Art| Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject| DPVRLARCT6 | DPVRLARD6     | Aaron Royer (Grey) | 20000                | Still Image  | Full Production | DPVRLARATN6             | Latin America| Campaign 1 | BFO          | USD - US Dollar         |
When I am on cost items page of cost title 'DPVRLARCT6'
Then I 'should not' see Usage Vendor Section on cost item page