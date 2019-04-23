!--NGN-9382
Feature:          BU partners
Narrative:
In order to
As a              GlobalAdmin
I want to         check that global admin can add partners for BU

Scenario: Check that after add BU1 as partner to BU2, BU1 should also contain BU2 in parners
Meta:@globaladmin
     @gdam
Given I created the agency 'A_BUP_S01_1' with default attributes
And created the agency 'A_BUP_S01_2' with default attributes
When I add following partners to agency 'A_BUP_S01_1' on partners page:
| Name        |
| A_BUP_S01_2 |
Then I 'should' see following partners on agency 'A_BUP_S01_2' partners page:
| Name        |
| A_BUP_S01_1 |


Scenario: Check that BU could contain more than 10 partners
Meta:@globaladmin
     @gdam
Given I created the agency 'A_BUP_S02' with default attributes
And created the agency 'A_BUP_S02_1' with default attributes
And created the agency 'A_BUP_S02_2' with default attributes
And created the agency 'A_BUP_S02_3' with default attributes
And created the agency 'A_BUP_S02_4' with default attributes
And created the agency 'A_BUP_S02_5' with default attributes
And created the agency 'A_BUP_S02_6' with default attributes
And created the agency 'A_BUP_S02_7' with default attributes
And created the agency 'A_BUP_S02_8' with default attributes
And created the agency 'A_BUP_S02_9' with default attributes
And created the agency 'A_BUP_S02_10' with default attributes
And created the agency 'A_BUP_S02_11' with default attributes
When I add following partners to agency 'A_BUP_S02' on partners page:
| Name         |
| A_BUP_S02_1  |
| A_BUP_S02_2  |
| A_BUP_S02_3  |
| A_BUP_S02_4  |
| A_BUP_S02_5  |
| A_BUP_S02_6  |
| A_BUP_S02_7  |
| A_BUP_S02_8  |
| A_BUP_S02_9  |
| A_BUP_S02_10 |
| A_BUP_S02_11 |
And refresh the page
Then I 'should' see following partners on agency 'A_BUP_S02' partners page:
| Name         |
| A_BUP_S02_1  |
| A_BUP_S02_2  |
| A_BUP_S02_3  |
| A_BUP_S02_4  |
| A_BUP_S02_5  |
| A_BUP_S02_6  |
| A_BUP_S02_7  |
| A_BUP_S02_8  |
| A_BUP_S02_9  |
| A_BUP_S02_10 |
| A_BUP_S02_11 |


Scenario: Check that BU could be removed from partners
Meta:@globaladmin
     @gdam
Given I logged in as 'GlobalAdmin'
And I created the agency 'A_BUP_S03' with default attributes
And created the agency 'A_BUP_S03_1' with default attributes
And created the agency 'A_BUP_S03_2' with default attributes
And created the agency 'A_BUP_S03_3' with default attributes
When I add following partners to agency 'A_BUP_S03' on partners page:
| Name        |
| A_BUP_S03_1 |
| A_BUP_S03_2 |
| A_BUP_S03_3 |
And wait for '2' seconds
And remove following partners 'A_BUP_S03_1' from agency 'A_BUP_S03' on partners page
Then I 'should not' see following partners on agency 'A_BUP_S03' partners page:
| Name        |
| A_BUP_S03_1 |
Then I 'should' see following partners on agency 'A_BUP_S03' partners page:
| Name        |
| A_BUP_S03_2 |
| A_BUP_S03_3 |


Scenario: Check that category couldn't be shared on non partner BU (non Parner BU shouldn't be in drop down and couldn't be entered in dropdown)
Meta:@globaladmin
     @gdam
Given I created the agency 'A_BUP_S04_1' with default attributes
And created the agency 'A_BUP_S04_2' with default attributes
And created users with following fields:
| Email     | Role         | Agency      |
| U_BUP_S04 | agency.admin | A_BUP_S04_1 |
And logged in with details of 'U_BUP_S04'
And created 'C_BUP_S04' category
When I click Add Agencies button for category 'C_BUP_S04'
And start type agency name 'A_BUP_S04_2' on Add Agencies popup
Then I 'should not' see agencies in the dropdown list according to text 'A_BUP_S04_2'
