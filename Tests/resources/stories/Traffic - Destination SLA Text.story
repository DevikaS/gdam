!--NGN-18999
Feature:          Destination - Service Level Text
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that destination service level text is displayed in color


Scenario: Check that Service Level text is displayed in color
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
And I create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser  | Brand        | Sub Brand     | Product       | Campaign       | Clock Number  | Duration | Motivnummer |First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TDSLTAR1    | TDSLTBR1    | TDSLTSB1    | TDSLTP1          | TDSLTC1        |TDSLTCN_1      | 20       |      1      |12/14/2022     |   Already Supplied |HD 1080i 25fps  | TDSLTT1    |  Facebook DE:Express;Filmstarts:Standard        |
And I complete order contains item with clock number 'TDSLTCN_1' with following fields:
| Job Number  | PO Number |
|TDSLTJN1     | TDSLTPO1 |
And I logged in with details of 'trafficManager'
And waited till order with clockNumber 'TDSLTCN_1' will be available in Traffic
And selected 'All' tab in Traffic UI
And refreshed the page
And entered search criteria 'TDSLTCN_1' in simple search form on Traffic Order List page
And expanded all orders on Traffic Order List page
Then I should see the service level text colored for ClockNumber 'TDSLTCN_1':
|Condition|Destination|Service Level Text|Color        |
|should   |Facebook DE|Express           |color-orange |
|should   |Filmstarts |Standard          |color-blue   |
