!--ORD-3152
!--ORD-3304
Feature: Market specific fields for Disney Pan Nordic
Narrative:
In order to:
As a AgencyAdmin
I want to check a correct market specific fields for Disney Pan Nordic

Scenario: check saving as draft order with Disney Pan Nordic market
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MSFDPNA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSFDPNU1 | agency.admin | MSFDPNA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSFDPNA1':
| Advertiser | Brand     | Sub Brand | Product   |
| ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 |
And logged in with details of 'MSFDPNU1'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And select following market 'Disney Pan Nordic' on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Title    | Duration | First Air Date | Format         | Disney Code       |
| automated test info    | ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 | MSFDPNC1 | MSFDPNCN1    | MSFDPNT1 | 20       | 12/14/2022     | HD 1080i 25fps | DTV1234_AUTO(vs1) |
And save as draft order
And open order item with following clock number 'MSFDPNCN1'
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Title    | Duration | First Air Date | Format         | Disney Code       |
| automated test info    | ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 | MSFDPNC1 | MSFDPNCN1    | MSFDPNT1 | 20       | 12/14/2022     | HD 1080i 25fps | DTV1234_AUTO(vs1) |

Scenario: check confirming order with Disney Pan Nordic market
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MSFDPNA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSFDPNU1 | agency.admin | MSFDPNA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSFDPNA1':
| Advertiser | Brand     | Sub Brand | Product   |
| ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 |
And logged in with details of 'MSFDPNU1'
And create 'tv' order with market 'Disney Pan Nordic' and items with following fields:
| Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Title    | Duration | First Air Date | Format         | Disney Code       |
| ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 | MSFDPNC2 | MSFDPNCN2    | MSFDPNT2 | 20       | 12/14/2022     | HD 1080i 25fps | DTV1234_AUTO(vs2) | Disney:Standard |
When I open order item with following clock number 'MSFDPNCN2'
And fill following fields for Add information form on order item page:
| Additional Information |
| automated test info    |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard                   |
| Disney Denmark Sponsorship - Please |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| MSFDPNJN2  | MSFDPNPN2 |
And confirm order on Order Proceed page
When I go to View Live Orders tab of 'tv' order on ordering page
Then I should see TV order in 'live' order list with item clock number 'MSFDPNCN2' and following fields:
| Order# | DateTime    | Advertiser | Brand     | Sub Brand | Product   | Market            | PO Number | Job #     | NoClocks | Status        |
| Digit  | CurrentTime | ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 | Disney Pan Nordic | MSFDPNPN2 | MSFDPNJN2 | 1        | 0/1 Delivered |
And should see 'live' order in 'tv' order list contains clock number 'MSFDPNCN2' and items with following fields:
| Clock Number | Advertiser | Product   | Title    | First Air Date | Format         | Duration | Status        |
| MSFDPNCN2    | ARMSFDPN1  | PRMSFDPN1 | MSFDPNT2 | 12/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |

Scenario: check Copy Code value on cover flow
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MSFDPNA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSFDPNU1 | agency.admin | MSFDPNA1     |
And logged in with details of 'MSFDPNU1'
And create 'tv' order with market 'Disney Pan Nordic' and items with following fields:
| Title    |
| MSFDPNT3 |
When I open order item with next title 'MSFDPNT3'
And fill following fields for Add information form on order item page:
| Clock Number | Campaign |
| MSFDPNCN3    | MSFDPNC3 |
Then I should see for active order item on cover flow following data:
| Clock Number | Title    |
| MSFDPNCN3    | MSFDPNT3 |

