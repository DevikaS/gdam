!-- NGN-132
Feature:          Delete folder from template - trash bin
Narrative:
In order to
As a              AgencyAdmin
I want to         Check moving folder/subfolders and files to trash bin


Scenario: Check that after delete folders,they should be removed from ui(for template)
Meta:@gdam
@projects
Given I created 'HUT2' template
And created in 'HUT2' template next folders:
| folder       |
| /tes         |
| /tes/upd     |
| /tes/upd/ert |
| /Lol         |
| /Lol2        |
When I delete folder '/tes' in template 'HUT2'
Then I should see following folders in 'HUT2' template:
| folder      | should     |
| /tes        | should not |


Scenario: Check that trash bin should not be visible(for template)
Meta:@gdam
@projects
!--NGN-2846
Given I created 'PTF2_1' template
When I go to template 'PTF2_1' files page
Then I 'should not' see element 'TrashBin' on page 'FilesPage'