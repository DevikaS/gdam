package com.adstream.automate.babylon.sut.pages.admin.roles;

import com.adstream.automate.babylon.JsonObjects.Role;
import com.adstream.automate.babylon.sut.pages.admin.roles.elements.CreateNewRolePopUpWindow;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 19.02.13 14:26
 */
public class GlobalAdminRolesPage extends RolesPage {
    public Edit roleName;
    public Button save;
    public DojoCombo advertiser;

    private By businessUnitLocator = By.cssSelector(".select2-chosen");
    private By businessUnitsearchLocator = By.cssSelector("[ng-model=\"vm.searchedBusinessUnit\"]");
    private By selectBusinessUnit = By.xpath("//ul[@id='select2-results-2']/li");
    private By roleTypeLocator = By.xpath("//*[@id='s2id_roleType']/a");
    private By selectRoleType = By.xpath("//ul[@id='select2-results-3']/li");
    private By saveRole = By.cssSelector("aside.size1of4.unit.roles_left button.secondary");
    private By editRoleName = By.xpath("//input[@ng-model='vm.editedRoleName']");

    public GlobalAdminRolesPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void init() {
        super.init();
   // NGN-14650     roleName = new Edit(this, By.name("roleName"));
        roleName = new Edit(this, By.id("roleName"));
        save = new Button(this, By.className("save"));
        advertiser = new DojoCombo(this, By.cssSelector(".advertizer"));
    }

    @Override
    public void load() {
     //NGN-14650  web.waitUntilElementAppearVisible(By.cssSelector("#roles_list_full"));
     //NGN-14650  web.waitUntilElementAppearVisible(By.cssSelector(".permissions_list"));
        web.waitUntilElementAppearVisible(By.cssSelector(".mls.mbs"));
        web.waitUntilElementAppearVisible(By.xpath("//a[contains(.,'agency.admin')]"));
    }

    @Override
    public void isLoaded() throws Error {
    //NGN-14650    assertTrue(web.isElementPresent(By.cssSelector("#roles_list_full")));
    //NGN-14650    assertTrue(web.isElementPresent(By.cssSelector(".permissions_list")));
        web.waitUntilElementAppearVisible(By.cssSelector(".mls.mbs"));
    }

    public String getOrganizationDropdownValue() {
        return web.findElement(By.name("advertiser")).getAttribute("value").trim();
    }

    public List<String> getVisibleRoles() {
   // NGN-14650     return web.findElementsToStrings(By.cssSelector("div[id=roles_list_full] a[href^='#roles']"));
        return web.findElementsToStrings(By.cssSelector("ul[class='mls mbs'] li[class='pbs ng-scope'] a"));
    }

    // global roles, library roles, project roles
    public List<String> getVisibleRoles(String groupName) {
        // NGN-14650   String locator = String.format("//span[text()='%s']/../following-sibling::ul[1]//a", groupName);
        // NGN-14650  return web.findElementsToStrings(By.xpath(locator));

        int rolePicker = 0;
        if(groupName.contains(Role.GROUP_GLOBAL))
            rolePicker = 1;
        if(groupName.contains(Role.GROUP_LIBRARY))
            rolePicker = 2;
        if(groupName.contains(Role.GROUP_PROJECT))
            rolePicker = 3;

        return web.findElementsToStrings(By.xpath("//div[@class='user_roles phl ptm']/ul[" + rolePicker + "]//a"));

     }

    // 14650
    public boolean isSaveButtonInCreateNewRoleSectionEnabled() {
        return web.findElement(By.cssSelector("section.mbs button.button.secondary")).isEnabled();
    }

    public List<String> getVisiblePermissions() {
        return web.findElementsToStrings(By.cssSelector("[type='checkbox']"), "name");
    }

    public List<String> getSelectedPermissions() {
        By locator = By.cssSelector("[type='checkbox']:checked");
        return web.isElementPresent(locator) ? web.findElementsToStrings(locator, "name") : new ArrayList<String>();
    }

    public List<String> getUnselectedPermissions() {
        By locator = By.cssSelector("[type='checkbox']:not(:checked)");
        return web.isElementPresent(locator) ? web.findElementsToStrings(locator, "name") : new ArrayList<String>();
    }

    public RolesPage changeRoleName(String newName) {
       //NGN-14650 roleName.type(newName);
        web.waitUntilElementAppearVisible(editRoleName);
        web.findElement(editRoleName).sendKeys(newName);
        return this;
    }

    public void clearPermissions() {
        for (WebElement checkbox : web.findElements(By.cssSelector("[type='checkbox']:checked"))) {
            web.clickThroughJavascript(checkbox);
        }
    }

    // NGN-17777
    public void enableCanShareToSection(boolean enabled) {
        By elementLocator = By.xpath("//span[contains(@ng-switch-when,'"+enabled+"')]");
        web.waitUntilElementAppearVisible(elementLocator).click();
    }

    public void enableCanShareToSectionifNotalreadyDone(boolean enabled) {
        By elementLocator = By.xpath("//span[contains(@ng-switch-when,'"+enabled+"')]");
         if(web.isElementVisible(elementLocator))web.click(elementLocator);
    }

    public boolean isCanShareToSectionEnabled() {
        return web.isElementVisible(By.xpath("//span[contains(.,'Can share to')]"));
    }

