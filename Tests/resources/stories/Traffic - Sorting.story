Feature:          Traffic List sorting
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Traffic List sorting


Scenario: Check sorting for TM on Order and Order Item Clock tab types (Title, Clock Number, First Air Date, Clock Service Level)
!--NGN-15951
Meta:@traffic
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser | Brand      | Sub Brand  | Product |
|  TLSIAR1   |  TLSIBR1   |   TLSIB1   | TLSIP1  |
And logged in with details of '<User>'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Media Agency| Clock Number   | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination          | Motivnummer |
| automated test info    | TLSIAR1    | TLSIBR1    | TLSIB1     | TLSIP1    | TTVBTVSC1 | TTVBTVSC1   | <ClockNumber1>  | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps | Adstream | Facebook DE:Standard |  1           |
And create 'tv' order with market 'Uruguay' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Media Agency| Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title    | Destination          |
| automated test info    | TLSIAR1    | TLSIBR1    | TLSIB1     | TLSIP1    | TTVBTVSC1 | TTVBTVSC1   | <ClockNumber2>  | 20       | 12/14/2018     |  Already Supplied  |HD 1080i 25fps  | 07Bond   | 	TV Rio:Standard (US) |
And create 'tv' order with market 'Australia' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Media Agency| Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title    | Destination                     |
| automated test info    | TLSIAR1    | TLSIBR1    | TLSIB1     | TLSIP1    | TTVBTVSC1 | TTVBTVSC1   | <ClockNumber3>  | 20       | 12/27/2022     |  Already Supplied  |HD 1080i 25fps  | ZemZ     | Redhot (Adelaide):Standard (AU) |
And create 'tv' order with market 'Australia' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Media Agency| Clock Number   | Duration | First Air Date | Subtitles Required | Format         | Title    | Destination                    |
| automated test info    | TLSIAR1    | TLSIBR1    | TLSIB1     | TLSIP1    | TTVBTVSC1 | TTVBTVSC1   | <ClockNumber4> | 20       | 12/03/2023     |  Already Supplied  |HD 1080i 25fps  | 9Levi    | Redhot (Adelaide):Express (AU) |
And create 'tv' order with market 'Australia' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Media Agency| Clock Number   | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                    |
| automated test info    | TLSIAR1    | TLSIBR1    | TLSIB1     | TLSIP1    | TTVBTVSC1 | TTVBTVSC1   | <ClockNumber5> | 20       | 03/12/2023     |  Already Supplied  |HD 1080i 25fps  | FAster    | Redhot (Adelaide):Red Hot (AU) |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number '<ClockNumber4>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number '<ClockNumber5>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And logged in with details of 'trafficManager'
And waited till order with clockNumber '<ClockNumber1>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber2>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber3>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber4>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber5>' will be available in Traffic
And created tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition    |  Condition Type  |  Value   |
|  <Condition1> |   <FilterType1>  | <Value1> |
|  <Condition2> |   <FilterType2>  | <Value2> |
And waited till order item list will be loaded in Traffic
And waited for '5' seconds
When I sort Order Items by field '<SortedBy>' in order '<SortingType>' from Traffic UI
And wait till order list will be loaded
Then I should see that 'order item' are sorted by '<SortedByReal>' field and '<SortingType>' order in Traffic

Examples:
| Agency         |  User         | ClockNumber1 | ClockNumber2 | ClockNumber3 | ClockNumber4 | ClockNumber5 |       SortedBy                |         SortedByReal        | SortingType  |     TabName       |   Condition1     | FilterType1  | Value1            |  Condition2 | FilterType2 | Value2  |    TabType       |
| DefaultAgency  | AgencyAdmin   |  TLSCN1_1    |   TLSCN1_2   |    TLSCN1_3  |   TLSCN1_4   |   TLSCN1_5   |        Title                  |            Title            |     asc      | AdvertiserSort    |   Advertiser     |   Match      | TLSIAR1           |             |             |         | Order Item Clock |
| DefaultAgency  | AgencyAdmin   |  TLSCN2_1    |   TLSCN2_2   |    TLSCN2_3  |   TLSCN2_4   |   TLSCN2_5   |     Clock Number                   |        Clock Number              |     asc      | ClockNumberSort   |   Market Country | Match        | AU                |  Advertiser |   Match     | TLSIAR1 | Order Item Clock |
| DefaultAgency  | AgencyAdmin   |  TLSCN3_1    |   TLSCN3_2   |    TLSCN3_3  |   TLSCN3_4   |   TLSCN3_5   |    First Air Date             |        First Air Date       |    desc      | FirstAirDateSort  |  Market Country  | Match        | AU                |  Advertiser |   Match     | TLSIAR1 | Order Item Clock |
| DefaultAgency  | AgencyAdmin   |  TLSCN4_1    |   TLSCN4_2   |    TLSCN4_3  |   TLSCN4_4   |   TLSCN4_5   | Clock Service Level           | Clock Service Level         |     asc      | ServiceLevelSort  |  Market Country  | Match        | AU                |  Advertiser |   Match     | TLSIAR1 | Order Item Clock |
| DefaultAgency  | AgencyAdmin   |  TLSCN5_1    |   TLSCN5_2   |    TLSCN5_3  |   TLSCN5_4   |   TLSCN5_5   |      Service Level Minutes    |    Service Level Minutes    |    desc      | ServiceLevelSort2 |   Agency         |   Starts with| A5testAdvertiser  |             |             |         | Order Item Clock |
| DefaultAgency  | AgencyAdmin   |  TLSCN6_1    |   TLSCN6_2   |    TLSCN6_3  |   TLSCN6_4   |   TLSCN6_5   |      Agency                   |    Agency                   |    desc      | AgencySort        |   Agency         |   Starts with|  A5testAdvertiser |             |             |         | Order Item Clock |

