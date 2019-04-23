Feature: Currency in Cost module
Narrative:
In order to
As a CostOwner
I want to check Currency functionality


Scenario: Check that cost owner not able to change currency after initial stage is approved
Meta:@adcost
!--QA-745
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number      | Cost Title    | Description   | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number   | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject  | ACMCCT1       | ACMCD1        | Aaron Royer (Grey)  | 50000                | Audio        | Post Production Only |  ACMCATN1                 | Latin America | DefaultCampaign | BFO          | INR - Indian Rupee      |
And added production details for cost title 'ACMCCT1' with following fields:
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And added expected asset details for cost title 'ACMCCT1':
| Initiative | Country      | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | ACMCAT7      | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
Then I 'should' see sections currency as 'INR - Indian Rupee' on cost item page for cost title 'ACMCCT1'
When fill Payment details section on cost items page with following details:
| VO recording sessions | P&G insurance | Talent fees |Please enter a 10-digit IO number |
| 550000                | 390000        | 420000       | 1234567890                      |
Then I 'should' see following Cost Line Items populated on cost item page:
| VO recording sessions   | P&G insurance          | Talent fees         |
| $ 8232.55               | $ 5837.62              | $ 6286.67           |
When I click 'Continue' button on Adcost system page
And upload following supporting documents to cost title 'ACMCCT1':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And add below approvers for cost title 'ACMCCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'ACMCCT1'
And I login with details of 'IPMuser'
And 'Request Changes' the cost with title 'ACMCCT1'
And I login with details of 'CostOwner'
When I click 'Reopen' and 'Yes, reopen this cost' on title 'ACMCCT1' from costs overview page
And I edit cost for cost title 'ACMCCT1' with following CostDetails:
| Agency Payment Currency |
| GBP - British Pound     |
Then I 'should' see sections currency as 'GBP - British Pound' on cost item page for cost title 'ACMCCT1'
When I 'Submit' the cost with title 'ACMCCT1'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'ACMCCT1'
And cost with title 'ACMCCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
When I 'NextStage' the cost with title 'ACMCCT1'
Then I 'should not' able to edit the currency field on cost detail page for costTitle 'ACMCCT1'
And I 'should not' able to edit the currency field on cost item page for different sections for costTitle 'ACMCCT1'


Scenario: Check that Direct Payment vendor not able to change currency and direct vendor related fields after initial stage is approved
Meta:@adcost
!--QA-745, QA-1141
Given I logged in with details of 'GovernanceManager'
And I 'created' vendor with following VendorDetails:
|  Name         | Category         | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion  | ContentType | ProductionType         | TotalCostAmount | Rule name | CostType  |
| ACMCVendor1   | TalentCompany    | SAP1            |  true               | true           | EUR              | CostTotal       | 0                 | 1           | true                    | IMEA        | Audio         | Post Production Only   |0;GreaterThan    | DPRule1   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number      | Cost Title    | Description   | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number   | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject  | ACMCCT2       | ACMCD1        | Aaron Royer (Grey)  | 50000                | Audio        | Post Production Only |  ACMCATN1                 | Latin America | DefaultCampaign | BFO          | USD - US Dollar         |
When I fill Production Details with following fields for cost title 'ACMCCT2':
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City |
| ACMCVendor1;true    | 01/07/2019     | 2              | India             | New Delhi      |
And add expected asset details for cost title 'ACMCCT2':
| Initiative | Country      | Asset Title  | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | AAK          | DPVRIRAT4      | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
Then I 'should' see sections currency as 'EUR - Euro' on cost item page for cost title 'ACMCCT2'
When I fill Payment details section on cost items page with following details:
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 20000                 | 15000         | 30000       | 1234567890                        |
Then I 'should' see following Cost Line Items populated on cost item page:
| VO recording sessions | P&G insurance | Talent fees |
| $ 21937.04            | $ 16452.78    | $ 32905.56  |
When click 'Continue' button on Adcost system page
And upload following supporting documents to cost title 'ACMCCT2':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And add below approvers for cost title 'ACMCCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'ACMCCT2'
And I login with details of 'IPMuser'
And 'Request Changes' the cost with title 'ACMCCT2'
And I login with details of 'CostOwner'
When I click 'Reopen' and 'Yes, reopen this cost' on title 'ACMCCT2' from costs overview page
And I edit Production Details with following fields for cost title 'ACMCCT2':
| Talent Company      |
| GBP - British Pound |
Then I 'should' see sections currency as 'GBP - British Pound' on cost item page for cost title 'ACMCCT2'
When I 'Submit' the cost with title 'ACMCCT2'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'ACMCCT2'
And cost with title 'ACMCCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'ACMCCT2'
Then I 'should not' able to edit the currency field for catagory 'Talent Company' on production detail page for costTitle 'ACMCCT2'
And I 'should not' able to edit the currency field on cost item page for different sections for costTitle 'ACMCCT2'
And I 'should not' be able to edit the vendor field 'Talent Company' on production detail page for costTitle 'ACMCCT2'
And I 'should not' able to edit the activate vendor radio buttons for category 'Talent Company' on production detail page for costTitle 'ACMCCT2'


