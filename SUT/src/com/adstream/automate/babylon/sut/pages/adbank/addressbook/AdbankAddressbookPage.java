package com.adstream.automate.babylon.sut.pages.adbank.addressbook;

import com.adstream.automate.babylon.sut.pages.adbank.BaseAdBankPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 21.06.12
 * Time: 14:17
 */
public class AdbankAddressbookPage extends BaseAdBankPage<AdbankAddressbookPage> {

    public AdbankAddressbookPage(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppear(By.cssSelector(".list-body"));
    }

    @Override
    public void isLoaded() {
        super.isLoaded();
        web.waitUntilElementAppear(By.cssSelector(".list-body"));
    }

    public WebElement getUserListElementById(String userId) {
        String locator = String.format("//div[contains(@class, 'users-list-item') and descendant::img[contains(@src, '%s')]]", userId);
        return web.findElement(By.xpath(locator));
    }

    public List<WebElement> getAllSelectedUserListElementById() {
        return web.findElements(By.cssSelector(".row.user.users_list_item.clearfix.pointer.abitem.border-bottom.checked"));
    }

    public List<String> getAllUserListElementById() {
        return web.findElementsToStrings(By.cssSelector(".row.user.users-list-item.clearfix.pointer.abitem.border-bottom"));
    }

    public List<String> getAllCompaniesFromPage() {
        return web.findElementsToStrings(By.cssSelector(".bold.company.h5"));
    }

    public void clickUserListElement(String userId) {
        String locator = String.format("//*[@data-dojo-type='admin.people.addressbook_item'][.//*[contains(@src,'%s') or @data-item='%s']]", userId, userId);
        web.click(By.xpath(locator));
        web.sleep(1000);
    }

    public void clickUserLinkElementOnTheList(String userId) {
        web.click(By.xpath(String.format("//*[@data-dojo-type='admin.people.addressbook_item'][.//*[contains(@src,'%s') or @data-item='%s']]//a[@data-role]", userId, userId)));
    }

    public boolean isUserListElementVisible(String userId) {
        String locator = String.format("//*[@data-dojo-type='admin.people.addressbook_item'][.//*[contains(@src,'%s') or @data-item='%s']]", userId, userId);
        return web.isElementVisible(By.xpath(locator));
    }

    public boolean isUserListElementSelected(String userId) {
        return getUserListElementById(userId).getAttribute("class").contains("checked");
    }

    public boolean isAddUserToTeamTemplatePopupVisible() {
        return web.isElementVisible(By.cssSelector(".popupWindow.dijitDialog.dijitDialogIncomplete.dijitIncomplete"));
    }

    public List<String> getUserList() {
        // FirstName + LastName, or email
        return web.findElementsToStrings(By.cssSelector("[data-dojo-type='admin.people.addressbook_item'] a.select-user"), "title");
    }

    public AdbankAddressbookAddUsersPopUp clickAddUser() {
        web.waitUntilElementAppearVisible(getAddContactsButtonLocator());
        web.sleep(4000);
        web.findElement(getAddContactsButtonLocator()).click();
        web.waitUntilElementAppearVisible(getAddContactsPopUpLocator());
        return new AdbankAddressbookAddUsersPopUp(web);
    }

    public void clickRemoveContactButton() {
        web.click(By.xpath("//*[@class='valign-middle prxs' and text()='Remove']"));
    }

    public void clickConfirmDeleteButton() {
        web.click(By.name("Delete"));
        web.sleep(1000);
    }

    public void clickCancelDeleteButton() {
        web.click(By.cssSelector(".popupWindow .cancel"));
    }

    public void clickAddToTeamTemplateButton() {
        web.waitUntilElementDisappear(getAddToTeamTemplateDisabledButtonLocator());
        web.click(By.cssSelector(".button.mlm[data-dojo-type='admin.people.addressbook_add_to_team_template_button']"));
    }

    public void clickRemoveLinkForTeamTemplate(String teamTemplateName) {
        web.click(By.xpath("//p[contains(text(), '" + teamTemplateName + "')]/a[text()='Remove']"));
    }

