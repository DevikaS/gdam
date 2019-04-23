package com.adstream.automate.babylon.sut.pages.oneDelivery;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

public class OneDeliveryOrderCompletePage extends OneDeliveryBasePage {

    private String placeMyOrderButtonLocator = "//button[@data-test-id='btn-place-order']";

    public OneDeliveryOrderCompletePage(ExtendedWebDriver web){
        super(web);
        waitForPageToLoad();
    }

    public void waitForPageToLoad(){
        web.waitUntilElementAppearVisible(By.xpath(placeMyOrderButtonLocator));
    }

    public void clickPlaceMyOrderButton(){
        web.click(By.xpath(placeMyOrderButtonLocator));
    }
}