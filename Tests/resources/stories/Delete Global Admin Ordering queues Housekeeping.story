
Feature:          Delete Global Admin Ordering queues Housekeeping
Narrative:
In order to
As a              AgencyAdmin
I want to         Delete all Messages in Ordering admin queue

Scenario: check that all orders in orering admin queue can be deleted
!--This is jus to be run for maintenance or housekeeping and not a regular scenario for E2E run
Given I logged in as 'GlobalAdmin'
And I am on Failed Order page
When I delete all orders in failed orders list
And refresh the page without delay
Then I 'should' see '0' Failed orders
When I click on Order completion queue
When I delete all orders in failed orders list
Then I 'should' see '0' Failed orders