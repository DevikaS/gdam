!--ORD-375
!--ORD-713
Feature: Table settings should be specific for active filters
Narrative:
In order to:
As a AgencyAdmin
I want to check table settings for active filters

Scenario: Check that column disappears after unchecking column on table settings
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVTSAFA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVTSAFU1 | agency.admin | OTVTSAFA1    |
And logged in with details of 'OTVTSAFU1'
When I go to View Draft Orders tab of 'tv' order on ordering page
And fill following checkboxes for column filters settings on ordering page:
| Order #  | Date & Time | Advertiser   | Market   | No Clocks  | Creator   |
| <Order#> | <DateTime>  | <Advertiser> | <Market> | <NoClocks> | <Creator> |
Then I 'should not' see column '<Name>' for order list on ordering page

Examples:
| Order#     | DateTime   | Advertiser | Market     | NoClocks   | Creator    | Name         |
| should not | should     | should     | should     | should     | should     | Order #      |
| should     | should not | should     | should     | should     | should     | Date Created |
| should     | should     | should not | should     | should     | should     | Advertiser   |
| should     | should     | should     | should not | should     | should     | Market       |
| should     | should     | should     | should     | should not | should     | No. Clocks   |
| should     | should     | should     | should     | should     | should not | Creator      |

Scenario: Check correct work of Restore to default button
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVTSAFA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVTSAFU1 | agency.admin | OTVTSAFA1    |
And logged in with details of 'OTVTSAFU1'
When I go to View Draft Orders tab of 'tv' order on ordering page
And fill following checkboxes for column filters settings on ordering page:
| Order #  | Date & Time | Advertiser   | Market   | No Clocks  | Creator   |
| <Order#> | <DateTime>  | <Advertiser> | <Market> | <NoClocks> | <Creator> |
And restore to default column filters settings on ordering page
Then I 'should' see column '<Name>' for order list on ordering page

Examples:
| Order#     | DateTime   | Advertiser | Market     | NoClocks   | Creator    | Name         |
| should not | should     | should     | should     | should     | should     | Order #      |
| should     | should not | should     | should     | should     | should     | Date Created |
| should     | should     | should not | should     | should     | should     | Advertiser   |
| should     | should     | should     | should not | should     | should     | Market       |
| should     | should     | should     | should     | should not | should     | No. Ads      |
| should     | should     | should     | should     | should     | should not | Creator      |

Scenario: Table settings should be specific for active filters (View Live Orders)
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVTSAFA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVTSAFU1 | agency.admin | OTVTSAFA1    |
And logged in with details of 'OTVTSAFU1'
When I go to View Draft Orders tab of 'tv' order on ordering page
And fill following checkboxes for column filters settings on ordering page:
| Order #  | No Clocks  |
| <Order#> | <NoClocks> |
And select 'View Live Orders' tab on ordering page
Then I 'should' see column '<Name>' for order list on ordering page

Examples:
| Order#     | NoClocks   | Name     |
| should not | should     | Order #  |
| should     | should not | No. Ads  |

Scenario: Table settings should be specific for active filters (View Held Orders)
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVTSAFA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVTSAFU1 | agency.admin | OTVTSAFA1    |
And logged in with details of 'OTVTSAFU1'
When I go to View Draft Orders tab of 'tv' order on ordering page
And fill following checkboxes for column filters settings on ordering page:
| No Clocks  | Advertiser   |
| <NoClocks> | <Advertiser> |
And select 'View Held Orders' tab on ordering page
Then I 'should' see column '<Name>' for order list on ordering page

Examples:
| NoClocks   | Advertiser | Name       |
| should not | should     | No. Ads    |
| should     | should not | Advertiser |

Scenario: Table settings should be specific for active filters (View Completed Orders)
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVTSAFA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVTSAFU1 | agency.admin | OTVTSAFA1    |
And logged in with details of 'OTVTSAFU1'
When I go to View Draft Orders tab of 'tv' order on ordering page
And fill following checkboxes for column filters settings on ordering page:
| Order #  | Market   |
| <Order#> | <Market> |
And select 'View Completed Orders' tab on ordering page
Then I 'should' see column '<Name>' for order list on ordering page

Examples:
| Order#     | Market     | Name        |
| should not | should     | Order #     |
| should     | should not | Market      |

Scenario: Check that Restore to default work per tab
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVTSAFA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVTSAFU1 | agency.admin | OTVTSAFA1    |
And logged in with details of 'OTVTSAFU1'
When I go to View Draft Orders tab of 'tv' order on ordering page
And fill following checkboxes for column filters settings on ordering page:
| Order #    |
| should not |
And select 'View Live Orders' tab on ordering page
And fill following checkboxes for column filters settings on ordering page:
| Advertiser |
| should not |
And select 'View Draft Orders' tab on ordering page
And restore to default column filters settings on ordering page
And select 'View Live Orders' tab on ordering page
Then I 'should not' see column 'Advertiser' for order list on ordering page

Scenario: Check that after reloading page table settings are saved
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |
| OTVTSAFA1 | DefaultA4User |
And created users with following fields:
| Email     | Role         | AgencyUnique |
| OTVTSAFU1 | agency.admin | OTVTSAFA1    |
And logged in with details of 'OTVTSAFU1'
When I go to View Draft Orders tab of 'tv' order on ordering page
And fill following checkboxes for column filters settings on ordering page:
| Order #    |
| should not |
And refresh the page without delay
Then I 'should not' see column 'Order #' for order list on ordering page