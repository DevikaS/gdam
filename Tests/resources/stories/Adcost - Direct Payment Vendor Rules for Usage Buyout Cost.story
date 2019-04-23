Feature: Direct Vendor Payment Rules
Narrative:
In order to
As a GovernanceManager
I want to verify direct payment vendor rules functionality for usage buyout cost

Scenario: Check Vendor Activate Direct Billing radio button visble when vendor is selected from dropdown
Meta:@adcost
     @directPaymentRules
!--QA-1074
Given I am on cost overview page
And I filled following data on vendor creation page to create new vendor:
|  Name           | Category               | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | TotalCostAmount | Rule name     | CostType             |
| DPVRUBCVendor1  | Usage/buyout/contract  | DPVRUBCSAP1     |  true               | true           | US Dollar        | Total Costs     | 100               | 100         | true                    | Europe       | 0               | DPVRUBCDPRule | Usage/Buyout/Contract|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Contract (celebrity & athletes) | DPVRUBCCT1 | DPVRUBCCD1  | Aaron Royer (Grey)  | DPVRUBCATN1            | Europe        | DefaultCampaign |  BFO         | USD - US Dollar         |
And I am on cost items page of cost title 'DPVRUBCCT1'
When I fill direct vendor details on Cost Item Page for 'UsageBuyoutContract' cost:
| Vendor to which payment will go     |
| DPVRUBCVendor1                      |
Then I 'should' see following radio button when selects a vendor from Dropdown on cost item page:
| Activate Direct Billing | Do Not Activate Direct Billing |
| true                    | false                          |
And I 'should' see successful message for vendor 'DPVRUBCVendor1' setup on cost item page


Scenario: Check Vendor payment split rules of hundred and hundred percent for cost greater than zero within IMEA region for usage buyout cost
Meta:@adcost
     @directPaymentRules
     @adcostCriticalTests
!--QA-1074
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
|  Name           | Category            | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | TotalCostAmount | Rule name      | CostType             |
|  DPVRUBCVendor2 | UsageBuyoutContract | DPVRUBCSAP2     |  true               | true           | USD              | CostTotal       | 1                 | 1           | true                    | IMEA         | 0;GreaterThan   | DPVRUBCDPRule2 | Usage/Buyout/Contract|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Contract (celebrity & athletes) | DPVRUBCCT2 | DPVRUBCCD2  | Aaron Royer (Grey)  | DPVRUBCATN1            | IMEA          | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'DPVRUBCCT2' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints  | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air  | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 90000          |
And added negotiated terms page for cost title 'DPVRUBCCT2' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'DPVRUBCCT2'
And filled direct vendor details on Cost Item Page for 'UsageBuyoutContract' cost:
| Vendor to which payment will go     |
| DPVRUBCVendor2;GBP - British Pound  |
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRUBCCT2':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'DPVRUBCCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'DPVRUBCCT2'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'DPVRUBCCT2'
And on cost review page of cost item with title 'DPVRUBCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 20000.00                         | 0.00                        | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'DPVRUBCCT2'
Then should see AMQ receives below request for cost title 'DPVRUBCCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      | Vendor      |
| 20000        | 20000          | GBP      | 1234567890 | DefaultBrand | DPVRUBCCD2  | brandDescription | DPVRUBCSAP2 |
When cost with title 'DPVRUBCCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'DPVRUBCCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'DPVRUBCCT2':
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'DPVRUBCCT2':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
| /files/EditWord.doc | Scope change approval form             |
And 'Submit' the cost with title 'DPVRUBCCT2'
And on cost review page of cost item with title 'DPVRUBCCT2'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 20000.00                         | 0.00                        | 20000.00 |
| Final Actual      | 20000.00                         | 10000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'DPVRUBCCT2'
And cost with title 'DPVRUBCCT2' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'DPVRUBCCT2' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name      | Vendor      |
| 30000        | 10000          | GBP      | 1234567890 | DefaultBrand  |DPVRUBCCD2   | brandDescription | DPVRUBCSAP2 |


