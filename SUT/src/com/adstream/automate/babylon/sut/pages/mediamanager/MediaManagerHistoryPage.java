package com.adstream.automate.babylon.sut.pages.mediamanager;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Saritha.Dhanala on 16/01/2018.
 */
public class MediaManagerHistoryPage extends MediaMangerBasePage{

    public MediaManagerHistoryPage(ExtendedWebDriver web){super(web);
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


    public void clickClockNumberLink(String clockNumber){
        web.findElement(By.xpath("//*[contains(text(),'"+clockNumber+"')]")).click();
    }


    public Map<String,String> getMetaDataDetails(){
        Map<String,String> metaData = new HashMap<>();
        List<WebElement> list = web.findElements(By.xpath("//div[contains(text(),'Details')]/following-sibling::table//tr"));
        try {
            for (int i = 0; i < list.size(); i++) {
                int first = list.get(i).getText().indexOf(" ");
                int second = list.get(i).getText().indexOf(" ", first);
                if(first > 0 || second > 0)
                    metaData.put(list.get(i).getText().substring(0, second), list.get(i).getText().substring(second));
            }
        }catch(Exception e){
            e.getMessage();
        }
        return metaData;
    }


    public int numberOfResultsDisplayed(){
        return web.findElements(By.xpath("//*[contains(text(),'File')]")).size();
    }

}
