package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.DojoCombo;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 02.07.12 18:08
 */
public class TeamUserPermissionsPopUpWindow extends AddTeamTemplatePopUpWindow {
   public DojoCombo role;


   // public Select role2;
    public Button save;
    public Button addrole;
    public org.openqa.selenium.support.ui.Select selectlist;

    public TeamUserPermissionsPopUpWindow(Page parentPage) {
        super(parentPage);
        role = new DojoCombo(parentPage, By.cssSelector(".select2-choice"));
       // role = new Select(parentPage, By.cssSelector(".select2-choice.select2-default"));
        //role = new Select(parentPage, By.cssSelector(".angular-ui-select.ui-input.select2-offscreen"));

        if(web.isElementPresent(By.cssSelector("[ng-click=\"onSave()\"]")))
            save = new Button(parentPage, web.findElement(By.cssSelector("[ng-click=\"onSave()\"]")));
        else if(web.isElementPresent(By.cssSelector("[ng-click='modalCtrl.ok()']")))
            save = new Button(parentPage, web.findElement(By.cssSelector("[ng-click='modalCtrl.ok()']")));

        if(web.isElementPresent(By.xpath("//*[@ng-click='modalCtrl.addRoleToFolder()']")))
            addrole = new Button(parentPage, By.xpath("//*[@ng-click='modalCtrl.addRoleToFolder()']"));
        else if(web.isElementPresent(By.xpath("//*[@ng-click='onAddRole()']")))
            addrole = new Button(parentPage, By.xpath("//*[@ng-click='onAddRole()']"));
        //WebElement selectdd = web.findElement(By.cssSelector(".select2-choice.select2-default"));


    }

    public void startTypeName(String name) {
        web.findElement(By.xpath("//input[@name='autocomplete']/preceding-sibling::input")).sendKeys(name);
        web.waitUntilElementAppearVisible(By.className("dijitComboBoxMenuPopup"));
    }

    public class RoleItemForManagePermissionPopup
    {
        private String roleId;
        private String roleName;
        private DateTime date;
        private boolean includeSubfolders;
        WebElement container;

        public RoleItemForManagePermissionPopup() {}

        public RoleItemForManagePermissionPopup(WebElement container, String roleId, String roleName, DateTime date, boolean includeSubfolders) {
            this.container = container;
            this.roleId = roleId;
            this.roleName = roleName;
            this.date = date;
            this.includeSubfolders = includeSubfolders;
        }

        public String getRoleId() {
            return roleId;
        }

        public void setRoleId(String roleId) {
            this.roleId = roleId;
        }

        public String getRoleName() {
            return roleName;
        }

        public void setRoleName(String roleName) {
            this.roleName = roleName;
        }

        public DateTime getDate() {
            return date;
        }

        public void setDate(DateTime date) {
            this.date = date;
        }

        public boolean isIncludeSubfolders() {
            return includeSubfolders;
        }

        public void setIncludeSubfolders(boolean includeSubfolders) {
            this.includeSubfolders = includeSubfolders;
        }

        public void clickRemove(){

            container.findElement(By.xpath(".//*[contains(@class,'remove')]")).click();

        }


    }

    public RoleItemForManagePermissionPopup getRoleItemByIdOrNameForManagePermissionPopup(String roleId,String name) {
        if(getRoleItems().isEmpty()){
            return null;
        }

        for (RoleItemForManagePermissionPopup roleItem : getRoleItemsonManagepermissionpopup()) {
            if(roleItem.getRoleId()!=null && roleItem.getRoleId().equals(roleId) || roleItem.getRoleName().equals(name)) {
                return roleItem;
            }
        }
        return null;
    }

    public boolean IsRemoveIconForRoleDisplayed() {
            boolean result=true;
            try { web.findElement(By.cssSelector("[data-role=remove-role]")); }
            catch (Exception e)
            { result = false;}
            return result;
        }

    public List<RoleItemForManagePermissionPopup> getRoleItemsonManagepermissionpopup() {
        List<RoleItemForManagePermissionPopup> roleItems = new ArrayList<>();
        List<WebElement> roleItemElements = web.findElements(By.className("role-item"));
        for (WebElement roleItemElement : roleItemElements) {
            List<WebElement> roleItemElementLines = roleItemElement.findElements(By.tagName("div"));
            String roleId = null, roleName = null;
            DateTime date = null;
            boolean includeSubfolders = false;
            for (WebElement line : roleItemElementLines) {
                if (line.getAttribute("data-role-id") != null) {
                    roleId = line.getAttribute("data-role-id");
                    if (roleId.contains("||")) {
                        roleId = roleId.substring(0, roleId.indexOf("||"));
                    }
                } else if (line.getAttribute("class") != null && line.getAttribute("class").contains("bold")) {
                    roleName = line.getText();
                } else if (line.getText().startsWith("Expiry date")) {
                    String dateStr = line.getText();
                    dateStr = dateStr.substring(dateStr.indexOf(":")+1).trim();
                    date = DateTime.parse(dateStr, DateTimeFormat.forPattern("M/d/yy"));
                } else if (line.getText().trim().matches("Include subfolders|Inherited")) {
                    includeSubfolders = true;
                }
            }
            roleItems.add(new RoleItemForManagePermissionPopup(roleItemElement, roleId, roleName, date, includeSubfolders));
        }
        return roleItems;
    }

