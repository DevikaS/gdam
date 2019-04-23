package com.adstream.automate.babylon.tests.steps.domain;

import com.adstream.automate.babylon.ContactSearchingParams;
import com.adstream.automate.babylon.JsonObjects.Contact;
import com.adstream.automate.babylon.JsonObjects.User;
import com.adstream.automate.babylon.data.Logo;
import com.adstream.automate.babylon.sut.pages.adbank.addressbook.AdbankAddressbookAddUserToTemplatesPopUp;
import com.adstream.automate.babylon.sut.pages.adbank.addressbook.AdbankAddressbookAddUsersPopUp;
import com.adstream.automate.babylon.sut.pages.adbank.addressbook.AdbankAddressbookPage;
import com.adstream.automate.babylon.sut.pages.adbank.addressbook.InviteUserPopup;
import com.adstream.automate.babylon.tests.steps.core.BaseStep;
import com.adstream.automate.hamcrest.StringByRegExpCheck;
import com.adstream.automate.utils.Common;
import org.hamcrest.Matcher;
import org.jbehave.core.annotations.*;
import org.jbehave.core.model.ExamplesTable;
import org.openqa.selenium.Keys;

import java.util.*;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 21.06.12
 * Time: 14:36
 */
public class AddressBookSteps extends BaseStep {
    @Given("I am on Address Book page")
    @When("I go on Address Book page")
    public AdbankAddressbookPage openAddressbookPage() {
        return getSut().getPageNavigator().getAdbankAddressbookPage();
    }

    @Given("I am on add contact popup page")
    @When("I go to add contact popup page")
    public AdbankAddressbookAddUsersPopUp openAddressbookAddUsersPopUp() {
        return openAddressbookPage().clickAddUser();
    }

    @Given("{I |}added user '$userName' into address book")
    @When("{I |}added user '$userName' into address book")
    public void addUserToAddressBook(String userName) {
        getCoreApi().addIntoAddressBook(wrapUserEmailWithTestSession(userName));
    }

    @Given("{I |}added user '$userName' into address book with no testsession")
    @When("{I |}added user '$userName' into address book with no testsession")
    public void addUserToAddressBookWitNoTestSession(String userName) {
        getCoreApi().addIntoAddressBook(userName);
    }
    @Given("{I |}invited user '$email'")
    @When("{I |}invite user '$email'")
    public void inviteUser(String email) {
        getCoreApi().inviteUser(wrapUserEmailWithTestSession(email));
    }

    // | UserName |
    @Given("{I |}added following users to address book: $userTable")
    public void addUsersToAddressBook(ExamplesTable usersTable) {
        for (Map<String, String> row : parametrizeTableRows(usersTable)) {
            addUserToAddressBook(row.get("UserName"));
        }
    }

    @Given("{I |}removed user '$userName' from address book")
    public void removeUserFromAddressBook(String userName) {
        String contactEmail = wrapUserEmailWithTestSession(userName);
        Contact contact = getCoreApi().getContactByEmail(contactEmail);
        getCoreApi().deleteContact(contact.getId());
        long end  = System.currentTimeMillis() + 15 * 1000; //wait 10 second
        while (getCoreApi().isContactExistByEmail(contactEmail)){
            if (end < System.currentTimeMillis()) {
                throw new IllegalStateException("User was not deleted from address book!!!");
            }
            Common.sleep(1000); // one second
        }
    }

    @Given("{I |}added user '$userName' to team template '$templateName'")
    public void addUserToTeamTemplate(String userName, String templateName) {
        String userEmail = wrapUserEmailWithTestSession(userName);
        User user = getCoreApiAdmin().getUserByEmail(userEmail);
        if (user == null)
            throw new IllegalStateException(String.format("Could not find user '%s'", userEmail));
        getCoreApi().addUserToTeamTemplate(user.getEmail(), wrapVariableWithTestSession(templateName));
    }

    @Given("{I |}added user '$userName' to team template '$templateName' with no Test Session")
    @When("{I |}add user '$userName' to team template '$templateName' with no Test Session")
    public void addUserToTeamTemplateWithNoTestSession(String userName, String templateName) {
        User user = getCoreApiAdmin().getUserByEmail(userName);
        if (user == null)
            throw new IllegalStateException(String.format("Could not find user '%s'", userName));
        getCoreApi().addUserToTeamTemplate(user.getEmail(), templateName);
    }

    // | UserName |
    @Given("{I |}added following users to team template '$templateName': $userTable")
    public void addUsersToTeamTemplate(String templateName, ExamplesTable usersTable) {
        for (Map<String, String> row : parametrizeTableRows(usersTable)) {
            addUserToTeamTemplate(row.get("UserName"), templateName);
        }
    }

    @Given("{I |}added '$userName' to team template '$teamTemplateName'")
    public void addUsersToTeamTemplate(String userName, String templateName) {
        String[] usersName = userName.split(",");
        for (String uN: usersName) {
            addUserToTeamTemplate(uN, templateName);
        }
    }

    // | UserName  | TeamTemplate |
    @Given("I added users to team template with the following fields: $fieldTable")
    public void addUsersToTeamTemplate(ExamplesTable usersTable) {
        for (Map<String, String> row : usersTable.getRows()) {
            addUserToTeamTemplate(row.get("UserName"), row.get("TeamTemplate"));
        }
    }

    @Given("{I |}selected '$userName' on Address Book")
    @When("{I |}select '$userName' on Address Book")
    public void clickOnUser(String userName) {
        String userId = getCoreApi().getUserByEmail(resolveUserNameToEmail(userName)).getId();
        if(userId==null) {
          userId = getCoreApi().getContactByEmail(resolveUserNameToEmail(userName)).getId();
        }
        getSut().getPageCreator().getAdbankAddressbookPage().clickUserListElement(userId);
    }

    @Given("{I |}selected '$userName' on Address Book with no Test Session")
    @When("{I |}select '$userName' on Address Book with no Test Session")
    public void clickOnUserWithNoTestSession(String userName) {
        String userId = getCoreApi().getUserByEmail(userName).getId();
        if(userId==null) {
            userId = getCoreApi().getContactByEmail(userName).getId();
        }
        getSut().getPageCreator().getAdbankAddressbookPage().clickUserListElement(userId);
    }

    @When("I select users on Address book: $usersName")
    public void clickOnUser(ExamplesTable usersName) {
        for (Map<String, String> row: usersName.getRows()) {
            clickOnUser(row.get("UserName"));
        }
    }

