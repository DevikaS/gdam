Feature:
Narrative:
In order to
As a	 AgencyAdmin
I want to Check functionality




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

