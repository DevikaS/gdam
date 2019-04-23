!--NGN-1054 NGN-4315
Feature:          Library - assets per page
Narrative:
In order to
As a              AgencyAdmin
I want to         Check assets per page


Scenario: Correct counting of selected assets on page
Meta: @gdam
@library
Given I appended file '/files/Fish Ad.mov' to library for collection 'My Assets' while file count less than '10'NEWLIB
When I go to the Library page for collection 'My Assets'NEWLIB
And wait while preview is available in collection 'My Assets'NEWLIB
And select '5' assets on 'My Assets' pageNEWLIB
Then I should see '5' selected note in files counter in 'My Assets'NEWLIB

Scenario: Verify that all assets are selected using Select All
Meta:@gdam
@library
Given I appended file '/files/Fish Ad.mov' to library for collection 'My Assets' while file count less than '10'NEWLIB
When I go to the library page for collection 'My Assets'NEWLIB
When select all assets for collection 'My Assets' on the library pageNEWLIB
Then I should see '10' selected note in files counter in 'My Assets'NEWLIB