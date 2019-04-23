package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.DojoDateTextBox;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.page.controls.Select;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 05.07.12 20:14
 */
public class AddTeamTemplatePopUpWindow extends AbstractPopUpWindow {
    public class RoleItem
    {
        private String roleId;
        private String roleName;
        private DateTime date;
        private boolean includeSubfolders;
        WebElement container;

        public RoleItem() {}

        public RoleItem(WebElement container, String roleId, String roleName, DateTime date, boolean includeSubfolders) {
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

            //container.findElement(By.cssSelector("[data-role=remove-role]")).click();
            if(web.isElementPresent(By.xpath("//div[contains(@ng-click,'onRemoveRole')]")))
                container.findElement(By.xpath("//div[contains(@ng-click,'onRemoveRole')]")).click();
            else
                container.findElement(By.cssSelector("[data-role=remove-role]")).click();
        }
    }

    //public DojoCombo expirationDate;
    public Edit expirationDate;

    public Edit userNameField;

    public Select role;


    public AddTeamTemplatePopUpWindow(Page parentPage) {
        super(parentPage);
//        expirationDate = new DojoCombo(parentPage, By.cssSelector(".expiration"));
//        userNameField = new Edit(parentPage, By.cssSelector(".suggestor .dijitInputContainer > input:first-child"));
        expirationDate = new Edit(parentPage, By.cssSelector(".ng-valid-date"));
        userNameField = new Edit(parentPage, By.xpath("//input[contains(@placeholder,'Start typing')]"));
        //role = new Select(web.findElement(By.cssSelector("\".angular-ui-select.ui-input.select2-offscreen\"")));
        role = new Select(parentPage, By.cssSelector(".angular-ui-select.ui-input.select2-offscreen"));
    }



    public void selectRole(String roleName) {

        //role.selectByVisibleText(roleName);

        role.select(roleName);
    }

    public void clickAddRole() {
        //web.findElement(generateLocator("[data-role='add-role']")).click();
       // web.findElement(By.xpath("//button[contains(.,'Add Role')]")).click();
        WebElement addRole = web.findElement(By.xpath("//button[contains(.,'Add Role')]"));
        if(addRole.isEnabled()){
            addRole.click();
        }
    }

    public void clickOK() {
        //web.findElement(generateLocator("[data-role='add-role']")).click();
        // web.findElement(By.xpath("//button[contains(.,'Add Role')]")).click();
        WebElement addRole = web.findElement(By.xpath("//button[contains(.,'OK')]"));
        if(addRole.isEnabled()){
            addRole.click();
        }
    }


    public void setName(String name) {
        userNameField.type(name + Keys.RETURN, 1000);
        //userNameField.setValue(name);
        web.sleep(1000);
    }

    public void startTypeName(String name) {
        //web.findElement(By.xpath("//input[@name='autocomplete']/preceding-sibling::input")).sendKeys(name);
        web.findElement(By.xpath("//input[contains(@placeholder,'Start typing')]")).sendKeys(name);
        //web.waitUntilElementAppearVisible(By.className("dijitComboBoxMenuPopup"));
        web.waitUntilElementAppearVisible(By.cssSelector(".suggestion-item.ng-scope.selected"));
    }

    public void toggleFolder(String path) {
        path = normalizePath(path);
        if (path.isEmpty()) return;
        String[] parts;
//        WebElement currentNode = web.findElement(By.cssSelector(".tree_head"));
        WebElement currentNode = web.findElement(By.cssSelector(".folder-tree-item"));
        do {
            parts = path.split("/", 2);
           // String locator = String.format("ul/li[div//a[.='%s']]", parts[0]);
            String locator = String.format("//span[contains(.,'%s')]", parts[0]);
            currentNode = currentNode.findElement(By.xpath(locator));
            if (parts.length == 2) {
                //Commenting this code as the folders are already expanded by default + also there is no clear distinction to realise if a folder has been expanded or not. Earlier in the class it used to append -Active if expanded
//                if (!currentNode.getAttribute("class").contains("active"))
//                    currentNode.findElement(By.className("arrow")).click();

                //Alternate code if required is written below--
                String arrowlocator = String.format("//span[contains(.,'%s')]/preceding-sibling::span[contains(@ng-if,'$ctrl.hasChilds()')]", parts[0]);
                WebElement TempNode = currentNode.findElement(By.xpath(arrowlocator));
                if (TempNode.getAttribute("class").contains("trigon-dark-right"))
                    TempNode.click();
                //End of Alternate code

                path = parts[1];
            } else {
               // currentNode.findElement(By.xpath("div//a")).click();
                currentNode.click();
            }
        } while (parts.length == 2);
    }

