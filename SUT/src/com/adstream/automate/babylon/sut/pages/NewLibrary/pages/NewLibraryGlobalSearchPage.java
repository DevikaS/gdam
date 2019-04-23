package com.adstream.automate.babylon.sut.pages.NewLibrary.pages;

import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.LibraryWalkMePopup;
import com.adstream.automate.babylon.sut.pages.NewLibrary.elements.RestorePopUp;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;


public class NewLibraryGlobalSearchPage extends LibraryAsset<NewAdbankLibraryPage> {
    private static final By CHECK_ON_LOAD=By.xpath("//div[@class='global-search-header']");
    public NewLibraryGlobalSearchPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppear(CHECK_ON_LOAD);
        Common.sleep(1000);
    }

    @Override
    public void isLoaded() throws Error {
        Common.sleep(2000);
        new LibraryWalkMePopup(this).clickClose();
        assertTrue(web.isElementPresent(CHECK_ON_LOAD));
    }

    public void enterSearchCriteria(String input)
    {
        web.findElement(By.xpath("//input[@placeholder='Enter your search']")).clear();
        web.findElement(By.xpath("//input[@placeholder='Enter your search']")).sendKeys(input);
        web.findElement(By.xpath("//input[@placeholder='Enter your search']")).sendKeys(Keys.ENTER);
    }

    public void clickViewAll() {
        web.findElement(By.xpath("//a[@ng-click='$ctrl.resultsGroup.viewAll()']")).click();
        web.waitUntilElementDisappear(By.xpath("//a[@ng-click='$ctrl.resultsGroup.viewAll()']"));

    }

    public void clickBackButton() {
        web.findElement(By.xpath("//ads-md-button[@click='$ctrl.closeSearch()']/button")).click();

    }

    public List<String> getListOfAssets()
    {
        return web.findElementsToStrings(By.xpath("//div[@ng-repeat='item in $ctrl.resultsGroup.list']//div[contains(@class,'result-item-title')]"));
    }

    public String getTotalAssetsFound()
    {
        return web.findElement(By.xpath("//global-search-results-section/h4")).getText();
    }

    public void selectMenuOption(String option)
    {
        web.findElement(By.xpath("//ads-md-menu//span[@code='chevron-outline-down']")).click();
        Common.sleep(2000);
        web.findElement(By.xpath("//ads-md-button/button//span[.='" + option + "']")).click();
    }

    public void checkMatchAllWords(String input)
    {
        String text = web.findElement(By.xpath("//ads-md-checkbox[@checked='$ctrl.isMatchAll()']/md-checkbox")).getAttribute("checked");
        if(input.equalsIgnoreCase("check")) {
                web.findElement(By.xpath("//ads-md-checkbox[@checked='$ctrl.isMatchAll()']/md-checkbox")).click();

        }
        else if(input.equalsIgnoreCase("uncheck")) {
            if (text.equalsIgnoreCase("checked")) {
                web.findElement(By.xpath("//ads-md-checkbox[@checked='$ctrl.isMatchAll()']/md-checkbox")).click();
            }

        }
    }

}
