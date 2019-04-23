package com.adstream.automate.babylon.sut.pages.traffic.tableList;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.concurrent.TimeUnit;

/**
 * Created by denysb on 03/12/2015.
 */
public class TrafficOrderNestedList extends TrafficOrderList{

    private static final By orderItemRowsSelector = By.cssSelector("tr[ ng-repeat-start=\"clock in $tvClocksListCtrl.clocks track by clock._id\"]");
    private static final By orderItemCellsSelector = By.xpath(".//td[contains(@ng-repeat,'definition in $tvClocksListCtrl.schema')]");
    private static final By tableRowSelector  = By.cssSelector("tr");
    private static final By selector = By.cssSelector("[ng-click^='$toggleSelectCtrl.toggleSelect']");
    private static final By orderItemStatusSelector = By.cssSelector("a[id^='order_item_link']");
    private static final By titleSelector = By.cssSelector("span[ng-switch='$formattedSchemaValueCtrl.schema.type'] :first-child");
    private static final By clockOnHoldSelector = By.cssSelector("span[bo-if='!$first']");
    private static final By orderItemColumnTitleSelector = By.xpath(".//th[contains(@ng-repeat,'definition in $tvClocksListCtrl.schema//p')]");
    private static final By orderItemColumnTitleTextSelector = By.cssSelector("p");
    private static final By expandItemSelector = By.cssSelector(".icon-Add");
    private static final By currentNodeSelector = By.cssSelector(".table-head-inner");
    private static final By editOrderItemSelector = By.cssSelector("[href^='/ordering#orders/']");
    private static final By orderItemLinkToOpedItemDetails = By.cssSelector("a[href*='#/details/order-item/']");
    protected final static Logger log = Logger.getLogger(TrafficOrderNestedList.class);

    public TrafficOrderNestedList(ExtendedWebDriver web) {
        super(web);
    }

    public class TrafficOrderItem {
        private WebElement currentNode;
        private WebElement tableRow;
        private ExtendedWebDriver web;
        private String orderItemStatus;
        private String agency;
        private String market;
        private String title;
        private String clockNumber;
        private String additionalDetails;
        private String duration;
        private String firstAirDate;
        private String format;
        private String aspectRatio;
        private String mediaAgency;
        private String creativeAgency;
        private String postHouse;
        private String masterReceivedDate;
        private String masterReceivedComment;
        private String tapeNumber;
        private String campaign;
        private String advertiser;
        private String product;
        private String adDurationInFrames;
        private String adDurationInTime;
        private String clockServiceLevel;
        private String clockHoldOn;
        private String ingestedDate;
        private String adsDelivered;
        private String cloned;
        private WebElement expand;
        private WebElement orderItemLink;
        private WebElement editButton;
        private WebElement select;

        public WebElement getSelect() { return select;  }

        public void setSelect(WebElement select) { this.select = select;  }

        public WebElement getCurrentNode() {
            return currentNode;
        }

        public WebElement getTableRow() {
            return tableRow;
        }

        public ExtendedWebDriver getWeb() {
            return web;
        }

        public String getOrderItemStatus() {
            return orderItemStatus;
        }

        public String getAgency() {
            return agency;
        }

        public String getMarket() {
            return market;
        }

        public String getTitle() {
            return title;
        }

        public String getClockNumber() {
            return clockNumber;
        }

        public String getAdditionalDetails() {
            return additionalDetails;
        }

        public String getDuration() {
            return duration;
        }

        public String getFirstAirDate() {
            return firstAirDate;
        }

        public String getFormat() {
            return format;
        }

        public String getAspectRatio() {
            return aspectRatio;
        }

        public String getMediaAgency() {
            return mediaAgency;
        }

        public String getCreativeAgency() {
            return creativeAgency;
        }

        public String getPostHouse() {
            return postHouse;
        }

        public String getMasterReceivedDate() {
            return masterReceivedDate;
        }

        public String getMasterReceivedComment() {
            return masterReceivedComment;
        }

        public String getTapeNumber() {
            return tapeNumber;
        }