Scenario: check saving as draft order in draft order list with Disney Pan Nordic market
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MSFDPNA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSFDPNU1 | agency.admin | MSFDPNA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSFDPNA1':
| Advertiser | Brand     | Sub Brand | Product   |
| ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 |
And logged in with details of 'MSFDPNU1'
And create 'tv' order with market 'Disney Pan Nordic' and items with following fields:
| Clock Number |
| MSFDPNCN4    |
When I open order item with following clock number 'MSFDPNCN4'
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Title    | Duration | First Air Date | Format         | Disney Code       |
| automated test info    | ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 | MSFDPNC4 | MSFDPNT4 | 20       | 12/14/2022     | HD 1080i 25fps | DTV1234_AUTO(vs4) |
And save as draft order
Then I should see TV order in 'draft' order list with item clock number 'MSFDPNCN4' and following fields:
| Order# | DateTime    | Advertiser | Brand     | Sub Brand | Product   | Market            | NoClocks | Creator  | Owner    |
| Digit  | CurrentTime | ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 | Disney Pan Nordic | 1        | MSFDPNU1 | MSFDPNU1 |
And should see 'draft' order in 'tv' order list contains items with following fields:
| Clock Number | Advertiser | Product   | Title    | First Air Date | Format         | Duration |
| MSFDPNCN4    | ARMSFDPN1  | PRMSFDPN1 | MSFDPNT4 | 12/14/2022     | HD 1080i 25fps | 20       |

Scenario: check data on the Order Summary page for order with Disney Pan Nordic market
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MSFDPNA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSFDPNU1 | agency.admin | MSFDPNA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSFDPNA1':
| Advertiser | Brand     | Sub Brand | Product   |
| ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 |
And logged in with details of 'MSFDPNU1'
And create 'tv' order with market 'Disney Pan Nordic' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Title    | Duration | First Air Date | Format         | Disney Code       |
| automated test info    | ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 | MSFDPNC5 | MSFDPNCN5    | MSFDPNT5 | 20       | 12/14/2022     | HD 1080i 25fps | DTV1234_AUTO(vs5) |
When I open order item with following clock number 'MSFDPNCN5'
And fill following fields for Add information form on order item page:
| Additional Information |
| automated test info    |
And fill Search Stations field by value 'Disney Denmark Sponsorship' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard                   |
| Disney Denmark Sponsorship - Please |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| MSFDPNJN5  | MSFDPNPN5 |
And confirm order on Order Proceed page
When I go to Order Summary page for order contains item with following clock number 'MSFDPNCN5'
Then I should see clock delivery with following fields on 'tv' order summary page:
| Clock Number | Advertiser | Brand     | Sub Brand | Product   | Title    | First Air Date | Format         | Duration | Status        | Approve |
| MSFDPNCN5    | ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 | MSFDPNT5 | 12/14/2022     | HD 1080i 25fps | 20       | 0/1 Delivered |         |
And should see clock delivery 'MSFDPNCN5' contains destinations with following fields on 'tv' order summary page:
| Destination                                                               | Status       | Time of Delivery | Priority |
| Disney Denmark Sponsorship - Please ensure you have added the Disney Code | Order Placed | -                | Standard |

Scenario: check data on the View Media Details page for order with Disney Pan Nordic market
Meta: @ordering

Given I created the following agency:
| Name     | A4User        |
| MSFDPNA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSFDPNU1 | agency.admin | MSFDPNA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSFDPNA1':
| Advertiser | Brand     | Sub Brand | Product   |
| ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 |
And logged in with details of 'MSFDPNU1'
And create 'tv' order with market 'Disney Pan Nordic' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Title    | Duration | First Air Date | Format         | Disney Code       |
| automated test info    | ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 | MSFDPNC6 | MSFDPNCN6    | MSFDPNT6 | 20       | 12/14/2022     | HD 1080i 25fps | DTV1234_AUTO(vs6) |
When I open order item with following clock number 'MSFDPNCN6'
And fill following fields for Add information form on order item page:
| Additional Information |
| automated test info    |
And fill Search Stations field by value 'Disney Denmark Sponsorship' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard                   |
| Disney Denmark Sponsorship - Please |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| MSFDPNJN6  | MSFDPNPN6 |
And confirm order on Order Proceed page
When I go to View Media Details page for order contains item with following clock number 'MSFDPNCN6'
Then I should see following media information on View Media Details page:
| Clock Number | Advertiser | Brand     | Sub Brand | Product   | Title    | Duration | First Air Date | Additional Details  | Video Format                                | Aspect Ratio | Video Standard |
| MSFDPNCN6    | ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 | MSFDPNT6 | 20       | 12/14/2022     | automated test info | Broadcast SD PAL 16x9 Program Stream master | 16x9         | 720x576i@25fps |
And should see destination delivered for order contains item with clock number 'MSFDPNCN6' with following fields:
| Order # | Destination                                                               | Date Ordered  | Ordered by | Status       |
| Digit   | Disney Denmark Sponsorship - Please ensure you have added the Disney Code | DateSubmitted | MSFDPNU1   | Order Placed |



