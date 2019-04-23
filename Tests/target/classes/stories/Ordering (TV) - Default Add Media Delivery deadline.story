!--ORD-3342
!--ORD-3474
!--upload reminders scenario skipped as it involves changing date time settings at host level and DB level
Feature: Set default Add Media Delivery deadline
Narrative:
In order to:
As a AgencyAdmin
I want to check setting default Add Media Delivery deadline

Scenario: check validation of Add Media Deadline Default in the Delivery Settings
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| DAMDDA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DAMDDU1 | agency.admin | DAMDDA1      |
And logged in with details of 'DAMDDU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Add Media Deadline Default |
| one                        |
And save own Delivery Setting
Then I should see message error 'Add Media Deadline Default should be a number'

Scenario: check saving Add Media Deadline Default
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| DAMDDA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DAMDDU1 | agency.admin | DAMDDA1      |
And logged in with details of 'DAMDDU1'
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Add Media Deadline Default |
| 3                          |
And save own Delivery Setting
And refresh the page without delay
Then I should see following data for Delivery Setting form on user delivery setting page:
| Add Media Deadline Default |
| 3                          |

Scenario: check days before First Air Date value in the Add media section
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| DAMDDA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DAMDDU1 | agency.admin | DAMDDA1      |
And logged in with details of 'DAMDDU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| DAMDDCN3     |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Add Media Deadline Default |
| 5                          |
And save own Delivery Setting
And open order item with following clock number 'DAMDDCN3'
Then I should see following data on New Master form for order item that supply via 'FTP':
| Days Before First Air Date |
| 5                          |

Scenario: check days before First Air Date value after added to order
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| DAMDDA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DAMDDU1 | agency.admin | DAMDDA1      |
And logged in with details of 'DAMDDU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| DAMDDCN4     |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Add Media Deadline Default |
| 5                          |
And save own Delivery Setting
And open order item with following clock number 'DAMDDCN4'
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee | Already Supplied | Message        |
| DAMDDU1  | should not       | automated test |
Then I should see following data on New Master form for order item that supply via 'FTP':
| Assignee | Already Supplied | Message        | Days Before First Air Date |
| DAMDDU1  | should not       | automated test | 5                          |

Scenario: check days before First Air Date value after copy current
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| DAMDDA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DAMDDU1 | agency.admin | DAMDDA1      |
And logged in with details of 'DAMDDU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| DAMDDCN5     |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Add Media Deadline Default |
| 5                          |
And save own Delivery Setting
And open order item with following clock number 'DAMDDCN5'
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee | Already Supplied | Message        |
| DAMDDU1  | should not       | automated test |
And hold for approval active order item on cover flow
And 'copy current' order item by Add Commercial button on order item page
Then I should see following data on New Master form for order item that supply via 'FTP':
| Assignee | Already Supplied | Message        | Days Before First Air Date |
| DAMDDU1  | should not       | automated test | 5                          |

Scenario: check days before First Air Date value after copy to all for Beam agency
Meta: @ordering
Given I created the following agency:
| Name    | Labels | A4User        |
| DAMDDA6 | Beam   | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DAMDDU6 | agency.admin | DAMDDA6      |
And logged in with details of 'DAMDDU6'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| DAMDDCN6_1   |
| DAMDDCN6_2   |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Add Media Deadline Default |
| 5                          |
And save own Delivery Setting
And open order item with following clock number 'DAMDDCN6_1'
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee | Post House | Already Supplied | Message        | Days Before First Air Date | Arrival Time |
| DAMDDU6  | DAMDDU6    | should not       | automated test | 5                          | 20:00        |
And copy data from 'Add media' section of order item page to all other items
And select order item with following clock number 'DAMDDCN6_2' on cover flow
Then I should see following data on New Master form for order item that supply via 'FTP':
| Assignee | Post House | Already Supplied | Message        | Days Before First Air Date | Arrival Time |
| DAMDDU6  | DAMDDU6    | should not       | automated test | 5                          | 20:00        |

Scenario: check days before First Air Date value on Assign someone to supply media form for live orders
Meta: @ordering
      @obug
!--FAB-319
Given I created the following agency:
| Name    | A4User        |
| DAMDDA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DAMDDU1 | agency.admin | DAMDDA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DAMDDA1':
| Advertiser | Brand    | Sub Brand | Product  |
| DAMDDAR1   | DAMDDBR1 | DAMDDSB1  | DAMDDPR1 |
And logged in with details of 'DAMDDU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | DAMDDAR1   | DAMDDBR1 | DAMDDSB1  | DAMDDPR1 | DAMDDC7  | DAMDDCN7     | 20       | 08/14/2022     | HD 1080i 25fps | DAMDDT7 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'DAMDDCN7' with following fields:
| Job Number | PO Number |
| DAMDDJN7   | DAMDDPN7  |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Add Media Deadline Default |
| 5                          |
And save own Delivery Setting
And go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'DAMDDCN7' in 'live' order list
Then I should see following data on Assign someone to supply media form that supply via '' on ordering page:
| Order Number | Clock Number |
| DAMDDCN7     | DAMDDCN7     |

