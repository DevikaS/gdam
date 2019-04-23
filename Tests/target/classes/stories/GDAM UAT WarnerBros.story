Feature:          Warner Bro GDAM Scenarios
Narrative:
In order to
As a             GlobalAdmin
I want to         verify notification settings

Scenario: Check that notification settings when a new user is assigned global role of Agency User in the Warner Bros EMEA BU
Meta:@ClientScenarioWarnerBros
!--QA-568
Given I am on global admin passwords page
And I changed password for user 'wbemeaadmin@adbank.me' with password 'A5admin_WB' and repeat password 'A5admin_WB'
When I login as user with login 'wbemeaadmin@adbank.me' and password 'A5admin_WB'
And I go to Create New User page
And I fill following fields on user opened details page:
| FirstName       | LastName         | Email           | Password       | Access          | Role        |
| Warner          | Bros             |  WBAU1          | abcdefghA1     | library,folders | agency.user |
And I click save on users details page with no Timezone
And login with details of 'WBAU1'
And I go to my Notifications Settings page
Then I should see the complete list of following notifications:
| Name                                                      | Checked |
| Ad Pro Notification                                       | off     |
| Ad Pro Uploader Notification                              | off     |
| Approval Has Been Canceled                                | off     |
| Asset Downloaded From Presentation As Master              | off     |
| Asset Downloaded From Presentation As Proxy               | off     |
| Asset Filter Shared                                       | off     |
| Assets Shared                                             | off     |
| Assets Shared With Users                                  | off     |
| Assets Uploaded                                           | off     |
| Asset Usage Rights Expire Soon                            | off     |
| Asset Usage Rights Updated                                | off     |
| Assign All Asset To User                                  | off     |
| Assign All Destinations To User                           | off     |
| Assign All Storage To User                                | off     |
| Assign Single To User                                     | off     |
| Category Updated                                          | off     |
| Comment Submitted                                         | off     |
| Delivery Item Delivered                                   | off     |
| Delivery Item Ready For Approval                          | off     |
| Delivery Item Ready For Proxy Approval                    | off     |
| Epsilon User Invited                                      | off     |
| Epsilon User Invite Reminded                              | off     |
| File Commented                                            | off     |
| File Downloaded As Master                                 | off     |
| File Downloaded As Preview                                | off     |
| File Matched                                              | off     |
| File Preview Played                                       | off     |
| File Preview Transcode Failed                             | off     |
| File Q C Completed                                        | off     |
| File Revision Uploaded                                    | off     |
| Files Copied                                              | off     |
| Files Copied To Other Project                             | off     |
| Files Deleted                                             | off     |
| Files Downloaded                                          | off     |
| Files Moved                                               | off     |
| Files Moved To Library                                    | off     |
| Files Moved To Other Project                              | off     |
| Files Shared                                              | off     |
| Files Shared With Users                                   | Immediately      |
| Files Updated                                             | off     |
| Files Uploaded                                            | off     |
| File Upload Failed                                        | off     |
| File Upload Requested                                     | off     |
| File Upload Request Reset                                 | off     |
| File Usage Rights Expire Soon                             | off     |
| File Usage Rights Updated                                 | off     |
| Folders Shared                                            | off     |
| Folders Shared With Users                                 | Immediately      |
| Genericxmg Access Requested                               | off     |
| Genericxmg W R Access Requested                           | off     |
| Genericxmg W R Incorrect Asset                            | off     |
| Genericxmg W R Incorrect Assset                           | off     |
| House Number Assigned                                     | off     |
|Legal Proxy Rejected                                       | off     |
| Master Approved                                           | off     |
| Master Delivered                                          | off     |
| Master Escalated                                          | off     |
| Master Rejected                                           | off     |
| New File For Approval                                     | off     |
| Order Delivered                                           | off     |
| Order Generics Upload Requested                           | off     |
| Order Ingested                                            | off     |
| Order Media Ftp Upload Reminder                           | off     |
| Order Media Ftp Upload Requested                          | off     |
| Order Media Physical Upload Reminder                      | off     |
| Order Media Physical Upload Requested                     | off     |
| Order Media SendPlus Upload Reminder                      | off     |
| Order Media SendPlus Upload Requested                     | off     |
| Order Media Upload Reassigned                             | off     |
| Order Media Upload Reminder                               | off     |
| Order Media Upload Requested                              | off     |
| Order Placed                                              | off     |
| Order Subtitles Required                                  | off     |
| Order Transferred                                         | off     |
| Presentation Downloaded                                   | off     |
| Project Published                                         | Immediately      |
| Presentation Shared                                       | off     |
| Presentation Viewed                                       | off     |
| Presentation Shared With Users                            | Immediately      |
| Presentation Zip Download Bundle Created                  | off     |
| Preview Approved                                          | off     |
| Preview Escalated                                         | off     |
| Preview Rejected                                          | off     |
| Preview Restored                                          | off     |
| Project Owner Removed                                     | off     |
| Project Publication Notify                                | off     |
| Project Shared                                            | off     |
| Project Shared With Users                                 | off     |
| Project Team Added                                        | off     |
| Project Team Removed                                      | off     |
| Project Unshared                                          | off     |
| Radio Order Delivered                                     | off     |
| Radio Order Downloaded                                    | off     |
| Radio Order Placed                                        | off     |
| Zip Download Bundle Created                               | off     |

