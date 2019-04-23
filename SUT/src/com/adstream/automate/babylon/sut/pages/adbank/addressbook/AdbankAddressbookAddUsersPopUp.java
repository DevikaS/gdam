package com.adstream.automate.babylon.sut.pages.adbank.addressbook;

import com.adstream.automate.babylon.sut.data.DijitStoreItems;
import com.adstream.automate.babylon.sut.pages.adbank.BaseAdBankPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Control;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;
import static com.thoughtworks.selenium.SeleneseTestBase.fail;

/**
 * Created with IntelliJ IDEA.
 * User: savitskiy-a
 * Date: 26.06.12
 * Time: 11:50
 */
public class AdbankAddressbookAddUsersPopUp extends BaseAdBankPage {
    private DojoCombo addUserComboBox;
    private Control popUpContainer;
    public Edit emailEdit;
    public Button addButton;

    public AdbankAddressbookAddUsersPopUp(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        popUpContainer.visible();
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(popUpContainer.isVisible());
    }

    @Override
    public void init() {
        super.init();
        String popupLocator = ".popupWindow.dijitDialog:not([style*='display: none'])";
        addUserComboBox = new DojoCombo(this, By.cssSelector(popupLocator + " [role='combobox']"));
        popUpContainer = new Control(this, By.cssSelector(popupLocator));
        emailEdit = new Edit(this, By.cssSelector(popupLocator + " [role=textbox]"));
        addButton = new Button(this, By.cssSelector(popupLocator + " [name=Save]"));
    }

    public AdbankAddressbookAddUsersPopUp typeUserMail(String email) {
        if (email.contains(",")){
            String[] emails = email.split(",");
            for (int i=0; i< emails.length; i++) {
                emailEdit.type(emails[i]+ Keys.ENTER);
            }
        }  else {
            emailEdit.type(email + Keys.ENTER);
        }
        return this;
    }

    public AdbankAddressbookAddUsersPopUp startTypeUserMail(String email) {
        emailEdit.typeWithInterval(email, 100);
        web.sleep(1000);
        return this;
    }

    public AdbankAddressbookAddUsersPopUp typeUserTextWithPause(String text, int sleep) {
        emailEdit.type(text, sleep);
        return this;
    }

    public AdbankAddressbookPage clickAddButton() {
        web.waitUntilElementAppear(By.cssSelector(".popupWindow.dijitDialog:not([style*='display: none']) [name='Save']:not([class~='disabled'])"));
        addButton.click();
        return new AdbankAddressbookPage(web);
    }

   public void selectUserByEmail(String email) {
        emailEdit.type(email);
        web.sleep(1000);
        web.click(By.xpath(String.format("//*[contains(@id,'Autocomplete')]//*[@role='option'][contains(.,'%s')]", email)));
    }

    public List<String> getUserList() {
        return web.findElementsToStrings(By.cssSelector(".popupWindow.dijitDialog:not([style*='display: none']) .itemsList .row .size1of4 span.plxs")); // First name
    }

    public byte[] getLogoOnPopup(String userId) {
        return getDataByUrl(getLogoOnPopupSrc(userId));
    }

    public String getLogoOnPopupSrc(String userId) {
        return web.findElement(By.cssSelector(".popupWindow.dijitDialog:not([style*='display: none']) img[src*='" + userId+ "']")).getAttribute("src");
    }

    public WebElement getEmailOnUsersPopup(String email) {
        return web.findElement(By.xpath("//div[@class='plxs']/span[normalize-space(@title)='" + email+ "']"));
    }

    public WebElement getFirstNameOnUsersPopup(String firstName) {
        return web.findElement(By.cssSelector(".plxs[title='" + firstName + "']"));
    }

    public WebElement getLastNameOnUsersPopup(String lastName) {
        return web.findElement(By.xpath("//div[@class='plxs']/span[text()='" + lastName + "']"));
    }

    public List<String> getDropdownUsersList() {
        return web.findElementsToStrings(By.xpath("//span[@class='dijitComboBoxHighlightMatch']/parent::span"));
    }

    public List<DijitStoreItems> executeJsForLookUp(String value, boolean isEmpty) {
        List<DijitStoreItems> result = new ArrayList<DijitStoreItems>();
        String script = "var adijit = dijit.getEnclosingWidget(dojo.query('.suggestor')[0]);\n" +
                "adijit._startSearch('" + value.replace("'", "\\'") + "');\n " +
                "var arr = adijit.store._items;\n" +
                "var out = [];\n" +
                "for (key in arr) {\n" +
                "var obj = arr[key].i;\n" +
                "var item = [];\n" +
                "item.push(obj.firstName);\n" +
                "item.push(obj.lastName);\n" +
                "item.push(obj.email);\n" +
                "item.push(obj.displayedValue);\n" +
                "item.push(obj.avatar);\n" +
                "out.push(item);\n" +
                "}\n" +
                "return out;";
        Object list = web.getJavascriptExecutor().executeScript(script);
        long startTime = System.currentTimeMillis();
        while (((List<Object>)list).size() == 0) {
            list = web.getJavascriptExecutor().executeScript(script);
            Common.sleep(1000);
            if (System.currentTimeMillis() - startTime > 5000) {
                if (!isEmpty) {
                    fail("JS works so long");
                }
                else {
                    break;
                }

            }
        }
        for (int i=0; i<((ArrayList) list).size(); i++) {
            DijitStoreItems dijitStoreItems = new DijitStoreItems();
            dijitStoreItems.setDisplayedValue(((List<String>)((ArrayList) list).get(i)).get(3));
            dijitStoreItems.setLogoPath(((List<String>)((ArrayList) list).get(i)).get(4));
            result.add(dijitStoreItems);
        }
        return result;
    }

    public List<String> convertDijitStoreItemIntoDisplayedValues(List<DijitStoreItems> list) {
        List<String> result = new ArrayList<String>();
        for (DijitStoreItems dijitStoreItems: list) {
            result.add(dijitStoreItems.getDisplayedValue());
        }
        return result;
    }

    public List<String> convertDijitStoreItemIntoLogoPath(List<DijitStoreItems> list) {
        List<String> result = new ArrayList<String>();
        for (DijitStoreItems dijitStoreItems: list) {
            result.add(dijitStoreItems.getLogoPath());
        }
        return result;
    }

    public List<WebElement> getImagesInTheDropdownList() {
        return web.findElements(By.xpath("//span[@class='dijitComboBoxHighlightMatch']/parent::span/parent::div/span/img"));
    }

    public List<String> getDropdownLogoSrcList() {
        List<String> result = new ArrayList<String>();
        for (WebElement webElement: web.findElements(By.xpath("//span[@class='dijitComboBoxHighlightMatch']/parent::span/preceding-sibling::span/img"))) {
            result.add(webElement.getAttribute("src"));
        }
        return result;
    }

    public List<byte[]> getListLogoOnPopup() {
        List<byte[]> result = new ArrayList<byte[]>();
        for (String element: getDropdownLogoSrcList()) {
            result.add(getDataByUrl(element));
        }
        return result;
    }

    public WebElement getElementWithSelectedUsers() {
        return web.findElement(By.cssSelector(".as-selections"));
    }

    public byte[] getLogo(int num) {
        return getDataByUrl(getDropdownLogoSrcList().get(num));
    }

    public void clickAddButtonInstant() {
        web.waitUntilElementAppear(By.cssSelector(".popupWindow.dijitDialog:not([style*='display: none']) [name='Save']:not([class~='disabled'])"));
        addButton.click();
    }

}
