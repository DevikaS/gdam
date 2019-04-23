Feature:          New Library Download functionality
Narrative:
In order to
As a              AgencyAdmin
I want to         check assets can be downloaded using api

Scenario: check that you can download master and proxy for the assets and a zip folder is created
Meta:@gdam
@library
Given logged in with details of 'AgencyAdmin'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
Then I am able to downloaded asset 'Fish1-Ad.mov' as 'master,proxy' from collection 'Everything'

Scenario: Check that you can download  master and proxy using sendplus
Meta: @gdam
@library
Given logged in with details of 'AgencyAdmin'
And uploaded file '/files/Fish1-Ad.mov' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
Then I am able to downloaded asset 'Fish1-Ad.mov' as 'master,proxy' from collection 'Everything' using sendplus

Scenario: check that you can download master and proxy for the assets and a zip folder is created when the asset name has special char
Meta:@gdam
@library
!--UIR-991
Given logged in with details of 'AgencyAdmin'
And uploaded file '/files/file4!@#$%^&()+-=~_.mpg' into my libraryNEWLIB
And waited while transcoding is finished in collection 'Everything'NEWLIB
Then I am able to downloaded asset 'file4!@#$%^&()+-=~_.mpg' as 'master,proxy' from collection 'Everything'


