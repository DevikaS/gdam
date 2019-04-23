Feature:          Traffic reassign orders
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that TM user should be able to select and reassign orders from Orders list




Scenario: Traffic Manager can assign to more than one user
Meta: @traffic
Given I created the following agency:
| Name    |    A4User     | AgencyType | Application Access |
| TROA1_1 | DefaultA4User | Advertiser |      ordering      |
| TROA1_2 | DefaultA4User |   Ingest   |       adpath       |
And created users with following fields:
| Email   |           Role          | AgencyUnique |  Access  |
| TROU1_1 |       agency.admin      |   TROA1_1  | ordering |
| TROU1_2 | traffic.traffic.manager |   TROA1_2  |  adpath  |
| TROU1_3 | traffic.traffic.manager |   TROA1_2  |  adpath  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'TROA1_1':
| Advertiser | Brand   | Sub Brand | Product   |
| TROSAR1    | TROSBR1 | TROSSB1   | TROSP1 |
And logged in with details of 'TROU1_1'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title  | Destination         |
| automated test info    | TROSAR1    | TROSBR1 | TROSSB1   | TROSP1  | TROSC1   |<ClockNumber1>| 20       |      1      | 06/16/2016     |   Already Supplied |HD 1080i 25fps  | TROST1 | Facebook DE:Express |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title  | Destination         |
| automated test info    | TROSAR1    | TROSBR1 | TROSSB1   | TROSP1  | TROSC1   |<ClockNumber2>| 20       |      1      | 06/13/2016     |   Already Supplied |HD 1080i 25fps  | TROST1 | Facebook DE:Express |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number | PO Number |
| TROS11     | TROS11    |
And complete order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number | PO Number |
| TROS11     | TROS11    |
And logged in with details of 'TROU1_2'
And waited till order with clockNumber '<ClockNumber1>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber2>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber1>' will have next status 'In Progress' in Traffic
And waited till order with clockNumber '<ClockNumber2>' will have next status 'In Progress' in Traffic
And selected 'All' tab in Traffic UI
And refreshed the page
And waited till order list will be loaded
When I assign all users from 'TROA1_2' agency for following orders:
| clockNumber      |
| <ClockNumber1>   |
| <ClockNumber2>   |
Then I should see order with clockNumber '<ClockNumber1>' in traffic list that have following data:
| Traffic assigned to|
| TROU1_2,TROU1_3    |
And should see order with clockNumber '<ClockNumber2>' in traffic list that have following data:
| Traffic assigned to|
| TROU1_2,TROU1_3    |

Examples:
| ClockNumber1 | ClockNumber2 |
| TROCN1_1     | TROCN1_2     |



Scenario: Traffic Manager can assign to one user
Meta: @traffic
Given I created the following agency:
| Name    |    A4User     | AgencyType | Application Access |
| TROA2_2 | DefaultA4User |   Ingest   |       adpath       |
And created users with following fields:
| Email   |           Role          | AgencyUnique |  Access  |
| TROU2_2 | traffic.traffic.manager |   TROA2_2    |  adpath  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| TROSAR2    | TROSBR2 | TROSSB2   | TROSP2  |
And logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title  | Destination         |
| automated test info    | TROSAR2    | TROSBR2 | TROSSB2   | TROSP2  | TROSC1   |<ClockNumber1>| 20       |      1      | 06/16/2016     |   Already Supplied |HD 1080i 25fps  | TROST1 | Facebook DE:Express |
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number | Duration | Motivnummer | First Air Date | Subtitles Required | Format         | Title  | Destination         |
| automated test info    | TROSAR2    | TROSBR2 | TROSSB2   | TROSP2  | TROSC1   |<ClockNumber2>| 20       |      1      | 06/13/2016     |   Already Supplied |HD 1080i 25fps  | TROST1 | Facebook DE:Express |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number | PO Number |
| TROS11     | TROS11    |
And complete order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number | PO Number |
| TROS11     | TROS11    |
And logged in with details of 'TROU2_2'
And waited till order with clockNumber '<ClockNumber1>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber2>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber1>' will have next status 'In Progress' in Traffic
And waited till order with clockNumber '<ClockNumber2>' will have next status 'In Progress' in Traffic
And selected 'All' tab in Traffic UI
And waited till order list will be loaded
And entered search criteria '<ClockNumber1>' in simple search form on Traffic Order List page
When I assign all users from 'TROA2_2' agency for following orders:
| clockNumber      |
| <ClockNumber1>   |
And open order details with clockNumber '<ClockNumber1>' from Traffic UI
Then I should see following fields on order page in Traffic UI:
| Assigned to |
| TROU2_2     |


Examples:
| ClockNumber1 | ClockNumber2 |
| TROCN2_1     | TROCN2_2     |