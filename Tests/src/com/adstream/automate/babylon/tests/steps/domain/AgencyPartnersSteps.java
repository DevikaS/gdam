package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.sut.pages.admin.agency.AgencyPartnersPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import org.apache.commons.lang3.StringUtils;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * User: lynda-k
 * Date: 25.02.14
 * Time: 12:00
 */
public class AgencyPartnersSteps extends BaseStep {

    protected AgencyPartnersPage getAgencyPartnersPage() {
        return getSut().getPageCreator().getAgencyPartnersPage();
    }

    @Given("{I am |}on agency '$agencyName' partners page")
    @When("{I |}go to agency '$agencyName' partners page")
    public AgencyPartnersPage openAgencyPartnersPage(String agencyName) {
        return getSut().getPageNavigator().getAgencyPartnersPage(getAgencyIdByName(agencyName));
    }

    @Given("{I |}added following partners '$partners' to agency '$agencyName' on partners page")
    @When("{I |}add following partners '$partners' to agency '$agencyName' on partners page")
    public void addPartnersToAgency(String partners, String agencyName) {
        AgencyPartnersPage page = openAgencyPartnersPage(agencyName);
        //getSut().getWebDriver().navigate().refresh();
        Common.sleep(2000);
        for (String partner : partners.split(",")) {
            page.clickNewPartnerButton().setPartnerName(wrapVariableWithTestSession(partner)).clickAction();
            Common.sleep(2000);
        }
    }

    // | Name |
    @Given("{I |}added following partners to agency '$agencyName' on partners page: $data")
    @When("{I |}add following partners to agency '$agencyName' on partners page: $data")
    public void addPartnersToAgency(String agencyName, ExamplesTable data) {
        List<String> partnersList = new ArrayList<String>();
        for (Map<String,String> row : parametrizeTableRows(data)) partnersList.add(row.get("Name"));
        addPartnersToAgency(StringUtils.join(partnersList, ","), agencyName);
    }

    @Given("{I |}removed following partners '$partners' from agency '$agencyName' on partners page")
    @When("{I |}remove following partners '$partners' from agency '$agencyName' on partners page")
    public void removePartnersFromAgency(String partners, String agencyName) {
        AgencyPartnersPage page = openAgencyPartnersPage(agencyName);

        for (String partner : partners.split(",")) {
            page.selectPartner(wrapVariableWithTestSession(partner));
        }
        Common.sleep(2000);
        page.clickRemoveButton().clickAction();
    }

    @Given("{I |} updated partners '$partners' to allow billing from agency '$agencyName'")
    @When("{I |} update partners '$partners' to allow billing from agency '$agencyName'")
    public void enableBillingforPartnerFromAgency(String partners, String agencyName) {
        AgencyPartnersPage page = openAgencyPartnersPage(agencyName);

        for (String partner : partners.split(",")) {
            page.checkAllowBillforPartnerBU(wrapVariableWithTestSession(partner));
        }
    }

    @Then("{I |}'$shouldState' see Set Up Billing button on agency partners page")
    public void checkSetUpBillingButtonVisibility(String shouldState) {
        assertThat("Check Set Up Billing button visibility: ", getAgencyPartnersPage().isSetUpBillingBtnVisible(), is(shouldState.equals("should")));
    }

    // | Name |
    @Then("{I |}'$condition' see following partners on agency '$agencyName' partners page: $data")
    public void addPartnersToAgency(String condition, String agencyName, ExamplesTable data) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        List<String> actualPartnersList = openAgencyPartnersPage(agencyName).getFullPartnersList();

        for (Map<String,String> row : parametrizeTableRows(data)) {
            String expectedPartnerName = wrapVariableWithTestSession(row.get("Name"));
            assertThat(actualPartnersList, shouldState ? hasItem(expectedPartnerName) : not(hasItem(expectedPartnerName)));
        }
    }

    @Then("{I |}should see following type '$agencyType' for agency '$partnersAgencyName' on agency partners page")
    public void checkPartnersAgencyType(String agencyType, String partnersAgencyName) {
        assertThat("Check type for agency: " + partnersAgencyName, getAgencyPartnersPage().getAgencyType(wrapVariableWithTestSession(partnersAgencyName)), equalTo(agencyType));
    }
}