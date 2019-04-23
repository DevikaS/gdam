Feature: Travel Details
Narrative:
In order to
As a CostOwner
I want to add Travel Details to a cost

Scenario: Check that cost can be submitted with travel details
Meta:@adcost
     @travelDetails
     @adcostSmokeUAT
     @adcostSmoke
!--QA-827
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | TCCT1      | TCCD1       | Aaron Royer (Grey)  | 20000                | Video        | Full Production | TCATN1                 | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'TCCT1' with following fields:
| First Shoot Date | Production Company  | # of Shoot Days | Director     | Shoot Country | Shoot City | Talent Company      | Post Production Company | Music Company       | CGI/Animation Company |
| 01/10/2019       | GlobalDefaultVendor | 2               | Sven Harding | India         | New Delhi  | GlobalDefaultVendor | GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And I am on production details page of cost title 'TCCT1'
When I fill Travel Cost form  with following details for cost title 'TCCT1':
| Name of Traveller | Role of Traveller | Days | Destination Region | Country of travel | Shoot City | Mode of Travel (e.g., Air/Train Tickets) | Transportation Cost/Fee | Does travel cover other content Types | Comments             |
| TCCTTraveller1    | Producer          | 2    | Europe             | Italy             | Rome       | Air                                      | 200                     | No                                    | Auto Travel comments |
Then I 'should' see following fields on travel details section on Adcost production details page:
| Traveller name  | Traveller role | Shoot city | No. of days | Travel type | Total Agency Travel Costs |
| TCCTTraveller1  | Producer       | Rome       | 2           | Air         | $   1,400.00              |
When I add expected asset details for cost title 'TCCT1':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | TCAT1       | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And fill Cost Line Items with following fields for cost title 'TCCT1':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And upload following supporting documents to cost title 'TCCT1' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And fill below approvers for cost title 'TCCT1':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'TCCT1'
Then I 'should' see following fields in Travel Details section on Cost Review page:
| Traveller name | Traveller role | Shoot city | No. of days | Travel type | Total Agency Travel Costs |
| TCCTTraveller1 | Producer       | Rome       | 2           | Air         | $   1,400.00              |


Scenario: Check that edited travel details are shown on cost review page
Meta:@adcost
     @travelDetails
!--QA-827
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | TCCT2      | TCCD2       | Aaron Royer (Grey)  | 50000                | Audio        | Post Production Only | TCATN2                 | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And I added following Travel Details for cost title 'TCCT2':
| Name of Traveller | Role of Traveller | Days | Destination Region | Country of travel | Shoot City | Mode of Travel (e.g., Air/Train Tickets) | Transportation Cost/Fee | Does travel cover other content Types | Comments             |
| TCCTTraveller2    | Art Director      | 2    | Europe             | Italy             | Rome       | Air                                      | 200                     | No                                    | Auto Travel comments |
When I am on production details page of cost title 'TCCT2'
And I click 'Edit' option for traveler name 'TCCTTraveller2' in travel costs section on production details page
And I fill Travel Cost form  with following details for cost title 'TCCT2':
| Name of Traveller   | Days | Transportation Cost/Fee |
| TCCTTraveller2_Edit | 3    | 300                     |
And I fill Production Details with following fields for cost title 'TCCT2':
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
And add expected asset details for cost title 'TCCT2':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | TCAT2       | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And fill Cost Line Items with following fields for cost title 'TCCT2':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 10000                 | 10000         | 10000       | 1234567890                        |
And I upload following supporting documents to cost title 'TCCT2' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And fill below approvers for cost title 'TCCT2':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'TCCT2'
Then I 'should' see following fields in Travel Details section on Cost Review page:
| Traveller name       | Traveller role | Shoot city | No. of days | Travel type | Total Agency Travel Costs |
| TCCTTraveller2_Edit  | Art Director   | Rome       | 3           | Air         | $   2,100.00              |

Scenario: Check that cost can have multiple travel details
Meta:@adcost
     @travelDetails
