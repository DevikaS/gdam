!--ORD-5305
!--ORD-5384
Feature: User can select Notification Group when placing New Master Order
Narrative:
In order to:
As a AgencyAdmin
I want to check that user can select Notification Group when placing New Master Order

Scenario: Check that Notification Groups can be selected in case to add New Master
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| UCSNGA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| UCSNGU1_1 | agency.admin | UCSNGA1      |
| UCSNGU1_2 | agency.admin | UCSNGA1      |
| UCSNGU1_3 | agency.admin | UCSNGA1      |
And logged in with details of 'UCSNGU1_1'
And added following users to address book:
| UserName  |
| UCSNGU1_1 |
| UCSNGU1_2 |
| UCSNGU1_3 |
And waited for '3' seconds
And added following users to team template 'UCSNGTT1':
| UserName  |
| UCSNGU1_1 |
| UCSNGU1_2 |
| UCSNGU1_3 |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| UCSNGCN1     |
When I open order item with following clock number 'UCSNGCN1'
And fill following fields for Select Group popup of New Master on Add media form:
| Search Groups | Group Name |
| UCSNGTT1      | should     |
And accept selection of specified notification group 'UCSNGTT1' on Select Group popup of New Master on Add media form
Then I should see following data on New Master form for order item that supply via '':
| Assignee                      | Already Supplied | Message | Deadline Date |
| UCSNGU1_1,UCSNGU1_2,UCSNGU1_3 | should not       |         |               |


Scenario: Check that user can send upload request from Order Summary to users group
Meta: @ordering
      @obug
!--FAB-319
Given I created the following agency:
| Name    | A4User        |
| UCSNGA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| UCSNGU1_1 | agency.admin | UCSNGA1      |
| UCSNGU1_2 | agency.admin | UCSNGA1      |
| UCSNGU1_3 | agency.admin | UCSNGA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'UCSNGA1':
| Advertiser | Brand    | Sub Brand | Product  |
| UCSNGAR2   | UCSNGBR2 | UCSNGSB2  | UCSNGPR2 |
And logged in with details of 'UCSNGU1_1'
And added following users to address book:
| UserName  |
| UCSNGU1_1 |
| UCSNGU1_2 |
| UCSNGU1_3 |
And waited for '3' seconds
And added following users to team template 'UCSNGTT1':
| UserName  |
| UCSNGU1_1 |
| UCSNGU1_2 |
| UCSNGU1_3 |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | UCSNGAR2   | UCSNGBR2 | UCSNGSB2  | UCSNGPR2 | UCSNGC2  | UCSNGCN2     | 20       | 10/14/2022     | HD 1080i 25fps | UCSNGT2 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'UCSNGCN2' with following fields:
| Job Number | PO Number |
| UCSNGJN2   | UCSNGPN2  |
And I am on Order Summary page for order contains item with following clock number 'UCSNGCN2'
When I fill following fields for Select Group popup of Assign someone to supply media form on order summary page:
| Search Groups | Group Name |
| UCSNGTT1      | should     |
And accept selection of specified notification group 'UCSNGTT1' on Select Group popup of Assign someone to supply media form on order summary page
And fill following fields for Assign someone to supply media form that supply via 'FTP' on order summary page:
| Message        |
| automated test |
And send order to supply media by someone on order summary page
Then I 'should not' see Assign someone to supply media form on order summary page

Scenario: Check that users included into selected Notification Group are rendered on page after selection this group
Meta: @ordering
      @obug
