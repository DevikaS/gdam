Feature:          Library - Change Media
Narrative:
In order to
As a              AgencyAdmin
I want to         change the Media Type for an asset


Scenario: Check that you can change the Media Type for an asset and the asset type is changed in the Thumbnail
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                       |
| <File>                     |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
And selected asset '<AssetName>' in the 'Everything' library pageNEWLIB
And I changed media to '<AssetType>' on 'Everything' library page
Then I 'should' see asset type changed to '<AssetType>' for asset '<AssetName>' on 'Everything' page

Examples:
| File                   |  AssetName    |AssetType  |
| /files/Fish1-Ad.mov    |  Fish1-Ad.mov |   print   |
|/files/test.mp3         |  test.mp3     |  image    |


Scenario: Check that when you set filter after changing the asset type the asset it listed accordingly
Meta:@gdam
@library
Given I uploaded following assetsNEWLIB:
| Name                       |
| /files/Fish1-Ad.mov        |
| /files/test.mp3            |
| /files/test.ogg            |
And I am on the Library page for collection 'Everything'NEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
And selected asset '<AssetName>' in the 'Everything' library pageNEWLIB
And I changed media to '<AssetType>' on 'Everything' library page
When I switch 'on' media type filter '<Filter>' for collection 'Everything' on the page LibraryNEWLIB
Then I 'should' see assets '<AssetsInclude>' in the collection 'Everything'NEWLIB
And 'should not' see assets '<AssetsExclude>' in the collection 'Everything'NEWLIB

Examples:
|  AssetName    |AssetType  | Filter | AssetsInclude  | AssetsExclude           |
|  Fish1-Ad.mov |   print   | print  | Fish1-Ad.mov   | test.mp3,test.ogg       |
|  test.mp3     |  image    | image  | test.mp3       | Fish1-Ad.mov,test.ogg   |
| test.ogg      | audio     | audio  | test.ogg       | Fish1-Ad.mov,test.mp3   |


