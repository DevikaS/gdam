package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

import static com.thoughtworks.selenium.SeleneseTestBase.fail;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 10.07.12
 * Time: 15:39
 */
public class AddShareFolderForUserPopUpWindow extends PopUpWindow {
    public DojoCombo expirationDate;
    public DojoCombo autoCompleteName;
    public DojoCombo role;
    public DojoCombo addedRole;

    public AddShareFolderForUserPopUpWindow(Page parentPage) {
        super(parentPage);
        expirationDate = new DojoCombo(parentPage, getExpirationDateComboBoxByCss());
        autoCompleteName = new DojoCombo(parentPage, getUsersComboBoxByCss());
        role = new DojoCombo(parentPage, getRoleComboBoxByCss());
        addedRole = new DojoCombo(parentPage, getAddedRoleComboBoxByCss());
    }

     public DojoCombo getExistedUserRole(User user ) {
        String locator;
        if (user.getFirstName().equals("") || user.getFirstName() == null) {
            locator = String.format("//div[contains(@class, 'user_name_col') and descendant::span[normalize-space(.)='%s']]/following-sibling::div//div[contains(@class, 'select_roles')]", user.getEmail());
        } else {
            locator = String.format("//*[contains(text(), '%s')]/ancestor::node()[2]//div[contains(@class, 'select_roles')]", user.getFullName());
        }
        return new DojoCombo(parentPage, web.findElement(By.xpath(locator)));
    }

    public DojoCombo getExistedUserRolesByOneUser(User user, int index) {
        String locator = String.format("//*[contains(text(), '%s')]/ancestor::node()[2]//div[contains(@class,'select_roles')]", user.getFullName());
        return new DojoCombo(parentPage, web.findElements(By.xpath(locator)).get(index));
    }

    public DojoCombo getExistedExpiredDate(User user) {
        String locator;
        if (user.getFirstName().equals("") || user.getFirstName() == null) {
            locator = String.format("//div[contains(@class, 'user_name_col') and descendant::span[normalize-space(.)='%s']]/following-sibling::div[2]//div[contains(@class,'date')]", user.getEmail());
        } else {
            locator = String.format("//*[contains(text(), '%s')]/ancestor::node()[2]//div[contains(@class,'startdate date')]", user.getFullName());
        }
        return new DojoCombo(parentPage, web.findElement(By.xpath(locator)));
    }

    public DojoCombo getExistedExpiredDateByOneUser(User user, int index) {
        String locator = String.format("//*[contains(text(), '%s')]/ancestor::node()[2]//div[contains(@class,'startdate')]", user.getFullName());
        return new DojoCombo(parentPage, web.findElements(By.xpath(locator)).get(index));
    }

    public boolean isAccessToSubFolder(User user) {
        String locator;
        if (user.getFirstName().equals("") || user.getFirstName() == null) {
            locator = String.format("//div[contains(@class, 'user_name_col') and descendant::span[normalize-space(.)='%s']]/following-sibling::div[3]//input[@type='checkbox']", user.getEmail());
        } else {
            locator = String.format("//*[contains(text(), '%s')]/ancestor::node()[2]//input[@type='checkbox']", user.getFullName());
        }
        return web.findElement(By.xpath(locator)).isSelected();
    }

    public boolean isAccessToSubFolderByOneUser (User user, int index) {
        String locator = String.format("//*[contains(text(), '%s')]/ancestor::node()[2]//*[contains(@class, 'inheritance none-shadow')]", user.getFullName());
        return web.findElements(By.xpath(locator)).get(index).isSelected();
    }

    public WebElement getAccessToSubFolder (User user) {
        String locator;
        if (user.getFirstName().equals("")) {
            locator = String.format("//div[contains(@class, 'user_name_col') and descendant::span[.='%s']]/following-sibling::div[3]//input[@type='checkbox']", user.getEmail());
        } else {
            locator = String.format("//*[contains(text(), '%s')]/ancestor::node()[2]//input[@type='checkbox']", user.getFullName());
        }
        return  web.findElement(By.xpath(locator));
    }

    public void selectRoleForAllUsers(String roleName) {
        for (WebElement e : web.findElements(By.cssSelector(".visible .select_roles"))) {
            new DojoCombo(parentPage, e).selectByVisibleText(roleName);
        }
    }

    public boolean isAccessToSubFolderSelected() {
        WebElement elementAccess=web.findElement(getAccessToSubFoldersCheckBoxByCss());
        return elementAccess.isSelected();
    }

    public void selectAccessToSubFolder() {
        web.findElement(getAccessToSubFoldersCheckBoxByCss()).click();
    }

