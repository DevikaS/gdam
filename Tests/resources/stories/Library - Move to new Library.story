Feature:          Access to new library
Narrative:
In order to
As a              AgencyAdmin
I want to         check that BU needs to have new_library_trial label to be able to access New Library

Scenario: Check that Agency needs to have label new_library_trial and User needs to have access to Streamlined Library module inorder to access the new library
Meta:@gdam
@library
!--QA-991
Given I created the agency '<Agency>' with default attributes
And updated the following agency:
| Name     | Labels  | Application Access   |
| <Agency> | <Label> | <Agency_Application_Access>  |
And I created users with following fields:
| Email       | Role         | Agency    | Access             |
| <User>      | agency.admin | <Agency> | <Usr_Application_Access> |
And logged in with details of '<User>'
Then I '<AccessToNewLibrary>' see 'Streamlined Library is coming! Click here to take a look at the beta version'
And '<AccessToNewLibrary>' be directed to new library page

Examples:
| Agency         |  User         | AccessToNewLibrary  |Label                                                     | Agency_Application_Access                       |  Usr_Application_Access                        |
| A_ATNL_01      | U_ATNL_01     | should              | new_library_trial,nVerge,FTP,Physical,dubbing_services   | streamlined_library,library,folders,dashboard   | streamlined_library,folders,dashboard,library  |
| A_ATNL_02      | U_ATNL_02     | should not          | new_library_trial,nVerge,FTP,Physical,dubbing_services   | streamlined_library,library,folders,dashboard   | folders,dashboard,library                      |
| A_ATNL_03      | U_ATNL_03     | should not          | nVerge,FTP,Physical,dubbing_services                     | streamlined_library,library,folders,dashboard   | folders,dashboard,library                      |
| A_ATNL_04      | U_ATNL_04     | should not          | nVerge,FTP,Physical,dubbing_services                     | streamlined_library,library,folders,dashboard   | streamlined_library,folders,dashboard,library |