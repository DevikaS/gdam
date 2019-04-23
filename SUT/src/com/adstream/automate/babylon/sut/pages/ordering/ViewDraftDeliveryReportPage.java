package com.adstream.automate.babylon.sut.pages.ordering;

import com.adstream.automate.babylon.JsonObjects.Localization;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.List;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by demidovskiy-r on 13.01.14.
 */
public class ViewDraftDeliveryReportPage extends BaseOrderingPage {
    private Button saveAsPDF;
    private Button saveAsCSV;
    private List<OrderItemUnit> orderItemUnits;

    public ViewDraftDeliveryReportPage(ExtendedWebDriver web) {
        super(web);
        saveAsPDF = new Button(this, generateButtonLocatorByType("pdf"));
        saveAsCSV = new Button(this, generateButtonLocatorByType("csv"));
        orderItemUnits = getOrderItemUnits();
    }

    public void load() {
        web.waitUntilElementAppearVisible(getViewDeliveryReportPageLocator());
    }

    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(getViewDeliveryReportPageLocator()));
    }

    public boolean isSaveAsPDFBtnVisible() {
        return saveAsPDF.isVisible();
    }

    public boolean isSaveAsCSVBtnVisible() {
        return saveAsCSV.isVisible();
    }

    public static class SummaryInformation {
        private String orderReference;
        private String dateCreated;

        public SummaryInformation(WebElement orderSummaryInfo) {
            List<WebElement> summaryCells = orderSummaryInfo.findElements(By.tagName("div"));
            orderReference = summaryCells.get(0).getText();
            dateCreated = summaryCells.get(1).getText();
        }

        public String getOrderReference() {
            return orderReference;
        }

        public String getDateCreated() {
            return dateCreated;
        }
    }

    public static class OrderItemUnit {
        private String clockNumber;
        private String stationGroup;
        private String destination;
        private String serviceLevel;
        private String subtitles;
        private String heldForApproval;

        public OrderItemUnit(ExtendedWebDriver web, WebElement orderItemUnit, boolean isFullUnitData) {
            List<WebElement> unitCells = orderItemUnit.findElements(By.className("unit"));
            clockNumber = unitCells.get(0).getText();
            stationGroup = unitCells.get(1).getText().trim();
            destination = unitCells.get(2).getText().trim();
            serviceLevel = unitCells.get(3).getText().trim();
            subtitles = isFullUnitData ? unitCells.get(4).getText().trim() : "";
            heldForApproval = isFullUnitData ? unitCells.get(5).getText() : unitCells.get(4).getText();
        }

        public String getClockNumber() {
            return clockNumber;
        }

        public String getStationGroup() {
            return stationGroup;
        }

        public String getDestination() {
            return destination;
        }

        public String getServiceLevel() {
            return serviceLevel;
        }

        public String getSubtitles() {
            return subtitles;
        }

        public String getHeldForApproval() {
            return heldForApproval;
        }
    }

    public SummaryInformation getOrderSummaryInformation() {
        if (!web.isElementVisible(getOrderSummaryInformationLocator()))
            throw new NoSuchElementException("There is no Order Summary Information on View Delivery Report page!");
        WebElement orderSummaryInfo = web.findElement(getOrderSummaryInformationLocator());
        return new SummaryInformation(orderSummaryInfo);
    }

    public OrderItemUnit getOrderItemUnitByClockNumber(String clockNumber) {
        for (OrderItemUnit orderItemUnit : getOrderItemUnits())
            if (orderItemUnit.getClockNumber().equals(clockNumber))
                return orderItemUnit;
        return null;
    }

    public OrderItemUnit getOrderItemUnit(String clockNumber, String destination) {
        for (OrderItemUnit orderItemUnit : orderItemUnits)
            if (orderItemUnit.getClockNumber().equals(clockNumber) && orderItemUnit.getDestination().equals(destination))
                return orderItemUnit;
        return null;
    }

    private List<OrderItemUnit> getOrderItemUnits() {
        if (!web.isElementVisible(By.className("phm")))
            throw new NoSuchElementException("Order item units list is not present on View Delivery Report page!");
        if (!web.isElementPresent(getOrderItemUnitLocator())) return null;
        List<WebElement> orderItemUnitRows = web.findElements(getOrderItemUnitLocator());
        List<OrderItemUnit> orderItemUnits = new ArrayList<>();
        for (WebElement row : orderItemUnitRows)
            orderItemUnits.add(new OrderItemUnit(web, row, isFullUnitDataDisplayed()));
        return orderItemUnits;
    }

    private enum UnitTableHeader {
        CLOCK_NUMBER(Localization.CLOCK_NUMBER.getDescription()),
        STATION_GROUP("Station Group"),
        DESTINATION("Destination"),
        SERVICE_LEVEL("Service level"),
        SUBTITLES("Subtitles"),
        HELD_FOR_APPROVAL("Held for approval");

        private String name;

        private UnitTableHeader(String name) {
            this.name = name;
        }

        @Override
        public String toString() {
            return name;
        }
    }

    private boolean isFullUnitDataDisplayed(){
        for (UnitTableHeader unitTableHeader : UnitTableHeader.values())
            if (!web.findElement(getOrderItemUnitTableHeaderLocator()).getText().contains(unitTableHeader.toString()))
                return false;
        return true;
    }

    private By getOrderItemUnitTableHeaderLocator() {
        return generateOrderItemTableElementLocator(".border-bottom");
    }

    private By getOrderItemUnitLocator() {
        return generateOrderItemTableElementLocator("[class$='size1of1']");
    }

    private By generateOrderItemTableElementLocator(String partialLocator) {
        return By.cssSelector(".phm " + partialLocator);
    }

    private By generateButtonLocatorByType(String type) {
        return By.cssSelector(".button[type='" + type + "']");
    }

    private By getOrderSummaryInformationLocator() {
        return By.cssSelector(".pbl .unit:last-child");
    }

    private By getViewDeliveryReportPageLocator() {
        return By.id("report");
    }
}