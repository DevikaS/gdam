!--NGN-16203
Feature: Global Admin can define Save in Library option behavior for BU
Narrative:
In order to: Validate Save In Library
As a GlobalAdmin
I want to check settings at BU level


Scenario: Check that when Default_Save_in_Library option set to TRUE at BU level then Adbank checkbox checked by default
Meta: @ordering
Given I created the following agency:
| Name      | A4User        | Save In Library | Allow To Save In Library |
| GADSILA01 | DefaultA4User | should          | should                   |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| GADSILU01 | agency.admin | GADSILA01    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GADSILA01':
| Advertiser | Brand    | Sub Brand | Product  |
| GADSILAR   | GADSILBR | GADSILBR  | GADSILPR |
And logged in with details of 'GADSILU01'
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination       |
| automated test info    | GADSILAR   | GADSILBR | GADSILBR  | GADSILPR | GADSILC  | GADSILCN1    | 20       | 10/14/2022     | HD 1080i 25fps | GADSILT | Adtext SD          | ABP News:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'GADSILCN1'
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Archive |
| GADSILCN1    | should  |


Scenario: Check that when Default_Save_in_Library option set to FALSE at BU level then Adbank checkbox unchecked by default
Meta: @ordering
Given I created the following agency:
| Name      | A4User        | Save In Library | Allow To Save In Library |
| GADSILA02 | DefaultA4User | should not      |                          |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| GADSILU02 | agency.admin | GADSILA02    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GADSILA02':
| Advertiser | Brand    | Sub Brand | Product  |
| GADSILAR   | GADSILBR | GADSILBR  | GADSILPR |
And logged in with details of 'GADSILU02'
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination       |
| automated test info    | GADSILAR   | GADSILBR | GADSILBR  | GADSILPR | GADSILC  | GADSILCN2    | 20       | 10/14/2022     | HD 1080i 25fps | GADSILT | Adtext SD          | ABP News:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'GADSILCN2'
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Archive   |
| GADSILCN2    | should not|


Scenario: Check user can overwrite (check/uncheck) BU setting at order level when Allow_User_to_Change_Save_in_Library option set to TRUE
Meta: @ordering
Given I created the following agency:
| Name      | A4User        | Save In Library | Allow To Save In Library |
| GADSILA03 | DefaultA4User | should          | should                   |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| GADSILU03 | agency.admin | GADSILA03    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GADSILA03':
| Advertiser | Brand    | Sub Brand | Product  |
| GADSILAR   | GADSILBR | GADSILBR  | GADSILPR |
And logged in with details of 'GADSILU03'
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number  | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination       |
| automated test info    | GADSILAR   | GADSILBR | GADSILBR  | GADSILPR | GADSILC  | <ClockNumber> | 20       | 10/14/2022     | HD 1080i 25fps | GADSILT | Adtext SD          | ABP News:Standard |
When I go to Order Proceed page for order contains order item with following clock number '<ClockNumber>'
And '<checkStateArchive>' checkbox Archive for following clock number '<ClockNumber>' of QC View summary on Order Proceed page
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number  | Archive          |
| <ClockNumber> | <ArchiveChecked> |

Examples:
| ClockNumber | checkStateArchive | ArchiveChecked |
| GADSILCN3_1 | uncheck           | should not     |
| GADSILCN3_2 | check             | should         |


