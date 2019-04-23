package com.adstream.automate.babylon.sut.pages.adbank.projects;

import com.adstream.automate.babylon.sut.pages.adbank.AdbankPaginator;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;

/**
 * Created with IntelliJ IDEA.
 * User: solomin-y
 * Date: 19.10.12
 * Time: 15:17

 */
public class AdbankTemplateSearchResultPage extends AdbankPaginator {

    public AdbankTemplateSearchResultPage(ExtendedWebDriver web) {
        super(web);
    }

    public int getItemsCount() {
        return web.findElementsToStrings(By.cssSelector(".first.vmiddle.link.no-decoration.project_link")).size();
    }

}
