package com.adstream.automate.babylon.sut.pages.admin.relatedFiles;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by Geethanjali.K on 11/02/2016
 */
public  class RelatedFilesManagementPage extends BaseAdminPage<RelatedFilesManagementPage> {

    private final static String ROOT_NODE = ".size1of1.clearfix.content-block";

    public RelatedFilesManagementPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        web.waitUntilElementAppearVisible(getPageLocator());
    }

    @Override
    public void isLoaded() throws Error {
        assertTrue(web.isElementVisible(getPageLocator()));
    }

    protected String getRootNode() {
        return ROOT_NODE;
    }

    protected By generatePageLocator(String partialLocator) {
        return By.cssSelector(String.format("%s %s", getRootNode(), partialLocator));
    }

    private By getPageLocator() {
        return By.cssSelector(getRootNode());
    }

    // NGN-16212 - QAA: Global Admin can Search for BU - By Geethanjali- code starts
    private By getRelationRole1Locator() {
        return By.cssSelector("div.pam div.size1of1:nth-child(1) label:nth-child(1) div:nth-child(2) input:nth-child(1)");
    }

    public String getRelationRole1Value() {
        return web.findElement(getRelationRole1Locator()).getAttribute("value").trim();
    }

    public void fillRelationRole1Box(String text) {
        web.sleep(3000);
       web.typeClean(getRelationRole1Locator(), text);
    }

    private By getRelationRole2Locator() {
        return By.cssSelector("div.pam div.size1of1:nth-child(2) label:nth-child(1) div:nth-child(2) input:nth-child(1)");
    }

    public String getRelationRole2Value() {
        return web.findElement(getRelationRole2Locator()).getAttribute("value").trim();
    }
    public void fillRelationRole2Box(String text) {
        web.sleep(3000);
        //web.findElement(getRelationRole2Locator()).sendKeys(text);
        web.typeClean(getRelationRole2Locator(), text);
    }

    public List<String> getRelatedTypesList() {
        return web.findElementsToStrings(By.cssSelector(".ellipsis.overflow-hidden.ng-binding"));
    }

    public void clickCreateRelationsTypeButton() {
        web.click(By.cssSelector(".button.secondary.mrs.ng-scope"));
        Common.sleep(1000);
    }
    // NGN-16212 - QAA: Global Admin can Search for BU - By Geethanjali- code Ends
}