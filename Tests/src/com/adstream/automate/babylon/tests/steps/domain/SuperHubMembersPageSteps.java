package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.JsonObjects.Agency;
import com.adstream.automate.babylon.sut.pages.admin.agency.HubMembersPage;
import com.adstream.automate.babylon.sut.pages.admin.agency.HubMembersPopUpWindow;
import com.adstream.automate.babylon.sut.pages.admin.agency.SuperHubMembersPage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.utils.Common;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.Map;

/**
 * User: Devika Subramanian
 * Date: 15.06.16
 */
public class SuperHubMembersPageSteps extends BaseStep {

    private SuperHubMembersPage getSuperHubMembersPage() {
        return getSut().getPageCreator().getSuperHubMembersPage();
    }

    @Given("{I am |}on agency '$agencyName' super hub members page")
    @When("{I |}go to agency '$agencyName' super hub members page")
    public SuperHubMembersPage openSuperHubMembersPagePage(Agency agency) {
        return getSut().getPageNavigator().getSuperHubMembersPage(agency.getId());

    }

    @Given("{I am |}on agency '$agencyName' hub members page")
    @When("{I |}go to agency '$agencyName' hub members page")
    public HubMembersPage openHubMembersPagePage(Agency agency) {
        return getSut().getPageNavigator().getHubMembersPage(agency.getId());

    }

    @Given("{I |}set house number grouping is '$groupModel' on {hub|super} members page")
    @When("{I |}set house number grouping is '$groupModel' on {hub|super} members page")
    public void setHNGroupModel(String groupModel)
    {
        HubMembersPage page = getSut().getPageCreator().getHubMembersPage();
        page.setHNGroupModel(groupModel);
    }

    @Given("{I |}add super hub members:$superHubMembers")
    @When("{I |}add super hub members:$superHubMembers")
    public void addSuperHubMembers(ExamplesTable superHubMembers)
    {
        SuperHubMembersPage page = getSut().getPageCreator().getSuperHubMembersPage();
        for (int i = 0; i < superHubMembers.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(superHubMembers, i);
            HubMembersPopUpWindow superHubMembersPopUpWindow = page.clickNewSuperHubMember();
            String hubMembers;
            if(row.get("Super Hub Members").equals("A5TestBroadcastTwoStage") || row.get("Super Hub Members").equals("A5TestBroadcastOneStage") || row.get("Super Hub Members").equals("A5TestBroadcastNoApproval"))
                hubMembers = row.get("Super Hub Members");
              else
                hubMembers = wrapVariableWithTestSession(row.get("Super Hub Members"));


          //  String hubMembers = wrapVariableWithTestSession(row.get("Super Hub Members"));
            Common.sleep(10000);
            superHubMembersPopUpWindow.addSuperHubMembers(hubMembers);
            Common.sleep(1000);
        }
    }

    @Given("{I |}add hub members:$hubMembers")
    @When("{I |}add hub members:$hubMembers")
    public void addHubMembers(ExamplesTable hubMembers) {
        HubMembersPage page = getSut().getPageCreator().getHubMembersPage();
        for (int i = 0; i < hubMembers.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(hubMembers, i);
            HubMembersPopUpWindow superHubMembersPopUpWindow = page.clickNewHubMember();
            Agency hubMembers1=getAgencyByName(row.get("Hub Members"));
         //   String hubMembers1 = wrapVariableWithTestSession(row.get("Hub Members"));
            Common.sleep(1000);
            superHubMembersPopUpWindow.addSuperHubMembers(hubMembers1.getName());
            Common.sleep(1000);
        }
    }


    @Given("{I |}add house number:$houseNUmber")
    public void addHouseNumber(ExamplesTable houseNUmber) {
        SuperHubMembersPage page = getSut().getPageCreator().getSuperHubMembersPage();
        int j = 2;
        for (int i = 0; i < houseNUmber.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(houseNUmber, i);
            Common.sleep(2000);
            page.enterHouseNumber(j,row.get("House Number"));
            j++;
        }
        page.clickSaveHouseNumber();
    }
}
