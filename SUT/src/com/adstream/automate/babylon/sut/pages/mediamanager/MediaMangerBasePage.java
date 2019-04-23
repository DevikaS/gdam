package com.adstream.automate.babylon.sut.pages.mediamanager;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Saritha.Dhanala on 06/12/2017.
 */
public class MediaMangerBasePage {

    ExtendedWebDriver web;
    private static final By POPUPHEADER = By.xpath("//div[@class='header']");
    private static final By CONTNUEUPLOADBUTTON = By.xpath("//*[@class='actions']/button[contains(text(),'Continue')]");
    private String textFieldFormat = "//input[contains(@id,'%s')][@type='text']";
    private String listBoxFormat = "//*[contains(@class,'field')]//label[contains(text(),'%s')]//following-sibling::*[@role='combobox']";
    private String dateListFormat = "//*[contains(@class,'field')]//label[contains(text(),'%s')]";

    public MediaMangerBasePage(ExtendedWebDriver web){this.web = web;}

    public void clickHoldButton(){
        web.findElement(By.xpath("//*[text()='On hold']")).click();
    }

    public void clickHistoryButton(){
        web.findElement(By.xpath("//*[text()='History']")).click();
    }

    public void clickMediaChecker(){ web.findElement(By.xpath("//*[text()='Media Checker']")).click(); }

    public void clickLogout(){ web.findElement(By.xpath("//a[@href='/logout']")).click(); }

    public void searchTextMedia(String searchParameter){
        web.waitUntilElementAppear(By.xpath("//input[contains(@placeholder,'title')][@type='text']"));
        WebElement searchLocator = web.findElement(By.xpath("//input[contains(@placeholder,'title')][@type='text']"));
        if(searchLocator.getText()==null) {
            searchLocator.sendKeys(searchParameter);
        }else{
            web.typeClean(By.xpath("//input[contains(@placeholder,'title')][@type='text']"),searchParameter);
        }
        web.sleep(2000);
    }

    public void clickSortByDateList(String type) {
        web.sleep(1000);
        WebElement sortFieldElement =  web.waitUntilElementAppearVisible(By.xpath("//*[@class='dropdown icon']/preceding-sibling::div[contains(text(),'Date')]"));
        web.scrollToElement(sortFieldElement);
        sortFieldElement.click();
        if(type.equals("old"))
            web.findElement(By.xpath("//span[contains(text(),'Date - Oldest First')]")).click();
        else if (type.equals("recent"))
            web.findElement(By.xpath("//span[contains(text(),'Date - Most Recent First')]")).click();
    }


    public List<String> getAssetfieldValues(String fieldName){
        int intCellToFind = 0;
        List<String> fieldValues = new ArrayList<String>();
        WebElement table = web.findElement(By.tagName("table"));
        List<WebElement> tableHeaders = table.findElements(By.tagName("th"));
        WebElement tableBody = table.findElement(By.tagName("tbody"));
        List<WebElement> rows = tableBody.findElements(By.tagName("tr"));
        for(int t =0;t<tableHeaders.size();t++){
            if(tableHeaders.get(t).getText().contains(fieldName)){
                intCellToFind = t;
                break;
            }

        }

        for (WebElement row : rows) {
            List<WebElement> td = row.findElements(By.tagName("td"));
            fieldValues.add(td.get(intCellToFind).getText());
        }

        return fieldValues;

    }


    public void clickSortPerPageList(){
        web.findElement(By.xpath("//*[contains(text(),'24 per page')][@role='alert']")).click();
    }

    public void clickUploadPopUp(){
        try{
            web.waitUntilElementAppearVisible(POPUPHEADER);
            if(web.findElement(POPUPHEADER).isDisplayed()){
                String header = web.findElement(POPUPHEADER).getText();
                if(header.contains("upload")) {
                    web.waitUntilElementAppearVisible(CONTNUEUPLOADBUTTON);
                   web.findElement(CONTNUEUPLOADBUTTON).click();
                    Common.sleep(3000);
                }
            }
        }catch(Exception e){
            e.getMessage();
        }
         web.sleep(3000);

    }

    public String getWarningMessage(){
        return web.findElement(By.cssSelector("html>body>pre")).getText();
    }

