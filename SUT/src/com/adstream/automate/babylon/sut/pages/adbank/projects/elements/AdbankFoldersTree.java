package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoFolderMenu;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * User: Ruslan Semerenko
 * Date: 04.05.12 20:30
 */
public class AdbankFoldersTree extends AdbankProjectTabs {
    public AdbankFoldersTree(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(By.cssSelector("[data-dojo-type='adbank.projects.sidebar']"));
        Common.sleep(1000);
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(By.cssSelector("[data-dojo-type='adbank.projects.sidebar']")));
    }

    public String createFolder(String folderName) {
        return createFolder(folderName, null, false);
    }

    public String createFolder(String folderName, String parentId) {
        return createFolder(folderName, parentId, false);
    }

    public String createFolder(String folderName, String parentId, boolean isDuplicate) {
        if (folderName == null) folderName = "";

        if (!isDuplicate && !folderName.isEmpty()) {
            WebElement link = getFolderLink(folderName, parentId);
            if (link != null) return extractFolderId(link.getAttribute("href"));
        }

        String folderLocator;
        String escapedFolderName;

        if (folderName.contains("'")) {
            escapedFolderName = String.format("concat('%s')", folderName.replaceAll("'", "',\"'\",'"));
        } else {
            escapedFolderName = String.format("'%s'", folderName);
        }

        if (parentId == null) {
            folderLocator = String.format("//*[contains(@class,'tree-root')]/li/div//a[contains(@data-role,'folder-link')][contains(.,%s)]",
                    escapedFolderName);
        } else {
            folderLocator = String.format("//*[@data-item-id='%s']/ul/li/div//a[contains(@data-role,'folder-link')][contains(.,%s)]",
                    parentId, escapedFolderName);
        }

        clickCreateFolder(parentId).setFolderName(folderName).action.click();
        web.sleep(500);

        if (!folderName.isEmpty()) {
            String href;

            try {
                href = web.waitUntilElementAppearVisible(By.xpath(folderLocator)).getAttribute("href");
            } catch (StaleElementReferenceException e) {
                // do it again. folders sorting removes dom node
                href = web.waitUntilElementAppearVisible(By.xpath(folderLocator)).getAttribute("href");
            }

            return extractFolderId(href);
        } else {
            return parentId;
        }
    }

    public WebElement selectFolder(String folderName, String parentId) {
        return getFolderLink(folderName, parentId);
    }

    public WebElement selectFolderInTrash(String folderName, String parentId) {
        return getFolderLinkInTrash(folderName, parentId);
    }

    public void createFolderButClickCancel(String folderName, String parentId) {
        clickCreateFolder(parentId).setFolderName(folderName).cancel.click();
    }

    public void createFolderButClickCloseWindowButton(String folderName, String parentId) {
        clickCreateFolder(parentId).setFolderName(folderName).cancel.click();
    }

    public void renameFolder(String folderId, String newFolderName) {
        clickEditFolder(folderId).setFolderName(newFolderName).action.click();
        web.sleep(1000);
    }

    public void removeFolder(String folderId) {
        clickDeleteFolder(folderId).action.click();
        web.sleep(1000);
    }

    public void removeCollection(String collectionId) {
        clickDeleteCollection(collectionId).action.click();
        web.sleep(1000);
    }

    public void renameCollection(String collectionId, String newCollectionName) {
        RenameCollectionPopUp renameCollectionPopUp = clickRenameCollection(collectionId);
        renameCollectionPopUp.setCollectionName(newCollectionName).action.click();
        web.sleep(1000);
    }

    public void cancelRemoveFolder(String folderId) {
        clickDeleteFolder(folderId).cancel.click();
        web.sleep(1000);
    }

    public void restoreFolder(String folderId, String path) {
       SelectFolderRestorePopUpWindow restorePopUpWindow = clickRestoreFolder(folderId);
       restorePopUpWindow.selectFolder(path);
       restorePopUpWindow.action.click();
       web.sleep(1000);
    }

    public void crossRestoreFolder(String folderId, String path) {
        SelectFolderRestorePopUpWindow restorePopUpWindow = clickRestoreFolder(folderId);
        restorePopUpWindow.selectFolder(path);
        restorePopUpWindow.close.click();
        web.sleep(1000);
    }

    public void cancelRestoreFolder(String folderId, String path) {
        SelectFolderRestorePopUpWindow restorePopUpWindow = clickRestoreFolder(folderId);
        restorePopUpWindow.selectFolder(path);
        restorePopUpWindow.cancel.click();
        web.sleep(1000);
    }

    public SelectFolderRestorePopUpWindow clickRestoreButtonForFolder(String folderId) {
        return clickRestoreFolder(folderId);
    }

    //return links only first level children from parent
    public List<WebElement> getFoldersLinks(String parentId) {
        String locator;
        if (parentId == null) {
            locator = ".title a.tree-root, .tree-root > li > div a[data-role='folder-link']";
        } else {
            locator = String.format("[data-item-id='%s'] > ul > li > div a[data-role='folder-link']", parentId);
        }
        if (!web.isElementPresent(By.cssSelector(locator)))
            return new ArrayList<>();
        else
            return web.findElements(By.cssSelector(locator));
    }

    public List<WebElement> getFoldersLinksInTrash(String parentId) {
        String locator;
        if (parentId == null) {
            locator = ".trash-content > .relative > .title>div>a";
        } else {
            locator = String.format(".trash-content [data-item-id='%s'] .relative>.title>div>a", parentId);
        }
        if (web.isElementPresent(By.cssSelector(locator))) {
            return web.findElements(By.cssSelector(locator));
        }  else {
            return new ArrayList<>();
        }
    }

    public WebElement getFolderLink(String folderName, String parentId) {
        for (WebElement link : getFoldersLinks(parentId)) {
            if (link.getText().trim().equals(folderName)) return link;
        }
        return null;
    }

    public void expandFolder(String folderName) {
        By locator = By.xpath(String.format(
                "//*[not(contains(@class,'active'))][*[contains(@class,'title')]//*[contains(text(),'%s')]]/*[contains(@class,'centered')]",folderName));
        if (web.isElementVisible(locator)) web.click(locator);
    }

    public void expandRootFolder(String rootFolderName){
        By locator = By.xpath(String.format("//*[*[contains(@class,'title')]//*[contains(text(),'%s')]]/*[contains(@class,'arrow')]",rootFolderName));
        if (web.isElementVisible(locator)) web.click(locator);
    }

    public WebElement getFolderLinkInTrash(String folderName, String parentId) {
        for (WebElement link : getFoldersLinksInTrash(parentId)) {
            if (link.getText().equals(folderName)) return link;
        }
        return null;
    }

    public String extractFolderId(String uri) {
        if (!uri.contains("/folders/")) return null;
        int start = uri.indexOf("/folders/") + "/folders/".length();
        int end = uri.indexOf("/", start);
        return uri.substring(start, end);
    }

    public String getCurrentFolderId() {
        return extractFolderId(web.getCurrentUrl());
    }

    public String getCurrentFolderName() {
        By locator = By.cssSelector(".tree-item.current span:last-child");
        return web.findElement(locator).getText();
    }

    public String extractFolderIdInTrash(String uri) {
        if (!uri.contains("/trash/")) return null;
        int start = uri.indexOf("/trash/") + "/trash/".length();
        int end = uri.indexOf("/", start);
        return uri.substring(start, end);

    }

    public List<String> getSelectedFilesId() {
        List<String> id = new ArrayList<>();
        for (String link : web.findElementsToStrings(By.cssSelector(".file-list-item.selected .file-context a"), "href")) {
            int start = link.indexOf("/files/") + "/files/".length();
            int end = link.indexOf("/", start);
            id.add(link.substring(start, end));
        }
        return id;
    }

    private NewEditFolderPopUpWindow clickCreateFolder(String folderId) {
        clickItemInFolderMenu("create", folderId);
        return new NewEditFolderPopUpWindow(this);
    }

    private NewEditFolderPopUpWindow clickEditFolder(String folderId) {
        clickItemInFolderMenu("edit", folderId);
        return new NewEditFolderPopUpWindow(this);
    }

    private PopUpWindow clickDeleteFolder(String folderId) {
        clickItemInFolderMenu("delete", folderId);
        return new PopUpWindow(this);
    }

    private PopUpWindow clickDeleteCollection(String collectionId) {
        clickItemInCollectionMenu("delete", collectionId);
        return new PopUpWindow(this);
    }

    private RenameCollectionPopUp clickRenameCollection(String collectionId) {
        clickItemInCollectionMenu("rename", collectionId);
        return new RenameCollectionPopUp(this);
    }

    private SelectFolderRestorePopUpWindow clickRestoreFolder(String folderId) {
        clickItemInFolderTrashBinMenu("restore", folderId);
        return new SelectFolderRestorePopUpWindow(this);
    }

    public AddShareFolderForUserPopUpWindow clickShare(String folderId) {
        web.waitUntilElementAppearVisible(By.cssSelector(".tree-block .title a:not(.folder-name)"));
        clickItemInFolderMenu("share", folderId);
        web.sleep(1000);
        return new AddShareFolderForUserPopUpWindow(this);
    }

    public void clickOpen(String folderId) {
        web.waitUntilElementAppearVisible(By.cssSelector(".tree-block .title a:not(.folder-name)"));
        clickItemInFolderMenu("Open folder", folderId);
        web.sleep(1000);
    }

    public void downloadBySendplusFolder(String folderId) {
        clickDownloadBySendplusFromFolder(folderId);
        web.sleep(1000);
    }

    private void clickItemInFolderMenu(String cssClass, String folderId) {
        openFolderMenu(folderId).clickMenuEntry(cssClass);
    }

    private void clickItemInCollectionMenu(String cssClass, String collectionId) {
        openCollectionMenu(collectionId).clickMenuEntry(cssClass);
    }

    private void clickItemInFolderTrashBinMenu(String cssClass, String folderId) {
        DojoFolderMenu menu = openTrashFolderMenu(folderId);
        menu.clickMenuEntry(cssClass);
    }

    public void clickDownloadBySendplusFromFolder(String folderId) {
        web.waitUntilElementAppearVisible(By.cssSelector(".tree-block .title a:not(.folder-name)"));
        clickItemInFolderMenu("downloadByNverge", folderId);
        web.sleep(1000);

    }

    public DojoFolderMenu openFolderMenu(String folderId) {
        By locator;
        web.sleep(1000);
        if (folderId == null) {
            locator = By.xpath("//*[contains(@class,'title')][div/a[contains(@class,'tree-root')]]");
        } else {
            locator = By.xpath(String.format("//*[contains(@class,'title')][div/a[contains(@href,'%s')]]", folderId));

        }

        web.sleep(1000);
        DojoFolderMenu menu = new DojoFolderMenu(this, locator);
        menu.openMenu();
        web.sleep(1000);
        return menu;
    }

    public DojoFolderMenu openCollectionMenu(String collectionId) {
        By locator = By.cssSelector(String.format("[data-item-id='%s'] > .title", collectionId));
        DojoFolderMenu menu = new DojoFolderMenu(this, locator);
        menu.openMenu();
        return menu;
    }

    public DojoFolderMenu openTrashFolderMenu(String folderId) {
        By locator = By.xpath(String.format("//li[@data-item-id='%s']/div//a", folderId));
        DojoFolderMenu menu = new DojoFolderMenu(this, locator) {
            @Override
            protected void initMenu(WebElement rootNode) {
                WebElement eventLoader = getEventLoader(rootNode);
                if (eventLoader != null) {
                    getDriver().getJavascriptExecutor().executeScript("dijit.getEnclosingWidget(arguments[0]).eventFire();", eventLoader);
                }
            }

            private WebElement getEventLoader(WebElement rootNode) {
                By locator = By.cssSelector("a + [data-dojo-type='common.onEventLoader']");
                try {
                    return rootNode.findElement(locator);
                } catch (Exception e) {
                    return null;
                }
            }
        };
        menu.openMenu();
        return menu;
    }

    public boolean isItemsPresentInFoldersPopUpMenu(String textItem) {
        return web.isElementVisible(getItemInFoldersPopUpMenuLocatorByXPath(textItem));
    }

    public void typeFolderNameInSearchFoldersField(String folderName) {
        web.findElement(getSearchFoldersFieldByCssSelector()).click();
        web.findElement(getSearchFoldersFieldByCssSelector()).sendKeys(folderName);
        web.sleep(500);
        if (!web.isElementPresent(By.xpath("//*[@role='alert' and string-length(.)>0]")))
            web.findElement(By.xpath("//*[contains(@id,'common_menu_highlight')]")).click();
    }

    public String getFoldersPath() {
        WebElement element = web.findElement(getFoldersPathByCssSelector());
        return element.getText();
    }

    public List<String> getAllTabsNames () {
        return web.findElementsToStrings(By.cssSelector(".line.plm > a"));
    }

    public List<String> getAllFoldersName() {
        return web.findElementsToStrings(By.cssSelector("[data-role='folder-link']"));
    }

    private By getItemInFoldersPopUpMenuLocatorByXPath(String textItem) {
        return By.xpath(String.format("//table[contains(@class, 'dijitMenu')]//span[normalize-space(text())='%s']", textItem));
    }

    private By getFoldersPathByCssSelector() {
        return By.cssSelector("div[class='unit']");
    }

    private By getSearchFoldersFieldByCssSelector() {
        return By.cssSelector("[data-dojo-type='adbank.shared.search_folders']");
    }
}