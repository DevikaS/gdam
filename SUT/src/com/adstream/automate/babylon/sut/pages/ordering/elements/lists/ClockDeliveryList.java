package com.adstream.automate.babylon.sut.pages.ordering.elements.lists;

import com.adstream.automate.babylon.sut.pages.ordering.PageElement;
import com.adstream.automate.babylon.sut.pages.ordering.elements.StepsOrderType;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.ApprovalConfirmationPopUp;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 16.09.13
 * Time: 18:23
 */
public class ClockDeliveryList extends AbstractList {

    public ClockDeliveryList(ExtendedWebDriver web) {
        super(web);
    }

    public static class ClockDelivery extends PageElement<ClockDeliveryList> {
        private WebElement tableRow;
        private WebElement expander;
        private String clockNumber;
        private String advertiser;
        private String brand;
        private String subBrand;
        private String product;
        private String campaign;
        private String title;
        private String firstAirDate;
        private String format;
        private String duration;
        private String status;
        private String approve;
        private WebElement approveRoot;
        private WebElement onHold;

        public ClockDelivery(ExtendedWebDriver web, WebElement rowElement, ClockDeliveryList parent, String orderStatus) {
            super(web, parent);
            this.tableRow = rowElement;
            List<WebElement> cells = rowElement.findElements(By.cssSelector("[data-type='tableRow'] .unit"));
            if (cells.size()>10){
                clockNumber = cells.get(0).findElement(getCellContentLocator()).getText();
                advertiser = cells.get(1).findElement(getCellContentLocator()).getText();
                brand = cells.get(2).findElement(getCellContentLocator()).getText();
                subBrand = cells.get(3).findElement(getCellContentLocator()).getText();
                product = cells.get(4).findElement(getCellSpanContentLocator()).getText();
                title = orderStatus.equals(StepsOrderType.TV.toString()) ? cells.get(5).findElement(getCellSpanContentLocator()).getText() : cells.get(6).findElement(getCellSpanContentLocator()).getText();
                campaign = orderStatus.equals(StepsOrderType.MUSIC.toString()) ? cells.get(5).findElement(getCellSpanContentLocator()).getText() : "";
                firstAirDate = orderStatus.equals(StepsOrderType.TV.toString()) ? cells.get(6).findElement(getCellContentLocator()).getText() : cells.get(7).findElement(getCellContentLocator()).getText();
                format = orderStatus.equals(StepsOrderType.TV.toString()) ? cells.get(7).findElement(getCellSpanContentLocator()).getText() : cells.get(8).findElement(getCellSpanContentLocator()).getText();
                duration = orderStatus.equals(StepsOrderType.TV.toString()) ? cells.get(8).findElement(getCellContentLocator()).getText() : "";
                status = cells.get(9).findElement(getCellContentLocator()).getText();
                approveRoot = cells.get(10).findElement(getCellContentLocator());
            }else{
                clockNumber = cells.get(0).findElement(getCellContentLocator()).getText();
                advertiser = cells.get(1).findElement(getCellContentLocator()).getText();
                brand = cells.get(2).findElement(getCellContentLocator()).getText();
                product = cells.get(3).findElement(getCellSpanContentLocator()).getText();
                title = orderStatus.equals(StepsOrderType.TV.toString()) ? cells.get(4).findElement(getCellSpanContentLocator()).getText() : cells.get(5).findElement(getCellSpanContentLocator()).getText();
                campaign = orderStatus.equals(StepsOrderType.MUSIC.toString()) ? cells.get(4).findElement(getCellSpanContentLocator()).getText() : "";
                firstAirDate = orderStatus.equals(StepsOrderType.TV.toString()) ? cells.get(5).findElement(getCellContentLocator()).getText() : cells.get(6).findElement(getCellContentLocator()).getText();
                format = orderStatus.equals(StepsOrderType.TV.toString()) ? cells.get(6).findElement(getCellSpanContentLocator()).getText() : cells.get(7).findElement(getCellSpanContentLocator()).getText();
                duration = orderStatus.equals(StepsOrderType.TV.toString()) ? cells.get(7).findElement(getCellContentLocator()).getText() : "";
                status = cells.get(8).findElement(getCellContentLocator()).getText();
                approveRoot = cells.get(9).findElement(getCellContentLocator());
            }
            approve = approveRoot.getText();
        }

        public String getClockNumber() {
            return clockNumber;
        }

        public String getAdvertiser() {
            return advertiser;
        }

        public String getBrand() {
            return brand;
        }

        public String getSubBrand() {
            return subBrand;
        }

        public String getProduct() {
            return product;
        }

        public String getTitle() {
            return title;
        }

        public String getCampaign() {
            return campaign;
        }

        public String getFirstAirDate() {
            return firstAirDate;
        }

        public String getFormat() {
            return format;
        }

        public String getStatus() {
            return status;
        }

        public String getDuration() {
            return duration;
        }

        public String getApprove() {
            return approve;
        }

        public ClockDeliveryNestedList getClockDeliveryNestedList() {
            if (!tableRow.getAttribute("class").contains("expanded"))
                expandClockDeliveryNestedList();
            return new ClockDeliveryNestedList(web);
        }

        public ApprovalConfirmationPopUp getApprovalConfirmationPopUp() {
            if (!web.isElementVisible(By.xpath(ApprovalConfirmationPopUp.TITLE_NODE)))
                clickOnHold();
            return new ApprovalConfirmationPopUp(parent, ApprovalConfirmationPopUp.TITLE);
        }

        private void expandClockDeliveryNestedList() {
            if (expander == null)
                expander = tableRow.findElement(By.className("expander"));
            expander.click();
        }

        private void clickOnHold() {
            if (onHold == null)
                onHold = approveRoot.findElement(By.className("onhold"));
            onHold.click();
        }

        private By getCellContentLocator() {
            return By.className("cell-content");
        }

        private By getCellSpanContentLocator() {
            return By.cssSelector(".cell-content span");
        }
    }

    public ClockDelivery getClockDeliveryByClockNumber(String clockNumber, String orderStatus) {
        for (ClockDelivery clockDelivery : getClockDeliveries(orderStatus))
            if (clockDelivery.getClockNumber().equals(clockNumber))
                return clockDelivery;
        return null;
    }

    public List<String> getVisibleClockDeliveries(String orderStatus) {
        List<String> clockNumbers = new ArrayList<String>();
        List<ClockDelivery> clockDeliveries = getClockDeliveries(orderStatus);
        if (clockDeliveries == null) return clockNumbers;
        for (ClockDelivery clockDelivery : clockDeliveries)
            clockNumbers.add(clockDelivery.getClockNumber());
        return clockNumbers;
    }

    private List<ClockDelivery> getClockDeliveries(String orderStatus) {
        if (!web.isElementPresent(getClockDeliveryRowLocator())) return null;
        List<WebElement> rows = web.findElements(getClockDeliveryRowLocator());
        List<ClockDelivery> clockDeliveries = new ArrayList<ClockDelivery>();
        for (WebElement row : rows)
            clockDeliveries.add(new ClockDelivery(web, row, this, orderStatus));
        return clockDeliveries;
    }

    private By getClockDeliveryRowLocator() {
        return generateListLocator("[data-dojo-type='ordering.summary.toggler']");
    }
}