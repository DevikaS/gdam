!--ORD-1299
Feature: Permissions
Narrative:
In order to:
As a AgencyAdmin
I want to check ordering permissions

Scenario: Verification for roles default values were checked
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OTVPA1 | DefaultA4User |
And I logged in as 'GlobalAdmin'
And opened role '<Role>' page with parent 'OTVPA1'
Then I '<ShouldState>' see 'selected' permissions 'tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' on opened global role page

Examples:
| Role         | ShouldState |
| agency.admin | should      |
| agency.user  | should      |
| guest.user   | should not  |

Scenario: Verify that button Confirm was hidden unhidden for created new Order depends on permission tv_order.complete
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OTVPA1 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'OTVPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | OTVPA1       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVPA1':
| Advertiser | Brand   | Sub Brand | Product |
| OTVPAR2    | OTVPBR2 | OTVPSB2   | OTVPP2  |
And logged in with details of '<Email>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | OTVPAR2    | OTVPBR2 | OTVPSB2   | OTVPP2  | OTVPC2   | <ClockNumber> | 20       | 10/14/2022     | HD 1080i 25fps | OTVPT2 | Already Supplied   | BSkyB Green Button:Standard |
And I am on Order Proceed page for order contains order item with following clock number '<ClockNumber>'
Then I '<ShouldState>' Confirm button on Order Proceed page

Examples:
| Email    | Role     | ClockNumber | Permissions                                                                    | ShouldState |
| OTVPU2_1 | OTVPR2_1 | OTVPCN2_1   | tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write | should      |
| OTVPU2_2 | OTVPR2_2 | OTVPCN2_2   | tv_order.create,tv_order.delete,tv_order.read,tv_order.write                   | should not  |

Scenario: Verify that Create Order was hidden unhidden depends on permission tv_order.create
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OTVPA1 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'OTVPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | OTVPA1       |
And logged in with details of '<Email>'
And I am on View Draft Orders tab of 'tv' order on ordering page
Then I '<ShouldState>' see Create an Order button on ordering page
When I select 'View Live Orders' tab on ordering page
Then I '<ShouldState>' see Create an Order button on ordering page
When I select 'View Held Orders' tab on ordering page
Then I '<ShouldState>' see Create an Order button on ordering page
When I select 'View Completed Orders' tab on ordering page
Then I '<ShouldState>' see Create an Order button on ordering page

Examples:
| Email    | Role     | Permissions                                                                    | ShouldState |
| OTVPU3_1 | OTVPR3_1 | tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write | should      |
| OTVPU3_2 | OTVPR3_2 | tv_order.complete,tv_order.delete,tv_order.read,tv_order.write                 | should not  |

Scenario: Verify that user cannot see any type of orders for agency depends on permission tv_order.read
!--ORD-3591
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OTVPA1 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'OTVPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | OTVPA1       |
And logged in with details of '<Email>'
When I go to Delivery page
Then I '<ShouldState>' see error message 'We are sorry! You do not have permission to access this area.' on the page

Examples:
| Email    | Role     | Permissions                                                                    | ShouldState |
| OTVPU4_1 | OTVPR4_1 | tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write | should not  |
| OTVPU4_2 | OTVPR4_2 | tv_order.complete,tv_order.create,tv_order.delete,tv_order.write               | should not  |

Scenario: Verify that link Create Order was hidden unhidden depends on permission tv_order.write
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OTVPA1 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'OTVPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | OTVPA1       |
And logged in with details of '<Email>'
And I am on View Draft Orders tab of 'tv' order on ordering page
Then I '<ShouldState>' see Create an Order button on ordering page
When I select 'View Live Orders' tab on ordering page
Then I '<ShouldState>' see Create an Order button on ordering page
When I select 'View Held Orders' tab on ordering page
Then I '<ShouldState>' see Create an Order button on ordering page
When I select 'View Completed Orders' tab on ordering page
Then I '<ShouldState>' see Create an Order button on ordering page

Examples:
| Email    | Role     | Permissions                                                                    | ShouldState |
| OTVPU5_1 | OTVPR5_1 | tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write | should      |
| OTVPU5_2 | OTVPR5_2 | tv_order.complete,tv_order.create,tv_order.delete,tv_order.read                | should not  |

