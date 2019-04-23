package com.adstream.automate.babylon.tests.steps.domain.adcost;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.JsonObjects.adcost.CostTemplates;
import com.adstream.automate.babylon.sut.pages.adcost.AdCostsAdminUserOverridePage;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.When;

/**
 * Created by Raja.Gone on 24/04/2017.
 */
public class AdCostsAdminUserOverrideSteps extends AdCostsHelperSteps {

    protected AdCostsAdminUserOverridePage openAdCostsAdminUserOverridePage() {
        return getSut().getPageNavigator().getAdCostsAdminUserOverridePage();
    }

    @Given("I {am |}logged to AdCosts system as '$userName'")
    @When("I {am |}login to AdCosts system as '$userName'")
    public void loginToAdcostAs(String userName) {
        User user = getData().getUserByType(userName);
        if(user == null) {
            userName = wrapUserEmailWithTestSession(userName);
            user = getCoreApiAdmin().getUserByEmail(userName, 0);
        }
        openAdCostsAdminUserOverridePage().loginToAdCostsSystem(user.getId(),false);
        setAdcostUser(user);
    }

    @Given("I {am |}logged to AdCosts system with userID as '$userId'")
    public void loginToAdcostWithUserId(String userId) {
        openAdCostsAdminUserOverridePage().loginToAdCostsSystem(userId,false);
        getSut().getPageNavigator().getAdCostOverviewPage();
        setAdcostUser(userId);
    }

    @When("I {am |}login to AdCosts system with userID as '$userId'")
    public void loginToAdcostWithUserId_WithoutPageRefresh(String userId) {
        openAdCostsAdminUserOverridePage().loginToAdCostsSystem(userId,false);
        setAdcostUser(userId);
    }

    // costType = { Production || Buyout }
    @Given("{I |}get templateId for '$costType' costType")
    public String  templateId(String costType) {
        return getCostTemplateId(costType);
    }


    private String getCostTemplateId(String temaplteType){
        CostTemplates[] templates = getCoreApi().getCostTemplates();
        for(CostTemplates temp:templates)
            if(temp.getCostType().equals(temaplteType))
                return temp.getId();
        return null;
    }
}
