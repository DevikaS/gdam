package com.adstream.automate.babylon.sut.pages.admin.people;

import com.adstream.automate.babylon.sut.data.UserDecorator;
import com.adstream.automate.babylon.sut.elements.controls.complex.LogoElement;
import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.HashMap;
import java.util.Map;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created by IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 06.02.12
 * Time: 17:57
 */
public class CreateUserPage extends BaseAdminPage {
    protected Edit email;
    private LogoElement logo;
    public DojoCombo agencyBox;
    public DojoCombo roleBox;
    public DojoCombo languageBox;

    public CreateUserPage(ExtendedWebDriver web) {
        super(web);
        email = new Edit(this, By.name("_cm.common.email"));
        agencyBox = new DojoCombo(this, By.cssSelector(".test_advertiser"));
        roleBox = new DojoCombo(this, By.cssSelector(".roles"));
        languageBox = new DojoCombo(this, By.cssSelector("[data-schema-path='user#_cm.common.language'] .dijitComboBox"));
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.cssSelector("[data-dojo-type='admin.people.UserSettingsForm']"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(By.cssSelector("[data-dojo-type='admin.people.UserSettingsForm']")));
    }

    public CreateUserPage fillFields(UserDecorator user) {
        web.typeClean(getFirstNameLocator(), user.getFirstName());
        web.typeClean(getLastNameLocator(), user.getLastName());
//        agencyBox.selectByVisibleText(user.getAgencyName());   due to remove advertisers , also NGN-6231
        if (!user.getEmail().isEmpty() && getEmailLocator().isEnabled())
            fillEmail(user.getEmail());   //NGN-5918
        web.typeClean(getPhoneNumberLocator(), user.getPhoneNumber());
        if (!(this instanceof EditUserPage) && !user.getPassword().equals("none"))
            web.typeClean(getPasswordLocator(), user.getPassword());
        web.setCheckBoxTo(getFoldersCheckboxLocator(), user.isFoldersAccess());
        web.setCheckBoxTo(getAccesStreamlinedLibraryCheckboxLocator(), user.isStreamLinedLibraryAccess());
        web.setCheckBoxTo(getAccesLibraryCheckboxLocator(), user.isLibraryAccess()); //This can be removed..no need to have this line
        if(user.isOrderingAccess()){
        web.setCheckBoxTo(getAccessOrderingCheckboxLocator(), user.isOrderingAccess());}
        web.typeClean(getMobileNumberLocator(), user.getMobileNumber());
        web.typeClean(getSkypeNumberLocator(), user.getSkypeNumber());
        web.typeClean(getGTalkLocator(), user.getGoogleTalkContact());
        web.sleep(2000);
        roleBox.loadedStore().selectByVisibleText(user.getRoleName());
        web.setCheckBoxTo(By.name("_cm.common.disabled"), user.isDisabled());
        if (user.getLogo() != null && !user.getLogo().isEmpty()) {
            uploadLogo(user.getLogoPath());
        }
        getLanguageBoxLocator().selectByVisibleText("English");
        return this;
    }

    public CreateUserPage changeUserRole(String userRole) {
        web.sleep(3000);
        roleBox.loadedStore().selectByVisibleText(userRole);
        clickSave();
        return this;
    }

    public DojoCombo getLanguageBoxLocator() {
        return languageBox;
    }

    public Edit getEmailLocator() {
        return email;
    }

    public By getGTalkLocator() {
        return By.name("_cm.common.gTalkContact");
    }

    public By getSkypeNumberLocator() {
        return By.name("_cm.common.skypeNumber");
    }

    public By getMobileNumberLocator() {
        return By.name("_cm.common.mobileNumber");
    }

    public By getFirstNameLocator() {
        return By.name("_cm.common.firstName");
    }

    public By getLastNameLocator() {
        return By.name("_cm.common.lastName");
    }

    public By getPhoneNumberLocator() {
        return By.name("_cm.common.phoneNumber");
    }

    public By getPasswordLocator() {
        return By.name("password");
    }

    public By getFoldersCheckboxLocator() {
        return By.name("_cm.view.access.folders");
    }

    public By getAccesLibraryCheckboxLocator() {
        return By.name("_cm.view.access.library");
    }
    public By getAccesStreamlinedLibraryCheckboxLocator() {
        return By.name("_cm.view.access.streamlined_library");
    }

    public By getAccessOrderingCheckboxLocator() {
        return By.name("_cm.view.access.ordering");
    }

    public Map<String, By> getLocatorsOfUserForm() {
        Map<String, By> map = new HashMap<>();
        map.put("gtalk", getGTalkLocator());
        map.put("skype", getSkypeNumberLocator());
        map.put("mobile", getMobileNumberLocator());
        map.put("firstName", getFirstNameLocator());
        map.put("lastName", getLastNameLocator());
        map.put("phone", getPhoneNumberLocator());
        map.put("password", getPasswordLocator());
        map.put("folders", getFoldersCheckboxLocator());
        map.put("library", getAccesLibraryCheckboxLocator());
        map.put("ordering", getAccessOrderingCheckboxLocator());

        return map;
    }