    public void typeUserToShare(String userName) {
        if (!userName.isEmpty()) {
            web.findElement(getUsersToShareFieldToByXpath()).click();
            web.findElement(getUsersToShareFieldToByXpath()).sendKeys(userName);
            waitForAutoCompletePopUp();
        }
    }

    public void clickAddMore() {
        web.findElement(getAddMoreButtonByCss()).click();
    }

    public List<String> getUserNames() {
        Common.sleep(1500);
        List<String> userNames = new ArrayList<>();
        if (web.isElementPresent(getUsersNameByCss())) {
            userNames = web.findElementsToStrings(getUsersNameByCss());
        }
        return userNames;
    }

    public List<String> getUserNamesOnUsersTab(String tabName) {
        Common.sleep(1500);
        turnOffImplicitWait();
        List<WebElement> elements;
        if (tabName.equals("Add users")) {
            elements = web.findElements(getUsersNameOnAddUsersTabLocator());
        }  else {
            elements = web.findElements(getUsersNameOnUsersAlreadyOnThiFolderTabLocator());
        }
        turnOnImplicitWait();
        List<String> userNames = new ArrayList<>();
        for (WebElement element : elements) {
            userNames.add(element.getText().replace("\n", " "));
        }
        return userNames;
    }

    public WebElement getLogo(int index) {
        List<WebElement> elements = web.findElements(getLogoByXpath());
        return elements.get(index);
    }

    public byte [] getLogoSize(int index) {
        List<WebElement> elements = web.findElements(getLogoByXpath());
        WebElement logo = elements.get(index);
        BasePage page = new BasePage(web);
        return page.getDataByUrl(logo.getAttribute("src"));
    }

    public boolean isSearchResultsContainsString(String text) {
        List<WebElement> elements = web.findElements(getSearchingResultByXpath());
        for(WebElement element : elements) {
            if(element.getText().toLowerCase().contains(text.toLowerCase()))
                return true;
        }
        return false;
    }

    public String getSearchResult(int index) {
        List<WebElement> elements = web.findElements(getSearchingResultByXpath());
        WebElement searchResult = elements.get(index);
        return searchResult.getText();
    }

    public String getSearchResultByTeamTemplate(int index) {
        List<WebElement> elements = web.findElements(getSearchingResultTeamTemplateLocatorByXpath());
        WebElement searchResult = elements.get(index);
        return searchResult.getText();
    }

    public String getTinyTextInAutoCompletePopUp(int index) {
        List<WebElement> elements = web.findElements(getTinyTextAutoCompletePopUpByCss());
        WebElement tinyText = elements.get(index);
        return tinyText.getText();
    }

    public List<String> getAddedRolesName() {
        turnOffImplicitWait();
        List<String> roleNames = new ArrayList<>();
        if (web.isElementPresent(getAddedRoleComboBoxByCss()))
            for (WebElement roleWidget : web.findElements(getAddedRoleComboBoxByCss()))
                roleNames.add(new DojoCombo(parentPage, roleWidget).getSelectedLabel());
        return roleNames;
    }

    public String getCountNextAddUsers() {
        WebElement element = web.findElement(getCountNextAddUsersTabByXpath());
        return element.getText();
    }

    public String getCountNextUsersAlreadyOnThisFolder() {
        WebElement element = web.findElement(getCountNextUsersAlreadyOnThisFolderTabByXpath());
        return element.getText();
    }

    public void deleteUsersFromAddUsersTab(User user) {
        String locator;
        if (user.getFirstName().equals("")) {
            locator = String.format("//div[contains(@class, 'user_name_col') and descendant::span[.='%s']]/following-sibling::div[4]//span[contains(@class,'icon-error del pointer')]", user.getEmail());
        } else {
            locator = String.format("//*[contains(text(), '%s')]/ancestor::node()[2]//*[contains(@class, 'del')]", user.getFullName());
        }
        web.findElement(By.xpath(locator)).click();
    }

    public int getNumberPageOnAddUsersTab() {
        List<WebElement> numberPages = web.findElements(getNumberPageOnAddUsersTabLocatorByCss());
        return numberPages.size();
    }

    public int getNumberPageOnUsersAlreadyOnThisFolderTab() {
        List<WebElement> numberPages = web.findElements(getNumberPageOnUsersAlreadyOnThisFolderLocatorByCss());
        return numberPages.size();
    }

    public int getCurrentPageOnUsersTab() {
        List<WebElement> elements = web.findElements(getCurrentPageLocatorByCss());
        for(WebElement element : elements) {
            if(element.isDisplayed())
                return Integer.valueOf(element.getText());
        }
        return 0;
    }

