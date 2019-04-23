Feature: GL and MGC Codes validations
Narrative:
In order to
As a CostOwner
I want to check GL and MGC Codes validations

Scenario: Check GL and MGC codes for audio and full Production cost
Meta:@adcost
     @GLMGCcodes
!--QA-812
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | GMCVCT1     | GMCVCD1     | Aaron Royer (Grey)  | 60000                | Audio        | Full Production | GMCVATN1               | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'GMCVCT1' with following fields:
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And added expected asset details for cost title 'GMCVCT1':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL       | Media/Touchpoint   | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | GMCVAT1     | 10:10:10          | Version    | Direct to consumer | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'GMCVCT1':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 20000.50              | 25000.45      | 35000.63    | 1234567890                        |
And I uploaded following supporting documents to cost title 'GMCVCT1':
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'GMCVCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'GMCVCT1'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'GMCVCT1'
Then I should see AMQ receives below request for cost title 'GMCVCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | CategoryId | Gl       |
| 80001.58     | 0              | USD      | 1234567890 | DefaultBrand | GMCVCD1     | G821215AA  | 33710001 |
When cost with title 'GMCVCT1' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'GMCVCT1'
And I click 'Next Stage' button and 'Confirm' on cost review page
And add expected asset details for cost title 'GMCVCT1':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL  | Media/Touchpoint   | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | GMCVAT1A    | 10:10:10          | Lift  | Direct to consumer | 12/12/2017               | Yes      | Yes       |
And fill Cost Line Items with following fields for cost title 'GMCVCT1':
| VO recording sessions | P&G insurance | Talent fees |
| 35000.50              | 35000         | 30000       |
And I upload following supporting documents to cost title 'GMCVCT1':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'GMCVCT1'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'GMCVCT1'
Then I should see AMQ receives below request for cost title 'GMCVCT1' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description | CategoryId | Gl       |
| 100000.5     | 100000.5       | USD      | 1234567890 | DefaultBrand | GMCVCD1      | G821215AA  | 33710001 |


Scenario: Check GL and MGC codes for Audio and Post production cost
Meta:@adcost
     @GLMGCcodes
!--QA-812
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | GMCVCT2     | GMCVCD2     | Aaron Royer (Grey)  | 40000                | Audio        | Post Production Only | GMCVATN2               | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'GMCVCT2' with following fields:
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And added expected asset details for cost title 'GMCVCT2':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL       | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | GMCVAT2     | 10:10:10          | Adaptation | Tv               | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'GMCVCT2':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 10000.55              | 10000.65      | 10000       | 1234567890                        |
And I uploaded following supporting documents to cost title 'GMCVCT2':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'GMCVCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'GMCVCT2'
And I login with details of 'IPMuser'
And I 'Approve' the cost with title 'GMCVCT2'
Then I should see AMQ receives below request for cost title 'GMCVCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | CategoryId  | Gl       |
| 30001.2      | 0              | USD      | 1234567890 | DefaultBrand | GMCVCD2     | S821018BI   | 33500005 |
When cost with title 'GMCVCT2' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'GMCVCT2'
And click 'Next Stage' button and 'Confirm' on cost review page
And add expected asset details for cost title 'GMCVCT2':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | GMCVAT2A    | 10:10:10          | Version | streaming audio  | 12/12/2017               | Yes      | Yes       |
And fill Cost Line Items with following fields for cost title 'GMCVCT2':
| VO recording sessions | P&G insurance |
| 13000.21              | 12000.31      |
And I upload following supporting documents to cost title 'GMCVCT2':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'GMCVCT2'
And I login with details of 'IPMuser'
And I 'Approve' the cost with title 'GMCVCT2'
Then I should see AMQ receives below request for cost title 'GMCVCT2' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | CategoryId  | Gl       |
| 35000.52     | 35000.52       | USD      | 1234567890 | DefaultBrand | GMCVCD2     | S821018AU   | 33500001 |


Scenario: Check GL and MGC codes for Traffic Distribution cost
Meta:@adcost
     @GLMGCcodes
