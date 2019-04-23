package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 07.08.12
 * Time: 12:44
 */
public class AdBankTeamsPage extends AdbankProjectTabs {
    public AdBankTeamsPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppear(By.cssSelector(".content-container.phm.pbm.project-team-content.ng-scope"));
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(By.cssSelector(".content-container.phm.pbm.project-team-content.ng-scope")));
    }

    public WebElement getUserItemElement(String userName) {
        for (WebElement userItemElement : getUsersList()) {
            String itemUserName = userItemElement.findElement(By.cssSelector(".team_link")).getText().trim();
            if (userName.equalsIgnoreCase(itemUserName)) {
                return userItemElement;
            }
        }
        return null;
    }

    public boolean isUserPresent(String userName){
        return getUserItemElement(userName) != null;
    }

    public List<String> getAgencyProjectTeamsList(){
        List<String> teamsList = new ArrayList<String>();
        List<WebElement> teams = web.findElements(By.cssSelector(".agencyTeams span + span"));
        for(WebElement team : teams){
            teamsList.add(team.getText());
        }
        return teamsList;
    }

    public AdBankTeamsPage selectAgencyProjectTeam(String teamName){
        //      web.click(By.xpath("//span[text()='" + teamName + "']"));
        web.click(By.xpath("//span[contains(.,'" + teamName + "')]"));
        return new AdBankTeamsPage(web);
    }

    public List<String> getUserRoles(String userName) {
        List<String> roles = new ArrayList<String>();
        WebElement userItemElement = getUserItemElement(userName);
        List<WebElement> roleElements = userItemElement.findElements(By.cssSelector(".role"));
        //List<WebElement> roleElements = userItemElement.findElements(By.cssSelector(".list_of_roles"));
        for (WebElement roleElement : roleElements) {
            String role = roleElement.getText().trim().toLowerCase();
            roles.add(role);
            //roles.add(role.replaceAll(" ", "."));
        }
        return roles;
    }

    public List<String> getUserRolesFromDetails(String userName) {
        getUserItemElement(userName).findElement(By.cssSelector(".team_link")).click();
        return web.findElementsToStrings(By.cssSelector(".team_users_permissions .role"));
    }

    public void clickAddRoleButton() {
        // web.click(By.cssSelector("[data-role='add-role']:not(.disabled)"));
        web.findElement(By.xpath("//button[contains(.,'Add Role')]")).click();
    }

    public void clickSaveButton() {
        // web.click(By.name("Save"));
        if(web.isElementPresent(By.cssSelector("[ng-click=\"onSave()\"]")))
            web.findElement(By.cssSelector("[ng-click=\"onSave()\"]")).click();
        else if(web.isElementPresent(By.cssSelector("[ng-click=\"modalCtrl.ok()\"]")))
        web.findElement(By.cssSelector("[ng-click=\"modalCtrl.ok()\"]")).click();
        else
            web.click(By.name("Save"));

    }

    // For NGN-14650
    public void clickCancelButton() {
        web.click(By.xpath("//a[contains(.,'Cancel')]"));
    }

    public void removeRole(String roleId) {
        web.click(By.cssSelector("[data-role-id*='"+roleId+"']"));
    }

    public int getValueOfUsersOnThisTeamPageCounter() {
        String locator = ".bold.ng-binding";
        return Integer.parseInt(web.findElement(By.cssSelector(locator)).getText());
    }

    public List<WebElement> getSelectedUsers(){
        By by = By.cssSelector(".users_list_item.selected");
        if (!web.isElementPresent(by)) return new ArrayList<WebElement>();
        return web.findElements(by);
    }
    public int getSelectedUsersCount() {
        return getSelectedUsers().size();
    }

    public boolean isUserDisplayed(String userName) {
        return web.findElement(By.linkText(userName)).isDisplayed();
    }

    public void selectUser(User user) {
        WebElement webElement =getUserItemElement(user.getFullName());
        webElement.click();
    }

    public List<WebElement> getUsersList() {
        By by = By.cssSelector("[ng-click=\"vm.selectUser(vm.user)\" ]");
        return web.findElements(by);
    }

    public byte[] getUserLogo(User user) {
        WebElement userElement = getUserItemElement(user.getFirstName() + " " + user.getLastName());
        String logoUrl = userElement.findElement(By.cssSelector(" .avatar img")).getAttribute("src");
        return getDataByUrl(logoUrl);
    }

    public void clickManagePermissions() {
        web.click(By.xpath("//*[@data-dojo-type='common.initAngular']/button[contains(text(),'Manage permissions')]"));
    }

    public List<String> getUserNames() {
        return web.findElementsToStrings(By.cssSelector(".users-list-item .team_link"));
    }

    public String getRoleForUser(String userName) {
        String locator = String.format("//div[contains(@class,'users-list-item') and descendant::a[normalize-space(text())='%s']]//li", userName);
        return web.findElement(By.xpath(locator)).getText().trim();
    }

    public List<String> getUserNamesInLowerCase() {
        List<String> result = new ArrayList<String>();
        for (String str: getUserNames()) {
            result.add(str.toLowerCase());
        }
        return result;
    }

    public List<WebElement> getAllFilesLinkInActivityList() {
        return web.findElements(By.cssSelector(".phm.ptm.activities_list.pbl a.h4.bold.no-decoration.plxs[href*='files']"));
    }

    public AdBankTeamsPage openUserDetails(User user) {
        WebElement userElement;
        if (user.getFirstName() != null && user.getLastName() != null) {
            userElement = getUserItemElement(user.getFirstName() + " " + user.getLastName());
        } else {
            userElement = getUserItemElement(user.getEmail());
        }
        userElement.findElement(By.cssSelector(".team_link")).click();
        return this;
    }

    public AdBankTeamsPage selectUserFormRecentActivities(User user) {
        String displayedName = user.getFirstName() == null || user.getLastName() == null ? user.getEmail() : user.getFullName();
        web.click(By.xpath(String.format("//*[contains(@class,'activities_list')]//*[text()='%s']", displayedName)));
        return this;
    }

    public AdBankTeamsPage clickFileLinkFromRecentActivities(String filePath, User user) {
        String displayedName = user.getFirstName() == null || user.getLastName() == null ? user.getEmail() : user.getFullName();
        web.click(By.xpath(String.format("//*[contains(@class,'activities_list')]//*[contains(@id,'activity_item')][*//*[text()='%s']]//a[contains(text(),'%s')]", displayedName, filePath)));
        return this;
    }

    public AdBankTeamsPage clickAddUserButton(){
        web.click(By.xpath("//span[text()='Add User']"));
        return this;
    }

    public AddTeamUserPopUpWindow clickUserOption() {
        web.click(By.xpath("//td[span[contains(@class, 'icon-user')]]"));
        return new AddTeamUserPopUpWindow(this);
    }

    public AddAgencyProjectTeamPopUp clickAddToProjectTeam() {
        // web.click(By.xpath("//td[contains(.,'Public Project Team Template')]"));
        web.click(By.xpath("//button[contains(@type,'button')]/..//span[contains(.,'Public Project Team Template')]"));

        return new AddAgencyProjectTeamPopUp(this);
    }

    public AddAgencyProjectTeamPopUp openAddAgencyProjectTeamPopUp(){
        //By locator = By.xpath("//*[contains(@widgetid,'DropDownButton') and .//*[text()='Add User']]");
        By locator = By.xpath("//button[contains(@type,'button')][contains(.,'Add User')]");
        web.findElement(locator).click();
        // new DojoDropDownButton(this, locator).openDropDown();
        return clickAddToProjectTeam();
    }

    public List<String> getSelectedUserName() {
        return web.findElementsToStrings(By.cssSelector(".users-list-item.selected .clear_lage_font a"));
    }

    public int getUsersPerPage(){
        return web.findElements(By.cssSelector(".lastUnit.clear_lage_font")).size();
    }

    public List<String> getPaginationSizes(){
        return web.findElementsToStrings(By.xpath("//div[@id='paginate-size-range']/ul/li/a"));
    }

    public boolean selectPaginationSize(String number){
        boolean selected = false;
        web.findElement(By.xpath("//*[@id='paginate-size-range']/button")).click();
        web.sleep(1000);
        for(WebElement element : web.findElements(By.xpath("//ul[@ class='dropdown-menu'][@role='menu']/li"))) {
            if(element.getText().equals(number)){
                element.click();
                selected = true;
                break;
            }
        }
        return selected;
    }

    private By getRecentActivitiesLocator() {
        return  By.cssSelector(".activities-list .row");
    }

    public int getActivityItemsCount() {
        return web.findElementsToStrings(getRecentActivitiesLocator()).size();
    }

    public List<String> getActivitiesList() {
        List<String> activities = new ArrayList<>();
        if (web.isElementPresent(getRecentActivitiesLocator())) {
            for (WebElement element : web.findElements(getRecentActivitiesLocator())) {
                activities.add(element.getText().replaceAll("\n.*$", "").replaceAll("\n", " "));
            }
        }
        return activities;
    }
}
