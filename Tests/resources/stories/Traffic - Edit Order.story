Feature:    Traffic Edit Order
Narrative:
In order to
As a              AgencyAdmin
I want to check edit order feature

Scenario: Check that after enable Master Arrived, order item details will be changed (Master Arrived comment, Master Arrived Data, Status, Tape Number)
Meta: @traffic
!-- NIR-603
Given I created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand  | Product |
| TEOAdv1    | TEOBRD1 | TEOSBRD1   | TEOPRD1 |
And logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TEOAdv1 | TEOBRD1 | TEOSBRD1 | TEOPRD1 | TTVBTVSC1 |TEOTVSCN1_1 | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | Talk Sport:Standard |
And completed order contains item with clock number 'TEOTVSCN1_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And open Traffic Order List page
And wait till order with clockNumber 'TEOTVSCN1_1' will be available in Traffic
And wait till order with clockNumber 'TEOTVSCN1_1' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TEOTVSCN1_1' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TEOTVSCN1_1' in Traffic
And click master arrived button on Traffic Order Edit page
And fill the following fields on master arrived traffic pop up:
|  Date       | Time     | Tape number  | Comments        |
|  7/7/2015   | 11:30 AM | 545          | Automation Test |
And click proceed button on Traffic Order Edit page
And wait for '2' seconds
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And open Traffic Order List page
And refresh the page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TEOTVSCN1_1' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I 'should' see that OrderItem status was updated to value 'Media Received - Awaiting Ingestion' for order with ClockNumber 'TEOTVSCN1_1'
And should see order item with clockNumber 'TEOTVSCN1_1' in traffic order list that have following data:
| Tape number | Master Received Comment  | Master Received Date  |
| 545         | Automation Test          | 07/07/2015 11:30      |



Scenario: Check that TM can undo Master Arrived
Meta: @traffic
!-- NIR-603
Given logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TEOAdv1 | TEOBRD1 | TEOSBRD1 | TEOPRD1 | TTVBTVSC1 | TEOTVSCN0 | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | Talk Sport:Standard |
And completed order contains item with clock number 'TEOTVSCN0' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TEOTVSCN0' will be available in Traffic
And wait till order with clockNumber 'TEOTVSCN0' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TEOTVSCN0' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TEOTVSCN0' in Traffic
And click master arrived button on Traffic Order Edit page
And fill the following fields on master arrived traffic pop up:
| Tape number  | Comments        |
| 545          | Automation Test |
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait till order list will be loaded
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TEOTVSCN0' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TEOTVSCN0' in Traffic
And click undo master arrived button on Traffic Order Edit page
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait till order list will be loaded
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TEOTVSCN0' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I 'should' see that OrderItem status was updated to value 'New' for order with ClockNumber 'TEOTVSCN0'


Scenario: Check that after order editing in traffic, fields also should be changed in order list
Meta: @traffic
      @qatrafficsmoke
      @uattrafficsmoke
      @criticaltraffictests
      @trafficcrossbrowser
Given I am logged in as 'GlobalAdmin'
And on the global 'common editable' metadata page for agency 'DefaultAgency'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DefaultAgency':
| Advertiser | Brand   | Sub Brand | Product |
| TEOAdv2    | TEOBRD2 | TEOSBRD2  | TEOPRD2 |
And logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product   | Campaign  | Clave | Clock Number  | Duration | First Air Date| Watermarking Required | Subtitles Required  | Format         | Title     | Destination     |
| automated test info    | TEOAdv1 | TEOBRD1 | TEOSBRD1 | TEOPRD1 | TTVBTVSC1 |   1   | <ClockNumber> | 20       | 12/14/2022    | No                    | <Original Subtitle> |HD 1080i 25fps | TTVBTVST1  | Talk Sport:Standard |
And completed order contains item with clock number '<ClockNumber>' with following fields:
| Job Number    | PO Number   |
| <Job Number>  | <PO Number> |
And login with details of 'trafficManager'
And wait till order with clockNumber '<ClockNumber>' will be available in Traffic
And wait till order with clockNumber '<ClockNumber>' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait for '15' seconds
And refresh the page
And I Edit order item with following clock number '<ClockNumber>'
And edit order in traffic with the following fields:
| FieldName          | FieldValue  |
| Clock number       | <NewClock>  |
| Title              | ChangedName |
| Advertiser         | TEOAdv2     |
| Brand              | TEOBRD2     |
| Sub Brand          | TEOSBRD2    |
| Product            | TEOPRD2     |
| Subtitles Required | None        |
| Duration           | 22s         |
| First Air Date     |  12/16/2021 |
And click proceed button on Traffic Order Edit page
And fill following fields on Order Proceed page:
| Job Number         | PO Number        |
| <New Jb Number>   | <New Pb Number>  |
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria '<NewClock>' in simple search form on Traffic Order List page
Then I should see order with clockNumber '<NewClock>' in traffic list that have following data:
| Job Number         | PO Number        |
| <New Jb Number>   | <New Pb Number>  |
And expand all orders on Traffic Order List page
And I should see order item with clockNumber '<NewClock>' in traffic order list that have following data:
| Clock Number | Advertiser | Title       | Duration | First Air Date | Subtitles Required   |
| <NewClock>   | TEOAdv2    | ChangedName | 22s      | 12/16/2021     | <Subtitles Required> |

