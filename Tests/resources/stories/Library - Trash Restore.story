
Feature:          Library - Trash and Restore
Narrative:
In order to
As a              AgencyAdmin
I want to         Check trash and restore


Scenario: Check that message is displayed when assets are restored
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
And uploaded file '/files/128_shortname.jpg' into my libraryNEWLIB
And uploaded file '/files/logo3.jpg' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets '128_shortname.jpg,logo3.jpg'NEWLIB
And I am on the Library page for collection 'Everything'NEWLIB
And selected asset '128_shortname.jpg,logo3.jpg' in the 'Everything' library pageNEWLIB
And I removed asset in 'Everything' library page
When I restore assets '128_shortname.jpg,logo3.jpg' from library trash pageNEWLIB
Then I 'should' see message 'Asset(s) restored successfully' while restoring assets from library  trash pageNEWLIB
And I 'should not' see assets with titles '128_shortname.jpg,logo3.jpg' in the library trash pageNEWLIB
When I go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see assets '128_shortname.jpg,logo3.jpg' in the collection 'C_AUR_S15_2'NEWLIB


Scenario: Check that assets are moved to trash when assets are removed
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
And uploaded file '/files/128_shortname.jpg' into my libraryNEWLIB
And uploaded file '/files/logo3.jpg' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets '128_shortname.jpg,logo3.jpg'NEWLIB
And I am on the Library page for collection 'Everything'NEWLIB
And selected asset '128_shortname.jpg,logo3.jpg' in the 'Everything' library pageNEWLIB
And I removed asset in 'Everything' library page
When I go to library trash pageNEWLIB
Then I 'should' see assets with titles '128_shortname.jpg,logo3.jpg' in the library trash pageNEWLIB
And I 'should' see asset count '2' in the library trash pageNEWLIB


Scenario: Check that assets are restored from trash asset info page
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
And uploaded file '/files/128_shortname.jpg' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets '128_shortname.jpg'NEWLIB
And I am on the Library page for collection 'Everything'NEWLIB
And selected asset '128_shortname.jpg' in the 'Everything' library pageNEWLIB
And I removed asset in 'Everything' library page
When I go to library trash pageNEWLIB
And I click asset '128_shortname.jpg' on library trash pageNEWLIB
And I click Restore button on opened asset info pageNEWLIB
Then I 'should not' see assets with titles '128_shortname.jpg' in the library trash pageNEWLIB
When I go to the Library page for collection 'Everything'NEWLIB
Then I 'should' see assets '128_shortname.jpg' in the collection 'Everything'NEWLIB


Scenario: Check that trash asset info page is displayed correctly
Meta:@gdam
@library
Given I logged in with details of 'AgencyAdmin'
And uploaded file '/files/128_shortname.jpg' into my libraryNEWLIB
And waited while preview is visible on library page for collection 'Everything' for assets '128_shortname.jpg'NEWLIB
And I am on the Library page for collection 'Everything'NEWLIB
And selected asset '128_shortname.jpg' in the 'Everything' library pageNEWLIB
And I removed asset in 'Everything' library page
When I go to library trash pageNEWLIB
And I click asset '128_shortname.jpg' on library trash pageNEWLIB
Then I 'should' see 'info' button on opened asset info pageNEWLIB
And I 'should' see 'activities' button on opened asset info pageNEWLIB
And I 'should not' see 'download' button on opened asset info pageNEWLIB
And I 'should not' see 'share asset' button on opened asset info pageNEWLIB
And I 'should not' see 'remove' button on opened asset info pageNEWLIB
And I 'should not' see 'usage rights' button on opened asset info pageNEWLIB
And I 'should not' see 'projects' button on opened asset info pageNEWLIB
And I 'should not' see 'attachments' button on opened asset info pageNEWLIB