!--FAB-319
Given I created the following agency:
| Name    | A4User        |
| UCSNGA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| UCSNGU1_1 | agency.admin | UCSNGA1      |
| UCSNGU1_2 | agency.admin | UCSNGA1      |
| UCSNGU1_3 | agency.admin | UCSNGA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'UCSNGA1':
| Advertiser | Brand    | Sub Brand | Product  |
| UCSNGAR2   | UCSNGBR2 | UCSNGSB2  | UCSNGPR2 |
And logged in with details of 'UCSNGU1_1'
And added following users to address book:
| UserName  |
| UCSNGU1_1 |
| UCSNGU1_2 |
| UCSNGU1_3 |
And waited for '3' seconds
And added following users to team template 'UCSNGTT1':
| UserName  |
| UCSNGU1_1 |
| UCSNGU1_2 |
| UCSNGU1_3 |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | UCSNGAR2   | UCSNGBR2 | UCSNGSB2  | UCSNGPR2 | UCSNGC3  | UCSNGCN3     | 20       | 10/14/2022     | HD 1080i 25fps | UCSNGT3 | Already Supplied   | Aastha:Standard |
And complete order contains item with clock number 'UCSNGCN3' with following fields:
| Job Number | PO Number |
| UCSNGJN3   | UCSNGPN3  |
And I am on Order Summary page for order contains item with following clock number 'UCSNGCN3'
When I fill following fields for Select Group popup of Assign someone to supply media form on order summary page:
| Search Groups | Group Name |
| UCSNGTT1      | should     |
And accept selection of specified notification group 'UCSNGTT1' on Select Group popup of Assign someone to supply media form on order summary page
And fill following fields for Assign someone to supply media form that supply via 'FTP' on order summary page:
| Message        |
| automated test |
And send order to supply media by someone on order summary page
Then I should see for order contains item with clock number 'UCSNGCN3' following summary information on order summary page:
| Assigned To Supply Media      |
| UCSNGU1_1 UCSNGU1_2 UCSNGU1_3 |


Scenario: check default state of RemovePreviousAssignees checkbox on Assign someone to supply media popup
Meta: @ordering
      @obug
!--FAB-319
Given I created the following agency:
| Name     | A4User        |
| UCSNGUA4 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| UCSNGUU4_1 | agency.admin | UCSNGUA4     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'UCSNGUA4':
| Advertiser | Brand     | Sub Brand | Product   |
| UCSNGUAR1  | UCSNGUBR1 | UCSNGUSB1 | UCSNGUPR1 |
And logged in with details of 'UCSNGUU4_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | UCSNGUAR1  | UCSNGUBR1 | UCSNGUSB1 | UCSNGUPR1 | UCSNGUC1 | UCSNGUCN4    | 20       | 10/14/2022     | HD 1080i 25fps | UCSNGUT4 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'UCSNGUCN4' a New Master with following fields:
| Supply Via | Assignee   | Already Supplied | Message          | Deadline Date |
| FTP        | UCSNGUU4_1 | should not       | automated test 1 | 12/14/2022    |
And complete order contains item with clock number 'UCSNGUCN4' with following fields:
| Job Number | PO Number |
| UCSNGUJN4  | UCSNGUPN4 |
And I am on View Live Orders tab of 'tv' order on ordering page
When I go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'UCSNGUCN4' in 'live' order list
Then I 'should' see remove previous assignees checkbox ticked on Assign someone to supply media popup


Scenario: check previous users hasn't removed from assignees list when RemovePreviousAssignees checkbox not ticked on Assign someone to supply media popup
Meta: @ordering
      @obug
!--FAB-319
Given I created the following agency:
| Name     | A4User        |
| UCSNGUA5 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| UCSNGUU5_1 | agency.admin | UCSNGUA5     |
| UCSNGUU5_2 | agency.admin | UCSNGUA5     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'UCSNGUA5':
| Advertiser | Brand     | Sub Brand | Product   |
| UCSNGUAR1  | UCSNGUBR1 | UCSNGUSB1 | UCSNGUPR1 |
And logged in with details of 'UCSNGUU5_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | UCSNGUAR1  | UCSNGUBR1 | UCSNGUSB1 | UCSNGUPR1 | UCSNGUC1 | UCSNGUCN5    | 20       | 10/14/2022     | HD 1080i 25fps | UCSNGUT5 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'UCSNGUCN5' a New Master with following fields:
| Supply Via | Assignee   | Already Supplied | Message          | Deadline Date |
| FTP        | UCSNGUU5_1 | should not       | automated test 1 | 12/14/2022    |
And complete order contains item with clock number 'UCSNGUCN5' with following fields:
| Job Number | PO Number |
| UCSNGUJN5  | UCSNGUPN5 |
And I am on View Live Orders tab of 'tv' order on ordering page
When I go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'UCSNGUCN5' in 'live' order list
And 'uncheck' remove previous assignees checkbox on Assign someone to supply media popup
And fill following fields for Assign someone to supply media form that supply via 'FTP' on ordering page:
| Assignee   | Message        |
| UCSNGUU5_2 | automated test |
And send order to supply media by someone on ordering page
And select order with following item clock number 'UCSNGUCN5' in 'live' order list
Then I should see the previous assignee on supply media form on order list page:
| Previous Assignee     |
| UCSNGUU5_1,UCSNGUU5_2 |


