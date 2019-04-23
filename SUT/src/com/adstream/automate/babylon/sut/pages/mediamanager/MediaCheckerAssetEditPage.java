package com.adstream.automate.babylon.sut.pages.mediamanager;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

/**
 * Created by Saritha.Dhanala on 11/07/2018.
 */
public class MediaCheckerAssetEditPage extends MediaCheckerPage {

    public MediaCheckerAssetEditPage(ExtendedWebDriver web){super(web);
    }

    public void clickEdit(){
        web.waitUntilElementAppearVisible(By.xpath("//a[contains(@class,'ui compact icon')]"));
        web.findElement(By.xpath("//a[contains(@class,'ui compact icon')]")).click();
    }

    public boolean isMetaDataDisabled(){
        web.waitUntilElementAppearVisible(By.xpath("//form[@class='ui form']/div[@class='disabled field']"));
        return web.isElementVisible(By.xpath("//form[@class='ui form']/div[@class='disabled field']"));
    }

    public void setPlayahead(){
        List<WebElement> list = web.findElements(By.xpath("//div[@class='field']/button[contains(text(),'Set at playhead')]"));
        web.getJavascriptExecutor().executeScript("arguments[0].click()",web.findElement(By.xpath("//*[@class=\"jw-plugin jw-reset\"]/preceding-sibling::div/div")));
        //Set TC in
        list.get(0).click();
        web.findElement(By.xpath("//div[@data-testid='play-button']")).click();
        web.sleep(500);
        //Set TC out
        list.get(1).click();
    }

}