    public void authenticateNewExternalUSer(String userName){
        web.get("http://auth.adstreamdev.com:8026/");
        web.switchTo().alert().sendKeys("uatTester" + Keys.TAB + "mmAuth99");
        web.switchTo().alert().accept();
        waitForTheUser("//div[@ng-repeat=\"to in message.Content.Headers['To']\"]", userName);
        web.findElement(By.xpath("//div[@ng-repeat=\"to in message.Content.Headers['To']\"]")).click();
        web.findElement(By.xpath("//a[@href='#preview-plain']")).click();
        String linkToOpen = web.findElement(By.xpath("//div[@class='tab-content']/div/a")).getText();
        web.get(linkToOpen);
        web.findElement(By.linkText("Click here to proceed")).click();


    }

    public void waitForTheUser(String locator, String userName){
        long timeOut = 1500; //2 sec
        long globalTimeout = 2 * 60 * 1000; // 2 min
        long start = System.currentTimeMillis();

        do {
            if (timeOut > 0)
                Common.sleep(timeOut * 2);
            web.navigate().refresh();
            web.findElement(By.xpath("//*[@id='search']")).sendKeys(userName + Keys.ENTER);
           try{
               if(web.isElementVisible(By.xpath(locator)))
                   break;
           }catch(Exception e){
               e.getMessage();
           }

        } while (System.currentTimeMillis() - start < globalTimeout);
    }

    public String[] clicknavigatorRight(){
        web.waitUntilElementAppearVisible(By.xpath("//ul"));
        web.scrollToElement(web.findElement(By.xpath("//ul")));
        List<WebElement> list = web.findElements(By.xpath("//ul/li"));
        String[] a = new String[2];
        String nextValue = null;
        String previousValue = web.findElement(By.xpath("//li[@class='page active']/a")).getText();
        if(list.size()>3 && previousValue!=null){
            web.findElement(By.xpath("//li[@class='next']")).click();
            nextValue = web.findElement(By.xpath("//li[@class='page active']/a")).getText();
        }

        a[0] = previousValue;
        a[1] = nextValue;
        return a;
    }

    public String[] clicknavigatorLeft(){
        List<WebElement> list = web.findElements(By.xpath("//ul/li"));
        String[] a = new String[2];
        String previousValue = null;
        String nextValue = web.findElement(By.xpath("//li[@class='page active']/a")).getText();
        if(list.size()>=3 && nextValue!=null){
            web.findElement(By.xpath("//li[@class='previous']")).click();
            previousValue = web.findElement(By.xpath("//li[@class='page active']/a")).getText();
        }

        a[0] = nextValue;
        a[1] = previousValue;

        return a;
    }

    public List<String> getPaginationSizesPage(String defaultSize){
        web.findElement(By.xpath("//div[@class='ui fluid selection dropdown']//div[contains(text(),'"+defaultSize+"')]")).click();
        return web.findElementsToStrings(By.xpath("//div[@class='visible menu transition']//span"));
    }

    public List<String> getSortbyList(String defaultSort){
        web.findElement(By.xpath("//*[@role='alert'][contains(text(),'"+defaultSort+"')]")).click();
        return web.findElementsToStrings(By.xpath("//div[@class='visible menu transition']//span"));
    }

    public Map<String,String> getRequestDetails(){
        Map<String,String> orderDetails = new HashMap();
        List<WebElement> elements = web.findElements(By.xpath("//*[contains(text(),'Details')]/following-sibling::table//tr//td"));
        for(int i = 0; i<elements.size(); i=i+2){
            orderDetails.put(elements.get(i).getText(), elements.get(i+1).getText());
        }
        return orderDetails;
    }

    public void fillFieldByName(String fieldName, String fieldValue) {
        By textFieldLocator = By.xpath(String.format(textFieldFormat, fieldName));
        By listBoxLocator = By.xpath(String.format(listBoxFormat, fieldName));
        By datelistLocator = By.xpath(String.format(dateListFormat, fieldName));

        if (web.isElementPresent(listBoxLocator)) {
            web.click(listBoxLocator);
            web.findElement(By.xpath(String.format("//span[text()='%s']", fieldValue))).click();
            Common.sleep(1000);

        } else if (web.isElementPresent(datelistLocator)) {
            String locator = null;
            if(fieldName.equals("TC in") || fieldName.equals("TC out") ){
                locator = String.format(dateListFormat, fieldName) + "/following-sibling::input";
                web.typeClean(By.xpath(locator), fieldValue);
                Common.sleep(2000);
       }
            else {
                locator = String.format(dateListFormat, fieldName) + String.format("/following-sibling::*[1]//div[contains(.,'%s')]", fieldValue);
                web.findElement(By.xpath(locator)).click();
                web.findElement(By.xpath(String.format("//span[text()='%s']", fieldValue))).click();
            }

        } else if (web.isElementVisible(textFieldLocator)) {
            if (web.isElementVisible(textFieldLocator)) {
                web.typeClean(textFieldLocator, fieldValue);

            } else {
                throw new IllegalArgumentException(String.format("Unknown field name '%s'", fieldName));
            }
        }
    }