!--QA-827
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | TCCT3      | TCCD3       | Aaron Royer (Grey)  | 20000                | Audio        | Full Production | TCATN3                 | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'TCCT3' with following fields:
| Talent Company      | Recording Date | Recording Days | Recording Country | Recording City | Audio/Music Company |
| GlobalDefaultVendor | 01/07/2019     | 2              | India             | New Delhi      | GlobalDefaultVendor |
When I add following Travel Details for cost title 'TCCT3':
| Name of Traveller | Role of Traveller | Days | Destination Region | Country of travel | Shoot City | Mode of Travel (e.g., Air/Train Tickets) | Transportation Cost/Fee | Does travel cover other content Types | Comments             |
| TCCTTraveller3    | Producer          | 1    | Europe             | Italy             | Rome       | Air                                      | 200                     | No                                    | Auto Travel comments |
| TCCTTraveller4    | Producer          | 2    | Europe             | Italy             | Rome       | Air                                      | 300                     | No                                    | Auto Travel comments |
| TCCTTraveller5    | Art Director      | 1    | Europe             | France            | Paris      | Air                                      | 400                     | No                                    | Auto Travel comments |
And I am on production details page of cost title 'TCCT3'
Then I 'should' see following fields on travel details section on Adcost production details page:
| Traveller name | Traveller role | Shoot city | No. of days | Travel type | Total Agency Travel Costs |
| TCCTTraveller4 | Producer       | Rome       | 2           | Air         | $   1,500.00              |
| TCCTTraveller3 | Producer       | Rome       | 1           | Air         | $   800.00                |
| TCCTTraveller5 | Art Director   | Paris      | 1           | Air         | $   1,000.00              |
When I add expected asset details for cost title 'TCCT3':
| Initiative | Country      | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id |
| Giggles    | Japan,Europe | TCAT3       | 10:10:10          | Version | Tv               | 12/12/2017               | Yes      | Yes       |
And fill Cost Line Items with following fields for cost title 'TCCT3':
| VO recording sessions | P&G insurance | Talent fees | Please enter a 10-digit IO number |
| 10000                 | 10000         | 10000       | 1234567890                        |
And upload following supporting documents to cost title 'TCCT3' and click continue:
| FileName            | FormName                                     |
| /files/EditWord.doc | Supplier winning bid (budget form)           |
| /files/EditWord.doc | P&G Communication Brief                      |
| /files/EditWord.doc | Approved Creative (storyboard/layout/script) |
And fill below approvers for cost title 'TCCT3':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And I click 'Submit' button and 'Send for approval' on approval Page
And I am on cost review page of cost item with title 'TCCT3'
Then I 'should' see following fields in Travel Details section on Cost Review page:
| Traveller name | Traveller role | Shoot city | No. of days | Travel type | Total Agency Travel Costs |
| TCCTTraveller4 | Producer       | Rome       | 2           | Air         | $   1,500.00              |
| TCCTTraveller3 | Producer       | Rome       | 1           | Air         | $   800.00                |
| TCCTTraveller5 | Art Director   | Paris      | 1           | Air         | $   1,000.00              |


Scenario: Check that travel details can be deleted
Meta:@adcost
     @travelDetails
!--QA-827
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | TCCT4      | TCCD4       | Aaron Royer (Grey) | 20000                | Still Image  | Post Production Only | TCATN4                 | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And I added following Travel Details for cost title 'TCCT4':
| Name of Traveller | Role of Traveller | Days | Destination Region | Country of travel | Shoot City | Mode of Travel (e.g., Air/Train Tickets) | Transportation Cost/Fee | Does travel cover other content Types | Comments             |
| TCCTTraveller6    | Art Director      | 2    | Europe             | Italy             | Rome       | Air                                      | 200                     | No                                    | Auto Travel comments |
| TCCTTraveller7    | Art Director      | 2    | Europe             | France            | Paris      | Air                                      | 200                     | No                                    | Auto Travel comments |
And I am on production details page of cost title 'TCCT4'
When I click 'Delete' option for traveler name 'TCCTTraveller6' in travel costs section on production details page
Then I 'should not' see traveler name 'TCCTTraveller6' in travel costs section on production details page
And I 'should' see traveler name 'TCCTTraveller7' in travel costs section on production details page


Scenario: Check that cost can be created with duplicate travel details
Meta:@adcost
     @travelDetails
!--QA-827
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | TCCT5      | TCCD5       | Aaron Royer (Grey) | 20000                | Still Image  | Full Production | TCATN5                 | North America | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'TCCT5' with following fields:
| Talent Company      | Photographer Company | Photographer Name | Shoot Country  | Shoot City | First Shoot Date | # of Shoot Days | Retouching Company  |
| GlobalDefaultVendor | GlobalDefaultVendor  | Overall Justin    | United Kingdom | Manchester | 01/07/2019       | 2               | GlobalDefaultVendor |
And I am on production details page of cost title 'TCCT5'
When I fill Travel Cost form  with following details for cost title 'TCCT5':
| Name of Traveller | Role of Traveller | Days | Destination Region | Country of travel | Shoot City | Mode of Travel (e.g., Air/Train Tickets) | Transportation Cost/Fee | Does travel cover other content Types | Comments             |
| TCCTTraveller8    | Creative          | 2    | Europe             | Italy             | Rome       | Air                                      | 200                     | No                                    | Auto Travel comments |
When I duplicate travel details for traveler name 'TCCTTraveller8' in production details page
Then I 'should' see traveler name 'TCCTTraveller8' in travel costs section on production details page
When I add expected asset details for cost title 'TCCT5':
| Initiative | Asset Title | OVAL    | Media/Touchpoint | First Air/Insertion Date | Scrapped | Get AD-Id | Country |
| Giggles    | TCAT6       | Version | streaming audio  | 12/12/2017               | Yes      | Yes       | Japan   |
And fill Cost Line Items with following fields for cost title 'TCCT5':
| Preproduction | Retouching | FX (Loss) & Gain | Please enter a 10-digit IO number |
| 10000         | 12000      | 8000             | 1234567890                        |
And upload following supporting documents to cost title 'TCCT5' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And add below approvers for cost title 'TCCT5':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refresh the page without delay
And I click 'Submit' button and 'Send for approval' on approval Page
And on cost review page of cost item with title 'TCCT5'
Then I 'should' see following fields in Travel Details section on Cost Review page:
| Traveller name | Traveller role | Shoot city | No. of days | Travel type | Total Agency Travel Costs |
| TCCTTraveller8 | Creative       | Rome       | 2           | Air         | $   1,400.00              |
| TCCTTraveller8 | Creative       | Rome       | 2           | Air         | $   1,400.00              |

