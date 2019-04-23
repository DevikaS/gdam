!--ORD-399
!--ORD-3153
!--NGN-16193
Feature: Upload request for Live and On Hold orders
Narrative:
In order to:
As a AgencyAdmin
I want to check upload request for Live and On Hold orders

Scenario: Check availability of assign link from Live Hold Draft Complete tab
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| URLHOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| URLHOU1 | agency.admin | URLHOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA1':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 |
And logged in with details of 'URLHOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC1  | URLHOCN1_1   | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT1 | Already Supplied   | BSkyB Green Button:Standard |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| URLHOCN1_2   |
And hold for approval 'tv' order items with following clock numbers 'URLHOCN1_1'
And complete order contains item with clock number 'URLHOCN1_1' with following fields:
| Job Number | PO Number |
| URLHOJN1   | URLHOPN1  |
When I go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'URLHOCN1_1' in 'live' order list
Then I 'should' see Assign order button on ordering page
When I select 'View Held Orders' tab on ordering page
And select order with following item clock number 'URLHOCN1_1' in 'held' order list
Then I 'should' see Assign order button on ordering page
When I select 'View Draft Orders' tab on ordering page
And select order with following item clock number 'URLHOCN1_2' in 'draft' order list
Then I 'should not' see Assign order button on ordering page

Scenario: Check assigning someone to supply media
Meta: @ordering
      @obug
!--FAB-319
Given I created the following agency:
| Name    | A4User        |
| URLHOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| URLHOU1 | agency.admin | URLHOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA1':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 |
And logged in with details of 'URLHOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC2  | URLHOCN2     | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT2 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'URLHOCN2' with following fields:
| Job Number | PO Number |
| URLHOJN2   | URLHOPN2  |
When I go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'URLHOCN2' in 'live' order list
And fill following fields for Assign someone to supply media form that supply via 'FTP' on ordering page:
| Assignee | Message        |
| URLHOU1  | automated test |
And send order to supply media by someone on ordering page
Then I should see message success 'Items successfully sent'
And 'should not' see Assign someone to supply media form on ordering page


Scenario: Check assigning someone to supply media for Beam agency
Meta: @ordering
      @obug
!--FAB-319
!--Posthouse field removed after confirmation with Maria that its okie that it doesnt appear
Given I created the following agency:
| Name    | Labels | A4User        |
| URLHOA3 | Beam   | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| URLHOU3 | agency.admin | URLHOA3      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA3':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR3   | URLHOBR3 | URLHOSB3  | URLHOPR3 |
And logged in with details of 'URLHOU3'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | URLHOAR3   | URLHOBR3 | URLHOSB3  | URLHOPR3 | URLHOC3  | URLHOCN3     | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT3 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'URLHOCN3' with following fields:
| Job Number | PO Number |
| URLHOJN3   | URLHOPN3  |
When I go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'URLHOCN3' in 'live' order list
And fill following fields for Assign someone to supply media form that supply via 'Physical' on ordering page:
| Assignee | Message        |
| URLHOU3  | automated test |
And send order to supply media by someone on ordering page
Then I should see message success 'Items successfully sent'
And 'should not' see Assign someone to supply media form on ordering page


Scenario: Check that correct data is displayed on Assign someone to supply media form
Meta: @ordering
      @obug
!--FAB-319
Given I created the following agency:
| Name    | A4User        |
| URLHOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| URLHOU1 | agency.admin | URLHOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA1':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 |
And logged in with details of 'URLHOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC4_1 | URLHOCN4_1   | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT4_1 | Already Supplied   | BSkyB Green Button:Standard |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC4_2 | URLHOCN4_2   | 15       | 08/14/2020     | HD 1080i 25fps | URLHOT4_2 | Already Supplied   | BET:Standard                |
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC4_3 | URLHOCN4_3   | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT4_3 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'URLHOCN4_1' with following fields:
| Job Number | PO Number  |
| URLHOJN4_1 | URLHOPN4_1 |
And complete order contains item with clock number 'URLHOCN4_3' with following fields:
| Job Number | PO Number  |
| URLHOJN4_2 | URLHOPN4_2 |
When I go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'URLHOCN4_1,URLHOCN4_3' in 'live' order list
Then I should see following data on Assign someone to supply media form that supply via '' on ordering page:
| Order Number          | Clock Number                     |
| URLHOCN4_1,URLHOCN4_3 | URLHOCN4_1,URLHOCN4_2,URLHOCN4_3 |

