!--NGN-4219  NGN-4915
Feature:          Agency Admin - Teams - Add ability to remove Library team and user from team
Narrative:
In order to
As a              AgencyAdmin
I want to         Check remove Teams and users in Admin>Users--Remove Agency Project teams and user from it,was described in NGN-4779

Scenario: Check that Library team could be deleted
Meta:@gdam
     @library
Given I created 'AdtauFT_U1' User
When I add 'AdtauFT_U1' users to 'LibraryTeam' library team on Users list page
And I delete library team 'LibraryTeam'
Then 'should not' see 'LibraryTeam' 'library' team on Users list page


Scenario: Check that new Library Team with name of just deleted one can be created and will be different
Meta:@gdam
     @library
Given I created 'AdtauFT_U5' User
And I added 'AdtauFT_U5' users to 'AdtauFTLibTeam3' library team on Users list page
And I deleted library team 'AdtauFTLibTeam3'
When I add 'AdtauFT_U5' users to 'AdtauFTLibTeam3' library team on Users list page
Then I 'should' see 'AdtauFTLibTeam3' 'library' team on Users list page
And I 'should' see 'AdtauFT_U5' user in 'AdtauFTLibTeam3' users group


Scenario: Check that if delete last user from library Team, team should not be deleted
Meta:@gdam
     @library
Given I created 'AdtauFT_U6' User
And I added 'AdtauFT_U6' users to 'AdtauFTLibTeam6' library team on Users list page
When I remove users 'AdtauFT_U6' from 'library' team 'AdtauFTLibTeam6'
Then I 'should' see 'AdtauFTLibTeam6' 'library' team on Users list page


Scenario: Check that just removed User from library Team can be added again
!--bug NGN-5283 (Agency admin - Teams: not correct results of search of library team in 'Add to team popup')
Meta:@gdam
     @library
Given I created 'AdtauFT_U7' User
And I added 'AdtauFT_U7' users to 'AdtauFTLibTeam7' library team on Users list page
And I removed users 'AdtauFT_U7' from 'library' team 'AdtauFTLibTeam7'
When I add 'AdtauFT_U7' users to 'AdtauFTLibTeam7' library team on Users list page
Then I 'should' see 'AdtauFT_U7' user in 'AdtauFTLibTeam7' users group


Scenario: Check that after remove user from team, he still available in 'All users' list
Meta:@gdam
     @library
Given I created 'AdtauFT_U8' User
And I added 'AdtauFT_U8' users to 'AdtauFTLibTeam8' library team on Users list page
When I remove users 'AdtauFT_U8' from 'library' team 'AdtauFTLibTeam8'
And I go to User list page
Then I 'should' see 'AdtauFT_U8' in User list


Scenario: Check that after remove Library team with users, users still available in 'All users' list
Meta:@gdam
     @library
Given I created 'AdtauFT_U9' User
And I added 'AdtauFT_U9' users to 'AdtauFTLibTeam9' library team on Users list page
When I delete library team 'AdtauFTLibTeam9'
Then I 'should' see 'AdtauFT_U9' in User list