Scenario: check working Auto code generating for order with Disney Pan Nordic market
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MSFDPNA7 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSFDPNU7 | agency.admin | MSFDPNA7     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSFDPNA7':
| Advertiser | Brand     | Sub Brand | Product   |
| ARMSFDPN7  | BRMSFDPN7 | SBMSFDPN7 | PRMSFDPN7 |
And update custom code 'Clock number' of schema 'video' agency 'MSFDPNA7' by following fields:
| Name      | Sequential Number | Free Text | Metadata Elements                                             | Enabled |
| MSFDPNCC7 | 8                 | /;-       | Advertiser:3,Brand:2,Sub Brand:2,Product:3,Duration:2,Title:3 | should  |
And logged in with details of 'MSFDPNU7'
And create 'tv' order with market 'Disney Pan Nordic' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Title    | Duration |
| automated test info    | ARMSFDPN7  | BRMSFDPN7 | SBMSFDPN7 | PRMSFDPN7 | TMSFDPN7 | 20       |
When I open order item with next title 'TMSFDPN7'
And generate 'auto code' value for Add information form on order item page
Then I should see following auto generated code '\d{2,8}/-ARMBRSBPRM20TMS' for field 'Clock Number' on Add information form of order item page

Scenario: check Copy current action for order with Disney Pan Nordic market
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MSFDPNA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSFDPNU1 | agency.admin | MSFDPNA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSFDPNA1':
| Advertiser | Brand     | Sub Brand | Product   |
| ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 |
And logged in with details of 'MSFDPNU1'
And create 'tv' order with market 'Disney Pan Nordic' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Title    | Duration | First Air Date | Format         | Disney Code       |
| automated test info    | ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 | MSFDPNC8 | MSFDPNCN8    | MSFDPNT8 | 20       | 12/14/2022     | HD 1080i 25fps | DTV1234_AUTO(vs8) |
When I open order item with following clock number 'MSFDPNCN8'
And 'copy current' order item by Add Commercial button on order item page
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Title    | Duration | First Air Date | Format         | Disney Code       |
| automated test info    | ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 | MSFDPNC8 | MSFDPNCN8    | MSFDPNT8 | 20       | 12/14/2022     | HD 1080i 25fps | DTV1234_AUTO(vs8) |

Scenario: check Copy To All action for order with Disney Pan Nordic market
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MSFDPNA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSFDPNU1 | agency.admin | MSFDPNA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSFDPNA1':
| Advertiser | Brand     | Sub Brand | Product   |
| ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 |
And logged in with details of 'MSFDPNU1'
And create 'tv' order with market 'Disney Pan Nordic' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign   | Clock Number | Title      | Duration | First Air Date | Format         | Disney Code         |
| automated test info    | ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 | MSFDPNC9_1 | MSFDPNCN9_1  | MSFDPNT9_1 | 20       | 12/14/2022     | HD 1080i 25fps | DTV1234_AUTO(vs9_1) |
|                        |            |           |           |           |            | MSFDPNCN9_2  |            |          |                |                |                     |
When I open order item with following clock number 'MSFDPNCN9_1'
And copy data from 'Add information' section of order item page to all other items
And select '2' order item with following clock number 'MSFDPNCN9_1' on cover flow
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign   | Clock Number | Title      | Duration | First Air Date | Format         | Disney Code         |
| automated test info    | ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 | MSFDPNC9_1 | MSFDPNCN9_1  | MSFDPNT9_1 | 20       | 12/14/2022     | HD 1080i 25fps | DTV1234_AUTO(vs9_1) |

