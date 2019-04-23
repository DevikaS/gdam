package com.adstream.automate.babylon.sut.pages.traffic.tableList;

import com.adstream.automate.babylon.sut.pages.traffic.element.Comment;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.InvalidSelectorException;
import org.openqa.selenium.WebDriverException;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.concurrent.TimeUnit;

/**
 * Created by denysb on 02/12/2015.
 */
public class TrafficOrderList extends AbstractTrafficList {

    private static final By cellsSelector  = By.cssSelector("[ng-repeat^='definition in $tvOrdersListCtrl.schema']");
    private static final By ordersRowsSelector = By.cssSelector("[ng-repeat-start^='order in $tvOrdersListCtrl.orders']");
    private static final By tableRowSelector  = By.cssSelector("tr");
    private static final By titleSelector = By.cssSelector("span[ng-switch='$formattedSchemaValueCtrl.schema.type'] :first-child");
    private static final By editPencilSelector = By.cssSelector(".icon-pencil");
    private static final By orderReferenceLinkSelector = By.cssSelector("a");
    private static final By orderReferenceSelector = By.cssSelector("td[name-row='orderReference']");
    private static final By expanderSelector = By.cssSelector("[ng-click=\"$toggleExpandCtrl.toggleExpand(!$toggleExpandCtrl.isExpanded())\"]");
  //  private static final By columnTitlesSelector = By.cssSelector(".clickable_table_header");
    private static final By selector = By.cssSelector("[ng-click^='$toggleSelectCtrl.toggleSelect']");
    private static final By addComment = By.cssSelector("[ng-click='comment()']");
    private static final String CONFIGURE_ORDER ="Configure Order Table";
    private static final String CONFIGURE_ITEM ="Configure Order Item";
    private static final String DOWNLOAD_CSV ="Download CSV";
    private static final By columnTitlesSelector = By.cssSelector("th[ng-repeat^='definition in $tvOrdersListCtrl.schema'] p");
    public TrafficOrderList(ExtendedWebDriver web) {
        super(web);
    }



    public class TrafficOrder {
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
        private String lastComment;
        private String ingestedAds;
        private WebElement select;
        private String orderItemStatus;
        private String cloned;
        private String format;


        public String getOrderItemStatus() {
            return orderItemStatus;
        }

        public void setOrderItemStatus(String orderItemStatus) {
            orderItemStatus = orderItemStatus;
        }

        public String getLastComment() { return lastComment; }

        public void setLastComment(String lastComment) { this.lastComment = lastComment;   }

        public WebElement getSelect() {
            return select;
        }

        public void setSelect(WebElement select) {
            this.select = select;
        }

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

        public String getIngestedAds() {
            return ingestedAds;
        }

        public void setIngestedAds(String ingestedAds) {
            this.ingestedAds = ingestedAds;
        }

        public String getCloned() {
            return cloned;
        }

        public void setCloned(String cloned) {
            this.cloned = cloned;
        }

        public String getFormat() {
            return format;
        }

