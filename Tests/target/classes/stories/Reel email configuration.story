!--NGN-538 NGN-3391
Feature:          Reel email configuration
Narrative:
In order to
As a              AgencyAdmin
I want to         Check reel email configuration


Scenario: Check that not registered user receives email notification if presentation is sent to him
Meta: @skip
      @gdam
      @gdamemails
Given I created the following agency:
| Name      |
| A_REC_S01 |
And created users with following fields:
| FirstName | LastName | Email     | AgencyUnique | Role         |
| Eric      | Cartman  | U_REC_S01 | A_REC_S01    | agency.admin |
And logged in with details of 'U_REC_S01'
And uploaded file '/files/Fish1-Ad.mov' into library
And I am on the Library page for collection 'Everything'
And added asset 'Fish1-Ad.mov' into new presentation 'P_REC_S01' with description 'Desctiption'
When I send presentation 'P_REC_S01' to user 'U_REC_S01_NA' with personal message 'Hello U_REC_S01_NA!'
And wait for '5' seconds
Then I 'should' see email notification for 'Shared presentation' with field to 'U_REC_S01_NA' and subject 'has been shared with you' contains following attributes:
| Agency    | Message             | PresentationName | UserName  |
| A_REC_S01 | Hello U_REC_S01_NA! | P_REC_S01        | U_REC_S01 |


Scenario: Check that registered user receives email notification if presentation is sent to him
Meta:@gdam
@library
Given I created the following agency:
| Name        |
| A_REC_S02_1 |
And created users with following fields:
| FirstName | LastName   | Email        | AgencyUnique | Role         |Access|
| Stan      | Marsh      | AU_REC_S02_1 | A_REC_S02_1  | agency.admin |streamlined_library,presentations|
| Kyle      | Broflovski | U_REC_S02_1  | A_REC_S02_1  | agency.user  |streamlined_library,presentations|
And logged in with details of 'U_REC_S02_1'
And set following notification settings for user:
| UserEmail      | SettingName              | SettingState |
|U_REC_S02_1     | presentationShared       | on           |
And logged in with details of 'AU_REC_S02_1'
And uploaded file '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name                |
| Fish1-Ad.mov         |
And I am on the Library page for collection 'Everything'NEWLIB
And I add assets 'Fish1-Ad.mov' to new presentation 'P_REC_S02_1' from collection 'Everything' pageNEWLIB
When I send presentation 'P_REC_S02_1' to user 'U_REC_S02_1' with personal message 'Hello Kyle Broflovski!'
And wait for '5' seconds
Then I 'should' see email notification for 'Shared presentation' with field to 'U_REC_S02_1' and subject 'has been shared with' contains following attributes:
| Agency      | Message                | PresentationName | UserName     |
| A_REC_S02_1 | Hello Kyle Broflovski! | P_REC_S02_1      | AU_REC_S02_1 |


Scenario: Check that user goes directly to presentation preview of presentation sent to him if user uses link from received email about sharing presentation
Meta:@gdam
@library
Given I created users with following fields:
| FirstName | LastName  | Email     | Role        |Access|
| Kenny     | McCormick | U_REC_S03 | agency.user |streamlined_library,presentations|
And uploaded file '/files/Fish1-Ad.mov' into libraryNEWLIB
And I am on the Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for asset 'Fish1-Ad.mov'NEWLIB
And I add assets 'Fish1-Ad.mov' to new presentation 'P_REC_S03' from collection 'Everything' pageNEWLIB
And sent presentation 'P_REC_S03' to user 'U_REC_S03' with personal message 'Hello Kenny McCormick!'
And waited for '5' seconds
When I login with details of 'U_REC_S03'
And open link from email with shared presentation 'P_REC_S03' which user 'U_REC_S03' received
Then I 'should' see for user 'AgencyAdmin' presentation name 'P_REC_S03' for current preview
And should see for user 'AgencyAdmin' following assets for presentation 'P_REC_S03' on the preview page:
| Name         | Should |
| Fish1-Ad.mov | should |


Scenario: Check that email notification about Reel file downloaded sent to owner after downloading files of assets included in presentation
Meta:@gdam
     @bug
     @library
