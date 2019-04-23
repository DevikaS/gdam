!--NGN-13218
!--ORD-4887
Feature: Global Admin should be able to search Users
Narrative:
In order to:
As a GlobalAdmin
I want to check correct work of searching users under Global Admin

Scenario: Check user searching by email
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| GASASUA1 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| GASASUU1 | agency.admin | GASASUA1     |
And I am on the global search users page
When I fill following fields on the global search users page:
| Email    |
| GASASUU1 |
And do searching on the global search users page
Then I should see following users on the global search users page:
| User     | Business Unit |
| GASASUU1 | GASASUA1      |

Scenario: Check user searching by First Name
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| GASASUA1 | DefaultA4User |
And created users with following fields:
| Email    | FirstName | Role         | AgencyUnique |
| GASASUU2 | GASASUFN2 | agency.admin | GASASUA1     |
And I am on the global search users page
When I fill following fields on the global search users page:
| First Name |
| GASASUFN2  |
And do searching on the global search users page
Then I should see following users on the global search users page:
| User     | Business Unit |
| GASASUU2 | GASASUA1      |

Scenario: Check user searching by Last Name
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| GASASUA1 | DefaultA4User |
And created users with following fields:
| Email    | LastName  | Role         | AgencyUnique |
| GASASUU3 | GASASULN3 | agency.admin | GASASUA1     |
And I am on the global search users page
When I fill following fields on the global search users page:
| Last Name |
| GASASULN3 |
And do searching on the global search users page
Then I should see following users on the global search users page:
| User     | Business Unit |
| GASASUU3 | GASASUA1      |

Scenario: Check user searching by BU
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| GASASUA4 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| GASASUU4 | agency.admin | GASASUA4     |
And I logged in as 'GlobalAdmin'
And I am on the global search users page
And refreshed the page without delay
When I fill following fields on the global search users page:
| Business Unit |
| GASASUA4      |
And do searching on the global search users page
Then I should see following users on the global search users page:
| User     | Business Unit |
| GASASUU4 | GASASUA4      |

Scenario: Check user searching by all fields together
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| GASASUA5 | DefaultA4User |
And created users with following fields:
| Email    | FirstName | LastName  | Role         | AgencyUnique |
| GASASUU5 | GASASUFN5 | GASASULN5 | agency.admin | GASASUA5     |
And I am on the global search users page
And refreshed the page without delay
When I fill following fields on the global search users page:
| First Name | Last Name | Email    | Business Unit |
| GASASUFN5  | GASASULN5 | GASASUU5 | GASASUA5      |
And do searching on the global search users page
Then I should see following users on the global search users page:
| User     | Business Unit |
| GASASUU5 | GASASUA5      |

Scenario: Check negative result while user searching
Meta: @ordering
Given I am on the global search users page
When I fill following fields on the global search users page:
| First Name  | Last Name  | Email   |
| <FirstName> | <LastName> | <Email> |
And do searching on the global search users page
Then I 'should' see noone user on the global search users page

Examples:
| FirstName | LastName  | Email    |
| GASASUFN6 |           |          |
|           | GASASULN6 |          |
|           |           | GASASUU6 |

Scenario: Check negative result while user searching in case one of searching criteria is wrong
Meta: @ordering
Given I created the following agency:
| Name     | A4User        |
| GASASUA7 | DefaultA4User |
And created users with following fields:
| Email    | FirstName | LastName  | Role         | AgencyUnique |
| GASASUU7 | GASASUFN7 | GASASULN7 | agency.admin | GASASUA7     |
And I am on the global search users page
And refreshed the page without delay
When I fill following fields on the global search users page:
| First Name  | Last Name  | Email   |  Business Unit |
| <FirstName> | <LastName> | <Email> |  GASASUA7      |
And do searching on the global search users page
Then I 'should' see noone user on the global search users page

Examples:
| FirstName   | LastName    | Email      |
| GASASUFN7_1 | GASASULN7   | GASASUU7   |
| GASASUFN7   | GASASULN7_1 | GASASUU7   |
| GASASUFN7   | GASASULN7   | GASASUU7_1 |

Scenario: Check Email field validation
Meta: @ordering
Given I am on the global search users page
When I fill following fields on the global search users page:
| Email     |
| GASASUU8@ |
Then I 'should' see validation error for following fields 'Email' on the global search users page

Scenario: Check clearing of Business Unit
!--Invalid as there is no clear button any longer
Meta: @ordering
      @skip
Given I created the following agency:
| Name     | A4User        |
| GASASUA9 | DefaultA4User |
And created users with following fields:
| Email    | Role         | AgencyUnique |
| GASASUU9 | agency.admin | GASASUA9     |
And I am on the global search users page
And refreshed the page without delay
When I fill following fields on the global search users page:
| Business Unit |
| GASASUA9      |
And clear chosen Business Unit on the global search users page
Then I should see following data on the global search users page:
| First Name | Last Name | Email | Business Unit |
|            |           |       |               |