!--QA-812
Given I am on costs overview page
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | GMCVCT3    | GMCVD3      | Aaron Royer (Grey)  | 30000                | GMCVATN3               | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
And I filled Cost Line Items with following fields for cost title 'GMCVCT3':
| Trafficking/Distribution Costs | Please enter a 10-digit IO number |
| 20000                          |  1234567890                       |
And added below approvers for cost title 'GMCVCT3':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When 'Submit' the cost with title 'GMCVCT3'
And wait until cost status is 'PendingBrandApproval' and cost stage is 'Original Estimate' for cost title 'GMCVCT3'
And on cost review page of cost item with title 'GMCVCT3'
Then should see AMQ receives below request for cost title 'GMCVCT3' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand         | Description | Basket Name      | CategoryId | Gl       |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand  | GMCVD3      | brandDescription | S821018AT  | 33500002 |


Scenario: Check GL and MGC codes for Still image and Full production cost
Meta:@adcost
     @GLMGCcodes
     @adcostSmokeUAT
!--QA-812
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | GMCVCT4     | GMCVCD4     | Aaron Royer (Grey)  | 8000                 | Still Image  | Full Production | GMCVATN4               | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'GMCVCT4' with following fields:
| Talent Company      | Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Retouching Company  |
| GlobalDefaultVendor | GlobalDefaultVendor  | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | GlobalDefaultVendor |
And added expected asset details for cost title 'GMCVCT4':
| Initiative | Asset Title |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | GMCVAT4     |  Version | PR/Influencer    | 12/12/2017               | Yes      | Yes       | Japan   |
And I filled Cost Line Items with following fields for cost title 'GMCVCT4':
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 40000                  | 2000       | 3000             | 1234567890                        |
And I uploaded following supporting documents to cost title 'GMCVCT4':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'GMCVCT4':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'GMCVCT4'
And I login with details of 'IPMuser'
And I 'Approve' the cost with title 'GMCVCT4'
Then I should see AMQ receives below request for cost title 'GMCVCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | CategoryId  | Gl       |
| 45000        | 0              | USD      | 1234567890 | DefaultBrand | GMCVCD4     | S82141500   | 33720001 |
When cost with title 'GMCVCT4' is 'Approve' on behalf of MyPurchases application with page refresh
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'GMCVCT4'
And add expected asset details for cost title 'GMCVCT4':
| Initiative | Asset Title |  OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | GMCVAT4     |  Version | PR/Influencer    | 12/12/2017               | Yes      | Yes       | Japan   |
And fill Cost Line Items with following fields for cost title 'GMCVCT4':
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain |
| 50000                  | 5000       | 5000             |
And I upload following supporting documents to cost title 'GMCVCT4' and click continue:
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And I 'Submit' the cost with title 'GMCVCT4'
And I login with details of 'IPMuser'
And I 'Approve' the cost with title 'GMCVCT4'
Then I should see AMQ receives below request for cost title 'GMCVCT4' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | CategoryId  | Gl       |
| 60000        | 60000          | USD      | 1234567890 | DefaultBrand | GMCVCD4     | S82141500   | 33720001 |


Scenario: Check GL and MGC codes for Music and Usage/Buyout cost
Meta:@adcost
     @GLMGCcodes
     @adcostCriticalTests
!--QA-812
Given I am on costs overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type  | Usage/Buyout/Contract  | Cost Title | Description | Agency Producer/Art | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Music | Usage                  | GMCVCT5    | GMCVCD5     | Aaron Royer (Grey)  | GMCVATN1               | Japan         | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'GMCVCT5' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 40000          |
And added negotiated terms page for cost title 'GMCVCT5' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on cost items page of cost title 'GMCVCT5'
And I filled Cost Line Items with following fields:
| Base Compensation | Usage/Residuals/Buyout Fee |  Please enter a 10-digit IO number |
| 10000             | 10000                      |  1234567890                        |
And I uploaded following supporting documents to cost title 'GMCVCT5':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And added below approvers for cost title 'GMCVCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I 'Submit' the cost with title 'GMCVCT5'
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'GMCVCT5'
Then should see AMQ receives below request for cost title 'GMCVCT5' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name    | CategoryId | Gl       |
| 20000        | 0              | USD      | 1234567890 | DefaultBrand | GMCVCD5   | brandDescription | S55111500  | 33500004 |


Scenario: Check GL and MGC codes for video and CGI/Animation cost
Meta:@adcost
     @GLMGCcodes