Scenario: check media transfer confirmation email with days before First Air Date value after confirming
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name    | A4User        |
| DAMDDA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DAMDDU1 | agency.admin | DAMDDA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DAMDDA1':
| Advertiser | Brand    | Sub Brand | Product  |
| DAMDDAR1   | DAMDDBR1 | DAMDDSB1  | DAMDDPR1 |
And logged in with details of 'DAMDDU1'
And I am on own Delivery Setting page
And filled following fields for Delivery Setting form on user delivery setting page:
| Add Media Deadline Default |
| 5                          |
And saved own Delivery Setting
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | DAMDDAR1   | DAMDDBR1 | DAMDDSB1  | DAMDDPR1 | DAMDDC8  | DAMDDCN8     | 20       | 08/15/2022     | HD 1080i 25fps | DAMDDT8 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'DAMDDCN8' a New Master with following fields:
| Supply Via | Assignee  | Already Supplied | Message        | Days Before First Air Date |
| FTP        | DAMDDU1_8 | should not       | automated test | 5                          |
And complete order contains item with clock number 'DAMDDCN8' with following fields:
| Job Number | PO Number |
| DAMDDJN8   | DAMDDPN8  |
Then I 'should' see email notification for 'Media Transfer Request' with field to 'DAMDDU1_8' and subject 'Media Transfer Request' contains following attributes:
| Agency  | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product  | Title   | Duration | Format         | Message        |
| DAMDDA1 | adstream     | DAMDDU1_8 | 08/08/2022    | DAMDDCN8     | DAMDDAR1   | DAMDDPR1 | DAMDDT8 | 20       | HD 1080i 25fps | automated test |

Scenario: check media transfer confirmation email with days before First Air Date value for confirmed order
Meta: @ordering
      @obug
      @orderingemails
!--FAB-319
Given I created the following agency:
| Name    | A4User        |
| DAMDDA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DAMDDU1 | agency.admin | DAMDDA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DAMDDA1':
| Advertiser | Brand    | Sub Brand | Product  |
| DAMDDAR1   | DAMDDBR1 | DAMDDSB1  | DAMDDPR1 |
And logged in with details of 'DAMDDU1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title   | Subtitles Required | Destination                 |
| automated test info    | DAMDDAR1   | DAMDDBR1 | DAMDDSB1  | DAMDDPR1 | DAMDDC9  | DAMDDCN9     | 20       | 08/15/2022     | HD 1080i 25fps | DAMDDT9 | Already Supplied   | BSkyB Green Button:Standard |
And complete order contains item with clock number 'DAMDDCN9' with following fields:
| Job Number | PO Number |
| DAMDDJN9   | DAMDDPN9  |
And I am on own Delivery Setting page
When I fill following fields for Delivery Setting form on user delivery setting page:
| Add Media Deadline Default |
| 5                          |
And save own Delivery Setting
And go to View Live Orders tab of 'tv' order on ordering page
And select order with following item clock number 'DAMDDCN9' in 'live' order list
And fill following fields for Assign someone to supply media form that supply via 'FTP' on ordering page:
| Message        |Assignee  |
| automated test |DAMDDU1_9 |
And send order to supply media by someone on ordering page
Then I 'should' see email notification for 'Media Transfer Request' with field to 'DAMDDU1_9' and subject 'Media Transfer Request' contains following attributes:
| Agency  | Account Type | UserEmail | Deadline Date | Clock Number | Advertiser | Product  | Title   | Duration | Format         | Message        |
| DAMDDA1 | adstream     | DAMDDU1_9 | 08/15/2022    | DAMDDCN9     | DAMDDAR1   | DAMDDPR1 | DAMDDT9 | 20       | HD 1080i 25fps | automated test |

Scenario: check that days before First Air Date value has ignored weekends and only count working days
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name    | A4User        |
| DAMDDA1 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DAMDDU1 | agency.admin | DAMDDA1      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DAMDDA1':
| Advertiser | Brand    | Sub Brand | Product  |
| DAMDDAR1   | DAMDDBR1 | DAMDDSB1  | DAMDDPR1 |
And logged in with details of 'DAMDDU1'
And I am on own Delivery Setting page
And filled following fields for Delivery Setting form on user delivery setting page:
| Add Media Deadline Default |
| 5                          |
And saved own Delivery Setting
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination                 |
| automated test info    | DAMDDAR1   | DAMDDBR1 | DAMDDSB1  | DAMDDPR1 | DAMDDC10 | DAMDDCN10    | 20       | 08/15/2022     | HD 1080i 25fps | DAMDDT10 | Already Supplied   | BSkyB Green Button:Standard |
And add for 'tv' order to item with clock number 'DAMDDCN10' a New Master with following fields:
| Supply Via | Assignee   | Already Supplied | Message        | Days Before First Air Date |
| FTP        | DAMDDU1_10 | should not       | automated test | 5                          |
And complete order contains item with clock number 'DAMDDCN10' with following fields:
| Job Number | PO Number |
| DAMDDJN10  | DAMDDPN10 |
Then I 'should' see email notification for 'Media Transfer Request' with field to 'DAMDDU1_10' and subject 'Media Transfer Request' contains following attributes:
| Agency  | Account Type | UserEmail  | Deadline Date | Clock Number | Advertiser | Product  | Title    | Duration | Format         | Message        |
| DAMDDA1 | adstream     | DAMDDU1_10 | 08/08/2022    | DAMDDCN10    | DAMDDAR1   | DAMDDPR1 | DAMDDT10 | 20       | HD 1080i 25fps | automated test |

