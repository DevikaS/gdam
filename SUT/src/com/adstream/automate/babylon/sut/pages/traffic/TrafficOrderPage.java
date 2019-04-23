package com.adstream.automate.babylon.sut.pages.traffic;

import com.adstream.automate.babylon.TestsContext;
import com.adstream.automate.babylon.sut.pages.traffic.element.AdditionalServiceDeliveryStatusPopup;
import com.adstream.automate.babylon.sut.pages.traffic.element.DubbingService;
import com.adstream.automate.babylon.sut.pages.traffic.element.Comment;
import com.adstream.automate.babylon.sut.pages.traffic.element.ProductionService;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Control;
import com.adstream.automate.utils.Common;
import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.InvalidSelectorException;
import org.openqa.selenium.WebElement;

import java.util.*;
import java.util.concurrent.TimeUnit;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by denysb on 17/03/2016.
 */
public class TrafficOrderPage extends BaseTrafficPage {
    protected final static Logger log = Logger.getLogger(TrafficOrderPage.class);
    private final static By isLoaded = By.cssSelector("#main");
    private final static By backButtonSelector = By.cssSelector("[ng-click=\"$detailsPageCtrl.goBack()\"]");
    private static final By cellsSelector = By.cssSelector("h5");
    // private static final By destinationRowsSelector = By.cssSelector("div[ng-repeat='dest in orderItemDestinations']"); // Pre refactoring
    private static final By orderItemRowsSelector = By.cssSelector("[ng-repeat='orderItem in $orderItemsListCtrl.orderItems']");
    private static final By productionServicesSelector = By.cssSelector("[ng-repeat='service in $additionalServicesCtrl.productionServices']");
    private static final By dubbingServicesSelector = By.cssSelector("[ng-repeat='service in $additionalServicesCtrl.dubbingServices']");
    private static final By destinationRowsSelector = By.cssSelector("div[ng-repeat='destination in $deliveryItemsListCtrl.destinations']"); // Post refactoring
    private static final By tableRowSelector = By.cssSelector("h5");
    private static final By columnTitlesSelector = By.cssSelector(".col-sm-2>b");
    private static final By clockReference = By.cssSelector("a[href^='#/details/order-item']");
    //private static final By assignedToSelector = By.cssSelector("[ng-repeat*='rawSelectedOrderData.assignedUsers']");
    private static final By assignedToSelector = By.cssSelector("[ng-repeat*=\"$tvOrderDetailsCtrl.order.assignedUsers\"]");
    private final static long waitforSupportingDocumentsTraffic = 60 * 3000; //3min
    //private static final By emailOfAssignedToSelector = By.cssSelector("[ng-show='au.email']");
    private static final By emailOfAssignedToSelector = By.cssSelector(" [ng-show*=\"assignedUser.email\"]");




    public TrafficOrderPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void isLoaded() {
        assertTrue(web.isElementVisible(isLoaded));
    }

    @Override
    public void init() {
        container = new Control(this, By.cssSelector(".app-wrapper"));
    }

    public void openOrderItemUsingClockNumber(String clockNumber) {
        web.findElement(By.xpath("//a[contains(text(),'" + clockNumber + "')]")).click();
    }

    public int cloneCounts(String clockNumber) {
        // return web.findElements(By.cssSelector("[ng-repeat='oi in orderItems']   a[ng-href^='/traffic/#/details/order-item']")).size(); // Pre refactoring
        return web.findElements(By.cssSelector("[ng-repeat='orderItem in $orderItemsListCtrl.orderItems']   a[href^='#/details/order-item']")).size(); // Post refactoring
    }

    public void openClonedOrderItemUsingClockNumber(String clockNumber, String DestinationName) {
        List<WebElement> DestinationWe = web.findElements(By.xpath(".//*[@class=\"col-sm-3 break-word\"]"));
        for (WebElement Destination : DestinationWe) {
            if (Destination.getText().equalsIgnoreCase(DestinationName)) {
                Destination.findElement(By.xpath("..//a[contains(text()," + clockNumber + ")]")).click();
           break;}
        }
    }

    public void clickButton(String button) {
        web.sleep(2000);
        switch (button) {
            case "Back":
                web.findElement(backButtonSelector).click();
                break;
        }
    }

