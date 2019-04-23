!--NGN-11002
Feature:          Change available Proxy Download options for PDF files
Narrative:
In order to
As a              AgencyAdmin
I want to         Check that Change available Proxy Download options for PDF files


Scenario: Check that JPEG download proxy button is hidden in UI for pdf files/assets
Meta:@gdam
     @skip
!--new lib wont show download low res pdf button..it shows only original and proxy..This is As designed
Given I uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
When go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see 'download original' button on opened asset info pageNEWLIB


Scenario: Check that Low Resolution PDF download button isn't available for image file
Meta:@gdam
@library
!--new lib wont show download low res pdf button..it shows only original and proxy..This is As designed
Given I created 'P_CAPDOFPDFF_01' project
And created '/folder1' folder for project 'P_CAPDOFPDFF_01'
And uploaded '/files/atCalcImage.jpg' file into '/folder1' folder for 'P_CAPDOFPDFF_01' project
And waited while preview is available in folder '/folder1' on project 'P_CAPDOFPDFF_01' files page
When go to file 'atCalcImage.jpg' info page in folder '/folder1' project 'P_CAPDOFPDFF_01'
Then I 'should not' see element 'download low res pdf' on page 'FileInfoPage'

Scenario: Check that download proxy and original option are shown in UI for pdf files/assets
Meta:@gdam
@library
Given I uploaded file '/files/GWGTest2.pdf' into libraryNEWLIB
And waited while preview is available in collection 'My Assets'NEWLIB
When go to asset 'GWGTest2.pdf' info page in Library for collection 'My Assets'NEWLIB
Then I 'should' see 'download original' button on opened asset info pageNEWLIB
And I 'should' see 'download proxy' button on opened asset info pageNEWLIB