Scenario: Check that Adbank checkbox state restored to defaults when data on Order item is changed
Meta: @ordering
Given I created the following agency:
| Name      | A4User        | Save In Library | Allow To Save In Library |
| GADSILA04 | DefaultA4User | should          | should                   |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| GADSILU04 | agency.admin | GADSILA04    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GADSILA04':
| Advertiser | Brand    | Sub Brand | Product  |
| GADSILAR   | GADSILBR | GADSILBR  | GADSILPR |
And logged in with details of 'GADSILU04'
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination       |
| automated test info    | GADSILAR   | GADSILBR | GADSILBR  | GADSILPR | GADSILC  | GADSILCN4    | 20       | 10/14/2022     | HD 1080i 25fps | GADSILT | Adtext SD          | ABP News:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'GADSILCN4'
And back to order item page from Order Proceed page
And select following market 'Republic of Ireland' on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required |
| automated test info    | GADSILAR   | GADSILBR  | GADSILBR  | GADSILPR | GADSILC  | GADSILCN4    | 15       | 10/14/2022     | HD 1080i 25fps | GADSILT1 | Adtext SD          |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard          |
| Universal Ireland |
And click Proceed button on order item page
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Advertiser | Title    | Duration | Format      | Archive |
| GADSILCN4    | GADSILAR   | GADSILT1 | 15       | SD PAL 16x9 | should  |


Scenario: Check user can't overwrite BU setting at order level when Allow_User_to_Change_Save_in_Library option set to FALSE
Meta: @ordering
Given I created the following agency:
| Name      | A4User        | Save In Library | Allow To Save In Library |
| GADSILA05 | DefaultA4User | should          | should not               |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| GADSILU05 | agency.admin | GADSILA05    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GADSILA05':
| Advertiser | Brand    | Sub Brand | Product  |
| GADSILAR   | GADSILBR | GADSILBR  | GADSILPR |
And logged in with details of 'GADSILU05'
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number  | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination       |
| automated test info    | GADSILAR   | GADSILBR | GADSILBR  | GADSILPR | GADSILC  | GADSILCN5     | 20       | 10/14/2022     | HD 1080i 25fps | GADSILT | Adtext SD          | ABP News:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'GADSILCN5'
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Archive    | Editability Archive |
| GADSILCN5    | should     | should not          |


Scenario: Check user can't overwrite BU setting at order level when Allow_User_to_Change_Save_in_Library option set to FALSE, from BU Overview page (UI)
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| GADSILA06 | DefaultA4User |
And I updated agency 'GADSILA06' with following fields on agency overview page:
| FieldName                            | FieldValue |
| Default Save in Library              | true       |
| Allow User to Change Save in Library | false      |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| GADSILU06 | agency.admin | GADSILA06    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GADSILA06':
| Advertiser | Brand    | Sub Brand | Product  |
| GADSILAR   | GADSILBR | GADSILBR  | GADSILPR |
And logged in with details of 'GADSILU06'
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number  | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination       |
| automated test info    | GADSILAR   | GADSILBR | GADSILBR  | GADSILPR | GADSILC  | GADSILCN6     | 20       | 10/14/2022     | HD 1080i 25fps | GADSILT | Adtext SD          | ABP News:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'GADSILCN6'
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Archive    | Editability Archive |
| GADSILCN6    | should     | should not          |



Scenario: Check that archived assets are available to retrieve from Library
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| GADSILA09 | DefaultA4User |
And I updated agency 'GADSILA09' with following fields on agency overview page:
| FieldName                            | FieldValue |
| Default Save in Library              | true       |
| Allow User to Change Save in Library | true       |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| GADSILU09 | agency.admin | GADSILA09    |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GADSILA09':
| Advertiser | Brand    | Sub Brand | Product  |
| GADSILAR   | GADSILBR | GADSILBR  | GADSILPR |
And logged in with details of 'GADSILU09'
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number  | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination       |
| automated test info    | GADSILAR   | GADSILBR | GADSILBR  | GADSILPR | GADSILC  | GADSILCN9_1   | 20       | 10/14/2022     | HD 1080i 25fps | GADSILT9_1 | Adtext SD          | ABP News:Standard |
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number  | Duration | First Air Date | Format         | Title      | Subtitles Required | Destination       |
| automated test info    | GADSILAR   | GADSILBR | GADSILBR  | GADSILPR | GADSILC  | GADSILCN9_2   | 20       | 10/14/2022     | HD 1080i 25fps | GADSILT9_2 | Adtext SD          | ABP News:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| GADSILCN9_3  |
And complete order contains item with clock number 'GADSILCN9_1' with following fields:
| Job Number  | PO Number   |
| GADSILJN9_1 | GADSILPN9_1 |
And complete order contains item with clock number 'GADSILCN9_2' with following fields:
| Job Number  | PO Number   |
| GADSILJN9_2 | GADSILPN9_2 |
When I open order item with following clock number 'GADSILCN9_3'
Then I should see following 'Library' content counter notification '2 files found. Showing 1 - 2' for order item at Add media to your order form


