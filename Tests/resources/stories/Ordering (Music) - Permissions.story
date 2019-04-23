!--ORD-1608
Feature: Permissions
Narrative:
In order to:
As a AgencyAdmin
I want to check ordering permissions for music

Scenario: Verification for roles default values were checked for music
Meta: @ordering
Given I created the following agency:
| Name  | A4User       |
| OMPA1 | DefaultA4User |
And I logged in as 'GlobalAdmin'
And opened role '<Role>' page with parent 'OMPA1'
Then I '<ShouldState>' see 'selected' permissions 'tv_order_music.complete,tv_order_music.create,tv_order_music.delete,tv_order_music.read,tv_order_music.write' on opened global role page

Examples:
| Role         | ShouldState |
| agency.admin | should      |
| agency.user  | should      |
| guest.user   | should not  |

Scenario: Verify that button Confirm was hidden unhidden for created new Order depends on permission tv_order_music.complete for music
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| OMPA1 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'OMPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | OMPA1        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMPA1':
| Advertiser | Brand  | Sub Brand | Product |
| OMPAR2     | OMPBR2 | OMPSB2    | OMPP2   |
And logged in with details of '<Email>'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser | Brand  | Sub Brand | Product | Artist | ISRC Code  | Release Date | Format         | Title | Destination                 |
| automated test info    | OMPAR2     | OMPBR2 | OMPSB2    | OMPP2   | OMPC2  | <ISRCCode> | 10/14/2022   | HD 1080i 25fps | OMPT2 | BSkyB Green Button:Standard |
And I am on Order Proceed page for order contains order item with following isrc code '<ISRCCode>'
Then I '<ShouldState>' Confirm button on Order Proceed page

Examples:
| Email   | Role    | ISRCCode | Permissions                                                                                                  | ShouldState |
| OMPU2_1 | OMPR2_1 | OMPCN2_1 | tv_order_music.complete,tv_order_music.create,tv_order_music.delete,tv_order_music.read,tv_order_music.write | should      |
| OMPU2_2 | OMPR2_2 | OMPCN2_2 | tv_order_music.create,tv_order_music.delete,tv_order_music.read,tv_order_music.write                         | should not  |

Scenario: Verify that Create Order was hidden unhidden depends on permission tv_order_music.read for music
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| OMPA1 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'OMPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | OMPA1        |
And logged in with details of '<Email>'
And I am on View Draft Orders tab of 'music' order on ordering page
Then I '<ShouldState>' see Create an Order button on ordering page
When I select 'View Live Orders' tab on ordering page
Then I '<ShouldState>' see Create an Order button on ordering page
When I select 'View Held Orders' tab on ordering page
Then I '<ShouldState>' see Create an Order button on ordering page
When I select 'View Completed Orders' tab on ordering page
Then I '<ShouldState>' see Create an Order button on ordering page

Examples:
| Email   | Role    | Permissions                                                                                                  | ShouldState |
| OMPU3_1 | OMPR3_1 | tv_order_music.complete,tv_order_music.create,tv_order_music.delete,tv_order_music.read,tv_order_music.write | should      |
| OMPU3_2 | OMPR3_2 | tv_order_music.complete,tv_order_music.delete,tv_order_music.read,tv_order_music.write                       | should not  |

Scenario: Verify that user cannot see any type of orders for agency depends on permission tv_order_music.read for music
!--ORD-3591
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| OMPA1 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'OMPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | OMPA1        |
And logged in with details of '<Email>'
When I go to Delivery page
And '<Action>' to 'music' orders on ordering page
Then I '<ShouldState>' see error message 'We are sorry! You do not have permission to access this area.' on the page

Examples:
| Email   | Role    | Permissions                                                                                                  | ShouldState | Action       |
| OMPU4_1 | OMPR4_1 | tv_order_music.complete,tv_order_music.create,tv_order_music.delete,tv_order_music.read,tv_order_music.write | should not  | switch       |
| OMPU4_2 | OMPR4_2 | tv_order_music.complete,tv_order_music.create,tv_order_music.delete,tv_order_music.write                     | should not  | don't switch |

Scenario: Verify that link Create Order was hidden unhidden depends on permission tv_order_music.write for music
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| OMPA1 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'OMPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | OMPA1        |
And logged in with details of '<Email>'
And I am on View Draft Orders tab of 'music' order on ordering page
Then I '<ShouldState>' see Create an Order button on ordering page
When I select 'View Live Orders' tab on ordering page
Then I '<ShouldState>' see Create an Order button on ordering page
When I select 'View Draft Orders' tab on ordering page
Then I '<ShouldState>' see Create an Order button on ordering page
When I select 'View Held Orders' tab on ordering page
Then I '<ShouldState>' see Create an Order button on ordering page
When I select 'View Completed Orders' tab on ordering page
Then I '<ShouldState>' see Create an Order button on ordering page

Examples:
| Email   | Role    | Permissions                                                                                                  | ShouldState |
| OMPU5_1 | OMPR5_1 | tv_order_music.complete,tv_order_music.create,tv_order_music.delete,tv_order_music.read,tv_order_music.write | should      |
| OMPU5_2 | OMPR5_2 | tv_order_music.complete,tv_order_music.create,tv_order_music.delete,tv_order_music.read                      | should not  |

