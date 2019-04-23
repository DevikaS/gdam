Feature:          Add Collection on the Fly
Narrative:
In order to
As a              AgencyAdmin
I want to         Collection Added on the fly


Scenario: Create child from added on the fly collection (check list of assets)
Meta: @qagdamsmoke
      @uatgdamsmoke
	  @livegdamsmoke
      @gdam
      @library
!--In new lib,filter wont be applicable for pinned assets
Given I am on Dashboard page
And I am on  Library page for collection 'Everything'NEWLIB
And uploaded file '/files/image10.jpg' into libraryNEWLIB
And uploaded file '/files/Fish1-Ad.mov' into libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'image10.jpg,Fish1-Ad.mov' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'TestCol6_1_8928' from collection 'Everything'NEWLIB
And I switch on media type filter 'video' from collection 'TestCol6_1_8928'NEWLIB
Then I 'should' see asset count greater than '2' in collection filter pageNEWLIB

Scenario: Remove added on the fly collection
Meta:@gdam
      @library
Given on Library pageNEWLIB
And I uploaded following assetsNEWLIB:
| Name               |
| /files/image10.jpg  |
| /files/audio04.mp3 |
| /files/audio05.mp3 |
And waited while transcoding is finished in collection '<ExistCollection>'NEWLIB
When I select asset '<Name>' in the '<ExistCollection>'  library pageNEWLIB
And I add assets to 'new' collection '<NewCollection>' from collection '<ExistCollection>'NEWLIB
And I wait for '2' seconds
And I delete the collection '<NewCollection>' on collection details pageNEWLIB
Then I 'should not' see list of collections '<NewCollection>' on the collection pageNEWLIB

Examples:
| Name                                | NewCollection  | ExistCollection |
| image10.jpg,audio04.mp3,audio05.mp3 | TestCol11_89_28 | Everything      |

Scenario: Create added on the fly collection with specific name (adding several assets)
Meta:@gdam
      @library
Given I uploaded following assetsNEWLIB:
| Name                |
| /files/image11.jpg  |
| /files/Fish1-Ad.mov |
| /files/image10.jpg  |
And waited while transcoding is finished in collection 'Everything'NEWLIB
When I select asset 'image11.jpg' in the 'Everything'  library pageNEWLIB
And I add assets to 'new' collection 'TestCol_8928' from collection 'Everything'NEWLIB
Then I should see following assets in the collectionsNEWLIB:
| Collection   | AssetInclude  | AssetExclude             |
| TestCol_8928 | image11.jpg   | Fish1-Ad.mov,image10.jpg |


Scenario: Check that added on the fly collection is absent on admin->collection tab
Meta:@gdam
      @library
Given I uploaded following assetsNEWLIB:
| Name                |
| /files/image10.jpg  |
| /files/Fish3-Ad.mov |
And waited while transcoding is finished in collection '<ExistCollection>'NEWLIB
When I select asset '<Name>' in the '<ExistCollection>'  library pageNEWLIB
And I add assets to 'new' collection '<NewCollection>' from collection '<ExistCollection>'NEWLIB
When I go to administration area collections page
Then I should see following collections on administration area collections page:
| CategoryName    | Should     |
| <NewCollection> | should not |

Examples:
| Name                     | NewCollection  | ExistCollection |
| image10.jpg,Fish3-Ad.mov | TestCol11_8928 | Everything      |


Scenario: Several added on the fly collections
Meta:@gdam
      @library
Given I uploaded following assetsNEWLIB:
| Name                |
| /files/image10.jpg   |
| /files/Fish3-Ad.mov |
And waited while transcoding is finished in collection '<ExistCollection>'NEWLIB
And I am on  Library page for collection '<ExistCollection>'NEWLIB
When I select asset '<Name>' in the '<ExistCollection>'  library pageNEWLIB
And I add assets to 'new' collection '<NewCollection>' from collection '<ExistCollection>'NEWLIB
And I go to the collections page
Then I 'should' see collection '<NewCollection>' under My Collections on the Library pageNEWLIB
Then I 'should' see only one collection '<NewCollection>' under My Collections on the Library pageNEWLIB
When I go to  Library page for collection '<NewCollection>'NEWLIB
Then I 'should' see assets '<Name>' in the collection '<NewCollection>'NEWLIB

Examples:
| Name                    | NewCollection  | ExistCollection |
| image10.jpg,Fish3-Ad.mov | TestCol_2_8928 | Everything      |
| image10.jpg,Fish3-Ad.mov | TestCol_3_8928 | Everything      |
