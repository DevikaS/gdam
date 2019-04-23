package com.adstream.automate.babylon.tests.steps.domain.traffic;

import com.adstream.automate.babylon.sut.pages.traffic.TrafficOrderEditPage;
import com.adstream.automate.babylon.sut.pages.traffic.element.MasterArrivedPopup;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.When;
import org.jbehave.core.model.ExamplesTable;

/**
 * Created by denysb on 10/12/2015.
 */
public class TrafficMasterArrivedPopUpSteps extends TrafficHelperSteps {

    @Given("{I |}filled the following fields on master arrived traffic pop up:$data")
    @When("{I |}fill the following fields on master arrived traffic pop up:$data")
    public void selectNewConditionforTrafficNewTab(ExamplesTable data){
        MasterArrivedPopup popup = getSut().getPageCreator().getTrafficOrderEditPage().openMasterArrivedPopUp();
        popup.fillMasterArrivedForm(parametrizeTabularRow(data));
        popup.clickSaveButton();
    }

}