Scenario: Check that correct data is displayed on Assign someone to supply media form if user selects 1 order item of 2
Meta: @ordering
      @obug
!--FAB-319
!--FAB-489
Given I created the following agency:
| Name    | A4User        |
| URLHOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| URLHOU1 | agency.admin | URLHOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA1':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 |
And logged in with details of 'URLHOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC5_1 | URLHOCN5_1   | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT5_1 | Already Supplied   | BSkyB Green Button:Standard |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC5_2 | URLHOCN5_2   | 15       | 08/14/2020     | HD 1080i 25fps | URLHOT5_2 | Already Supplied   | BET:Standard                |
And complete order contains item with clock number 'URLHOCN5_1' with following fields:
| Job Number | PO Number |
| URLHOJN5   | URLHOPN5  |
When I go to View Live Orders tab of 'tv' order on ordering page
And select order item with following clock number 'URLHOCN5_1' in 'tv' order list for 'live' order
Then I should see following data on Assign someone to supply media form that supply via '' on ordering page:
| Order Number | Clock Number |
| URLHOCN5_1   | URLHOCN5_1   |

Scenario: Check that email specified into Assign someone to supply media form is remembered and can be selected next time
Meta: @ordering
      @obug
!--FAB-319
Given I created the following agency:
| Name    | A4User        |
| URLHOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| URLHOU1 | agency.admin | URLHOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA1':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 |
And logged in with details of 'URLHOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC6  | URLHOCN6     | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT6 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'URLHOCN6' with following fields:
| Job Number | PO Number |
| URLHOJN6   | URLHOPN6  |
When I go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'URLHOCN6' in 'live' order list
And fill following fields for Assign someone to supply media form that supply via 'FTP' on ordering page:
| Assignee | Message        |
| URLHOU1  | automated test |
And send order to supply media by someone on ordering page
And select order with following item clock number 'URLHOCN6' in 'live' order list
And fill following fields for Assign someone to supply media form that supply via 'Physical' on ordering page:
| Assignee |
| URLHOU1  |
Then I should see auto complete emails count '1' under Assignee for Assign someone to supply media form on ordering page

Scenario: check media transfer confirmation email after assining order
Meta: @ordering
      @obug
      @orderingemails
!--FAB-319
Given I created the following agency:
| Name    | A4User        |
| URLHOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| URLHOU1 | agency.admin | URLHOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA1':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 |
And logged in with details of 'URLHOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC7  | URLHOCN7     | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT7 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'URLHOCN7' with following fields:
| Job Number | PO Number |
| URLHOJN7   | URLHOPN7  |
When I go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'URLHOCN7' in 'live' order list
And fill following fields for Assign someone to supply media form that supply via 'FTP' on ordering page:
| Assignee |Message        |
| URLHOU7  |automated test |
And send order to supply media by someone on ordering page
Then I 'should' see email notification for 'Media Transfer Request' with field to 'URLHOU7' and subject 'Media Transfer Request' contains following attributes:
| Agency  | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product  | Title   | Duration | Format         | Message        |
| URLHOA1 | adstream     | URLHOU1   | 08/14/2022    | URLHOCN7     | URLHOAR1   | URLHOPR1 | URLHOT7 | 20       | HD 1080i 25fps | automated test |

Scenario: check media transfer confirmation email after assining order by selecting order item
Meta: @ordering
      @obug
      @orderingemails