Scenario: Check that when ordering on behalf, Default_Save_in_Library setting should be taken from Order's BU, not from user's BU
Meta: @ordering
Given I created the following agency:
| Name        | A4User        | Save In Library | Allow To Save In Library |
| GADSILA10_1 | DefaultA4User | should          | should                   |
| GADSILA10_2 | DefaultA4User | should not      | should not               |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| GADSILU10_1 | agency.admin | GADSILA10_1  |
| GADSILU10_2 | agency.admin | GADSILA10_2  |
And added agency 'GADSILA10_2' as a partner for agency 'GADSILA10_1' with following fields:
| Can Bill | Can View |
| should   | should   |
And added existing user 'GADSILU10_2' to agency 'GADSILA10_1' with role 'agency.admin'
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GADSILA10_1':
| Advertiser | Brand    | Sub Brand | Product  |
| GADSILAR   | GADSILBR | GADSILBR  | GADSILPR |
And logged in with details of 'GADSILU10_2'
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| GADSILCN10_2 |
When I open order item with following clock number 'GADSILCN10_2'
And edit following fields for Change BU on behalf of popup on order item page:
| On Behalf Of BU | Invoice On Behalf Of BU |
| GADSILA10_1     | GADSILA10_1             |
And select following market 'Republic of Ireland' on order item page
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required |
| automated test info    | GADSILAR   | GADSILBR  | GADSILBR  | GADSILPR | GADSILC  | GADSILCN10_1 | 15       | 10/14/2022     | HD 1080i 25fps | GADSILT1 | Adtext SD          |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard          |
| Universal Ireland |
And click Proceed button on order item page
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Archive    | Editability Archive |
| GADSILCN10_1 | should     | should              |


Scenario: Check changes made to Adbank checkbox are saved when order saved as drafts
Meta: @ordering
@obug
!--FAB-490
Given I created the following agency:
| Name       | A4User        | Save In Library | Allow To Save In Library |
| GADSILA011 | DefaultA4User | should          | should                   |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| GADSILU011 | agency.admin | GADSILA011   |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GADSILA011':
| Advertiser | Brand    | Sub Brand | Product  |
| GADSILAR   | GADSILBR | GADSILBR  | GADSILPR |
And logged in with details of 'GADSILU011'
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination       |
| automated test info    | GADSILAR   | GADSILBR | GADSILBR  | GADSILPR | GADSILC  | GADSILCN11   | 20       | 10/14/2022     | HD 1080i 25fps | GADSILT | Adtext SD          | ABP News:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'GADSILCN11'
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Archive    | Editability Archive |
| GADSILCN11   | should     | should              |
When 'uncheck' checkbox Archive for following clock number 'GADSILCN11' of QC View summary on Order Proceed page
And save as draft order on Order Proceed page
And I go to Order Proceed page for order contains order item with following clock number 'GADSILCN11'
Then I should see following QC View Summary info on Order Proceed page:
| Clock Number | Archive     | Editability Archive |
| GADSILCN11    | should not | should              |