Scenario: check previous user removed from assignees list when RemovePreviousAssignees checkbox ticked on Assign someone to supply media popup
Meta: @ordering
      @obug
!--FAB-319
Given I created the following agency:
| Name     | A4User        |
| UCSNGUA6 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| UCSNGUU6_1 | agency.admin | UCSNGUA6     |
| UCSNGUU6_2 | agency.admin | UCSNGUA6     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'UCSNGUA6':
| Advertiser | Brand     | Sub Brand | Product   |
| UCSNGUAR1  | UCSNGUBR1 | UCSNGUSB1 | UCSNGUPR1 |
And logged in with details of 'UCSNGUU6_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | UCSNGUAR1  | UCSNGUBR1 | UCSNGUSB1 | UCSNGUPR1 | UCSNGUC1 | UCSNGUCN6    | 20       | 10/14/2022     | HD 1080i 25fps | UCSNGUT6 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'UCSNGUCN6' a New Master with following fields:
| Supply Via | Assignee   | Already Supplied | Message          | Deadline Date |
| FTP        | UCSNGUU6_1 | should not       | automated test 1 | 12/14/2022    |
And complete order contains item with clock number 'UCSNGUCN6' with following fields:
| Job Number | PO Number |
| UCSNGUJN6  | UCSNGUPN6 |
And I am on View Live Orders tab of 'tv' order on ordering page
When I go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'UCSNGUCN6' in 'live' order list
And 'check' remove previous assignees checkbox on Assign someone to supply media popup
And fill following fields for Assign someone to supply media form that supply via 'FTP' on ordering page:
| Assignee   | Message        |
| UCSNGUU6_2 | automated test |
And send order to supply media by someone on ordering page
And select order with following item clock number 'UCSNGUCN6' in 'live' order list
Then I 'should' see the previous assignee on supply media form on order list page:
| Previous Assignee |
| UCSNGUU6_2        |
Then I 'should not' see the previous assignee on supply media form on order list page:
| Previous Assignee |
| UCSNGUU6_1        |


Scenario: check email notifications when previous user hasn't removed while adding new user on Assign someone to supply media popup
Meta: @ordering
      @obug
      @orderingemails
!--FAB-319
Given I created the following agency:
| Name     | A4User        |
| UCSNGUA7 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| UCSNGUU7_1 | agency.admin | UCSNGUA7     |
| UCSNGUU7_2 | agency.admin | UCSNGUA7     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'UCSNGUA7':
| Advertiser | Brand     | Sub Brand | Product   |
| UCSNGUAR1  | UCSNGUBR1 | UCSNGUSB1 | UCSNGUPR1 |
And logged in with details of 'UCSNGUU7_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | UCSNGUAR1  | UCSNGUBR1 | UCSNGUSB1 | UCSNGUPR1 | UCSNGUC1 | UCSNGUCN7    | 20       | 10/14/2022     | HD 1080i 25fps | UCSNGUT7 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'UCSNGUCN7' a New Master with following fields:
| Supply Via | Assignee   | Already Supplied | Message          | Deadline Date |
| FTP        | UCSNGUU7_1 | should not       | automated test 1 | 12/14/2022    |
And complete order contains item with clock number 'UCSNGUCN7' with following fields:
| Job Number | PO Number |
| UCSNGUJN7  | UCSNGUPN7 |
And I am on View Live Orders tab of 'tv' order on ordering page
When I go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'UCSNGUCN7' in 'live' order list
And 'uncheck' remove previous assignees checkbox on Assign someone to supply media popup
And fill following fields for Assign someone to supply media form that supply via 'FTP' on ordering page:
| Assignee   | Message        |
| UCSNGUU7_2 | automated test |
And send order to supply media by someone on ordering page
And select order with following item clock number 'UCSNGUCN7' in 'live' order list
Then I 'should' see email notification for 'Media Transfer Request' with field to 'UCSNGUU7_1' and subject 'Media Transfer Request' contains following attributes:
| Agency   | Account Type | UserEmail  | Deadline Date | Clock Number | Advertiser | Product   | Title    | Duration | Format         | Message        |
| UCSNGUA7 | adstream     | UCSNGUU7_2 | 12/14/2022    | UCSNGUCN7    | UCSNGUAR1  | UCSNGUPR1 | UCSNGUT7 | 20       | HD 1080i 25fps | automated test |
And 'should' see email notification for 'Media Transfer Request' with field to 'UCSNGUU7_2' and subject 'Media Transfer Request' contains following attributes:
| Agency   | Account Type | UserEmail  | Deadline Date | Clock Number | Advertiser | Product   | Title    | Duration | Format         | Message        |
| UCSNGUA7 | adstream     | UCSNGUU7_2 | 12/14/2022    | UCSNGUCN7    | UCSNGUAR1  | UCSNGUPR1 | UCSNGUT7 | 20       | HD 1080i 25fps | automated test |


