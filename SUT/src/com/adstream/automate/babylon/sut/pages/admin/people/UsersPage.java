package com.adstream.automate.babylon.sut.pages.admin.people;

import com.adstream.automate.babylon.sut.pages.adbank.addressbook.InviteUserPopup;
import com.adstream.automate.babylon.sut.pages.admin.BaseAdminPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: ruslan.semerenko
 * Date: 25.04.12 12:39
 */
public class UsersPage extends BaseAdminPage<UsersPage> {
    private static final By NEW_USER_BUTTON_LOCATOR = By.linkText("Add Users to This Unit");
    private static final By USERS_FILTER_LOCATOR = By.cssSelector("[data-dojo-type='admin.people.filter']");

    public UsersPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppear(NEW_USER_BUTTON_LOCATOR);
        web.waitUntilElementAppear(USERS_FILTER_LOCATOR);
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(NEW_USER_BUTTON_LOCATOR));
        assertTrue(web.isElementPresent(USERS_FILTER_LOCATOR));
    }

    public List<String> getVisibleUsersFieldsByName(String field) {
        List<String> usersFields = new ArrayList<>();

        if (field.equals("Id")) {
            By locator = By.cssSelector("[id*='usersListItem'] .avatar img");
            if (web.isElementPresent(locator)) {
                Pattern pattern = Pattern.compile("documentId=([\\w\\d]+)", Pattern.CASE_INSENSITIVE);
                for (String userId : web.findElementsToStrings(locator, "src")) {
                    Matcher matcher = pattern.matcher(userId);
                    usersFields.add(matcher.find() ? matcher.group(1) : "");
                }
            }
        } else if (field.equals("FullName")) {
            By locator = By.cssSelector("[id*='usersListItem'] .h5");
            if (web.isElementPresent(locator)) usersFields = web.findElementsToStrings(locator);
        } else if (field.equals("Logo")) {
            By locator = By.cssSelector("[id*='usersListItem'] .avatar img");
            if (web.isElementPresent(locator)) usersFields = web.findElementsToStrings(locator, "src");
        } else if (field.equals("Role")) {
            for (WebElement row : web.findElements(By.cssSelector("[id*='usersListItem']"))) {
                By locator = By.cssSelector("[id='" + row.getAttribute("id") + "'] .role");
                usersFields.add(web.isElementPresent(locator) ? web.findElement(locator).getText() : "");
            }
        } else if (field.equals("Unit")) {
            By locator = By.cssSelector("[id*='usersListItem'] > div > span");
            if (web.isElementPresent(locator)) usersFields = web.findElementsToStrings(locator);
        } else if (field.equals("FullNameOnly")) {
            By locator = By.xpath("//*[contains(@id,'usersListItem')]//*[contains(@class,'team_link')]//*[not(contains(text(),'@'))]");
            if (web.isElementPresent(locator)) usersFields = web.findElementsToStrings(locator);
        } else if (field.equals("EmailOnly")) {
            By locator = By.xpath("//*[contains(@id,'usersListItem')]//*[contains(@class,'team_link')]//*[(contains(text(),'@'))]");
            if (web.isElementPresent(locator)) usersFields = web.findElementsToStrings(locator);
        } else {
            throw new IllegalArgumentException(String.format("Unknown user field name: '%s',\n" +
                    "please choose one of the following: 'Id','Email','FullName','Logo','Role','Unit'", field));
        }
        return usersFields;
    }

    public Map<String, List<String>> getVisibleUsersFields(String... fields) {
        Map<String, List<String>> users = new HashMap<>();
        for (String field : fields)
            users.put(field, getVisibleUsersFieldsByName(field));
        return users;
    }

    public Map<String, List<String>> getFullMapOfVisibleUsersFields(String... fields) {
        if (web.getCurrentUrl().contains("page=")) {
            //web.navigate().to(web.getCurrentUrl().replaceAll("page=\\d+", "page=1"));
            String tempUrl = web.getCurrentUrl().replaceAll("page=\\d+", "page=1");
            if(!(web.getCurrentUrl().equalsIgnoreCase(tempUrl)))
                web.navigate().to(tempUrl);
        }
        String backupPage = web.getCurrentUrl();
        Map<String, List<String>> users = getVisibleUsersFields(fields);
        while (isNextPageButtonActive()) {
            clickNextPageButton();
            for (String field : fields) {
                Map<String, List<String>> visibleUsersFields = getVisibleUsersFields(fields);
                users.get(field).addAll(visibleUsersFields.get(field));
            }
        }
        //This is a stupid hack in place coz of an issue with geckodriver not being able to navigate to a URL if its already on same url and the url contains fragments.Though it says fixed it doesnt work
        //https://github.com/mozilla/geckodriver/issues/189 ; https://github.com/mozilla/geckodriver/issues/150;
        // https://bugzilla.mozilla.org/show_bug.cgi?id=1280300;https://bugzilla.mozilla.org/show_bug.cgi?id=1337464
         if(!(web.getCurrentUrl()).equalsIgnoreCase(backupPage))
        {
            web.navigate().to(backupPage);
        }
        return users;
    }

    public String getLogoSrc(String userId) {
        return web.findElement(By.cssSelector(String.format(".avatar [src*='%s']", userId))).getAttribute("src");
    }

    public byte[] getLogo(String userId) {
        return getDataByUrl(getLogoSrc(userId));
    }

    public List<String> getLibraryTeamsList() {
        return web.findElementsToStrings(By.cssSelector(".libraryTeams li span + span"));
    }

    public List<String> getProjectTeamsList() {
        return web.findElementsToStrings(By.cssSelector(".agencyTeams span + span"));
    }

    public List<String> getVisibleUsersFirstName() {
        return web.findElementsToStrings(By.cssSelector("[data-user-id] [data-dojo-type='common.trimmedBox']:first-child"), "title");
    }

    public List<String> getVisibleUsersLastName() {
        return web.findElementsToStrings(By.cssSelector("[data-user-id] [data-dojo-type='common.trimmedBox']:last-child"), "title");
    }

    public int getUsersCount(){
        return web.findElements(By.xpath("//div[contains(@id,'admin_people_usersListItem')]")).size();
    }

    public String getClassOfSortField(String fieldName) {
        WebElement element = getSortFieldByFieldName(fieldName);
        return element.getAttribute("class") == null ? "" : element.getAttribute("class");
    }

    public WebElement getSortFieldByFieldName(String fieldName) {
        return web.findElement(By.cssSelector(String.format("[fieldname='%s']", convertSortFieldName(fieldName))));
    }

    public String getUserCount() {
        return web.findElement(By.cssSelector("[id*='UsersCounter'].counter")).getText().trim();
    }

    public String getPageNumber() {
        Pattern pattern = Pattern.compile("Page\\s+(\\d+)", Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(web.findElement(By.cssSelector(".page-display")).getText().trim());

        return matcher.find() ? matcher.group(1) : "";
    }

    public List<String> getAgencyNamesList() {
        return web.findElementsToStrings(By.cssSelector(".listSpecial:not(.libraryTeams):not(.agencyTeams) .pls .vmiddle"));
    }

    public List<String> getSelectedUsersFullName() {
        return web.findElementsToStrings(By.cssSelector("[id*='usersListItem'].selected .h5"));
    }

    public String getSelectedUserName() {
        return web.findElement(By.cssSelector("#selectedUser .h4.unit")).getText().trim();
    }

    public String getSelectedUserAgency() {
        return web.findElement(By.cssSelector("#selectedUser .h4.mtm")).getText().trim();
    }

    public String getSelectedUserLogoSrc() {
        return web.findElement(By.cssSelector("#selectedUser .avatar img")).getAttribute("src").trim();
    }

    public String getSelectedUserRole() {
        return web.findElement(By.cssSelector("#selectedUser .role")).getText().trim();
    }

    public boolean isNextButtonActiveOnUserDetails() {
        return web.isElementPresent(By.cssSelector("#selectedUser .next:not(.inactive)"));
    }

    public boolean isUserPresentedById(String userId) {
        return web.isElementVisible(By.cssSelector(String.format("[id*='usersListItem'] .h5 [href*='%s']", userId)));
    }

    public boolean isUserSelectedById(String userId) {
        return web.isElementVisible(By.cssSelector(String.format("[id*='usersListItem'].selected .h5 [href*='%s']", userId)));
    }

    public boolean isUserProfilePopupPresent() {
        return web.isElementPresent(By.xpath("//*[contains(@class,'popupWindow')][not(contains(@style,'display: none'))][*[contains(@title,'User Profile')]]"));
    }

    public boolean isNavigationButtonActiveOnUserDetails(String button) {
        return web.isElementPresent(By.cssSelector(String.format("#selectedUser .%s:not(.inactive)", button)));
    }

    public boolean isAgencyProjectTeamsListPresent(){
        return web.isElementPresent(By.xpath("//span[text()='Public Project Team Templates']"));
    }

    public boolean isPreviousPageButtonActive() {
        return web.isElementPresent(By.cssSelector("[id*='peopleUsersList'] .prev:not(.disabled)"));
    }

    public boolean isNextPageButtonActive() {
        return web.isElementPresent(By.cssSelector("[id*='peopleUsersList'] .next:not(.disabled)"));
    }

    public boolean isAddToTeamButtonActive() {
        return web.isElementPresent(By.cssSelector(".button:not(.disabled) [id*='peopleAddToTeamDropDown'][role='button']"));
    }

    public boolean isUserItemSelected(String userName) {
        return web.findElement(By.xpath(String.format("//*[contains(@id,'usersListItem')][*[contains(@class,'cell')]//*[normalize-space()='%s']]", userName))).
                getAttribute("CLASS").contains("selected");
    }

    public boolean areAllUsersSelected(){
        List<WebElement> usersRows = web.findElements(By.xpath("//div[contains(@id,'admin_people_usersListItem')]"));
        for(WebElement userRow : usersRows){
            if(!userRow.getAttribute("class").contains("selected")){
                return false;
            }
        }
        return true;
    }

    public void clickNextButtonOnUserDetails() {
        WebElement usersList = web.findElement(By.cssSelector("#selectedUser #peopleSelectedUserContent .itemsList"));
        web.click(By.cssSelector("#selectedUser .next:not(.inactive)"));
        web.waitUntilElementChanged(usersList);
    }

    public void clickNextPageButton() {
        WebElement usersList = web.findElement(By.cssSelector("[id*='peopleUsersList'] .team-users-list .itemsList"));
        web.click(By.cssSelector("[id*='peopleUsersList'] .next:not(.disabled)"));
        web.waitUntilElementChanged(usersList);
    }

    public CreateUserPage clickNewUser() {
        web.click(NEW_USER_BUTTON_LOCATOR);
        return new CreateUserPage(web);
    }

    public void clickSortField(String fieldName) {
        WebElement usersList = web.findElement(By.cssSelector(".team-users-list .itemsList"));
        getSortFieldByFieldName(fieldName).click();
        web.waitUntilElementChanged(usersList);
    }

    public void clickNavigationButtonOnUserDetails(String button) {
        WebElement container = web.findElement(By.cssSelector("#peopleSelectedUserContent .itemsList"));
        web.click(By.cssSelector(String.format("#selectedUser .%s:not(.inactive)", button)));
        web.waitUntilElementChanged(container);
    }

    public ConfirmRemoveUserPopUp clickRemoveUserFromTeam(String userName, String teamName, String teamType) {
        AgencyProjectTeamPage agencyProjectTeamPage;
        if(teamType.equalsIgnoreCase("project")) agencyProjectTeamPage = selectAgencyProjectTeam(teamName);
        else if(teamType.equalsIgnoreCase("library")) agencyProjectTeamPage = selectLibraryTeam(teamName);
        else throw new IllegalArgumentException(String.format("Unknown team type: '%s'", teamType));
        return agencyProjectTeamPage.clickRemoveUserButton(userName);
    }

    public void clickAddMoreButtonForUserDetails() {
        web.click(By.cssSelector("#selectedUser .add-more"));
    }

    public void clickAddToTeam() {
        web.click(By.cssSelector("[id*='peopleAddToTeamDropDown'][role='button']"));
        Common.sleep(500);
    }

    public AddToAgencyTeamPopUp clickAddToProjectTeam() {
        web.click(By.xpath("//*[contains(@class,'dijitMenuItemLabel')][normalize-space()='Add to Public Project Team Template']"));
        return new AddToAgencyTeamPopUp(this);
    }

    public AddToLibraryTeamPopUp clickAddToLibraryTeam() {
        web.click(By.xpath("//*[contains(@class,'dijitMenuItemLabel')][normalize-space()='Add to Library Team']"));
        return new AddToLibraryTeamPopUp(this);
    }

    public void clickUserItem(String userName) {
        // NGN-6455
        web.click(By.xpath(String.format("//*[contains(@id,'usersListItem')][*[contains(@class,'cell')]//*[normalize-space()='%s']]//*[contains(@class,'h5')]/a", userName)));
        waitUntilSelectedUserAppears();
    }

    public ConfirmTeamDeletionPopUp clickDeleteTeamButton(){
        web.click(By.xpath("//*[contains(@id,'DeleteTeam')]"));
        return new ConfirmTeamDeletionPopUp(this);
    }

    public void openProfilePopup() {
        web.click(By.cssSelector("#selectedUser [id*='peopleUserProfile']"));
    }

    public void selectUserByIdForCurrentSearchResult(String userId) {
        if (web.getCurrentUrl().contains("page=")) {
            //web.navigate().to(web.getCurrentUrl().replaceAll("page=\\d+", "page=1"));
            String tempUrl = web.getCurrentUrl().replaceAll("page=\\d+", "page=1");
            if(!(web.getCurrentUrl().equalsIgnoreCase(tempUrl)))
            web.navigate().to(tempUrl);
        }

        if (isUserPresentedById(userId)) selectUserById(userId);

        while (isNextPageButtonActive() && !isUserSelectedById(userId)) {
            clickNextPageButton();
            if (isUserPresentedById(userId)) selectUserById(userId);
        }
    }

    public AgencyProjectTeamPage selectAgencyProjectTeam(String aptName){
        web.click(By.xpath(String.format("//ul[contains(@class,'agencyTeams')]//span[text()='%s']", aptName)));
        web.sleep(1000);
        return new AgencyProjectTeamPage(web);
    }

    public AgencyProjectTeamPage selectLibraryTeam(String aptName){
        web.click(By.xpath(String.format("//ul[contains(@class,'libraryTeams')]//span[text()='%s']", aptName)));
        web.sleep(1000);
        return new AgencyProjectTeamPage(web);
    }

    public boolean isLibraryTeamVisible(String aptName){
        return web.isElementPresent(By.xpath(String.format("//ul[contains(@class,'libraryTeams')]//span[text()='%s']", aptName)));
    }

    public void selectUserById(String userId) {
        web.waitUntilElementAppear(By.cssSelector(String.format("[id*='usersListItem'] .h5 [href*='%s']", userId)));
        web.click(By.cssSelector(String.format("[id*='usersListItem'] .h5 [href*='%s']", userId)));
       // waitUntilSelectedUserAppears();
    }

    public UsersPage checkSelectAllCheckBox() {
        new Checkbox(this, By.cssSelector("#total_selector")).select();

        return new UsersPage(web);
    }

    public void searchUser(String userName) {
        try {
            web.typeClean(By.cssSelector("[data-dojo-type='admin.people.filter'] > input"), userName + Keys.RETURN);
        } catch (NoSuchElementException e) {
            web.navigate().refresh();
            load();
            web.typeClean(By.cssSelector("[data-dojo-type='admin.people.filter'] > input"), userName + Keys.RETURN);
        }
        web.sleep(1000);
    }

    public AgencyProjectTeamPage removeUserFromAgencyProjectTeam(String userName, String teamName){
        AgencyProjectTeamPage agencyProjectTeamPage = selectAgencyProjectTeam(teamName);
        agencyProjectTeamPage.removeUserFromThisTeam(userName);
        return new AgencyProjectTeamPage(web);
    }

    public AgencyProjectTeamPage removeUserFromLibraryTeam(String userName, String teamName){
        AgencyProjectTeamPage agencyProjectTeamPage = selectLibraryTeam(teamName);
        agencyProjectTeamPage.removeUserFromThisTeam(userName);
        return new AgencyProjectTeamPage(web);
    }

    public AgencyProjectTeamPage removeClientUserFromLibraryTeam(String userName, String teamName){
        AgencyProjectTeamPage agencyProjectTeamPage = selectLibraryTeam(teamName);
        List<String> users = agencyProjectTeamPage.getVisibleUsersFieldsByName("FullName");
        for (int i = 0; i < users.size() - 1; i++) {
            if (users.get(i).contains(userName)) {
                agencyProjectTeamPage.removeUserFromThisTeam(userName);
            }
        }
        return new AgencyProjectTeamPage(web);
    }

    public UsersPage removeAgencyProjectTeam(String teamName){
        this.selectAgencyProjectTeam(teamName);
        ConfirmTeamDeletionPopUp confirmTeamDeletionPopUp = this.clickDeleteTeamButton();
        confirmTeamDeletionPopUp.confirmDeletion();
        return this;
    }

    public UsersPage removeLibraryTeam(String teamName){
        this.selectLibraryTeam(teamName);
        ConfirmTeamDeletionPopUp confirmTeamDeletionPopUp = this.clickDeleteTeamButton();
        confirmTeamDeletionPopUp.confirmDeletion();
        return this;
    }

    public void saveUserDetails() {
        web.click(By.cssSelector("#selectedUser .save"));
    }

    private void waitUntilSelectedUserAppears() {
        web.waitUntilElementAppear(By.cssSelector("#selectedUser > *"));
    }

    private String convertSortFieldName(String fieldName) {
        if (fieldName.equalsIgnoreCase("user")) {
            fieldName = "_cm.common.firstName";
        } else if(fieldName.toLowerCase().equals("unit")) {
            fieldName = "_cm.common.advertiser";
        }

        return fieldName;
    }

    public boolean isInviteButtonVisible() {
        return web.isElementPresent(By.xpath("//div[@class='button mrs']"))
                && web.isElementVisible(By.xpath("//div[@class='button mrs']"));
    }

    public InviteUserPopup clickInviteButton() {
        web.click(By.xpath("//div[@class='button mrs']"));
        return new InviteUserPopup(this);
    }

    public ProjectAccessRulePopUp clickManageAccessRules()
    {
        web.waitUntilElementAppear(By.xpath("//button[@data-role='manage']")).click();
       // web.click(By.xpath("//button[@data-role='manage']"));
        return new ProjectAccessRulePopUp(this);
    }

    public void clickCollectionsTab(){
        web.click(By.cssSelector(".line.plm>a[href=\"#categories\"]"));
        Common.sleep(500);
        waitUntilPopUpNotificationMessageDisappeared();
    }
}