    @Then("I '$condition' see user email: '$emailName'")
    public void checkUsersEmail(String condition, String userEmail) {
        userEmail = wrapUserEmailWithTestSession(userEmail);
        boolean should = condition.equals("should");
        AdbankAddressbookPage adbankAddressbookPage = getSut().getPageCreator().getAdbankAddressbookPage();
        assertThat("", adbankAddressbookPage.getContactInfoEmailValue().equals(userEmail), equalTo(should));
    }

    @Given("{I |}selected user link '$userName' on Address{ |}{B|b}ook")
    @When("{I |}select user link '$userName' on Address{ |}{B|b}ook")
    public void clickOnUserField(String userName) {
        String userId = getCoreApi().getUserByEmail(resolveUserNameToEmail(userName)).getId();
        if (userId==null){
            userId = getCoreApi().getContactByEmail(resolveUserNameToEmail(userName)).getId();
        }
        getSut().getPageCreator().getAdbankAddressbookPage().clickUserListElement(userId);
    }

    @Given("{I |}click on user link '$userName' on Address{ |}{B|b}ook")
    @When("{I |}click on user link '$userName' on Address{ |}{B|b}ook")
    public void clickOnUserLink(String userName) {
       String userId;
        try{
            userId = getCoreApi().getUserByEmail(resolveUserNameToEmail(userName)).getId();
        }catch (NullPointerException e){
            userId = getCoreApi().getContactByEmail(resolveUserNameToEmail(userName)).getId();
        }
        getSut().getPageCreator().getAdbankAddressbookPage().clickUserLinkElementOnTheList(userId);
    }

    @When("{I |}click remove link next to team template '$teamTemplateName'")
    public void clickRemoveLinkNextToTeamTemplate(String teamTemplateName) {
        String realTeamTemplateName = wrapVariableWithTestSession(teamTemplateName);
        AdbankAddressbookPage adbankAddressbookPage = getSut().getPageCreator().getAdbankAddressbookPage();
        adbankAddressbookPage.clickRemoveContactButton();
        adbankAddressbookPage.clickConfirmDeleteButton();
        Common.sleep(1000);
    }

    @When("{I |}click remove button on Adressbook page")
    public void clickRemoveButtonOnAdressBookPage() {
        AdbankAddressbookPage adbankAddressbookPage = getSut().getPageCreator().getAdbankAddressbookPage();
        adbankAddressbookPage.clickRemoveContactButton();
        Common.sleep(1000);
    }

