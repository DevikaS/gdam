package com.adstream.automate.babylon.sut.pages.mediamanager.tablelist;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

public class AbstractMediaCheckerList extends BasePage {
    private static final By ROOT_TABLE_NODE = By.cssSelector(".ui.container table");
    public AbstractMediaCheckerList(ExtendedWebDriver web) {
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
}