Scenario: Check that notification settings are retained on Warner Bros Home Office BU when a user is converted from Guest to Agency user
Meta:@ClientScenarioWarnerBros
!--QA-569
Given I logged in with details of 'GlobalAdmin'
When I go to the global admin passwords page
And I change password for user 'a5wbadmin@adstream.com' with password 'A5admin_WB' and repeat password 'A5admin_WB'
And I login as user with login 'a5wbadmin@adstream.com' and password 'A5admin_WB'
And I go to Create New User page
And I fill following fields on user opened details page:
| FirstName       | LastName       | Email       | Password       | Access          | Role        |
| Warner             | Bros             |  WBGU1          | abcdefghA1     | library,folders | guest.user |
And I click save on users details page with no Timezone
And login with details of 'WBGU1'
And I refresh the page
And I go to my Notifications Settings page
Then I should see the complete list of following notifications:
| Name                                                      | Checked |
| Ad Pro Notification                                       | off     |
| Ad Pro Uploader Notification                              | off     |
| Approval Has Been Canceled                                | off     |
| Asset Downloaded From Presentation As Master              | off     |
| Asset Downloaded From Presentation As Proxy               | off     |
| Asset Filter Shared                                       | off     |
| Assets Shared                                             | off     |
| Assets Shared With Users                                  | off     |
| Assets Uploaded                                           | off     |
| Asset Usage Rights Expire Soon                            | off     |
| Asset Usage Rights Updated                                | off     |
| Assign All Asset To User                                  | off     |
| Assign All Destinations To User                           | off     |
| Assign All Storage To User                                | off     |
| Assign Single To User                                     | off     |
| Category Updated                                          | off     |
| Comment Submitted                                         | off     |
| Delivery Item Delivered                                   | off     |
| Delivery Item Ready For Approval                          | off     |
| Delivery Item Ready For Proxy Approval                    | off     |
| Epsilon User Invited                                      | off     |
| Epsilon User Invite Reminded                              | off     |
| File Commented                                            | off     |
| File Downloaded As Master                                 | off     |
| File Downloaded As Preview                                | off     |
| File Matched                                              | off     |
| File Preview Played                                       | off     |
| File Preview Transcode Failed                             | off     |
| File Q C Completed                                        | off     |
| File Revision Uploaded                                    | off     |
| Files Copied                                              | off     |
| Files Copied To Other Project                             | off     |
| Files Deleted                                             | off     |
| Files Downloaded                                          | off     |
| Files Moved                                               | off     |
| Files Moved To Library                                    | off     |
| Files Moved To Other Project                              | off     |
| Files Shared                                              | off     |
| Files Shared With Users                                   | Immediately      |
| Files Updated                                             | off     |
| Files Uploaded                                            | off     |
| File Upload Failed                                        | off     |
| File Upload Requested                                     | off     |
| File Upload Request Reset                                 | off     |
| File Usage Rights Expire Soon                             | off     |
| File Usage Rights Updated                                 | off     |
| Folders Shared                                            | off     |
| Folders Shared With Users                                 | Immediately      |
| Genericxmg Access Requested                               | off     |
| Genericxmg W R Access Requested                           | off     |
| Genericxmg W R Incorrect Asset                            | off     |
| Genericxmg W R Incorrect Assset                           | off     |
| House Number Assigned                                     | off     |
|Legal Proxy Rejected                                       | off     |
| Master Approved                                           | off     |
| Master Delivered                                          | off     |
| Master Escalated                                          | off     |
| Master Rejected                                           | off     |
| New File For Approval                                     | off     |
| Order Delivered                                           | off     |
| Order Generics Upload Requested                           | off     |
| Order Ingested                                            | off     |
| Order Media Ftp Upload Reminder                           | off     |
| Order Media Ftp Upload Requested                          | off     |
| Order Media Physical Upload Reminder                      | off     |
| Order Media Physical Upload Requested                     | off     |
| Order Media SendPlus Upload Reminder                      | off     |
| Order Media SendPlus Upload Requested                     | off     |
| Order Media Upload Reassigned                             | off     |
| Order Media Upload Reminder                               | off     |
| Order Media Upload Requested                              | off     |
| Order Placed                                              | off     |
| Order Subtitles Required                                  | off     |
| Order Transferred                                         | off     |
| Presentation Downloaded                                   | off     |
| Project Published                                         | Immediately      |
| Presentation Shared                                       | off     |
| Presentation Viewed                                       | off     |
| Presentation Shared With Users                            | Immediately      |
| Presentation Zip Download Bundle Created                  | off     |
| Preview Approved                                          | off     |
| Preview Escalated                                         | off     |
| Preview Rejected                                          | off     |
| Preview Restored                                          | off     |
| Project Owner Removed                                     | off     |
| Project Publication Notify                                | off     |
| Project Shared                                            | off     |
| Project Shared With Users                                 | off     |
| Project Team Added                                        | off     |
| Project Team Removed                                      | off     |
| Project Unshared                                          | off     |
| Radio Order Delivered                                     | off     |
| Radio Order Downloaded                                    | off     |
| Radio Order Placed                                        | off     |
| Zip Download Bundle Created                               | off     |
When I logout from account
And I login as user with login 'a5wbadmin@adstream.com' and password 'A5admin_WB'
And I go to user 'WBGU1' details page
And I edit for user 'WBGU1' agency role 'Agency User'
And login with details of 'WBGU1'
And I refresh the page
And I go to my Notifications Settings page
Then I should see the complete list of following notifications:
| Name                                                      | Checked |
| Ad Pro Notification                                       | off     |
| Ad Pro Uploader Notification                              | off     |
| Approval Has Been Canceled                                | off     |
| Asset Downloaded From Presentation As Master              | off     |
| Asset Downloaded From Presentation As Proxy               | off     |
| Asset Filter Shared                                       | off     |
| Assets Shared                                             | off     |
| Assets Shared With Users                                  | off     |
| Assets Uploaded                                           | off     |
| Asset Usage Rights Expire Soon                            | off     |
| Asset Usage Rights Updated                                | off     |
| Assign All Asset To User                                  | off     |
| Assign All Destinations To User                           | off     |
| Assign All Storage To User                                | off     |
| Assign Single To User                                     | off     |
| Category Updated                                          | off     |
| Comment Submitted                                         | off     |
| Delivery Item Delivered                                   | off     |
| Delivery Item Ready For Approval                          | off     |
| Delivery Item Ready For Proxy Approval                    | off     |
| Epsilon User Invited                                      | off     |
| Epsilon User Invite Reminded                              | off     |
| File Commented                                            | off     |
| File Downloaded As Master                                 | off     |
| File Downloaded As Preview                                | off     |
| File Matched                                              | off     |
| File Preview Played                                       | off     |
| File Preview Transcode Failed                             | off     |
| File Q C Completed                                        | off     |
| File Revision Uploaded                                    | off     |
| Files Copied                                              | off     |
| Files Copied To Other Project                             | off     |
| Files Deleted                                             | off     |
| Files Downloaded                                          | off     |
| Files Moved                                               | off     |
| Files Moved To Library                                    | off     |
| Files Moved To Other Project                              | off     |
| Files Shared                                              | off     |
| Files Shared With Users                                   | Immediately      |
| Files Updated                                             | off     |
| Files Uploaded                                            | off     |
| File Upload Failed                                        | off     |
| File Upload Requested                                     | off     |
| File Upload Request Reset                                 | off     |
| File Usage Rights Expire Soon                             | off     |
| File Usage Rights Updated                                 | off     |
| Folders Shared                                            | off     |
| Folders Shared With Users                                 | Immediately      |
| Genericxmg Access Requested                               | off     |
| Genericxmg W R Access Requested                           | off     |
| Genericxmg W R Incorrect Asset                            | off     |
| Genericxmg W R Incorrect Assset                           | off     |
| House Number Assigned                                     | off     |
|Legal Proxy Rejected                                       | off     |
| Master Approved                                           | off     |
| Master Delivered                                          | off     |
| Master Escalated                                          | off     |
| Master Rejected                                           | off     |
| New File For Approval                                     | off     |
| Order Delivered                                           | off     |
| Order Generics Upload Requested                           | off     |
| Order Ingested                                            | off     |
| Order Media Ftp Upload Reminder                           | off     |
| Order Media Ftp Upload Requested                          | off     |
| Order Media Physical Upload Reminder                      | off     |
| Order Media Physical Upload Requested                     | off     |
| Order Media SendPlus Upload Reminder                      | off     |
| Order Media SendPlus Upload Requested                     | off     |
| Order Media Upload Reassigned                             | off     |
| Order Media Upload Reminder                               | off     |
| Order Media Upload Requested                              | off     |
| Order Placed                                              | off     |
| Order Subtitles Required                                  | off     |
| Order Transferred                                         | off     |
| Presentation Downloaded                                   | off     |
| Project Published                                         | Immediately      |
| Presentation Shared                                       | off     |
| Presentation Viewed                                       | off     |
| Presentation Shared With Users                            | Immediately      |
| Presentation Zip Download Bundle Created                  | off     |
| Preview Approved                                          | off     |
| Preview Escalated                                         | off     |
| Preview Rejected                                          | off     |
| Preview Restored                                          | off     |
| Project Owner Removed                                     | off     |
| Project Publication Notify                                | off     |
| Project Shared                                            | off     |
| Project Shared With Users                                 | off     |
| Project Team Added                                        | off     |
| Project Team Removed                                      | off     |
| Project Unshared                                          | off     |
| Radio Order Delivered                                     | off     |
| Radio Order Downloaded                                    | off     |
| Radio Order Placed                                        | off     |
| Zip Download Bundle Created                               | off     |

