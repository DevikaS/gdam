package com.adstream.automate.babylon.sut.pages.oneDelivery;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

public class OneDeliveryBasePage {

    ExtendedWebDriver web;
    private String newOrderButtonLoc = "//a[.='New order']";

    public OneDeliveryBasePage(ExtendedWebDriver web){this.web = web;}

    public void waitForPageToLoad(){
        web.waitUntilElementAppearVisible(By.xpath(newOrderButtonLoc));
    }

    public void clickOneDeliveryTab(){
        web.click(By.xpath("//a[.='ONE Delivery-Beta']"));
        waitForPageToLoad();
    }


    public void clickNewOrderButton(){
        web.findElement(By.xpath(newOrderButtonLoc)).click();
    }

    public void clickByButtonName(String buttonName){
        Common.sleep(1000);
        web.click(By.xpath("//button[.='"+buttonName+"']"));
    }
}