Scenario: Check Vendor will only be visible in the drop down when the Vendor category and the Budget region matches the usage buyout Cost type
Meta:@adcost
     @directPaymentRules
!--QA-1074
Given I am on cost overview page
And I filled following data on vendor creation page to create new vendor:
|  Name           | Category               | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | TotalCostAmount | Rule name     | CostType             |
| DPVRUBCVendor3  | Usage/buyout/contract  | DPVRUBCSAP3     |  true               | true           | US Dollar        | Total Costs     | 100               | 100         | true                    | Europe       | 0               | DPVRUBCDPRule3 | Usage/Buyout/Contract|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Contract (celebrity & athletes) | DPVRUBCCT3 | DPVRUBCCD3  | Aaron Royer (Grey)  | DPVRUBCATN3            | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
When I am on cost items page of cost title 'DPVRUBCCT3'
Then I 'should not' see following vendor dropdown on cost item page:
| Vendor to which payment will go |
| DPVRUBCVendor3                  |
And I 'should not' be able to add vendor 'DPVRUBCVendor3A' on the fly


Scenario: Check that Usage Buyout Direct Payment vendor not able to change currency and other direct vendor fields after initial stage is approved
Meta:@adcost
     @directPaymentRules
!--QA-1074, ADC-2623, QA-1141
Given I am on costs overview page
And I 'created' vendor with following VendorDetails:
|  Name           | Category            | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | TotalCostAmount | Rule name      | CostType             |
|  DPVRUBCVendor4 | UsageBuyoutContract | DPVRUBCSAP4     |  true               | true           | EUR              | CostTotal       | 1                 | 1           | true                    | Latin America| 0;GreaterThan   | DPVRUBCDPRule4 | Usage/Buyout/Contract|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type   | Usage/Buyout/Contract  | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Model  | Usage                  | DPVRUBCCT4 | DPVRUBCCD4  | Aaron Royer (Grey)  | DPVRUBCATN4            | Latin America | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'DPVRUBCCT4' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints  | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air  | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 90000          |
And I am on cost items page of cost title 'DPVRUBCCT4'
And filled direct vendor details on Cost Item Page for 'UsageBuyoutContract' cost:
| Vendor to which payment will go |
| DPVRUBCVendor4                  |
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 20000             | 15000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRUBCCT4':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'DPVRUBCCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'DPVRUBCCT4'
And I login with details of 'IPMuser'
And 'Request Changes' the cost with title 'DPVRUBCCT4'
And I login with details of 'CostOwner'
And I click 'Reopen' and 'Yes, reopen this cost' on title 'DPVRUBCCT4' from costs overview page
And I edit vendor currency with following fields for cost title 'DPVRUBCCT4' on cost item page:
| Usage Buyout Contract Payment Currency  |
| GBP - British Pound                     |
Then I 'should' see sections currency as 'GBP - British Pound' on cost item page
When I click 'Continue' button on Adcost system page
And I 'Submit' the cost with title 'DPVRUBCCT4'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'DPVRUBCCT4'
And cost with title 'DPVRUBCCT4' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'DPVRUBCCT4'
Then I 'should not' able to edit the currency field for catagory 'UsageBuyoutContract' on cost item page for costTitle 'DPVRUBCCT4'
And I 'should not' able to edit the currency field on cost item page for different sections for costTitle 'DPVRUBCCT4'
And I 'should' see following currency symbols for grand total on cost Item page:
| CurrencyGroup   | Currency Symbol  |
| Local           | £                |
| Default         | $                |
Then I 'should not' able to edit the vendor field 'Vendor to which payment will go' on cost item page for costTitle 'DPVRUBCCT4'


Scenario: Check that usage cost can be created and submitted without selecting any direct vendor payment
Meta:@adcost
     @directPaymentRules
