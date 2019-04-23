package com.adstream.automate.babylon.sut.pages.admin.agency.agencySearch;

import com.adstream.automate.babylon.sut.pages.ordering.PageElement;
import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.AbstractList;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by Geethanjali.K on 20-01-2016-NGN16208
 */
public class AgencyList extends AbstractList {
    public AgencyList(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(getListLocator());
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(getListLocator()));
    }

    public static class Agency extends PageElement<AgencyList> {

        private String businessUnit;
        private String type;
        private String country;
        private String storage;

        public Agency(ExtendedWebDriver web, AgencyList parent, WebElement row) {
            super(web, parent);
            List<WebElement> cells = row.findElements(By.className("cell"));
            businessUnit = cells.get(0).findElement(By.tagName("a")).getText();
            type = cells.get(1).findElement(By.className("ng-binding")).getText();
            country =  cells.get(2).findElement(By.className("ng-binding")).getText();
            storage =   cells.get(3).findElement(By.className("ng-binding")).getText();
        }


        public String getType() {
            return type;
        }

        public String getCountry() {
            return country;
        }

        public String getStorage() {
            return storage;
        }

        public String getBusinessUnit() {
            return businessUnit;
        }
    }

    public Agency getAgencyByName(String businessUnit) {
        for (Agency agency: getAgencies()) {
            if (agency.getBusinessUnit().equals(businessUnit))
                return agency;
        }
        return null;
    }


    private List<Agency> getAgencies() {
        if (!web.isElementPresent(getAgencyRowLocator())) return null;
        List<WebElement> agencyElements = web.findElements(getAgencyRowLocator());
        List<Agency> agencies = new ArrayList<>();
        for (WebElement element: agencyElements)
            agencies.add(new Agency(web, this, element));
        return agencies;
    }


    private By getAgencyRowLocator() {
        return generateListLocator(".row");
    }

    public String getEmptyMessage(){
       String message = web.findElement(By.xpath(".//*[@id='app-main']/div/div/div[2]/div/div/div[2]/div/div/div[2]/div/div/div")).getText().trim();
        return message;

    }

}