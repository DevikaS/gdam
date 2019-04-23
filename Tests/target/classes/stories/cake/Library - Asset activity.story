!--NGN-3580 NGN-5078
Feature:          Library - Asset activity
Narrative:
In order to
As a              AgencyAdmin
I want to         Check asset activity

Meta:
@cake

Scenario: Check that filter works for uploaded activity appears on Activity tab of asset
Given I created users with following fields:
| FirstName | LastName | Email     | Role         |
| Clyde     | Donovan  | U_LAA_S01 | agency.admin |
When I login with details of 'U_LAA_S01'
And upload file '/files/image9.jpg' into library
And wait for '5' seconds
And I set Action 'Asset was transcoded' on asset Activity tab 'image9.jpg' activity page for collection 'My Assets'
And I type an userName 'U_LAA_S01' on asset Activity tab 'image9.jpg' activity page for collection 'My Assets'
And I click on filter button in Activity tab on asset Activity tab 'image9.jpg' activity page for collection 'My Assets'
Then I 'should' see the following activities on asset without refresh 'image9.jpg' activity page for collection 'My Assets':
| UserName  | Message              | Value |
| U_LAA_S01 | asset was transcoded |       |