!--QA-812
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | GMCVCT6    | GMCVCD6     | Aaron Royer (Grey)  | 55000                | Video        | CGI/Animation   | GMCVATN6               | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And I waited for '2' seconds
And added production details for cost title 'GMCVCT6' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'GMCVCT6':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | GMCVAT6     | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | Japan   |
And filled Cost Line Items with following fields for cost title 'GMCVCT6':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 40000              | 20000         | 5000          | 1234567890                        |
And I uploaded following supporting documents to cost title 'GMCVCT6' and click continue:
| FileName            | FormName                            |
| /files/EditWord.doc | Supplier winning bid (budget form)  |
| /files/EditWord.doc | P&G Communication Brief             |
And filled below approvers for cost title 'GMCVCT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I click 'Submit' button and 'Send for approval' on approval Page
And I login with details of 'IPMuser'
And on cost review page of cost item with title 'GMCVCT6'
And click 'Approve' button and 'Approve' on cost review page
Then I should see AMQ receives below request for cost title 'GMCVCT6' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | CategoryId | Gl       |
| 65000        | 0              | USD      | 1234567890 | DefaultBrand | GMCVCD6     | S821018AT  | 33500001 |
When cost with title 'GMCVCT6' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And on cost review page of cost item with title 'GMCVCT6'
And click 'Next Stage' button and 'Confirm' on cost review page
And add expected asset details for cost title 'GMCVCT6':
| Initiative | Asset Title  | Length (hh:mm:ss) | OVAL       | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | GMCVAT6A     | 10:10:10          | Adaptation | Cinema           | 12/12/2017               | HD         | Yes      | Yes       | Japan   |
And fill Cost Line Items with following fields for cost title 'GMCVCT6':
| Audio finalization | Offline edits |
| 40000              | 22000         |
And I upload following supporting documents to cost title 'GMCVCT6':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'GMCVCT6'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'GMCVCT6'
Then I should see AMQ receives below request for cost title 'GMCVCT6' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | CategoryId | Gl       |
| 67000        | 67000          | USD      | 1234567890 | DefaultBrand | GMCVCD6     | S821018AT  | 33500001 |


Scenario: Check GL and MGC codes for Video Content Type and Full Production
Meta:@adcost
     @GLMGCcodes
!--QA-812
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number      | Cost Title | Description | Agency Producer/Art  | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject  | GMCVCT7    | GMCVD7      | Aaron Royer (Grey)   | 9000                 | Video        | Full Production | GMCVATN7               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'GMCVCT7' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'GMCVCT7':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | GMCVAT2     | 10:10:10          | Version | In-store         | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'GMCVCT7':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And uploaded following supporting documents to cost title 'GMCVCT7':
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'GMCVCT7':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'GMCVCT7'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'GMCVCT7'
Then I should see AMQ receives below request for cost title 'GMCVCT7' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      | CategoryId | Gl       |
| 14000        | 0              | USD      | 1234567890 | DefaultBrand | GMCVD7      | brandDescription | S821019BD  | 34420006 |
When cost with title 'GMCVCT7' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I 'NextStage' the cost with title 'GMCVCT7'
And add expected asset details for cost title 'GMCVCT7':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL     | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | GMCVAT2A    | 10:10:10          | Original | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And I fill Cost Line Items with following fields for cost title 'GMCVCT7':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 10000         | 4000          | 1234567890                        |
And I upload following supporting documents to cost title 'GMCVCT7':
| FileName            | FormName                              |
| /files/EditWord.doc | First Presentation Confirmation Email |
| /files/EditWord.doc | Scope change approval form            |
And 'Submit' the cost with title 'GMCVCT7'
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'GMCVCT7'
Then I should see AMQ receives below request for cost title 'GMCVCT7' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      | CategoryId | Gl       |
| 22000        | 9000           | USD      | 1234567890 | DefaultBrand | GMCVD7      | brandDescription | S821018AT  | 33500001 |


Scenario: Check GL and MGC codes for Still image and Post production only cost
Meta:@adcost
     @GLMGCcodes
