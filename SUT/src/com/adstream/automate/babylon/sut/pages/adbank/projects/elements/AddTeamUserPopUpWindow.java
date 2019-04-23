package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 26.06.12 9:04
 */
public class AddTeamUserPopUpWindow extends TeamUserPermissionsPopUpWindow {
    public org.openqa.selenium.support.ui.Select selectlist;
    public AddTeamUserPopUpWindow(Page parentPage) {
        super(parentPage);
    }

    public boolean isUserAvailableForSelecting(String name) {
        web.sleep(1000);
        //String locator = String.format("//div[contains(@class, 'dijitMenuItem') and descendant::span[contains(text(), '%s')]]", name);
        //String locator = String.format("//div[contains(@class, 'autocomplete') and descendant::span[contains(text(), '%s')]]", name);
        String locator = String.format("//div[contains(@class,'autocomplete')]//span[contains(.,'%s')]", name);
        return web.isElementPresent(By.xpath(locator));
    }

    public boolean isUserLookUpResultsContainsText(String userEmail) {
        //String locator = String.format("//*[contains(@class,'dijitComboBoxMenuPopup')]//*[contains(@class,'dijitMenuItem')]//span[contains(normalize-space(.),'%s')]", userEmail);
        String locator = String.format("//div[contains(@class,'autocomplete')]//span[contains(.,'%s')]", userEmail);
        return web.isElementPresent(By.xpath(locator));
    }

    public byte[] getUserLogoForSelecting(String name) {
        //This xpath needs to change for angular changes. As of now its broken--no logo visible --something like this --//div[contains(@class,'autocomplete')]//span[contains(.,'%s')]//img
       // String locator = String.format("//div[contains(@class, 'dijitMenuItem') and descendant::span[contains(text(), '%s')]]//img", name);
        String locator = String.format("//div[contains(@class,'autocomplete')]//div[contains(.,'%s')]//img", name);
        String src = web.findElement(By.xpath(locator)).getAttribute("src");
        BasePage basePage = new BasePage(web);
        return basePage.getDataByUrl(src);
    }

    public boolean isSelectedUser(User user) {
        return web.findElement(getUserListItemLocatorByXpath(user)).isSelected();
    }

    public List<String> getAvailableTeams() {
        //return new DojoCombo(parentPage, By.cssSelector("[data-role='teams-selector'] .suggestor")).getDisplayedValues();
        Edit templatenames = new Edit(parentPage, By.cssSelector(".autocomplete.ng-scope"));
        String tnames =  templatenames.getText();
        List<String> myList = new ArrayList<String>(Arrays.asList(tnames.split("\n")));
        return myList;
    }

    public void clickAddRole() {
        //web.findElement(generateLocator("[data-role='add-role']")).click();
        web.findElement(By.xpath("//button[contains(.,'Add Role')]")).click();
    }

    private By getUserListItemLocatorByXpath (User user) {
        String locator = String.format("//a[contains(@id,'common_trimmedBox') and contains(@title,'%s')]/ancestor::div[6]",user.getFirstName());
        return By.xpath(locator);
    }

    public boolean isFolderExistsonTeamUserPermissionPopup(String path) {
        path = normalizePath(path);
        if (path.isEmpty()) return false;
        String[] parts;
        WebElement currentNode = web.findElement(By.cssSelector(".folder-tree-item"));
        try {
            do {
                turnImplicitlyWaitOff();
                parts = path.split("/", 2);
               String locator = String.format("//span[contains(.,'%s')]", parts[0]);
                currentNode = currentNode.findElement(By.xpath(locator));
                if (parts.length == 2) {
                    String arrowlocator = String.format("//span[contains(.,'%s')]/preceding-sibling::span[contains(@class,'spriteicon')]", parts[0]);
                    WebElement TempNode = currentNode.findElement(By.xpath(arrowlocator));
                    if (TempNode.getAttribute("class").contains("trigon-dark-right"))
                        TempNode.click();
                    web.sleep(1000);
                    path = parts[1];
                }
            } while (parts.length == 2);
            turnImplicitlyWaitOn();
        } catch (NoSuchElementException e) {
            e.printStackTrace();
            turnImplicitlyWaitOn();
            return false;
        }
        return true;
    }

    public List<String> getRolesListAddUserPopup() {

       // return role.getValues();
        selectlist = new org.openqa.selenium.support.ui.Select(web.findElement(By.cssSelector(".angular-ui-select.ui-input.select2-offscreen")));
        List<String> roles = new ArrayList<String>();
        List<WebElement> rolelists = selectlist.getOptions();
        for(WebElement options:rolelists)
        {
            roles.add(options.getText());
        }
        return roles;

    }

}