    public String checkWarningMessage()
    {
        String service = "";
        try
        {
            String warning = web.findElement(By.xpath("//warning-message[@services='$tvOrderDetailsCtrl.unauthorizedServices.items']/div[@class='c-warning-message']/div")).getText();
            int rowCount = web.findElements(By.xpath("//warning-message[@services='$tvOrderDetailsCtrl.unauthorizedServices.items']//li[@class='c-warning-message__service']")).size();
            for (int row = 1; row <= rowCount; row++) {
                String text = web.findElement(By.xpath("//warning-message[@services='$tvOrderDetailsCtrl.unauthorizedServices.items']//li[" + row + "]")).getText();
                service = service + " " + text;
            }
        return warning+service.trim(); }
        catch(Exception e)
        {
            return "";
        }
    }


    public Order getOrderFromTrafficOrderPage() {
        return new Order(web);
    }

    public String getComment(String orderItemId) {
        String comment = null;
        try {
            WebElement clockElement = web.findElement(commentSelector).findElement(By.cssSelector(String.format("a[href^='#/details/order-item/%s']", orderItemId)));
            comment = clockElement.findElement(By.xpath("following-sibling::p")).getText();
        }
        catch (NoSuchElementException e){
            e.printStackTrace();
        }
        return comment;
    }

    public String getProxyCreatedDate(String clockNumber) {
        String proxyCreatedDate = null;
        try {
            web.waitUntilElementAppearVisible(By.cssSelector("[ng-repeat='doc in $supportingDocsCtrl.documents']"));
            List<WebElement> ww = web.findElements(By.cssSelector("[ng-repeat='doc in $supportingDocsCtrl.documents']"));
            for (WebElement w : ww) {
                if (w.findElement(By.cssSelector("td:nth-child(1)")).getText().contains(clockNumber) && w.findElement(By.cssSelector("td:nth-child(1)")).getText().endsWith("mp4")) {
                    proxyCreatedDate = w.findElement(By.cssSelector("td:nth-child(2)")).getText();
                    break;
                }
            }

        }
        catch (Exception e){
            proxyCreatedDate = null;
        }
        return proxyCreatedDate;
    }

    public boolean getSupportingDocument(String fileName) {
        boolean fileavailable = false;
        waitForSupportingDocumentinTraffic(fileName);
        List<String> SupportingDocument = new ArrayList<String>();
        List<WebElement> SuppDocs = web.findElements(SuppDocSelector);
        for (WebElement SuppDoc : SuppDocs) {
            SupportingDocument.add(SuppDoc.getText());
        }
        for (String doc : SupportingDocument) {
            if (doc.contains(fileName)) {
                fileavailable = doc.contains(fileName);
                break;
            }
        }
        return fileavailable;
    }


    public String  getCommentOnOrdetailsPage(String Comment)
    {
        String getComment = null;
        getComment = web.findElement(By.xpath("//p[contains(text(),'" + Comment + "')]")).getText();
        return getComment;
    }



    public Comment clickAddCommentOnOrderDetailsPage()

    {
        web.findElement(By.xpath("//button[@id='add_comment']")).click();
        return new Comment(this);

    }

    public boolean isSupportingDocumentVisible() {
        Common.sleep(2000);
        return web.isElementVisible(SuppDocSelector);
    }



    public String getProxyFiledownloadUrl() {
        String proxyFile = null;
        By locator = By.xpath("//a[@title='Download']");
        //   proxyFile = web.findElement(By.xpath("//*[@id='video-controls']/fieldset/a")).getAttribute("ng-href"); // Pre refactoring
        if (web.isElementVisible(locator))
            proxyFile = web.findElement(locator).getAttribute("href"); // Post refactoring
        else
            proxyFile = "proxyFileDownloadUrlNotVisibleOnPage";

        return proxyFile;
    }

    public void inputJobNumber(String jobNumber) {
        web.waitUntilElementAppearVisible(By.xpath("//div[contains(@class,'detail-item')]/span[.='Job Number:']/../following-sibling::div//span[@class='icon-pencil']")).click();
        web.waitUntilElementAppearVisible(By.cssSelector("input.ng-pristine")).clear();
        web.waitUntilElementAppearVisible(By.cssSelector("div.form-group input")).sendKeys(jobNumber);
    }

