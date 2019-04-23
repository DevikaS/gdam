Feature:          Agency - Markets
Narrative:
In order to
As a              AgencyAdmin
I want to         Validate agency markets on order creation page

Scenario: Check that default and meta markets are displayed on market page
Meta: @ordering
Given I created the agency 'OTVAMVAA1' with default attributes
And I logged in as 'GlobalAdmin'
When I go to agency 'OTVAMVAA1' market page
Then I 'should' see the following markets on market page:
|Market |Type   |
|Albania|default|
|DACH   |meta   |

Scenario: Check that custom market is created with default markets associated
Meta: @ordering
Given I created the agency 'OTVAMVAA2' with default attributes
And I logged in as 'GlobalAdmin'
When I go to agency 'OTVAMVAA2' create market page
And I create custom 'OTVAMVCM2' market
And I refresh the page
And I select the default market 'Albania' on edit market page
And I wait for '10' seconds
And I add destination group to custom market
And I click on save button on edit market page
And I wait for '5' seconds
And I 'should' see custom market 'OTVAMVCM2' on market page
When I click on custom 'OTVAMVCM2' market
Then I should see the destination groups added for custom market on edit market page

Scenario: Check that custom market is created with meta markets associated
Meta: @ordering
Given I created the agency 'OTVAMVAA3' with default attributes
And I logged in as 'GlobalAdmin'
When I go to agency 'OTVAMVAA3' create market page
And I create custom 'OTVAMVCM3' market
And I refresh the page
And I select the meta market 'DACH' on edit market page
And I wait for '20' seconds
And I add destination group to custom market
And I click on save button on edit market page
And I wait for '5' seconds
And I 'should' see custom market 'OTVAMVCM3' on market page
When I click on custom 'OTVAMVCM3' market
Then I should see the destination groups added for custom market on edit market page

Scenario: Check that custom market is editable
Meta: @ordering
Given I created the agency 'OTVAMVAA4' with default attributes
And I logged in as 'GlobalAdmin'
When I go to agency 'OTVAMVAA4' create market page
And I create custom 'OTVAMVCM4' market
And I refresh the page
And I select the default market 'Algeria' on edit market page
And I wait for '10' seconds
And I add destination group to custom market
And I click on save button on edit market page
And I wait for '5' seconds
And I 'should' see custom market 'OTVAMVCM4' on market page
And I click on custom 'OTVAMVCM4' market
And I edit custom 'OTVAMVECM4' market details
And I click on save button on edit market page
And I wait for '5' seconds
Then I 'should' see custom market 'OTVAMVECM4' on market page

Scenario: Check that custom market is deleted
Meta: @ordering
Given I created the agency 'OTVAMVAA5' with default attributes
And I logged in as 'GlobalAdmin'
When I go to agency 'OTVAMVAA5' create market page
And I create custom 'OTVAMVCM5' market
And I refresh the page
And I select the default market 'Algeria' on edit market page
And I wait for '10' seconds
And I add destination group to custom market
And I click on save button on edit market page
And I wait for '5' seconds
And I 'should' see custom market 'OTVAMVCM5' on market page
And I click on custom 'OTVAMVCM5' market
And I delete the custom market
And I wait for '5' seconds
Then I should see the custom market 'OTVAMVCM5' deleted on market page

Scenario: Check that custom market is displayed on market field on order creation page
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVAMVAA6 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVAMVU6 | agency.admin | OTVAMVAA6     |
And I logged in as 'GlobalAdmin'
When I go to agency 'OTVAMVAA6' create market page
And I create custom 'OTVAMVCM6' market
And I refresh the page
And I select the default market 'Albania' on edit market page
And I wait for '10' seconds
And I add destination group to custom market
And I click on save button on edit market page
And I wait for '5' seconds
Then I 'should' see custom market 'OTVAMVCM6' on market page
And I login with details of 'OTVAMVU6'
When I go to View Draft Orders tab of 'tv' order on ordering page
And I create 'tv' order on View Draft Orders tab on ordering page
Then I 'should' see available following markets 'OTVAMVCM6' on Select market popup on order item page

Scenario: Check that custom market is not displayed on market field on order creation page after deletion
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVAMVAA7 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVAMVU7 | agency.admin | OTVAMVAA7    |
And I logged in as 'GlobalAdmin'
When I go to agency 'OTVAMVAA7' create market page
And I create custom 'OTVAMVCM7' market
And I refresh the page
And I select the default market 'Algeria' on edit market page
And I wait for '10' seconds
And I add destination group to custom market
And I click on save button on edit market page
And I wait for '5' seconds
And I 'should' see custom market 'OTVAMVCM7' on market page
And I click on custom 'OTVAMVCM7' market
And I delete the custom market
And I wait for '5' seconds
And I login with details of 'OTVAMVU7'
And I go to View Draft Orders tab of 'tv' order on ordering page
And I create 'tv' order on View Draft Orders tab on ordering page
Then I 'should not' see available following markets 'OTVAMVCM7' on Select market popup on order item page