Scenario: check that material deadline date considers holidays set for the country
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name    | A4User        |
| DAMDDA11 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DAMDDU11 | agency.admin | DAMDDA11      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DAMDDA11':
| Advertiser | Brand    | Sub Brand | Product  |
| DAMDDAR1   | DAMDDBR1 | DAMDDSB1  | DAMDDPR1 |
And I logged in as 'GlobalAdmin'
And on the holidays page
And select following details on holidays page:
| Country        | Year | Month   |
| United Kingdom | 2022 | January |
And add following dates to holidays list:
| Date       | Description  |
| 12/08/2022 | My birth day |
And logged in with details of 'DAMDDU11'
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And select following market 'United Kingdom' on order item page
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee   | Already Supplied | Days Before First Air Date | Message        |
| DAMDDU11_1 | should not       | 5                          | automated test |
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required |
| automated test info    | DAMDDAR1   | DAMDDBR1 | DAMDDSB1  | DAMDDPR1 | DAMDDC11 | DAMDDCN11    | 20       | 08/15/2022     | HD 1080i 25fps | DAMDDT11 | Already Supplied   |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard |
| ABP News |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| DAMDDJN11  | DAMDDPN11 |
And confirm order on Order Proceed page
Then I 'should' see email notification for 'Media Transfer Request' with field to 'DAMDDU11_1' and subject 'Media Transfer Request' contains following attributes:
| Agency   | Account Type | UserEmail  | Deadline Date | Clock Number | Advertiser | Product  | Title    | Duration | Format         | Message        |
| DAMDDA11 | adstream     | DAMDDU11_1 | 08/05/2022    | DAMDDCN11    | DAMDDAR1   | DAMDDPR1 | DAMDDT11 | 20       | HD 1080i 25fps | automated test |

Scenario: check that days set for default material deadline date considers holidays set for the country
Meta: @ordering
      @orderingemails
Given I created the following agency:
| Name    | A4User        |
| DAMDDA12 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| DAMDDU12 | agency.admin | DAMDDA12      |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'DAMDDA12':
| Advertiser | Brand    | Sub Brand | Product  |
| DAMDDAR1   | DAMDDBR1 | DAMDDSB1  | DAMDDPR1 |
And I logged in as 'GlobalAdmin'
And on the holidays page
And select following details on holidays page:
| Country        | Year | Month   |
| United Kingdom | 2022 | January |
And add following dates to holidays list:
| Date       | Description  |
| 12/08/2022 | My birth day |
And logged in with details of 'DAMDDU12'
And I am on own Delivery Setting page
And filled following fields for Delivery Setting form on user delivery setting page:
| Add Media Deadline Default |
| 5                          |
And saved own Delivery Setting
And I am on View Draft Orders tab of 'tv' order on ordering page
When I create 'tv' order on View Draft Orders tab on ordering page
And select following market 'United Kingdom' on order item page
And fill following fields for New Master of order item that supply via 'FTP' on Add media form:
| Assignee   | Already Supplied | Message        |
| DAMDDU12_1 | should not       | automated test |
And fill following fields for Add information form on order item page:
| Additional Information | Advertiser | Brand    | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required |
| automated test info    | DAMDDAR1   | DAMDDBR1 | DAMDDSB1  | DAMDDPR1 | DAMDDC12 | DAMDDCN12    | 20       | 08/15/2022     | HD 1080i 25fps | DAMDDT12 | Already Supplied   |
And 'check' following destinations for Select Broadcast Destinations form on order item page:
| Standard |
| ABP News |
And click Proceed button on order item page
And fill following fields on Order Proceed page:
| Job Number | PO Number |
| DAMDDJN12  | DAMDDPN12 |
And confirm order on Order Proceed page
Then I 'should' see email notification for 'Media Transfer Request' with field to 'DAMDDU12_1' and subject 'Media Transfer Request' contains following attributes:
| Agency   | Account Type | UserEmail  | Deadline Date | Clock Number | Advertiser | Product  | Title    | Duration | Format         | Message        |
| DAMDDA12 | adstream     | DAMDDU12_1 | 08/05/2022    | DAMDDCN12    | DAMDDAR1   | DAMDDPR1 | DAMDDT12 | 20       | HD 1080i 25fps | automated test |