    public void inputPONumber(String poNumber) {
        web.waitUntilElementAppearVisible(By.xpath("//div[contains(@class,'detail-item')]/span[.='PO Number:']/../following-sibling::div//span[@class='icon-pencil']")).click();
        web.waitUntilElementAppearVisible(By.cssSelector("input.ng-pristine")).clear();
        web.waitUntilElementAppearVisible(By.cssSelector("div.form-group input")).sendKeys(poNumber);
    }

    public void clickSaveButton() {
        web.click(By.cssSelector("button.btn-primary"));
    }

    public void clickCancelButton() {
        web.click(By.cssSelector("button.btn-danger"));
    }

    public boolean isSuccessMessageDisplayed(String message) {
        String actualMessage = web.waitUntilElementAppearVisible(By.cssSelector("div.toast-message")).getText();
        return actualMessage.equalsIgnoreCase(message);
    }


    public class Order {
        private ExtendedWebDriver web;

        private List<WebElement> assighedTo;

        public List<String> getEmailsOfAssignedToUsers() {
            List<String> emails = new ArrayList<>();
            for (WebElement user : assighedTo) {
                String userEmail = user.findElement(emailOfAssignedToSelector).getText();
                emails.add(userEmail);
            }
            return emails;
        }

        public Order(ExtendedWebDriver driver) {
            this.web = driver;
            assighedTo = web.findElements(assignedToSelector);
        }
    }

    public class DeliveryItem {
        private ExtendedWebDriver web;
        private WebElement currentNode;
        private WebElement tableRow;
        private String clockNumber;
        private String destinationName;
        private String serviceLevel;
        private String deliveryStatus;
        private String onHoldDest;

        public String getOnHoldDest() {
            return onHoldDest;
        }

        public List<WebElement> getColumnTitles() {
            return columnTitles;
        }

        public void setColumnTitles(List<WebElement> columnTitles) {
            this.columnTitles = web.findElements(By.cssSelector(".col-sm-3>b"));
            this.columnTitles.addAll(columnTitles);
        }

        private List<WebElement> columnTitles;

        public ExtendedWebDriver getWeb() {
            return web;
        }

        public String getClockNumber() {
            return clockNumber;
        }

        public String getDestinationName() {
            return destinationName;
        }


        public String getDeliveryStatus() {
            return deliveryStatus;
        }

        public String getServiceLevel() {
            return serviceLevel;
        }

        public WebElement getTableRow() {
            return tableRow;
        }


        public DeliveryItem(WebElement destRow, ExtendedWebDriver driver) {
            this.web = driver;
            currentNode = destRow;
            tableRow = destRow.findElement(tableRowSelector);
            List<WebElement> tail = web.findElements(columnTitlesSelector);
            setColumnTitles(tail.subList(Math.max(tail.size() - 3, 0), tail.size()));
            List<WebElement> cells = currentNode.findElements(cellsSelector);
            if (cells.size() == 0) {
                throw new InvalidSelectorException("Selector " + cellsSelector + " is absent");
            }
            initDestinationFields(cells);
        }


        public List getColumnTitlesNames() {
            List<WebElement> list = getColumnTitles();
            List<String> columnTitles = new ArrayList<String>();
            if (list == null || list.size() == 0) return columnTitles;
            for (WebElement webElement : list) {
                columnTitles.add(webElement.getText().trim());
            }
            return columnTitles;
        }

        private void initDestinationFields(List<WebElement> cells) {
            List<String> list = getColumnTitlesNames();
            web.manage().timeouts().implicitlyWait(0, TimeUnit.SECONDS);
            for (int i = 0; i < list.size(); i++) {
                String cellValue = cells.get(i).getText();
                switch (list.get(i)) {
                    case "Clock number":
                        clockNumber = cellValue;
                        break;
                    case "Destination Name":
                        destinationName = cellValue;
                        break;
                    case "Service Level":
                        serviceLevel = cellValue;
                        break;
                    case "Delivery Status":
                        deliveryStatus = cellValue;
                        break;
                    case "On Hold Dest":
                        onHoldDest = cellValue;
                        break;
                }

            }
            web.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
        }
    }
    public class OrderItem {
        private ExtendedWebDriver web;
        private WebElement currentNode;
        private WebElement tableRow;
        private String status;
        private String clockNumber;
        private String advertiser;
        private String onHold;
        private String title;
        private String product;

        public void setClockNumber(String clockNumber) {
            this.clockNumber = clockNumber;
        }