Scenario: check Clear section action for order with Disney Pan Nordic market
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MSFDPNA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSFDPNU1 | agency.admin | MSFDPNA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSFDPNA1':
| Advertiser | Brand     | Sub Brand | Product   |
| ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 |
And logged in with details of 'MSFDPNU1'
And create 'tv' order with market 'Disney Pan Nordic' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign  | Clock Number | Title     | Duration | First Air Date | Format         | Disney Code        |
| automated test info    | ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 | MSFDPNC10 | MSFDPNCN10   | MSFDPNT10 | 20       | 12/14/2022     | HD 1080i 25fps | DTV1234_AUTO(vs10) |
When I open order item with following clock number 'MSFDPNCN10'
And clear 'Add information' section on order item page
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand | Sub Brand | Product | Campaign | Clock Number | Title | Duration | First Air Date | Format | Disney Code |
|                        |            |       |           |         |          |              |       |          |                |        |             |

Scenario: check saving data after proceed order with Disney Pan Nordic market and back to order creation page
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MSFDPNA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSFDPNU1 | agency.admin | MSFDPNA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSFDPNA1':
| Advertiser | Brand     | Sub Brand | Product   |
| ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 |
And logged in with details of 'MSFDPNU1'
And create 'tv' order with market 'Disney Pan Nordic' and items with following fields:
| Title     |
| MSFDPNT11 |
When I open order item with next title 'MSFDPNT11'
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign  | Clock Number | Duration | First Air Date | Format         | Disney Code        |
| automated test info    | ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 | MSFDPNC11 | MSFDPNCN11   | 20       | 12/14/2022     | HD 1080i 25fps | DTV1234_AUTO(vs11) |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard                   |
| Disney Denmark Sponsorship - Please |
And click Proceed button on order item page
And back to order item page from Order Proceed page
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign  | Clock Number | Title     | Duration | First Air Date | Format         | Disney Code        |
| automated test info    | ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 | MSFDPNC11 | MSFDPNCN11   | MSFDPNT11 | 20       | 12/14/2022     | HD 1080i 25fps | DTV1234_AUTO(vs11) |

Scenario: check validation of Disney Code and Copy Code fields for order with Disney Pan Nordic market
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MSFDPNA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSFDPNU1 | agency.admin | MSFDPNA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSFDPNA1':
| Advertiser | Brand     | Sub Brand | Product   |
| ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 |
And logged in with details of 'MSFDPNU1'
And create 'tv' order with market 'Disney Pan Nordic' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign  | Title     | Duration | First Air Date | Format         |
| automated test info    | ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 | MSFDPNC12 | MSFDPNT12 | 20       | 12/14/2022     | HD 1080i 25fps |
When I open order item with next title 'MSFDPNT12'
And fill following fields for Add information form on order item page:
| Additional Information |
| automated test info    |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard                   |
| Disney Denmark Sponsorship - Please |
And click active Proceed button on order item page
Then I 'should' see that following fields 'Clock Number,Disney Code' are required for order item on Add information form

Scenario: check transfering for order with Disney Pan Nordic market
Meta: @ordering
Given I created the following agency:
| Name        | A4User        |
| MSFDPNA13_1 | DefaultA4User |
| MSFDPNA13_2 | DefaultA4User |
And added agency 'MSFDPNA13_2' as a partner to agency 'MSFDPNA13_1'
And created users with following fields:
| Email       | Role         | AgencyUnique |
| MSFDPNU13_1 | agency.admin | MSFDPNA13_1  |
| MSFDPNU13_2 | agency.user  | MSFDPNA13_2  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSFDPNA13_1':
| Advertiser | Brand      | Sub Brand  | Product    |
| ARMSFDPN13 | BRMSFDPN13 | SBMSFDPN13 | PRMSFDPN13 |
And logged in with details of 'MSFDPNU13_1'
And create 'tv' order with market 'Disney Pan Nordic' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Title     | Duration | First Air Date | Format         | Disney Code        |
| automated test info    | ARMSFDPN13 | BRMSFDPN13 | SBMSFDPN13 | PRMSFDPN13 | MSFDPNC13 | MSFDPNCN13   | MSFDPNT13 | 20       | 12/14/2022     | HD 1080i 25fps | DTV1234_AUTO(vs13) |
And transfered order contains item with clock number 'MSFDPNCN13' to user 'MSFDPNU13_2' with following message 'autotest transfer message'
And logged in with details of 'MSFDPNU13_2'
When I open order item with following clock number 'MSFDPNCN13'
Then I should see following data for order item on Add information form:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Title     | Duration | First Air Date | Format         | Disney Code        |
| automated test info    | ARMSFDPN13 | BRMSFDPN13 | SBMSFDPN13 | PRMSFDPN13 | MSFDPNC13 | MSFDPNCN13   | MSFDPNT13 | 20       | 12/14/2022     | HD 1080i 25fps | DTV1234_AUTO(vs13) |