Scenario: Check sorting for TM on Order  (Market)
!--NGN-15951
Meta:@traffic
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser | Brand      | Sub Brand  | Product |
|  TLSIAR1   |  TLSIBR1   |   TLSIB1   | TLSIP1  |
And logged in with details of '<User>'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Media Agency| Clock Number   | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination          | Motivnummer |
| automated test info    | TLSIAR1    | TLSIBR1    | TLSIB1     | TLSIP1    | TTVBTVSC1 | TTVBTVSC1   | <ClockNumber1>  | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps | Adstream | Facebook DE:Standard |  1           |
And create 'tv' order with market 'Uruguay' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Media Agency| Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title    | Destination          |
| automated test info    | TLSIAR1    | TLSIBR1    | TLSIB1     | TLSIP1    | TTVBTVSC1 | TTVBTVSC1   | <ClockNumber2>  | 20       | 12/14/2018     |  Already Supplied  |HD 1080i 25fps  | 07Bond   | 	TV Rio:Standard (US) |
And create 'tv' order with market 'Australia' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Media Agency| Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title    | Destination                     |
| automated test info    | TLSIAR1    | TLSIBR1    | TLSIB1     | TLSIP1    | TTVBTVSC1 | TTVBTVSC1   | <ClockNumber3>  | 20       | 12/27/2022     |  Already Supplied  |HD 1080i 25fps  | ZemZ     | Redhot (Adelaide):Standard (AU) |
And create 'tv' order with market 'Australia' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Media Agency| Clock Number   | Duration | First Air Date | Subtitles Required | Format         | Title    | Destination                    |
| automated test info    | TLSIAR1    | TLSIBR1    | TLSIB1     | TLSIP1    | TTVBTVSC1 | TTVBTVSC1   | <ClockNumber4> | 20       | 12/03/2023     |  Already Supplied  |HD 1080i 25fps  | 9Levi    | Redhot (Adelaide):Express (AU) |
And create 'tv' order with market 'Australia' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Media Agency| Clock Number   | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                    |
| automated test info    | TLSIAR1    | TLSIBR1    | TLSIB1     | TLSIP1    | TTVBTVSC1 | TTVBTVSC1   | <ClockNumber5> | 20       | 03/12/2023     |  Already Supplied  |HD 1080i 25fps  | FAster    | Redhot (Adelaide):Red Hot (AU) |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number '<ClockNumber4>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number '<ClockNumber5>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And logged in with details of 'trafficManager'
And waited till order with clockNumber '<ClockNumber1>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber2>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber3>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber4>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber5>' will be available in Traffic
And created tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition    |  Condition Type  |  Value   |
|  <Condition1> |   <FilterType1>  | <Value1> |
|  <Condition2> |   <FilterType2>  | <Value2> |
And waited till order item list will be loaded in Traffic
And waited for '5' seconds
When I sort Order Items by field '<SortedBy>' in order '<SortingType>' from Traffic UI
And wait till order item list will be loaded in Traffic
Then I should see that 'order' are sorted by '<SortedByReal>' field and '<SortingType>' order in Traffic

Examples:
| Agency         |  User         | ClockNumber1 | ClockNumber2 | ClockNumber3 | ClockNumber4 | ClockNumber5 |       SortedBy       |         SortedByReal        | SortingType  |     TabName       |   Condition1   | FilterType1  | Value1            |  Condition2 | FilterType2 | Value2  |    TabType       |
| DefaultAgency  | AgencyAdmin   |  TLSCN7_1    |   TLSCN7_2   |    TLSCN7_3  |   TLSCN7_4   |   TLSCN7_5   |      Market          |    Market                   |    desc      | MarketSort        |   Agency       |   Starts with| A5testAdvertiser  |             |             |         |       Order      |

