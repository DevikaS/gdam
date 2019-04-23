package com.adstream.automate.babylon.sut.pages.admin.agency;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.babylon.sut.pages.admin.agency.elements.AddNewPartnerPopup;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.BillingRuleBuilderForm;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import org.openqa.selenium.By;
import java.util.List;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
  * User: lynda-k
 * Date: 25.02.14
 * Time: 12:07
 */
public class AgencyPartnersPage extends BaseAdminPage<AgencyPartnersPage> {
    private String agencyType;
    private Button setUpBilling;

    public AgencyPartnersPage(ExtendedWebDriver web) {
        super(web);
        setUpBilling = new Button(this, getSetUpBillingBtnLocator());
    }

    @Override
    public void init() {
        super.init();
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.className("itemsList"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.className("itemsList")));
    }

    public List<String> getFullPartnersList() {
        return web.findElementsToStrings(By.cssSelector(".itemsList .link"));
    }

    public AddNewPartnerPopup clickNewPartnerButton() {
        web.click(getNewPartnerButtonLocator());
        return new AddNewPartnerPopup(this);
    }

    public PopUpWindow clickRemoveButton() {
        web.click(getRemoveButtonLocator());
        web.sleep(2000);
        return new PopUpWindow(this);
    }

    public void selectPartner(String name) {
        web.click(By.xpath(String.format("//*[contains(@class,'row')][not(contains(@class,'selected'))][.//*[normalize-space()='%s']]", name)));
    }

    public String getAgencyType(String agencyName) {
        if (agencyType == null)
            agencyType = web.findElement(By.xpath(String.format("//*[contains(@class,'row')][not(contains(@class,'selected'))][.//*[normalize-space()='%s']]//*[contains(@class,'size1of3')]//*[contains(@class, 'ng-binding')]", agencyName))).getText().trim();
        return agencyType;
    }

    public BillingRuleBuilderForm getBillingRuleBuilderForm() {
        if (!web.isElementVisible(By.cssSelector(BillingRuleBuilderForm.ROOT_NODE)))
            clickSetUpBilling();
        return new BillingRuleBuilderForm(this);
    }

    public boolean isSetUpBillingBtnVisible() {
        return setUpBilling.isVisible();
    }

    public void checkAllowBillforPartnerBU(String partner) {
        web.findElement(By.xpath(String.format("//*[contains(@class, 'itemsList')]//a[.='%s']/../../following-sibling::*//input[@name='behalf']", partner))).click();
    }

    private void clickSetUpBilling() {
        setUpBilling.click();
        web.sleep(1000);
    }

    private By getSetUpBillingBtnLocator() {
        return By.cssSelector("[ng-click='unitsPartnersCtrl.setupBilling()']");
    }

    private By getNewPartnerButtonLocator() {
        return By.cssSelector("[ng-click*='AddPartner']");
    }

    private By getRemoveButtonLocator() {
        return By.cssSelector("[ng-click*='RemovePartner']");
    }
}