Scenario: Check that Direct Payment vendor currency is applied on cost item page when different currency is selected for DPV on Production detail Page
Meta:@adcost
!--QA-745
Given I logged in with details of 'GovernanceManager'
And I 'created' vendor with following VendorDetails:
|  Name        | Category                  | SAP Vendor Code | Preferred Supplier | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | ContentType         | TotalCostAmount | Rule name | CostType  |
|  ACMCVendor2 | DigitalDevelopmentCompany | SAP2            |  true              | true           | USD              | CostTotal       | 0                 | 1           | true                    | IMEA         | Digital Development | 0;GreaterThan   | DPRule2   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ACMCCT3    | ACMCCD3     | Aaron Royer (Grey)  | 50000                | Digital Development | ACMCATN3               | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
When fill Production Details with following fields for cost title 'ACMCCT3':
| Digital Development Company             |
| ACMCVendor2;true;GBP - British Pound    |
Then I 'should' see sections currency as 'GBP - British Pound' on cost item page for cost title 'ACMCCT3'



Scenario: Check that Direct vendor currency is not updated when Cost Sections Currencies are updated by the Owner
Meta: @adcost
!--QA-745
Given I logged in with details of 'GovernanceManager'
And I 'created' vendor with following VendorDetails:
|  Name       | Category           | SAP Vendor Code | Preferred Supplier  | Direct Payment | Default Currency | Cost Total Type | Original Estimate | Final Actual| Skip First Presentation | BudgetRegion | ContentType | ProductionType       | TotalCostAmount | Rule name | CostType  |
| ACMCVendor3 | PhotographyCompany | SAP3            |  true               | true           | USD              | CostTotal       | 0                 | 1           | true                    | IMEA         | Still Image | Post Production Only |0;GreaterThan    | DPRule3   | Production|
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ACMCCT4    | ACMCCD4     | Aaron Royer (Grey)  | 10000                | Still Image  | Post Production Only | ACMCATN4               | IMEA          | DefaultCampaign | BFO          | GBP - British Pound     |
And filled Production Details with following fields for cost title 'ACMCCT4':
| Photographer Company |
| ACMCVendor3;true     |
When I change the all sections currency to 'EUR - Euro' on cost item page for cost title 'ACMCCT4'
Then I 'should' see following currency symbols for grand total on cost Item page:
| CurrencyGroup   | Currency Symbol  |
| Local           | $                |
| Default         | $                |
When I edit Production Details with following fields for cost title 'ACMCCT4':
| Photographer Company      |
| GBP - British Pound       |
Then I 'should' see sections currency as 'GBP - British Pound' on cost item page for cost title 'ACMCCT4'


Scenario: Check that Agency payment currency is not updated when Cost Sections Currencies are updated by the Owner
Meta: @adcost
!--QA-745
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ACMCCT5    | ACMCCD5     | Aaron Royer (Grey)  | 10000                | Still Image  | Post Production Only | ACMCATN5               | AAK           | DefaultCampaign | BFO          | GBP - British Pound     |
When I change the all sections currency to 'USD - US Dollar' on cost item page for cost title 'ACMCCT5'
Then I 'should' see following currency symbols for grand total on cost Item page:
| CurrencyGroup   | Currency Symbol  |
| Local           | £                |
| Default         | $                |


