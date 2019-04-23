!--ORD-1360
!--ORD-1653
Feature: Reintroduction and improvement of Additional Instructions on Destination List
Narrative:
In order to:
As a AgencyAdmin
I want to Check Additional Instructions on Destination List
!--Steps to enable field in a5 for commenting
!--Go to A4 central http://dev8/Central/Admin/SystemInformation/DestinationInfo.aspx
!--log: danielr@adstream.com.au.ua pass: 1
!--Search - Clubland destination from United Kingdom
!--Choose Comment in the Comment Type drop down
!--Press SAVE button and wait for
Scenario: Check that User can add the Additional Instructions
Meta: @qaorderingsmoke
      @uatorderingsmoke
Given I created the following agency:
| Name     | A4User        |
| OTVMAIA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMAIU1 | agency.admin | OTVMAIA1     |
And logged in with details of 'OTVMAIU1'
And create '<OrderType>' order with market 'United Kingdom' and items with following fields:
| Clock Number   | Destination      |
| <ClockNumber>  | Clubland:Standard |
When I open order item with following clock number '<ClockNumber>'
And fill for destination 'Clubland' following additional instruction '~!@#$%^&*()_<>?}{' on Select Broadcast Destinations form
And save as draft order
And I open order item with following clock number '<ClockNumber>'
Then I should see following additional instruction '~!@#$%^&*()_<>?}{' for destination 'Clubland' on Select Broadcast Destinations form

Examples:
| ClockNumber | OrderType |
| OTVMAICN1_1 | tv        |
| OTVMAICN1_2 | music     |

Scenario: Check Additional Instructions after Copy to all
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVMAIA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMAIU1 | agency.admin | OTVMAIA1     |
And logged in with details of 'OTVMAIU1'
And create '<OrderType>' order with market 'United Kingdom' and items with following fields:
| Clock Number        | Destination      |
| <FirstClockNumber>  | Clubland:Standard |
| <SecondClockNumber> |                  |
When I open order item with following clock number '<FirstClockNumber>'
And fill for destination 'Clubland' following additional instruction '~!@#$%^&*()_<>?}{' on Select Broadcast Destinations form
And copy data from 'Select Broadcast Destinations' section of order item page to all other items
And select order item with following clock number '<SecondClockNumber>' on cover flow
Then I should see following additional instruction '~!@#$%^&*()_<>?}{' for destination 'Clubland' on Select Broadcast Destinations form

Examples:
| FirstClockNumber | SecondClockNumber | OrderType  |
| OTVMAICN2_1      | OTVMAICN2_2       | tv         |
| OTVMAICN2_3      | OTVMAICN2_4       | music      |

Scenario: Check Additional Instructions after Copy to all with save as draft
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVMAIA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMAIU1 | agency.admin | OTVMAIA1     |
And logged in with details of 'OTVMAIU1'
And create '<OrderType>' order with market 'United Kingdom' and items with following fields:
| Clock Number        | Destination      |
| <FirstClockNumber>  | Clubland:Standard  |
| <SecondClockNumber> |                  |
When I open order item with following clock number '<FirstClockNumber>'
And fill for destination 'Clubland' following additional instruction 'qwerty' on Select Broadcast Destinations form
And save as draft order
And open order item with following clock number '<FirstClockNumber>'
And copy data from 'Select Broadcast Destinations' section of order item page to all other items
And select order item with following clock number '<SecondClockNumber>' on cover flow
Then I should see following additional instruction 'qwerty' for destination 'Clubland' on Select Broadcast Destinations form

Examples:
| FirstClockNumber | SecondClockNumber | OrderType  |
| OTVMAICN3_1      | OTVMAICN3_2       | tv         |
| OTVMAICN3_3      | OTVMAICN3_4       | music      |

