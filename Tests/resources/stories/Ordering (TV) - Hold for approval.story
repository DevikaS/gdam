!--ORD-269
!--ORD-1077
Feature: Hold for approval
Narrative:
In order to:
As a AgencyAdmin
I want to check hold for approval

Scenario: create order that appears at live and held tabs
!--ordering/traffic integration - Activity Buffer.
Meta: @qaorderingsmoke
      @uatorderingsmoke
      @orderingcrossbrowser
Given I created the following agency:
| Name     | A4User        |
| OTVHFAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVHFAU1 | agency.user  | OTVHFAA1     |
And I am logged in as 'GlobalAdmin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVHFAA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVHFAAR1  | OTVHFABR1 | OTVHFASB1 | OTVHFAP1 |
And on the global 'common custom' metadata page for agency 'OTVHFAA1'
And clicked 'Sub Brand' button in 'Common Metadata' section on opened metadata page
And unchecked 'Hide' checkbox on opened string field Settings and Customization page
And saved metadata field settings
And confirmed opened popup on Settings and Customization page if it appears
And logged in with details of 'OTVHFAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | OTVHFAAR1  | OTVHFABR1 | OTVHFASB1 | OTVHFAP1 | OTVHFAC1 | OTVHFACN1    | 20       | 08/14/2022     | HD 1080i 25fps | OTVHFAT1 | Already Supplied   | GEO News:Standard |
And hold for approval 'tv' order items with following clock numbers 'OTVHFACN1'
And complete order contains item with clock number 'OTVHFACN1' with following fields:
| Job Number | PO Number |
| OTVHFAJN1  | OTVHFAPN1 |
When I go to View Live Orders tab of 'tv' order on ordering page
Then I should see TV order in 'live' order list with item clock number 'OTVHFACN1' and following fields:
| Order# | DateTime    | Advertiser | Market         | PO Number | Job #     | NoClocks | Status        |
| Digit  | CurrentTime | OTVHFAAR1  | United Kingdom | OTVHFAPN1 | OTVHFAJN1 | 1        | 0/1 Delivered |
And wait for '300' seconds
When I select 'View Held Orders' tab on ordering page
Then I should see TV order in 'live' order list with item clock number 'OTVHFACN1' and following fields:
| Order# | DateTime    | Advertiser | Market         | PO Number | Job #     | NoClocks | Status        |
| Digit  | CurrentTime | OTVHFAAR1  | United Kingdom | OTVHFAPN1 | OTVHFAJN1 | 1        | 0/1 Delivered |

Scenario: Hold for approval button doesn't erase data from Add information section
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVHFAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVHFAU1 | agency.admin | OTVHFAA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVHFAA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVHFAAR1  | OTVHFABR2 | OTVHFASB2 | OTVHFAP2 |
And logged in with details of 'OTVHFAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVHFACN2    |
When I open order item with following clock number 'OTVHFACN2'
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Duration | First Air Date | Format         | Title    |
| automated test info    | OTVHFAAR1  | OTVHFABR2 | OTVHFASB2 | OTVHFAP2 | OTVHFAC2 | 20       | 12/14/2022     | HD 1080i 25fps | OTVHFAT2 |
And hold for approval active order item on cover flow
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Campaign | Clock Number | Duration | First Air Date | Format         | Product  | Title    |
| automated test info    | OTVHFAAR1  | OTVHFAC2 | OTVHFACN2    | 20       | 12/14/2022     | HD 1080i 25fps | OTVHFAP2 | OTVHFAT2 |

