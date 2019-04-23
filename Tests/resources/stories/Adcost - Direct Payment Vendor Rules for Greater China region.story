Feature: Direct Vendor Payment Rules
Narrative:
In order to
As a GovernanceManager
I want to verify direct payment vendor rules functionality for Greater China region


Scenario: Check Vendor payment split rules for cost greater than zero within Greater China region for Audio and Post Production Only
Meta:@adcost
     @directPaymentRules
!--QA-704, rule no-51
Given I am on cost overview page
And I filled following data on vendor creation page to create new vendor:
|  Name           | Category             | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion  | ContentType | ProductionType      | TotalCostAmount | Rule name     | CostType  |
| DPVRGCRVendor1  | Audio/Music Company  | DPVRGCRSAP1     |  true               | true           | US Dollar        | CostTotal       |100                | 100         | true                    | Greater China | Audio       | Post Production Only| 0               | DPVRGCRDPRule | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title     | Description    | Agency Producer/Art              | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRGCRCT1     | DPVRGCRCD1     |  Aldrin Anthony Galang (Grey)    | 40000                | Audio        | Post Production Only | DPVRGCRATN1             | Greater China| DefaultCampaign | BFO          | USD - US Dollar         |
And filled Production Details with following fields for cost title 'DPVRGCRCT1':
| Audio/Music Company |
| DPVRGCRVendor1;true    |
And added expected asset details for cost title 'DPVRGCRCT1':
| Initiative | Country      | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | AAK          | DPVRGCRAT4   | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'DPVRGCRCT1':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 10000                 | 10000         | 10000       | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRGCRCT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'DPVRGCRCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'DPVRGCRCT1'
And I am on cost review page of cost item with title 'DPVRGCRCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 0.00                        | 30000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'DPVRGCRCT1'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRGCRCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 30000        | 30000          | USD      | 1234567890 | DefaultBrand   | DPVRGCRCD1      | brandDescription |
When cost with title 'DPVRGCRCT1' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'DPVRGCRCT1'
And I am on supporting documents of cost title 'DPVRGCRCT1'
And I upload following supporting documents to cost title 'DPVRGCRCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And I 'Submit' the cost with title 'DPVRGCRCT1'
And I am on cost review page of cost item with title 'DPVRGCRCT1'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 30000.00                         | 0.00                        | 30000.00 |


Scenario: Check payment split for cost greater than zero within Greater China region for Digital type
Meta:@adcost
     @directPaymentRules
!--QA-704, rule no-53
Given I am on cost overview page
Given I 'created' vendor with following VendorDetails:
|  Name           | Category                      | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion  | ContentType         | TotalCostAmount | Rule name        | CostType  |
|  DPVRGCRVendor2 | DigitalDevelopmentCompany     | DPVRGCRSAP2     |  true               | true           | USD              | CostTotal       | 0.5               | 1           | true                    | Greater China | Digital Development | 0;GreaterThan   | DPVRGCRDPRule2   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title   | Description  | Agency Producer/Art  | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRGCRCT2   | DPVRGCRCD2   | Aaron Royer (Grey)   | 50000                | Digital Development | DPVRGCRATN2            | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'DPVRGCRCT2' with following fields:
| Digital Development Company | Digital Development Company Activate Direct Billing |
| DPVRGCRVendor2                 | Yes                                                 |
And added expected asset details for cost title 'DPVRGCRCT2':
| Initiative | Asset Title  | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | DPVRGCRAT7   | Digital          | 12/12/2017               | Yes      | Yes       | IMEA   |
And filled Cost Line Items with following fields for cost title 'DPVRGCRCT2':
| Adaptation   | Virtual Reality | P&G insurance | Please enter a 10-digit IO number |
| 30000        | 20000           | 10000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRGCRCT2':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'DPVRGCRCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'DPVRGCRCT2'
And I am on cost review page of cost item with title 'DPVRGCRCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 30000.00                         | 30000.00                    | 60000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'DPVRGCRCT2'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRGCRCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand          | Description  | Basket Name      |
| 60000        | 30000          | USD      | 1234567890 | DefaultBrand   | DPVRGCRCD2   | brandDescription |
When cost with title 'DPVRGCRCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'DPVRGCRCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And I upload following supporting documents to cost title 'DPVRGCRCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And add below approvers for cost title 'DPVRGCRCT2':
| Technical Approver |
| IPMuser            |
And 'Submit' the cost with title 'DPVRGCRCT2'
And I am on cost review page of cost item with title 'DPVRGCRCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage        | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Final Actual | 30000.00                         | 30000.00                    | 60000.00 |


