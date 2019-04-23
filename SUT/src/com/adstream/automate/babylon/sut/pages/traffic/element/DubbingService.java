package com.adstream.automate.babylon.sut.pages.traffic.element;

import com.adstream.automate.babylon.sut.pages.traffic.BaseTrafficPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.InvalidSelectorException;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * Created by Janaki.Kamat on 08/12/2016.
 */
public class DubbingService {

    ExtendedWebDriver web;
    private WebElement currentNode;
    private String clockNumber;
    private String type;
    private String format;
    private String specification;
    private String noOfCopies;
    private String mediaCompile;
    private String serviceLevel;
    private String notes;
    private String deliveryStatus;
    private String arrivalDate;
    private String destination;

    public WebElement getDeliveryStatusDropdown() {
        return deliveryStatusDropdown;
    }

    private WebElement deliveryStatusDropdown;

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getClockNumber() {
        return clockNumber;
    }

    public void setClockNumber(String clockNumber) {
        this.clockNumber = clockNumber;
    }
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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

    public String getServiceLevel() {
        return serviceLevel;
    }

    public void setServiceLevel(String serviceLevel) {
        this.serviceLevel = serviceLevel;
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

    public ExtendedWebDriver getWeb() {
        return web;
    }

    public void setWeb(ExtendedWebDriver web) {
        this.web = web;
    }


    private final By columnTitlesSelector =By.cssSelector("[production-services='::$tvOrderDetailsCtrl.additionalServices.productionServices'] table");
    private final By cellsSelector = By.cssSelector("td");

    public DubbingService(WebElement destRow,ExtendedWebDriver driver) {
        web=driver;
        currentNode = destRow;
        List<WebElement> tail = web.findElements(columnTitlesSelector);
        List<WebElement> cells = currentNode.findElements(cellsSelector);
        if (cells.size() == 0) {
            throw new InvalidSelectorException("Selector " + cellsSelector + " is absent");
        }
        loadFields(cells);
    }

    public List getColumnTitlesNames() {
        WebElement listProd = web.findElements(columnTitlesSelector).get(0);
        List<WebElement> list=listProd.findElements(By.cssSelector("thead:nth-child(1) th"));
        List<String> columnTitles = new ArrayList<String>();
        if (list == null || list.size() == 0) return columnTitles;
        for (WebElement webElement : list) {
            columnTitles.add(webElement.getText().trim());
        }
        return columnTitles;
    }
    private void loadFields(List<WebElement> cells) {
        List<String> list = getColumnTitlesNames();
        web.manage().timeouts().implicitlyWait(0, TimeUnit.SECONDS);
        int COUNT=0;
        for (String titl:list) {
            switch (titl) {
                case "Clock number":
                    clockNumber = cells.get(COUNT++).getText();
                    break;
                case "Destination":
                    destination=cells.get(COUNT++).getText().split("\n")[0];
                    break;
                case "Type":
                    type = cells.get(COUNT++).getText();
                    break;
                case "Format":
                    format = cells.get(COUNT++).getText();
                    break;
                case "Specification":
                    specification = cells.get(COUNT++).getText();
                    break;
                case "No. Copies":
                    noOfCopies = cells.get(COUNT++).getText();
                    break;
                case "Media Compile":
                    mediaCompile = cells.get(COUNT++).getText();
                    break;
                case "Service Level":
                    serviceLevel = cells.get(COUNT++).getText();
                    break;
                case "Notes":
                    notes = cells.get(COUNT++).getText();
                    break;
                case "Delivery Status":
                    try {
                        deliveryStatusDropdown = cells.get(COUNT).findElement(By.cssSelector("button span"));
                    }
                    catch(Exception e){
                        deliveryStatusDropdown=null;
                    }
                    deliveryStatus = cells.get(COUNT++).getText();
                    break;
                case "Arrival Date":
                    arrivalDate = cells.get(COUNT++).getText();
                    break;

            }

        }
        web.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
    }

 }