Scenario: check new email notification received by previous user when RemovePreviousAssignees checkbox ticked on Assign someone to supply media popup
Meta: @ordering
      @obug
      @orderingemails
!--FAB-319
Given I created the following agency:
| Name     | A4User        |
| UCSNGUA8 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| UCSNGUU8_1 | agency.admin | UCSNGUA8     |
| UCSNGUU8_2 | agency.admin | UCSNGUA8     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'UCSNGUA8':
| Advertiser | Brand     | Sub Brand | Product   |
| UCSNGUAR1  | UCSNGUBR1 | UCSNGUSB1 | UCSNGUPR1 |
And logged in with details of 'UCSNGUU8_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand     | Sub Brand | Product   | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | UCSNGUAR1  | UCSNGUBR1 | UCSNGUSB1 | UCSNGUPR1 | UCSNGUC1 | UCSNGUCN8    | 20       | 10/14/2022     | HD 1080i 25fps | UCSNGUT8 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'UCSNGUCN8' a New Master with following fields:
| Supply Via | Assignee   | Already Supplied | Message          | Deadline Date |
| FTP        | UCSNGUU8_1 | should not       | automated test 1 | 12/14/2022    |
And complete order contains item with clock number 'UCSNGUCN8' with following fields:
| Job Number | PO Number |
| UCSNGUJN8  | UCSNGUPN8 |
And I am on View Live Orders tab of 'tv' order on ordering page
When I go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'UCSNGUCN8' in 'live' order list
And 'check' remove previous assignees checkbox on Assign someone to supply media popup
And fill following fields for Assign someone to supply media form that supply via 'FTP' on ordering page:
| Assignee   | Message        |
| UCSNGUU8_2 | automated test |
And send order to supply media by someone on ordering page
And select order with following item clock number 'UCSNGUCN8' in 'live' order list
Then I 'should' see email notification for 'Media Transfer Request' with field to 'UCSNGUU8_2' and subject 'Media Transfer Request' contains following attributes:
| Agency   | Account Type | UserEmail  | Deadline Date | Clock Number | Advertiser | Product   | Title    | Duration | Format         | Message        |
| UCSNGUA8 | adstream     | UCSNGUU8_2 | 12/14/2022    | UCSNGUCN8    | UCSNGUAR1  | UCSNGUPR1 | UCSNGUT8 | 20       | HD 1080i 25fps | automated test |
And 'should' see email notification for 'Please ignore upload request' with field to 'UCSNGUU8_1' and subject 'Please ignore upload request' contains following attributes:
| Agency   | Account Type | UserEmail  | Clock Number |
| UCSNGUA8 | adstream     | UCSNGUU8_1 | UCSNGUCN8    |
And I 'should' see only one email with subject 'Media Transfer Request' sent to 'UCSNGUU8_1'