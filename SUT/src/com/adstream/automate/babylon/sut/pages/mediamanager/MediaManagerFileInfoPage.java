package com.adstream.automate.babylon.sut.pages.mediamanager;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Created by Saritha.Dhanala on 02/01/2018.
 */
public class MediaManagerFileInfoPage extends MediaManagerUploadPage {
    private static final By CONFIRMMATCH = By.xpath("//*[@class='actions']/button[contains(text(),'Accept T&C and confirm match')]");

    public MediaManagerFileInfoPage(ExtendedWebDriver web){super(web);
    }

    public String getAdvertiser(){
        return web.findElement(By.xpath("//*[@id='root_advertiser']")).getAttribute("value");
    }

    public String getProduct(){
        return web.findElement(By.cssSelector("#root_product")).getAttribute("value");
    }

    public String getClockNumber(){
        return web.findElement(By.cssSelector("#root_clockNumber")).getAttribute("value");
    }

    public String getTitle(){
        return web.findElement(By.cssSelector("#root_title")).getAttribute("value");
    }

    public String getVersion(){
        return web.findElement(By.cssSelector("#root_version")).getAttribute("value");
    }

    public String getAgency(){
        return web.findElement(By.cssSelector("#root_agency")).getAttribute("value");
    }

    public String getDuration(){
        return  web.findElement(By.cssSelector("#root_duration")).getAttribute("value");
    }

    public int getNumberOfAssets() { return web.findElements(By.xpath("//div[@class='ui centered cards']/a")).size();}

    public void clickQCReportButton(){
        web.findElement(By.xpath("//*[@class='check circle outline icon']")).click();
    }

    public void clickButtonLink(String name){
        switch(name){
            case "ViewDetails"       : web.findElement(By.cssSelector(".close.large.icon")).click();
                                       break;
            case "View matching assets": web.findElement(By.xpath("//span[contains(text(),'View matching assets')]")).click();
                                       break;
            case "View matching asset": web.findElement(By.xpath("//span[contains(text(),'View matching asset')]")).click();
                break;
            case "Choose another asset": web.findElement(By.xpath("//span[contains(text(),'Choose another asset')]")).click();
                                       break;
            case "SafeTile"          : web.findElement(By.xpath("//input[@type='checkbox']")).click();
                                       break;
            default: break;
            }
        }


    public Map<String,String> getRequestDetails(){
        Map<String,String> orderDetails = new HashMap();
        List<WebElement> elements = web.findElements(By.xpath("//table//tr//td"));
        for(int i = 0; i<elements.size(); i=i+2){
            orderDetails.put(elements.get(i).getText(), elements.get(i+1).getText());
        }
       return orderDetails;
    }


    public void closeViewDetails(){
        web.findElement(By.cssSelector(".close.large.icon")).click();
        web.sleep(1000);
    }



    public void selectAsset(String number){
        String locator = String.format("//div[@ class='ui centered cards']/a[%s]",number);
        web.findElement(By.xpath(locator)).click();
        web.sleep(1000);
     }

    public void attachAsset() {
        web.waitUntilElementAppear(By.xpath("//button[contains(text(),'Attach asset')]"));
        web.findElement(By.xpath("//button[contains(text(),'Attach asset')]")).click();
        web.waitUntilElementAppear(CONFIRMMATCH);
        web.findElement(CONFIRMMATCH).click();
        web.sleep(2000);
    }


    public void cancelUpload(){
        web.switchTo().activeElement();
        web.findElement(By.cssSelector(".actions .ui.blue.primary.button")).click();

    }

    public void waitUntilProgressBarFinishesInInfoPage(){
        String loadingVideo = null;
        web.waitUntilElementAppear(By.xpath("//div[@class='ui blue small progress']"));
        do {
            loadingVideo = web.findElement(By.xpath("//div[@class='ui blue small progress']")).getAttribute("data-percent");
        }while(!loadingVideo.equals("100"));
    }

    public void uploadVideoToMediaFileInfoPageViaUI(String filePath){
        web.findElement(By.xpath("//label[@role='button']/input[@type='file']")).sendKeys(filePath);
        clickUploadPopUp();
    }