Scenario: Check that notifications of an existing Guest User will remain intact after a new release on Warner Bros Home Office and EMEA BU
Meta:@ClientScenarioWarnerBros
!--QA-570
Given I login as user with login 'a5wbadmin@adstream.com' and password 'A5admin_WB'
And I am on user 'gvutest5522b@gmail.com' Notifications Settings page
Then I should see that user 'gvutest5522b@gmail.com' has the complete list of following notifications:
| Name                                                      | Checked |
| Ad Pro Notification                                       | off     |
| Ad Pro Uploader Notification                              | off     |
| Approval Has Been Canceled                                | off     |
| Asset Downloaded From Presentation As Master              | off     |
| Asset Downloaded From Presentation As Proxy               | off     |
| Asset Filter Shared                                       | off     |
| Assets Shared                                             | off     |
| Assets Shared With Users                                  | off     |
| Assets Uploaded                                           | off     |
| Asset Usage Rights Expire Soon                            | off     |
| Asset Usage Rights Updated                                | off     |
| Assign All Asset To User                                  | off     |
| Assign All Destinations To User                           | off     |
| Assign All Storage To User                                | off     |
| Assign Single To User                                     | off     |
| Category Updated                                          | off     |
| Comment Submitted                                         | off     |
| Delivery Item Delivered                                   | off     |
| Delivery Item Ready For Approval                          | off     |
| Delivery Item Ready For Proxy Approval                    | off     |
| Epsilon User Invited                                      | off     |
| Epsilon User Invite Reminded                              | off     |
| File Commented                                            | off     |
| File Downloaded As Master                                 | off     |
| File Downloaded As Preview                                | off     |
| File Matched                                              | off     |
| File Preview Played                                       | off     |
| File Preview Transcode Failed                             | off     |
| File Q C Completed                                        | off     |
| File Revision Uploaded                                    | off     |
| Files Copied                                              | off     |
| Files Copied To Other Project                             | off     |
| Files Deleted                                             | off     |
| Files Downloaded                                          | off     |
| Files Moved                                               | off     |
| Files Moved To Library                                    | off     |
| Files Moved To Other Project                              | off     |
| Files Shared                                              | off     |
| Files Shared With Users                                   | Immediately      |
| Files Updated                                             | off     |
| Files Uploaded                                            | off     |
| File Upload Failed                                        | off     |
| File Upload Requested                                     | off     |
| File Upload Request Reset                                 | off     |
| File Usage Rights Expire Soon                             | off     |
| File Usage Rights Updated                                 | off     |
| Folders Shared                                            | off     |
| Folders Shared With Users                                 | Immediately      |
| Genericxmg Access Requested                               | off     |
| Genericxmg W R Access Requested                           | off     |
| Genericxmg W R Incorrect Asset                            | off     |
| Genericxmg W R Incorrect Assset                           | off     |
| House Number Assigned                                     | off     |
|Legal Proxy Rejected                                       | off     |
| Master Approved                                           | off     |
| Master Delivered                                          | off     |
| Master Escalated                                          | off     |
| Master Rejected                                           | off     |
| New File For Approval                                     | off     |
| Order Delivered                                           | off     |
| Order Generics Upload Requested                           | off     |
| Order Ingested                                            | off     |
| Order Media Ftp Upload Reminder                           | off     |
| Order Media Ftp Upload Requested                          | off     |
| Order Media Physical Upload Reminder                      | off     |
| Order Media Physical Upload Requested                     | off     |
| Order Media SendPlus Upload Reminder                      | off     |
| Order Media SendPlus Upload Requested                     | off     |
| Order Media Upload Reassigned                             | off     |
| Order Media Upload Reminder                               | off     |
| Order Media Upload Requested                              | off     |
| Order Placed                                              | off     |
| Order Subtitles Required                                  | off     |
| Order Transferred                                         | off     |
| Presentation Downloaded                                   | off     |
| Project Published                                         | Immediately      |
| Presentation Shared                                       | off     |
| Presentation Viewed                                       | off     |
| Presentation Shared With Users                            | Immediately      |
| Presentation Zip Download Bundle Created                  | off     |
| Preview Approved                                          | off     |
| Preview Escalated                                         | off     |
| Preview Rejected                                          | off     |
| Preview Restored                                          | off     |
| Project Owner Removed                                     | off     |
| Project Publication Notify                                | off     |
| Project Shared                                            | off     |
| Project Shared With Users                                 | off     |
| Project Team Added                                        | off     |
| Project Team Removed                                      | off     |
| Project Unshared                                          | off     |
| Radio Order Delivered                                     | off     |
| Radio Order Downloaded                                    | off     |
| Radio Order Placed                                        | off     |
| Zip Download Bundle Created                               | Immediately     |
When I logout from account
And I login as user with login 'wbemeaadmin@adbank.me' and password 'A5admin_WB'
And I go to user 'emeaguestuser@yopmail.com' Notifications Settings page
Then I should see that user 'emeaguestuser@yopmail.com' has the complete list of following notifications:
| Name                                                      | Checked |
| Ad Pro Notification                                       | off     |
| Ad Pro Uploader Notification                              | off     |
| Approval Has Been Canceled                                | off     |
| Asset Downloaded From Presentation As Master              | off     |
| Asset Downloaded From Presentation As Proxy               | off     |
| Asset Filter Shared                                       | off     |
| Assets Shared                                             | Immediately     |
| Assets Shared With Users                                  | off     |
| Assets Uploaded                                           | off     |
| Asset Usage Rights Expire Soon                            | off     |
| Asset Usage Rights Updated                                | off     |
| Assign All Asset To User                                  | off     |
| Assign All Destinations To User                           | off     |
| Assign All Storage To User                                | off     |
| Assign Single To User                                     | off     |
| Category Updated                                          | off     |
| Comment Submitted                                         | off     |
| Delivery Item Delivered                                   | off     |
| Delivery Item Ready For Approval                          | off     |
| Delivery Item Ready For Proxy Approval                    | off     |
| Epsilon User Invited                                      | off     |
| Epsilon User Invite Reminded                              | off     |
| File Commented                                            | off     |
| File Downloaded As Master                                 | off     |
| File Downloaded As Preview                                | off     |
| File Matched                                              | off     |
| File Preview Played                                       | off     |
| File Preview Transcode Failed                             | off     |
| File Q C Completed                                        | off     |
| File Revision Uploaded                                    | off     |
| Files Copied                                              | off     |
| Files Copied To Other Project                             | off     |
| Files Deleted                                             | off     |
| Files Downloaded                                          | off     |
| Files Moved                                               | off     |
| Files Moved To Library                                    | off     |
| Files Moved To Other Project                              | off     |
| Files Shared                                              | off     |
| Files Shared With Users                                   | Immediately      |
| Files Updated                                             | off     |
| Files Uploaded                                            | off     |
| File Upload Failed                                        | off     |
| File Upload Requested                                     | off     |
| File Upload Request Reset                                 | off     |
| File Usage Rights Expire Soon                             | off     |
| File Usage Rights Updated                                 | off     |
| Folders Shared                                            | off     |
| Folders Shared With Users                                 | Immediately      |
| Genericxmg Access Requested                               | off     |
| Genericxmg W R Access Requested                           | off     |
| Genericxmg W R Incorrect Asset                            | off     |
| Genericxmg W R Incorrect Assset                           | off     |
| House Number Assigned                                     | off     |
|Legal Proxy Rejected                                       | off     |
| Master Approved                                           | off     |
| Master Delivered                                          | off     |
| Master Escalated                                          | off     |
| Master Rejected                                           | off     |
| New File For Approval                                     | off     |
| Order Delivered                                           | off     |
| Order Generics Upload Requested                           | off     |
| Order Ingested                                            | off     |
| Order Media Ftp Upload Reminder                           | off     |
| Order Media Ftp Upload Requested                          | off     |
| Order Media Physical Upload Reminder                      | off     |
| Order Media Physical Upload Requested                     | off     |
| Order Media SendPlus Upload Reminder                      | off     |
| Order Media SendPlus Upload Requested                     | off     |
| Order Media Upload Reassigned                             | off     |
| Order Media Upload Reminder                               | off     |
| Order Media Upload Requested                              | off     |
| Order Placed                                              | off     |
| Order Subtitles Required                                  | off     |
| Order Transferred                                         | off     |
| Presentation Downloaded                                   | off     |
| Project Published                                         | Immediately      |
| Presentation Shared                                       | off     |
| Presentation Viewed                                       | off     |
| Presentation Shared With Users                            | Immediately      |
| Presentation Zip Download Bundle Created                  | off     |
| Preview Approved                                          | off     |
| Preview Escalated                                         | off     |
| Preview Rejected                                          | off     |
| Preview Restored                                          | off     |
| Project Owner Removed                                     | off     |
| Project Publication Notify                                | off     |
| Project Shared                                            | off     |
| Project Shared With Users                                 | off     |
| Project Team Added                                        | off     |
| Project Team Removed                                      | off     |
| Project Unshared                                          | off     |
| Radio Order Delivered                                     | off     |
| Radio Order Downloaded                                    | off     |
| Radio Order Placed                                        | off     |
| Zip Download Bundle Created                               | Immediately     |

