package com.adstream.automate.babylon.sut.pages.mediamanager;

import com.adstream.automate.babylon.sut.pages.mediamanager.tablelist.MediaCheckerOrdersList;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;
import java.util.List;
import java.util.NoSuchElementException;


/**
 * Created by Saritha.Dhanala on 04/01/2018.
 */
public class MediaCheckerPage extends MediaMangerBasePage {

    public MediaCheckerPage(ExtendedWebDriver web) {
        super(web);
    }

    public void clickSortByInMediaChecker(String sortingType) {
        web.findElement(By.xpath("//label[contains(text(),'Sort by')]/following-sibling::div[@role='listbox']")).click();
        String locator = String.format("//*[contains(text(),'%s')]", sortingType);
        web.findElement(By.xpath(locator)).click();
        web.sleep(1000);
    }

    public void openRequestTile(String clockNumber) {
        web.waitUntilElementAppearVisible(By.xpath(String.format("//*[contains(text(),'%s')]", clockNumber)));
        web.findElement(By.xpath(String.format("//*[contains(text(),'%s')]", clockNumber))).click();
    }



    public void SendRequestBackToUploader(String email) {
        web.findElement(By.xpath("//*[@role='listbox']")).click();
        web.findElement(By.xpath("//div[@role='option' and (text()='Send request back to uploader')]")).click();
        web.typeClean(By.xpath("//input[@type='email']"), email);
        web.findElement(By.xpath("//button[contains(text(),'Confirm')]")).click();


    }

    public boolean isButtonVisibleInMediaChecker(String buttonName) {
        String locator = String.format("//*[contains(text(),'%s')]", buttonName);
        return web.findElement(By.xpath(locator)).isDisplayed();
    }


    public void waitForRequest(String clockNumber) {
        long start = System.currentTimeMillis();
        long timeOut = 1500;
        long globalTimeOut = 6 * 60 * 1000;

        do {
            if (timeOut > 0)
                Common.sleep(timeOut * 3);
            try {
                if (web.findElement(By.xpath("//div[contains(text(),'" + clockNumber + "')]")).isDisplayed()) {
                    break;
                }
            } catch (Exception e) {
                e.getMessage();
            }

        }while (System.currentTimeMillis() - start < globalTimeOut) ;
        if (System.currentTimeMillis() - start > globalTimeOut)
            throw new TimeoutException("Timeout:: Request does not appear");

    }


    public int numberOfResultsInMC(){
        web.waitUntilElementAppear(By.xpath("//table//tr"));
        return web.findElements(By.xpath("//table//tr")).size()-1;
    }

    public boolean isrecentFileDisplayed(String text){
        boolean visible = false;
        try {
            if (web.findElement(By.xpath("//table//tr[1]/td//*[contains(text(),'"+text+"')]")).isDisplayed()) {
                visible = true;
            }
        }catch(Exception e){
            e.getMessage();
        }
        return  visible;
    }

    public void selectMarket(String market){
        List<WebElement> list = web.findElements(By.xpath("//div[@class='ui multiple search selection dropdown']//i[@class='delete icon']"));
        for(int i =0; i<list.size(); i++){
            list.get(i).click();
        }
        web.findElement(By.xpath("//div[@class='ui multiple search selection dropdown']/input")).sendKeys(market);
        web.findElement(By.xpath("//div[@class='visible menu transition']//span")).click();
    }


    public String getDeadlineMessage(){
        return web.findElement(By.cssSelector(".ui.red.icon.message")).getText();
    }

    public MediaCheckerOrdersList getMediaOrderList() {
        if (!web.isElementVisible(By.cssSelector(".ui.container")))
            throw new NoSuchElementException("Order list is not present on the page!");
        return new MediaCheckerOrdersList(web);
    }
}
