package com.adstream.automate.babylon.sut.pages.admin.views;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by demidovskiy-r on 17.06.2015.
 */
public  class ViewAssetPage extends BaseAdminPage<ViewAssetPage> {
    private final static String ROOT_NODE = "[data-dojo-type='admin.views.main_panel']";

    public ViewAssetPage(ExtendedWebDriver web) {
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


    public void clickSaveButton() {
        web.click(By.cssSelector(".button.secondary.save"));
        Common.sleep(1000);
    }
   public void fillInFields(String fieldName,String fieldValue)
   {
       if(fieldValue.isEmpty()) {
           web.findElement(By.xpath("//div[@data-dojo-type='admin.views.table_ordering']//div[contains(.,'" + fieldName + "')] [not(contains(.,'ID Film'))]/child::input")).clear();}
        else {
           web.typeClean(By.xpath("//div[@data-dojo-type='admin.views.table_ordering']//div[contains(.,'" + fieldName + "')]/child::input"),fieldValue);}
   }
}