        public void setFormat(String format) {
            this.format = format;
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

        public WebElement getSubtitlesRequired() {
            return subtitlesRequired;
        }

        public void setSubtitlesRequired(WebElement subtitlesRequired) {
            this.subtitlesRequired = subtitlesRequired;
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

        public void getExpander() {
            web.getJavascriptExecutor().executeScript("arguments[0].click();", expander);
            Common.sleep(1000);
        }

        public void setExpander(WebElement expander) {
            this.expander = expander;
        }

        public WebElement getEditPencil() {
            return editPencil;
        }

        public void setEditPencil(WebElement editPencil) {
            this.editPencil = editPencil;
        }

        private String tapeNumber;
        private WebElement subtitlesRequired;
        private String trafficAssignedTo;
        private WebElement orderReferenceLink;
        private WebElement expander;
        private WebElement editPencil;
        private WebElement subTitle;

        public TrafficOrder(ExtendedWebDriver driver, WebElement row){
            this.web = driver;
            currentNode = row;
            tableRow = row;
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

        public boolean closedCaptionCheck(){
            boolean found=false;
            WebElement subTitles=this.getSubtitlesRequired();
            boolean elementVisible=false;
            try{
                if(this.getSubtitlesRequired()!=null){
                    elementVisible=subTitles.findElement(By.cssSelector("[ng-if='$formattedSchemaValueCtrl.value === true']")).isDisplayed();
                }}
            catch (WebDriverException e) {
                elementVisible = false;
            }
            return elementVisible;
        }

        // Gets the value of a field/column for given clock (// TODO: 11/10/2016 : Implementation for other fields
        //Can be replaced by getFieldValuemew --but keeping for safety for sometime
//        public String getFieldValue(String fieldName){
//            String elementLocator;
//
//            if (fieldName.equals("Order Item Status"))
//                elementLocator = "orderItemIngestStatus";
//            else if (fieldName.equals("Order Status"))
//                elementLocator = "status";
//            else throw new NullPointerException("Check the field name: " + fieldName);
//
//            return  getDriver().findElement(By.xpath(".//*[@name-row=\""+elementLocator+"\"]//span")).getText();
//        }

        //based on Traffic object and not on selectors
        public String getFieldValue(String fieldName){
            if (fieldName.equals("Order Item Status"))
                return orderItemStatus;
            else if (fieldName.equals("Order Status"))
                return orderStatus;
            else if (fieldName.equals("Job Number"))
                return jobNumber;
            else if (fieldName.equals("PO Number"))
                return poNumber;
            else throw new NullPointerException("Check the field name: " + fieldName);
        }

        private void initFields(List <WebElement> cells){
            orderReferenceLink = tableRow.findElement(orderReferenceLinkSelector);
           // editPencil = tableRow.findElement(editPencilSelector);
            expander = tableRow.findElement(expanderSelector);
            select=tableRow.findElement(selector);
            List <String> list = getColumnTitlesNames(columnTitlesSelector);
            web.manage().timeouts().implicitlyWait(0,TimeUnit.SECONDS);
            for (int i=0; i<list.size();i++){
                String cellValue = "";
                if(cells.get(i).findElements(titleSelector).size()!=0){
                    cellValue = cells.get(i).findElement(titleSelector).getText();
                }else if(cells.get(i).findElements(orderReferenceLinkSelector).size()!=0) {
                    cellValue = cells.get(i).findElement(orderReferenceLinkSelector).getText();
                }else if(cells.get(i).findElements(By.cssSelector("[class^='color']")).size()!=0) {
                    cellValue = cells.get(i).findElement(By.cssSelector("[class^='color']")).getText();
                }
                switch (list.get(i)){
                    case "Reference":
                        orderReference = cellValue;
                        break;
                    case "Ingest Location":
                        ingestLocation = cellValue;
                        break;
                    case "Job Number":
                        jobNumber = cellValue;
                        break;
                    case "PO Number":
                        poNumber = cellValue;
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
                    case "Subtitles Required":
                        subtitlesRequired = cells.get(i).findElement(columnSubtitleSelector);
                        break;
                    case "Traffic assigned to":
                        trafficAssignedTo = cellValue;
                        break;
                    case "Last Comment" :
                        lastComment=cellValue;
                        break;
                    case "Order Item Status":
                        orderItemStatus=cellValue;
                        break;
                    case "Ingested Ads":
                        ingestedAds=cells.get(i).getText();
                        break;
                    case "Cloned":
                        cloned=cells.get(i).getText();
                        break;
                    case "Format":
                      format = cells.get(i).findElement(By.xpath("//span[@ng-switch-when='format']/format-icon/i")).getAttribute("uib-tooltip");

                        break;
                }

            }
            web.manage().timeouts().implicitlyWait(30,TimeUnit.SECONDS);
        }


        public void addComment(String data){
            web.findElement(addComment).click();
        }


    }

    public TrafficOrder getOrderByOrderReference(String orderReference){
        if (!web.isElementPresent(ordersRowsSelector)) return null;
        List<WebElement> rows = web.findElements(ordersRowsSelector);
        Common.sleep(2000);
        TrafficOrder order;
        for (WebElement row : rows) {
      //      String actualOrderReference = row.findElement(orderReferenceSelector).getText();
        //    if(actualOrderReference.equalsIgnoreCase(orderReference)) {
            order = new TrafficOrder(web, row);
            Common.sleep(2000);
            if(order.getOrderReference().equalsIgnoreCase(orderReference))
                return order;
       //     }
       }
        throw new NullPointerException("Order with " + orderReference + " is absent");
    }

    public TrafficOrderNestedList getTrafficOrderNestedList(){
        if(web.isElementVisible(By.cssSelector("[ng-switch-when='TvClock']"))){
            return new TrafficOrderNestedList(web);
        }
        if(!web.isElementVisible(By.tagName("tv-clocks-list"))||!web.isElementPresent(By.tagName("tv-clocks-list"))){
            throw new NoSuchElementException("Traffic Order Nested list is not present on the page!");
        }
        return new TrafficOrderNestedList(web);
    }

    public String getAddNewTabTitle(){
        return web.findElement(By.id("addTabButton")).getAttribute("uib-tooltib");
    }

    public String getConfigureOrderTitle(String title) {
        int position = title.equals(CONFIGURE_ORDER)?1:title.equals(CONFIGURE_ITEM)?2:title.equals(DOWNLOAD_CSV)?3:0;
        return web.findElement(By.xpath(String.format(".//*[@id='view-container']//configure-schema[%s]",position))).getAttribute("uib-tooltib");
    }

    public String getReorderTabTitle() {
        return web.findElement(By.id("reorderTabButton")).getAttribute("uib-tooltib");
    }

    public String getAllTabTitle(){
        return web.findElement(By.xpath("addTabButton")).getAttribute("uib-tooltib");
    }

    public List<TrafficOrder> getOrders(){
        List <TrafficOrder> trafficOrderItems = new ArrayList();
        List <WebElement> elements = web.findElements(ordersRowsSelector);
        for (WebElement webElement : elements) {
            trafficOrderItems.add(new TrafficOrder(web,webElement));
        }
        return trafficOrderItems;
    }

    public List<String> getfieldValues(String fieldName){
        int intCellToFind = 0;
        List<String> fieldValues = new ArrayList<String>();
        WebElement table = web.findElement(By.tagName("table"));
        List<WebElement> tableHeaders = table.findElements(By.tagName("th"));
        WebElement tableBody = table.findElement(By.tagName("tbody"));
        List<WebElement> rows = tableBody.findElements(By.tagName("tr"));
        for(int t =0;t<tableHeaders.size()-1;t++){
            if(tableHeaders.get(t).getText().equals(fieldName)){
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



}
