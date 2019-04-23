package com.adstream.automate.babylon.sut.pages.admin.people;

import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms.DeliveryAccessRuleBuilderForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.lists.DeliveryAccessRulesList;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by demidovskiy-r on 08.12.2014.
 */
public class UserDeliveryPage extends UsersPage {
    private final static String ROOT_NODE = "[data-dojo-type='admin.people.deliveryTabAccessRules']";
    private Button manageAccessRulesBtn;

    public UserDeliveryPage(ExtendedWebDriver web) {
        super(web);
        manageAccessRulesBtn = new Button(this, generatePageElementLocator("[data-role='manageButton']"));
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(getUserDeliveryPageLocator());
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(getUserDeliveryPageLocator()));
    }

    public DeliveryAccessRuleBuilderForm getDeliveryAccessBuilderForm() {
        if (!web.isElementVisible(By.cssSelector(DeliveryAccessRuleBuilderForm.ROOT_NODE)))
            clickManageAccessRuleBtn();
        return new DeliveryAccessRuleBuilderForm(this);
    }

    public DeliveryAccessRulesList getDeliveryAccessRulesList() {
        if (!web.isElementVisible(generatePageElementLocator("[data-role='rulesList']")))
            throw new NoSuchElementException("There are no any Delivery Access Rules on Delivery User page!");
        return new DeliveryAccessRulesList(web);
    }

    public boolean checkManageAccessRulesButton() {
        if (web.isElementVisible(By.xpath("//div[@data-role='manageButton']")))
            return true;
        else
            return false;
    }

    private void clickManageAccessRuleBtn() {
        manageAccessRulesBtn.click();
    }

    private By generatePageElementLocator(String partialLocator) {
        return By.cssSelector(String.format("%s %s", ROOT_NODE, partialLocator));
    }

    private By getUserDeliveryPageLocator() {
        return By.cssSelector(ROOT_NODE);
    }
}