        public String getCampaign() {
            return campaign;
        }

        public String getAdsDelivered() {
            return adsDelivered;
        }

        public String getCloned() {
            return cloned;
        }

        public String getAdvertiser() {
            return advertiser;
        }

        public String getProduct() {
            return product;
        }

        public String getAdDurationInFrames() {
            return adDurationInFrames;
        }

        public String getAdDurationInTime() {
            return adDurationInTime;
        }

        public String getClockServiceLevel() {
            return clockServiceLevel;
        }

        public String getClockHoldOn() {
            return clockHoldOn;
        }

        public String getIngestedDate() {
            return ingestedDate;
        }

        public void getExpand() {
            web.getJavascriptExecutor().executeScript("arguments[0].click();", expand);
            Common.sleep(1000);
        }

        public boolean isOrderExpanded() {
            return web.isElementVisible(By.cssSelector(".icon-minus"));
        }

        public WebElement getOrderItemLink() {
            return orderItemLink;
        }

        public WebElement getEditButton() {
            return editButton;
        }

        public TrafficOrderItem(ExtendedWebDriver driver,WebElement row,int count){
            web = driver;
            currentNode = row;
            tableRow = row;
            select=currentNode.findElement(selector);
            List <WebElement> cellsList = currentNode.findElements(orderItemCellsSelector);
            initOrderItems(cellsList,count);
        }

        public void selectOrder(){
            if(!getSelect().isSelected())
                getSelect().click();
        }

        public void deselectOrder(){
            if(getSelect().isSelected())
                getSelect().click();
        }


        private void initOrderItems(List <WebElement> cells,int count) {
            List<String> list = getTrafficOrderItemColumnTitlesNames(count);
            //   editButton = tableRow.findElement(editOrderItemSelector);
            orderItemLink = tableRow.findElement(orderItemLinkToOpedItemDetails);
            web.manage().timeouts().implicitlyWait(0, TimeUnit.SECONDS );
            if(tableRow.findElements(expandItemSelector).size()>0)
                expand = tableRow.findElement(expandItemSelector);
            for (int i = 0; i < list.size(); i++) {
                String value = "";
                if(cells.get(i).findElements(titleSelector).size()>0){
                    value = cells.get(i).findElement(titleSelector).getText();
                }else if (cells.get(i).findElements(clockOnHoldSelector).size()>0){
                    value = cells.get(i).findElement(clockOnHoldSelector).getText();
                }
                switch (list.get(i)) {
                    case "Order Item Status":
                        value = cells.get(i).findElement(titleSelector).getText();
                        orderItemStatus = value;
                        break;
                    case "Agency":
                        agency = value;
                        break;
                    case "Market":
                        market = value;
                        break;
                    case "Title":
                        title = value;
                        break;
                    case "Clock Number":
                        clockNumber = value;
                        break;
                    case "Additional Details":
                        additionalDetails = value;
                        break;
                    case "Duration":
                        duration = value;
                        break;
                    case "First Air Date":
                        firstAirDate = value;
                        break;
                    case "Format":
                        format = cells.get(i).findElement(By.xpath("//span[@ng-switch-when='assetDefinition']/format-icon/i")).getAttribute("uib-tooltip");
                        break;
                    case "Aspect ratio":
                        aspectRatio = value;
                        break;
                    case "Media Agency":
                        mediaAgency = value;
                        break;
                    case "Creative Agency":
                        creativeAgency = value;
                        break;
                    case "Posthouse":
                        postHouse = value;
                        break;
                    case "Master Received Date":
                        masterReceivedDate = value;
                        break;
                    case "Master Received Comment":
                        masterReceivedComment = value;
                        break;
                    case "Tape Number":
                        tapeNumber = value;
                        break;
                    case "Campaign":
                        campaign = value;
                        break;
                    case "Advertiser":
                        advertiser = value;
                        break;
                    case "Product":
                        product = value;
                        break;
                    case "Brand":
                        break;
                    case "Sub Brand":
                        break;
                    case "Ad Duration In Frames":
                        adDurationInFrames = value;
                        break;
                    case "Ad Duration In Time":
                        adDurationInTime = value;
                        break;
                    case "Subtitles Required":
                        break;
                    case "Manual QC State":
                        break;
                    case "Service Level Minutes":
                        clockServiceLevel = value;
                        break;
                    case "Clock On Hold":
                        clockHoldOn = value;
                        break;
                    case "Ingested Date":
                        ingestedDate = value;
                        break;
                    case "Ads Delivered":
                        adsDelivered = cells.get(i).getText();
                        break;
                    case "Cloned":
                        cloned = cells.get(i).getText();
                        break;

                }
            }
            web.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS );
        }