!--FAB-319
Given I created the following agency:
| Name    | A4User        |
| URLHOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| URLHOU1 | agency.admin | URLHOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA1':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 |
And logged in with details of 'URLHOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign  | Clock Number | Duration | First Air Date | Format         | Title     | Subtitles Required | Destination                 |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC8_1 | URLHOCN8_1   | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT8_1 | Already Supplied   | BSkyB Green Button:Standard |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC8_2 | URLHOCN8_2   | 15       | 08/14/2020     | HD 1080i 25fps | URLHOT8_2 | Already Supplied   | BET:Standard                |
And complete order contains item with clock number 'URLHOCN8_1' with following fields:
| Job Number | PO Number |
| URLHOJN8   | URLHOPN8  |
When I go to View Live Orders tab of 'tv' order on ordering page
And select order item with following clock number 'URLHOCN8_2' in 'tv' order list for 'live' order
And fill following fields for Assign someone to supply media form that supply via 'FTP' on ordering page:
| Assignee |Message        |
| URLHOU8  |automated test |
And send order to supply media by someone on ordering page
Then I 'should' see email notification for 'Media Transfer Request' with field to 'URLHOU8' and subject 'Media Transfer Request' contains following attributes:
| Agency  | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product  | Title     | Duration | Format         | Message        |
| URLHOA1 | adstream     | URLHOU1   | 08/14/2020    | URLHOCN8_2   | URLHOAR1   | URLHOPR1 | URLHOT8_2 | 15       | HD 1080i 25fps | automated test |

Scenario: check media transfer confirmation email after assining order for Beam agency
Meta: @ordering
      @obug
      @orderingemails
!--FAB-319
Given I created the following agency:
| Name    | Labels | A4User        |
| URLHOA9 | Beam   | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique | Language |
| URLHOU9 | agency.admin | URLHOA9      | en-beam  |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA9':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR9   | URLHOBR9 | URLHOSB9  | URLHOPR9 |
And logged in with details of 'URLHOU9'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | URLHOAR9   | URLHOBR9 | URLHOSB9  | URLHOPR9 | URLHOC9  | URLHOCN9     | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT9 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'URLHOCN9' with following fields:
| Job Number | PO Number |
| URLHOJN9   | URLHOPN9  |
When I go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'URLHOCN9' in 'live' order list
And fill following fields for Assign someone to supply media form that supply via 'FTP' on ordering page:
| Assignee  |Message        |
| URLHOU9_1 |automated test |
And send order to supply media by someone on ordering page
Then I 'should' see email notification for 'Media Transfer Request' with field to 'URLHOU9_1' and subject 'Media Transfer Request' contains following attributes:
| Agency  | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product  | Title   | Duration | Format         | Message        |
| URLHOA9 | beam         | URLHOU9   | 08/14/2022    | URLHOCN9     | URLHOAR9   | URLHOPR9 | URLHOT9 | 20       | HD 1080i 25fps | automated test |

Scenario: Check availability of Send New Upload Request button on order summary page
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| URLHOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| URLHOU1 | agency.admin | URLHOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA1':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 |
And logged in with details of 'URLHOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC10 | URLHOCN10    | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT10 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'URLHOCN10' with following fields:
| Job Number | PO Number |
| URLHOJN10  | URLHOPN10 |
And I am on Order Summary page for order contains item with following clock number 'URLHOCN10'
Then I 'should' see 'Send New Upload Request' button on order summary page

Scenario: Check assigning someone to supply media on order summary page
Meta: @ordering
       @obug
!--FAB-319
Given I created the following agency:
| Name    | A4User        |
| URLHOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| URLHOU1 | agency.admin | URLHOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA1':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 |
And logged in with details of 'URLHOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC11 | URLHOCN11    | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT11 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'URLHOCN11' with following fields:
| Job Number | PO Number |
| URLHOJN11  | URLHOPN11 |
And I am on Order Summary page for order contains item with following clock number 'URLHOCN11'
When I fill following fields for Assign someone to supply media form that supply via 'FTP' on order summary page:
| Assignee | Message        |
| URLHOU1  | automated test |
And send order to supply media by someone on ordering page
Then I should see message success 'Items successfully sent'
And 'should not' see Assign someone to supply media form on ordering page

