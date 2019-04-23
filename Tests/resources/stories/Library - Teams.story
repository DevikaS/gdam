!--NGN-5056 NGN-5087 NGN-4996 NGN-4646 NGN-5171
Feature:          Library - Teams
Narrative:
In order to
As a              AgencyAdmin
I want to         Check creating library teams on Users page

Scenario: Check that button 'Add to Team' is active if any user is select
Meta:@gdam
@library
Given I created users with following fields:
| Email   |
| U_LT_S1 |
When I search for user 'U_LT_S1' on Users page
And I select user 'U_LT_S1' on Users page
Then I 'should' see active 'Add to team' button on Users page


Scenario: Check that button 'Add to Team' is disable if any user is not select
Meta:@gdam
@library
Given I created users with following fields:
| Email   |
| U_LT_S2 |
When I search for user 'U_LT_S2' on Users page
And I select user 'U_LT_S2' on Users page
And I deselect user 'U_LT_S2' on Users page
Then I 'should not' see active 'Add to team' button on Users page


Scenario: Add users to existing Library Team
Meta:@gdam
@library
Given I created users with following fields:
| Email     |
| U_LT_S4_1 |
| U_LT_S4_2 |
| U_LT_S4_3 |
When I add '<UsersForNewTeam>' users to '<Teamname>' library team on Users list page
And I add '<UsersForExistingTeam>' users to '<Teamname>' library team on Users list page
And select library team '<Teamname>'
Then I 'should' see following users '<Users>' in '<Teamname>' users group

Examples:
| UsersForNewTeam     | UsersForExistingTeam | Teamname | Users                         |
| U_LT_S4_1,U_LT_S4_2 | U_LT_S4_3            | video_S4 | U_LT_S4_1,U_LT_S4_2,U_LT_S4_3 |


Scenario: Check that Library Teams accessible
Meta:@gdam
@library
Given I created users with following fields:
| Email     |
| U_LT_S5_1 |
| U_LT_S5_2 |
When I add 'U_LT_S5_1,U_LT_S5_2' users to 'LT_LT_S5' library team on Users list page
And select library team 'LT_LT_S5'
Then I 'should' see following users 'U_LT_S5_1, U_LT_S5_2' in 'LT_LT_S5' users group


Scenario: Check that new Library Team with existing name cannot be created
Meta:@gdam
@library
Given I created users with following fields:
| Email     |
| U_LT_S6_1 |
| U_LT_S6_2 |
When I add 'U_LT_S6_1' users to 'LT_LT_S6' library team on Users list page
And I search for user 'U_LT_S6_2' on Users page
And I select user 'U_LT_S6_2' on Users page
And I try to add 'LT_LT_S6' team name to Add to library team popup
Then I 'should not' see create new link near 'LT_LT_S6' group name on autocomplete form
And I 'should' see 'LT_LT_S6' group name in search results on autocomplete form


Scenario: Check that searching users in Library Team works correctly
Meta:@gdam
@library
Given I created users with following fields:
| Email     |
| U_LT_S9_1 |
| U_LT_S9_2 |
When I add 'U_LT_S9_1,U_LT_S9_2' users to 'LT_LT_S9' library team on Users list page
And select library team 'LT_LT_S9'
And search for users '<SearchText>' in library team
Then I 'should' see following users '<Result>' in 'LT_LT_S9' users group

Examples:
| SearchText | Result              |
| U_LT_S9    | U_LT_S9_1,U_LT_S9_2 |
| U_LT_S9_1  | U_LT_S9_1           |


Scenario: Check that User can be removed from Library Team
Meta:@gdam
@library
Given I created users with following fields:
| Email      |
| U_LT_S10_1 |
When I add 'U_LT_S10_1' users to 'LT_LT_S10' library team on Users list page
And I remove users 'U_LT_S10_1' from 'library' team 'LT_LT_S10'
Then I 'should not' see following users 'U_LT_S10_1' in 'LT_LT_S10' users group


Scenario: Check that count of users in Library Team correctly displayed quantity of users in this library team
Meta:@gdam
@library
Given I created users with following fields:
| Email      |
| U_LT_S13_1 |
| U_LT_S13_2 |
| U_LT_S13_3 |
| U_LT_S13_4 |
When I add 'U_LT_S13_1,U_LT_S13_2,U_LT_S13_3' users to 'LT_LT_S13' library team on Users list page
Then I 'should' see user count '3' on Users page
When I remove users 'U_LT_S13_2' from 'library' team 'LT_LT_S13'
And I go to library team 'LT_LT_S13' page
Then I 'should' see user count '2' on Users page
When I add 'U_LT_S13_4' users to 'LT_LT_S13' library team on Users list page
Then I 'should' see user count '3' on Users page


Scenario: Check that look up correctly works on Add to Library Team popup
Meta:@gdam
@library
Given I created users with following fields:
| Email    |
| U_LT_S14 |
When I search for user 'U_LT_S14' on Users page
And I select user 'U_LT_S14' on Users page
And I try to add 'LT_LT_S14' team name to Add to library team popup
Then I 'should' see create new link near 'LT_LT_S14' group name on autocomplete form
And I 'should not' see 'LT_LT_S14' group name in search results on autocomplete form


Scenario: Check that user can be added into several library team at the same time
Meta:@gdam
@library
Given I created users with following fields:
| Email    |
| U_LT_S17 |
When I add 'U_LT_S17' users to 'LT_LT_S17_1,LT_LT_S17_2' library teams on Users list page
And select library team 'LT_LT_S17_1'
Then I 'should' see 'U_LT_S17' user in 'LT_LT_S17_1' users group
When I select library team 'LT_LT_S17_2'
Then I 'should' see 'U_LT_S17' user in 'LT_LT_S17_2' users group


Scenario: Check that Library team can be deleted
Meta:@gdam
@library
Given I created users with following fields:
| Email    |
| U_LT_S18 |
When I add 'U_LT_S18' users to 'LT_LT_S18' library team on Users list page
And I delete library team 'LT_LT_S18'
Then 'should not' see 'LT_LT_S18' 'library' team on Users list page