Scenario: Check Project loading time of Warner Bros
Meta:@ClientScenarioWarnerBros
!--QA-548
Given I impersonated as Client user 'a5wbadmin@adstream.com' on opened page
When I go to Dashboard page
And I search by text 'Wonder Woman - INTL WORLDWIDE'
And click show all link for global user search for object 'Projects / Work Requests'
Then the project loading time should be '56' seconds after clicking on project 'Wonder Woman - INTL WORLDWIDE'
When I go to Dashboard page
And I search by text 'Wonder Woman - INTL WORLDWIDE'
And click show all link for global user search for object 'Projects / Work Requests'
Then the project loading time should be '45' seconds after clicking on project 'Wonder Woman - INTL WORLDWIDE'
When I go to Dashboard page
And I search by text 'Wonder Woman - INTL WORLDWIDE'
Then opening 'project' link 'Wonder Woman - INTL WORLDWIDE' in a new tab should be '80' seconds


Scenario: Check Project file loading time of Warner Bros
Meta:@ClientScenarioWarnerBros
!--QA-548
Given I impersonated as Client user 'a5wbadmin@adstream.com' on opened page
When I search by text 'NJG_TV30_EVIL_V4-FOR_TEST.mov'
And wait for '4' seconds
Then file 'NJG_TV30_EVIL_V4-FOR_TEST.mov' loading time should be '6' seconds after clicking file on search results popup
When I go to Dashboard page
And I search by text 'NJG_TV30_EVIL_V4-FOR_TEST.mov'
Then file 'NJG_TV30_EVIL_V4-FOR_TEST.mov' loading time should be '7' seconds after clicking file on search results popup
When I go to Dashboard page
And I search by text 'NJG_TV30_EVIL_V4-FOR_TEST.mov'
Then opening 'file' link 'NJG_TV30_EVIL_V4-FOR_TEST.mov' in a new tab should be '14' seconds