Scenario: Check payment split for cost greater than zero within Greater China region for DPV
Meta:@adcost
     @directPaymentRules
!--QA-704, rule no-58
Given I am on cost overview page
And I filled following data on vendor creation page to create new vendor:
|  Name          | Category               | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion  | ContentType | ProductionType      | TotalCostAmount | Rule name        | CostType  |
| DPVRGCRVendor3 | Photographer Company   | DPVRGCRSAP3     |  true               | true           | US Dollar        | CostTotal       |50                 | 100         | true                    | Greater China | Still Image | Post Production Only| 0               | DPVRGCRDPRule3   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRGCRCT3 | DPVRGCRCD3  | Aaron Royer (Grey)  | 10000                | Still Image  | Post Production Only | DPVRGCRATN3            | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And filled Production Details with following fields for cost title 'DPVRGCRCT3':
| Photographer Company  |
| DPVRGCRVendor3;true   |
And added expected asset details for cost title 'DPVRGCRCT3':
| Initiative | Asset Title |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country         |
| Giggles    | DPVRGCRAT3  |  Version | Digital          | 12/12/2017               | Yes      | Yes       | Greater China   |
And filled Cost Line Items with following fields for cost title 'DPVRGCRCT3':
| Agency Artwork / Packs | Retouching      | FX (Loss) & Gain   | Please enter a 10-digit IO number |
| 10000                  | 20000           | 10000              | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRGCRCT3':
| FileName            | FormName                            |
| /files/EditWord.doc | Supplier winning bid (budget form)  |
| /files/EditWord.doc | P&G Communication Brief             |
And added below approvers for cost title 'DPVRGCRCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'DPVRGCRCT3'
And on cost review page of cost item with title 'DPVRGCRCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 20000.00                         | 20000.00                    | 40000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'DPVRGCRCT3'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRGCRCT3' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      |
| 40000        | 20000          | USD      | 1234567890 | DefaultBrand | DPVRGCRCD3  | brandDescription |
When cost with title 'DPVRGCRCT3' is 'Approve' on behalf of MyPurchases application
When I login with details of 'CostOwner'
And on cost review page of cost item with title 'DPVRGCRCT3'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'DPVRGCRCT3':
| Agency Artwork / Packs | Retouching      | FX (Loss) & Gain   |
| 15000                  | 20000           | 15000              |
And I upload following supporting documents to cost title 'DPVRGCRCT3':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And I 'Submit' the cost with title 'DPVRGCRCT3'
And on cost review page of cost item with title 'DPVRGCRCT3'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 20000.00                         | 20000.00                    | 40000.00 |
| Final Actual      | 20000.00                         | 30000.00                    | 50000.00 |


Scenario: Check payment split for cost more than zero within Greater China region for Audio content type and Full production
Meta:@adcost
     @directPaymentRules
!--QA-704, rule no-46
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
|  Name          | Category      | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion  | ContentType | ProductionType   | TotalCostAmount | Rule name        | CostType  |
| DPVRGCRVendor4 | TalentCompany | DPVRGCRSAP4     |  true               | true           | GBP              | CostTotal       | 0                 | 1           | true                    | Greater China | Audio       | Full Production  |0;GreaterThan    | DPVRGCRDPRule4   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title   | Description  | Agency Producer/Art         | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRGCRCT4   | DPVRGCRCD14  | Adam Furman (Leo Burnett)   | 20000                | Audio        | Full Production | DPVRGCRATN4             | Greater China| DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'DPVRGCRCT4' with following fields:
| Talent Company  | Recording Date | Recording Days | Recording Country | Recording City | Talent Company Activate Direct Billing |
| DPVRGCRVendor4  | 01/07/2019     | 2              | India             | New Delhi      | Yes                                    |
And added expected asset details for cost title 'DPVRGCRCT4':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | DPVRGCRAT1  | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'DPVRGCRCT4':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 25000                 | 35000         | 20000       | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRGCRCT4':
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'DPVRGCRCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
And I 'Submit' the cost with title 'DPVRGCRCT4'
And on cost review page of cost item with title 'DPVRGCRCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 80000.00                    | 80000.00 |
When I login with details of 'IPMuser'
And I am on cost review page of cost item with title 'DPVRGCRCT4'
And I click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRGCRCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 80000        | 0              | GBP      | 1234567890 | DefaultBrand  | DPVRGCRCD14 |
When cost with title 'DPVRGCRCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'DPVRGCRCT4'
And I click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'DPVRGCRCT4':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 35000                 | 35000         | 30000       | 1234567890                        |
And I upload following supporting documents to cost title 'DPVRGCRCT4':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And add below approvers for cost title 'DPVRGCRCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And 'Submit' the cost with title 'DPVRGCRCT4'
And on cost review page of cost item with title 'DPVRGCRCT4'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total  |
| Original Estimate | 0.00                             | 80000.00                    | 80000.00  |
| Final Actual      | 0.00                             | 100000.00                   | 100000.00 |
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'DPVRGCRCT4'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'DPVRGCRCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 100000       | 100000         | GBP      | 1234567890 | DefaultBrand  | DPVRGCRCD14 |
When cost with title 'DPVRGCRCT4' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'DPVRGCRCT4' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description |
| 100000       | 100000         | GBP      | 1234567890 | DefaultBrand  | DPVRGCRCD14 |

