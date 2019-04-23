package com.adstream.automate.babylon.sut.pages.traffic.tableList;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.InvalidSelectorException;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * Created by denysb on 22/03/2016.
 */
public class TrafficOrderItemSendList extends AbstractTrafficList {

    private final static By tableHeaderSelector = By.cssSelector(".table-head");
    private final static By orderItemSendRowSelector = By.cssSelector("[ng-repeat^='destination in $tvDestinationsListCtrl.destinations']");
    private final static By orderItemSendColumnsSelector = By.cssSelector(".table-cell");
    private static final By cellsSelector  = By.cssSelector("[ng-repeat^='definition in $tvDestinationsListCtrl']");
    private static final By orderItemLinkSelector = By.cssSelector(("[ui-sref^=\"main.details.order-item\"]"));
    private static final By ordersRowsSelector = By.cssSelector("[ng-repeat^='order in orders']");
    // private static final By clockRowsSelector = By.cssSelector("[ng-repeat^='schemaItem in schema']");
    // private static final By tableRowSelector  = By.cssSelector("tr");
    private static final By titleSelector = By.cssSelector("span[ng-switch='$formattedSchemaValueCtrl.schema.type'] :first-child");
    private static final By houseNumberSelector = By.cssSelector("span[ng-if='::!$houseNumberWrapperCtrl.enableEditing()']");
    private static final By orderReferenceLinkSelector = By.cssSelector("a[href^=\"#/details/order-item\"]");
    private static final By clockReferenceSelector = By.cssSelector("td[name-row='clockNumber']");
    private static final By columnTitlesSelector = By.cssSelector("th[ng-repeat^='definition in $tvDestinationsListCtrl.schema'] p");
    private static final By selector = By.cssSelector("[ng-click^='$toggleSelectCtrl.toggleSelect']");
    private static final By addComment = By.cssSelector("[ng-click='comment()']");
    private static final By arrivalDateSelector =  By.cssSelector("[ng-switch-when='datetime']");



    public TrafficOrderItemSendList(ExtendedWebDriver web) {
        super(web);
    }


    private List<WebElement> getDestinationTableHeaderCells(WebElement node){
        return node.findElement(tableHeaderSelector).findElements(By.cssSelector("span"));
    }

    private List<String> getDestinationTableNames(WebElement currentNode){
        List<WebElement> cells = getDestinationTableHeaderCells(currentNode);
        List <String> tableNames = new ArrayList<>();
        for (WebElement element : cells) {
            tableNames.add(element.getText());
        }
        return tableNames;
    }


    public class TrafficOrderItemSend {
        private ExtendedWebDriver web;
        private WebElement tableRow;
        private WebElement currentNode;
        private String orderReference;
        private String ingestLocation;
        private String jobNumber;
        private String poNumber;
        private String onHold;
        private String orderStatus;
        private String agency;
        private String agencyCountry;
        private String submittedDate;
        private String market;
        private String marketCountry;
        private String serviceLevel;
        private String deliveryStatus;
        private String arrivalDate;
        private String title;
        private String advertiser;
        private String product;
        private String mediaAgency;
        private String houseNo;
        private String lastComment;

        public String getDestinationName() {
            return destinationName;
        }

        public void setDestinationName(String destinationName) {
            this.destinationName = destinationName;
        }

        private String destinationName;