    public void saveRequest(){
        web.findElement(By.xpath("//*[contains(text(),'Save')][@role='button']")).click();
        web.sleep(1000);
    }

    public boolean isErrorMessageExists(){
        return web.isElementVisible(By.xpath("//div[@class='ui error message']"));
    }

    public void logoutAfter_clickUploadPopUp(){
        try{
            if(web.findElement(POPUPHEADER).isDisplayed()){
                String header = web.findElement(POPUPHEADER).getText();
                if(header.contains("upload")) {
                    web.findElement(CONTNUEUPLOADBUTTON).click();
                    web.findElement(By.cssSelector("[class=\"close large icon\"]")).click();
                    web.click(By.xpath("//a[@href='/logout']"));
                }
            }
        }catch(Exception e){
            e.getMessage();
        }
        web.sleep(3000);

    }

    public String getFieldValueByName(String fieldName) {
        By textFieldLocator = By.xpath(String.format(textFieldFormat, fieldName));
        By listBoxLocator = By.xpath(String.format(listBoxFormat, fieldName));
        By datelistLocator = By.xpath(String.format(dateListFormat, fieldName));
        String value=null;
        if(fieldName.equalsIgnoreCase("Duration")){
            StringBuilder sb = new StringBuilder();
            for(WebElement el:web.findElements(By.xpath(String.format("//label[contains(text(),\"%s\")]/following-sibling::div[@class=\"two fields\"]//div[@class=\"text\"]", fieldName)))){
                sb.append(el.getText()).append(",");
            }
            value=sb.subSequence(0,sb.length()-1).toString();
        }
        else if (web.isElementPresent(listBoxLocator)) {
            value=web.findElement(By.xpath(String.format("//label[contains(text(),'%s')]/following-sibling::div[contains(@class,\"ui search\")]//div[@class=\"text\"]", fieldName))).getText();
            Common.sleep(1000);

        } else if (web.isElementVisible(textFieldLocator)) {
            if (web.isElementVisible(textFieldLocator)) {
                value=web.findElement(textFieldLocator).getAttribute("value");

            } else {
                throw new IllegalArgumentException(String.format("Unknown field name '%s'", fieldName));
            }
        }
        return value;
    }