Scenario: Check sorting for TM on Order tab type (Submitted date)
!--NGN-15951
Meta:@traffic
Given created following catalogue structure items chains in 'common' section of 'common' schema for agency '<Agency>':
| Advertiser | Brand      | Sub Brand  | Product |
|  TLSIAR1   |  TLSIBR1   |   TLSIB1   | TLSIP1  |
And logged in with details of '<User>'
And create 'tv' order with market 'Australia' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Media Agency| Clock Number   | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination          |
| automated test info    | TLSIAR1    | TLSIBR1    | TLSIB1     | TLSIP1    | TTVBTVSC1 | TTVBTVSC1   | <ClockNumber1>  | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps | Adstream | One Metro HD:Standard |
And create 'tv' order with market 'Uruguay' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Media Agency| Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title    | Destination          |
| automated test info    | TLSIAR1    | TLSIBR1    | TLSIB1     | TLSIP1    | TTVBTVSC1 | TTVBTVSC1   | <ClockNumber2>  | 20       | 12/14/2018     |  Already Supplied  |HD 1080i 25fps  | 07Bond   | 	TV Rio:Standard (US) |
And create 'tv' order with market 'Australia' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Media Agency| Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title    | Destination                     |
| automated test info    | TLSIAR1    | TLSIBR1    | TLSIB1     | TLSIP1    | TTVBTVSC1 | TTVBTVSC1   | <ClockNumber3>  | 20       | 12/27/2022     |  Already Supplied  |HD 1080i 25fps  | ZemZ     | Redhot (Adelaide):Standard (AU) |
And create 'tv' order with market 'Australia' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Media Agency| Clock Number   | Duration | First Air Date | Subtitles Required | Format         | Title    | Destination                    |
| automated test info    | TLSIAR1    | TLSIBR1    | TLSIB1     | TLSIP1    | TTVBTVSC1 | TTVBTVSC1   | <ClockNumber4> | 20       | 12/03/2023     |  Already Supplied  |HD 1080i 25fps  | 9Levi    | Redhot (Adelaide):Express (AU) |
And create 'tv' order with market 'Australia' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Media Agency| Clock Number   | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                    |
| automated test info    | TLSIAR1    | TLSIBR1    | TLSIB1     | TLSIP1    | TTVBTVSC1 | TTVBTVSC1   | <ClockNumber5> | 20       | 03/12/2023     |  Already Supplied  |HD 1080i 25fps  | FAster    | Redhot (Adelaide):Red Hot (AU) |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number '<ClockNumber4>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And complete order contains item with clock number '<ClockNumber5>' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And logged in with details of 'trafficManager'
And waited till order with clockNumber '<ClockNumber1>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber2>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber3>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber4>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber5>' will be available in Traffic
And selected 'All' tab in Traffic UI
When I sort Order Items by field '<SortedBy>' in order '<SortingType>' from Traffic UI
And wait till order item list will be loaded in Traffic
Then I should see that 'order item' are sorted by '<SortedByReal>' field and '<SortingType>' order in Traffic


Examples:
| Agency                |  User         |ClockNumber1   | ClockNumber2   | ClockNumber3   | ClockNumber4   | ClockNumber5   |       SortedBy       |      SortedByReal     | SortingType  |
| DefaultAgency         | AgencyAdmin   |  TLSCN6_1_1   |   TLSCN6_1_2   |    TLSCN6_1_3  |   TLSCN6_1_4   |   TLSCN6_1_5   |    Submitted Date    |     Submitted Date    |    asc       |


