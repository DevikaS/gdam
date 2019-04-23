package com.adstream.automate.babylon.sut.pages.mediamanager;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Saritha.Dhanala on 09/02/2018.
 */
public class MediaManagerQCReportPage extends MediaMangerBasePage{
    public MediaManagerQCReportPage(ExtendedWebDriver web){super(web);
    }

    public String getQCStatusMessage(){
        web.waitUntilElementAppear(By.xpath("//*[@class='ui basic clearing segment']"));
        return web.findElement(By.xpath("//*[@class='ui basic clearing segment']/following-sibling::*[@class='ui basic segment'][1]")).getText();
    }

   public List<String> getQCFailErrorMessages(){
        List<String> errorMessages = new ArrayList<String>();
        List<WebElement> list = web.findElements(By.xpath("//*[@role='listitem']"));
        for (int i = 0; i < list.size(); i++) {
            errorMessages.add(list.get(i).getText());
        }
        return errorMessages;
    }

    public void clickDownloadQAReportButton(){
        web.findElement(By.xpath("//a[contains(@href,'AQA-report')][@role='button']")).click();
    }

    public void clickFileInfoButton(){
        web.findElement(By.xpath("//*[@class='info circle icon']")).click();
    }

    public void clickActionReportButton(String text){
        String locatorPath = String.format("//button[contains(text(),'%s')]",text);
        web.findElement(By.xpath(locatorPath)).click();
    }

    public void clickOnPopup(String buttonName){
        String locatorPath = String.format("//div[@class='actions']//*[contains(text(),'%s')]",buttonName);
        web.findElement(By.xpath(locatorPath)).click();
    }

    public String getFileId(){
        String [] subUrl = web.getCurrentUrl().split("/files/");
        String [] subUrl1 = subUrl[1].split("/report");
        return subUrl1[0];
    }


    public void clickInfoIcon(){
        web.findElement(By.xpath("//*[@class = 'info circle icon']")).click();
    }

    public static class ReportData{
        private String audioCodec;
        private String fileType;
        private String fileSize;
        private String videoCodec;
        private String firstFrameTimeCode;
        private String length;
        private String status;
        private String errors;

        public String getAudioCodec() {
            return audioCodec;
        }

        public String getFileType() {
            return fileType;
        }

        public String getFileSize() {
            return fileSize;
        }

        public String getVideoCodec() {
            return videoCodec;
        }

        public String getFirstFrameTimeCode() {
            return firstFrameTimeCode;
        }

        public String getLength() {
            return length;
        }

        public String getStatus() {
            return status;
        }

        public String getErrors() {
            return errors;
        }
    }

    public String getDurationError(){
        web.waitUntilElementAppearVisible(By.xpath("//*[contains(@class,'icon message') or contains(@class,'ui icon warning message')]"));
        return web.findElement(By.xpath("//*[contains(@class,'icon message') or contains(@class,'ui icon warning message')]")).getText();
    }


    public boolean checkForReuploadButton(){
        return web.isElementPresent(By.xpath("//label[contains(text(),'Re-upload')]"));
    }

    public void reUploadMediaFileViaUI(String filePath){
        web.waitUntilElementAppear(By.xpath("//input[@type=\"file\"]"));
        web.findElement(By.xpath("//input[@type=\"file\"]")).sendKeys(filePath);
        Common.sleep(2000);
    }

    public String getFileUploadErrorMessage(){
        web.waitUntilElementAppearVisible(By.xpath("//*[contains(@class,'ui basic segment')]"));
        return web.findElement(By.xpath("//*[contains(@class,\"ui basic segment\")]")).getText();
    }

    public String getQCErrorMessageMessage(){
        return web.findElement(By.cssSelector(".ui.red.icon.message")).getText();
    }


    }
