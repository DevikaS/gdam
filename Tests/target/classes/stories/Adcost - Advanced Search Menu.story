Feature: Advanced Search Menu
Narrative:
In order to
As a CostOwner
I want to create various filters

Scenario: Check creation of costType filter for Trafficking
Meta:@adcost
     @adcostSmokeUAT
     @adcostSmoke
!--QA-804
Given I logged in with details of 'CostOwner'
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ASMCT1     | ASMCD1      | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | ASMATN1                | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And I created a new 'buyout' cost with following CostDetails:
| Project Number     | New  | Approval stage for submission | Type     | Usage/Buyout/Contract | Cost Title | Description | Agency Producer/Art  | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | true | OriginalEstimate              | Athletes | Buyout                | ASMCT2     | ASMCD2      | Lily Ross (Publicis) | ASMATN2                | AAK           | DefaultCampaign |  BFO         | USD - US Dollar         |
And I created a new 'Trafficking' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art| Target Budget Amount | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency | Air/Insertion Date  | Approval stage for submission |
| DefaultCostProject | ASMCT3     | ASMCD3      | Aaron Royer (Grey) | 30000                | ASMATN3                | Greater China | DefaultCampaign | BFO          | USD - US Dollar         | 12/12/2018          | OriginalEstimate              |
And I am on costs overview page
When I select 'filters' section on cost overview page
And I set search filters as:
| Cost Type   |
| Trafficking |
And I create a new filter by name 'ASMCTTrkG'
Then I 'should' see 'ASMCT3' cost item on Adcost overview page
And 'should not' see 'ASMCT1,ASMCT2' cost item on Adcost overview page


Scenario: Check that filter can be created with multi ContentType
Meta:@adcost
!--QA-804
Given I logged in with details of 'CostOwner'
And I am on costs overview page
And I selected 'filters' section on cost overview page
And I filled search filters as:
| Cost Type  | Content Type | Production Type |
| Production | Audio;Video  | Full Production |
And I created a new filter by name 'ASMCTProd'
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type      | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ASMCT4     | ASMCD4      | Aaron Royer (Grey)  | 9000                 | Video        | Post Production Only | ASMATN4                | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ASMCT5     | ASMCD5      | Aaron Royer (Grey)  | 9000                 | Video        | Full Production | ASMATN5                | Greater China | DefaultCampaign | BFO          | USD - US Dollar         |
And I created a new 'production' cost with following CostDetails:
| Project Number     | Cost Title | Description | Agency Producer/Art | Target Budget Amount | Content Type | Production Type | Agency Tracking Number | Budget Region | Campaign        | Organisation | Agency Payment Currency |
| DefaultCostProject | ASMCT6     | ASMCD6      | Aaron Royer (Grey)  | 9000                 | Audio        | Full Production | ASMATN6                | AAK           | DefaultCampaign | BFO          | USD - US Dollar         |
When I refresh the page
Then I 'should' see 'ASMCT5,ASMCT6' cost item on Adcost overview page
And 'should not' see 'ASMCT4' cost item on Adcost overview page

Scenario: Check that filter can be renamed
Meta:@adcost
!--QA-804
Given I logged in with details of 'CostOwner'
And I am on costs overview page
And I selected 'filters' section on cost overview page
And I filled search filters as:
| Cost Type  | Production Type |
| Production | Full Production |
When I create a new filter by name 'ASMCTUpdate'
Then I 'should' see a filter tab created by name 'ASMCTUpdate' on costs overview page
When I 'Updates' filter by name 'ASMCTUpdate_Edit'
Then I 'should' see a filter tab created by name 'ASMCTUpdate_Edit' on costs overview page

Scenario: Check that filter can be deleted
Meta:@adcost
!--QA-804
Given I logged in with details of 'CostOwner'
And I am on costs overview page
And I selected 'filters' section on cost overview page
And I filled search filters as:
| Cost Type  |
| Production |
When I create a new filter by name 'ASMCTDelete'
Then I 'should' see a filter tab created by name 'ASMCTDelete' on costs overview page
When I 'Deletes' filter by name 'ASMCTDelete'
Then I 'should not' see a filter tab created by name 'ASMCTDelete' on costs overview page

Scenario: Check that AIPE option not visible in Advance filter section
Meta:@adcost
!--QA-1179
Given I am on cost overview page
When I select 'filters' section on cost overview page
Then I 'should' see following in filter section on costs overview page:
| Cost Approval Stage                                      |
| All; Final Actual; First Presentation; Original Estimate |