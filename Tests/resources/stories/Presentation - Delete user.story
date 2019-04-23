!--NGN-2524
Feature:          Delete users from Presentation
Narrative:
In order to
As a              AgencyAdmin
I want to         Check removing users from Presentation

Meta:
@component presentation


Scenario: Check that removed user no longer be able to access presentation
Meta:@gdam
@library
Given I created users with following fields:
| Email       | Role       | Agency       |
| <UserEmail> | <UserRole> | <UserAgency> |
And I created following reels:
| Name              |
| <Name> |
And uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And I am on Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'NEWLIB
And I added asset 'Fish Ad.mov' into existing presentation '<Name>' from collection 'Everything'NEWLIB
And I am on the presentations assets page '<Name>'
When send presentation '<Name>' to user '<UserEmail>' with personal message 'Message'
And delete share for '<UserEmail>' agency user from '<Name>' presentation
And login with details of '<UserEmail>'
And open link from letter with subject '<Name>' for presentation
Then I should see message exclamation 'Sorry, this does not appear to be a valid presentation. Please check the details you received.'
And I 'should not' see presentation preview

Examples:
| UserEmail    | UserRole    | UserAgency    | Name |
| AU_PDU_S02_1 | agency.user | DefaultAgency | P_PDU_S02_1      |
| AU_PDU_S02_2 | guest.user  | DefaultAgency | P_PDU_S02_2      |


Scenario: Check that already opened presentation becomes not available after delete user from share
Meta:@gdam
@library
Given I created users with following fields:
| Email      | Role        | Agency        |
| AU_PDU_S03 | agency.user | DefaultAgency |
And uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And I am on Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'NEWLIB
And I add assets 'Fish Ad.mov' to new presentation 'P_PDU_S03' from collection 'Everything' pageNEWLIB
And I am on the presentations assets page 'P_PDU_S03'
When I send presentation 'P_PDU_S03' to user 'AU_PDU_S03' with personal message 'Message'
And login with details of 'AU_PDU_S03'
And open link from letter with subject 'P_PDU_S03' for presentation without message deleting
Then I 'should' see presentation preview
When I logout from account
And I login as 'AgencyAdmin'
And go to the presentations assets page 'P_PDU_S03'
And delete share for 'AU_PDU_S03' agency user from 'P_PDU_S03' presentation
And login with details of 'AU_PDU_S03'
And open link from letter with subject 'P_PDU_S03' for presentation
Then I should see message exclamation 'Sorry, this does not appear to be a valid presentation. Please check the details you received.'
And I 'should not' see presentation preview



Scenario: Check that presentation can be shared again on user, even earlier it user was deleted from share
Meta:@gdam
@library
Given I created users with following fields:
| Email      | Role        | Agency        |
| AU_PDU_S04 | agency.user | DefaultAgency |
And uploaded following assetsNEWLIB:
| Name               |
| /files/Fish Ad.mov |
And I am on Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for asset 'Fish Ad.mov'NEWLIB
And I add assets 'Fish Ad.mov' to new presentation 'P_PDU_S04' from collection 'Everything' pageNEWLIB
And I am on the presentations assets page 'P_PDU_S04'
When I send presentation 'P_PDU_S04' to user 'AU_PDU_S04' with personal message 'Message'
And delete share for 'AU_PDU_S04' agency user from 'P_PDU_S04' presentation
And send presentation 'P_PDU_S04' to user 'AU_PDU_S04' with personal message 'Message'
And login with details of 'AU_PDU_S04'
And open link from letter with subject 'P_PDU_S04' for presentation
Then I should see for user 'AgencyAdmin' following assets for presentation 'P_PDU_S04' on the preview page:
| Name        | Should |
| Fish Ad.mov | should |