    public boolean isFolderCheckBoxSelected(String path) {
        path = normalizePath(path);
        if (path.isEmpty()) return false;
        String[] parts;
        //WebElement currentNode = web.findElement(By.cssSelector(".tree_head"));
        WebElement currentNode = web.findElement(By.cssSelector(".folder-tree-item"));
        WebElement currentFolderCheckBoxNode;
        try {
            do {
                parts = path.split("/", 2);
                String locator = String.format("ul/li[div//a[.='%s']]", parts[0]);
                currentNode = currentNode.findElement(By.xpath(locator));
                String locatorCheckBox = String.format("//ul/li[div//a[.='%s']]//input[@type='checkbox']", parts[0]);
                currentFolderCheckBoxNode = web.findElement(By.xpath(locatorCheckBox));
                if (parts.length == 2) {
                    if (!currentNode.getAttribute("class").contains("active"))
                        currentNode.findElement(By.className("arrow")).click();
                    path = parts[1];
                }
            } while (parts.length == 2);
            return currentFolderCheckBoxNode.isSelected();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("There is no selecting checkbox on team popup for folder " + path);
        }
    }

    public boolean isFolderCheckBoxEditable(String path) {
        path = normalizePath(path);
        if (path.isEmpty()) return false;
        String[] parts;
        WebElement currentNode = web.findElement(By.cssSelector(".tree_head"));
        WebElement currentFolderCheckBoxNode;
        try {
            do {
                parts = path.split("/", 2);
                String locator = String.format("ul/li[div//a[.='%s']]", parts[0]);
                currentNode = currentNode.findElement(By.xpath(locator));
                String locatorCheckBox = String.format("//ul/li[div//a[.='%s']]//input[@type='checkbox']", parts[0]);
                currentFolderCheckBoxNode = web.findElement(By.xpath(locatorCheckBox));
                if (parts.length == 2) {
                    if (!currentNode.getAttribute("class").contains("active"))
                        currentNode.findElement(By.className("arrow")).click();
                    path = parts[1];
                }
            } while (parts.length == 2);
            return currentFolderCheckBoxNode.isEnabled();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("There is no selecting checkbox on team popup for folder " + path);
        }
    }

    public String getExpirationDate() {
        if (web.isElementPresent(By.cssSelector(".role-item > div + div + div"))){
        return web.findElement(By.cssSelector(".role-item > div + div + div")).getText().replaceAll("^.*:", "").trim();
//        if (web.isElementPresent(By.xpath("//span[contains(.,'Expiry')]/following-sibling::*"))){
//            return web.findElement(By.xpath("//span[contains(.,'Expiry')]/following-sibling::*")).getText();
        }else{
            return "";
        }
    }

    public void setExpirationDate(String date) {
        new DojoDateTextBox(parentPage, generateLocator(".date")).setDisplayedValue(date);

    }

    public void setExpirationDateInPopup(String date) {
        web.findElement(By.cssSelector(".ng-valid-date")).sendKeys(date);

    }



    public DateTime getExpirationDateByRoleIdOrRoleName(String roleId,String roleName) {
        for (RoleItem roleItem : getRoleItems()) {
            if (roleItem.getRoleId()!=null && roleItem.getRoleId().equals(roleId)||roleItem.getRoleName().equals(roleName)) {
                if(roleItem.getDate()!=null){
                    return  roleItem.getDate();
                }
            }
        }
        return null;
    }


    public List<RoleItem> getRoleItems() {
        List<RoleItem> roleItems = new ArrayList<>();
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
            roleItems.add(new RoleItem(roleItemElement, roleId, roleName, date, includeSubfolders));
        }
        return roleItems;
    }

    public RoleItem getRoleItemByIdOrName(String roleId,String name) {
        if(getRoleItems().isEmpty()){
            return null;
        }

        for (RoleItem roleItem : getRoleItems()) {
            if(roleItem.getRoleId()!=null && roleItem.getRoleId().equals(roleId) || roleItem.getRoleName().equals(name)) {
                    return roleItem;
                }
        }
        return null;
    }

    public String getNameInTree() {
        //return web.findElement(By.cssSelector(".valign-top.fsname")).getText().trim();
        return web.findElement(By.xpath("//div[contains(@class,'tree-item-title')]/span[contains(@class,'item-name')]")).getText().trim();
    }

    public int getAutoCompleteItemsCount() {
       // return web.findElements(By.cssSelector("[data-dojo-type='adbank.shared.AutoSuggestItem']")).size();
        return web.findElements(By.xpath("//tags-input/*//li")).size();
    }

    public void clickRoleCheckBox() {
        web.findElement(getRoleCheckBoxLocatorByCss()).click();
    }

    public DojoCombo getExpirationDateByEnableState(boolean isEnable) {
        String locator;
        if (isEnable) {
            locator = "//div[contains(@class,'expiration') and contains(@class,'Disabled')]";
        }   else {
            locator = "//div[contains(@class,'mtxs')]//input[@type='checkbox' and not(@disabled)]/ancestor::div[2]/following-sibling::div//div[contains(@class,'expiration date')]";
        }
        return new DojoCombo(parentPage, By.xpath(locator));
    }

    public void clickAddRoleButton() {
        WebElement AddRolelocator = web.findElement(By.cssSelector("div.ptxs:nth-child(4) > button:nth-child(1)"));
       if(AddRolelocator.isEnabled())
       AddRolelocator.click();
    }

    private By getRoleCheckBoxLocatorByCss() {
        return By.cssSelector(".size1of5.unit.ptxs>input[type='checkbox']");
    }


}