    public void goToPage(int numberPage) {
        WebElement pagerItem = web.findElement(getNumberPageLocatorByXPath(numberPage));
//        pagerItem.click();
        List<WebElement> elements = web.findElements(getNumberPageLocatorByXPath(numberPage));
        for(WebElement element : elements) {
            if(element.isDisplayed()) {
                element.click();
            }
        }
    }

    public void waitForAutoCompletePopUp() {
        WebElement popup = web.waitUntilElementAppear(getAutoCompletePopUpLocatorByCss());
        Common.sleep(2000);
        if (!popup.isDisplayed()) {
            fail("Autocomplete lookup doesn't work on Share window!!!");
        }
    }

    public void clickPaginationNavigationByName(String pageName) {
        List<WebElement> elements = pageName.equalsIgnoreCase("Next") ? web.findElements(getNextPageByCss()) : web.findElements(getPreviousPageByCss());
        for(WebElement element : elements) {
            if(element.isDisplayed()) {
                element.click();
            }
        }
    }

    private By getAutoCompletePopUpLocatorByCss() {
        return By.cssSelector(".dijitComboBoxMenu");
    }

    private By getNumberPageLocatorByXPath(int numberPage) {
        return By.xpath("//div[@class='pager-item' and .='"+ numberPage +"']");
    }

    private By getCurrentPageLocatorByCss() {
        return By.cssSelector(".pager-item.current");
    }

    private By getUsersNameOnAddUsersTabLocator() {
        return By.cssSelector("div[class^='users_list'] .user_name_col span");
    }

    private By getUsersNameOnUsersAlreadyOnThiFolderTabLocator() {
        return By.cssSelector("div[class$='mts users_list'] .user_name_col span");
    }

    private By getNumberPageOnAddUsersTabLocatorByCss() {
        return By.cssSelector("div[class^='size1of1 pts'] div[class*='pager-item']");
    }

    private By getNumberPageOnUsersAlreadyOnThisFolderLocatorByCss() {
        return By.cssSelector("div[class^='size1of1 unit pts'] div[class*='pager-item']");
    }

    private By getCountNextUsersAlreadyOnThisFolderTabByXpath() {
        return By.xpath("//li[contains(.,'Users already on this folder')]/span[contains(@id,'adbank_files_share_dialog_counter')]");
    }

    private By getCountNextAddUsersTabByXpath() {
        return By.xpath("//li[contains(.,'Add users')]/span[contains(@id,'adbank_files_share_dialog_counter')]");
    }

    private void turnOffImplicitWait() {
       web.manage().timeouts().implicitlyWait(0, TimeUnit.MILLISECONDS);
    }

    private void turnOnImplicitWait() {
        web.manage().timeouts().implicitlyWait(15 * 1000, TimeUnit.MILLISECONDS);
    }

    private By getTinyTextAutoCompletePopUpByCss() {
        return By.cssSelector(".tiny-text");
    }

/*    private By getSearchingResultByXpath() {
        return By.xpath("//div[@class='mbxs']//span[2]");
    }*/

    private By getSearchingResultByXpath() {
        return By.xpath("//span[@class='dijitComboBoxHighlightMatch']");
    }

    private By getSearchingResultTeamTemplateLocatorByXpath() {
        return By.xpath("//div[@class='mbxs']//span[1]");
    }

    private By getLogoByXpath() {
        return By.xpath("//*[contains(@class,'unit avatar small mrs')]//img");
    }

    private By getUsersComboBoxByCss() {
        return By.cssSelector(".autocomplete");
    }

    private By getExpirationDateComboBoxByCss() {
        return By.cssSelector(".startdate");
    }

    private By getRoleComboBoxByCss() {
        return By.cssSelector(".select_roles");
    }

    private By getAddedRoleComboBoxByCss() {
        return By.cssSelector(".visible .select_roles");
    }

    private By getUsersNameByCss() {
        return By.cssSelector(".user_name_col span");
    }

    private By getAddMoreButtonByCss() {
        return By.cssSelector(".button.small.add");
    }

    private By getUsersToShareFieldToByXpath() {
        return By.cssSelector("[id*=adbank_shared_Autocomplete].dijitInputInner");
    }

    private By getAccessToSubFoldersCheckBoxByCss() {
        return By.cssSelector("div[id*='adbank_files_share_folders_dialog_form_item'] input[type='checkbox']");
    }

    private By getNextPageByCss() {
        return By.cssSelector(".next.pls span:not(.icon-right)");
    }

    private By getPreviousPageByCss() {
        return By.cssSelector(".prev.prs span:not(.icon-left)");
    }
}