    public String getLogoSrc(String userId) {
        return web.findElement(By.cssSelector("img[src*='" + userId + "']")).getAttribute("src");
    }

    public byte[] getLogo(String userId) {
        return getDataByUrl(getLogoSrc(userId));
    }

    public void clickTeamTemplateItem(String teamTemplateName) {
        web.click(By.xpath("//span[contains(@class,'pls') and contains(text(), '" + teamTemplateName + "')]"));
        Common.sleep(1000);
    }

    public int getCountItemsInContactList() {
        return web.findElements(By.cssSelector(".row.user.users-list-item.clearfix.pointer.abitem.border-bottom")).size();
    }

    public String getUsersInfoTemplatesInformation() {
        return web.findElement(By.cssSelector(".templates-list.ptm")).getText();
    }

    public int getCountOfTeamTemplates() {
        if (!web.isElementPresent(By.cssSelector(".mbm.listSpecial.templates  .pls"))) {
            return 0;
        }
        return web.findElements(By.cssSelector(".mbm.listSpecial.templates  .pls")).size();
    }

    public List<String> getTeamTemplatesTexts() {
        List<String> result = new ArrayList<>();
        for (WebElement webElement: web.findElements(By.cssSelector(".mbm.listSpecial.templates  .pls"))) {
            result.add(webElement.getText());
        }
        return result;
    }

    public List<String> getTeamTemplatesOnPopupTexts() {
        List<String> result = new ArrayList<>();
        for (WebElement webElement: web.findElements(By.cssSelector(".mbsx label"))) {
            result.add(webElement.getText());
        }
        return result;
    }

    public String getContactInfoEmailValue() {
        return web.findElement(By.cssSelector("p .no-decoration")).getText();
    }

    public String getUsersNameOnEditContactDetailsText() {
        return web.findElement(By.cssSelector(".size3of8.pls span.h4")).getText();
    }

    public boolean isUsersLinkVisible(String userName) {
        return web.isElementVisible(By.cssSelector("a.first.link.no-decoration.team_link.select-user[title*='" + userName + "']"));
    }

    public List<String> getAllUsersLink() {
        return web.findElementsToStrings(By.cssSelector("a.first.link.no-decoration.team_link.select-user"));
    }

    public WebElement getSortFieldByFieldName(String fieldName) {
        return web.findElement(By.cssSelector("*[fieldname='" + convertSortFieldName(fieldName) + "']"));
    }

    public String convertSortFieldName(String fieldName) {
        if (fieldName.equalsIgnoreCase("user")) {
            return "firstName";
        } else if (fieldName.equalsIgnoreCase("company")) {
            return "company";
        }
        return fieldName;
    }

    public String getClassOfSortField(String fieldName) {
        WebElement webElement = getSortFieldByFieldName(fieldName);
        return webElement.getAttribute("class")==null?"":webElement.getAttribute("class");
    }

    public void clickSortField(String fieldName) {
        web.click(By.cssSelector("*[fieldname='" + convertSortFieldName(fieldName) + "']"));
    }

    public String getCompanyFieldValue() {
        return web.findElement(getCompanyFieldLocator()).getAttribute("value");
    }

    public boolean isInviteButtonVisible() {
        return web.isElementPresent(By.cssSelector(".button.mlm.invite_user"))
                && web.isElementVisible(By.cssSelector(".button.mlm.invite_user"));
    }

    public InviteUserPopup clickInviteButton() {
        web.click(By.cssSelector(".button.mlm.invite_user"));
        return new InviteUserPopup(this);
    }

    private By getCompanyFieldLocator() {
        return By.name("company");
    }

    private By getAddContactsButtonLocator() {
        return By.cssSelector(".button.add-to-contacts");
    }

    private By getAddContactsPopUpLocator() {
        return By.cssSelector(".popupWindow.dijitDialogFixed.dijitDialog");
    }

    private By getAddToTeamTemplateDisabledButtonLocator() {
        return By.xpath("//div[contains(@id,'admin_people_addressbook_add_to_team_template_button') and contains(@class,'button mlm disabled')]");
    }


}