Scenario: Check that Additional Instructions field becomes NonMandatory when Disabled in destination settings
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVMAIA2 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMAIU2 | agency.admin | OTVMAIA2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMAIA2':
| Advertiser  | Brand    | Sub Brand  | Product  |
| OARAACA3    | OBRAACA3 | OSBAACA3   | OPRAACA3 |
When I login with details of 'OTVMAIU2'
And created '<OrderType>' order with market 'India' and items with following fields:
| Clock Number   | Destination      |Advertiser  | Brand       | Sub Brand   | Product     | Duration | First Air Date | Format         | Title      | Subtitles Required|
| <ClockNumber>  | <Destination>    | OARAACA3   | OBRAACA3    | OSBAACA3    | OPRAACA3    |20        | 08/14/2022     | HD 1080i 25fps | OTVMASST42 | None               |
And I open order item with following clock number '<ClockNumber>'
Then I '<condition>' see additional instruction for destination '<Destn>' on Select Broadcast Destinations form is visible
And should see '<state>' Proceed button on order item page
When I click Proceed button on order item page
And confirm order on Order Proceed page
Then I should see count orders '<Count>' on 'View Live Orders' tab in order slider

Examples:
| ClockNumber | OrderType |Destination       |condition     |state    |Destn   |Count|
| OTVMAICN1_4 | tv        |Hackerz:Standard  |shouldnot     |enabled  |Hackerz |1    |

Scenario: Check that Additional Instructions field becomes optional when Enabled but optiona in destination settings for Beam
Meta: @ordering
@orderingemails
Given I created the following agency:
| Name     | A4User        | Labels |
| OTVMAIA3 | DefaultA4User | Beam   |
And created users with following fields:
| Email    | Role         | AgencyUnique |Language |
| OTVMAIU3 | agency.admin | OTVMAIA3     |en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMAIA3':
| Advertiser  | Brand    | Sub Brand  | Product  |
| OARAACA4    | OBRAACA4 | OSBAACA4   | OPRAACA4 |
When I login with details of 'OTVMAIU3'
And created '<OrderType>' order with market 'India' and items with following fields:
| Clock Number   | Destination      |Advertiser  | Brand       | Sub Brand   | Product     | Duration | First Air Date | Format         | Title      | Subtitles Required|
| <ClockNumber>  | <Destination>    |OARAACA4    | OBRAACA4    | OSBAACA4    | OPRAACA4    |20        | 08/14/2022     | HD 1080i 25fps | OTVMASST42 |    Adtext         |
And added for 'tv' order to item with clock number '<ClockNumber>' a New Master with following fields:
| Supply Via | Post House | Assignee  | Already Supplied | Message          | Deadline Date |
| nVerge     | NURU4      | OTVMAIU3  | should           | automated test 1 | 12/14/2022    |
And uploaded to 'tv' order item with clock number '<ClockNumber>' following documents:
| Document          |
| /files/file_2.txt |
When I open order item with following clock number '<ClockNumber>'
Then I '<condition>' see additional instruction for destination '<Destn>' on Select Broadcast Destinations form is visible
When I '<AddlnIns>' for destination '<Destn>' following additional instruction '<addIns>' on Select Broadcast Destinations form
Then should see '<state>' Proceed button on order item page
When I click Proceed button on order item page
And confirm order on Order Proceed page
And wait for '20' seconds
Then I 'should' see email notification for 'Order Confirmation' with field to 'OTVMAIU3' and subject 'Confirmation - Order' contains following attributes:
| Account Type | UserName | Clock Number   | Job Number | PO Number   | Order Items Count | Commercial Number | Country        | Spot Code     | Advertiser  | Brand       | Sub Brand   | Product     | Title      | Duration | Format         | Delivery Method | Deadline Date | Time Arrived | Master Held At | First Air Date | Archive |   Note      | Attachments | Delivery Points | Destination Group | Destination         | Service Level | Additional Instruction|
| beam         | OTVMAIU3 | <ClockNumber>  |            |             |1                  | 1                 | India          | <ClockNumber> | OARAACA4    | OBRAACA4    | OSBAACA4    | OPRAACA4    | OTVMASST42 | 20       | HD 1080i 25fps |                 |               |              |                | 08/14/2022     | No      |             |  file_2.txt | 1               |                   |  <Destn>            | Standard      |  <addIns>             |


Examples:
|ClockNumber	|OrderType	|Destination	|condition	|state	|Destn	|AddlnIns	|addIns	|
|OTVMAICN1_2	|tv	|Terrain:Standard	|should	|enabled	|Terrain	|fill	|test info	|
|OTVMAICN1_5	|tv	|Terrain:Standard	|should	|enabled	|Terrain	|skip	|	|


