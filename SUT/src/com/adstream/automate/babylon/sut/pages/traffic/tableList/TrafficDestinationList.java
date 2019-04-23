package com.adstream.automate.babylon.sut.pages.traffic.tableList;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by denysb on 07/12/2015.
 */
public class TrafficDestinationList extends AbstractTrafficList{

    private final static By destinationsTitleSelector = By.cssSelector("td[class='table-head static-destination'],td[class='table-head']");
    private final static By destinationsRowSelector = By.cssSelector("[ng-repeat^='destination in clock.getDestinations()']");
    private final static By additionalServicesRowSelector = By.xpath("//table[@class=\"table-head-inner\"]");
    private final static By destinationsColumnsSelector = By.xpath("//tr[@class=\"destination-table-row\"]/td");
    private final static By editIconSelector = By.cssSelector("[ng-if=\"!$houseNumberEditDefaultCtrl.isEditing\"] i[ng-click=\"$houseNumberEditDefaultCtrl.openEditForm()\"]");
   // private final static By destinationsColumnsSelector = By.cssSelector("[item='destination']");
   // private final static By serviceLevelTextColorStandard = By.xpath("//td[@ng-if='isTrafficManager']/span[@status='Standard']");
   // private final static By serviceLevelTextColorExpress = By.xpath("//td[@ng-if='isTrafficManager']/span[@status='Express']");

    public TrafficDestinationList(ExtendedWebDriver web) {
        super(web);
    }

    public class TrafficDestination{
        private ExtendedWebDriver web;
        private String destinationName;
        private WebElement currentNode;
        private WebElement houseNumber;
        private String deliveryStatus;
        private String broadcasterStatus;
        private String arrivalDate;
        private String destinationType;
        private String serviceLevel;
        private WebElement serviceLevelElement;
        private String onHold;
        private String format;
        private String lastComment;

        public ExtendedWebDriver getWeb() {
            return web;
        }

        public String getDestinationName() {
            return destinationName;
        }

        public WebElement getCurrentNode() {
            return currentNode;
        }

        public WebElement getHouseNumber() {
            return houseNumber;
        }

        public String getDeliveryStatus() {
            return deliveryStatus;
        }

        public String getBroadcasterStatus() {
            return broadcasterStatus;
        }

        public String getArrivalDate() {
            return arrivalDate;
        }

        public String getDestinationType() {
            return destinationType;
        }

        public String getServiceLevel() {
            return serviceLevel;
        }

        public String getOnHold() {
            return onHold;
        }

        public String getFormat() {
            return format;
        }

        public String getLastComment() {
            return lastComment;
        }

        public TrafficDestination(TrafficOrderNestedList.TrafficOrderItem orderItem, WebElement row, ExtendedWebDriver driver){
            web = driver;
            currentNode = row;
            List <WebElement> destinationColumns = currentNode.findElements(By.cssSelector("[item='destination'],[ng-if=\"destination.comments\"],[ng-if=\"!destination.comments\"]"));
            List <String> tableNames = getDestinationTableNames();
            for (int i = 0; i < tableNames.size() ; i++)
            { if(tableNames.get(i).isEmpty()) tableNames.remove(i);
            }
            initDestinationFields(tableNames, destinationColumns);
        }

        public void fillHouseNumberFieldWithValue(String value) {
       //     web.scrollToElement(houseNumber.findElement(houseNumberInputFieldSelector));
            web.click(editIconSelector);
            houseNumber.findElement(houseNumberInputFieldSelector).clear();
            Common.sleep(2000);
            houseNumber.findElement(houseNumberInputFieldSelector).sendKeys(value);
            Common.sleep(2000);
            // houseNumber.findElement(By.cssSelector(".btn.btn-info.btn-sm.ng-scope")).click();
            houseNumber.findElement(By.xpath("//i[contains(@ng-click,'$houseNumberEditDefaultCtrl.form.$valid && $houseNumberEditDefaultCtrl.updateHouseNumber()')]")).click();
           // houseNumber.click();//sorry for stupid workaround for HN saving
            waitUntilPageWillBeLoaded(3000);
        }

        public void fillHouseNumber(String value) {
            if(value.equalsIgnoreCase("NCS")||value.equalsIgnoreCase("CS")||value.equalsIgnoreCase("ECS")){
                houseNumber.findElement(houseNumberMenaPencilIconSelector).click();
                waitUntilPageWillBeLoaded(3000);
                List<WebElement> list = houseNumber.findElements(labelCode);
                for(WebElement li:list){
                    if(li.getText().equalsIgnoreCase(value)){
                        li.click();
                        break;
                    }}
            }else {
                web.click(By.xpath("*//i[@ng-click=\"$houseNumberEditDefaultCtrl.openEditForm()\"]"));
                houseNumber.findElement(houseNumberInputFieldSelector).sendKeys(value);
               // houseNumber.findElement(By.cssSelector(".btn.btn-info.btn-sm.ng-scope")).click();
                web.findElement(By.xpath("//i[contains(@ng-click,'$houseNumberEditDefaultCtrl.form.$valid && $houseNumberEditDefaultCtrl.updateHouseNumber()')]")).click();
                waitUntilPageWillBeLoaded(3000);
            }
        }