Scenario: Last Column is present as an option on the Order table and can be sorted
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                  |
| automated test info    | TLSIAR1      | TLSIBR1      | TLSIB1       | TLSIP1      | TLCMC4    | <ClockNumber1>    | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TLCMFSRT4  | BSkyB Green Button:Standard  |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand        | Sub Brand    | Product     | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                  |
| automated test info    | TLSIAR1      | TLSIBR1      | TLSIB1       | TLSIP1      | TLCMC4    | <ClockNumber2>    | 20       | 12/14/2022     |   Adtext           |HD 1080i 25fps  | TLCMFSRT5  | BSkyB Green Button:Standard  |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number   | PO Number  |
| TLCMOTSR14   | TLCMOTSR14 |
And complete order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number   | PO Number  |
| TLCMOTSR15   | TLCMOTSR15 |
| TLCMOTSR17  | TLCMOTSR17 |
And logged in with details of 'trafficManager'
And waited till order with clockNumber '<ClockNumber1>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber2>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber1>' will have next status 'In Progress' in Traffic
And waited till order with clockNumber '<ClockNumber2>' will have next status 'In Progress' in Traffic
And refreshed the page
And selected 'All' tab in Traffic UI
And I created tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type  |     Value       |
|   Market    |    Match        | United Kingdom  |
And waited till order list will be loaded
And I add comment for following orders:
| clockNumber      | comment      |
| <ClockNumber1>   | <Comment_1>  |
| <ClockNumber2>   | <Comment_2>  |
When I sort Order Items by field '<SortedBy>' in order '<SortingType>' from Traffic UI
And wait till order item list will be loaded in Traffic
Then I should see that 'order' are sorted by '<SortedBy>' field and '<SortingType>' order in Traffic


Examples:
| ClockNumber1   | ClockNumber2   |  TabName     |  TabType        | Comment_1 | Comment_2  |  SortedBy       |  SortingType  |
|   TLCMOTCN_5   |   TLCMOTCN_6   |  ORDER_AD_2  |  Order          | EEEE      | FFFF       |  Last Comment   |      desc     |


Scenario: Last Column is present as an option on the Send Level and can be sorted
Meta:@traffic
     @qatrafficsmoke
     @uattrafficsmoke
     @trafficdeploymentsanity
     @trafficcrossbrowser
Given logged in with details of 'AgencyAdmin'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                  |
| automated test info    | TLSIAR1    | TLSIBR1    | TLSIB1     | TLSIP1    | TLCMC4    | <ClockNumber1>    | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps  | TLCMFSRT4  | Talk Sport:Standard  |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                  |
| automated test info    | TLSIAR1    | TLSIBR1    | TLSIB1     | TLSIP1    | TLCMC4    | <ClockNumber2>    | 20       | 12/14/2022     |   Adtext           |HD 1080i 25fps  | TLCMFSRT5  | Talk Sport:Standard  |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number      | Duration | First Air Date | Subtitles Required | Format         | Title      | Destination                  |
| automated test info    | TLSIAR1    | TLSIBR1    | TLSIB1     | TLSIP1    | TLCMC4    | <ClockNumber3>    | 20       | 12/14/2022     |   Yes              |HD 1080i 25fps  | TLCMFSRT6  | Talk Sport:Standard  |
And complete order contains item with clock number '<ClockNumber1>' with following fields:
| Job Number  | PO Number |
| TLCMFSR14   | TLCMFSR14 |
And complete order contains item with clock number '<ClockNumber2>' with following fields:
| Job Number  | PO Number |
| TLCMFSR15   | TLCMFSR15 |
And complete order contains item with clock number '<ClockNumber3>' with following fields:
| Job Number  | PO Number |
| TLCMFSR16   | TLCMFSR16 |
And logged in with details of 'trafficManager'
And waited till order with clockNumber '<ClockNumber1>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber2>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber3>' will be available in Traffic
And waited till order with clockNumber '<ClockNumber1>' will have next status 'In Progress' in Traffic
And waited till order with clockNumber '<ClockNumber2>' will have next status 'In Progress' in Traffic
And waited till order with clockNumber '<ClockNumber3>' will have next status 'In Progress' in Traffic
And refreshed the page
And selected 'All' tab in Traffic UI
And I created tab with name '<TabName>' and type '<TabType>' and dataRange 'Today' and the following rules:
|  Condition  | Condition Type  |  Value  |
| Advertiser  |    Match  | TLSIAR1  |
And waited till order item list will be loaded in Traffic
And add comment '<Comment_1>' for '<ClockNumber1>' clock on traffic order send list
And add comment '<Comment_2>' for '<ClockNumber2>' clock on traffic order send list
And add comment '<Comment_3>' for '<ClockNumber3>' clock on traffic order send list
When I sort Order Items by field '<SortedBy>' in order '<SortingType>' from Order Level Send
And wait till order item list will be loaded in Traffic
Then I should see that order items are sorted by '<SortedBy>' field and '<SortingType>' in Clock Level Send


Examples:
| ClockNumber1 | ClockNumber2 | ClockNumber3 |  TabName    |  TabType            | Comment_1 | Comment_2  | Comment_3 |     SortedBy            |  SortingType  |
|   TLCMCN_1   |   TLCMCN_2   |    TLCMCN_3  |  SEND_AD_1  | Order Item (Send)   | AAAA      | !!!BBBB    | CCCC      |    Last Comment   |      asc      |

