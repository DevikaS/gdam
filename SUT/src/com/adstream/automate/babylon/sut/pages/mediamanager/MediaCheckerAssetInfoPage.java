package com.adstream.automate.babylon.sut.pages.mediamanager;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Saritha.Dhanala on 11/07/2018.
 */
public class MediaCheckerAssetInfoPage extends MediaCheckerPage {
    private static final By CONFIRMBUTTON = By.xpath("//*[@class='actions']/button[contains(text(),'Confirm')]");
    private static final By CANCELUPLOADBUTTON = By.xpath("//*[@class='actions']/button[contains(text(),'Cancel')]");

    public MediaCheckerAssetInfoPage(ExtendedWebDriver web){super(web);
    }

    public void deleteRequestTile() {
        web.findElement(By.xpath("//div[@role='option' and (text()='Delete')]")).click();
        if (web.findElement(CONFIRMBUTTON).isDisplayed()) {
            web.findElement(CONFIRMBUTTON).click();
        }
    }


    public void sendToAdproRequestTile() {
        web.findElement(By.xpath("//*[contains(text(),'Send to AdPro')]")).click();
        web.waitUntilElementAppear(CONFIRMBUTTON);
        web.findElement(CONFIRMBUTTON).sendKeys(Keys.ENTER);

    }

    public void downloadOriginalORMezzanine(String type){
        web.waitUntilElementAppear(By.xpath("//div[@class='menu transition visible']"));
        web.findElement(By.xpath(String.format("//a[@class='item'and contains(text(),'%s')]",type))).click();
    }



    public boolean istabVisible(String tab) {
        boolean enabled=false;
        switch(tab){
             case "MezzInfo":
                 enabled = web.isElementPresent(By.cssSelector("[href$=\"/mezz/info\"]:not([class*='disabled'])"));
                 break;
            case "MezzReport":
                enabled=web.isElementPresent(By.cssSelector("[href$=\"/mezz/report\"]:not([class*='disabled'])"));
                break;
            default:
                throw new IllegalArgumentException(String.format("%s does not exist",tab));
        }
        return enabled;
    }


    public boolean isEditButtonVisible(){
        return web.isElementVisible(By.xpath("//*[@class='info fitted icon']"));
    }

    public Map<String,String> getMetaDataDetails(){
        Map<String,String> metaData = new HashMap<>();
        List<WebElement> list = web.findElements(By.xpath("//table//tr//td"));

        try {
            for (int i = 0; i < list.size(); i=i+2) {
                metaData.put(list.get(i).getText(),list.get(i+1).getText());
            }
        }catch(Exception e){
            e.getMessage();
        }
        return metaData;
    }


    public void sendForSubtitlingRequestTile() {
        web.findElement(By.xpath("//*[contains(text(),'Send for subtitling')]")).click();
     }

}