        public boolean isEditHouseNumberPencilPresent(){
            return web.isElementVisible(houseNumberMenaPencilIconSelector);
        }

        public String getHouseNumberValue(String houseNumberValues) {
            if(houseNumberValues.equalsIgnoreCase("NCS")||houseNumberValues.equalsIgnoreCase("ECS")||houseNumberValues.equalsIgnoreCase("CS")){
                return web.findElement(houseNumberMenaInputFieldSelector).getText();
            }else{
                return houseNumber.findElement(By.xpath("*//div[contains(@class,'house-number-view-wrapper')]/span")).getText();
            }
        }

        public String getHouseNumberSuffix(){
            return web.findElement(houseNumberSuffixlocator).getText();
        }

        public String getServiceLevelTextColor(String type)
        {
            String color = web.findElement(By.xpath(String.format("//td[@ng-if='isTrafficManager']/span[@status='%s']",type))).getAttribute("class");
            //String color = serviceLevelElement.findElement(By.xpath("//td[@ng-if='isTrafficManager']/span[@status='Express']")).getAttribute("class");

            return color;
        }


        public String getOnHoldStatus(String type)
        {
            String color = web.findElement(By.xpath(String.format("//td[@ng-if='isTrafficManager']/span[@status='%s']",type))).getAttribute("class");
            //String color = serviceLevelElement.findElement(By.xpath("//td[@ng-if='isTrafficManager']/span[@status='Express']")).getAttribute("class");

            return color;
        }

        private void initDestinationFields(List <String> tableNames, List <WebElement> destinationColumns){
            for (int i = 0; i < tableNames.size() ; i++) {
                switch (tableNames.get(i)){
                    case "DESTINATION":
                        destinationName = destinationColumns.get(i).getText();
                        break;
                    case "HOUSE NO.":
                        houseNumber = destinationColumns.get(i);
                        break;
                    case "DELIVERY STATUS":
                        deliveryStatus = destinationColumns.get(i).getText();
                        break;
                    case "BROADCASTER APPROVAL STATUS":
                        broadcasterStatus = destinationColumns.get(i).findElement(By.cssSelector("[class^='font-14 text']")).getText();
                        break;
                    case "ARRIVAL DATE":
                        arrivalDate = destinationColumns.get(i).getText();
                        break;
                    case "DESTINATION TYPE":
                        destinationType = destinationColumns.get(i).getText();
                        break;
                    case "SERVICE LEVEL":
                        serviceLevel = destinationColumns.get(i).getText();
                        serviceLevelElement = destinationColumns.get(i);
                        break;
                    case "ON HOLD":
                        onHold = destinationColumns.get(i).getText();
                        break;
                    case "FORMAT":
                        format = destinationColumns.get(i).findElement(By.xpath("//span[@ng-switch-when='destinationFormat']/format-icon/i")).getAttribute("uib-tooltip");
                        break;
                    case "LAST COMMENT":
                        lastComment = destinationColumns.get(i).getText();
                        break;

                }
            }
        }



    }

    public class AdditionalService{
        private ExtendedWebDriver web;
        private String destination;
        private String format;
        private String specification;
        private String noOfCopies;
        private String mediaCompile;
        private String notes;
        private String deliveryStatus;
        private String arrivalDate;
        private WebElement currentNode;

        public String getServiceLevel() {
            return serviceLevel;
        }

        public void setServiceLevel(String serviceLevel) {
            this.serviceLevel = serviceLevel;
        }

        private String serviceLevel;

        public String getDubbingService() {
            return dubbingService;
        }

        public void setDubbingService(String dubbingService) {
            this.dubbingService = dubbingService;
        }

        private String dubbingService;

        public String getDestination() {
            return destination;
        }

        public void setDestination(String destination) {
            destination = destination;
        }

        public String getFormat() {
            return format;
        }

        public void setFormat(String format) {
            this.format = format;
        }

        public String getSpecification() {
            return specification;
        }

        public void setSpecification(String specification) {
            this.specification = specification;
        }

        public String getNoOfCopies() {
            return noOfCopies;
        }

        public void setNoOfCopies(String noOfCopies) {
            this.noOfCopies = noOfCopies;
        }

        public String getMediaCompile() {
            return mediaCompile;
        }

        public void setMediaCompile(String mediaCompile) {
            this.mediaCompile = mediaCompile;
        }

        public String getNotes() {
            return notes;
        }

        public void setNotes(String notes) {
            this.notes = notes;
        }