!--Confirmed with Maria that there is a bug FAB-452 --No emails are triggered when a shared presentation is downloaded.U1_REC_S05_1 & U1_REC_S05_3 would fail
Given I created the following agency:
| Name         |
| <UserAgency> |
And created users with following fields:
| FirstName | LastName  | Email        | AgencyUnique | Role         |Access|
| Kevin     | McCormick | <AdminUser1> | <UserAgency> | agency.admin |streamlined_library,presentations|
| Karen     | McCormick | <AdminUser2> | <UserAgency> | agency.admin |streamlined_library,presentations|
And logged in with details of '<AdminUser1>'
And I am on user '<AdminUser1>' Notifications Settings page
And set following notification settings for users:
| UserEmail    | SettingName             | SettingState |
| <AdminUser1> | Presentation Downloaded | <State>      |
And saved current user notifications setting
And logged in with details of '<AdminUser1>'
And uploaded file '/files/Fish1-Ad.mov' into libraryNEWLIB
And I am on the Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for asset 'Fish1-Ad.mov'NEWLIB
And I add assets 'Fish1-Ad.mov' to new presentation '<PresentationName>' from collection 'Everything' pageNEWLIB
When I send presentation '<PresentationName>' to user '<AdminUser2>' with personal message 'Hello Karen McCormick!'
And login with details of '<AdminUser2>'
And open link from email with shared presentation '<PresentationName>' which user '<AdminUser2>' received
And wait for '5' seconds
And click element 'DownloadLink' on page 'PresentationPreview'
And click element '<DownloadButton>' on page 'PresentationPreview'
And wait for '5' seconds
Then I '<Condition>' see email notification for 'Downloaded presentation' with field to '<AdminUser1>' and subject 'has been downloaded' contains following attributes:
| Agency       | PresentationName   | UserName     |
| <UserAgency> | <PresentationName> | <AdminUser2> |

Examples:
| AdminUser1   | AdminUser2   | UserAgency  | PresentationName | State | DownloadButton      | Condition  |
| U1_REC_S05_1 | U2_REC_S05_1 | A_REC_S05_1 | P_REC_S05_1      | on    | ProxyFilesButton    | should     |
| U1_REC_S05_2 | U2_REC_S05_2 | A_REC_S05_2 | P_REC_S05_2      | off   | ProxyFilesButton    | should not |
| U1_REC_S05_3 | U2_REC_S05_3 | A_REC_S05_3 | P_REC_S05_3      | on    | OriginalFilesButton | should     |
| U1_REC_S05_4 | U2_REC_S05_4 | A_REC_S05_4 | P_REC_S05_4      | off   | OriginalFilesButton | should not |


Scenario: Check that email is sent with updated reel name
Meta:@gdam
@library
Given I created the following agency:
| Name        |
| A_REC_S07_1 |
And created users with following fields:
| FirstName | LastName | Email        | AgencyUnique | Role         |Access|
| Linda     | Stotch   | U1_REC_S07_1 | A_REC_S07_1  | agency.admin |streamlined_library,presentations|
| Chris     | Stotch   | U2_REC_S07_1 | A_REC_S07_1  | agency.admin |streamlined_library,presentations|
| Butters   | Stotch   | U3_REC_S07_1 | A_REC_S07_1  | agency.admin |streamlined_library,presentations|
And logged in with details of 'U3_REC_S07_1'
And created 'P_REC_S07_1' reels with description 'Description'
And I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish Ad.mov         |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while preview is visible on library page for collection 'Everything' for assetsNEWLIB:
| Name                |
| Fish Ad.mov         |
And I add assets 'Fish Ad.mov' to existing presentations 'P_REC_S07_1' from collection 'Everything' pageNEWLIB
And logged in with details of 'U1_REC_S07_1'
When I change presentation name from 'P_REC_S07_1' to 'RP_REC_S07_1'
And I save settings for current presentation
And login with details of 'U2_REC_S07_1'
And send presentation 'RP_REC_S07_1' to user 'U1_REC_S07_1' with personal message 'Hello Linda Stotch!'
And wait for '5' seconds
Then I 'should' see email notification for 'Shared presentation' with field to 'U1_REC_S07_1' and subject 'has been shared with' contains following attributes:
| Agency      | Message             | PresentationName | UserName     |
| A_REC_S07_1 | Hello Linda Stotch! | RP_REC_S07_1     | U2_REC_S07_1 |