Scenario: Check Direct Payment Vendor Rules within Greater China for Still Image Content Type and Full Production
Meta:@adcost
     @directPaymentRules
!--QA-704, rule no-55
Given I am on cost overview page
And 'created' vendor with following VendorDetails:
|  Name            | Category               | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion  | ContentType | ProductionType  | TotalCostAmount | Rule name        | CostType  |
| DPVRGCRVendor5   | PhotographyCompany     | DPVRGCRSAP5     |  true               | true           | INR              | CostTotal       | 1                 | 1            | true                    | Greater China | Still Image | Full Production | 0;GreaterThan   | DPVRGCRDPRule5   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number    | Cost Title    | Description    | Agency Producer/Art| Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject| DPVRGCRCT5    | DPVRGCRD5      | Aaron Royer (Grey) | 20000                | Still Image  | Full Production | DPVRGCRATN5             | Greater China| DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'DPVRGCRCT5' with following fields:
| Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Photographer Company Activate Direct Billing |
| DPVRGCRVendor5       | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | Yes                                          |
And added expected asset details for cost title 'DPVRGCRCT5':
| Initiative | Asset Title |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | DPVRGCRAT6  |  Version | Digital          | 12/12/2017               | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'DPVRGCRCT5':
| Preproduction | Retouching | FX (Loss) & Gain   | Please enter a 10-digit IO number |
| 4000000       | 800000     | 4000000            | 1234567890                        |
And uploaded following supporting documents to cost title 'DPVRGCRCT5':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'DPVRGCRCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'DPVRGCRCT5'
And on cost review page of cost item with title 'DPVRGCRCT5'
Then 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 8800000.00                       | 0.00                        | 8800000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'DPVRGCRCT5'
And cost with title 'DPVRGCRCT5' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'DPVRGCRCT5'
And I upload following supporting documents to cost title 'DPVRGCRCT5':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And 'Submit' the cost with title 'DPVRGCRCT5'
And I am on cost review page of cost item with title 'DPVRGCRCT5'
Then 'should' see following data in payment summary section on Cost Review page:
| Stage              | Original Estimate payment amount | Final Actual payment amount | PO Total   |
| Original Estimate  | 8800000.00                       | 0.00                        | 8800000.00 |
| Final Actual       | 8800000.00                       | 0.00                        | 8800000.00 |


Scenario: Check Vendor is shown under right category on production detail page
Meta:@adcost
     @directPaymentRules
Given I am on cost overview page
And I filled following data on vendor creation page to create new vendor:
|  Name           | Category             | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | ContentType | ProductionType      | TotalCostAmount | Rule name         | CostType  |
| DPVRGCRVendor6  | Talent Company       | DPVRGCRSAP6     |  true               | true           | US Dollar        | CostTotal       |100                | 100         | true                    | Greater China| Audio       | Post Production Only| 0               | DPVRGCRDPRule6    | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
When I create a new 'production' cost with following CostDetails:
| Project Number     | Cost Title     | Description    | Agency Producer/Art              | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | DPVRGCRCT6     | DPVRGCRCD6     |  Aldrin Anthony Galang (Grey)    | 40000                | Audio        | Post Production Only | DPVRGCRATN6             | Greater China| DefaultCampaign | BFO          | USD - US Dollar         |
Then I 'should not' see following 'DPVRGCRVendor6' vendor under 'Audio/Music Company' category for cost title 'DPVRGCRCT6'