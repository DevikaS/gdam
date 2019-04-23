package com.adstream.automate.babylon.sut.pages.mediamanager;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;

import java.util.List;


/**
 * Created by Saritha.Dhanala on 06/12/2017.
 */
public class MediaManagerUploadPage extends MediaMangerBasePage{
     protected String buttonNameFormat = "//button//span[contains(text(),\"%s\")]";
     private static final By POPUPHEADER = By.xpath("//div[@class='header']");
     private static final By CANCELUPLOADBUTTON = By.xpath("//*[@class='actions']/button[contains(text(),'Cancel')]");
     private static final By CONFIRMANDSUBMIT = By.xpath("//*[@class='actions']/button[contains(text(),'Confirm terms and submit')]");

     public MediaManagerUploadPage(ExtendedWebDriver web){super(web);
    }

    public void isUploadandQCnewfileEnabled(){
        web.findElement(By.xpath("//input[@class='react-fine-uploader-file-input']")).isEnabled();
    }

    public boolean isEnterDetailstoStartQCDisplayed(String message){
        return web.findElement(By.xpath(String.format("//div[@class='ui card'][1]//div[contains(text(),'%s')]", message))).isDisplayed();
    }

    public void waitUntilProgressBarFinishesInUploadPage(){
           String loadingVideo = null;
            do {
                loadingVideo = web.findElement(By.xpath("//div[@class='ui blue tiny progress']")).getAttribute("data-percent");
            }while(!loadingVideo.equals("100"));
            web.sleep(1000);
        }

    public void waitUntilQCSpinnerDisappearsInUploadsPage() {
        long start = System.currentTimeMillis();
        long timeOut = 1000;
        long globalTimeOut = 5 * 60 * 1000;
        do {

            if (timeOut > 0)
                Common.sleep(timeOut * 1);

            try {
                 web.findElement(By.xpath("//div[@class='ui active inverted text loader']")).isDisplayed();
            }catch(Exception e){
                if(web.findElement(By.xpath("//div[contains(@class,'message')]")).isDisplayed())
                  break;
            }
        }while (System.currentTimeMillis() - start < globalTimeOut) ;
        if (System.currentTimeMillis() - start > globalTimeOut)
            throw new TimeoutException("Timeout:: Spinner still appears");


    }



    public void clickViewdetailsButton(String fileName){
        //.ui.fluid.button[href*='files/'+fileID]
       // web.findElement(By.cssSelector(".ui.fluid.button[href*='files']")).click();
        String locatorXpath = String.format("//div[contains(@class,'content')]/h4[@title='%s']//a[contains(text(),'%s')]",fileName,"View details");
        web.findElement(By.xpath(locatorXpath)).click();
        web.sleep(2000);
    }

    public void clickViewdetailsButton(){
        web.findElement(By.xpath("//a[contains(text(),'View details')]")).click();
        web.sleep(1000);
    }

    public String getNumberOfUploadfiles(){
        return web.findElement(By.xpath("//a[@href='/files/uploads']/div")).getText();
    }

    public void clickMediaRemovalButton(){
        WebElement locator =  web.findElement(By.xpath("//div[@class='ui card'][1]"));
        web.getActions().keyDown(Keys.CONTROL).moveToElement(locator).click().perform();
        web.getActions().keyUp(Keys.CONTROL).perform();
        web.findElement(By.xpath("//*[contains(@class,'ui grey circular top right')]")).click();
    }