    public boolean isMediaFilePlayable(){
        long timeOut = 1500;
        long start = System.currentTimeMillis();
        long globalTimeOut = 2*60*1000;
        boolean found=false;
        do{

            if(timeOut > 0)
                web.sleep(timeOut * 3);
            try{
            if(web.isElementVisible(By.xpath("//img[contains(@src,'/static/media/play')]"))){
                web.findElement(By.xpath("//img[contains(@src,'/static/media/play')]")).click();
                web.sleep(200);
                if(web.isElementPresent(By.xpath("//*[contains(@class,'jw-state-playing')]"))) {
                    found=true;
                    break;
                }
         }
        }catch (Exception e) {
                e.getMessage();
            }
        }while( System.currentTimeMillis() - start < globalTimeOut);

       return found;
    }


    public boolean isProgressMessageDisplayed(String assetText) {
        long start = System.currentTimeMillis();
        long timeOut = 1;
        long globalTimeOut = 1 * 60 * 1000; //1min
        boolean textExists = false;

        do {
            web.sleep(timeOut * 1);
            try {
                if (web.isElementVisible(By.xpath(String.format("//p[contains(.,'%s')]",assetText))))
                {
                    textExists = true;
                    break;
                }
            } catch (Exception e) {
                e.getMessage();
            }
        }while (System.currentTimeMillis() - start < globalTimeOut) ;

        return textExists;
    }


    public List<String> getWarningMessages(){
         List<String> messages = new ArrayList<>();
         List<WebElement> list = web.findElements(By.cssSelector(".text-danger"));
         for(WebElement w:list){
             messages.add(w.getText());
         }
         return messages;
     }

    public void waitUntilQCSpinnerDisappearsInInfoPage() {
        long start = System.currentTimeMillis();
        long timeOut = 1500;
        long globalTimeOut = 5 * 60 * 1000;
        do {
            if (timeOut > 0)
                Common.sleep(timeOut * 3);
            web.navigate().refresh();
            try {
                if (web.findElement(By.xpath("//div[@data-testid='play-button']")).isDisplayed())
                    break;
            }catch(Exception e){
                e.getMessage();
            }
            }while (System.currentTimeMillis() - start < globalTimeOut) ;
            if (System.currentTimeMillis() - start > globalTimeOut)
                throw new TimeoutException("Timeout:: Spinner still appears");


    }

    public boolean isSafeTileNotSelected(){
        return web.findElement(By.xpath("//div[@class='ui basic segment' and descendant::div[@class='ui toggle checkbox']]")).isDisplayed();
    }

    public void clickSafeTile(){
        web.getJavascriptExecutor().executeScript("arguments[0].click()",web.findElement(By.xpath("//label[.='Safe title']/..//preceding-sibling::input")));
    }

    public String isSafeFramesVisible(){
        return web.findElement(By.xpath("//div[@class='safe-frame-video']")).getAttribute("style");
    }

    public String[] getSafeFrameOutlineDetails(){
        List<WebElement> list = web.findElements(By.xpath("//div[@class='safe-frame']"));
        String safeFrames [] = new String[list.size()];
        for(int i = 0; i<list.size(); i++) {
            safeFrames[i] = list.get(i).getAttribute("style");
        }
        return safeFrames;
    }


    public List<String> getErrorMessages(){
        List<String> errors = new ArrayList<String>();
        List<WebElement> elements = web.findElements(By.xpath("//ul[contains(@class,'error-detail')]"));
        for(int i = 0; i<elements.size(); i++){
            errors.add(elements.get(i).getText());
        }
        return errors;


    }

    public Map<String,String> getMetaDataDetails(){
        Map<String,String> metaData = new HashMap<>();
        List<WebElement> list = web.findElements(By.xpath("//div[contains(text(),'Details')]/following-sibling::table//tr//td"));

        try {
            for (int i = 0; i < list.size(); i=i+2) {
                 metaData.put(list.get(i).getText(),list.get(i+1).getText());
            }
        }catch(Exception e){
            e.getMessage();
        }
        return metaData;
    }

    public String getDurationError(){
        String message = null;
        try{
            web.waitUntilElementAppearVisible(By.xpath("//div[contains(@class,'ui error icon message') or contains(@class,'ui icon warning message')]"));
            message = web.findElement(By.xpath("//div[contains(@class,'ui error icon message') or contains(@class,'ui icon warning message')]")).getText();
        }catch(Exception e){
            e.getMessage();
            message = "NIL";
        }
       return message;
    }

}