Examples:
| Subtitles Required | Original Subtitle | Job Number | PO Number | New Jb Number | New Pb Number | ClockNumber	 | NewClock	     |
| None	             | Already Supplied  | TT1BTVS11  | TT1BTVS12 | editedS11	  | editedS12	  | TEOTVSCN17_1 | TTVBTLT_test	 |
| Already Supplied	 | None	             |	          |	          | editedS21	  | editedS22	  | TEOTVSCN17_2 | TTVBTVT1_test |

Scenario: Check that after order editing in traffic, fields also should be changed in A5 library
Meta: @traffic
Given I logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination                 |
| automated test info    | TEOAdv1    | TEOBRD1 | TEOSBRD1  | TEOPRD1 | TTVBTVSC1 |TTVBTVSCN18_1 | 20       | 12/14/2022     |   Already Supplied |HD 1080i 25fps | TTVBTVST1 | Talk Sport:Standard |
And completed order contains item with clock number 'TTVBTVSCN18_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TTVBTVSCN18_1' will be available in Traffic
And wait till order with clockNumber 'TTVBTVSCN18_1' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And refresh the page
And I Edit order item with following clock number 'TTVBTVSCN18_1'
And edit order in traffic with the following fields:
| FieldName          | FieldValue  |
| Clock number       | TTVBT_test  |
| Title              | ChangedName |
| Advertiser         | TEOAdv2     |
| Brand              | TEOBRD2     |
| Sub Brand          | TEOSBRD2    |
| Product            | TEOPRD2     |
| Subtitles Required | None        |
| Duration           | 22          |
| First Air Date     |  12/16/2021 |
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And login with details of 'AgencyAdmin'
And I go to View Live Orders tab of 'tv' order on ordering page
Then I should see TV order in 'live' order list with item clock number 'TTVBT_test' and following fields:
| Clock Number | Advertiser | Brand   | Sub Brand | Title       | Duration | First Air Date | Subtitles Required |
| TTVBT_test   | TEOAdv2    | TEOBRD2 | TEOSBRD2  | ChangedName | 22       | 12/16/2021     | None               |


Scenario: Check that after adding additional destination, order details should be changed
Meta:@traffic
Given logged in with details of 'AgencyAdmin'
When created 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign  | Clock Number | Duration | First Air Date | Subtitles Required | Format         | Title     | Destination         |
| automated test info    | TEOAdv1    | TEOBRD1 | TEOSBRD1  | TEOPRD1 | TTVBTVSC1 | TBCCN1_1     | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | TTVBTVST1 | Talk Sport:Standard |
And completed order contains item with clock number 'TBCCN1_1' with following fields:
| Job Number  | PO Number |
| TTVBTVS11   | TTVBTVS11 |
And login with details of 'trafficManager'
And wait till order with clockNumber 'TBCCN1_1' will be available in Traffic
And wait till order with clockNumber 'TBCCN1_1' will have next status 'In Progress' in Traffic
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TBCCN1_1' in simple search form on Traffic Order List page
And open edit page for order with Clock Number 'TBCCN1_1' in Traffic
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard |
| AOL      |
And click proceed button on Traffic Order Edit page
And click confirm button on Traffic Order Summary page
And click done button on Traffic Order Summary page
And wait for '5' seconds
And open Traffic Order List page
And select 'All' tab in Traffic UI
And wait till order list will be loaded
And enter search criteria 'TBCCN1_1' in simple search form on Traffic Order List page
And expand all orders on Traffic Order List page
Then I 'should' see destinations 'AOL,Talk Sport' for order item in Traffic List with clockNumber 'TBCCN1_1'