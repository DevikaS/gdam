package com.adstream.automate.babylon.sut.pages.ordering.elements.lists;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

/*
 * Created by demidovskiy-r on 21.08.2014.
 */
public abstract class DestinationToDelivery {

    protected ExtendedWebDriver web;
    private String orderReference;
    private String destination;
    private String dateOrdered;
    private String orderedBy;
    private String status;

    public DestinationToDelivery(ExtendedWebDriver web, WebElement rowElement) {
        this.web = web;
        orderReference = rowElement.findElement(generateCellLocator("1")).getText();
        destination = rowElement.findElement(generateCellLocator("2")).getText();
        dateOrdered = rowElement.findElement(generateCellLocator("3")).getText();
        orderedBy = rowElement.findElement(generateCellLocator("4")).getText();
        status = rowElement.findElement(generateCellLocator("5")).getText();
    }

    public DestinationToDelivery(ExtendedWebDriver web, WebElement rowElement,String name) {
        this.web = web;
        orderReference = rowElement.findElement(getCellLocator("0")).getText();
        destination = rowElement.findElement(getCellLocator("1")).getText();
        dateOrdered = rowElement.findElement(getCellLocator("2")).getText();
        orderedBy = rowElement.findElement(getCellLocator("3")).getText();
        status = rowElement.findElement(getCellLocator("4")).getText();
    }

    public String getOrderReference() {
        return orderReference;
    }

    public String getDestination() {
        return destination;
    }

    public String getDateOrdered() {
        return dateOrdered;
    }

    public String getOrderedBy() {
        return orderedBy;
    }

    public String getStatus() {
        return status;
    }

    protected By generateCellLocator(String partialLocator) {

           return By.xpath(("//article[@ng-repeat='delivery in vm.deliveriesList']/div[" + partialLocator) + "]");
    }

    protected By getCellLocator(String partialLocator) {

        return By.cssSelector(".column-" + partialLocator + " .cell-content");
    }



}