    public void clickSubmitNow() {
        for (int i = 1; i <= getNumberOfFilesDisplayed(); i++) {
            try {
                if(web.isElementPresent(By.xpath("//div[@class='ui card'][" + i + "]//button[text()='Submit now']")))
                  web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.xpath("//div[@class='ui card'][" + i + "]//button[text()='Submit now']")));
                Common.sleep(500);
                if (web.isElementPresent(CONFIRMANDSUBMIT)) {
                    WebElement Submit = web.findElement(CONFIRMANDSUBMIT);
                    web.getJavascriptExecutor().executeScript("arguments[0].click();", Submit);
                }
                web.sleep(2000);
            } catch (Exception e) {
                e.getMessage();
            }
        }
    }


    public void confirmDeletion(){
        web.switchTo().activeElement();
        web.findElement(By.cssSelector(".actions .ui.blue.primary.button")).click();

    }

    public boolean isFileExists(String fileName){
        return web.isElementPresent(By.xpath(String.format("//div[contains(@class,'content')]/h4[@title='%s']", fileName)));
    }

    public boolean getFirstFileName(String fileName) {
        String locatorXpath = String.format("//div[@class='ui card'][1]//table//td[contains(text(),'%s')]",fileName);
        return web.isElementPresent(By.xpath(locatorXpath));
    }

    public void enterSearchValue(String searchType){
        web.findElement(By.xpath("//input[@placeholder='Search for clock number']")).sendKeys(searchType);
    }

    public String getQCMessage(){
        //Get the first file QC message
        return web.findElement(By.xpath("//div[@class='ui card'][1]//div[contains(@class,'message')]")).getText();
    }

    public String getResolutionType(){
        return web.findElement(By.xpath("//div[@class='ui card'][1]//div/img[contains(@class,'ui image')]")).getAttribute("src");
    }

    public String getSearchValue(String searchType) {
        String value = null;
        List<WebElement> list = web.findElements(By.xpath("//*[@role='listitem']"));
        for (int i = 0; i < list.size(); i++) {
            if(list.get(i).getText().contains(searchType)) {
                value = list.get(i).getText().split(searchType + " ")[1];
                break;
            }
        }
        return value;
    }

    public void selectFilesDisplayedPerPage(String number){
         web.findElement(By.xpath(String.format("//*[text()='%s']",number))).click();
    }

    public void clickPagingList(){
        web.findElement(By.xpath("//*[contains(@class,'ui compact selection dropdown')]")).click();
    }

    public int getNumberOfFilesDisplayed(){
          web.sleep(2000);
          return web.findElements(By.xpath("//div[@class='ui card']")).size();
    }

    public List<String> getPaginationSizesInUploadPage(){
        return web.findElementsToStrings(By.xpath("//div[@class='menu transition visible']/div/span"));
    }

    public void clickMMPagingButton(String buttonName){
        if(buttonName.equals("NextPagingButton")){
            web.findElement(By.xpath("//li[@class='next']")).click();
        }else if(buttonName.equals("PreviousPagingButton")){
            web.findElement(By.xpath("//li[@class='previous']")).click();
        }
    }

    public void uploadMediaFileToOrderViaUI(String filePath){
        web.findElement(By.xpath("//div[@class='ui card'][1]//input[@type='file']")).sendKeys(filePath);
        clickUploadPopUp();
    }

    public void uploadMediaFileViaUI(String filePath){
        web.waitUntilElementAppear(By.xpath("//label/input[@multiple=''][@type='file']"));
        web.findElement(By.xpath("//label/input[@multiple=''][@type='file']")).sendKeys(filePath);
        clickUploadPopUp();
    }

    public boolean isItInvalidfile(){
        boolean isItInvalidFile = false;
        String header = web.findElement(POPUPHEADER).getText();
        if(header.equals("Error")) {

            web.findElement(By.xpath("//*[@class='actions']/button[contains(text(),'OK')]")).click();
            isItInvalidFile = true;
        }
        return isItInvalidFile;
    }

    public String getErrorMessage(){
        return web.findElement(By.xpath("//*[@class='actions']/preceding-sibling::div[@class='content']")).getText();
    }

    public boolean isMediaFileVisible(String fileName){
        return web.isElementPresent(By.xpath(String.format("//div[contains(@class,'content')]/h4[@title='%s']",fileName)));
    }

    public boolean isButtonPresent(String fileName, String buttonName){
        boolean buttonPresent = false;
        String locatorXpath = String.format("//h4[@title='%s']/following-sibling::div/*[contains(text(),'%s')]", fileName,buttonName);
        try{
          if(web.isElementPresent(By.xpath(locatorXpath)))
            buttonPresent = true;
        }catch (Exception e){
            e.getMessage();
        }
        return buttonPresent;

    }

    public boolean isWarningFailedUploadMessageExist(String message) {
        return web.isElementPresent(getWarningFailedUploadMessage(message)) && web.isElementVisible(getWarningFailedUploadMessage(message));
    }

    private By getWarningFailedUploadMessage(String message) { return By.xpath(String.format("//div[@class='content']/p[text()='%s']", message)); }

    public String getClocknumber(){
        List<WebElement> list  =  web.findElements(By.xpath("//div[@class='ui card'][1]//table//tr"));
        int i = 0 ;
        return list.get(i++).getText().split("Clock no.")[1];
    }

    public boolean isAssetTextDisplayed(String assetText) {
        long start = System.currentTimeMillis();
        long timeOut = 1;
        long globalTimeOut = 1 * 60 * 1000; //1min
        boolean textExists = false;

        do {
            web.sleep(timeOut * 1);
            try {
                if (web.findElement(By.xpath("//div[contains(@class,'text loader')]/div")).getText().equals(assetText)) {
                    textExists = true;
                    break;
                }
            } catch (Exception e) {
                e.getMessage();
            }
        }while (System.currentTimeMillis() - start < globalTimeOut) ;

        return textExists;
    }

    public String getRequestData(){
      return  web.findElement(By.xpath("//div[@class='ui card'][1]/div[1]")).getText();
    }

    public void clickViewdetailsButton_Asset(String asset){
        web.click(By.xpath(String.format("//*[contains(@class,\"ui container\")]//*[contains(@class,\"ui card\")]//h4[contains(text(),\"%s\")]/following-sibling::div//a[contains(text(),\"View details\")]",asset)));
        web.sleep(1000);
    }

    public void Logout_uploadMediaFileViaUI(String filePath){
        web.waitUntilElementAppear(By.xpath("//label/input[@multiple=''][@type='file']"));
        web.findElement(By.xpath("//label/input[@multiple=''][@type='file']")).sendKeys(filePath);
        logoutAfter_clickUploadPopUp();
    }
    public static class MediaMetaData {

        private ExtendedWebDriver web;
        private String advertiser;
        private String product;
        private String market;
        private String clockNumber;
        private String title;

        public MediaMetaData(ExtendedWebDriver web){
            this.web = web;
            List<WebElement> list  =  web.findElements(By.xpath("//div[@class='ui card'][1]//table//tr"));
            int i = 0 ;
            clockNumber = list.get(i++).getText().split("Clock no.")[1];
            title = list.get(i++).getText().split("Title")[1];
            market = list.get(i++).getText().split("Market")[1];
            advertiser = list.get(i++).getText().split("Advertiser")[1];
            product = list.get(i++).getText().split("Product")[1];
        }

        public String getAdvertiser() {
            return advertiser;
        }

        public String getProduct() {
            return product;
        }

        public String getMarket() {
            return market;
        }

        public String getClockNumber() {
            return clockNumber;
        }

        public String getTitle() {
            return title;
        }

    }

}