Scenario: Check that Governance manager able to update the exchange rates under admin section and these rates reflected accurately on cost creation
Meta: @adcost
!-- QA-870
Given I logged in as 'GovernanceManager'
And I updated following currency on Currency page under admin section:
|  Currency title       | Exchange rate  |
|  Afghanistan Afghani  | 0.5            |
And I logged in with details of 'CostOwner'
And I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number      | Cost Title    | Description   | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      |  Agency Tracking Number   | Budget Region | Campaign        | Organisation | Agency Payment Currency   |
| DefaultCostProject  | ACMCCT6       | ACMCD6        | Aaron Royer (Grey)  | 50000                | Audio        | Post Production Only |  ACMCATN6                 | AAK           | DefaultCampaign | BFO          | AFN - Afghanistan Afghani |
Then I 'should' see sections currency as 'AFN - Afghanistan Afghani' on cost item page for cost title 'ACMCCT6'
When I fill Payment details section on cost items page with following details:
| VO recording sessions | P&G insurance | Talent fees |
| 20000                 | 15000         | 30000       |
And wait for '2' seconds
Then I 'should' see following Cost Line Items populated on cost item page:
| VO recording sessions | P&G insurance        | Talent fees      |
| $ 10000.00            | $ 7500.00            | $ 15000.00       |


Scenario: Check that Governance manager able to add Buyout and Exclusive category values under dictionaries and these values reflected on usage buyout detail page
Meta: @adcost
!-- QA-870
Given I logged in as 'GovernanceManager'
And I updated following item on dictionary page under admin section:
|  Item                | Value          |
|  BuyoutName          | ACMCBuyout     |
|  ExclusivityCategory | ACMCExCategory |
And I logged in with details of 'CostOwner'
When create a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Celebrity | Buyout                | ACMCCT7    | ACMCCD7     | Lily Ross (Publicis)| ACMCATN7               | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
Then I 'should' see following data for cost title 'ACMCCT7' on usage buyout page:
| FieldName             |  FieldValue     |
| Name                  |  ACMCBuyout     |
| Exclusivity Category  |  ACMCExCategory |


Scenario: Check that Governance manager able to add Initiative values under dictionaries and these values reflected on expected asset page
Meta: @adcost
!-- QA-870
Given I logged in as 'GovernanceManager'
And I updated following item on dictionary page under admin section:
|  Item                | Value          |
|  Initiative          | ACMCInitiative |
And I logged in with details of 'CostOwner'
When create a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type        | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ACMCCT8    | ACMCCD8     | Aaron Royer (Grey)  | 10000                | Digital Development | ACMCATN8               | Japan         | DefaultCampaign | BFO          | USD - US Dollar         |
Then I 'should' see following 'ACMCInitiative' under 'Initiative' field on expected form page for cost title 'ACMCCT8'


Scenario: Check that CostOwner can enter initiative values while creating cost when Governance manager enables add on fly feature for initiative field in Dictionaries
Meta: @adcost
!-- QA-870
Given I logged in as 'GovernanceManager'
And I enabled add on fly feature for 'Initiative' field on dictionary page under admin section
And I logged in with details of 'CostOwner'
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ACMCCT9    | ACMCCD9     | Aaron Royer (Grey)  | 50000                | Video        | CGI/Animation   | ACMCATN9               | Europe        | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'ACMCCT9' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I am on expected assets page of cost title 'ACMCCT9'
And filled Expected Assets form with following fields:
| Initiative                 | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| ACMCInitiative1;Add on fly | ACMCAT9     | 10:10:10          | Version | Tv               | 12/12/2019               | HD         | Yes      | Yes       | JAPAN   |
When I am on expected assets page of cost title 'ACMCCT9'
Then I 'should' see following fields on expected assets section on AdCosts expected assets page:
| Initiative                 | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Country |
| ACMCInitiative1;Add on fly | ACMCAT9     | 10:10:10          | Version | Tv               | 12/12/2019               | HD         | Yes      | JAPAN   |