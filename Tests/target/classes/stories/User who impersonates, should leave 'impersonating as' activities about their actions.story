!--NGN-12620
Feature:          User who impersonates, should leave impersonating as activities about their actions
Narrative:
In order to
As a              AgencyAdmin
I want to         Check some activities with impersonating as text on Dashboard Files/Assets



Scenario: Check that user sees activity 'project published' on Dashboard with 'Impersonatated by' description
!--NGN-12975 (was open)
Meta: @skip
      @gdam
Given I created users with following fields:
| Email      | Role         | Agency         |
| SLIAATA_U1 | agency.admin | Default agency |
| SLIAATA_U2 | agency.user  | Default agency |
And logged in with details of 'SLIAATA_U1'
And impersonated as user 'SLIAATA_U2' on opened page
When I create '$projectName' project
And publish the project '$projectName'
And logout from account
And login with details of 'SLIAATA_U2'
Then I 'should' see following activities in 'Recent Activity' section on Dashboard page:
| UserName | Message | Value |
| |         published project (Impersonated by SLIAATA_U1)



Scenario: Check that user sees activity 'folder shared' on Dashboard with 'Impersonated by' description
Meta: @gdam


Scenario: Check that user sees activity 'file downloaded' on asset activity tab with 'Impersonated by' description
!--NGN-12973 (was open)
Meta: @skip
      @gdam



Scenario: Check that user sees activity 'file uploaded' on Dashboard with 'Impersonated by' description
!--NGN-12975 (was open)
Meta: @skip
      @gdam


Scenario: Check that user sees activity 'file.edited' on file activity tab with 'Impersonated by' description
!--NGN-12973 (was open)
Meta: @skip
      @gdam


Scenario: Check that user sees activity 'file.deleted' on Dashboard with 'Impersonated by' description
Meta: @gdam


Scenario: Check that user sees activity 'terms and conditions accepted' on Project Overview with 'Impersonated by' description
Meta: @gdam


Scenario: Check that user sees activity 'attachments.added' on file activity tab with 'Impersonated by' description
!--NGN-12973 (was open)
Meta: @skip
      @gdam



Scenario: Check that user sees activity 'attachments.deleted' on Dashboard with 'Impersonated by' description
Meta: @gdam


Scenario: Check that user sees activity 'releted.asset.added' on asset activity tab with 'Impersonated by' description
!--NGN-12973 (was open)
Meta: @skip
     @gdam


Scenario: Check that user sees activity 'created asset from file' on file activity tab with 'Impersonated by' description
!--NGN-12973 (was open)
Meta: @skip
      @gdam


Scenario: Check that user sees activity 'asset viewed' on asset activity tab with 'Impersonated by' description
!--NGN-12973 (was open)
Meta: @skip
      @gdam



Scenario: CHeck that user sees activity 'file shared' on Dashboard  with 'Impersonated by' description
Meta: @gdam