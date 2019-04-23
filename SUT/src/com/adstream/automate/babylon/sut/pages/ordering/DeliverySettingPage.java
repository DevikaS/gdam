package com.adstream.automate.babylon.sut.pages.ordering;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.DeliverySettingForm;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 25.11.13
 * Time: 13:45
 */
public class DeliverySettingPage extends BaseAdminPage<DeliverySettingPage> {
    private Button saveBtn;

    public DeliverySettingPage(ExtendedWebDriver web) {
        super(web);
        saveBtn = new Button(this, By.className("save"));
    }

    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(getDeliverySettingPageLocator());
    }

    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(getDeliverySettingPageLocator()));
    }

    public DeliverySettingForm getDeliverySettingForm() {
        if (!web.isElementVisible(By.cssSelector(DeliverySettingForm.ROOT_NODE)))
            throw new NoSuchElementException("There is no Delivery Setting form on the page!");
        return new DeliverySettingForm(this);
    }

    public void save() {
        saveBtn.click();
    }

    private By getDeliverySettingPageLocator() {
        return By.className("delivery-settings");
    }
}