Scenario: Check Project Team loading time of Warner Bros
Meta:@ClientScenarioWarnerBros
!--QA-548
Given I impersonated as Client user 'a5wbadmin@adstream.com' on opened page
When I go to Dashboard page
And I search by text 'Wonder Woman - INTL WORLDWIDE'
And click show all link for global user search for object 'Projects / Work Requests'
Then the project loading time should be '60' seconds after clicking on project 'Wonder Woman - INTL WORLDWIDE'
And team page loading should be '19' seconds after clicking on Team tab

Scenario: Check that notification settings when a new guest user is invited(add user on the fly) via shared folder in the Warner Bros Home Office BU
Meta:@ClientScenarioWarnerBros
Given I impersonated as Client user 'a5wbadmin@adstream.com' on opened page
When I create new project with following fields for Client:
| FieldName                                 | FieldValue         |
| Name                                      | WBP1               |
| Feature Title                             | Argo               |
| Territory                              | Warner Bros Home Office            |
And I create sub folder 'WBF1' in folder '/WBP1' in project 'WBP1' using button NewFolder
And I open Share window from popup menu for folder '/WBF1' on client project 'WBP1'
And I fill Share popup of project folder for user 'new' with role 'WB Project User' expired '12.12.2020' and 'should' check access to subfolders
And click element 'Add' on page 'ShareWindow'
And logout from account
And I login as 'GlobalAdmin'
And I impersonated as Client user 'new' on opened page
And I go to my Notifications Settings page
Then I should see the complete list of following notifications:
| Name                                                      | Checked |
| Ad Pro Notification                                       | off     |
| Ad Pro Uploader Notification                              | off     |
| Approval Has Been Canceled                                | off     |
| Asset Downloaded From Presentation As Master              | off     |
| Asset Downloaded From Presentation As Proxy               | off     |
| Asset Filter Shared                                       | off     |
| Assets Shared                                             | off     |
| Assets Shared With Users                                  | off     |
| Assets Uploaded                                           | off     |
| Asset Usage Rights Expire Soon                            | off     |
| Asset Usage Rights Updated                                | off     |
| Assign All Asset To User                                  | off     |
| Assign All Destinations To User                           | off     |
| Assign All Storage To User                                | off     |
| Assign Single To User                                     | off     |
| Category Updated                                          | off     |
| Comment Submitted                                         | off     |
| Delivery Item Delivered                                   | off     |
| Delivery Item Ready For Approval                          | off     |
| Delivery Item Ready For Proxy Approval                    | off     |
| Epsilon User Invited                                      | off     |
| Epsilon User Invite Reminded                              | off     |
| File Commented                                            | off     |
| File Downloaded As Master                                 | off     |
| File Downloaded As Preview                                | off     |
| File Matched                                              | off     |
| File Preview Played                                       | off     |
| File Preview Transcode Failed                             | off     |
| File Q C Completed                                        | off     |
| File Revision Uploaded                                    | off     |
| Files Copied                                              | off     |
| Files Copied To Other Project                             | off     |
| Files Deleted                                             | off     |
| Files Downloaded                                          | off     |
| Files Moved                                               | off     |
| Files Moved To Library                                    | off     |
| Files Moved To Other Project                              | off     |
| Files Shared                                              | off     |
| Files Shared With Users                                   | Immediately      |
| Files Updated                                             | off     |
| Files Uploaded                                            | off     |
| File Upload Failed                                        | off     |
| File Upload Requested                                     | off     |
| File Upload Request Reset                                 | off     |
| File Usage Rights Expire Soon                             | off     |
| File Usage Rights Updated                                 | off     |
| Folders Shared                                            | off     |
| Folders Shared With Users                                 | Immediately      |
| Genericxmg Access Requested                               | off     |
| Genericxmg W R Access Requested                           | off     |
| Genericxmg W R Incorrect Asset                            | off     |
| Genericxmg W R Incorrect Assset                           | off     |
| House Number Assigned                                     | off     |
|Legal Proxy Rejected                                       | off     |
| Master Approved                                           | off     |
| Master Delivered                                          | off     |
| Master Escalated                                          | off     |
| Master Rejected                                           | off     |
| New File For Approval                                     | off     |
| Order Delivered                                           | off     |
| Order Generics Upload Requested                           | off     |
| Order Ingested                                            | off     |
| Order Media Ftp Upload Reminder                           | off     |
| Order Media Ftp Upload Requested                          | off     |
| Order Media Physical Upload Reminder                      | off     |
| Order Media Physical Upload Requested                     | off     |
| Order Media SendPlus Upload Reminder                      | off     |
| Order Media SendPlus Upload Requested                     | off     |
| Order Media Upload Reassigned                             | off     |
| Order Media Upload Reminder                               | off     |
| Order Media Upload Requested                              | off     |
| Order Placed                                              | off     |
| Order Subtitles Required                                  | off     |
| Order Transferred                                         | off     |
| Presentation Downloaded                                   | off     |
| Project Published                                         | Immediately      |
| Presentation Shared                                       | off     |
| Presentation Viewed                                       | off     |
| Presentation Shared With Users                            | Immediately      |
| Presentation Zip Download Bundle Created                  | off     |
| Preview Approved                                          | off     |
| Preview Escalated                                         | off     |
| Preview Rejected                                          | off     |
| Preview Restored                                          | off     |
| Project Owner Removed                                     | off     |
| Project Publication Notify                                | off     |
| Project Shared                                            | off     |
| Project Shared With Users                                 | off     |
| Project Team Added                                        | off     |
| Project Team Removed                                      | off     |
| Project Unshared                                          | off     |
| Radio Order Delivered                                     | off     |
| Radio Order Downloaded                                    | off     |
| Radio Order Placed                                        | off     |
| Zip Download Bundle Created                               | off     |

