!--NGN-10403
Feature:          Add Administrators to Project
Narrative:
In order to
As a              AgencyAdmin
I want to         Check Adding Administrators to Project


Scenario: Check that message appears in Create Project
Meta:@gdam
     @projects
Given I am on Create New Project page
Then on upload big logo '/files/big_background.jpg' I should see message error 'big_background.jpg is too large, maximum file size is 1Mb.'on projects page


Scenario: Check that message appears on create Template
Meta:@gdam
     @projects
Given I am on Create New Template page
Then on upload big logo '/files/big_background.jpg' I should see message error 'big_background.jpg is too large, maximum file size is 1Mb.'on templates page

