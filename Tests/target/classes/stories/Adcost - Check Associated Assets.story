Feature: Associated Assets
Narrative:
In order to
As a CostOwner
I want to check existing adId can linked via Associated Assets


Scenario: Check adid of production cost can be linked to usage cost type via assiciated assets
Meta:@adcost
     @linkedAssocoatedAssets
     @adcostCriticalTests
     @adcostSmokeUAT
     @adcostSmoke
!--QA-803
Given I am on costs overview page
Given I created a new 'production' cost with following CostDetails:
| Project Number      | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject  | CAACT1     | CAACD1      | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | CAAATN1           | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CAACT1' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CAACT1':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CAAAT1      | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
| Giggles    | JAPAN   | CAAAT2      | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
| Giggles    | JAPAN   | CAAAT3      | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And created a new 'buyout' cost on AdCosts overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Athletes  | Buyout                | CAACT2     | CAACD2      | Lily Ross (Publicis) | CAAATN2                | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And I am on Associated Assets page of cost title 'CAACT2'
When I link following adId of an existing assets for cost title 'CAACT2':
| Cost Title | Asset Title |
| CAACT1     | CAAAT1      |
| CAACT1     | CAAAT2      |
| CAACT1     | CAAAT3      |
Then I 'should' see following data added to Associated Assets section:
| Ad-ID  | Asset name | Initiative | Associated Cost |
| CAACT1 | CAAAT1     | Giggles    | CAACT1          |
| CAACT1 | CAAAT2     | Giggles    | CAACT1          |
| CAACT1 | CAAAT3     | Giggles    | CAACT1          |
When I click associated cost link of asset name 'CAAAT1' for cost title 'CAACT1'
Then I 'should' see associated cost opens in a new window for cost title 'CAACT1'
When I click associated cost link of asset name 'CAAAT2' for cost title 'CAACT1'
Then I 'should' see associated cost opens in a new window for cost title 'CAACT1'
When I click associated cost link of asset name 'CAAAT3' for cost title 'CAACT1'
Then I 'should' see associated cost opens in a new window for cost title 'CAACT1'


Scenario: Check that same adid can be linked only once and can also be deleted
Meta:@adcost
     @linkedAssocoatedAssets
!--QA-803
Given I am on costs overview page
Given I created a new 'production' cost with following CostDetails:
| Project Number      | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject  | CAACT3     | CAACD3      | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | CAAATN3           | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CAACT3' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CAACT3':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CAAAT4      | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
| Giggles    | JAPAN   | CAAAT5      | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Athletes  | Buyout                | CAACT4     | CAACD3      | Lily Ross (Publicis) | CAAATN3                | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And I am on Associated Assets page of cost title 'CAACT4'
When I link following adId of an existing assets for cost title 'CAACT4':
| Cost Title | Asset Title |
| CAACT3     | CAAAT4      |
| CAACT3     | CAAAT4      |
Then I 'should' see linked assets count as '1'
And 'should not' see linked assets count as '2'
When I link following adId of an existing assets for cost title 'CAACT4':
| Cost Title | Asset Title |
| CAACT3     | CAAAT5      |
Then I 'should' see linked assets count as '2'
And 'should not' see linked assets count as '1'
When I delete linked adid of asset name 'CAAAT4' for cost title 'CAACT3'
Then I 'should' see linked assets count as '1'
And 'should not' see linked assets count as '2'
And 'should' see following data added to Associated Assets section:
| Ad-ID  | Asset name | Initiative | Associated Cost |
| CAACT3 | CAAAT5     | Giggles    | CAACT3          |


Scenario: Check that AdId of another project cannot be linked
Given I created a project in agency 'DefaultAgency' without session wrap with following fileds:
| Name       | Custom Code | Advertiser | Sector        | Brand        |
| LAAProject | ProjectId   | DefaultAdv | DefaultSector | DefaultBrand |
And I am on costs overview page
And I created a new 'production' cost with following CostDetails:
| Project Number | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| LAAProject     | CAACT5     | CAACD5      | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | CAAATN5                | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CAACT5' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CAACT5':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CAAAT5      | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Athletes  | Buyout                | CAACT6     | CAACD6      | Lily Ross (Publicis) | CAAATN6           | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And I am on Associated Assets page of cost title 'CAACT6'
When I link following adId of an existing assets for cost title 'CAACT6':
| Cost Title | Asset Title |
| CAACT5     | CAAAT5      |
Then I 'should' see error message as 'Not able to find the Ad-ID. Please try again with the correct Ad-ID.'


Scenario: Check that costowner can submit the cost after linking adid
Meta:@adcost
     @linkedAssocoatedAssets
