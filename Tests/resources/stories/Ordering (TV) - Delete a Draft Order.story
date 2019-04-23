!--ORD-304
!--ORD-527
Feature: Delete a Draft Order
Narrative:
In order to:
As a AgencyAdmin
I want to check a correct delete of draft Order

Scenario: Check that for draft orders ‘Delete’ action button is available
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVDDOA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | <GlobalRole> | OTVDDOA1     |
And logged in with details of '<UserEmail>'
And create 'tv' orders with following fields:
| Market   |
| <Market> |
When I go to View Draft Orders tab of 'tv' order on ordering page
And I select just created 'draft' order in order list
Then I 'should' see Delete order button on ordering page

Examples:
| UserEmail  | GlobalRole   | Market         |
| OTVDDOU1_1 | agency.admin | United Kingdom |
| OTVDDOU1_2 | agency.user  | Iceland        |

Scenario: Check that for draft orders ‘Delete’ action button is available (guest.user with required permissions)
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVDDOA1 | DefaultA4User |
And created 'OTVDDOR1_3' role with 'tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'OTVDDOA1'
And created users with following fields:
| Email      | Role       | AgencyUnique |
| OTVDDOU1_3 | OTVDDOR1_3 | OTVDDOA1     |
And logged in with details of 'OTVDDOU1_3'
And create 'tv' orders with following fields:
| Market |
| Poland |
When I go to View Draft Orders tab of 'tv' order on ordering page
And I select just created 'draft' order in order list
Then I 'should' see Delete order button on ordering page

Scenario: Check that for live orders 'Delete' action button isn't available
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVDDOA1 | DefaultA4User |
And created users with following fields:
| Email       | Role         | AgencyUnique |
| <UserEmail> | <GlobalRole> | OTVDDOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVDDOA1':
| Advertiser   | Brand     | Sub Brand | Product  |
| <Advertiser> | OTVDDOBR2 | OTVDDOSB2 | OTVDDOP2 |
And logged in with details of '<UserEmail>'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser   | Brand     | Sub Brand | Product  | Campaign | Clock Number  | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination        |
| automated test info    | <Advertiser> | OTVDDOBR2 | OTVDDOSB2 | OTVDDOP2 | OTVDDOC2 | <ClockNumber> | 20       | 08/14/2022     | HD 1080i 25fps | OTVDDOT2 | Already Supplied   | PTV Prime:Standard |
And complete just created 'draft' order with following fields:
| Job Number | PO Number |
| OTVDDOJN2  | OTVDDOPN2 |
When I go to View Live Orders tab of 'tv' order on ordering page
And select just created 'live' order in order list
Then I 'should not' see Delete order button on ordering page

Examples:
| UserEmail  | GlobalRole   | Advertiser  | ClockNumber |
| OTVDDOU1_1 | agency.admin | OTVDDOAR2_1 | OTVDDOCN2_1 |
| OTVDDOU1_2 | agency.user  | OTVDDOAR2_2 | OTVDDOCN2_2 |

Scenario: Check that for live orders 'Delete' action button isn't available (guest.user with required permissions)
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVDDOA1 | DefaultA4User |
And created 'OTVDDOR1_3' role with 'tv_order.complete,tv_order.create,tv_order.delete,tv_order.read,tv_order.write' permissions in 'global' group for advertiser 'OTVDDOA1'
And created users with following fields:
| Email      | Role       | AgencyUnique |
| OTVDDOU1_3 | OTVDDOR1_3 | OTVDDOA1     |
And created following catalogue structure items chains in 'common' section of 'common' schema for agency 'OTVDDOA1':
| Advertiser  | Brand     | Sub Brand | Product  |
| OTVDDOAR2_3 | OTVDDOBR2 | OTVDDOSB2 | OTVDDOP2 |
And logged in with details of 'OTVDDOU1_3'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Additional Information | Advertiser  | Brand     | Sub Brand | Product  | Campaign | Clock Number | Duration | First Air Date | Format         | Title    | Subtitles Required | Destination        |
| automated test info    | OTVDDOAR2_3 | OTVDDOBR2 | OTVDDOSB2 | OTVDDOP2 | OTVDDOC2 | OTVDDOCN2_3  | 20       | 08/14/2022     | HD 1080i 25fps | OTVDDOT2 | Already Supplied   | PTV Prime:Standard |
And complete just created 'draft' order with following fields:
| Job Number | PO Number |
| OTVDDOJN2  | OTVDDOPN2 |
When I go to View Live Orders tab of 'tv' order on ordering page
And select just created 'live' order in order list
Then I 'should not' see Delete order button on ordering page