Scenario: check media transfer confirmation email after assining order from order summary page
!--ORD-5442
Meta: @ordering
      @obug
      @orderingemails
!--FAB-319
Given I created the following agency:
| Name    | A4User        |
| URLHOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| URLHOU1 | agency.admin | URLHOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA1':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 |
And logged in with details of 'URLHOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC12 | URLHOCN12    | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT12 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'URLHOCN12' with following fields:
| Job Number | PO Number |
| URLHOJN12  | URLHOPN12 |
And I am on Order Summary page for order contains item with following clock number 'URLHOCN12'
When I fill following fields for Assign someone to supply media form that supply via 'FTP' on order summary page:
| Assignee |Message        |
| URLHOU12 |automated test |
And send order to supply media by someone on order summary page
Then I 'should' see email notification for 'Media Transfer Request' with field to 'URLHOU12' and subject 'Media Transfer Request' contains following attributes:
| Agency  | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product  | Title    | Duration | Format         | Message        |
| URLHOA1 | adstream     | URLHOU1   | 08/14/2022    | URLHOCN12    | URLHOAR1   | URLHOPR1 | URLHOT12 | 20       | HD 1080i 25fps | automated test |

Scenario: check media transfer confirmation email after assining order from order summary page in case setup deadline date in the item
!--ORD-5442
Meta: @ordering
      @obug
      @orderingemails
!--FAB-319
Given I created the following agency:
| Name    | A4User        |
| URLHOA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| URLHOU1 | agency.admin | URLHOA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA1':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 |
And logged in with details of 'URLHOU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC13 | URLHOCN13    | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT13 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'URLHOCN13' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | URLHOU1  | should not       | automated test | 12/14/2024    |
And complete order contains item with clock number 'URLHOCN13' with following fields:
| Job Number | PO Number |
| URLHOJN13  | URLHOPN13 |
And I am on Order Summary page for order contains item with following clock number 'URLHOCN13'
When I fill following fields for Assign someone to supply media form that supply via 'FTP' on order summary page:
| Assignee | Message        |
| URLHOU13 | automated test |
And send order to supply media by someone on order summary page
Then I 'should' see email notification for 'Media Transfer Request' with field to 'URLHOU13' and subject 'Media Transfer Request' contains following attributes:
| Agency  | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product  | Title    | Duration | Format         | Message        |
| URLHOA1 | adstream     | URLHOU1   | 12/14/2024    | URLHOCN13    | URLHOAR1   | URLHOPR1 | URLHOT13 | 20       | HD 1080i 25fps | automated test |


Scenario: Check that Previous assignee shows the user that was assigned previously in order list page When New Master - FTP is chosen
Meta: @ordering
      @obug
!--FAB-319
Given I created the following agency:
| Name    | A4User        |
| URLHOA4 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| URLHOU7 | agency.admin | URLHOA4      |
| URLHOU8 | agency.admin | URLHOA4     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA4':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 |
And logged in with details of 'URLHOU7'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC13 | URLHOCN16   | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT13 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'URLHOCN16' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | URLHOU7  | should not       | automated test | 12/14/2024    |
And complete order contains item with clock number 'URLHOCN16' with following fields:
| Job Number | PO Number |
| URLHOJN16  | URLHOPN16 |
When I go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'URLHOCN16' in 'live' order list
Then I should see the previous assignee on supply media form on order list page:
| Previous Assignee         |
| URLHOU7 |


Scenario: Check that Previous assignee shows the user that was assigned previously in order list page When New Master - Physical media is chosen
Meta: @ordering
      @obug
!--FAB-319
Given I created the following agency:
| Name    | A4User        |
| URLHOA2 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| URLHOU3 | agency.admin | URLHOA2      |
| URLHOU4 | agency.admin | URLHOA2     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA2':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 |
And logged in with details of 'URLHOU3'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC13 | URLHOCN14    | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT13 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'URLHOCN14' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| Physical        | URLHOU3  | should not       | automated test | 12/14/2024    |
And complete order contains item with clock number 'URLHOCN14' with following fields:
| Job Number | PO Number |
| URLHOJN14  | URLHOPN14 |
When I go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'URLHOCN14' in 'live' order list
Then I should see the previous assignee on supply media form on order list page:
| Previous Assignee         |
| URLHOU3 |