Scenario: Verify when you can to add values to order item depends on permission tv order.write for music
!--ORD-2042
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| OMPA1 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'OMPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | OMPA1        |
And make 'Campaign' field from asset element project common schema available in Delivery for agency 'OMPA1'
And logged in with details of '<Email>'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code     |
| <ISRCCode> |
When I open order item with following isrc code '<ISRCCode>'
Then I '<ShouldState>' see able to edit following fields 'ISRC Code,Record Company,Label,Artist,Title,Release Date,Format,Additional Information' for order item on Add information form

Examples:
| Email   | Role    | ISRCCode | Permissions                                                                                                  | ShouldState |
| OMPU7_1 | OMPR7_1 | OMPCN7_1 | tv_order_music.complete,tv_order_music.create,tv_order_music.delete,tv_order_music.read,tv_order_music.write | should      |
| OMPU7_2 | OMPR7_2 | OMPCN7_2 | tv_order_music.complete,tv_order_music.create,tv_order_music.delete,tv_order_music.read                      | should      |

Scenario: Verify that link Delete was hidden unhidden for the Draft Orders depends on permission tv_order_music.delete
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| OMPA1 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'OMPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | OMPA1        |
And logged in with details of '<Email>'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code  |
| <ISRCCode> |
When I go to View Draft Orders tab of 'music' order on ordering page
And select order with following item isrc code '<ISRCCode>' in 'draft' order list
Then I '<ShouldState>' see Delete order button on ordering page

Examples:
| Email   | Role    | ISRCCode | Permissions                                                                                                  | ShouldState |
| OMPU8_1 | OMPR8_1 | OMPCN8_1 | tv_order_music.complete,tv_order_music.create,tv_order_music.delete,tv_order_music.read,tv_order_music.write | should      |
| OMPU8_2 | OMPR8_2 | OMPCN8_2 | tv_order_music.complete,tv_order_music.create,tv_order_music.read,tv_order_music.write                       | should not  |

Scenario: Verify that cross on the order item was hidden unhidden on the coverflow depends on permission tv_order_music.delete for music
!--ORD-2010
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| OMPA1 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'OMPA1'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | OMPA1        |
And logged in with details of '<Email>'
And create 'music' order with market 'United Kingdom' and items with following fields:
| ISRC Code  |
| <ISRCCode> |
| OMPCN9     |
When I open order item with following isrc code '<ISRCCode>'
Then I '<ShouldState>' see Cross button for active order item on cover flow

Examples:
| Email   | Role    | ISRCCode | Permissions                                                                                                  | ShouldState |
| OMPU9_1 | OMPR9_1 | OMPCN9_1 | tv_order_music.complete,tv_order_music.create,tv_order_music.delete,tv_order_music.read,tv_order_music.write | should      |
| OMPU9_2 | OMPR9_2 | OMPCN9_2 | tv_order_music.complete,tv_order_music.create,tv_order_music.read,tv_order_music.write                       | should      |

Scenario: Check saving property for different permissions for Global Admin using different Business Units for music
Meta: @ordering
Given I created the following agency:
| Name   | A4User        |
| OMPA10 | DefaultA4User |
And created 'OMPR10' role with 'tv_order.delete' permissions in 'global' group for advertiser 'OMPA10'
And I logged in as 'GlobalAdmin'
And opened role 'OMPR10' page with parent 'OMPA10'
When I change role permissions to 'tv_order_music.complete,tv_order_music.create,tv_order_music.delete,tv_order_music.read,tv_order_music.write'
And click element 'SaveButton' on page 'Roles'
And refresh the page
Then I 'should' see 'selected' permissions 'tv_order_music.complete,tv_order_music.create,tv_order_music.delete,tv_order_music.read,tv_order_music.write' on opened global role page

Scenario: Verify that you can confirm or not the order depends on permission tv_order_music.write
!--ORD-1727
Meta: @ordering
Given I created the following agency:
| Name  | A4User        |
| OMPA6 | DefaultA4User |
And created '<Role>' role with '<Permissions>' permissions in 'global' group for advertiser 'OMPA6'
And created users with following fields:
| Email   | Role   | AgencyUnique |
| <Email> | <Role> | OMPA6        |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OMPA6':
| Advertiser | Brand  | Sub Brand | Product |
| OMPAR6     | OMPBR6 | OMPSB6    | OMPP6   |
And logged in with details of '<Email>'
And create 'music' order with market 'United Kingdom' and items with following fields:
| Additional Information | Record Company | Brand  | Sub Brand | Label | Artist | ISRC Code  | Release Date | Format         | Title | Destination                 |
| automated test info    | OMPAR6         | OMPBR6 | OMPSB6    | OMPP6 | OMPC6  | <ISRCCode> | 12/14/2022   | HD 1080i 25fps | OMPT6 | BSkyB Green Button:Standard |
And I am on Order Proceed page for order contains order item with following isrc code '<ISRCCode>'
When I fill following fields on Order Proceed page:
| Job Number | PO Number |
| OMPJN6     | OMPPN6    |
And confirm order on Order Proceed page
Then I should see count orders '<Count>' on 'View Live Orders' tab in order slider
And should see orders counter '<Count>' above orders list on ordering page

Examples:
| Email   | Role    | ISRCCode | Permissions                                                                                                  | Count |
| OMPU6_1 | OMPR6_1 | OMPCN6_1 | tv_order_music.complete,tv_order_music.create,tv_order_music.delete,tv_order_music.read,tv_order_music.write | 1     |
| OMPU6_2 | OMPR6_2 | OMPCN6_2 | tv_order_music.complete,tv_order_music.create,tv_order_music.delete,tv_order_music.read                      | 2     |