    public void clickTab(String section){
        switch(section){
            case "MasterInfo":
                if(web.isElementPresent(By.cssSelector("[href$=\"/master/info\"]:not([class*='active'])")))
                    web.click(By.cssSelector("[href$=\"/master/info\"]"));
                break;
            case "MasterReport":
                if(web.isElementPresent(By.cssSelector("[href$=\"/master/report\"]:not([class*='active'])")))
                 web.click(By.cssSelector("[href$=\"/master/report\"]"));
                break;
            case "MezzInfo":
                web.navigate().refresh();
                web.waitUntilElementAppear(By.cssSelector("[href$=\"/mezz/info\"]:not([class*='disabled'])"));
                if(web.isElementPresent(By.cssSelector("[href$=\"/mezz/info\"]:not([class*='active disabled'])")))
                  web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.cssSelector("[href$=\"/mezz/info\"]")));
                break;
            case "MezzReport":
                web.navigate().refresh();
                web.waitUntilElementAppear(By.cssSelector("[href$=\"/mezz/report\"]:not([class*='disabled'])"));
                if(web.isElementPresent(By.cssSelector("[href$=\"/mezz/report\"]:not([class*='active disabled'])")))
                  web.getJavascriptExecutor().executeScript("arguments[0].click();",web.findElement(By.cssSelector("[href$=\"/mezz/report\"]")));
                break;
            default:
                throw new IllegalArgumentException(String.format("%s does not exist",section));
        }
    }

    public Map<String,String> getData(String section,String value){
        Map<String,String> orderDetails = new HashMap();
        clickTab(section);
        List<WebElement> elements = web.findElements(By.xpath(String.format("//*[contains(text(),%s)]/following-sibling::table//tr//td",value)));
        for(int i = 0; i<elements.size(); i=i+2){
            orderDetails.put(elements.get(i).getText(), elements.get(i+1).getText());
        }
        return orderDetails;
    }


    public Map<String,String> getQCPassFileInfo(String tab,String data){
        Map<String,String> fileInfo = new HashMap<>();
        clickTab(tab);
        List<WebElement> list = web.findElements(By.xpath("//table/tbody/tr"));
        try {
            for (int i = 0; i < list.size(); i++) {
                fileInfo.put(list.get(i).findElement(By.xpath("td")).getText(), list.get(i).findElement(By.xpath("td/following-sibling::td")).getText());
            }
        }catch(Exception e){
            e.getMessage();
        }
        return fileInfo;
    }

    public void waitUntilQCSpinnerDisappearsInMezzReportPage() {
        long start = System.currentTimeMillis();
        long timeOut = 1000;
        long globalTimeOut = 5 * 60 * 1000;
        do {

            if (timeOut > 0)
                Common.sleep(timeOut * 1);
            try {
                 if(!web.isElementVisible(By.xpath("//div[contains(@class,'middle aligned content')][contains(text(),\"QC Passed\")]"))){
                    web.navigate().refresh();
                    Common.sleep(3000);
                    web.waitUntilElementDisappear(By.xpath("//div[@class='ui massive active text loader']/div[contains(text(),'Mezzanine Auto QC in progress')]"));
                    if(web.findElement(By.xpath("//div[contains(@class,'middle aligned content')][contains(text(),\"QC Passed\")]")).isDisplayed())
                        break;
                }
                else
                    break;

            }catch(Exception e){
                e.getMessage();
            }
         }while (System.currentTimeMillis() - start < globalTimeOut) ;
        if (System.currentTimeMillis() - start > globalTimeOut)
            throw new TimeoutException("Timeout:: Spinner still appears");


    }


    public Map<String,String> getQCPassFileInfo(){
        Map<String,String> fileInfo = new HashMap<>();
        List<WebElement> list = web.findElements(By.xpath("//table/tbody/tr"));
        try {
            for (int i = 0; i < list.size(); i++) {
                fileInfo.put(list.get(i).findElement(By.xpath("td")).getText(), list.get(i).findElement(By.xpath("td/following-sibling::td")).getText());
            }
        }catch(Exception e){
            e.getMessage();
        }
        return fileInfo;
    }

    public String getFileId(){
        String [] subUrl = web.getCurrentUrl().split("/files/");
        String [] subUrl1 = subUrl[1].split("/report");
        return subUrl1[0];
    }


    public boolean isButtonVisible(String type) {
        boolean visible = false;
        try {
            if (web.isElementVisible(By.xpath("//*[contains(text(),'" + type + "')]"))) {
                visible = true;
            }
        }catch(Exception e){
            e.getMessage();
        }
        return  visible;
    }

    public void clickOptionsList(){
        if(web.isElementPresent(By.xpath("//div[@role='listbox'][@aria-expanded=\"false\"]")))
           web.findElement(By.xpath("//div[@role='listbox']")).click();
    }


    public void waitUntilQCErrorMessageappearsInMezzReportPage() {
        long start = System.currentTimeMillis();
        long timeOut = 1000;
        long globalTimeOut = 5 * 60 * 1000;
        do {

            if (timeOut > 0)
                Common.sleep(timeOut * 1);

            try {
                    web.navigate().refresh();
                    Common.sleep(1000);
                    web.waitUntilElementAppear(By.xpath("//*[contains(text(),'Mezzanine QC Report - Critical errors')]"));
                    if(web.findElement(By.xpath("//*[contains(text(),\"Mezzanine QC Report - Critical errors\")]")).isDisplayed())
                        break;


            }catch(Exception e){
                e.getStackTrace();
            }
        }while (System.currentTimeMillis() - start < globalTimeOut) ;
        if (System.currentTimeMillis() - start > globalTimeOut)
            throw new TimeoutException("Timeout:: Spinner still appears");


    }
}
