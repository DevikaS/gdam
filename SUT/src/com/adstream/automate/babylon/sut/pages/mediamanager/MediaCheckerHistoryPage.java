package com.adstream.automate.babylon.sut.pages.mediamanager;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;

/**
 * Created by Saritha.Dhanala on 14/05/2018.
 */
public class MediaCheckerHistoryPage extends MediaMangerBasePage{

    public MediaCheckerHistoryPage(ExtendedWebDriver web){super(web);
        }

    public boolean verifyStatusMessage(String clockNumber, String status, String date){
        boolean isFileAvailable = false;
        long start = System.currentTimeMillis();
        long timeOut = 1500;
        long globalTimeOut = 5 * 60 * 1000;
        do {
            if (timeOut > 0)
                Common.sleep(timeOut * 3);
            web.navigate().refresh();
            try {
                 if (web.findElement(By.xpath("//div[@class='ui basic segment'][1]")).isDisplayed())
                    break;
            }catch(Exception e){
                e.getMessage();
            }
        }while (System.currentTimeMillis() - start < globalTimeOut) ;
        if (System.currentTimeMillis() - start > globalTimeOut)
            throw new TimeoutException("Timeout:: History still doesn't appear");
        WebElement w = web.findElement(By.xpath("//div[@class='ui basic segment'][1]"));
         if(w.findElement(By.xpath("div[1]")).getText().equals(date)){
            for(int i =2;i<=w.findElements(By.xpath("div")).size();i++){
                 if((w.findElement(By.xpath("div["+i+"]")).getText().contains(clockNumber)) && (w.findElement(By.xpath("div["+i+"]")).getText().contains(status))){
                    isFileAvailable = true;
                    break;
                }
            }
        }
        return isFileAvailable;
    }

    public int numberOfResultsInMCHistoryPage(){
        return web.findElements(By.xpath("//div[contains(text(),'File')]")).size();
    }

}