Scenario: Check travel details can be added during revisions
Meta:@adcost
     @travelDetails
!--QA-827
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | TCCT6      | TCCD6       | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | TCATN6                 | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'TCCT6' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'TCCT6':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | TCAT1       | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And filled Cost Line Items with following fields for cost title 'TCCT6':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 3000          | 3000          | 1234567890                        |
And uploaded following supporting documents to cost title 'TCCT6' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'TCCT6':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
When I 'Submit' the cost with title 'TCCT6'
And I am on cost review page of cost item with title 'TCCT6'
And I login with details of 'IPMuser'
And 'Approve' the cost with title 'TCCT6'
And cost with title 'TCCT6' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And I am on cost review page of cost item with title 'TCCT6'
And click 'Create Revision' button and 'Confirm' on cost review page
And wait for '3' seconds
And I add following Travel Details for cost title 'TCCT6':
| Name of Traveller | Role of Traveller | Days | Destination Region | Country of travel | Shoot City | Mode of Travel (e.g., Air/Train Tickets) | Transportation Cost/Fee | Does travel cover other content Types | Comments             |
| TCCTTraveller9    | Producer          | 2    | Europe             | Italy             | Rome       | Air                                      | 200                     | No                                    | Auto Travel comments |
And I add cost item details for cost title 'TCCT6' with 'USD' currency:
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 8000               | 10000         | 3000          | 1234567890                        |
And I upload following supporting documents to cost title 'TCCT6':
| FileName            | FormName                   |
| /files/EditWord.doc | Scope change approval form |
And refresh the page without delay
And 'Submit' the cost with title 'TCCT6'
And I am on cost review page of cost item with title 'TCCT6'
Then I 'should' see following fields in Travel Details section on Cost Review page:
| Traveller name | Traveller role | Shoot city | No. of days | Travel type | Total Agency Travel Costs |
| TCCTTraveller9 | Producer       | Rome       | 2           | Air         | $   1,400.00              |


Scenario: Check travel details can be added in next stage
Meta:@adcost
     @travelDetails
!--QA-827
Given I am on costs overview page
And created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | TCCT7      | TCCD7       | Aaron Royer (Grey)  | 49000                | Video        | CGI/Animation   | TCATN7                  | AAK          | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'TCCT7' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'TCCT7':
| Initiative | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id | Country |
| Giggles    | TCAT1       | 10:10:10          | Version | Tv               | 12/12/2017               | HD         | Yes      | Yes       | JAPAN   |
And filled Cost Line Items with following fields for cost title 'TCCT7':
| Audio finalization | Offline edits | Agency travel | Please enter a 10-digit IO number |
| 1000               | 1000          | 40000         | 1234567890                        |
And I uploaded following supporting documents to cost title 'TCCT7' and click continue:
| FileName            | FormName                           |
| /files/EditWord.doc | Supplier winning bid (budget form) |
| /files/EditWord.doc | P&G Communication Brief            |
And added below approvers for cost title 'TCCT7':
| Technical Approver | Coupa Requisitioner       |
| IPMuser            | BrandManagementApprover   |
And refreshed the page without delay
And I clicked 'Submit' button and 'Send for approval' on approval Page
When I login with details of 'IPMuser'
And on cost review page of cost item with title 'TCCT7'
And click 'Approve' button and 'Approve' on cost review page
And cost with title 'TCCT7' is 'Approve' on behalf of MyPurchases application
And I login with details of 'CostOwner'
And 'NextStage' the cost with title 'TCCT7'
And I add following Travel Details for cost title 'TCCT7':
| Name of Traveller | Role of Traveller | Days | Destination Region | Country of travel | Shoot City | Mode of Travel (e.g., Air/Train Tickets) | Transportation Cost/Fee | Does travel cover other content Types | Comments             |
| TCCTTraveller10   | Producer          | 2    | Europe             | Italy             | Rome       | Air                                      | 200                     | No                                    | Auto Travel comments |
And I upload following supporting documents to cost title 'TCCT7':
| FileName            | FormName                                   |
| /files/EditWord.doc | Final (online) version approval from brand |
And refresh the page without delay
And 'Submit' the cost with title 'TCCT7'
And on cost review page of cost item with title 'TCCT7'
Then I 'should' see following fields in Travel Details section on Cost Review page:
| Traveller name  | Traveller role | Shoot city | No. of days | Travel type | Total Agency Travel Costs |
| TCCTTraveller10 | Producer       | Rome       | 2           | Air         | $   1,400.00              |