    public void toggleFolder(String path) {
        path = normalizePath(path);
        if (path.isEmpty()) return;
        String[] parts;
        WebElement currentNode = web.findElement(By.cssSelector(".tree_head"));
        do {
            parts = path.split("/", 2);
            String locator = String.format("ul/li[div//a[.='%s']]", parts[0]);
            currentNode = currentNode.findElement(By.xpath(locator));
            if (parts.length == 2) {
                if (!currentNode.getAttribute("class").contains("active"))
                    currentNode.findElement(By.className("arrow")).click();
                path = parts[1];
            } else {
                currentNode.findElement(By.xpath("div//a")).click();
            }
        } while (parts.length == 2);
    }

    public List<String> getRolesList() {

//        return role.getValues();
        selectlist = new org.openqa.selenium.support.ui.Select(web.findElement(By.cssSelector(".angular-ui-select.select2-offscreen")));
        List<String> roles = new ArrayList<String>();
        List<WebElement> rolelists = selectlist.getOptions();
        for(WebElement options:rolelists)
        {
            roles.add(options.getText());
        }
        return roles;

    }

    public void selectRole(String roleName) {
        role.click();
        WebElement roles = web.findElement(By.xpath("//ul[@role='listbox']"));
        List<WebElement> rolesList=roles.findElements(By.tagName("li"));
        for (WebElement li : rolesList) {
            if (li.getText().equals(roleName)) {
                li.click();
                break;
            }
        }
//        role.selectByValue(roleName);
    }

    public boolean isRolePresentInList(String roleName) {
        int i = 0;
        role.click();

    WebElement roles = web.findElement(By.xpath("//*[@id='select2-drop']/ul"));
    List<WebElement> rolesList=roles.findElements(By.tagName("li"));
        for (WebElement li : rolesList) {
        if (li.getText().equals(roleName)) {
            i++;
        }
    }
    if(i==1)
        return true;
        else
            return false;

}

    public void toggleRolesList() {
        //web.click(By.cssSelector(".select_roles > .dijitArrowButton"));
        web.click(By.cssSelector(" .select2-arrow"));

    }

    public String getSelectedRole() {
        return web.findElement(By.cssSelector(".roles-content .bold")).getText();
      //  return web.findElement(By.cssSelector(".valign-middle.bold.ng-binding")).getText();

    }

    public List<String> getAvailableRolesOfuserInFolder()
    {
            List <String> list = new ArrayList<>();
       // if(web.isElementPresent(By.cssSelector(".roles-content .bold"))){
        if(web.isElementPresent(By.cssSelector(".valign-middle.bold.ng-binding")))
        {
            //for(WebElement listElement : web.findElements(By.cssSelector(".roles-content .bold"))){
            for(WebElement listElement : web.findElements(By.cssSelector(".valign-middle.bold.ng-binding")))
            {
                list.add(listElement.getText());
            }
            return list;
        }
        else if(web.isElementPresent(By.cssSelector(".roles-content .bold")))
        {
            for (WebElement listElement : web.findElements(By.cssSelector(".roles-content .bold"))) {
                list.add(listElement.getText());
            }
            return list;
        }

        else
        {
            return list;
        }

    }

    //leaving this untouched for now--will need to change if impacted
    public DojoCombo getSelectedRoleByEnableState(boolean isEnabled) {
        String locator;
        if (isEnabled) {
            locator = "//div[contains(@class,'select_roles') and @aria-disabled='true']";
        } else {
            locator = "//div[contains(@class,'mtxs')]//input[@type='checkbox' and not(@disabled)]/ancestor::div[1]/following-sibling::div/div[contains(@class,'select_roles')]";
        }
        return new DojoCombo(parentPage, By.xpath(locator));
    }

    public boolean isRoleCheckBoxEditable(boolean isEditable) {
        return web.findElement(getRoleCheckBoxLocatorByEditableState(isEditable)).isEnabled();
    }

    public boolean isIncludeChildrenCheckBoxSelected() {
        return web.findElement(getIncludeChildrenCheckBoxLocatorByName()).isSelected();
    }

    public boolean isRoleCheckBoxSelected(boolean isEditable) {
        return web.findElement(getRoleCheckBoxLocatorByEditableState(isEditable)).isSelected();
    }

    public boolean isRoleCheckBoxChecked() {
        return web.findElement(By.cssSelector(".mtxs .unit > input")).isSelected();
    }

    public boolean isRootFolderSelected() {
        return web.findElement(By.cssSelector(".tree_head")).getAttribute("class").contains("selected");
    }

    public void selectIncludeChildrenCheckBoxForFolder() {
        web.findElement(getIncludeChildrenCheckBoxLocatorByName()).click();
    }

    private By getIncludeChildrenCheckBoxLocatorByName() {
        return By.name("inheritance");
    }

    private By getRoleCheckBoxLocatorByEditableState(boolean isEditable) {
        By enabledLocator = By.cssSelector(".mtxs .unit > input:not([disabled])");
        By disabledLocator = By.cssSelector(".mtxs .unit > input[disabled='\"disabled\"']");
        return isEditable ? enabledLocator : disabledLocator;
    }
}