        public void setTitle(String title) {
            this.title = title;
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

        public String getMediaAgency() {
            return mediaAgency;
        }

        public void setMediaAgency(String mediaAgency) {
            this.mediaAgency = mediaAgency;
        }

        public String getHouseNo() {
            return houseNo;
        }

        public String getTitle() {
            return title;
        }

        public void setHouseNo(String houseNo) {
            this.houseNo = houseNo;
        }



        public String getLastComment() {
            return lastComment;
        }

        public void setLastComment(String lastComment) {
            this.lastComment = lastComment;
        }



        public String getClockNumber() {
            return clockNumber;
        }

        public void setClockNumber(String clockNumber) {
            this.clockNumber = clockNumber;
        }

        private String clockNumber;

        public String getArrivalDate() { return arrivalDate; }

        public void setArrivalDate(String arrivalDate) { this.arrivalDate = arrivalDate;   }

        public String getDeliveryStatus() { return deliveryStatus; }

        public void setDeliveryStatus(String deliveryStatus) {this.deliveryStatus = deliveryStatus; }

        public WebElement getSelect() {
            return select;
        }

        public void setSelect(WebElement select) {
            this.select = select;
        }

        private WebElement select;

        public WebElement getOrderItemLink() {
            return orderReferenceLink;
        }

        private WebElement orderItemLink;

        public WebElement getTableRow() {
            return tableRow;
        }

        public void setTableRow(WebElement tableRow) {
            this.tableRow = tableRow;
        }

        public WebElement getCurrentNode() {
            return currentNode;
        }

        public void setCurrentNode(WebElement currentNode) {
            this.currentNode = currentNode;
        }

        public String getOrderReference() {
            return orderReference;
        }

        public void setOrderReference(String orderReference) {
            this.orderReference = orderReference;
        }

        public String getIngestLocation() {
            return ingestLocation;
        }

        public void setIngestLocation(String ingestLocation) {
            this.ingestLocation = ingestLocation;
        }

        public String getJobNumber() {
            return jobNumber;
        }

        public void setJobNumber(String jobNumber) {
            this.jobNumber = jobNumber;
        }

        public String getPoNumber() {
            return poNumber;
        }

        public void setPoNumber(String poNumber) {
            this.poNumber = poNumber;
        }

        public String getOnHold() {
            return onHold;
        }

        public void setOnHold(String onHold) {
            this.onHold = onHold;
        }

        public String getOrderStatus() {
            return orderStatus;
        }

        public void setOrderStatus(String orderStatus) {
            this.orderStatus = orderStatus;
        }

        public String getAgency() {
            return agency;
        }

        public void setAgency(String agency) {
            this.agency = agency;
        }

        public String getAgencyCountry() {
            return agencyCountry;
        }

        public void setAgencyCountry(String agencyCountry) {
            this.agencyCountry = agencyCountry;
        }

        public String getSubmittedDate() {
            return submittedDate;
        }

        public void setSubmittedDate(String submittedDate) {
            this.submittedDate = submittedDate;
        }

        public String getMarket() {
            return market;
        }

        public void setMarket(String market) {
            this.market = market;
        }

        public String getMarketCountry() {
            return marketCountry;
        }

        public void setMarketCountry(String marketCountry) {
            this.marketCountry = marketCountry;
        }

        public String getServiceLevel() {
            return serviceLevel;
        }

        public void setServiceLevel(String serviceLevel) {
            this.serviceLevel = serviceLevel;
        }

        public String getTapeNumber() {
            return tapeNumber;
        }

        public void setTapeNumber(String tapeNumber) {
            this.tapeNumber = tapeNumber;
        }

        public String getTrafficAssignedTo() {
            return trafficAssignedTo;
        }

        public void setTrafficAssignedTo(String trafficAssignedTo) {
            this.trafficAssignedTo = trafficAssignedTo;
        }

        public WebElement getOrderReferenceLink() {
            return orderReferenceLink;
        }

        public void setOrderReferenceLink(WebElement orderReferenceLink) {
            this.orderReferenceLink = orderReferenceLink;
        }


        private String tapeNumber;
        private String trafficAssignedTo;
        private WebElement orderReferenceLink;

        public TrafficOrderItemSend(ExtendedWebDriver driver, WebElement row){
            this.web = driver;
            currentNode = row;
            //     tableRow = row.findElement(tableRowSelector);
            select=row.findElement(selector);
            List<WebElement> cells = currentNode.findElements(cellsSelector);
            if (cells.size()==0){
                throw new InvalidSelectorException("Selector " + cellsSelector + " is absent");
            }
            initFields(cells);

        }

        public void selectOrder(){
            if(!getSelect().isSelected())
                getSelect().click();
        }

        public void deselectOrder(){
            if(getSelect().isSelected())
                getSelect().click();
        }

        private void initFields(List <WebElement> cells){
            orderReferenceLink = currentNode.findElement(orderReferenceLinkSelector);
            List <String> list = getColumnTitlesNames(columnTitlesSelector);
            web.manage().timeouts().implicitlyWait(0, TimeUnit.SECONDS);
            for (int i=0; i<list.size();i++){
                String cellValue = "";
                if(cells.get(i).findElements(titleSelector).size()!=0){
                    cellValue = cells.get(i).findElement(titleSelector).getText();
                }else if(cells.get(i).findElements(orderReferenceLinkSelector).size()!=0) {
                    cellValue = cells.get(i).findElement(orderReferenceLinkSelector).getText();
                }else if(cells.get(i).findElements(By.cssSelector("[class^='color']")).size()!=0) {
                    cellValue = cells.get(i).findElement(By.cssSelector("[class^='color']")).getText();
                }else if(cells.get(i).findElements(houseNumberSelector).size()!=0){
                    cellValue = cells.get(i).findElement(houseNumberSelector).getText();
                }
                switch (list.get(i)){
                    case "Arrival Date" :
                        arrivalDate=cells.get(i).findElement(arrivalDateSelector).getAttribute("tooltip");
                        break;
                    case "House Number":
                        houseNo = cellValue;
                        break;
                    case "Title":
                        title = cellValue;
                        break;
                    case "Advertiser":
                        advertiser = cellValue;
                        break;
                    case "Product":
                        product = cellValue;
                        break;
                    case "Media Agency":
                        mediaAgency = cellValue;
                        break;
                    case "Reference":
                        orderReference = cellValue;
                        break;
                    case "Ingest Location":
                        ingestLocation = cellValue;
                        break;
                    case "Job Number":
                        jobNumber = cellValue;
                        break;
                    case "Last Comment":
                        lastComment = cellValue;
                        break;
                    case "PO Number":
                        poNumber = cellValue;
                        break;
                    case "Clock Number":
                        clockNumber = cellValue;
                        break;
                    case "On Hold":
                        onHold = cellValue;
                        break;
                    case "Order Status":
                        orderStatus = cellValue;
                        break;
                    case "Agency":
                        agency = cellValue;
                        break;
                    case "Agency Country":
                        agencyCountry = cellValue;
                        break;
                    case "Submitted Date":
                        submittedDate = cellValue;
                        break;
                    case "Market":
                        market = cellValue;
                        break;
                    case "Market Country":
                        marketCountry = cellValue;
                        break;
                    case "Service Level":
                        serviceLevel = cellValue;
                        break;
                    case "Tape numbers":
                        tapeNumber = cellValue;
                        break;
                    case "Traffic assigned to":
                        trafficAssignedTo = cellValue;
                        break;
                    case "Delivery Status":
                        deliveryStatus = cellValue;
                        break;
                    case "Destination name":
                        destinationName=cellValue;
                        break;
                }

            }
            web.manage().timeouts().implicitlyWait(30,TimeUnit.SECONDS);
        }


        public void addComment(String data){
            web.findElement(addComment).click();
        }
    }