Scenario: Check that Additional Instructions field becomes optional when Enabled but optional in destination settings
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVMAIA5 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |Language |
| OTVMAIU5 | agency.admin | OTVMAIA5     |en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMAIA5':
| Advertiser  | Brand    | Sub Brand  | Product  |
| OARAACA5    | OBRAACA5 | OSBAACA5   | OPRAACA5 |
And logged in with details of 'OTVMAIU5'
When I created '<OrderType>' order with market 'India' and items with following fields:
| Additional Information | Clock Number   | Destination      |Advertiser  | Brand       | Sub Brand   | Product     | Duration | First Air Date | Format         | Title      | Subtitles Required|
| automated test info    | <ClockNumber>  | <Destination>    |OARAACA5    | OBRAACA5    | OSBAACA5    | OPRAACA5    |20        | 08/14/2022     | HD 1080i 25fps | OTVMASST42 |    Adtext         |
And open order item with following clock number '<ClockNumber>'
Then I '<condition>' see additional instruction for destination '<Destn>' on Select Broadcast Destinations form is visible
When I '<AddlnIns>' for destination '<Destn>' following additional instruction '<addIns>' on Select Broadcast Destinations form
And click Proceed button on order item page
Then I should see following data for order items on View 'Adstream' Delivery Report page:
| Clock Number | Job Number | PO Number | Order Items Count | Commercial Number | Country  | Advertiser | Brand      | Sub Brand  | Product    | Title       | Duration | Format         | Delivery Method | Deadline Date | First Air Date | Archive | Note               | Delivery Points |Destination Group | Destination | Service Level | Instructions |
| OTVMAICN1_2 |            |           | 1                 | 1                 | India     | OARAACA5   | OBRAACA5   | OSBAACA5   | OPRAACA5   | OTVMASST42 | 20       | HD 1080i 25fps |                 |               | 08/14/2022     | No      | automated test info | 1               | 9X Media3        | Terrain     | Standard      | <addIns>   |

Examples:
| ClockNumber | OrderType |Destination       |condition     |state    |Destn   |AddlnIns |addIns   |
| OTVMAICN1_2 | tv        |Terrain:Standard  |should        |enabled  |Terrain |fill     |test info|
| OTVMAICN1_5 | tv        |Terrain:Standard  |should        |enabled  |Terrain |skip     |         |


Scenario: Check that Additional Instructions field becomes mandatory when Enabled and required in destination settings
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVMAIA4 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVMAIU4 | agency.admin | OTVMAIA4     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVMAIA4':
| Advertiser  | Brand    | Sub Brand  | Product  |
| OARAACA5    | OBRAACA5 | OSBAACA5   | OPRAACA5 |
When I login with details of 'OTVMAIU4'
And created '<OrderType>' order with market 'India' and items with following fields:
| Clock Number   | Destination      |Advertiser  | Brand       | Sub Brand   | Product     | Duration | First Air Date | Format         | Title      | Subtitles Required|
| <ClockNumber>  |     |OARAACA5    | OBRAACA5    | OSBAACA5    | OPRAACA5    |20        | 08/14/2022     | HD 1080i 25fps | OTVMASST42 | None               |
And I open order item with following clock number '<ClockNumber>'
And fill Search Stations field by value 'Valley' for Select Broadcast Destinations form on order item page
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard            |
| Valley |
And I click active Proceed button on order item page
Then I 'should not' see Order Proceed page
When I '<AddlnIns>' for destination '<Destn>' following additional instruction '<addIns>' on Select Broadcast Destinations form
Then should see '<afterState>' Proceed button on order item page
When I click Proceed button on order item page
And confirm order on Order Proceed page
Then I should see count orders '<Count>' on 'View Live Orders' tab in order slider

Examples:
| ClockNumber | OrderType |Destination       |condition     |beforestate    |Destn   |Count|afterState|AddlnIns |addIns   |
| OTVMAICN1_3 | tv        |Valley:Standard   |should        |disabled       |Valley  | 1   |enabled   |fill     |~!@#$%^&*()_<>?}{|