!--QA-1074
Given I am on costs overview page
And I 'created' vendor with following VendorDetails:
|  Name           | Category            | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | TotalCostAmount | Rule name      | CostType             |
|  DPVRUBCVendor5 | UsageBuyoutContract | DPVRUBCSAP5     |  true               | true           | EUR              | CostTotal       | 1                 | 1           | true                    | Japan        | 0;GreaterThan   | DPVRUBCDPRule5 | Usage/Buyout/Contract|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type   | Usage/Buyout/Contract  | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Model  | Usage                  | DPVRUBCCT5 | DPVRUBCCD5  | Aaron Royer (Grey)  | DPVRUBCATN5            | Japan         | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'DPVRUBCCT5' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints  | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air  | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 90000          |
And filled Cost Line Items with following fields for cost title 'DPVRUBCCT5':
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 20000             | 15000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRUBCCT5':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'DPVRUBCCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'DPVRUBCCT5'
Then I 'should' see following data for 'DPVRUBCCT5' cost item on Adcost overview page:
| Cost Stage        | Cost Status         | Approver  |
| Original Estimate | Pending Approval by | IPMuser   |


Scenario: Check Vendor payment split rules of zero and hundred percent for cost greater than zero within Japan region for usage buyout cost
Meta:@adcost
     @directPaymentRules
     @adcostSmokeUAT
     @adcostSmoke
!--QA-1074
Given I am on cost overview page
And I 'created' vendor with following VendorDetails:
|  Name           | Category            | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | TotalCostAmount | Rule name      | CostType             |
|  DPVRUBCVendor6 | UsageBuyoutContract | DPVRUBCSAP6     |  true               | true           | USD              | CostTotal       | 0                 | 1           | true                    | Japan        | 0;GreaterThan   | DPVRUBCDPRule6 | Usage/Buyout/Contract|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type       | Usage/Buyout/Contract           | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Ilustrator | Contract (celebrity & athletes) | DPVRUBCCT6 | DPVRUBCCD6  | Aaron Royer (Grey)  | DPVRUBCATN1            | Japan         | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'DPVRUBCCT6' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints  | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air  | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 90000          |
And I am on cost items page of cost title 'DPVRUBCCT6'
And filled direct vendor details on Cost Item Page for 'UsageBuyoutContract' cost:
| Vendor to which payment will go  |
| DPVRUBCVendor6                   |
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee | Please enter a 10-digit IO number |
| 10000             | 10000                      | 1234567890                        |
And I uploaded following supporting documents to cost title 'DPVRUBCCT6':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'DPVRUBCCT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'DPVRUBCCT6'
And wait until cost status is 'PendingTechnicalApproval' and cost stage is 'Original Estimate' for cost title 'DPVRUBCCT6'
And on cost review page of cost item with title 'DPVRUBCCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'DPVRUBCCT6'
Then should see AMQ receives below request for cost title 'DPVRUBCCT6' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      | Vendor      |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand | DPVRUBCCD6  | brandDescription | DPVRUBCSAP6 |
When cost with title 'DPVRUBCCT6' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'DPVRUBCCT6'
And click 'Next Stage' button and 'Confirm' on cost review page
And fill Cost Line Items with following fields for cost title 'DPVRUBCCT6':
| Base Compensation | Usage/Residuals/Buyout Fee |
| 15000             | 15000                      |
And I upload following supporting documents to cost title 'DPVRUBCCT6':
| FileName            | FormName                               |
| /files/EditWord.doc | Signed contract or letter of extension |
| /files/EditWord.doc | Scope change approval form             |
And 'Submit' the cost with title 'DPVRUBCCT6'
And on cost review page of cost item with title 'DPVRUBCCT6'
Then I 'should' see following data in payment summary section on Cost Review page:
| Stage             | Original Estimate payment amount | Final Actual payment amount | PO Total |
| Original Estimate | 0.00                             | 20000.00                    | 20000.00 |
| Final Actual      | 0.00                             | 30000.00                    | 30000.00 |
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'DPVRUBCCT6'
And cost with title 'DPVRUBCCT6' is 'Approve' on behalf of MyPurchases application
Then I should see AMQ receives below request for cost title 'DPVRUBCCT6' and type as 'goods_receipt_submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         |Description  | Basket Name      | Vendor      |
| 30000        | 30000          | USD      | 1234567890 | DefaultBrand  |DPVRUBCCD6   | brandDescription | DPVRUBCSAP6 |