Scenario: Check archived assets saved to library when Default_Save_in_Library option set to TRUE at BU level
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| GADSILA07 | DefaultA4User |
And I updated agency 'GADSILA07' with following fields on agency overview page:
| FieldName                            | FieldValue |
| Default Save in Library              | true       |
| Allow User to Change Save in Library | false      |
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| GADSILU07 | agency.admin | GADSILA07    |streamlined_library,library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GADSILA07':
| Advertiser | Brand    | Sub Brand | Product  |
| GADSILAR   | GADSILBR | GADSILBR  | GADSILPR |
And logged in with details of 'GADSILU07'
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number  | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination       |
| automated test info    | GADSILAR   | GADSILBR | GADSILBR  | GADSILPR | GADSILC  | GADSILCN7     | 20       | 10/14/2022     | HD 1080i 25fps | GADSILT7 | Adtext SD          | ABP News:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'GADSILCN7'
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| GADSILJN7  | GADSILPN7 |
And confirm order on Order Proceed page
And go to the Library page for collection 'My Assets'NEWLIB
And I refresh the page
Then I should see assets 'GADSILT7' count '1' in collection 'My Assets'NEWLIB


Scenario: Check assets which aren't archived not saved to library when Default_Save_in_Library option set to FALSE at BU level
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| GADSILA08 | DefaultA4User |
And I updated agency 'GADSILA08' with following fields on agency overview page:
| FieldName               | FieldValue |
| Default Save in Library | false      |
And created users with following fields:
| Email     | Role         | AgencyUnique |Access|
| GADSILU08 | agency.admin | GADSILA08    |streamlined_library,library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GADSILA08':
| Advertiser | Brand    | Sub Brand | Product  |
| GADSILAR   | GADSILBR | GADSILBR  | GADSILPR |
And logged in with details of 'GADSILU08'
And I create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number  | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination       |
| automated test info    | GADSILAR   | GADSILBR | GADSILBR  | GADSILPR | GADSILC  | GADSILCN8     | 20       | 10/14/2022     | HD 1080i 25fps | GADSILT8 | Adtext SD          | ABP News:Standard |
When I go to Order Proceed page for order contains order item with following clock number 'GADSILCN8'
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| GADSILJN8  | GADSILPN8 |
And confirm order on Order Proceed page
And go to the Library page for collection 'My Assets'NEWLIB
And I refresh the page
Then I should see assets 'GADSILT8' count '0' in collection 'My Assets'NEWLIB

Scenario: Check that SD and HD clones are saved in library when  an order is placed with SD and HD destinations
Meta: @ordering
Given I logged in as 'GlobalAdmin'
And I created the following agency:
| Name      | A4User        |Save In Library|Allow To Save In Library |Default Manage Conversion |Allow To Change Manage Conversion|
| GADSIL12  | DefaultA4User |should         |should not                   |    should                |    should |
And I created users with following fields:
| Email      |           Role            | AgencyUnique   |Access|
| GADSILU12  |       agency.admin        |   GADSIL12    |streamlined_library,library,ordering|
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'GADSIL12':
| Advertiser | Brand      | Sub Brand  | Product   |
| GADSILAR12     | GADSILBR12     | GADSILSB12     | GADSILSP12    |
And I logged in with details of 'GADSILU12'
And create 'tv' order with market 'Germany' and items with following fields:
| Additional Information | Advertiser    | Brand         | Sub Brand     | Product     | Campaign  | Clock Number    | Duration | First Air Date | Subtitles Required | Format         | Title      |Destination|Motivnummer|                                                                                                                  |
| automated test info    | GADSILAR12     | GADSILBR12    | GADSILSB12     | GADSILSP12    | GADSILC12    | GADSILCN12      | 20       | 12/14/2022     |  Already Supplied  |HD 1080i 25fps  | GADSILT12 |  Disney Germany SD:Standard;Disney Germany HD:Standard      |1|
When I open order item with following isrc code 'GADSILCN12'
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number    | PO Number |
| GADSILJN12    | GADSILPO12  |
And confirm order on Order Proceed page
And go to the Library page for collection 'My Assets'NEWLIB
Then I should see assets 'GADSILT12' count '2' in collection 'My Assets'NEWLIB


