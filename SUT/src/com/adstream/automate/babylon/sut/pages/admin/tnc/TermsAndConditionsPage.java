package com.adstream.automate.babylon.sut.pages.admin.tnc;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: ruslan.semerenko
 * Date: 25.04.12 12:39
 */
public class TermsAndConditionsPage extends BaseAdminPage {
    private Checkbox enableTnCForProjectsCheckbox;

    public TermsAndConditionsPage(ExtendedWebDriver web) {
        super(web);
        enableTnCForProjectsCheckbox = new Checkbox(this, getEnableForProjectsCheckboxLocator());
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppear(By.cssSelector("[ng-controller='termsAndConditionsCtrl']"));
    }

    @Override
    public void isLoaded() {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.cssSelector("[ng-controller='termsAndConditionsCtrl']")));
    }

    public String getEntryTextBoxValue() {
        return web.findElement(getEntryTextboxLocator()).getAttribute("value").trim();
    }

    public void fillEntryTextBox(String text) {
        web.sleep(5000);
        web.typeClean(getEntryTextboxLocator(), text);
    }

    public void checkEnableForProjectsCheckbox() {
        web.sleep(2000);
        setEnableForProjects(true);
    }

    public void uncheckEnableForProjectsCheckbox() {
        setEnableForProjects(false);
    }

    public void setEnableForProjects(boolean selected) {
        enableTnCForProjectsCheckbox.setSelected(selected);
    }

    public boolean isEnabledForProjects() {
        return enableTnCForProjectsCheckbox.isSelected();
    }

    public void clickSaveButton() {
        web.click(By.cssSelector("[ng-click='save()']"));
        Common.sleep(1000);
    }

    public void clickDeleteButton() {
        web.click(By.cssSelector("[ng-click='delete()']"));
    }

    private By getEntryTextboxLocator() {
        return By.cssSelector("[ng-model='entity.text']");
    }

    private By getEnableForProjectsCheckboxLocator() {
        return By.cssSelector("[ng-model='isEnabledForAgency']");
    }
}