    public boolean isFieldEnabled(By fieldLocator) {
        return web.findElement(fieldLocator).isEnabled();
    }


    public void uploadLogo(String logoPath) {
        if (logo == null) logo = new LogoElement(web);
        logo.uploadLogo(logoPath);
    }

    protected String getFieldValue(String fieldName) {
        return web.findElement(By.name(fieldName)).getAttribute("value");
    }

    protected boolean isElementSelected(String fieldName) {
        return web.findElement(By.name(fieldName)).isSelected();
    }

    protected void fillByName(String fieldName, String text) {
        web.typeClean(By.name(fieldName), text);
    }

    public String getFirstName() {
        return getFieldValue("_cm.common.firstName");
    }

    public String getLastName() {
        return getFieldValue("_cm.common.lastName");
    }

    public String getEmail() {
        return getFieldValue("_cm.common.email");
    }

    public String getAgency() {
        return agencyBox.getSelectedLabel();
    }

    public String getPhoneNumber() {
        return getFieldValue("_cm.common.phoneNumber");
    }

    public String getMobileNumber() {
        return getFieldValue("_cm.common.mobileNumber");
    }

    public String getSkypeNumber() {
        return getFieldValue("_cm.common.skypeNumber");
    }

    public String getGoogleTalkContact() {
        return getFieldValue("_cm.common.gTalkContact");
    }

    public boolean isFoldersChecked() {
        return isElementSelected("_cm.view.access.folders");
    }

    public boolean isLibraryChecked() {
        return isElementSelected("_cm.view.access.library");
    }
    public boolean isStreamlinedLibraryChecked() {
        return isElementSelected("_cm.view.access.streamlined_library");
    }

    public boolean isOrderingChecked() {
        return isElementSelected("_cm.view.access.ordering");
    }

    public String getRole() {
        return roleBox.loadedStore().getSelectedLabel();
    }

    public String getLogoSrc() {
        return logo.getImageSrc();
    }

    public String getPasswordQualityText() {
        return web.findElement(By.xpath("//*[contains(text(),'Your password must have')]")).getText().trim();
    }

    public void fillFirstName(String text) {
        fillByName("_cm.common.firstName", text);
    }

    public void fillLastName(String text) {
        fillByName("_cm.common.lastName", text);
    }

    public void fillEmail(String text) {
        if (!email.isEnabled()) {
            throw new RuntimeException("NGN-5918 Could not edit email");
        }
        email.type(text);
    }

    public boolean isEmailFieldEnabled() {
        return email.isEnabled();
    }

    public void fillUserRoleList(String text) {
        //roleBox.selectByVisibleText(text);
        web.typeClean(By.cssSelector("[id^=admin_people_global_roles_list]"), text);
    }

    public void fillAgencyList(String text) {
        //agencyBox.selectByVisibleText(text);
        web.typeClean(By.cssSelector("[id^='admin_shared_FilteringSelect']"), text);
    }

    public boolean isPasswordNeverExpiresCheckboxVisible() {
        By locator = By.name("_cm.common.passwordNeverExpires");
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public boolean isPasswordNeverExpiresCheckboxSelected() {
        By locator = By.name("_cm.common.passwordNeverExpires");
        return web.isElementPresent(locator) && new Checkbox(this, locator).isSelected();
    }

    public void selectPasswordNeverExpires() {
        new Checkbox(this, By.name("_cm.common.passwordNeverExpires")).select();
    }

    public void deselectPasswordNeverExpires() {
        new Checkbox(this, By.name("_cm.common.passwordNeverExpires")).deselect();
    }

    public void clickSave() {
      //  if(web.isElementVisible(By.className("save")))
            web.click(By.className("save"));
            web.sleep(3000);
      //  new UsersPage(web).isLoaded();
    }

    public void clickCancel() {
        web.click(By.cssSelector(".cancel.mls"));
    }

    public void clickGeneratePasswordCheckbox(boolean desiredState) {
        WebElement generatePassCheckbox = web.findElement(By.cssSelector(".automat-pass"));
        while (desiredState != generatePassCheckbox.isSelected()) {
            generatePassCheckbox.click();
        }
    }

    public void clickDisableUserCheckbox(boolean desiredState) {
        WebElement disableUser = web.findElement(By.name("_cm.common.disabled"));
        while (desiredState != disableUser.isSelected()) {
            disableUser.click();
        }
    }

    public boolean isPasswordTextboxVisible() {
        By locator = By.name("password");
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public boolean isApplicationCheckboxVisible(String application) {
        By locator = By.name("_cm.view.access." + application);
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public void setApplicationAccessCheckboxState(String application, boolean enabled) {
        WebElement locator = web.findElement(By.name("_cm.view.access." + application));
        web.scrollToElement(locator);
        if (isApplicationCheckboxVisible(application)) {
            if (enabled) {
                new Checkbox(this, By.name("_cm.view.access." + application)).select();
            } else {
                new Checkbox(this, By.name("_cm.view.access." + application)).deselect();
            }
        }
        else {
            throw new RuntimeException("Frame Grabber checkbox not exist on user details page");
        }

        clickSave();
    }
}