Scenario: Verify that you can confirm or not the order depends on permission tv_order.write
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OTVPA6 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'OTVPA6'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | OTVPA6       |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVPA6':
| Advertiser | Brand   | Sub Brand | Product |
| OTVPAR6    | OTVPBR6 | OTVPSB6   | OTVPP6  |
And logged in with details of '<Email>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand   | Sub Brand | Product | Campaign | Clock Number  | Duration | First Air Date | Format         | Title  | Subtitles Required | Destination                 |
| automated test info    | OTVPAR6    | OTVPBR6 | OTVPSB6   | OTVPP6  | OTVPC6   | <ClockNumber> | 20       | 12/14/2022     | HD 1080i 25fps | OTVPT6 | Already Supplied   | BSkyB Green Button:Standard |
And I am on Order Proceed page for order contains order item with following clock number '<ClockNumber>'
When I fill following fields on Order Proceed page:
| Job Number | PO Number |
| OTVPJN6    | OTVPPN6   |
And confirm order on Order Proceed page
And wait for '10' seconds
Then I should see count orders '<Count>' on 'View Live Orders' tab in order slider
And should see orders counter '<Count>' above orders list on ordering page

Examples:
| Email    | Role     | ClockNumber | Permissions                                                                    | Count |
| OTVPU6_1 | OTVPR6_1 | OTVPCN6_1   | tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write | 1     |
| OTVPU6_2 | OTVPR6_2 | OTVPCN6_2   | tv_order.complete,tv_order.create,tv_order.delete,tv_order.read                | 2     |

Scenario: Verify when you can to add values to order item depends on permission tv order.write
!--ORD-2042
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OTVPA1 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'OTVPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | OTVPA1       |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OTVPA1'
And logged in with details of '<Email>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I open order item with following clock number '<ClockNumber>'
Then I '<ShouldState>' see able to edit following fields 'Clock Number,Advertiser,Product,Campaign,Title,Duration,First Air Date,Format,Subtitles Required,Additional Information' for order item on Add information form

Examples:
| Email    | Role     | ClockNumber | Permissions                                                                    | ShouldState |
| OTVPU7_1 | OTVPR7_1 | OTVPCN7_1   | tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write | should      |
| OTVPU7_2 | OTVPR7_2 | OTVPCN7_2   | tv_order.complete,tv_order.create,tv_order.delete,tv_order.read                | should      |

Scenario: Verify that link Delete was hidden/unhidden for the Draft Orders depends on permission tv_order.delete
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OTVPA1 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'OTVPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | OTVPA1       |
And logged in with details of '<Email>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
When I go to View Draft Orders tab of 'tv' order on ordering page
And select order with following item clock number '<ClockNumber>' in 'draft' order list
Then I '<ShouldState>' see Delete order button on ordering page

Examples:
| Email    | Role     | ClockNumber | Permissions                                                                    | ShouldState |
| OTVPU8_1 | OTVPR8_1 | OTVPCN8_1   | tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write | should      |
| OTVPU8_2 | OTVPR8_2 | OTVPCN8_2   | tv_order.complete,tv_order.create,tv_order.read,tv_order.write                 | should not  |

Scenario: Verify that cross on the order item was hidden unhidden on the coverflow depends on permission tv_order.delete
!--ORD-2010
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OTVPA1 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'OTVPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | OTVPA1       |
And logged in with details of '<Email>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number  |
| <ClockNumber> |
| OTVPCN9       |
When I open order item with following clock number '<ClockNumber>'
Then I '<ShouldState>' see Cross button for active order item on cover flow

Examples:
| Email    | Role     | ClockNumber | Permissions                                                                    | ShouldState |
| OTVPU9_1 | OTVPR9_1 | OTVPCN9_1   | tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write | should      |
| OTVPU9_2 | OTVPR9_2 | OTVPCN9_2   | tv_order.complete,tv_order.create,tv_order.read,tv_order.write                 | should      |

Scenario: Check saving property for different permissions for Global Admin using different Business Units
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVPA10 | DefaultA4User |
And created 'OTVPR10' role with 'tv_order.delete' permissions in 'global' group for advertiser 'OTVPA10'
And I logged in as 'GlobalAdmin'
And opened role 'OTVPR10' page with parent 'OTVPA10'
When I change role permissions to 'tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write'
And click element 'SaveButton' on page 'Roles'
And refresh the page
Then I 'should' see 'selected' permissions 'tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' on opened global role page