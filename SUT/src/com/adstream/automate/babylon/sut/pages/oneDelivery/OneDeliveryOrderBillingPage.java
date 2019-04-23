package com.adstream.automate.babylon.sut.pages.oneDelivery;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

public class OneDeliveryOrderBillingPage extends OneDeliveryBasePage {

    private String completeButtonLocator = "//button[@data-test-id='btn-continue-to-complete']";

    public OneDeliveryOrderBillingPage(ExtendedWebDriver web){
        super(web);
        waitForPageToLoad();
    }

    public void waitForPageToLoad(){
        web.waitUntilElementAppearVisible(By.xpath(completeButtonLocator));
    }

    public void clickCompleteContinueButton(){
        web.click(By.xpath(completeButtonLocator));
    }
}