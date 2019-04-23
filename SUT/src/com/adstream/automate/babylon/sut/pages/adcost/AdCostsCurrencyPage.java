package com.adstream.automate.babylon.sut.pages.adcost;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;



public class AdCostsCurrencyPage extends BaseAdCostPage<AdCostsCurrencyPage> {

    private String currencyTitle;
    private String shortCode;
    private String exchangeRate;
    private String lastDateUpdated;

    public AdCostsCurrencyPage(ExtendedWebDriver web) {
        super(web);
        closeWakeMePopUp();
    }
    public void load() {
        super.load();
    }

        public String getCurrencyTitle() {
            return currencyTitle;
        }

        public String getShortCode() {
            return shortCode;
        }

        public String getExchangeRate() {
            return exchangeRate;
        }

        public void setExchangeRate(String exchangeRate) {
            this.exchangeRate = exchangeRate;
        }

        public String getlastDateUpdated() {
            return lastDateUpdated;
        }

        public void loadCurrencyDetail(String currTitle) {
            String noOfColumns = "//div[contains(@class,'exchange-rate-table')]//*[@class='table-item header layout-row']//*[@layout-align='start center']";
            String noOfRows = "//div[contains(@class,'exchange-rate-table')]//*[@class='table-item item ng-scope layout-row']";
            boolean itemFound = false;
            for (int i = 1; i <= web.findElements(By.xpath(noOfRows)).size()|| itemFound; i++) {
                String curTitle = web.findElement(By.xpath(String.format(noOfRows.concat("[" + i + "]//*[@layout-align='start center'][1]")))).getText();
                for (int j = 1; j <= web.findElements(By.xpath(noOfColumns)).size(); j++) {
                    String columnValue = web.findElement(By.xpath(String.format(noOfColumns).concat("[" + j + "]"))).getText();
                    String itemValue = noOfRows.concat("[" + i + "]//*[@layout-align='start center'][".concat( +j + "]"));
                    if (curTitle.equals(currTitle)) {
                        switch (columnValue) {
                            case "Currency title":
                                currencyTitle = curTitle;
                                break;
                            case "Shortcode":
                                shortCode = web.findElement(By.xpath(itemValue)).getText();
                                break;
                            case "Exchange rate":
                                exchangeRate = web.findElement(By.xpath(itemValue.concat("//input"))).getAttribute("value");
                                break;
                            case "Last date updated":
                                lastDateUpdated = web.findElement(By.xpath(itemValue)).getText();
                                break;
                        }
                        itemFound = true;
                    }
                }
            }
        }

        public void updateCurrency(String currTitle, String exchgRate) {
            String noOfColumns = "//div[contains(@class,'exchange-rate-table')]//*[@class='table-item header layout-row']//*[@layout-align='start center']";
            String noOfRows = "//div[contains(@class,'exchange-rate-table')]//*[@class='table-item item ng-scope layout-row']";
            boolean itemUpdated = false;
            for (int i = 1; i <= web.findElements(By.xpath(noOfRows)).size(); i++) {
                if (itemUpdated==true)
                    break;
                String curTitle = web.findElement(By.xpath(String.format(noOfRows.concat("[" + i + "]//*[@layout-align='start center'][1]")))).getText();
                for (int j = 1; j <= web.findElements(By.xpath(noOfColumns)).size(); j++) {
                    String columnValue = web.findElement(By.xpath(String.format(noOfColumns).concat("[" + j + "]"))).getText();
                    By updateItemLocator = By.xpath(String.format(noOfRows.concat("[" + i + "]//*[@layout-align='start center'][".concat(+j + "]//input[@type='number']"))));
                    if (curTitle.equals(currTitle)) {
                        if (columnValue.equals("Exchange rate")) {
                            web.typeClean(updateItemLocator, exchgRate);
                            web.findElement(By.xpath("//h2[.='Exchange rates']")).click();
                            web.click(updateItemLocator);
                            web.findElement(By.xpath("//h2[.='Exchange rates']")).click();
                            web.waitUntilElementAppearVisible(By.xpath("//span[contains(text(),'Rate successfully updated')]"));
                            itemUpdated = true;
                            break;
                        }
                    }
                }
            }
        }
}