        public List<WebElement> getTrafficOrderItemColumnTitleElements(int count){
            List <WebElement> list;
            try {
                list = web.findElements(By.tagName("tv-clocks-list")).get(count).findElements(By.xpath(".//tr[contains(@class,'table-row')]")).get(0).findElements(By.xpath(".//th[contains(@ng-repeat,'definition in $tvClocksListCtrl.schema')]//p"));
            }
            catch (Exception e) {
                list = web.findElements(By.xpath(".//th[contains(@ng-repeat,'definition in $tvClocksListCtrl.schema')]//p"));
            }
            return list;
        }

        public  List<String> getTrafficOrderItemColumnTitlesNames(int count){
            List <WebElement> list = getTrafficOrderItemColumnTitleElements(count);
            List <String> listOfTitles = new ArrayList<>();
            for (WebElement element: list) {
                listOfTitles.add(element.getText());
            }
            return listOfTitles;
        }
    }

    //Slow method cause need to parse all orders before parcing order Item, so use it only in specific cases
    public List<TrafficOrderItem> getOrderItemByOrderReference(String orderReference){
        TrafficOrder order = getOrderByOrderReference(orderReference);
        List <TrafficOrderItem> trafficOrderItems = new ArrayList();
        order.getExpander();
        List <WebElement> rowList = order.getCurrentNode().findElements(orderItemRowsSelector);
        int count=-1;
        for (WebElement element : rowList) {
            trafficOrderItems.add(new TrafficOrderItem(web,element,++count));
        }
        return trafficOrderItems;
    }

    public List<TrafficOrderItem> getOrderItems(){
        List <TrafficOrderItem> trafficOrderItems = new ArrayList();
        List <WebElement> elements = web.findElements(orderItemRowsSelector);
        int count=-1;
        for (WebElement webElement : elements) {
            trafficOrderItems.add(new TrafficOrderItem(web,webElement,++count));
        }
        return trafficOrderItems;
    }


    public TrafficOrderItem  getTrafficOrderItemByClockNumber(String clockNumber){
        TrafficOrderItem orderItem;
        List <WebElement> elements = web.findElements(orderItemRowsSelector);
        Common.sleep(4000);
        int count=-1;
        for (WebElement webElement : elements) {
            orderItem = new TrafficOrderItem(web,webElement,++count);
            Common.sleep(3000);
            if(orderItem.getClockNumber().equals(clockNumber)) {
               return orderItem;
            }
        }
        throw new NullPointerException("OrderItem with clockNumber " + clockNumber + " was not found");
    }

    public List<TrafficOrderItem> getTrafficOrderItemsByClockNumber(String clockNumber){
        List <TrafficOrderItem> allOrderItems;
        allOrderItems = getOrderItems();
        List <TrafficOrderItem> orderItems = new ArrayList<>();
        for (TrafficOrderItem trafficOrderItem : allOrderItems) {
            if(trafficOrderItem.clockNumber.equalsIgnoreCase(clockNumber)){
                orderItems.add(trafficOrderItem);
            }
        }
        return orderItems;
    }



    public TrafficDestinationList getTrafficDestinationList(){
        if(!web.isElementPresent(By.cssSelector("[class='table-body tv-destinations']"))){
            throw new NoSuchElementException("Traffic Destination list is not present on the page, check maybe you forgot to expand list!");
        }
        return new TrafficDestinationList(web);
    }


}
