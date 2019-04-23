package com.adstream.automate.babylon.sut.pages.mediamanager;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

/**
 * Created by janaki.kamat on 13/02/2019.
 */
public class MediaCheckerMezzInfoPage extends MediaCheckerPage {
    private static final By COMMITBUTTON = By.xpath("//*[@class='actions']/button[contains(text(),'Commit')]");

    public MediaCheckerMezzInfoPage(ExtendedWebDriver web){super(web);
    }

    public void commitRequestTile() {
        web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath("//*[contains(text(),'Commit to broadcast')]")));
        if (web.isElementPresent(COMMITBUTTON)) {
            web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(COMMITBUTTON));
        }
    }

    public void clickEdit(){
        web.waitUntilElementAppearVisible(By.xpath("//a[contains(@class,'ui compact icon')]"));
        web.findElement(By.xpath("//a[contains(@class,'ui compact icon')]")).click();
    }


    public boolean isFileTypeVisible(String type) {
        long start = System.currentTimeMillis();
        long timeOut = 50;
        long globalTimeOut = 1 * 60 * 1000;
        boolean visible = false;
        String locator = null;
        do {

            if (timeOut > 0)
                Common.sleep(timeOut *2);
            web.navigate().refresh();
            locator = String.format("//div[@class='ui basic clearing center aligned segment']/div[contains(text(),'%s')]", type);

            try {
                if(web.isElementVisible(By.xpath(locator))) {
                    visible = true;
                    break;
                }
            }catch(Exception e){
                e.getMessage();
            }
        }while (System.currentTimeMillis() - start < globalTimeOut) ;
        return visible;
    }
}