Scenario: Check that correct notification is displayed in case to delete order
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVDDOA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVDDOU1_1 | agency.admin | OTVDDOA1     |
And logged in with details of 'OTVDDOU1_1'
And create 'tv' orders with following fields:
| Market |
| Poland |
When I go to View Draft Orders tab of 'tv' order on ordering page
And I select just created 'draft' order in order list
And without delay delete selected order in order list
Then I should see message success 'Items successfully deleted'

Scenario: Check that correct notification is displayed in case to delete order item
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVDDOA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVDDOU1_1 | agency.admin | OTVDDOA1     |
And logged in with details of 'OTVDDOU1_1'
And create 'tv' order with market 'United Kingdom' and items with following fields:
| Clock Number |
| OTVDDOU4_1   |
| OTVDDOU4_2   |
When I go to View Draft Orders tab of 'tv' order on ordering page
And select order item with following clock number 'OTVDDOU4_2' in 'tv' order list for just created 'draft' order
And without delay delete selected order in order list
Then I should see message success 'Items successfully deleted'

Scenario: Check that deletion of orders successfully works
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVDDOA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVDDOU1_1 | agency.admin | OTVDDOA1     |
And logged in with details of 'OTVDDOU1_1'
And create 'tv' orders with following fields:
| Market              |
| Albania             |
| Republic of Ireland |
| China               |
And deleted orders with following markets 'Albania,China'
When I go to View Draft Orders tab of 'tv' order on ordering page
Then I 'should' see orders with following markets 'Republic of Ireland' in 'draft' order list
And 'should not' see orders with following markets 'Albania,China' in 'draft' order list

Scenario: Check that deletion of order items successfully works
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVDDOA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVDDOU1_1 | agency.admin | OTVDDOA1     |
And logged in with details of 'OTVDDOU1_1'
And create 'tv' order with market 'Croatia' and items with following fields:
| Clock Number |
| OTVDDOCN6_1  |
| OTVDDOCN6_2  |
And create 'tv' order with market 'Bulgaria' and items with following fields:
| Clock Number |
| OTVDDOCN6_3  |
| OTVDDOCN6_4  |
And deleted order items with following clock numbers 'OTVDDOCN6_1' for 'tv' order with market 'Croatia'
And deleted order items with following clock numbers 'OTVDDOCN6_4' for 'tv' order with market 'Bulgaria'
When I go to View Draft Orders tab of 'tv' order on ordering page
Then I 'should' see order items with following clock numbers 'OTVDDOCN6_2' in 'draft' order list for 'tv' order with market 'Croatia'
And 'should not' see order items with following clock numbers 'OTVDDOCN6_1' in 'draft' order list for 'tv' order with market 'Croatia'
And 'should' see order items with following clock numbers 'OTVDDOCN6_3' in 'draft' order list for 'tv' order with market 'Bulgaria'
And 'should not' see order items with following clock numbers 'OTVDDOCN6_4' in 'draft' order list for 'tv' order with market 'Bulgaria'

