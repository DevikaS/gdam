package com.adstream.automate.babylon.sut.pages.oneDelivery;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

public class OneDeliveryOrderItemPage extends OneDeliveryBasePage {

    String textLocFormatter = "//input[@placeholder='%s']";
    String textLocFormat = "//div[.='%s']//input";
    String comboLocFormat = "//label[.='%s']//..//input";
    String destinationLocFormat = "//label[.='%s']//..//div[@role='listbox']";

    public OneDeliveryOrderItemPage(ExtendedWebDriver web){
        super(web);
        waitForPageToload();
    }

    public void waitForPageToload(){
        web.waitUntilElementAppearVisible(By.xpath("//div[.='Add details for this clock']"));
    }

    public void waitForDestinationPopUpToload(){
        web.waitUntilElementAppearVisible(By.xpath(String.format(textLocFormatter, "Search...")));
    }

    public void waitForDestinationPopUpToDisappear(){
        web.waitUntilElementDisappear(By.xpath(String.format(textLocFormatter, "Search...")));
    }

    public void fillFieldByName(String fieldName, String fieldValues) {
        By textFieldLocater = By.xpath(String.format(textLocFormatter, fieldName));
        By textFieldLocator = By.xpath(String.format(textLocFormat, fieldName));
        By comboFieldLocator = By.xpath(String.format(comboLocFormat,fieldName));
        By listBoxLocator = By.xpath(String.format(destinationLocFormat,fieldName));

        for (String fieldValue : fieldValues.split(",")) {
            if (web.isElementPresent(textFieldLocater))
                web.typeClean(textFieldLocater, fieldValue);
            else if (web.isElementPresent(textFieldLocator))
                web.typeClean(textFieldLocator,fieldValue);
            else if (web.isElementPresent(comboFieldLocator)) {
                web.typeClean(comboFieldLocator,fieldValue);
                web.click(By.xpath("//span[.='"+fieldValue+"']"));
            } else if (web.isElementPresent(listBoxLocator)) {
                web.getJavascriptExecutor().executeScript("arguments[0].click();", web.findElement(listBoxLocator));
                waitForDestinationPopUpToload();
                String dest[] = fieldValue.split(":");
                web.typeClean(By.xpath(String.format(textLocFormatter, "Search...")),dest[0]);
                if(dest[1].equalsIgnoreCase("STD")) {
                    web.clickThroughJavascript(By.xpath("//tr//td[.='"+dest[0]+"']//..//input[@value='2']"));}
                else if(dest[1].equalsIgnoreCase("EXP")){
                    web.clickThroughJavascript(By.xpath("//tr//td[.='"+dest[0]+"']//..//input[@value='3']")); }
                clickByButtonName("Save");
                waitForDestinationPopUpToDisappear();
            } else
                throw new IllegalArgumentException(String.format("Unknown field name '%s'", fieldName));
        }
    }
}