        public String getAdvertiser() {
            return advertiser;
        }

        public void setAdvertiser(String advertiser) {
            this.advertiser = advertiser;
        }

        public String getProduct() {
            return product;
        }

        public void setProduct(String product) {
            this.product = product;
        }

        public String getOnHold() {
            return onHold;
        }

        public void setOnHold(String onHold) {
            this.onHold = onHold;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public List<WebElement> getColumnTitles() {
            return columnTitles;
        }

        public void setColumnTitles(List<WebElement> columnTitles) {
            this.columnTitles = web.findElements(By.cssSelector(".col-sm-3>b"));
            this.columnTitles.addAll(columnTitles);
        }

        private List<WebElement> columnTitles;

        public ExtendedWebDriver getWeb() {
            return web;
        }

        public String getClockNumber() {
            return clockNumber;
        }

        public WebElement getTableRow() {
            return tableRow;
        }


        public OrderItem(WebElement destRow, ExtendedWebDriver driver) {
            this.web = driver;
            currentNode = destRow;
            tableRow = destRow.findElement(tableRowSelector);
            List<WebElement> tail = web.findElements(columnTitlesSelector);
            setColumnTitles(tail.subList(1, Math.max(tail.size() - 3, 0)));
            List<WebElement> cells = currentNode.findElements(cellsSelector);
            if (cells.size() == 0) {
                throw new InvalidSelectorException("Selector " + cellsSelector + " is absent");
            }
            initOrderItemFields(cells);
        }


        public List getColumnTitlesNames() {
            List<WebElement> list = getColumnTitles();
            List<String> columnTitles = new ArrayList<String>();
            if (list == null || list.size() == 0) return columnTitles;
            for (WebElement webElement : list) {
                columnTitles.add(webElement.getText().trim());
            }
            return columnTitles;
        }

        private void initOrderItemFields(List<WebElement> cells) {
            List<String> list = getColumnTitlesNames();
            web.manage().timeouts().implicitlyWait(0, TimeUnit.SECONDS);
            int COUNT = 0;
            for (String titl : list) {
                switch (titl) {
                    case "Clock number":
                        clockNumber = cells.get(COUNT++).getText();
                        break;
                    case "Advertiser":
                        advertiser = cells.get(COUNT++).getText();
                        break;
                    case "Title":
                        title = cells.get(COUNT++).getText();
                        break;
                    case "Product":
                        product = cells.get(COUNT++).getText();
                        break;
                    case "Status":
                        status = cells.get(COUNT++).getText();
                        break;
                    case "On Hold":
                        onHold = cells.get(COUNT++).getText();
                        break;

                }

            }
            web.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
        }
    }
    public DeliveryItem getDeliveryItemByReference(String clockNumber, String destinationName) {
        if (!web.isElementPresent(destinationRowsSelector)) return null;
        List<WebElement> rows = web.findElements(destinationRowsSelector);
        Common.sleep(5000);
        DeliveryItem delivery;
        for (WebElement row : rows) {
            String actualOrderReference = row.findElements(clockReference).get(0).getText();
            if (actualOrderReference.equalsIgnoreCase(clockNumber)) {
                List<WebElement> destRows = web.findElements(destinationRowsSelector);
                Common.sleep(6000);
                for (WebElement destrow : destRows) {
                    if (destrow.findElements(clockReference).get(0).getText().equalsIgnoreCase(clockNumber) && destrow.findElement(By.cssSelector("h5:nth-of-type(2)")).getText().equalsIgnoreCase(destinationName)) {
                        delivery = new DeliveryItem(destrow, web);
                        Common.sleep(6000);
                        return delivery;
                    }
                }
            }
        }
        throw new NullPointerException("Order with " + clockNumber + " is absent");
    }

    public OrderItem getOrderItemByReference(String clockNumber) {
        if (!web.isElementPresent(orderItemRowsSelector)) return null;
        List<WebElement> rows = web.findElements(orderItemRowsSelector);
        OrderItem item;
        for (WebElement row : rows) {
            String actualOrderReference = row.findElements(clockReference).get(0).getText();
            if (actualOrderReference.equalsIgnoreCase(clockNumber)) {
                List<WebElement> destRows = web.findElements(orderItemRowsSelector);
                for (WebElement destrow : destRows) {
                    if (destrow.findElements(clockReference).get(0).getText().equalsIgnoreCase(clockNumber)) {
                        item = new OrderItem(destrow, web);
                        return item;
                    }
                }
            }
        }
        throw new NullPointerException("Order with " + clockNumber + " is absent");
    }


