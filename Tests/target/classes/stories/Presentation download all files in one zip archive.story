!--NGN-1741
Feature:          Presentation download all files in one zip archive
Narrative:
In order to
As a              AgencyAdmin
I want to         Check download of presentations

Meta:
@component presentation



Scenario: Check that archive has correct name and size
!--NGN-3597 NGN-3596
Meta: @skip
      @gdam
Given I uploaded the following assets to library page
| Assets          | Size  |
| Addidas.mpeg    | 30 MB |
| Nike.mp3        | 5 MB  |
| Puma.jpeg       | 1 MB  |
| New_balance.pdf | 9 MB  |
And wait untill files will be transcoded
And created 'ReelForTestDownload' presentation with the following assets
| Assets          |
| Addidas.mpeg    |
| Nike.mp3        |
| Puma.jpeg       |
| New_balance.pdf |
And opened 'Settings' tab in 'ReelForTestDownload' presentation
And download option set to 'Originals + Proxys'
And opened preview page for 'ReelForTestDownload' presentation
When I download '<Archive>' archive from presentation preview page
Then I should see the '<Archive>' on hard drive with '<Name>'name and '<size>' size
| Examples | Name                | Size  |
| Original | ReelForTestDownload | 45 MB |
| Proxies  | ReelForTestDownload | 64 MB |


Scenario: Check that download of original/proxy archive works proper
Meta: @skip
      @gdam
Given I uploaded the following assets to library page
| Assets          |
| Addidas.mpeg    |
| Nike.mp3        |
| Puma.jpeg       |
| New_balance.pdf |
And wait untill files will be transcoded
And created 'ReelForTestDownload' presentation with the following assets
| Assets          |
| Addidas.mpeg    |
| Nike.mp3        |
| Puma.jpeg       |
| New_balance.pdf |
And opened 'Settings' tab in 'ReelForTestDownload' presentation
And download option set to 'Originals + Proxys'
And opened preview page for 'ReelForTestDownload' presentation
When I download '<Archive>' archive from presentation preview page
Then I should see the following files on hard drive
| Files           |
| Addidas.mpeg    |
| Nike.mp3        |
| Puma.jpeg       |
| New_balance.pdf |

Examples:
| Original |
| Proxies  |


Scenario: Check that download of original/proxy archive works proper after sharing via public url
Meta: @skip
      @gdam
Given I uploaded the following assets to library page
| Assets          |
| Addidas.mpeg    |
| Nike.mp3        |
| Puma.jpeg       |
| New_balance.pdf |
And wait untill files will be transcoded
And created 'ReelForTestDownload' presentation with the following assets
| Assets          |
| Addidas.mpeg    |
| Nike.mp3        |
| Puma.jpeg       |
| New_balance.pdf |
And opened 'Settings' tab in 'ReelForTestDownload' presentation
And download option set to 'Originals + Proxys'
And enabled public url for 'ReelForTestDownload' presentation
And opened public url of 'ReelForTestDownload' presentation in new session
When I download '<Archive>' archive on presentation preview page
Then I should see the following files on hard drive
| Files           |
| Addidas.mpeg    |
| Nike.mp3        |
| Puma.jpeg       |
| New_balance.pdf |

Examples:
| Original |
| Proxies  |


Scenario: Check that download of original/proxy archive works proper after sharing on easyshare user
Meta: @skip
      @gdam
Given I uploaded the following assets to library page
| Assets          |
| Addidas.mpeg    |
| Nike.mp3        |
| Puma.jpeg       |
| New_balance.pdf |
And wait untill files will be transcoded
And created 'ReelForTestDownload' presentation with the following assets
| Assets          |
| Addidas.mpeg    |
| Nike.mp3        |
| Puma.jpeg       |
| New_balance.pdf |
And opened 'Settings' tab in 'ReelForTestDownload' presentation
And download option set to 'Originals + Proxys'
And i share 'ReelForTestDownload' presentation for 'easyshareuser@privet.sd' easyshare user
And Opened 'ReelForTestDownload' presentation in new session under 'easyshareuser@privet.sd'
When I download '<Archive>' archive on presentation preview page
Then I should see the following files on hard drive
| Files           |
| Addidas.mpeg    |
| Nike.mp3        |
| Puma.jpeg       |
| New_balance.pdf |

Examples:
| Original |
| Proxies  |


Scenario: Check that download of original/proxy archive works proper after sharing on agency user
Meta: @skip
      @gdam
