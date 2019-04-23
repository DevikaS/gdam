package com.adstream.automate.babylon.sut.pages.admin.people;

import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 02.10.12
 * Time: 15:07
 */
public class AccountSettingPage extends BaseAdminPage<AccountSettingPage> {
    public AccountSettingPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.cssSelector("[data-dojo-type='admin.people.reset_password']"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(By.cssSelector(("[data-dojo-type='admin.people.reset_password']"))));
    }

    public String getPasswordQualityText() {
        return web.findElement(By.xpath("//*[contains(text(),'Your password must have')]")).getText().trim();
    }

    public void changeUsersPassword(String currentPassword, String newPassword, String confirmPassword) {
        setCurrentPassword(currentPassword);
        setNewPassword(newPassword);
        setConfirmNewPassword(confirmPassword);
        clickSave();
    }

    public void cancelChangingPassword(String currentPassword, String newPassword, String confirmPassword) {
        setCurrentPassword(currentPassword);
        setNewPassword(newPassword);
        setConfirmNewPassword(confirmPassword);
        clickCancel();
    }

    public void setCurrentPassword(String value) {
        new Edit(this, By.name("oldPassword")).typeWithInterval(value, 50);
    }

    public void setNewPassword(String value) {
        new Edit(this, By.name("password")).typeWithInterval(value, 50);
    }

    public void setConfirmNewPassword(String value) {
        new Edit(this, By.name("confirmation")).typeWithInterval(value, 50);
    }

    public void clickSave() {
        new Button(this, By.name("Save")).click();
    }

    public void clickCancel() {
        new Button(this, By.className("cancel")).click();
    }
}