Scenario: Check that Previous assignee shows the user that was assigned previously in order list page When New Master -  nVerge is chosen
Meta: @ordering
      @obug
!--FAB-319
Given I created the following agency:
| Name    | A4User        |
| URLHOA3 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| URLHOU5 | agency.admin | URLHOA3      |
| URLHOU6 | agency.admin | URLHOA3     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA3':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 |
And logged in with details of 'URLHOU5'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC13 | URLHOCN15    | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT13 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'URLHOCN15' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| nVerge        | URLHOU5  | should not       | automated test | 12/14/2024    |
And complete order contains item with clock number 'URLHOCN15' with following fields:
| Job Number | PO Number |
| URLHOJN15  | URLHOPN15 |
When I go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'URLHOCN15' in 'live' order list
Then I should see the previous assignee on supply media form on order list page:
| Previous Assignee         |
| URLHOU5 |


Scenario: Check that Previous assignee shows the user that was assigned previously in order summary page When New Master -  FTP is chosen
Meta: @ordering
      @obug
!--FAB-319
Given I created the following agency:
| Name    | A4User        |
| URLHOA5 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| URLHOU9 | agency.admin | URLHOA5      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA5':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 |
And logged in with details of 'URLHOU9'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC13 | URLHOCN18    | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT13 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'URLHOCN18' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| FTP        | URLHOU9  | should not       | automated test | 12/14/2024    |
And complete order contains item with clock number 'URLHOCN18' with following fields:
| Job Number | PO Number |
| URLHOJN18  | URLHOPN18 |
And I am on Order Summary page for order contains item with following clock number 'URLHOCN18'
Then I should see the previous assignee on supply media form on order summary page:
| Previous Assignee         |
| URLHOU9 |

Scenario: Check that Previous assignee shows the user that was assigned previously in order summary page When New Master -  Physical is chosen
Meta: @ordering
      @obug
!--FAB-319
Given I created the following agency:
| Name    | A4User        |
| URLHOA6 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| URLHOU10 | agency.admin | URLHOA6      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA6':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 |
And logged in with details of 'URLHOU10'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC13 | URLHOCN19    | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT13 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'URLHOCN19' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| Physical        | URLHOU10  | should not       | automated test | 12/14/2024    |
And complete order contains item with clock number 'URLHOCN19' with following fields:
| Job Number | PO Number |
| URLHOJN19  | URLHOPN19 |
And I am on Order Summary page for order contains item with following clock number 'URLHOCN19'
Then I should see the previous assignee on supply media form on order summary page:
| Previous Assignee         |
| URLHOU10 |

Scenario: Check that Previous assignee shows the user that was assigned previously in order summary page When New Master -  nVerge is chosen
Meta: @ordering
      @obug
!--FAB-319
Given I created the following agency:
| Name    | A4User        |
| URLHOA7 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| URLHOU11 | agency.admin | URLHOA7     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'URLHOA7':
| Advertiser | Brand    | Sub Brand | Product  |
| URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 |
And logged in with details of 'URLHOU11'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | URLHOAR1   | URLHOBR1 | URLHOSB1  | URLHOPR1 | URLHOC13 | URLHOCN20   | 20       | 08/14/2022     | HD 1080i 25fps | URLHOT13 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'URLHOCN20' a New Master with following fields:
| Supply Via | Assignee | Already Supplied | Message        | Deadline Date |
| nVerge        | URLHOU11  | should not       | automated test | 12/14/2024    |
And complete order contains item with clock number 'URLHOCN20' with following fields:
| Job Number | PO Number |
| URLHOJN20  | URLHOPN20 |
And I am on Order Summary page for order contains item with following clock number 'URLHOCN20'
Then I should see the previous assignee on supply media form on order summary page:
| Previous Assignee         |
| URLHOU11 |


