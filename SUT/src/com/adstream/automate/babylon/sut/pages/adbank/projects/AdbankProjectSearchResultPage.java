package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.pages.adbank.AdbankPaginator;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 03.10.12
 * Time: 11:57
 */
public class AdbankProjectSearchResultPage extends AdbankPaginator {

    public AdbankProjectSearchResultPage(ExtendedWebDriver web) {
        super(web);
    }

    protected List<WebElement> getObjectsLinks() {
        By linksLocator = By.cssSelector(".row>.cell>.vmiddle .project_link");
        return web.findElements(linksLocator);
    }

    public int getCountOfTotalProject() {
        return Integer.parseInt(web.findElement(By.cssSelector("[data-id='total-count']")).getText());
    }

    public int getItemsCount() {
        return web.findElementsToStrings(By.cssSelector("[data-id=\"all-items\"]")).size();
    }
}