    public List<TrafficOrderItemSend> getOrderByClockNumber(String orderReference){
        if (!web.isElementPresent(orderItemSendRowSelector)) return null;
        List<TrafficOrderItemSend> clockList = new ArrayList<TrafficOrderItemSend>();
        List<WebElement> rows = web.findElements(orderItemSendRowSelector);
        TrafficOrderItemSend orderItem;
        for (WebElement row : rows) {
            //   String actualOrderReference = row.findElement(clockReferenceSelector).getText();
            //   if(actualOrderReference.equalsIgnoreCase(orderReference)) {
            orderItem = new TrafficOrderItemSend(web, row);
            if(orderItem.getClockNumber().equalsIgnoreCase(orderReference))
                clockList.add(orderItem);
            //  }
        }

        return clockList;
    }

    public List<TrafficOrderItemSend> getOrderByTitle(String title){
        if (!web.isElementPresent(orderItemSendRowSelector)) return null;
        List<TrafficOrderItemSend> clockList = new ArrayList<TrafficOrderItemSend>();
        List<WebElement> rows = web.findElements(orderItemSendRowSelector);
        TrafficOrderItemSend orderItem;
        for (WebElement row : rows) {
            orderItem = new TrafficOrderItemSend(web, row);
            if(orderItem.getTitle().equalsIgnoreCase(title))
                clockList.add(orderItem);
        }

        return clockList;
    }

    public List<TrafficOrderItemSend> getOrderSendItems(){
        List <TrafficOrderItemSend> trafficOrderItems = new ArrayList();
        List <WebElement> elements = web.findElements(orderItemSendRowSelector);
        for (WebElement webElement : elements) {
            trafficOrderItems.add(new TrafficOrderItemSend(web,webElement));
        }
        return trafficOrderItems;
    }

}
