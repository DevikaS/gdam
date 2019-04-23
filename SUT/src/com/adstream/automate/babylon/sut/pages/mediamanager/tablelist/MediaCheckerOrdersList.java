package com.adstream.automate.babylon.sut.pages.mediamanager.tablelist;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.InvalidSelectorException;
import org.openqa.selenium.WebElement;

import java.util.List;
import java.util.concurrent.TimeUnit;

public class MediaCheckerOrdersList extends AbstractMediaCheckerList {
    private static final By cellsSelector = By.cssSelector("[ng-repeat^='definition in $tvOrdersListCtrl.schema']");
    private static final By ordersRowsSelector = By.cssSelector("table tbody tr");
    protected static final By columntitlesSelector = By.xpath("//table/thead/tr/th");

    public MediaCheckerOrdersList(ExtendedWebDriver web) {
        super(web);
    }

    public class AssetOrder {
        private ExtendedWebDriver web;
        private WebElement tableRow;
        private WebElement currentNode;
        private String clockNumber;
        private String agency;
        private String orderReference;
        private String status;
        private String additionalServices;

        public String getClockNumber() {
            return clockNumber;
        }

        public void setClockNumber(String clockNumber) {
            this.clockNumber = clockNumber;
        }

        public String getAgency() {
            return agency;
        }

        public void setAgency(String agency) {
            this.agency = agency;
        }

        public String getOrderReference() {
            return orderReference;
        }

        public void setOrderReference(String orderReference) {
            this.orderReference = orderReference;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public String getAdditionalServices() {
            return additionalServices;
        }

        public void setAdditionalServices(String additionalServices) {
            this.additionalServices = additionalServices;
        }

        public AssetOrder(ExtendedWebDriver driver, WebElement row) {
            this.web = driver;
            currentNode = row;
            tableRow = row;
            List<WebElement> cells = currentNode.findElements(By.cssSelector("td"));
            if (cells.size() == 0) {
                throw new InvalidSelectorException("Selector " + cellsSelector + " is absent");
            }
            initFields(cells);

        }

        private void initFields(List<WebElement> cells) {
            List<String> list = getColumnTitlesNames(columntitlesSelector);
            web.manage().timeouts().implicitlyWait(0, TimeUnit.SECONDS);
            for (int i = 0; i < list.size(); i++) {
                String cellValue = cells.get(i).getText();
                switch (list.get(i)) {
                    case "Request title and clock no.":
                        clockNumber = cellValue.split("\n")[1];
                        break;
                    case "Agency":
                        agency = cellValue;
                        break;
                    case "Status":
                        status = cellValue;
                        break;
                    case "Order ref":
                        orderReference = cellValue;
                        break;
                    case "Additional Services":
                        additionalServices = cellValue;
                        break;
                }

            }
            web.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
        }


    }

    public AssetOrder getOrderByClockNumber(String clockNumber) {
        if (!web.isElementPresent(ordersRowsSelector)) return null;
        List<WebElement> rows = web.findElements(ordersRowsSelector);
        Common.sleep(2000);
        AssetOrder order;
        for (WebElement row : rows) {
            order = new AssetOrder(web, row);
            Common.sleep(2000);
            if (order.getClockNumber().equalsIgnoreCase(clockNumber))
                return order;
        }
        throw new NullPointerException("Order with " + clockNumber + " is absent");
    }
}