Given I created 'UserFromAnotherAgency@test.mars' agency user in 'anothertest' agency
And uploaded the following assets to library page
| Assets          |
| Addidas.mpeg    |
| Nike.mp3        |
| Puma.jpeg       |
| New_balance.pdf |
And wait untill files will be transcoded
And created 'ReelForTestDownload' presentation with the following assets
| Assets          |
| Addidas.mpeg    |
| Nike.mp3        |
| Puma.jpeg       |
| New_balance.pdf |
And opened 'Settings' tab in 'ReelForTestDownload' presentation
And download option set to 'Originals + Proxys'
And i share 'ReelForTestDownload' presentation for 'UserFromAnotherAgency@test.mars' agency user
And Opened 'ReelForTestDownload' presentation in new session under 'UserFromAnotherAgency@test.mars'
When I download '<Archive>' archive on presentation preview page
Then I should see the following files on hard drive
| Files           |
| Addidas.mpeg    |
| Nike.mp3        |
| Puma.jpeg       |
| New_balance.pdf |

Examples:
| Original |
| Proxies  |


Scenario: Check that download Original and Proxy buttons is depends to presentation settings
Meta:@gdam
@library
Given I uploaded file '/images/logo.jpg' into libraryNEWLIB
And created following reels:
| Name           | Description |
| <Presentation> | description |
And I waited while preview is visible on library page for collection 'My Assets' for assetsNEWLIB:
| Name     |
| logo.jpg |
And I am on library page for collection 'My Assets'NEWLIB
And I add assets 'logo.jpg' to existing presentations '<Presentation>' from collection 'My Assets' pageNEWLIB
When I send presentation '<Presentation>' to user '<Email>' with personal message 'Hello' and download option '<DownloadOption>'
And open link from email when user '<Email>' received email with next subject 'You are invited to Adbank'
And accept new user with first name 'TestUserName' and last name 'TestUserLastName'
And click element 'DownloadLink' on page 'PresentationPreview'
Then I '<ShouldOriginal>' see Original files (ZIP) button on Download popup of presentation preview page
And '<ShouldProxy>' see Proxy files (ZIP) button on Download popup of presentation preview page

Examples:
| DownloadOption   | ShouldOriginal | ShouldProxy | Presentation |  Email      |
| Original + Proxy | should         | should      | PDAFOZAR2_1  |  UDAFOZAR2  |
| Proxies          | should not     | should      | PDAFOZAR2_2  |  UDAFOZAR2_N|


Scenario: Check that Download button is depends to presentation settings and visible after sharing via public url
Meta:@gdam
@library
Given I uploaded file '/images/logo.jpg' into libraryNEWLIB
And created following reels:
| Name               | Description |
| <PresentationName> | description |
And I waited while preview is visible on library page for collection 'My Assets' for assetsNEWLIB:
| Name     |
| logo.jpg |
And I am on library page for collection 'My Assets'NEWLIB
And I add assets 'logo.jpg' to existing presentations '<PresentationName>' from collection 'My Assets' pageNEWLIB
When I send presentation '<PresentationName>' by public link to user 'testUser1' with personal message 'msg1' with option '<DownloadOption>'
And logout from account
And go to the presentation '<PresentationName>' view page by public url
And click element 'DownloadLink' on page 'PresentationPreview'
Then I '<ShouldStateOriginal>' see Original files (ZIP) button on Download popup of presentation preview page
Then I '<ShouldStateProxy>' see Proxy files (ZIP) button on Download popup of presentation preview page

Examples:
| PresentationName | DownloadOption   | ShouldStateOriginal | ShouldStateProxy |
| PDAFOZAR3_2      | Original + Proxy | should              | should           |
| PDAFOZAR3_3      | Proxies          | should not          | should           |


Scenario: Check that Download button is depends to presentation settings
Meta:@gdam
@library
Given I uploaded file '/images/logo.jpg' into libraryNEWLIB
And created following reels:
| Name              | Description |
| pugs_presentation | description |
And I waited while preview is visible on library page for collection 'My Assets' for assetsNEWLIB:
| Name     |
| logo.jpg |
And I am on library page for collection 'My Assets'NEWLIB
And I add assets 'logo.jpg' to existing presentations 'pugs_presentation' from collection 'My Assets' pageNEWLIB
When I send presentation 'pugs_presentation' by public link to user 'testUser1' with personal message 'msg1' with option ''
And logout from account
And go to the presentation 'pugs_presentation' view page by public url
Then I 'should not' see element 'DownloadLink' on page 'PresentationPreview'


Scenario: Check that Download button is depends to presenation settings and visible for easyshare user
Meta:@gdam
@library
Given I uploaded file '/images/logo.jpg' into libraryNEWLIB
And created following reels:
| Name      | Description |
| <Presentation> | description |
And I waited while preview is visible on library page for collection 'My Assets' for assetsNEWLIB:
| Name     |
| logo.jpg |
And I am on library page for collection 'My Assets'NEWLIB
And I add assets 'logo.jpg' to existing presentations '<Presentation>' from collection 'My Assets' pageNEWLIB
And I am on the presentation '<Presentation>' settings page
When I send presentation '<Presentation>' by public link to user '<email>' with personal message 'msg1' with option '<DownloadOption>'
And I logout from account
And open link from email with shared presentation '<Presentation>' which user '<email>' received
Then I '<Should>' see Download button on presentation preview page