Scenario: Change from on hold to approved on order summary page
!--ORD-1288
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVHFAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVHFAU1 | agency.admin | OTVHFAA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVHFAA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVHFAAR1  | OTVHFABR3 | OTVHFASB3 | OTVHFAP3 |
And logged in with details of 'OTVHFAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign   | Clock Number | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination                 |
| automated test info    | OTVHFAAR1  | OTVHFABR3 | OTVHFASB3 | OTVHFAP3 | OTVHFAC3_1 | OTVHFACN3_1  | 20       | 12/14/2022     | HD 1080i 25fps | OTVHFAT3_1 | Already Supplied   | BSkyB Green Button:Standard |
| automated test info    | OTVHFAAR1  | OTVHFABR3 | OTVHFASB3 | OTVHFAP3 | OTVHFAC3_2 | OTVHFACN3_2  | 15       | 12/14/2024     | HD 1080i 25fps | OTVHFAT3_2 | Already Supplied   | Deepam TV:Standard          |
And hold for approval 'tv' order items with following clock numbers 'OTVHFACN3_1,OTVHFACN3_2'
And complete order contains item with clock number 'OTVHFACN3_1' with following fields:
| Job Number | PO Number |
| OTVHFAJN3  | OTVHFAPN3 |
And wait for finish place order with following item clock number 'OTVHFACN3_1' to A4
When I go to Order Summary page for order contains item with following clock number 'OTVHFACN3_1'
And approve order item with following clock number 'OTVHFACN3_1' on 'tv' order summary page
Then I should see clock delivery with following fields on 'tv' order summary page:
| Clock Number | Advertiser | Product  | Title      | First Air Date | Format         | Duration | Status        | Approve  |
| OTVHFACN3_1  | OTVHFAAR1  | OTVHFAP3 | OTVHFAT3_1 | 12/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered | Approved |
| OTVHFACN3_2  | OTVHFAAR1  | OTVHFAP3 | OTVHFAT3_2 | 12/14/2024     | HD 1080i 25fps | 15       | 0/1 Delivered | On hold  |

Scenario: Check that order disappears after approving from View Held Orders tab
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVHFAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVHFAU1 | agency.admin | OTVHFAA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVHFAA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVHFAAR1  | OTVHFABR4 | OTVHFASB4 | OTVHFAP4 |
And logged in with details of 'OTVHFAU1'
And create 'tv' order with market 'Republic of Ireland' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                |
| automated test info    | OTVHFAAR1  | OTVHFABR4 | OTVHFASB4 | OTVHFAP4 | OTVHFAC4 | OTVHFACN4    | 20       | 12/14/2022     | HD 1080i 25fps | OTVHFAT4 | Already Supplied   | Universal Ireland:Standard |
And hold for approval 'tv' order items with following clock numbers 'OTVHFACN4'
And complete order contains item with clock number 'OTVHFACN4' with following fields:
| Job Number | PO Number |
| OTVHFAJN4  | OTVHFAPN4 |
And waited for '5' seconds
And approve 'tv' order items with following clock numbers 'OTVHFACN4'
When I go to View Held Orders tab of 'tv' order on ordering page
And refresh the page without delay
Then I 'should not' see orders with following markets 'Republic of Ireland' in 'held' order list
When I select 'View Live Orders' tab on ordering page
Then I should see TV order in 'live' order list with item clock number 'OTVHFACN4' and following fields:
| Order# | DateTime    | Advertiser | Market              | PO Number | Job #     | NoClocks | Status        |
| Digit  | CurrentTime | OTVHFAAR1  | Republic of Ireland | OTVHFAPN4 | OTVHFAJN4 | 1        | 0/1 Delivered |

Scenario: Check that held orders can be approved on Live Orders tab without opening order details
!--ORD-5170
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVHFAA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVHFAU1 | agency.admin | OTVHFAA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVHFAA1':
| Advertiser | Brand     | Sub Brand | Product  |
| OTVHFAAR5  | OTVHFABR5 | OTVHFASB5 | OTVHFAP5 |
And logged in with details of 'OTVHFAU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | OTVHFAAR5  | OTVHFABR5 | OTVHFASB5 | OTVHFAP5 | OTVHFAC5 | OTVHFACN5    | 20       | 12/14/2022     | HD 1080i 25fps | OTVHFAT5 | Already Supplied   | BSkyB Green Button:Standard |
And hold for approval 'tv' order items with following clock numbers 'OTVHFACN5'
And complete order contains item with clock number 'OTVHFACN5' with following fields:
| Job Number | PO Number |
| OTVHFAJN5  | OTVHFAPN5 |
And waited for '5' seconds
And wait for finish place order with following item clock number 'OTVHFACN5' to A4
When I go to View Live Orders tab of 'tv' order on ordering page
And approve order item with following clock number 'OTVHFACN5' in 'tv' order list for 'live' order
Then I should see 'live' order in 'tv' order list contains clock number 'OTVHFACN5' and items with following fields:
| Clock Number | Advertiser | Product  | Title    | First Air Date | Format         | Duration | Status        | Approve  |
| OTVHFACN5    | OTVHFAAR5  | OTVHFAP5 | OTVHFAT5 | 12/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered | Approved |