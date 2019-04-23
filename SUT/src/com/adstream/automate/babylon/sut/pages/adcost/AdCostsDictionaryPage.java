package com.adstream.automate.babylon.sut.pages.adcost;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;


public class AdCostsDictionaryPage extends BaseAdCostPage<AdCostsDictionaryPage> {

    public AdCostsDictionaryPage(ExtendedWebDriver web) {
        super(web);
        closeWakeMePopUp();
    }
    public void load() {
        super.load();
    }

    public void updateDictionary(String item, String value) {
        web.click(By.xpath(String.format("//button[@aria-label='%s']", item)));
        web.waitUntilElementAppearVisible(By.xpath(String.format("//md-input-container/input[@aria-label='%s']", item)));
        web.findElement(By.xpath("//md-input-container/label[.='New Entry']//following-sibling::input")).sendKeys(value);
        web.findElement(By.xpath("//ads-md-button[@aria-label='Add']//button/span/span")).click();
        web.waitUntilElementAppearVisible(By.xpath(String.format("//md-input-container[contains(text(),'%s')]", value)));
        web.sleep(200);
    }

    public void updateAddOnFlyFeature(String fieldname){
        String locator = "//md-input-container[contains(text(),'Can Add values on the fly:')]/..//following-sibling::div/md-input-container";
        web.click(By.xpath(String.format("//button[@aria-label='%s']", fieldname)));
        web.waitUntilElementAppearVisible(By.xpath(String.format("//md-input-container/input[@aria-label='%s']", fieldname)));
        if(web.findElement(By.xpath(locator)).getText().equals("false"))
            web.click(By.xpath(locator.concat("//following-sibling::ads-md-button/button")));
        web.sleep(200);
    }
}