!--QA-812
Given I am on costs overview page
And created a new 'production' cost on AdCosts overview page
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title   | Description  | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | GMCVCT8      | GMCVCD8      | Aaron Royer (Grey)  | 50000                | Still Image  | Post Production Only | GMCVATN7               | IMEA          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'GMCVCT8' with following fields:
| Retouching Company  | Talent Company      | Photographer Company |
| GlobalDefaultVendor | GlobalDefaultVendor | GlobalDefaultVendor  |
And added expected asset details for cost title 'GMCVCT8':
| Initiative | Asset Title  | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | GMCVAT8      | Version | Out of home      | 12/12/2017               | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'GMCVCT8':
| Agency Artwork / Packs | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 30000                  | 20000      | 10000              | 1234567890                        |
And I uploaded following supporting documents to cost title 'GMCVCT8':
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'GMCVCT8':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'GMCVCT8'
And I login with details of 'IPMuser'
And I 'Approve' the cost with title 'GMCVCT8'
Then I should see AMQ receives below request for cost title 'GMCVCT8' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      | CategoryId | Gl       |
| 60000        | 30000          | USD      | 1234567890 | DefaultBrand | GMCVCD8      | brandDescription | S821018AV  | 33500001 |
When cost with title 'GMCVCT8' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'GMCVCT8'
And click 'Next Stage' button and 'Confirm' on cost review page
And add expected asset details for cost title 'GMCVCT8':
| Initiative | Asset Title  | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | GMCVAT8      | Lift    | Out of home      | 12/12/2017               | Yes      | Yes       | JAPAN   |
And fill Cost Line Items with following fields for cost title 'GMCVCT8':
| Agency Artwork / Packs |
| 40000                  |
And I upload following supporting documents to cost title 'GMCVCT8':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
| /files/EditWord.doc | Scope change approval form                 |
And 'Submit' the cost with title 'GMCVCT8'
And I login with details of 'IPMuser'
And I 'Approve' the cost with title 'GMCVCT8'
Then I should see AMQ receives below request for cost title 'GMCVCT8' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description  | Basket Name      | CategoryId | Gl       |
| 70000        | 40000          | USD      | 1234567890 | DefaultBrand | GMCVCD8      | brandDescription | S821018AV  | 33500001 |


Scenario: Check that default Video GL and MGC codes are selected for Direct to Consumers media type and OVAL type Adaptation
Meta:@adcost
     @GLMGCcodes
     @adcostSmokeUAT
     @adcostSmoke
!--QA-812
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number      | Cost Title | Description | Agency Producer/Art  | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject  | GMCVCT9    | GMCVD9      | Aaron Royer (Grey)   | 9000                 | Video        | Full Production | GMCVATN9               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'GMCVCT9' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'GMCVCT9':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL       | Media/Touchpoint   | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | GMCVAT9     | 10:10:10          | Adaptation | Direct to consumer | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'GMCVCT9':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And uploaded following supporting documents to cost title 'GMCVCT9':
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'GMCVCT9':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'GMCVCT9'
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'GMCVCT9'
Then I should see AMQ receives below request for cost title 'GMCVCT9' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | Basket Name      | CategoryId | Gl       |
| 14000        | 0              | USD      | 1234567890 | DefaultBrand | GMCVD9      | brandDescription | S821018AT  | 33500001 |


Scenario: Check that default GL and MGC codes are selected for Direct to Consumers media type and OVAL type Adaptation
Meta:@adcost
     @GLMGCcodes
     @adcostCriticalTests
!--QA-812
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title  | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | GMCVCT10    | GMCVCD10    | Aaron Royer (Grey)  | 60000                | Audio        | Full Production | GMCVATN10              | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'GMCVCT10' with following fields:
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And added expected asset details for cost title 'GMCVCT10':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL       | Media/Touchpoint   | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | GMCVAT10    | 10:10:10          | Adaptation | Direct to consumer | 12/12/2017               | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'GMCVCT10':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 25000                 | 35000         | 20000       | 1234567890                        |
And I uploaded following supporting documents to cost title 'GMCVCT10':
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And added below approvers for cost title 'GMCVCT10':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When 'Submit' the cost with title 'GMCVCT10'
When I login with details of 'IPMuser'
And 'Approve' the cost with title 'GMCVCT10'
Then I should see AMQ receives below request for cost title 'GMCVCT10' and type as 'submitted':
| Total Amount | Payment Amount | Currency | IO Number  | Brand        | Description | CategoryId | Gl       |
| 80000        | 0              | USD      | 1234567890 | DefaultBrand | GMCVCD1     | S821018AU  | 33500001 |