    public RolesPage selectPermissions(String[] permissions) {
        clearPermissions();
        for (String permission : permissions) {
            if (permission == null) {
                continue;
            }
            if (permission.contains(",")) {
                for (String dopPermission : permission.split(",")) {
                    web.clickThroughJavascript(By.name(dopPermission));
                }
            } else {
                web.clickThroughJavascript(By.name(permission));
            }
        }
        return this;
    }

    public void selectPermission(String permission) {
        web.waitUntilElementAppearVisible(By.name(permission));
        web.clickThroughJavascript(By.name(permission));
    }
    public RolesPage selectPermissionsInCanShareToSection(String[] permissions) {
        for (String permission : permissions) {
                WebElement elementLocator = getDriver().findElement(By.xpath("//input[@name='" + permission+ "']"));
                if (!elementLocator.isSelected())
                    elementLocator.click();
            }
        return this;
    }

    public CreateNewRolePopUpWindow clickCreateNewRole() {
        web.waitUntilElementAppearVisible(By.cssSelector(".user_roles .create"));
        web.click(By.cssSelector(".user_roles .create"));
        return new CreateNewRolePopUpWindow(this);
    }

    // For NGN-14650
    public void clickCreateNewRole_new() {
        //..    web.waitUntilElementAppearVisible(By.cssSelector(".user_roles .create"));
        //..    web.click(By.cssSelector(".user_roles .create"));
        web.waitUntilElementAppearVisible(By.xpath("//span[contains(.,'Create new Role')]"));
        web.click(By.xpath("//span[contains(.,'Create new Role')]"));
    }



    public void selectAdvertizer(String advertiserName) {
        // Angular Fix: NGN-14650
        web.findElement(businessUnitLocator).click();
        List<WebElement> allBusinessUnits = web.findElements(selectBusinessUnit);
        for (int i = 0; i < allBusinessUnits.size(); i++) {
            if (allBusinessUnits.get(i).getText().contentEquals(advertiserName)) {
                allBusinessUnits.get(i).click();
                break;
            }
        }
    }

    public void searchAdvertiser(String advertiserName) {
        web.findElement(businessUnitsearchLocator).clear();
        web.findElement(businessUnitsearchLocator).sendKeys(advertiserName);
        }


    public boolean isSaveButtonInCreateNewRoleSectionVisible() {
        return web.isElementVisible(By.cssSelector("section.mbs button.button.secondary"));
    }



    public boolean isCopyButtonInCreateNewRoleSectionVisible() {
        return web.isElementVisible(By.cssSelector("button.mlm.copy"));
    }

    public boolean isCancelButtonInCreateNewRoleSectionVisible() {
        return web.isElementVisible(By.xpath("//article[@ng-show='vm.showCreateNewRole']//span[@class='button']"));
    }

    public void clickSaveButtonInCreateNewRoleSectionVisible() {
        if(isSaveButtonInCreateNewRoleSectionVisible())
                web.findElement(By.cssSelector("section.mbs button.button.secondary")).click();
    }

    public void clickCancelButtonInCreateNewRoleSectionVisible() {
        if(isCancelButtonInCreateNewRoleSectionVisible())
            web.findElement(By.xpath("//article[@ng-show='vm.showCreateNewRole']//span[@class='button']")).click();
    }

    public boolean isRoleNameFieldVisible() {
        return web.isElementPresent(By.cssSelector("#roleName"));
    }

    public boolean isRoleNameEditable() {
        return web.isElementPresent(By.name("roleName")) && !roleName.getAttribute("readonly").equals("true");
    }

    public String getCurrentRoleName() {
        return roleName.getValue();
    }

    // NGN-14650
    public String getCurrentRoleName_new() {
        web.isElementPresent(editRoleName);
        return web.findElement(editRoleName).getAttribute("value");
    }

    // NGN-14650
    public String getCurrentRoleNamePlaceHolder() {
        web.isElementPresent(editRoleName);
        return web.findElement(editRoleName).getAttribute("placeholder");
    }

    // For: NGN-14650
    public void setRoleName(String name){
        roleName.type(name);
    }

    public boolean isAgencyRolePermissionHeaderVisible()
    {
        return web.isElementPresent(By.cssSelector("header.block_title.mbm.clearfix>div.unit>p"));
    }

    // NGN-14650
    public String getAgencyRolePermissionHeader()
    {
        web.waitUntilElementAppearVisible(By.cssSelector("header.block_title.mbm.clearfix>div.unit>p"));
        return web.findElement(By.cssSelector("header.block_title.mbm.clearfix>div.unit>p")).getText();
    }

    // For: NGN-14650
    public void setRoleType(String type) {
        web.findElement(roleTypeLocator).click();
        List<WebElement> allRoles = web.findElements(selectRoleType);
        for (int i = 0; i < allRoles.size(); i++) {
            if (allRoles.get(i).getText().contains(type)) {
                allRoles.get(i).click();
                break;
            }
        }
    }

    public void clickAction(){
        web.click(saveRole);
    }

    // For: NGN-14650
    public boolean isRoleTypesVisible(String type) {
        boolean result = false;
        web.findElement(roleTypeLocator).click();
        List<WebElement> allRoles = web.findElements(selectRoleType);
        for (int i = 0; i < allRoles.size(); i++) {
            if (allRoles.get(i).getText().contains(type)) {
                result=true;
                web.findElement(roleTypeLocator).click();
                break;
            }
        }
        return result;
    }
}
