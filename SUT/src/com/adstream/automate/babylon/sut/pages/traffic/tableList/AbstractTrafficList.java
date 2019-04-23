package com.adstream.automate.babylon.sut.pages.traffic.tableList;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by denysb on 02/12/2015.
 */
public abstract class AbstractTrafficList extends BasePage {
    private static final By ROOT_TABLE_NODE = By.cssSelector("[class='app-wrapper']");
    private static final By NESTED_ROOT_TABLE_NODE = By.cssSelector(".table-head-inner");
    protected final static By labelCode = By.cssSelector("[ng-click=\"$houseNumberEditCustomCodeCtrl.updateHouseNumber(prefix)\"]");
    protected final static By houseNumberPencilIconSelector = By.cssSelector("div>span[ng-if='!$houseNumberEditDefaultCtrl.isEditing']");
    protected final static By houseNumberInputFieldSelector = By.cssSelector("[ng-model=\"$houseNumberEditDefaultCtrl.editValue\"]");
    protected final static By houseNumberInputSelector = By.cssSelector(".input-group-addon.house-number-view");
    protected final static By houseNumberMenaInputFieldSelector = By.cssSelector("[ng-if='$houseNumberEditCustomCodeCtrl.houseNumber']");
    protected static final By houseNumberSuffixlocator = By.cssSelector("span.input-group-addon");
    protected final static By houseNumberMenaPencilIconSelector = By.cssSelector("a[uib-tooltip='Edit House Number']");
    protected static final By columnSubtitleSelector = By.cssSelector("[ng-switch-when='orderSubtitlesRequired']");
    private final static By progressBarPageLoadingSelector = By.cssSelector("#loading-bar");
    private final static long pageLoadingTimeOut = 20 * 1000; //20sec

    public AbstractTrafficList(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(ROOT_TABLE_NODE);
    }

    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(ROOT_TABLE_NODE));
    }

    protected WebElement getRootTableNode(){
        return web.findElement(ROOT_TABLE_NODE);
    }

    protected WebElement getNestedNode(){
        return web.findElement(NESTED_ROOT_TABLE_NODE);
    }

    private List<WebElement> getColumnTitlesElements(By locator){
        return web.findElements(locator);
    }

    public List getColumnTitlesNames(By locator){
        List <WebElement> list= getColumnTitlesElements(locator);
        List <String> columnTitles = new ArrayList<String>();
        if(list == null || list.size() == 0) return columnTitles;
        for (WebElement webElement : list) {
            columnTitles.add(webElement.getText().trim());
        }
        return columnTitles;
    }

    public void waitUntilPageWillBeLoaded(Integer timeOut){
        long start = System.currentTimeMillis();
        do {
            if (timeOut > 0)
                Common.sleep(timeOut * 2);
            if (System.currentTimeMillis() - start > pageLoadingTimeOut) {
                throw new TimeoutException("Timeout during Order Item page Loading!");
            }
        } while (web.isElementPresent(progressBarPageLoadingSelector));
    }

}
