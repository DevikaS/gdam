package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Link;
import org.openqa.selenium.By;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by demidovskiy-r on 11.08.2014.
 */
public class AdbankLibraryRelatedProjectsPage extends AdbankLibraryAssetsInfoPage {
    private final String ROOT_NODE = "[ng-controller='relatedProjectsCtrl']";
    private Link originatedInProject;

    public AdbankLibraryRelatedProjectsPage(ExtendedWebDriver web) {
        super(web);
        originatedInProject = new Link(this, generatePageElementLocator("a"));
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(getPageLocator());
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(getPageLocator()));
    }

    public String getOriginatedProjectName() {
        return originatedInProject.getText();
    }

    public boolean getRelatedProjectName(String projectName) {
        return web.isElementPresent(By.xpath("//div[@ng-repeat='projectRelation in projectRelations']//a[text()='" + projectName + "']"));
    }

    public String getOriginatedProjectHRef() {
        return originatedInProject.getHRef();
    }

    public void clickOriginatedProjectLink() {
        originatedInProject.click();
    }

    private By generatePageElementLocator(String partialLocator) {
        return By.cssSelector(ROOT_NODE + " " + partialLocator);
    }

    private By getPageLocator() {
        return By.cssSelector(ROOT_NODE);
    }
}