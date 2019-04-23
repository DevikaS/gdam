Feature:    Add Asset To Presntation
Narrative:
In order to
As a              AgencyAdmin
I want to check that assets are added to presentation


Scenario: Check that toast message is displayed when single asset is added to presentation
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/_file1.gif  |
| /files/128_shortname.jpg  |
And waited while preview is visible on library page for collection 'My Assets' for assets '128_shortname.jpg,_file1.gif'NEWLIB
When I go to the library page for collection 'My Assets'NEWLIB
And I add assets '_file1.gif,128_shortname.jpg' to new presentation 'LAP_P2' from collection 'My Assets' pageNEWLIB
Then I 'should' see message 'Asset(s) successfully copied to   LAP_P2' while adding assets to presentation from collection 'My Assets' NEWLIB


Scenario: Check that toast message is displayed when multiple assset is addded to multiple existing presentations
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/_file1.gif  |
| /files/128_shortname.jpg  |
And I created following reels:
| Name              |
| LAP_P3 |
And I created following reels:
| Name              |
| LAP_P4 |
And waited while preview is visible on library page for collection 'My Assets' for assets '128_shortname.jpg,_file1.gif'NEWLIB
When I go to the library page for collection 'My Assets'NEWLIB
And I add assets '_file1.gif,128_shortname.jpg' to existing presentations 'LAP_P3,LAP_P4' from collection 'My Assets' pageNEWLIB
Then I 'should' see message 'Asset(s) successfully copied to   presentations' while adding assets to presentation from collection 'My Assets' NEWLIB
When I go to the presentations assets page 'LAP_P3'
Then I 'should' see asset '_file1.gif,128_shortname.jpg' in the current presentation
When I go to the presentations assets page 'LAP_P4'
Then I 'should' see asset '_file1.gif,128_shortname.jpg' in the current presentation


Scenario: Check that presentation query returns more relavent results
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/_file1.gif  |
And waited while preview is visible on library page for collection 'My Assets' for assets '_file1.gif'NEWLIB
And I created following reels:
| Name          | Description |
| PRAATP_P2     | DDD_1       |
| PR_P2         | DDD_2       |
| PRP2          | DDD_3       |
| PRAA P2       | DDD_2       |
| P2 PR         | DDD_3       |
When I go to the library page for collection 'My Assets'NEWLIB
Then I 'should' see following presentation search results for text 'PR' while adding asset '_file1.gif' from collection 'My Assets' pageNEWLIB:
|SearchResults|AssetCount|
|PRAATP_P2    | (0 assets)    |
|PR_P2        |(0 assets)    |
|PRP2         |(0 assets)    |
|PRAA P2      |(0 assets)    |
|P2 PR        |(0 assets)    |


Scenario: Check that asset is added to presentation popup from asset info page
Meta:@gdam
Given I uploaded following assetsNEWLIB:
| Name               |
| /files/_file1.gif  |
And waited while preview is visible on library page for collection 'My Assets' for assets '_file1.gif'NEWLIB
When go to asset '_file1.gif' info page in Library for collection 'My Assets'NEWLIB
And I add assets '_file1.gif' to new presentation 'LAP_P5' on opened asset info pageNEWLIB
When I go to the presentations assets page 'LAP_P5'
Then I 'should' see asset '_file1.gif' in the current presentation
