!--NGN-9387
Feature:          User receives Public link to Presentation in email notification if Public link is enabled for presentation
Narrative:
In order to
As a              AgencyAdmin
I want to         check that user receives Public link to Presentation in email notification if Public link is enabled for presentation


Scenario: Check that if presentation is set to Public, this public link should be included in all emails about this presentation share
Meta: @gdam
@gdamemails
Given I created users with following fields:
| Email           | Role         |Access|
| URPLPENPLEPN1_1 | agency.admin |streamlined_library,presentations|
| URPLPENPLEPN1_2 | agency.user  |streamlined_library,presentations|
And logged in with details of 'URPLPENPLEPN1_1'
And uploaded following assetsNEWLIB:
| Name               |
| /files/logo2.png   |
And waited while preview is visible on library page for collection 'Everything' for asset 'logo2.png'NEWLIB
And on library pageNEWLIB
And I have refreshed the page
And I add assets 'logo2.png' to new presentation 'URPLPENPLEPSP1' from collection 'Everything' pageNEWLIB
When I send presentation 'URPLPENPLEPSP1' by public link to user 'URPLPENPLEPN1_2' with personal message '123' with option 'Original + Proxy'
Then I should see shared public link from 'URPLPENPLEPSP1' in user email 'URPLPENPLEPN1_2' with subject 'has been shared with'


Scenario: Check that if presentation is set to Public, this public link should be included in all emails about this presentation share, unregistered user
Meta: @gdam
@gdamemails
Given I created users with following fields:
| Email           | Role         |Access|
| URPLPENPLEPN2_1 | agency.admin |streamlined_library,presentations|
And logged in with details of 'URPLPENPLEPN2_1'
And uploaded following assetsNEWLIB:
| Name               |
| /files/logo2.png   |
And waited while preview is visible on library page for collection 'Everything' for asset 'logo2.png'NEWLIB
And on library pageNEWLIB
And I have refreshed the page
And I add assets 'logo2.png' to new presentation 'URPLPENPLEPSP2' from collection 'Everything' pageNEWLIB
When I send presentation 'URPLPENPLEPSP2' by public link to user 'URPLPENPLEPN2_1' with personal message '123' with option 'Original + Proxy'
Then I should see shared public link from 'URPLPENPLEPSP2' in user email 'URPLPENPLEPN2_1' with subject 'has been shared with'

Scenario: Check that if presentation is set to Public and download is 'on' than unregistered user can download presentation
Meta: @gdam
@gdamemails
Given I created users with following fields:
| Email           | Role         |Access|
| URPLPENPLEPN3_1 | agency.admin |streamlined_library,presentations|
And logged in with details of 'URPLPENPLEPN3_1'
And uploaded following assetsNEWLIB:
| Name               |
| /files/logo2.png   |
And waited while preview is visible on library page for collection 'Everything' for asset 'logo2.png'NEWLIB
And on library pageNEWLIB
And I have refreshed the page
And I add assets 'logo2.png' to new presentation 'URPLPENPLEPSP3' from collection 'Everything' pageNEWLIB
When I send presentation 'URPLPENPLEPSP3' by public link to user 'URPLPENPLEPN3_1' with personal message '123' with option 'Original + Proxy'
And logout from account
And open link from email when user 'URPLPENPLEPN3_1' received email with next subject 'has been shared'
Then I 'should' see Download button on presentation preview page