    public List<OrderItem> getOrderItemForClones(String clockNumber) {
        List<OrderItem> orderItemList = new ArrayList<OrderItem>();
        if (!web.isElementPresent(orderItemRowsSelector)) return null;
        List<WebElement> rows = web.findElements(orderItemRowsSelector);
        OrderItem item;
        for (WebElement row : rows) {
            String actualOrderReference = row.findElements(clockReference).get(0).getText();
            if (actualOrderReference.equalsIgnoreCase(clockNumber)) {
                List<WebElement> destRows = web.findElements(orderItemRowsSelector);
                for (WebElement destrow : destRows) {
                    if (destrow.findElements(clockReference).get(0).getText().equalsIgnoreCase(clockNumber)) {
                        orderItemList.add(new OrderItem(destrow, web));

                    }
                }
                return orderItemList;
            }
        }

        throw new NullPointerException("Order with " + clockNumber + " is absent");
    }

    public OrderReferenceSection getOrderReferenceSection() {
        return new OrderReferenceSection();
    }

    public class OrderReferenceSection {

        private String submitted;
        private String poNumber;
        private String orderItemIngestStatus;
        private String orderSubtitlesRequired;
        private String onHold;
        private String agencyName;
        private String orderAssignedTo;
        private String tapeNumbers;
        private String orderServiceLevelMinutes;
        private String jobNumber;
        private String marketCountry;
        private String orderBilledTo;
        private String productionServicesStatus;
        private String market;
        private String hasAdditionalServices;
        private String submittedBy;
        private String country;
        private String dubbingServicesStatus;
        private String status;
        private String orderServiceLevel;
        private String ingestLocation;
        private String orderReference;
        private String orderLastComment;
        Map<String, String> details = new HashMap();


        public OrderReferenceSection() {
            loadFieldsInOrderRefSection();
        }

        private void loadFieldsInOrderRefSection() {
            List<WebElement> elements = getDriver().findElements(By.cssSelector(".col-sm-6.detail-item"));
            String[] totalElements = null;
            for (int i = 1; i <= elements.size() / 2; i++) {
                if (getDriver().findElement(By.xpath(".//div[contains(@class,'row small')]/*[" + i + "]")).getText().contains("\n")) {
                    totalElements = getDriver().findElement(By.xpath(".//div[contains(@class,'row small')]/*[" + i + "]")).getText().replace("\n", "").split(":");
                } else {
                    totalElements[0] = getDriver().findElement(By.xpath(".//div[contains(@class,'row small')]/*[" + i + "]")).getText();
                    totalElements[1] = "";
                }
                details.put(totalElements[0], totalElements[1]);
            }

            for (Map.Entry<String, String> rowEntry : details.entrySet()) {
                switch (rowEntry.getKey()) {
                    case "Submitted":
                    case "Submitted Date":
                        setSubmitted(details.get("Submitted Date"));
                        break;
                    case "Po Number":
                    case "PO Number":
                        setPoNumber(details.get("PO Number"));
                        break;
                    case "Order Item Ingest Status":
                    case "Order Item Status":
                        setOrderItemIngestStatus(details.get("Order Item Status"));
                        break;
                    case "Order Subtitles Required":
                    case "Subtitles Required":
                        setOrderSubtitlesRequired(details.get("Subtitles Required"));
                        break;
                    case "On Hold":
                        setOnHold(details.get("On Hold"));
                        break;
                    case "Agency Name":
                    case "Agency":
                        setAgencyName(details.get("Agency"));
                        break;
                    case "Order Assigned To":
                        setOrderAssignedTo(details.get("Order Assigned To"));
                        break;
                    case "Tape Numbers":
                        setTapeNumbers(details.get("Tape Numbers"));
                        break;
                    case "Order Service Level Minutes":
                    case "Service Level Minutes":
                        setOrderServiceLevelMinutes(details.get("Service Level Minutes"));
                        break;
                    case "Job Number":
                        setJobNumber(details.get("Job Number"));
                        break;
                    case "Market Country":
                        setMarketCountry(details.get("Market Country"));
                        break;
                    case "Order Billed To":
                        setOrderBilledTo(details.get("Order Billed To"));
                        break;
                    case "Production Services Status":
                        setProductionServicesStatus(details.get("Production Services Status"));
                        break;
                    case "Market":
                        setMarket(details.get("Market"));
                        break;
                    case "Has Additional Services":
                    case "Additional Services":
                        setHasAdditionalServices(details.get("Additional Services"));
                        break;
                    case "Submitted By":
                        setSubmittedBy(details.get("Submitted By"));
                        break;
                    case "Country":
                    case "Agency Country":
                        setCountry(details.get("Agency Country"));
                        break;
                    case "Dubbing Services Status":
                        setDubbingServicesStatus(details.get("Dubbing Services Status"));
                        break;
                    case "Status":
                    case "Order Status":
                        setStatus(details.get("Order Status"));
                        break;
                    case "Order Service Level":
                    case "Service Level":
                        setOrderServiceLevel(details.get("Service Level"));
                        break;
                    case "Ingest Location":
                        setIngestLocation(details.get("Ingest Location"));
                        break;
                    case "Order Reference":
                    case "Reference":
                        setOrderReference(details.get("Reference"));
                        break;
                    case "Order Last Comment":
                    case "Last Comment":
                        setOrderLastComment(details.get("Order Last Comment"));
                        break;
                }
            }
        }