Scenario: check data for assignee after tranfering order with Disney Pan Nordic market
Meta: @ordering
Given I created the following agency:
| Name        | A4User        |
| MSFDPNA13_1 | DefaultA4User |
| MSFDPNA13_2 | DefaultA4User |
And added agency 'MSFDPNA13_2' as a partner to agency 'MSFDPNA13_1'
And created users with following fields:
| Email       | Role         | AgencyUnique |
| MSFDPNU13_1 | agency.admin | MSFDPNA13_1  |
| MSFDPNU13_2 | agency.admin | MSFDPNA13_2  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSFDPNA13_1':
| Advertiser | Brand      | Sub Brand  | Product    |
| ARMSFDPN13 | BRMSFDPN13 | SBMSFDPN13 | PRMSFDPN13 |
And logged in with details of 'MSFDPNU13_1'
And create 'tv' order with market 'Disney Pan Nordic' and items with following fields:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Title     | Duration | First Air Date | Format         | Disney Code        |
| automated test info    | ARMSFDPN13 | BRMSFDPN13 | SBMSFDPN13 | PRMSFDPN13 | MSFDPNC14 | MSFDPNCN14   | MSFDPNT14 | 20       | 12/14/2022     | HD 1080i 25fps | DTV1234_AUTO(vs14) |
And transfered order contains item with clock number 'MSFDPNCN14' to user 'MSFDPNU13_2' with following message 'autotest transfer message'
When I open order item with following clock number 'MSFDPNCN14'
Then I should see following read-only 'common' data for order item on Add information form:
| Additional Information | Advertiser | Brand      | Sub Brand  | Product    | Campaign  | Clock Number | Title     | Duration | First Air Date | Format         | Disney Code        |
| automated test info    | ARMSFDPN13 | BRMSFDPN13 | SBMSFDPN13 | PRMSFDPN13 | MSFDPNC14 | MSFDPNCN14   | MSFDPNT14 | 20       | 12/14/2022     | HD 1080i 25fps | DTV1234_AUTO(vs14) |

Scenario: check label for clock number after retriving assets from Library for order with Disney Pan Nordic market
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| MSFDPNA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| MSFDPNU1 | agency.admin | MSFDPNA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'MSFDPNA1':
| Advertiser | Brand     | Sub Brand | Product   |
| ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN1 |
And logged in with details of 'MSFDPNU1'
And create 'tv' order with market 'Disney Pan Nordic' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product    | Campaign  | Clock Number | Title     | Duration | First Air Date | Format         | Disney Code        |
| automated test info    | ARMSFDPN1  | BRMSFDPN1 | SBMSFDPN1 | PRMSFDPN15 | MSFDPNC15 | MSFDPNCN15_1 | MSFDPNT15 | 20       | 12/14/2022     | HD 1080i 25fps | DTV1234_AUTO(vs15) |
And create 'tv' order with market 'Disney Pan Nordic' and items with following fields:
| Clock Number |
| MSFDPNCN15_2 |
When I open order item with following clock number 'MSFDPNCN15_1'
And fill following fields for Add information form on order item page:
| Additional Information |
| automated test info    |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard                   |
| Disney Denmark Sponsorship - Please |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| MSFDPNJN15  | MSFDPNPN15 |
And confirm order on Order Proceed page
When I open order item with following clock number 'MSFDPNCN15_2'
And retrieve assets from library for order item at Add media to your order form
Then I should see for 'tv' order item at Add media to your order form following files metadata:
| Title     | Clock Number | Aspect Ratio | Clock Number Label |
| MSFDPNT15 | MSFDPNCN15_1 | 16:9         | Clock number            |