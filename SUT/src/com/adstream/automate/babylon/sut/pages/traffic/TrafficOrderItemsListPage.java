package com.adstream.automate.babylon.sut.pages.traffic;

import com.adstream.automate.babylon.sut.pages.adbank.BaseAdBankPage;
import com.adstream.automate.babylon.sut.pages.traffic.tableList.TrafficOrderList;
import com.adstream.automate.babylon.sut.pages.traffic.tableList.TrafficOrderItemSendList;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import com.adstream.automate.utils.DateTimeUtils;
import org.joda.time.DateTime;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by den4ik on 25-Feb-15.
 */
public class TrafficOrderItemsListPage extends BaseTrafficPage{

    private final static By searchInput = By.cssSelector("[id='txt_filter']");
    private final static By isLoaded = By.cssSelector("[ng-app='trafficWeb']");
    private final static By orderItemList = By.cssSelector("a[ng-if *=\"::$first\"]");
    private static final By filterByDateSelector = By.cssSelector("[ng-click=\"$tabSearchCtrl.showDateRangeSearch = !$tabSearchCtrl.showDateRangeSearch\"]");
    private static final By startSearchSelector = By.cssSelector("[ng-model=\"$dateRangeSearchCtrl._data.start\"]");
    private static final By endSearchSelector = By.cssSelector("[ng-model=\"$dateRangeSearchCtrl._data.end\"]");
    private static final By delFilterDateSelector = By.cssSelector("[class^=\"c-date-range-search__remove-icon\"]");

    public void load(){
        web.waitUntilElementAppearVisible(isLoaded);
    }

    @Override
    public void isLoaded(){
        assertTrue(web.isElementVisible(isLoaded));
    }

    public TrafficOrderItemsListPage(ExtendedWebDriver web) {
        super(web);
    }

    public TrafficOrderItemsListPage orderItemSearch(String value){
        web.findElement(searchInput).clear();
        web.findElement(searchInput).sendKeys(value);
        return new TrafficOrderItemsListPage(web);
    }

    public void openOrderItemUsingClockNumber(String orderId){
        //   web.findElement(By.cssSelector(String.format("a[href^='#/details/order-item/%s']", orderId))).click();
        web.getJavascriptExecutor().executeScript("arguments[0].click();", web.findElement(By.cssSelector(String.format("a[href^='#/details/order-item/%s']", orderId))));
        web.sleep(6000);
    }


    public List getOrderItemsList(){
        List <WebElement> list = web.findElements(orderItemList);
        List <String> results = new ArrayList<>();
        for (WebElement webElement : list) {
            Pattern p = Pattern.compile("([\\w]{24})");
            Matcher m = p.matcher(webElement.getAttribute("href"));
            results.add(m.find()? m.group(1): "");
        }

        return results;
    }


    public String getCsvDownloadUrl(){
        String csvDownloadUrl=null;
        try {
            csvDownloadUrl = web.findElement(By.xpath(".//*[@uib-tooltip=\"Download CSV\"]")).getAttribute("href");
        }
        catch (NoSuchElementException e){
            e.printStackTrace();
        }
        return csvDownloadUrl ;
    }


    public TrafficOrderItemSendList getTrafficOrderItemsList() {
        if (!web.isElementVisible(By.cssSelector("[ng-app='trafficWeb']")))
            throw new NoSuchElementException("Order list is not present on the page!");
        return new TrafficOrderItemSendList(web);
    }

    public void openOrderItemUsingAssetId(String orderId,String assetId){
        web.findElement(By.cssSelector(String.format("a[href^='#/details/order-item/%s?qcAssetId=%s']", orderId,assetId))).click();
        web.sleep(6000);
    }

    public List<String> getfieldValues(String fieldName){
        List<String> fieldValues = new ArrayList<String>();
        WebElement table = web.findElement(By.tagName("table"));
        List<WebElement> tableHeaders = table.findElements(By.tagName("th"));
        WebElement tableBody = table.findElement(By.tagName("tbody"));
        List<WebElement> rows = tableBody.findElements(By.tagName("tr"));

        for(int t =0;t<tableHeaders.size()-1;t++){
            if(tableHeaders.get(t).getText().equals(fieldName)){
                for (WebElement row : rows) {
                    List<WebElement> td = row.findElements(By.tagName("td"));
                    if ((fieldName.equalsIgnoreCase("Last Comment")) && (!td.get(t).getText().equalsIgnoreCase("-")))
                        fieldValues.add(td.get(t).getText());
                    else if(!(fieldName.equalsIgnoreCase("Last Comment")))
                        fieldValues.add(td.get(t).getText());
                }
            }

        }

        return fieldValues;

    }


    public boolean verifyClocksInClockLevelList(String clkNumber) {

        boolean flag = false;
        boolean breakFor=false;
        String getClkNumber = "";
        int rowCount = web.findElements(By.xpath("//table[@ng-if='$tvClocksListCtrl.schema']/tbody/tr[@ng-repeat-start='clock in $tvClocksListCtrl.clocks track by clock._id']")).size();
        for (int row = 1; row <= rowCount; row++) {
            int tdCount = web.findElements(By.xpath("//table[@ng-if='$tvClocksListCtrl.schema']/tbody/tr[" + row + "]/td[@ng-repeat='definition in $tvClocksListCtrl.schema | tableSchema']")).size();
            for (int td = 1; td <= tdCount; td++) {
                getClkNumber = web.findElement(By.xpath("//table[@ng-if='$tvClocksListCtrl.schema']/tbody/tr[" + row + "]/td[" + td + "]")).getText();
                if (getClkNumber.equalsIgnoreCase(clkNumber.trim())) {

                    flag = true;
                    breakFor=true;
                    break;
                }

            }
            if(breakFor){break;}
        }
        return flag;
    }

    public void clickFilterByDateSelector(){
        web.click(filterByDateSelector);
    }

    public void filterByDate(Map<String,String> data) {
        web.click(By.cssSelector("date-range-search button"));
        List<WebElement> elems = web.findElements(By.cssSelector("[ng-repeat=\"option in $dateRangeSearchCtrl.dateOptions\"] a[ng-click=\"$dateRangeSearchCtrl.setSelected(option)\"]"));
        for (WebElement elem : elems) {
            if (data.containsKey("Filter By Date") && data.get("Filter By Date").equalsIgnoreCase(elem.getText())) {
                elem.click();
                break;
            }
        }
        if (data.containsKey("Start Date") && data.get("Start Date") != null) {
            if ("Today".equalsIgnoreCase(data.get("Start Date"))) {
                web.findElement(startSearchSelector).sendKeys(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
            }
        }
        if (data.containsKey("End Date") && data.get("End Date") != null) {
            if ("Today".equalsIgnoreCase(data.get("End Date"))) {
                web.findElement(endSearchSelector).sendKeys(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
            }

        }
        Common.sleep(2000);
        web.findElement(searchField).sendKeys(Keys.ENTER);
        Common.sleep(2000);
    }


    public void delFilterDate(){
        web.click(delFilterDateSelector);
        Common.sleep(2000);
        web.findElement(searchField).sendKeys(Keys.ENTER);
        Common.sleep(2000);
    }
}
