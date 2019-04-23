package com.adstream.automate.babylon.sut.pages.admin.roles;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Checkbox;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: ruslan.semerenko
 * Date: 05.06.12 11:18
 */
public class RolesPage extends BaseAdminPage {

    private Checkbox showHidden;
    private Checkbox hideRole;

    public RolesPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
        showHidden = new Checkbox(this, By.cssSelector("[data-role='showHidden']"));
        hideRole = new Checkbox(this, By.cssSelector("[data-role='hideRole']"));
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.cssSelector(".rolesList"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.cssSelector(".rolesList")));
    }

    public boolean isPermissionEnabled(String permission) {
        return web.findElement(By.name(permission)).isEnabled();
    }

    public boolean isPermissionSelected(String permission) {
        return web.findElement(By.name(permission)).isSelected();
    }

    public List<String> getVisibleRoles() {
        List<String> roles = web.findElementsToStrings(By.xpath("//div[@data-dojo-type='admin.agencyRoles.roleListItem']"));
        for (int i = 0; i < roles.size(); i++) {
            roles.set(i, roles.get(i).substring(1));
        }
        return roles;
    }

    public RolesPage clickSaveButton() {
        web.click(By.linkText("Save"));
        return this;
    }

    public boolean isCancelLinkVisible() {
        return web.isElementVisible(By.cssSelector(".cancel.mrm"));
    }

    public boolean isCancelLinkInvisible() {
        return web.isElementPresent(By.cssSelector(".cancel.mrm.none"));
    }

    public boolean isUserPresent(User user) {
        List<WebElement> userNames  = web.findElements(By.cssSelector("span.p"));
        for(WebElement name: userNames) {
            if (name.getText().equalsIgnoreCase(user.getFullName()))
                return true;
        }
        return false;
    }

    public void clickUserLogo(User user) {
        String locator = String.format("//li[descendant::span[@class='p' and .='%s']]//img", user.getFullName());
        web.click(By.xpath(locator));
    }

    public boolean isAllPermissionCheckBoxStateDisabled() {
        if (!web.isElementPresent(By.cssSelector(".clearfix.size1of1.permissions_list_row input"))) return true; // Нет галочек, значит их низзя редактировать
        List<WebElement> allCheckBox = web.findElements(By.cssSelector(".clearfix.size1of1.permissions_list_row input"));
        for (WebElement checkBox: allCheckBox) {
            if (checkBox.getAttribute("disabled")==null  || !checkBox.getAttribute("disabled").equals("true")) return false;
        }
        return true;
    }

    public void clickRoleForAgencyUser(String roleName) {
        web.click(By.xpath(String.format("//div[@data-dojo-type='admin.agencyRoles.roleListItem' and contains(., '%s')]", roleName)));
    }

    public boolean isShowHidden() {
        return showHidden.isSelected();
    }

    public void setShowHidden(boolean showHidden) {
        this.showHidden.setSelected(showHidden);
    }

    public boolean isRoleHidden() {
        return hideRole.isSelected();
    }

    public void setHideRole(boolean hide) {
        hideRole.setSelected(hide);
    }

    public boolean isRoleOverviewSectionLoaded(){
        return web.isElementVisible(By.cssSelector("[data-role='hideRole']"));
    }

    public void clickRoleByRoleName(String roleName) {
        if(roleName.contains(".")) {
            roleName = roleName.replace(".", " ");
            roleName=roleName.substring(0, 1).toUpperCase() + roleName.substring(1);
        }
        web.click(By.xpath(String.format("//div[@data-dojo-type='admin.agencyRoles.roleListItem' and contains(., '%s')]", roleName)));
    }
}