Scenario: Check that deletion of order and order items successfully works
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVDDOA1 | DefaultA4User |
And created users with following fields:
| Email      | Role         | AgencyUnique |
| OTVDDOU1_1 | agency.admin | OTVDDOA1     |
And logged in with details of 'OTVDDOU1_1'
And create 'tv' orders with following fields:
| Market           |
| Cyprus           |
| Slovakia         |
And create 'tv' order with market 'Cambodia' and items with following fields:
| Clock Number |
| OTVDDOCN7_1  |
| OTVDDOCN7_2  |
And deleted orders with following markets 'Cyprus'
And deleted order items with following clock numbers 'OTVDDOCN7_2' for 'tv' order with market 'Cambodia'
When I go to View Draft Orders tab of 'tv' order on ordering page
Then I 'should' see orders with following markets 'Slovakia' in 'draft' order list
And 'should not' see orders with following markets 'Cyprus' in 'draft' order list
And 'should' see order items with following clock numbers 'OTVDDOCN7_1' in 'draft' order list for 'tv' order with market 'Cambodia'
And 'should not' see order items with following clock numbers 'OTVDDOCN7_2' in 'draft' order list for 'tv' order with market 'Cambodia'

Scenario: Check that counters of draft orders is decreased in case to delete order
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVDDOA8 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVDDOU8 | agency.admin | OTVDDOA8     |
And logged in with details of 'OTVDDOU8'
And create 'tv' orders with following fields:
| Market     |
| Albania    |
| Armenia    |
| Australia  |
| Austria    |
When I go to View Draft Orders tab of 'tv' order on ordering page
And select orders with following markets 'Albania,Armenia' in 'draft' order list
And delete selected order in order list
Then I should see count orders '2' on 'View Draft Orders' tab in order slider
And should see orders counter '2' above orders list on ordering page

Scenario: Check that correct Order references are displayed on Are you sure you want to proceed confirmation popup
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| OTVDDOA9 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| OTVDDOU9 | agency.admin | OTVDDOA9     |
And logged in with details of 'OTVDDOU9'
And create 'tv' orders with following fields:
| Market  |
| Albania |
| Armenia |
When I go to View Draft Orders tab of 'tv' order on ordering page
And select orders with following markets 'Albania,Armenia' in 'draft' order list
Then I should see orders of markets 'Albania,Armenia' with correct order references on delete confirmation popup

Scenario: Check that correct Clock numbers are displayed on Are you sure you want to proceed confirmation popup
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVDDOA10 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVDDOU10 | agency.admin | OTVDDOA10    |
And logged in with details of 'OTVDDOU10'
And create 'tv' order with market 'Croatia' and items with following fields:
| Clock Number |
| OTVDDOCN10_1 |
| OTVDDOCN10_2 |
And create 'tv' order with market 'Bulgaria' and items with following fields:
| Clock Number |
| OTVDDOCN10_3 |
| OTVDDOCN10_4 |
When I go to View Draft Orders tab of 'tv' order on ordering page
And select order item with following clock number 'OTVDDOCN10_2' in 'draft' order list for 'tv' order with following market 'Croatia'
And select order item with following clock number 'OTVDDOCN10_3' in 'draft' order list for 'tv' order with following market 'Bulgaria'
Then I should see orders of markets '' with correct order references on delete confirmation popup
And should see order items with following clock numbers 'OTVDDOCN10_2,OTVDDOCN10_3' on delete confirmation popup

Scenario: Check that correct Order References and Clock numbers are displayed on Are you sure you want to proceed confirmation popup
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVDDOA11 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVDDOU11 | agency.admin | OTVDDOA11    |
And logged in with details of 'OTVDDOU11'
And create 'tv' order with market 'Australia' and items with following fields:
| Clock Number |
| OTVDDOCN11_1 |
| OTVDDOCN11_2 |
And create 'tv' order with market 'Austria' and items with following fields:
| Clock Number |
| OTVDDOCN11_3 |
| OTVDDOCN11_4 |
When I go to View Draft Orders tab of 'tv' order on ordering page
And select orders with following markets 'Australia' in 'draft' order list
And select order item with following clock number 'OTVDDOCN11_4' in 'draft' order list for 'tv' order with following market 'Austria'
Then I should see orders of markets 'Australia' with correct order references on delete confirmation popup
And should see order items with following clock numbers 'OTVDDOCN11_1,OTVDDOCN11_2,OTVDDOCN11_4' on delete confirmation popup