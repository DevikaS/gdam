package com.adstream.automate.babylon.sut.pages.ordering.elements.lists;

import com.adstream.automate.babylon.sut.pages.ordering.BaseOrderingPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.List;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 16.09.13
 * Time: 18:31
 */
public abstract class AbstractList extends BaseOrderingPage<AbstractList> {
    private final String ROOT_NODE = ".itemsList";
    private final String NESTED_ROOT_NODE = "[data-type='nested-list']";

    public AbstractList(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(getListLocator());
    }

    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(getListLocator()));
    }

    public List<String> getVisibleColumnTitles() {
        List<String> titles = new ArrayList<String>();
        List<WebElement> columnTitles = getColumnTitles();
        if (columnTitles == null || columnTitles.size() == 0) return titles;
        for (WebElement columnTitle : columnTitles)
            titles.add(columnTitle.getText().trim());
        return titles;
    }

    protected String getRootNode() {
        return ROOT_NODE;
    }

    protected String getNestedRootNode() {
        return NESTED_ROOT_NODE;
    }

    protected By getListLocator() {
        return By.cssSelector(getRootNode());
    }

    protected By generateListLocator(String partialLocator) {
        return By.cssSelector(getRootNode() + " " + partialLocator);
    }

    protected By generateNestedListLocator() {
        return By.cssSelector(getRootNode() + " " + getNestedRootNode());
    }

    protected By generateNestedListLocator(String partialLocator) {
        return By.cssSelector(getRootNode() + " " + getNestedRootNode() + " " + partialLocator);
    }

    protected List<WebElement> getColumnTitles() {
        return web.findElements(By.cssSelector(getRootNode() + " [data-dojo-type='common.table.header'] .column-title"));
    }
}