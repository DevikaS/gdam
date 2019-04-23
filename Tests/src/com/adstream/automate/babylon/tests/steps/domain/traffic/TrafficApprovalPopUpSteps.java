package com.adstream.automate.babylon.tests.steps.domain.traffic;

import com.adstream.automate.babylon.sut.pages.ordering.elements.ServiceLevelType;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.BroadcastDestinationForm;
import com.adstream.automate.babylon.sut.pages.traffic.TrafficOrderItemPage;
import com.adstream.automate.babylon.sut.pages.traffic.element.ApprovePopUp;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;

/**
 * Created by denysb on 09/03/2016.
 */
public class TrafficApprovalPopUpSteps extends TrafficHelperSteps {

    public TrafficOrderItemPage getTrafficOrderItemPage(){
        return getSut().getPageCreator().getTrafficOrderItemPage();
    }

    @Given("{I |}filled the following fields on approval traffic pop up:$data")
    @When("{I |}fill the following fields on approval traffic pop up:$data")
    public void fillApprovalDataForOrderItem(ExamplesTable data){
        ApprovePopUp popup = getTrafficOrderItemPage().getApprovePopUpPage();
        for(Map<String,String> row : parametrizeTableRows(data)){
            if (row.get("Email") != null)
                row.put("Email", wrapUserEmailWithTestSession(row.get("Email")));
            popup.fillApprovalForm(row);
        }
        popup.clickSaveButton();
    }

    @Then("{I |}'$shouldState' see approval option of following destinations for order item on Approve pop up: $fieldsTable")
    public void chkDestinationsCheckedinApprovalPopUp(String shouldState, ExamplesTable fieldsTable){
        Map<String, String> row = parametrizeTabularRow(fieldsTable);
        ApprovePopUp popup = getTrafficOrderItemPage().getApprovePopUpPage();
        for (Map.Entry<String, String> entry: row.entrySet())
            for (String value : entry.getValue().split(";"))
                assertThat("Approval Check Failed for" + entry.getKey(),
                        popup.isChecked(entry.getKey(), value), is(shouldState.equals("should")));
}


    @Given("{I |}filled the following fields on approval traffic pop up for new user:$data")
    @When("{I |}fill the following fields on approval traffic pop up for new user:$data")
    public void fillApprovalDataForOrderItemForUniqueUser(ExamplesTable data){
        ApprovePopUp popup = getTrafficOrderItemPage().getApprovePopUpPage();
        for(Map<String,String> row : parametrizeTableRows(data)){
            if (row.get("Email") != null)
                row.put("Email", wrapUserEmailWithTestSession(row.get("Email")));
            popup.fillApprovalForm(row);
        }
        popup.clickSaveButton();
    }

    @Given("{I |}filled the following fields for specific destination on approval traffic pop up for new user:$data")
    @When("{I |}fill the following fields for specific destination on approval traffic pop up for new user:$data")
    public void fillApprovalDataForOrderItemForSpecDestn(ExamplesTable data){
        ApprovePopUp popup = getTrafficOrderItemPage().getApprovePopUpPage();
        for(Map<String,String> row : parametrizeTableRows(data)){
            if (row.get("Email") != null)
                row.put("Email", wrapUserEmailWithTestSession(row.get("Email")));
            popup.fillApprovalFormSpecDestn(row);
        }
        popup.clickSaveButton();
    }
}


