package com.adstream.automate.babylon.sut.pages.admin.agency.agencySearch;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.babylon.sut.pages.admin.agency.elements.NewAgencyPopup;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by Geethanjali.K on 20-01-2016-NGN16208
 */
public class GlobalAdminSearchAgencyPage extends BaseAdminPage<GlobalAdminSearchAgencyPage> {
    private final String ROOT_NODE = ".md-search";


    public GlobalAdminSearchAgencyPage(ExtendedWebDriver web) {
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

    public SearchAgencyModelForm getSearchAgencyModelForm() {
        return new SearchAgencyModelForm(this);
    }

    public AgencyList getAgencyList() {
        return new AgencyList(web);
    }

    private By getPageLocator() {
        return By.cssSelector(ROOT_NODE);
    }

 /*   public void chooseFilter(String field) {

        web.findElement(By.id("s2id_autogen2_search"));

    }*/

    public NewAgencyPopup clickNewBU() {
        web.waitUntilElementAppearVisible(getNewBUButtonLocator());
        web.click(getNewBUButtonLocator());
        web.waitUntilElementAppearVisible(By.cssSelector(".projects_action_form_popup"));

        return new NewAgencyPopup(this);
    }

    private By getNewBUButtonLocator() {
        return By.cssSelector("[data-dojo-type='units.info.editAgency']");
    }

    public boolean isCreateNewBUPopUpVisible() {
        return web.isElementVisible(By.xpath("//*[contains(@class, 'popupWindow')]//*[text()='New Business Unit']"));
    }


}