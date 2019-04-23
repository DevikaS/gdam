Feature:   Traffic  closed Caption image for subtitles required
Narrative:
In order to
As a              AgencyAdmin
I want to check that Closed Caption icon is shown at Order Level for SubTitles Required on Order Tab

Scenario: Check that Closed Caption icon is shown at Order Level on Order Tab for Subtitles Required None
Meta:@traffic
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand      | Sub Brand  | Product   |
| TCCIFSRAR4 | TCCIFSRBR4 | TCCIFSRSB4 | TCCIFSRP4 |
And logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TCCIFSRAR4 | TCCIFSRBR4 | TCCIFSRSB4 | TCCIFSRP4 | TCCIFSRC1 |TCCIFSRCN6_4  | 20       | 12/14/2022     |   None |HD 1080i 25fps | TCCIFSRT6 | BSkyB Green Button:Standard |
And completed order contains item with clock number 'TCCIFSRCN6_4' with following fields:
| Job Number  | PO Number |
| TCCIFSR17   | TCCIFSR17|
And login with details of 'trafficManager'
And wait till order with clockNumber 'TCCIFSRCN6_4' will be available in Traffic
And wait till order with clockNumber 'TCCIFSRCN6_4' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TCCIFSRCN6_4' in simple search form on Traffic Order Item List page
Then I should see ClosedCaption icon
| clockNumber  | ShouldSee  |
| TCCIFSRCN6_4 | should not |


Scenario: Check that Closed Caption icon is shown at Order Level on Order Tab for Subtitles Required Already Supplied
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TCCIFSRAR4 | TCCIFSRBR4 | TCCIFSRSB4 | TCCIFSRP4 | TCCIFSRC1 |TCCIFSRCN6_1  | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TCCIFSRT4 | BSkyB Green Button:Standard |
And completed order contains item with clock number 'TCCIFSRCN6_1' with following fields:
| Job Number  | PO Number |
| TCCIFSR14   | TCCIFSR14 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TCCIFSRCN6_1' will be available in Traffic
And wait till order with clockNumber 'TCCIFSRCN6_1' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TCCIFSRCN6_1' in simple search form on Traffic Order Item List page
Then I should see ClosedCaption icon
| clockNumber  | ShouldSee  |
| TCCIFSRCN6_1 | should     |


Scenario: Check that Closed Caption icon is shown at Order Level on Order Tab for Subtitles Required Adtext
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required       | Format    | Title | Destination                 |
| automated test info    | TCCIFSRAR4 | TCCIFSRBR4 | TCCIFSRSB4 | TCCIFSRP4 | TCCIFSRC1 |TCCIFSRCN6_2  | 20       | 12/14/2022     |   Adtext |HD 1080i 25fps | TCCIFSRT5 | BSkyB Green Button:Standard |
And completed order contains item with clock number 'TCCIFSRCN6_2' with following fields:
| Job Number  | PO Number |
| TCCIFSR14   | TCCIFSR14 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TCCIFSRCN6_2' will be available in Traffic
And wait till order with clockNumber 'TCCIFSRCN6_2' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TCCIFSRCN6_2' in simple search form on Traffic Order Item List page
Then I should see ClosedCaption icon
| clockNumber  | ShouldSee  |
| TCCIFSRCN6_2 | should     |


Scenario: Check that Closed Caption icon is shown at Order Level on Order Tab for Subtitles Required yes
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TCCIFSRAR4 | TCCIFSRBR4 | TCCIFSRSB4 | TCCIFSRP4 | TCCIFSRC1 |TCCIFSRCN6_3  | 20       | 12/14/2022     |   Yes |HD 1080i 25fps | TCCIFSRT6 | BSkyB Green Button:Standard |
And completed order contains item with clock number 'TCCIFSRCN6_3' with following fields:
| Job Number  | PO Number |
| TCCIFSR14   | TCCIFSR14 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TCCIFSRCN6_3' will be available in Traffic
And wait till order with clockNumber 'TCCIFSRCN6_3' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And enter search criteria 'TCCIFSRCN6_3' in simple search form on Traffic Order Item List page
Then I should see ClosedCaption icon
| clockNumber  | ShouldSee  |
| TCCIFSRCN6_3 | should     |



Scenario: Check that Closed Caption icon is shown at Order Level on Order Tab for Subtitles Required Adtext HD
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TCCIFSRAR4 | TCCIFSRBR4 | TCCIFSRSB4 | TCCIFSRP4 | TCCIFSRC1 |TCCIFSRCN6_5  | 20       | 12/14/2022     |   Adtext HD |HD 1080i 25fps | TCCIFSRT6 | BSkyB Green Button:Standard |
And completed order contains item with clock number 'TCCIFSRCN6_5' with following fields:
| Job Number  | PO Number |
| TCCIFSR14   | TCCIFSR14 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TCCIFSRCN6_5' will be available in Traffic
And wait till order with clockNumber 'TCCIFSRCN6_5' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TCCIFSRCN6_5' in simple search form on Traffic Order Item List page
Then I should see ClosedCaption icon
| clockNumber  | ShouldSee  |
| TCCIFSRCN6_5 | should     |


Scenario: Check that Closed Caption icon is shown at Order Level on Order Tab for Subtitles Required Adtext SD
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TCCIFSRAR4 | TCCIFSRBR4 | TCCIFSRSB4 | TCCIFSRP4 | TCCIFSRC1 |TCCIFSRCN6_6  | 20       | 12/14/2022     |   Adtext SD |HD 1080i 25fps | TCCIFSRT6 | BSkyB Green Button:Standard |
And completed order contains item with clock number 'TCCIFSRCN6_6' with following fields:
| Job Number  | PO Number |
| TCCIFSR14   | TCCIFSR14 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TCCIFSRCN6_6' will be available in Traffic
And wait till order with clockNumber 'TCCIFSRCN6_6' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And enter search criteria 'TCCIFSRCN6_6' in simple search form on Traffic Order Item List page
Then I should see ClosedCaption icon
| clockNumber  | ShouldSee  |
| TCCIFSRCN6_6 | should     |


Scenario: Check that Closed Caption icon is shown at Order Level on Order Tab for Subtitles Required BTI Studios
Meta:@traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TCCIFSRAR4 | TCCIFSRBR4 | TCCIFSRSB4 | TCCIFSRP4 | TCCIFSRC1 |TCCIFSRCN6_7  | 20       | 12/14/2022     |   BTI Studios |HD 1080i 25fps | TCCIFSRT6 | BSkyB Green Button:Standard |
And completed order contains item with clock number 'TCCIFSRCN6_7' with following fields:
| Job Number  | PO Number |
| TCCIFSR14   | TCCIFSR14 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TCCIFSRCN6_7' will be available in Traffic
And wait till order with clockNumber 'TCCIFSRCN6_7' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TCCIFSRCN6_7' in simple search form on Traffic Order Item List page
Then I should see ClosedCaption icon
| clockNumber  | ShouldSee  |
| TCCIFSRCN6_7 | should     |