!--QA-803
Given I am on costs overview page
Given I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | CAACT7     | CAACD7      | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | CAAATN7           | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CAACT7' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CAACT7':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CAAAT6 | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Athletes  | Buyout                | CAACT8     | CAACD8      | Lily Ross (Publicis) | CAAATN8                | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And added UsageBuyout details for cost title 'CAACT8' with following fields:
| Name     | Name of Licensor(Person or Company) | Airing Countries | Touchpoints | Exclusivity                  | Start Date | End Date   | Exclusivity Category   | Contract Total |
| Buyout 1 | Licensor 1                          | India            | not for air | yes, if yes specify category | 12/12/2018 | 12/12/2019 | Exclusivity Category 1 | 20000          |
And added negotiated terms page for cost title 'CAACT8' with following fields:
| Produced Asset | Makeup Artist | Hair Stylist | Nail Artist | Wardrobe Artist | Celebrity | Manager | Glam Squad | Security |
| Yes            | Yes           | Yes          | Yes         | Yes             | Economy   | Economy | Economy    | Economy  |
And I am on Associated Assets page of cost title 'CAACT8'
When I link following adId of an existing assets for cost title 'CAACT8':
| Cost Title | Asset Title |
| CAACT7     | CAAAT6      |
And fill Cost Line Items with following fields for cost title 'CAACT8':
| Base Compensation | Please enter a 10-digit IO number |
| 1000              | 1234567890                        |
And I upload following supporting documents to cost title 'CAACT8':
| FileName            | FormName            |
| /files/EditWord.doc | Brief/Call for work |
And add below approvers for cost title 'CAACT8':
| Coupa Requisitioner       |
| BrandManagementApprover   |
When I 'Submit' the cost with title 'CAACT8'
And on cost review page of cost item with title 'CAACT8'
Then I 'should' see following data in 'Associated assets' section on Cost Review page:
| Ad-ID  | Asset name | Initiative | Associated Cost |
| CAACT7 | CAAAT6     | Giggles    | CAACT7          |
And 'should' see following linked assets are clickable on Cost Review page:
| Asset name | Associated Cost |
| CAAAT6     | CAACT7          |


Scenario: Check that same adid can be linked to multiple costs
Meta:@adcost
     @linkedAssocoatedAssets
!--QA-803
Given I am on costs overview page
Given I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | CAACT9     | CAACD9      | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | CAAATN9                | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CAACT9' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CAACT9':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CAAAT8      | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Athletes  | Buyout                | CAACT10    | CAACD10     | Lily Ross (Publicis) | CAAATN10               | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And I am on Associated Assets page of cost title 'CAACT10'
When I link following adId of an existing assets for cost title 'CAACT10':
| Cost Title | Asset Title |
| CAACT9     | CAAAT8      |
Then I 'should' see following data added to Associated Assets section:
| Ad-ID  | Asset name | Initiative | Associated Cost |
| CAACT9 | CAAAT8     | Giggles    | CAACT9          |
When I am on costs overview page
And create a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign   | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Athletes  | Buyout                | CAACT11    | CAACD11     | Lily Ross (Publicis) | CAAATN11               | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And I am on Associated Assets page of cost title 'CAACT11'
And I link following adId of an existing assets for cost title 'CAACT11':
| Cost Title | Asset Title |
| CAACT9     | CAAAT8      |
Then I 'should' see following data added to Associated Assets section:
| Ad-ID  | Asset name | Initiative | Associated Cost |
| CAACT9 | CAAAT8     | Giggles    | CAACT9          |


Scenario: Check associated assets can be downloaded
Meta:@adcost
     @linkedAssocoatedAssets
!--QA-828
Given I am on costs overview page
Given I created a new 'production' cost with following CostDetails:
| Project Number      | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject  | CAACT12    | CAACD12     | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | CAAATN12               | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And added production details for cost title 'CAACT12' with following fields:
| Post Production Company | Music Company       | CGI/Animation Company |
| GlobalDefaultVendor     | GlobalDefaultVendor | GlobalDefaultVendor   |
And added expected asset details for cost title 'CAACT12':
| Initiative | Country | Asset Title | Length (hh:mm:ss) | OVAL    | Media/Touchpoint | First Air/Insertion Date | Definition | Scrapped | Get AD-Id |
| Giggles    | JAPAN   | CAAAT10     | 10:10:10          | Version | Tv               | 12/31/2017               | HD         | Yes      | Yes       |
And created a new 'buyout' cost on AdCosts overview page
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type      | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Athletes  | Buyout                | CAACT13    | CAACD13     | Lily Ross (Publicis) | CAAATN13               | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And I am on Associated Assets page of cost title 'CAACT13'
When I link following adId of an existing assets for cost title 'CAACT13':
| Cost Title | Asset Title |
| CAACT12    | CAAAT10     |
Then I 'should' see below information in downloaded Associated Assets for cost title 'CAACT13':
| Initiative | Title   | Duration | Media Type | O/V/A/L Type | First Air Date | Scrapped | Airing Country/Region | Linked Usage Cost |
| Giggles    | CAAAT10 | 10:10:10 | Tv         | Version      | 31/12/17       | True     | JAPAN                 | CAACT13           |
