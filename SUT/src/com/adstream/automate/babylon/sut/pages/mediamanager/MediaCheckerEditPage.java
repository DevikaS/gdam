package com.adstream.automate.babylon.sut.pages.mediamanager;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

/**
 * Created by Saritha.Dhanala on 02/07/2018.
 */
public class MediaCheckerEditPage extends MediaCheckerPage {
    public MediaCheckerEditPage (ExtendedWebDriver web) {
        super(web);
    }

    public void setDuration(String tcIN, String tcOUT){

        web.findElements(By.xpath("//div[@class='field']//input[@placeholder='HH:MM:SS:FF']"));

        List<WebElement> tcDuration = web.findElements(By.xpath("//div[@class='field']//input[@placeholder='HH:MM:SS:FF']"));
        for(int i=0; i<tcDuration.size(); i++){
            tcDuration.get(i).clear();
            if(i==0)
            tcDuration.get(i).sendKeys(tcIN);
            else if(i==1)
                tcDuration.get(i).sendKeys(tcOUT);
        }
    }

    public void clickSaveChanges(){
        web.findElement(By.xpath("//*[contains(text(),'Save changes')]")).click();
    }

    public String getTCINValue(){
        return web.findElement(By.xpath("//table//td[contains(text(),'TC In')]/following-sibling::td")).getText();
    }

    public String getTCOUTValue(){
        return web.findElement(By.xpath("//table//td[contains(text(),'TC Out')]/following-sibling::td")).getText();
    }
}