        public String getPoNumber() {
            return poNumber;
        }

        public void setPoNumber(String poNumber) {
            this.poNumber = poNumber;
        }

        public String getOrderItemIngestStatus() {
            return orderItemIngestStatus;
        }

        public void setOrderItemIngestStatus(String orderItemIngestStatus) {
            this.orderItemIngestStatus = orderItemIngestStatus;
        }

        public String getOrderSubtitlesRequired() {
            return orderSubtitlesRequired;
        }

        public void setOrderSubtitlesRequired(String orderSubtitlesRequired) {
            this.orderSubtitlesRequired = orderSubtitlesRequired;
        }

        public String getOnHold() {
            return onHold;
        }

        public void setOnHold(String onHold) {
            this.onHold = onHold;
        }

        public String getAgencyName() {
            return agencyName;
        }

        public void setAgencyName(String agencyName) {
            this.agencyName = agencyName;
        }

        public String getOrderAssignedTo() {
            return orderAssignedTo;
        }

        public void setOrderAssignedTo(String orderAssignedTo) {
            this.orderAssignedTo = orderAssignedTo;
        }

        public String getTapeNumbers() {
            return tapeNumbers;
        }

        public void setTapeNumbers(String tapeNumbers) {
            this.tapeNumbers = tapeNumbers;
        }

        public String getOrderServiceLevelMinutes() {
            return orderServiceLevelMinutes;
        }

        public void setOrderServiceLevelMinutes(String orderServiceLevelMinutes) {
            this.orderServiceLevelMinutes = orderServiceLevelMinutes;
        }

        public String getJobNumber() {
            return jobNumber;
        }

        public void setJobNumber(String jobNumber) {
            this.jobNumber = jobNumber;
        }

        public String getMarketCountry() {
            return marketCountry;
        }

        public void setMarketCountry(String marketCountry) {
            this.marketCountry = marketCountry;
        }

        public String getOrderBilledTo() {
            return orderBilledTo;
        }

        public void setOrderBilledTo(String orderBilledTo) {
            this.orderBilledTo = orderBilledTo;
        }

        public String getProductionServicesStatus() {
            return productionServicesStatus;
        }

        public void setProductionServicesStatus(String productionServicesStatus) {
            this.productionServicesStatus = productionServicesStatus;
        }

        public String getMarket() {
            return market;
        }

        public void setMarket(String market) {
            this.market = market;
        }

        public String getHasAdditionalServices() {
            return hasAdditionalServices;
        }

        public void setHasAdditionalServices(String hasAdditionalServices) {
            this.hasAdditionalServices = hasAdditionalServices;
        }

        public String getSubmittedBy() {
            return submittedBy;
        }

        public void setSubmittedBy(String submittedBy) {
            this.submittedBy = submittedBy;
        }

        public String getCountry() {
            return country;
        }

        public void setCountry(String country) {
            this.country = country;
        }

        public String getDubbingServicesStatus() {
            return dubbingServicesStatus;
        }

