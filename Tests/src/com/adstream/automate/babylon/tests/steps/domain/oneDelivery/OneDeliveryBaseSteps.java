package com.adstream.automate.babylon.tests.steps.domain.oneDelivery;

import com.adstream.automate.babylon.sut.pages.oneDelivery.OneDeliveryBasePage;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import org.jbehave.core.annotations.Given;

public class OneDeliveryBaseSteps extends BaseStep{

    private OneDeliveryBasePage getOneDeliveryBasePage(){
        return getSut().getPageNavigator().getOneDeliveryBasePage();
    }

    @Given("{I am} on OneDelivery home page")
    public OneDeliveryBasePage navigateToOneDeliveryHomePage(){
        OneDeliveryBasePage page = getOneDeliveryBasePage();
        page.clickOneDeliveryTab();
        return page;
    }

    @Given("{I |}clicked new order on OneDelivery home page")
    public void createNewOrder(){
        navigateToOneDeliveryHomePage().clickNewOrderButton();
    }
}