Scenario: Check that custom market is not displayed on market field on order creation page after hiding the custom market
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVAMVAA8 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVAMVU8 | agency.admin | OTVAMVAA8     |
And I logged in as 'GlobalAdmin'
When I go to agency 'OTVAMVAA8' create market page
And I create custom 'OTVAMVCM8' market
And I refresh the page
And I select the default market 'Albania' on edit market page
And I wait for '10' seconds
And I add destination group to custom market
And I click on save button on edit market page
And I wait for '5' seconds
Then I 'should' see custom market 'OTVAMVCM8' on market page
When I hide the custom 'OTVAMVCM8' market on market page
And I wait for '5' seconds
And I login with details of 'OTVAMVU8'
And I go to View Draft Orders tab of 'tv' order on ordering page
And I create 'tv' order on View Draft Orders tab on ordering page
Then I 'should not' see available following markets 'OTVAMVCM8' on Select market popup on order item page

Scenario: Check that default market is not displayed on market field on order creation page after hiding the default market
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVAMVAA9 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVAMVU9 | agency.admin | OTVAMVAA9     |
And I logged in as 'GlobalAdmin'
When I go to agency 'OTVAMVAA9' market page
And I hide the default 'Albania' market on market page
And I wait for '5' seconds
And I login with details of 'OTVAMVU9'
And I go to View Draft Orders tab of 'tv' order on ordering page
And I create 'tv' order on View Draft Orders tab on ordering page
Then I 'should not' see available following markets 'Albania' on Select market popup on order item page

Scenario: Check that meta market is not displayed on market field on order creation page after hiding the meta market
Meta: @ordering
Given I created the following agency:
| Name    | A4User        |
| OTVAMVAA10 | DefaultA4User |
And created users with following fields:
| Email   | Role         | AgencyUnique |
| OTVAMVU10 | agency.admin | OTVAMVAA10     |
And I logged in as 'GlobalAdmin'
When I go to agency 'OTVAMVAA10' market page
And I hide the meta 'MENA' market on market page
And I wait for '5' seconds
And I login with details of 'OTVAMVU10'
And I go to View Draft Orders tab of 'tv' order on ordering page
And I create 'tv' order on View Draft Orders tab on ordering page
Then I 'should not' see available following markets 'MENA' on Select market popup on order item page

Scenario: Check that list of markets displayed on destination page
Meta: @ordering
Given I created the agency 'OTVAMVAA11' with default attributes
And I logged in as 'GlobalAdmin'
And I am on agency 'OTVAMVAA11' destination page
Then I should see the group of markets 'UK markets,AU markets' displayed on destination page

Scenario: Check that destination group  is displayed for meta market on destination page
Meta: @ordering
Given I created the agency 'OTVAMVAA12' with default attributes
And I logged in as 'GlobalAdmin'
And I am on agency 'OTVAMVAA12' destination page
And I select the market 'UK markets' from dropdown on destination page
And I waited for '5' seconds
And I select the default market 'Argentina' on destination page
And I waited for '10' seconds
Then I should see the destination groups for the market on destination page

Scenario: Check that destination group  is displayed for default market on destination page
Meta: @ordering
Given I created the agency 'OTVAMVAA13' with default attributes
And I logged in as 'GlobalAdmin'
And I am on agency 'OTVAMVAA13' destination page
And I select the market 'AU markets' from dropdown on destination page
And I waited for '5' seconds
And I select the meta market 'MENA' on destination page
And I waited for '10' seconds
Then I should see the destination groups for the market on destination page

Scenario: Check that default market and meta markets are displayed on destination page for slected market group
Meta: @ordering
Given I created the agency 'OTVAMVAA14' with default attributes
And I logged in as 'GlobalAdmin'
And I am on agency 'OTVAMVAA14' destination page
And I select the market '<Market>' from dropdown on destination page
And I waited for '5' seconds
Then I 'should' see the following markets on destination page:
|Type|
|<Type>|

Examples:
|Market	|Type	|
|AU markets	|default	|
|UK markets	|meta	|


Scenario: Check that default and meta markets are displayed on market page when BU is created for Australia
Meta: @ordering
Given I created the following agency:
| Name      | A4User        |Labels|
| OTVAMVAA15 | DefaultA4User |au,dubbing_services,nVerge,Physical,FTP,production_services |
And I logged in as 'GlobalAdmin'
When I go to agency 'OTVAMVAA15' market page
Then I 'should' see the following markets on market page:
|Market |Type   |
|All Regional |default |
|Australia and New Zealand |meta |