        public void setDubbingServicesStatus(String dubbingServicesStatus) {
            this.dubbingServicesStatus = dubbingServicesStatus;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public String getOrderServiceLevel() {
            return orderServiceLevel;
        }

        public void setOrderServiceLevel(String orderServiceLevel) {
            this.orderServiceLevel = orderServiceLevel;
        }

        public String getIngestLocation() {
            return ingestLocation;
        }

        public void setIngestLocation(String ingestLocation) {
            this.ingestLocation = ingestLocation;
        }

        public String getOrderReference() {
            return orderReference;
        }

        public void setOrderReference(String orderReference) {
            this.orderReference = orderReference;
        }

        public String getOrderLastComment() {
            return orderLastComment;
        }

        public void setOrderLastComment(String orderLastComment) {
            this.orderLastComment = orderLastComment;
        }

        public String getSubmitted() {
            return submitted;
        }

        public void setSubmitted(String submitted) {
            this.submitted = submitted;
        }


    }
    public String downloaDeliveryRptDwldUrl(String orderId) {
        String delvRptDwnldUrl = "/api/traffic/v1/order/" + orderId;
        String downloadLocation = TestsContext.getInstance().deliveryServerUrl + delvRptDwnldUrl;
        return downloadLocation;
    }

    public ProductionService getProductionService(String clockNumber, String Type) {
        if (!web.isElementPresent(productionServicesSelector)) return null;
        List<WebElement> rows = web.findElements(productionServicesSelector);
        ProductionService item;
        for (WebElement row : rows) {
            if (row.findElement(By.cssSelector("td[ng-if='$additionalServicesCtrl.showClockNumber']")).getText().equalsIgnoreCase(clockNumber) && row.findElement(By.cssSelector("td:nth-of-type(2)")).getText().equalsIgnoreCase(Type)) {
                item = new ProductionService(row, web);
                return item;
            }}
        throw new NullPointerException("Order with " + clockNumber + " is absent");
    }

    public DubbingService getDubbingService(String clockNumber, String Type) {
        if (!web.isElementPresent(dubbingServicesSelector)) return null;
        List<WebElement> rows = web.findElements(dubbingServicesSelector);
        DubbingService item;
        for (WebElement row : rows) {
            if (row.findElement(By.cssSelector("td[ng-if='$additionalServicesCtrl.showClockNumber']")).getText().equalsIgnoreCase(clockNumber) && row.findElement(By.cssSelector("td:nth-of-type(2)")).getText().equalsIgnoreCase(Type)) {
                item = new DubbingService(row, web);
                return item;
            }}
        throw new NullPointerException("Order with " + clockNumber + " is absent");
    }

    protected void waitForSupportingDocumentinTraffic(String fileName) {
        long start = System.currentTimeMillis();
        do {
            List<WebElement> SuppliedDocs = web.findElements(SuppDocSelector);
            for (WebElement SuppliedDoc : SuppliedDocs)
            {  if (SuppliedDoc.getText().contains(fileName))
                    return;
            }
            Common.sleep(waitforSupportingDocumentsTraffic / 4);
            web.navigate().refresh();
        } while (System.currentTimeMillis() - start < waitforSupportingDocumentsTraffic);
    }

    public void selectDeliveryStatus(String deliveryStatus, String clockNumber, String serviceName, Map<String, String> row) {
        DubbingService additionalService = getDubbingService(clockNumber, serviceName);
        Common.sleep(2000);
        additionalService.getDeliveryStatusDropdown().click();
        Common.sleep(2000);
        List<WebElement> elem = web.findElements(By.cssSelector("[ng-repeat=\"status in $additionalServicesCtrl.getAvailableStatuses(service.status)\"]"));
        for (WebElement el : elem) {
            if (el.getText().equalsIgnoreCase(deliveryStatus)) {
                el.click();
                AdditionalServiceDeliveryStatusPopup additionalServiceDeliveryStatusPopup = new AdditionalServiceDeliveryStatusPopup(this);
                additionalServiceDeliveryStatusPopup.fillDate(row.get("date"));
                additionalServiceDeliveryStatusPopup.fillHour(row.get("hh"));
                additionalServiceDeliveryStatusPopup.fillMinute(row.get("mm"));
                additionalServiceDeliveryStatusPopup.clickSaveButton();
                break;
            }
        }
    }
}