    @Given("I clicked Add to team template for users: $userName")
    @When("I click Add to team template for users: $userName")
    public void clickAddToTeamTemplate(ExamplesTable usersTable) {
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        Common.sleep(1000);
        for (Map<String, String> row : usersTable.getRows()) {
            String userId = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(row.get("UserName"))).getId();
            if (!adbankAddressbookPage.isUserListElementSelected(userId)) {
                adbankAddressbookPage.clickUserListElement(userId);
            }
        }
        adbankAddressbookPage.clickAddToTeamTemplateButton();
    }

    @Given("I clicked Add to team template for users '$userName'")
    @When("I click Add to team template for users '$userName'")
    public void clickAddToTeamTemplate(String userName) {
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        String[] usersName = userName.split(",");
        for (String anUsersName : usersName) {
            String userId = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(anUsersName)).getId();
            if (!adbankAddressbookPage.isUserListElementSelected(userId)) {
                adbankAddressbookPage.clickUserListElement(userId);
            }
        }
        adbankAddressbookPage.clickAddToTeamTemplateButton();
    }

    @Given("I clicked Add to team template for users '$userName' with no Test Session")
    @When("I click Add to team template for users '$userName' with no Test Session")
    public void clickAddToTeamTemplateWithNoTestSession(String userName) {
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        String[] usersName = userName.split(",");
        for (String anUsersName : usersName) {
            String userId = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(anUsersName)).getId();
            if (!adbankAddressbookPage.isUserListElementSelected(userId)) {
                adbankAddressbookPage.clickUserListElement(userId);
            }
        }
        adbankAddressbookPage.clickAddToTeamTemplateButton();
    }


    @When("I delete contact '$userName' '$confirm'")
    public void deleteContactWithConfirm(String userName, String confirm) {
        String userId = getCoreApi().getUserByEmail(resolveUserNameToEmail(userName)).getId();
        if (userId==null){
            userId = getCoreApi().getContactByEmail(resolveUserNameToEmail(userName)).getId();
        }
        AdbankAddressbookPage page = getSut().getPageCreator().getAdbankAddressbookPage();
        page.clickUserListElement(userId);
        page.clickRemoveContactButton();
        if (confirm.equals("confirm")) {
            page.clickConfirmDeleteButton();
        } else {
            page.clickCancelDeleteButton();
        }
        getSut().getWebDriver().sleep(1000);
    }

    @When("I create team template with name '$teamTemplateName'")
    public void createNewTeamTemplate(String teamTemplateName) {
        String realTeamTemplateName = wrapVariableWithTestSession(teamTemplateName);
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        AdbankAddressbookAddUserToTemplatesPopUp adbankAddressbookAddUserToTemplatesPopUp = new AdbankAddressbookAddUserToTemplatesPopUp(adbankAddressbookPage);
        adbankAddressbookAddUserToTemplatesPopUp.typeNewTemplateName(realTeamTemplateName);
        adbankAddressbookAddUserToTemplatesPopUp.clickAddButton();
    }

    @When("I edit team template with name '$teamTemplateName'")
    public void editNewTeamTemplate(String teamTemplateName) {
        String realTeamTemplateName = wrapVariableWithTestSession(teamTemplateName);
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        AdbankAddressbookAddUserToTemplatesPopUp adbankAddressbookAddUserToTemplatesPopUp = new AdbankAddressbookAddUserToTemplatesPopUp(adbankAddressbookPage);
        adbankAddressbookAddUserToTemplatesPopUp.clickTeamTemplateCheckBox(realTeamTemplateName);
        adbankAddressbookAddUserToTemplatesPopUp.clickAddButton();
    }
    @Given("I clicked add button on the Add users team template popup")
    @When("I click add button on the Add users team template popup")
    public void clickAddButtonOnTheAddUsersTeamTemplatePopup() {
        AdbankAddressbookAddUserToTemplatesPopUp adbankAddressbookAddUserToTemplatesPopUp = new AdbankAddressbookAddUserToTemplatesPopUp(openAddressbookPage());
        adbankAddressbookAddUserToTemplatesPopUp.clickAddButton();
    }

    @Given("I clicked Update Existing button")
    @When("I click Update Existing button")
    public void clickUpdateExistingButton() {
        AdbankAddressbookAddUserToTemplatesPopUp adbankAddressbookAddUserToTemplatesPopUp = new AdbankAddressbookAddUserToTemplatesPopUp(openAddressbookPage());
        adbankAddressbookAddUserToTemplatesPopUp.clickUpdateExistingButton();
    }

    @Given("I clicked Rename Current link")
    @When("I click Rename Current link")
    public void clickRenameCurrentLink() {
        AdbankAddressbookAddUserToTemplatesPopUp adbankAddressbookAddUserToTemplatesPopUp = new AdbankAddressbookAddUserToTemplatesPopUp(openAddressbookPage());
        adbankAddressbookAddUserToTemplatesPopUp.clickRenameCurrentLink();
    }

    @When("I add user into few team templates: $teamTemplateName")
    public void addUsersIntoFewTeamTemplates(ExamplesTable teamTemplateName) {
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        AdbankAddressbookAddUserToTemplatesPopUp adbankAddressbookAddUserToTemplatesPopUp = new AdbankAddressbookAddUserToTemplatesPopUp(adbankAddressbookPage);
        for (Map<String, String> row : teamTemplateName.getRows()) {
            String realTeamTemplateName = wrapVariableWithTestSession(row.get("TeamTemplate"));
            adbankAddressbookAddUserToTemplatesPopUp.clickTeamTemplateCheckBox(realTeamTemplateName);
        }
        adbankAddressbookAddUserToTemplatesPopUp.clickAddButton();
    }

    @When("I select '$teamTemplateName' on the AddUserToTemplatesPopUp")
    public void selectTeamTemplateName(String teamTemplateName){
        String realTeamTemplateName = wrapVariableWithTestSession(teamTemplateName);
        AdbankAddressbookAddUserToTemplatesPopUp adbankAddressbookAddUserToTemplatesPopUp = new AdbankAddressbookAddUserToTemplatesPopUp(openAddressbookPage());
        adbankAddressbookAddUserToTemplatesPopUp.clickTeamTemplateCheckBox(realTeamTemplateName);
    }

    @Then("I '$condition' see '$teamTemplateName' in the Team Templates list")
    public void checkNewTemplateIsExist(String condition, String teamTemplateName) {
        boolean should = condition.equals("should");
        String realTeamTemplateName = wrapVariableWithTestSession(teamTemplateName);
        AdbankAddressbookPage adbankAddressbookPage = getSut().getPageCreator().getAdbankAddressbookPage();
        List<String> teamTemplatesFrontend = adbankAddressbookPage.getTeamTemplatesTexts();
        assertThat("Check that new Team Template: " + realTeamTemplateName + " is exist on the list", teamTemplatesFrontend.contains(realTeamTemplateName), equalTo(should));
    }

    @Then("I '$condition' see User '$userName' on Address Book")
    public void checkThatUserRemoveAfterDeleteConfirm(String condition, String userName) {
        boolean shouldState = condition.equals("should");

        User user = getCoreApi().getUserByEmail(resolveUserNameToEmail(userName));
        String fullName = user != null ? user.getFullName() : wrapUserEmailWithTestSession(userName);
        List<String> actualUsersList = getSut().getPageCreator().getAdbankAddressbookPage().getAllUsersLink();

        assertThat(fullName, shouldState ? isIn(actualUsersList) : not(isIn(actualUsersList)));
    }

    @Given("{I |}added user{s|} '$userName' to Address book")
    @When("{I |}add user{s|} '$userName' to Address book")
    public void addUser(List<String> userNameList) {
        AdbankAddressbookAddUsersPopUp popUp = openAddressbookAddUsersPopUp();
        for (String userName : userNameList) {
            popUp.selectUserByEmail(resolveUserNameToEmail(userName));
        }
        popUp.clickAddButton();
        Common.sleep(1000);
    }



    @When("I type users '$userName' in add user to address book popup")
    public AdbankAddressbookAddUsersPopUp typeEmailToPopUp(List<String> userName) {
        Iterator<String> userNameIterator = userName.iterator();
        StringBuilder sb = new StringBuilder();
        while (userNameIterator.hasNext()) {
            sb.append(resolveUserNameToEmail(userNameIterator.next()));
            if (userNameIterator.hasNext()) sb.append(",");
        }
        return openAddressbookAddUsersPopUp().typeUserMail(sb.toString());
    }

    @When("I type text '$text'  in add user to address book popup")
    public AdbankAddressbookAddUsersPopUp typeTextToPopUp(String text) {
        return openAddressbookAddUsersPopUp().typeUserTextWithPause(text + Keys.ENTER, 1000);
    }

    @When("I select users according to text '$text' in add user to address book popup")
    public void selectUsersTextToPopUp(String text) {
        AdbankAddressbookAddUsersPopUp popup = openAddressbookPage().clickAddUser().startTypeUserMail(text);
        Common.sleep(1000);
        popup.selectUserByEmail(text);
    }

    @Then("I '$shouldState' see user '$userName' in Address Book")
    public void checkUserInUserList(String shouldState, String userName) {
        Common.sleep(1000);
        boolean should = "should".equalsIgnoreCase(shouldState);
        List<String> userList = getSut().getPageCreator().getAdbankAddressbookPage().getUserList();
        String expectedUserName = resolveUserNameToNameInList(userName);
        assertThat("User name '" + expectedUserName + "' is present on address book page",
                userList.contains(expectedUserName), is(should));
    }

    // | Should |Email |
    @Then("I should see next users in Address book: $data")
    public void checkUserInUserList(ExamplesTable data) {
        List<String> actualUsersList = getSut().getPageNavigator().getAdbankAddressbookPage().getUserList();
        String expectedUserName;

        for (Map<String, String> row: parametrizeTableRows(data)) {
            boolean shouldState = row.get("Should").equalsIgnoreCase("should");
            expectedUserName = resolveUserNameToNameInList(row.get("Email"));

            assertThat(actualUsersList, shouldState ? hasItem(expectedUserName) : not(hasItem(expectedUserName)));
        }
    }

    @Then("I '$condition' see user type '$userType' in AddressBook")
    public void checkUserTypeVisibleOnAddressBook(String condition, String userType) {
        boolean should = "should".equalsIgnoreCase(condition);
        List<String> userList = getSut().getPageCreator().getAdbankAddressbookPage().getUserList();
        String expectedUserName = resolveUserNameToNameInList(getData().getUserByType(userType).getEmail());
        log.debug("I checked user " + expectedUserName);
        assertThat(userList, should ? hasItem(expectedUserName) : not(hasItem(expectedUserName)));
    }

    @Then("I '$condition' see less or equals users '$count' in AddressBook")
    public void checkUsersCount(String condition, String count) {
        boolean should = "should".equalsIgnoreCase(condition);
        List<String> userList = getSut().getPageCreator().getAdbankAddressbookPage().getUserList();
        assertThat(userList.size(), lessThanOrEqualTo(Integer.parseInt(count)));
    }

    @Then("I '$shouldState' see '$userName' in Add Contacts on AddressBook page with logo '$logo'")
    public void checkUserInPopup(String shouldState, String userName, String logo) {
        String email = resolveUserNameToEmail(userName);
        String userId = getCoreApi().getUserByEmail(email).getId();
        AdbankAddressbookAddUsersPopUp adbankAddressbookPopUp = getSut().getPageCreator().getAdbankAddressbookAddUsersPopUp();
        String dropDownItem = adbankAddressbookPopUp.getDropdownUsersList().get(0);
        assertThat(dropDownItem, equalTo(getCoreApi().getUser(userId).getFirstName() + " " + getCoreApi().getUser(userId).getLastName() + "\n" + email));
        byte[] emptyLogo = Logo.EMPTY.getBytes();
        byte[] projectLogo = adbankAddressbookPopUp.getListLogoOnPopup().get(0);
        if (logo.equals("EMPTY")) {
            assertThat("Logo length", projectLogo.length, equalTo(emptyLogo.length));
            for (int i = 0; i < emptyLogo.length; i++) {
                assertThat(projectLogo[i], equalTo(emptyLogo[i]));
            }
        } else {
            log.debug("projectLogo.length = " + projectLogo.length);
            assertThat("Logo length", projectLogo.length, not(equalTo(emptyLogo.length)));
        }
    }


    @When("I select user with name '$userName' in AddUsersPopUp")
    public void selectUserInAssUsersPopUp(String userName) {
        String email = resolveUserNameToEmail(userName);
        getSut().getPageCreator().getAdbankAddressbookAddUsersPopUp().selectUserByEmail(email);
        Common.sleep(500);
    }

    @When("I select user with name '$userName' in AddUsersPopUp with email")
    public void selectUserInAssUsersPopUpWithEmail(String email) {
        getSut().getPageCreator().getAdbankAddressbookAddUsersPopUp().selectUserByEmail(email);
        Common.sleep(500);
    }

    @Then("I should see users list sorted by '$elementName' and order '$order'")
    public void checkDefaultSorting(String elementName, String order) {
        if ((order == null) || (order.isEmpty())) {
            order = "asc";
        }
        checkSorting(elementName, order);
    }

    @Then("I should see the team templates on the Address{ |}book page sorted Alphabetically")
    public void checkTeamTemplatesOrder() {
        List<String> teamTemplates = getCoreApi().getTeamTemplates(new ContactSearchingParams());
        List<String> teamTemplateNames = new ArrayList<>();
        for (String key: teamTemplates) {
            teamTemplateNames.add(key);
        }
        AdbankAddressbookPage adbankAddressbookPage = getSut().getPageCreator().getAdbankAddressbookPage();
        List<String> teamTemplatesFrontend = adbankAddressbookPage.getTeamTemplatesTexts();
        Collections.sort(teamTemplateNames, String.CASE_INSENSITIVE_ORDER);
        assertThat("Check that count of team templates on the list is equals count of team templates in the core", teamTemplatesFrontend.size(), equalTo(teamTemplateNames.size()));
        int i= 0;
        for (String str: teamTemplateNames) {
            assertThat("Check team templates name: " + str, teamTemplatesFrontend.get(i++), equalTo(str));
        }
    }

    @Then("I should see the team templates on Add users to templates popup sorted Alphabetically")
    public void checkTeamTemplatesOrderOnPopup() {
        List<String> teamTemplates = getCoreApi().getTeamTemplates(new ContactSearchingParams());
        List<String> teamTemplateNames = new ArrayList<>();
        for (String key: teamTemplates) {
            teamTemplateNames.add(key);
        }
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        List<String> teamTemplatesFrontend = adbankAddressbookPage.getTeamTemplatesOnPopupTexts();
        Collections.sort(teamTemplateNames, String.CASE_INSENSITIVE_ORDER);
        assertThat("Check that count of team templates on the list is equals count of team templates in the core", teamTemplatesFrontend.size(), equalTo(teamTemplateNames.size()));
        int i= 0;
        for (String str: teamTemplateNames) {
            assertThat("Check team templates name: " + str.trim(), teamTemplatesFrontend.get(i++).trim(), equalTo(str.trim()));
        }
    }

    @When("I sorting contacts by field '$sortField' in order '$order'")
    public void sortContactsList(String sortField, String order) {
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        if (!adbankAddressbookPage.getClassOfSortField(sortField).contains(order)) {
            adbankAddressbookPage.clickSortField(sortField);
            Common.sleep(1000);
            if (!adbankAddressbookPage.getClassOfSortField(sortField).contains(order)) {
                adbankAddressbookPage.clickSortField(sortField);
            }
        }
    }

    @Then("I should see results in accordance with '$elementName' and order '$order'")
    public void checkSorting(String elementName, String order) {
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        List<String> listFromPage = adbankAddressbookPage.getAllUserListElementById();
        List<String> listOfCompanies = adbankAddressbookPage.getAllCompaniesFromPage();
        List<String> sortedListFromPage = new ArrayList<String>();
        List<String> sortedListOfCompanies = new ArrayList<String>();

        sortedListFromPage.addAll(listFromPage);
        sortedListOfCompanies.addAll(listOfCompanies);
        if (order.equalsIgnoreCase("asc")) {
            if (elementName.equalsIgnoreCase("User")) {
                Collections.sort(sortedListFromPage, String.CASE_INSENSITIVE_ORDER);
            }
            if (elementName.equalsIgnoreCase("Company")) {
                Collections.sort(sortedListOfCompanies, String.CASE_INSENSITIVE_ORDER);
            }
        }
        else {
            if (elementName.equalsIgnoreCase("User")) {
                Collections.sort(sortedListFromPage);
            }
            if (elementName.equalsIgnoreCase("Company")) {
                Collections.sort(sortedListOfCompanies, Collections.reverseOrder(String.CASE_INSENSITIVE_ORDER));
            }
        }
        assertThat("Check count of contacts in the address book", sortedListFromPage.size(), equalTo(adbankAddressbookPage.getAllUserListElementById().size()));
        int i=0;
        for (String contact: sortedListFromPage) {
            assertThat("check contact value: " + contact, contact, equalTo(listFromPage.get(i++).trim()));
        }
    }

    @Given("I '$condition' see selected the following users on AddressBook")
    @Then("I '$condition' see selected the following users on AddressBook")
    public void checkThatUsersAreSelected(String condition) {
        boolean selected = condition.equals("should");
        AdbankAddressbookPage adbankAddressbookPage = getSut().getPageCreator().getAdbankAddressbookPage();
        int expectedCount = selected ? adbankAddressbookPage.getAllUserListElementById().size() : 0;
        assertThat(adbankAddressbookPage.getAllSelectedUserListElementById().size(), equalTo(expectedCount));
    }

    @Given("I filled team templates '$teamTemplateName' as '$state'")
    @When("I fill team templates '$teamTemplateName' as '$state'")
    public void fillAddUsersToTeamTemplate(String teamTemplateName, String state) {
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        AdbankAddressbookAddUserToTemplatesPopUp adbankAddressbookAddUserToTemplatesPopUp = new AdbankAddressbookAddUserToTemplatesPopUp(adbankAddressbookPage);
        if (!teamTemplateName.isEmpty()) {
            if (state.equals("new")) {
                String realTeamTemplateName = wrapVariableWithTestSession(teamTemplateName);
                adbankAddressbookAddUserToTemplatesPopUp.typeNewTemplateName(realTeamTemplateName);
            } else {
                String[] teamTemplateNames = teamTemplateName.split(",");
                for (String teamTemplateName1 : teamTemplateNames) {
                    String realTeamTemplateName = wrapVariableWithTestSession(teamTemplateName1);
                    adbankAddressbookAddUserToTemplatesPopUp.clickTeamTemplateCheckBox(realTeamTemplateName);
                }
            }
        }
    }

    @Given("I filled team templates '$teamTemplateName' as '$state' with no test session")
    @When("I fill team templates '$teamTemplateName' as '$state' with no test session")
    public void fillAddUsersToTeamTemplateWithNoTestSession(String teamTemplateName, String state) {
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        AdbankAddressbookAddUserToTemplatesPopUp adbankAddressbookAddUserToTemplatesPopUp = new AdbankAddressbookAddUserToTemplatesPopUp(adbankAddressbookPage);
        if (!teamTemplateName.isEmpty()) {
            if (state.equals("new")) {
                String realTeamTemplateName = teamTemplateName;
                adbankAddressbookAddUserToTemplatesPopUp.typeNewTemplateName(realTeamTemplateName);
            } else {
                String[] teamTemplateNames = teamTemplateName.split(",");
                for (String teamTemplateName1 : teamTemplateNames) {
                    String realTeamTemplateName = teamTemplateName1;
                    adbankAddressbookAddUserToTemplatesPopUp.clickTeamTemplateCheckBox(realTeamTemplateName);
                }
            }
        }
    }
    @Then("I '$condition' see that user '$userName' is selected")
    public void checkUsersCheckBox(String condition, String userName) {
        boolean should = condition.equals("should");
        String userId = getCoreApi().getContactByEmail(wrapUserEmailWithTestSession(userName)).getId();
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
//        assertThat("I check that user " + userName + " is selected", adbankAddressbookPage.getUsersCheckBoxById(userId).isSelected(), equalTo(should));
        assertThat("I check that user " + userName + " is selected", adbankAddressbookPage.isUserListElementSelected(userId), equalTo(should));
    }

    @Then("I '$condition' see the Add User To Team Template Popup")
    public void checkVisibilityOfPopup(String condition) {
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        boolean visible = adbankAddressbookPage.isAddUserToTeamTemplatePopupVisible();
        boolean should = condition.equals("should");
        assertThat("", visible, equalTo(should));
    }

    @Then("I '$condition' see users '$userName' in list")
    @Alias("I '$condition' see users '$userName' on the Address Book page")
    public void checkVisibility(String condition, String userName) {
        boolean should = condition.equals("should");
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        String[] usersNames = userName.split(",");
        for (int i=0; i< usersNames.length; i++) {
            String userId = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(usersNames[i])).getId();
            assertThat("", adbankAddressbookPage.isUserListElementVisible(userId), equalTo(should));
        }
    }

    @Then("I '$condition' see easyshare users '$userName' on the Address Book page")
    public void checkESUVisibility(String condition, String userName) {
        boolean should = condition.equals("should");
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        String[] usersNames = userName.split(",");
        Common.sleep(1000);
        for (String usersName : usersNames) {
            assertThat("User on the address book page",
                    adbankAddressbookPage.isUsersLinkVisible(wrapUserEmailWithTestSession(usersName)), equalTo(should));
        }
    }

    @Then("I see users in the user's list with next rules: $rules")
    public void checkUsersInList(ExamplesTable examplesTable) {
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        for (Map<String, String> row: examplesTable.getRows()) {
            boolean should = row.get("Should").equals("should");
            String userEmail = wrapUserEmailWithTestSession(row.get("UserName"));
            String userId = "";
            if (getCoreApi().getUserByEmail(userEmail) != null) {
                userId = getCoreApi().getUserByEmail(userEmail).getId();
            }else {
                userId = getCoreApi().getContactByEmail(userEmail).getId();
            }
            if (!userId.isEmpty()) {
                //assertThat("", adbankAddressbookPage.isUserCheckBoxVisible(userId), equalTo(should));
                assertThat("", adbankAddressbookPage.isUserListElementVisible(userId), equalTo(should));
            }
        }
    }

    @Then("I '$condition' see that user '$userName' is in the team template '$teamTemplateName' count '$count'")
    public void tempNameCheckUnexpected(String condition, String userName, String teamTemplateName, String count) {
        boolean should = condition.equals("should");
        int countOfUsers = count.isEmpty() ? 1 : Integer.parseInt(count);
        String realTeamTemplateName = wrapVariableWithTestSession(teamTemplateName);
        String userId;
        String userFullName;
        User user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
        if(user==null){
            Contact contact = getCoreApi().getContactByEmail(wrapUserEmailWithTestSession(userName));
            userId = contact.getId();
            userFullName = contact.getFirstName() + " " + contact.getLastName();
        }else{
            user = getCoreApi().getUserByEmail(wrapUserEmailWithTestSession(userName));
            userId = user.getId();
            userFullName = user.getFullName();
        }
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        adbankAddressbookPage.clickTeamTemplateItem(realTeamTemplateName);
        if (should) {
            List<String> usersFromList = adbankAddressbookPage.getAllUserListElementById();
            boolean isContainsFullName = false;
            for (String strFromList : usersFromList) {
                if (strFromList.contains(userFullName)) {
                    isContainsFullName = strFromList.contains(userFullName);
                    break;
                }
            }
            assertThat(isContainsFullName, equalTo(should));
        }
        assertThat("Users count in list", adbankAddressbookPage.getCountItemsInContactList(), equalTo(countOfUsers));
        assertThat("I check that user " + userName + " " + condition + " present in the template", adbankAddressbookPage.isUserListElementVisible(userId), equalTo(should));
    }

    @Then("I should see in the team templates next users: $userTable")
    public void checkUserInTeamTemplate(ExamplesTable userTable) {
        for(Map<String, String> row : userTable.getRows()) {
            String count= (row.get("Count") == null)?"":row.get("Count");
            tempNameCheckUnexpected(row.get("Should"), row.get("UserName"), row.get("TeamTemplate"), count);
        }
    }

    @Then("I '$condition' see that user '$userName' is in the team template '$teamTemplateName'")
    public void checkUsersInTheTeamTemplate(String condition, String userName, String teamTemplateName) {
        String[] usersName = userName.split(",");
        for (String uN: usersName) {
            tempNameCheckUnexpected(condition, uN, teamTemplateName, String.valueOf(usersName.length));
        }
    }

    @Given("I selected team template '$teamTemplateName' on Address{ |}{B|b}ook page")
    @When("I select team template '$teamTemplateName' on Address{ |}{B|b}ook page")
    public void clickTeamTemplate(String teamTemplateName) {
        String realTeamTemplateName = wrapVariableWithTestSession(teamTemplateName);
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        adbankAddressbookPage.clickTeamTemplateItem(realTeamTemplateName);
    }

    @Then("on adding users '$userName' to Address book should see message '$message'")
    public void addUserNoDelay(List<String> userNameList,String message) {
        AdbankAddressbookAddUsersPopUp popUp = openAddressbookAddUsersPopUp();
        for (String userName : userNameList) {
            popUp.selectUserByEmail(resolveUserNameToEmail(userName));
        }
        popUp.clickAddButtonInstant();
        if (!message.trim().isEmpty()) {
            String actualMessage = getSut().getPageCreator().getBasePage().getErrorMessage();
            assertThat(actualMessage, StringByRegExpCheck.matches(message));
        }

    }

    @Then("I '$condition' see team template '$teamTemplateName' and role '$roleName' as team template (role) under Templates Information on User details")
    public void checkTeamTemplateViaUserDetail(String condition, String teamTemplateName, String roleName) {
        boolean should = condition.equals("should");

        String realRoleName = wrapVariableWithTestSession(roleName);
        AdbankAddressbookPage adbankAddressbookPage = getSut().getPageCreator().getAdbankAddressbookPage();
        String  userDetailsTemplateInfo = adbankAddressbookPage.getUsersInfoTemplatesInformation();
        String[] realTeamTemplateNames = teamTemplateName.split(",");
        for (int i=0; i< realTeamTemplateNames.length; i++) {
            String realTeamTemplateName= wrapVariableWithTestSession(realTeamTemplateNames[i]);
            String checkString = realTeamTemplateName + " (" + realRoleName + ")";
            assertThat("", userDetailsTemplateInfo.contains(checkString), equalTo(should));
        }
    }

    @Then("I '$condition' see team template (role) under Templates Information on User details with next fields: $teamTemplatesInfo")
    public void checkTeamTemplateViaUserDetail(String condition, ExamplesTable teamTemplatesInfo) {
        boolean should = condition.equals("should");
        //|UserName|TeamTemplate|Role|should|
        AdbankAddressbookPage adbankAddressbookPage = getSut().getPageCreator().getAdbankAddressbookPage();
        String userDetailsTemplateInfo = adbankAddressbookPage.getUsersInfoTemplatesInformation();
        for (Map<String, String> row: teamTemplatesInfo.getRows()) {
            String checkString = wrapVariableWithTestSession(row.get("TeamTemplate")) + " (" + wrapVariableWithTestSession(row.get("Role")) + ")";
            assertThat("", userDetailsTemplateInfo.contains(checkString), equalTo(should));
        }
    }

    @Then("I '$condition' see selected user '$userName' on the Address{ |}{B|b}ook page")
    public void checkThatUserIsSelected(String condition, String userName) {
        boolean should = condition.equals("should");
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        String userId = getCoreApi().getContactByEmail(wrapUserEmailWithTestSession(userName)).getId();
        assertThat("", adbankAddressbookPage.isUserListElementSelected(userId), equalTo(should));
    }

    @Then("I '$condition' see confirm popup with message '$messageText' button Update Existing and link Rename Current")
    public void checkMessageForTeamTemplates(String condition, String messageText) {
        boolean should = condition.equals("should");
        AdbankAddressbookAddUserToTemplatesPopUp adbankAddressbookAddUserToTemplatesPopUp = new AdbankAddressbookAddUserToTemplatesPopUp(openAddressbookPage());
        assertThat("", adbankAddressbookAddUserToTemplatesPopUp.getTextOfConfirmPopup().contains(messageText), equalTo(should));
        assertThat("", adbankAddressbookAddUserToTemplatesPopUp.isUpdateExistingButtonVisible(), equalTo(should));
        assertThat("", adbankAddressbookAddUserToTemplatesPopUp.isRenameCurrentLinkVisible(), equalTo(should));
    }

    @Then("I '$condition' see team templates '$teamTemplatesName'")
    public void checkVisibilityOfTeamTemplates(String condition, String teamTemplatesName) {
        boolean should = condition.equals("should");
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        int countTT = adbankAddressbookPage.getCountOfTeamTemplates();
        if (countTT == 0) {
            assertThat(false, equalTo(should));
        } else {
            List<String> teamTemplatesFromPage = adbankAddressbookPage.getTeamTemplatesTexts();
            String[] teamTemplatesNames = teamTemplatesName.split(",");
            for (String str : teamTemplatesNames)
                assertThat(teamTemplatesFromPage.contains(str), equalTo(should));
        }
    }

    // | Email | Logo | Company | Result |
    @Then("I see contact in the user list with the following data: $data")
    public void checkVisibilityOfContact(ExamplesTable data) {
        AdbankAddressbookPage adbankAddressbookPage = openAddressbookPage();
        List<String> listFromPage = adbankAddressbookPage.getAllUserListElementById();
        List<String> listOfNames = new ArrayList<String>();
        List<String> listOfCompanies = new ArrayList<String>();
        for (String str: listFromPage) {
            String[] array = str.split("\n");
            listOfNames.add(array[0].trim());
            if (array.length > 1)
                listOfCompanies.add(array[1].trim());
        }

        for (int i = 0; i < data.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(data, i);
            Contact contact = getCoreApi().getContactByEmail(wrapUserEmailWithTestSession(row.get("Email")));
            boolean check = row.get("Result").equals("should");
            String companyName = getData().getAgencyByName(row.get("Company")).getName();
            Matcher matcherUser = check ? isIn(listOfNames) : not(isIn(listOfNames));
            Matcher matcherCompany = check ? isIn(listOfCompanies) : not(isIn(listOfCompanies));
            String userName = contact.getFirstName() + " " + contact.getLastName();
            assertThat(userName, matcherUser);
            assertThat(companyName, matcherCompany);
            if (row.get("Logo") != null) {
                byte[] emptyLogo = Logo.EMPTY.getBytes();
                byte[] projectLogo = adbankAddressbookPage.getLogo(contact.getId());
                if (row.get("Logo").equals("EMPTY")) {
                    assertThat("Logo length", projectLogo.length, equalTo(emptyLogo.length));
                    for (int j = 0; j < emptyLogo.length; j++) {
                        assertThat(projectLogo[j], equalTo(emptyLogo[j]));
                    }
                } else {
                    assertThat("Logo length", projectLogo.length, not(equalTo(emptyLogo.length)));
                }
            }
        }
    }

    @Then("I should see in the field users name on edit contact details email '$text'")
    public void checkUsersNameOnEditContactDetailsText(String text) {
        AdbankAddressbookPage adbankAddressbookPage = getSut().getPageCreator().getAdbankAddressbookPage();
        text = wrapUserEmailWithTestSession(text);
        assertThat("", adbankAddressbookPage.getUsersNameOnEditContactDetailsText().trim(), equalTo(text.trim()));
    }

    @When("I start type '$search' SearchCriteria on AddUsersPopUp page")
    public void typeSearchCriteria(String search) {
        openAddressbookPage().clickAddUser().startTypeUserMail(search);
    }

    @Given("I clicked invite button on the {A|a}ddress book page")
    @When("I click invite button on the {A|a}ddress book page")
    public void clickInviteUser() {
        AdbankAddressbookPage adbankAddressbookPage = getSut().getPageCreator().getAdbankAddressbookPage();
        adbankAddressbookPage.clickInviteButton();
        Common.sleep(2000);
    }

    @Given("I typed '$email' user email on Invite user popup")
    @When("I type '$email' user email on Invite user popup")
    public void typeUserEmailInviteUser(String search) {
        InviteUserPopup inviteUserPopup = new InviteUserPopup(getSut().getPageCreator().getAdbankAddressbookPage());
        inviteUserPopup.startTypeUserEmail(wrapUserEmailWithTestSession(search) + Keys.RETURN, 2000);
        Common.sleep(2000);
    }

    @Given("I typed '$email' user email on Invite user popup without click enter")
    @When("I type '$email' user email on Invite user popup without click enter")
    public void typeUserEmailInviteUserWithoutEnter(String search) {
        InviteUserPopup inviteUserPopup = new InviteUserPopup(getSut().getPageCreator().getAdbankAddressbookPage());
        inviteUserPopup.startTypeUserEmail(wrapUserEmailWithTestSession(search));
        Common.sleep(1000);
    }

    // | Email |
    @Given("I added following users to invite list: $usersTable")
    @When("I add following users to invite list: $usersTable")
    public void addUsersToInviteList(ExamplesTable usersTable) {
        InviteUserPopup inviteUserPopup = new InviteUserPopup(getSut().getPageCreator().getAdbankAddressbookPage());
        for (int i = 0 ; i < usersTable.getRowCount(); i++) {
            Map<String, String> row = parametrizeTabularRow(usersTable, i);
            inviteUserPopup.startTypeUserEmail(wrapUserEmailWithTestSession(row.get("Email")) + Keys.RETURN);
            Common.sleep(2000);
        }
    }

    @Given("I typed '$text' text on Invite user popup")
    @When("I type '$text' text on Invite user popup")
    public void typeTextInviteUser(String search) {
        InviteUserPopup inviteUserPopup = new InviteUserPopup(getSut().getPageCreator().getAdbankAddressbookPage());
        inviteUserPopup.startTypeUserEmail(search + Keys.RETURN);
    }

    @When("I cancel invite user")
    public void cancelInviteUser() {
        InviteUserPopup inviteUserPopup = new InviteUserPopup(getSut().getPageCreator().getAdbankAddressbookPage());
        inviteUserPopup.cancel.click();
    }

    @When("I close [x] invite user")
    public void closeInviteUser() {
        InviteUserPopup inviteUserPopup = new InviteUserPopup(getSut().getPageCreator().getAdbankAddressbookPage());
        inviteUserPopup.close.click();
    }

    @Given("I clicked '$action' invite user")
    @When("I click '$action' invite user")
    public void clickInviteUserOnPopup(String action) {
        InviteUserPopup inviteUserPopup = new InviteUserPopup(getSut().getPageCreator().getAdbankAddressbookPage());
        if (action.equalsIgnoreCase("invite")) inviteUserPopup.action.click();
        else if (action.equalsIgnoreCase("close")) inviteUserPopup.close.click();
        else if (action.equalsIgnoreCase("cancel")) inviteUserPopup.cancel.click();
        else inviteUserPopup.close.click();
        Common.sleep(2000);
    }

    @Then("I '$condition' see that invite button is disabled on add user popup")
    public void checkStateOfInviteButton(String condition) {
        InviteUserPopup inviteUserPopup = new InviteUserPopup(getSut().getPageCreator().getAdbankAddressbookPage());
        assertThat(inviteUserPopup.isInviteButtonDisabled(), equalTo(condition.equalsIgnoreCase("should")));
    }

    @Then("I '$condition' see value '$value' on the {I|i}nvite users popup")
    public void checkValueInTheInviteUser(String condition, String value) {
        boolean shouldState = condition.equalsIgnoreCase("should");
        String inviteValues = new InviteUserPopup(getSut().getPageCreator().getAdbankAddressbookPage()).getInviteValues();
        assertThat(inviteValues, shouldState ? containsString(value) : not(containsString(value)));
    }

    @Then("I should see '$message' on the invite users '$userEmail' dropdown")
    public void checkMessageOnTheInviteUsersDropdown(String message, String userEmail) {
        InviteUserPopup inviteUserPopup = new InviteUserPopup(getSut().getPageCreator().getAdbankAddressbookPage());
        String resultFromPopup = inviteUserPopup.getInviteDropdownListItemText();
        userEmail = wrapUserEmailWithTestSession(userEmail);
        assertThat(resultFromPopup.split("\n")[0], equalTo(userEmail));
        assertThat(resultFromPopup.split("\n")[1], equalTo(message));
    }


    @Then("I should see displayed users sorted by First Name alphabetically on Add User popup according to '$search'")
    public void checkListOfUsersOnAddUserPopup(String search) {
        AdbankAddressbookAddUsersPopUp adbankAddressbookPopUp = getSut().getPageCreator().getAdbankAddressbookAddUsersPopUp();
        List<String> usersList = adbankAddressbookPopUp.getDropdownUsersList();
        List<String> sortedUsersList = new ArrayList<String>();
        sortedUsersList.addAll(usersList);
        Collections.sort(sortedUsersList, String.CASE_INSENSITIVE_ORDER);
        assertThat(sortedUsersList, equalTo(usersList));
    }

    @Then("I should see displayed users '$users' on Add User popup according to '$search'")
    public void checkListOfUsersOnAddUserPopup(String users, String search) {
        AdbankAddressbookAddUsersPopUp adbankAddressbookPopUp = getSut().getPageCreator().getAdbankAddressbookAddUsersPopUp();
        List<String> usersList = adbankAddressbookPopUp.convertDijitStoreItemIntoDisplayedValues(
                adbankAddressbookPopUp.executeJsForLookUp(search, (users == null || users.isEmpty())));
        if ((users == null) || (users.isEmpty())) {
            assertThat(usersList.size(), equalTo(0));
            return;
        }
        List<String> sortedUsersList = new ArrayList<String>();
        sortedUsersList.addAll(usersList);
        Collections.sort(sortedUsersList, String.CASE_INSENSITIVE_ORDER);
        String[] usersArray = users.split(",");
        for (int i = 0; i < usersList.size(); i++) {
            assertThat(usersList.get(i), containsString(search));
            if (i < usersArray.length) {
                String[] userNameParts = usersArray[i].split("\\\\n");
                String userName = userNameParts[0];
                String userEmail = wrapUserEmailWithTestSession(userNameParts[1]);
                String checkString = userName + " " + userEmail;
                if (usersList.size() < 20) {
                    assertThat(usersList, hasItem(checkString));
                }
                else {
                    throw new IllegalStateException("I can't correct check this situation. Drop down list has 20 elements. Please verify example data");
                }
                log.debug("I check detail info: counter = " + i + " and users: " + users);
            }
        }
    }

    @Then("I should see displayed user '$users' logo '$logo' on Add User popup according to '$text'")
    public void checkLogoOnTheAddUserPopup(String users, String logo, String text) {
        if (logo.isEmpty())
            return;
        AdbankAddressbookAddUsersPopUp popup = getSut().getPageCreator().getAdbankAddressbookAddUsersPopUp();
        String[] logos = logo.split(",");
        List<String> listOfImages = popup.convertDijitStoreItemIntoLogoPath(
                popup.executeJsForLookUp(text, users.isEmpty()));
        assertThat(logos.length, lessThanOrEqualTo(listOfImages.size()));
        for (int i=0; i< logos.length; i++) {
            byte[] emptyLogo = Logo.EMPTY.getBytes();
            byte[] projectLogo = popup.getLogo(i);
            if (logos[i].equals("EMPTY")) {
                assertThat("Logo length", projectLogo.length, equalTo(emptyLogo.length));
                for (int k = 0; k < emptyLogo.length; k++) {
                    assertThat(projectLogo[k], equalTo(emptyLogo[k]));
                }
            } else {
                assertThat("Logo length", projectLogo.length, not(equalTo(emptyLogo.length)));
            }
        }
    }

     @Then("I should see selected '$selectedUser' in add user as contact to Address Book")
    public void checkSelectedUserOnTheAddUsersPopup(String selectedUser) {
        AdbankAddressbookAddUsersPopUp adbankAddressbookPopUp = getSut().getPageCreator().getAdbankAddressbookAddUsersPopUp();
        if (selectedUser.isEmpty()) {
            String text = adbankAddressbookPopUp.getElementWithSelectedUsers().getText();
            assertThat("Is users list empty", text.isEmpty() || text.equals("Start typing user name"), equalTo(true));
            return;
        }
        String[] selectedItems = adbankAddressbookPopUp.getElementWithSelectedUsers().getText().trim().split("\n");
        List<String> listOfSelectedItems = new ArrayList<String>();
        for (String str : selectedItems) {
            if (!str.isEmpty()) {
                String[] parts = getContext().imapUserName.split("@");
                str = str.replace(parts[0] + "+", "")
                        .replace(getData().getSessionId() + "@" + parts[1], "");
                listOfSelectedItems.add(str);
            }
        }
        assertThat(listOfSelectedItems.size(), greaterThan(0));
        assertThat(listOfSelectedItems.get(0).isEmpty() || listOfSelectedItems.get(0).equals("Start typing user name"), equalTo(false));

        String[] selectedUsers = selectedUser.split(",");
        for (int i = 0, k = 0; i<listOfSelectedItems.size() && k < selectedUsers.length; i++, k++) {
            //assertThat("", listOfSelectedItems.get(i), containsString(selectedUsers[k]));
            assertThat("", selectedUsers[k], isIn(listOfSelectedItems));
        }
    }

    @Then("I should see Company field with valid value on Address book page")
    public void checkCompanyField() {
        AdbankAddressbookPage adbankAddressbookPage = getSut().getPageCreator().getAdbankAddressbookPage();
        String agency = getCoreApi().getCurrentAgency().getName();
        assertThat(adbankAddressbookPage.getCompanyFieldValue(), equalTo(agency));
    }

    @Then("I '$condition' see invite button on the Address book page")
    public void checkVisibilityOfButtonInvite(String condition) {
        AdbankAddressbookPage adbankAddressbookPage = getSut().getPageCreator().getAdbankAddressbookPage();
        assertThat(adbankAddressbookPage.isInviteButtonVisible(), equalTo(condition.equalsIgnoreCase("should")));
    }

    protected String resolveUserNameToEmail(String name) { //should return email
        return resolveUserNameUser(name).getEmail();
    }

    protected String resolveUserNameToNameInList(String name) { //return name or email in case of es user
        String email = resolveUserNameToEmail(name);
        User user = getCoreApiAdmin().getUserByEmail(email);
        return ((user != null) && (user.getFirstName() != null)) ? user.getFirstName() + " " + user.getLastName() : email;
    }

    protected User resolveUserNameUser(String name) {
        return UserSteps.prepareUser(name);
    }
}