        public String getDeliveryStatus() {
            return deliveryStatus;
        }

        public void setDeliveryStatus(String deliveryStatus) {
            this.deliveryStatus = deliveryStatus;
        }

        public String getArrivalDate() {
            return arrivalDate;
        }

        public void setArrivalDate(String arrivalDate) {
            this.arrivalDate = arrivalDate;
        }

        public WebElement getCurrentNode() {
            return currentNode;
        }

        public void setCurrentNode(WebElement currentNode) {
            this.currentNode = currentNode;
        }

        public AdditionalService(TrafficOrderNestedList.TrafficOrderItem orderItem, WebElement row, ExtendedWebDriver driver){
            web = driver;
            currentNode = row;
            List <WebElement> destinationColumns = currentNode.findElements(destinationsColumnsSelector);
            List <String> tableNames = getAdditionalServicesTableNames(currentNode);
            initAdditionalService(tableNames, destinationColumns);
        }

        private void initAdditionalService(List <String> tableNames, List <WebElement> destinationColumns){
            if (destinationColumns.get(0).getText().equals(""))
                destinationColumns.remove(0);
            for (int i = 0; i < tableNames.size() ; i++) {
                switch (tableNames.get(i)){
                    case "Dubbing Service":
                        dubbingService = destinationColumns.get(i).getText();
                        break;
                    case "Destination":
                        destination = destinationColumns.get(i).getText().split("\n")[0];
                        break;
                    case "Format":
                        format = destinationColumns.get(i).getText();
                        break;
                    case "Specification":
                        specification = destinationColumns.get(i).getText();
                        break;
                    case "No. Copies":
                        noOfCopies = destinationColumns.get(i).getText();
                        break;
                    case "Media Compile":
                        mediaCompile = destinationColumns.get(i).getText();
                        break;
                    case "Service Level":
                        serviceLevel = destinationColumns.get(i).getText();
                        break;
                    case "Notes":
                        notes = destinationColumns.get(i).getText();
                        break;
                    case "Delivery Status":
                        deliveryStatus = destinationColumns.get(i).getText();
                        break;
                    case "Arrival Date":
                        arrivalDate = destinationColumns.get(i).getText();
                        break;

                }
            }
        }

    }

    public List <TrafficDestination> getDestinationsForOrderItem(TrafficOrderNestedList.TrafficOrderItem orderItem){
        web.waitUntilElementAppear(destinationsRowSelector);
        List<WebElement> destinationsRows = web.findElements(destinationsRowSelector);
    //    Common.sleep(6000);
        List <TrafficDestination> destinations = new ArrayList<>();
        for (WebElement rowElement :destinationsRows) {
            Common.sleep(2000);
            destinations.add(new TrafficDestination(orderItem, rowElement, web));
        }
       return  destinations;
    }

    public List <AdditionalService> getAdditionalServiceForOrderItem(TrafficOrderNestedList.TrafficOrderItem orderItem){
        List<WebElement> destinationsRows = orderItem.getCurrentNode().findElements(additionalServicesRowSelector);
        List <AdditionalService> destinations = new ArrayList<>();
        for (WebElement rowElement :destinationsRows) {
            destinations.add(new AdditionalService(orderItem, rowElement, web));
        }
        return  destinations;
    }
    public TrafficDestination getDestinationByName(String name,String wrappedWithTestSessionName,TrafficOrderNestedList.TrafficOrderItem orderItem){
        List<TrafficDestination> destinations = getDestinationsForOrderItem(orderItem);
        for (TrafficDestination destination :destinations) {
            if (destination.destinationName.equals(name)||destination.destinationName.equals(wrappedWithTestSessionName))
                return destination;
        }
        return null;
    }

    private List<WebElement> getDestinationTableHeaderCells(WebElement node){
        return node.findElements(destinationsTitleSelector);

    }

    private List<WebElement> getAdditionalServiceTableHeaderCells(WebElement node){
  //      return node.findElement(destinationsTitleSelector).findElements(By.cssSelector("th"));
        return node.findElements(By.xpath("//tr[@class=\"destination-table-header\"]/th"));
    }
    private List<String> getDestinationTableNames(){
        WebElement node= web.findElement(By.cssSelector("[class='table-body tv-destinations']"));
        List<WebElement> cells = getDestinationTableHeaderCells(node);
        List <String> tableNames = new ArrayList<>();
        for (WebElement element : cells) {
            tableNames.add(element.getText());
        }
        return tableNames;
    }

    private List<String> getAdditionalServicesTableNames(WebElement currentNode){
        List<WebElement> cells = getAdditionalServiceTableHeaderCells(currentNode);
        List <String> tableNames = new ArrayList<>();
        for (WebElement element : cells) {
            if(!element.getText().equals(""))
              tableNames.add(element.getText());
        }
        return tableNames;
    }
}
