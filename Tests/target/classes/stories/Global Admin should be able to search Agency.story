!--NGN-16208-- Created By Geethanjali.K

Feature: Global Admin should be able to search Agency
Narrative:
In order to:
As a GlobalAdmin
I want to check correct work of searching Agency under Global Admin

Scenario: Check Agency searching by Type
Meta: @bug
     @gdam
     @globaladmin
!--FAB-462 ---Only example 2 and 3 will fail.
Given I created the following agency:
| Name                  | A4User        | AgencyType  |  Country        |
|  <Business_Unit name> | DefaultA4User | <Type>      | <Country>       |
And I logged in as 'GlobalAdmin'
And I am on the global search BU page
When I fill following fields on the global search BU page:
| AgencyType    |
| <Type>        |
And do searching on the global search BU page
Then I should see following BU s on the global search Agency page:
| Business Unit name    | Type          | Country    |
| <Business_Unit name>  | <Type>        | <Country>  |


Examples:
| Business_Unit name | Type             | Country        |
| GASASUAD_1         |  agency          |  Afghanistan   |
| GASASUAD_2         |  Advertiser      |  France        |
| GASASUAD_3         |  Publisher       |  Italy         |



Scenario: Check Agency searching by Business Unit-Exact string search
Meta:@gdam
     @globaladmin
Given I created the following agency:
| Name                 | A4User        | AgencyType   |  Country           |
| <Business_Unit name> | DefaultA4User | <AgencyType> |  <Country>         |
And I logged in as 'GlobalAdmin'
And I am on the global search BU page
When I fill following fields on the global search BU page:
| Business_Unit name                    |
| <searchBusiness Unit name>            |
And do searching on the global search BU page
Then I should see following BU s on the global search Agency page:
| Business Unit name    | Country    |
| <Business_Unit name>  | <Country>  |

Examples:
| Business_Unit name | AgencyType     | Country        | searchBusiness Unit name |
| GASASUC4           | agency         | Algeria        |  GASASUC4                |


Scenario: Check Agency searching by Business Unit-Partial string search
Meta:@gdam
     @globaladmin
Given I created the following agency:
| Name                 | A4User        | AgencyType   |  Country           |
| <Business_Unit name> | DefaultA4User | <AgencyType> |  <Country>         |
And I logged in as 'GlobalAdmin'
And I am on the global search BU page
When I fill following fields on the global search BU page without Testsession:
| Business_Unit name                    |
| <searchBusiness Unit name>            |
And do searching on the global search BU page
Then I should see following BU s on the global search Agency page:
| Business Unit name    | Country    |
| <Business_Unit name>  | <Country>  |


Examples:
| Business_Unit name | AgencyType     | Country        | searchBusiness Unit name |
| GASASUC5           | agency         | Algeria        |  GASASUC5                |



Scenario: Check Agency searching by Country
Meta:@gdam
     @globaladmin
Given I created the following agency:
| Name                 | A4User        | AgencyType   |  Country           |
| <Business_Unit name> | DefaultA4User | <AgencyType> |  <Country>         |
And I logged in as 'GlobalAdmin'
And I am on the global search BU page
When I fill following fields on the global search BU page:
| Country             |
| <Country>           |
And do searching on the global search BU page
Then I should see following BU s on the global search Agency page:
| Business Unit name    |Country    |
| <Business_Unit name>  |<Country>  |


Examples:
| Business_Unit name | AgencyType    | Country                              |
| GASASUB1           | agency        | France                               |
| GASASUB2           | Advertiser    | Tanzania, United Republic of         |
| GASASUB3           | Media Agency  | United States Minor Outlying Islands |

Scenario: Check Agency searching by all fields together
Meta:@gdam
     @globaladmin
Given I created the following agency:
| Name     | A4User        | AgencyType  |  Country        |
| GASASUA1 | DefaultA4User | agency      |  Belgium        |
And I logged in as 'GlobalAdmin'
And I am on the global search BU page
When I fill following fields on the global search BU page:
| Country    |  AgencyType        |  Business_Unit name  |
| Belgium    |  agency            |  GASASUA1            |
And do searching on the global search BU page
Then I should see following BU s on the global search Agency page:
| Business Unit name | Type   | Country        |
| GASASUA1           | agency | Belgium        |


Scenario: Check negative result while Agency searching in case one of searching criteria is wrong
Meta:@gdam
     @globaladmin
Given I created the following agency:
| Name                  | A4User        |  AgencyType        |  Country   |
| <Business_Unit name>  | DefaultA4User | <AgencyType>       |  <Country> |
And I logged in as 'GlobalAdmin'
And I am on the global search BU page
When I fill following fields on the global search BU page:
  |   Business_Unit name        |  AgencyType         | Country         |
  |  <searchBu>                 | <searchType>        | <searchPlace>   |
And do searching on the global search BU page
Then I 'should' see no results on the global search Agency page
Examples:
| Business_Unit name | AgencyType       |  Country       | searchBu                 | searchType              | searchPlace          |
| GASASUAA_1         |   Agency         |  Afghanistan   | GASASUAA_19              | Agency                  | Afghanistan          |
| GASASUAA_2         |   Advertiser     |  France        | GASASUAA_2               |TV Broadcaster           | France               |


Scenario: Check Agency searching by Business Unit-using '*'
Meta:@gdam
     @globaladmin
Given I created the following agency:
| Name                 | A4User        | AgencyType   |  Country           |
| <Business_Unit name> | DefaultA4User | <AgencyType> |  <Country>         |
And I logged in as 'GlobalAdmin'
And I am on the global search BU page
When I fill following fields on the global search BU page without Testsession:
| Business_Unit name                    |
| <searchBusiness Unit name>            |
And do searching on the global search BU page
Then I should see following BU s on the global search Agency page:
| Business Unit name    | Country    |
| <Business_Unit name>  | <Country>  |
Examples:
| Business_Unit name | AgencyType     | Country        | searchBusiness Unit name |
| GASASUC8           | agency         | Angola         |  *                       |
| GASASUC9           | agency         | Angola         |  GASASUC*                |