Examples:
| DownloadOption   | Should     | email       | Presentation |
|                  | should not | PDAFOZAU5_1 | PDAFOZAR51   |
| Original + Proxy | should     | PDAFOZAU5_2 | PDAFOZAR52   |
| Proxies          | should     | PDAFOZAU5_3 | PDAFOZAR53   |

Scenario: Check that download Original and Proxy buttons is depends to presenation settings and visible for easyshare user
Meta:@gdam
@library
Given I uploaded file '/images/logo.jpg' into libraryNEWLIB
And created following reels:
| Name           | Description |
| <Presentation> | description |
And I waited while preview is visible on library page for collection 'My Assets' for assetsNEWLIB:
| Name     |
| logo.jpg |
And I am on library page for collection 'My Assets'NEWLIB
When I add asset 'logo.jpg' into existing presentation '<Presentation>' from collection 'My Assets'NEWLIB
And I send presentation '<Presentation>' to user '<email>' with personal message 'message for easy share user' and download option '<DownloadOption>'
And I logout from account
And open link from email when user '<email>' received email with next subject 'You are invited to Adbank'
And accept new user with first name 'TestUserName' and last name 'TestUserLastName'
And click element 'DownloadLink' on page 'PresentationPreview'
Then I '<ShouldOriginal>' see Original files (ZIP) button on Download popup of presentation preview page
And '<ShouldProxy>' see Proxy files (ZIP) button on Download popup of presentation preview page

Examples:
| DownloadOption   | ShouldOriginal | ShouldProxy | email       | Presentation |
| Original + Proxy | should         | should      | PDAFOZAU6_1 | PDAFOZAR6_1  |
| Proxies          | should not     | should      | PDAFOZAU6_2 | PDAFOZAR6_2  |

Scenario: Check that Download button is depends to presentation settings and visible for agencys user
Meta:@gdam
@library
Given I uploaded file '/images/logo.jpg' into libraryNEWLIB
And created users with following fields:
| Email   | Role        | Agency        | Password     |
| <email> | agency.user | AnotherAgency | TestPassw0rd |
And created following reels:
| Name           | Description |
| <Presentation> | description |
And I waited while preview is visible on library page for collection 'My Assets' for assetsNEWLIB:
| Name     |
| logo.jpg |
And I am on library page for collection 'My Assets'NEWLIB
When I add asset 'logo.jpg' into existing presentation '<Presentation>' from collection 'My Assets'NEWLIB
And I send presentation '<Presentation>' to user '<email>' with personal message 'test message' and download option '<DownloadOption>'
And I logout from account
And open link from email with shared presentation '<Presentation>' which user '<email>' received
And I fill fields login '<email>' and password 'TestPassw0rd' and then login to system
Then I '<Should>' see Download button on presentation preview page

Examples:
| DownloadOption   | Should     | email       | Presentation |
|                  | should not | PDAFOZAU7_1 | PDAFOZAR7_1  |
| Original + Proxy | should     | PDAFOZAU7_2 | PDAFOZAR7_2  |
| Proxies           | should     | PDAFOZAU7_3 | PDAFOZAR7_3  |

Scenario: Check that Download button ZIP is depends to presentation settings and visible for agencys user
Meta:@gdam
@library
Given I uploaded file '/images/logo.jpg' into libraryNEWLIB
And created users with following fields:
| Email   | Role        | Agency        | Password     |
| <email> | agency.user | AnotherAgency | TestPassw0rd |
And created following reels:
| Name           | Description |
| <Presentation> | description |
And I waited while preview is visible on library page for collection 'My Assets' for assetsNEWLIB:
| Name     |
| logo.jpg |
And I am on library page for collection 'My Assets'NEWLIB
When I add asset 'logo.jpg' into existing presentation '<Presentation>' from collection 'My Assets'NEWLIB
And I send presentation '<Presentation>' to user '<email>' with personal message 'test message' and download option '<DownloadOption>'
And I logout from account
And open link from email with shared presentation '<Presentation>' which user '<email>' received
And I fill fields login '<email>' and password 'TestPassw0rd' and then login to system
And click element 'DownloadLink' on page 'PresentationPreview'
Then I '<ShouldOriginal>' see Original files (ZIP) button on Download popup of presentation preview page
And '<ShouldProxy>' see Proxy files (ZIP) button on Download popup of presentation preview page

Examples:
| DownloadOption   | ShouldOriginal | ShouldProxy | email       | Presentation |
| Original + Proxy | should         | should      | PDAFOZAU8_1 | PDAFOZAR8_1  |
| Proxies           | should not     | should      | PDAFOZAU8_2 | PDAFOZAR8_2  |
