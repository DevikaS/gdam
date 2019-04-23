package com.adstream.automate.babylon.sut.pages.adbank.projects.elements;

import com.adstream.automate.babylon.sut.elements.controls.complex.PopUpWindow;
import com.adstream.automate.babylon.sut.pages.library.AdbankAddFileToLibraryPage;
import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Page;
import com.adstream.automate.page.controls.DojoSelect;
import com.adstream.automate.utils.Common;
import org.apache.commons.lang3.StringEscapeUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

/**
 * User: ruslan.semerenko
 * Date: 22.06.12 14:36
 */
public class AdbankFilesPage extends AdbankFoldersTree {
    public static enum MediaType {
        IMAGE("image-type"),
        AUDIO("audio-type"),
        VIDEO("video-type"),
        PRINT("file-type"),
        DIGITAL("all-type"),
        DOCUMENT("document-type"),
        OTHER("other-type");

        private String mediaType;

        private MediaType(String mediaType) {
            this.mediaType = mediaType;
        }

        public String toString() {
            return mediaType;
        }
    }

    public static class FileMetadata {
        private String name;
        private String shortId;
        private String type;

        protected FileMetadata(ExtendedWebDriver web, String fileName) {
            String baseLocator = String.format("//*[contains(@class,'file-info')][.//a[contains(text(),'%s')]]", fileName);
            name = fileName;
            shortId = web.findElement(By.xpath(String.format("%s//*[contains(@class,'file-parameters')]/div[1]", baseLocator))).getText().trim();
            type = web.findElement(By.xpath(String.format("%s//*[contains(@class,'file-detail')][1]/*", baseLocator))).getText().trim();
        }

        public String getName() {
            return name;
        }

        public String getShortId() {
            return shortId;
        }

        public String getType() {
            return type;
        }
    }

    public AdbankFilesPage(ExtendedWebDriver web) {
        super(web);
    }

    public boolean isFilePresent(String fileName) {
        return getFilesCount(fileName) > 0;
    }

    public String getFileApprovalStatus(String fileName) {
        String locator = String.format("//*[contains(@class,'file-info')][.//*[normalize-space()='%s']]//*[contains(@class,'icon-status')]", fileName);
        if (web.isElementPresent(By.xpath(locator)))
            return web.findElement(By.xpath(locator)).getAttribute("title").toLowerCase();
        return null;
    }

    public String getFileTitle(String fileId) {
        String locator = String.format(".file-info a[href*='%s']", fileId);
        if (web.isElementPresent(By.cssSelector(locator)))
            return web.findElement(By.cssSelector(locator)).getText();
        return null;
    }

    public List<String> getFoldersTitles() {
        return web.findElementsToStrings(By.cssSelector("[data-dojo-type='adbank.files.FolderListItem'] a[title]"), "title");
    }

    public List<String> getObjectsText() {
        List<WebElement> elements = getUploadedElements();
        List<String> objectsText = new ArrayList<>(elements.size());
        for (WebElement element : elements) {
            String text = element.getText();
            objectsText.add(text);
        }
        return objectsText;
    }

    public List<String> getObjectsTitle() {
        List<WebElement> elements = getUploadedElements();
        List<String> objectsText = new ArrayList<>(elements.size());
        for (WebElement element : elements) {
            String text = element.getAttribute("title").trim();
            objectsText.add(text);
        }
        return objectsText;
    }

    public List<String> getObjectsTextTrashBin() {
        List<WebElement> elements = getDeletedElementsTrashBin();
        List<String> objectsText = new ArrayList<>(elements.size());
        for (WebElement element : elements) {
            String text = element.getText();
            objectsText.add(text);
        }
        return objectsText;
    }

    public boolean isPreviewAvailable() {
        By fileInfoLocator = By.className("file-info");
        By filePreviewLocator = By.cssSelector(".file-item .preview [data-dojo-type='common.imageResizer']");
        int fileInfoCount = 0, filePreviewCount = 0;
        if (web.isElementPresent(fileInfoLocator))
            fileInfoCount = web.findElements(fileInfoLocator).size();
        if (web.isElementPresent(filePreviewLocator))
            filePreviewCount = web.findElements(filePreviewLocator).size();
        return fileInfoCount == filePreviewCount;
    }

    public boolean isFilePreviewVisible() {
        return web.isElementVisible(By.cssSelector("img[data-dojo-type='common.imageResizer']"));
    }

    public boolean isFilePreviewVisible(String fileId) {
        return web.isElementPresent(By.cssSelector("img[src*='" + fileId + "']"));
    }

    public List<WebElement> getUploadedElements() {
        return web.findElements(getUploadedElementsByCssSelector());
    }

    public List<String> getUploadedElementsText() {
        if (!web.isElementPresent(getUploadedElementsByCssSelector())) {
            return new ArrayList<>();
        }
        return web.findElementsToStrings(getUploadedElementsByCssSelector());
    }

    public List<String> getPresentedAssetsTitles() {
        By locator = By.cssSelector(".file-info a.no-decoration");
        return web.isElementPresent(locator) ? web.findElementsToStrings(locator) : new ArrayList<String>();
    }

    private List<WebElement> getDeletedElementsTrashBin() {
        return web.findElements(getDeletedElementsTrashBinByCssSelector());
    }

    public String getSelectedSortingType() {
        return web.findElement(getSelectedSortingTypeByXpath()).getText();
    }

    public String getSelectedSortingTypeTrashBin() {
        return web.findElement(getSelectedSortingTypeTrashBinByCss()).getText();
    }

    // order: asc, desc
    public void sortListViewByColumn(String columnName, String order) {
        String locator = String.format("//div[@data-dojo-type='common.table.headerColumn2' and div[text()='%s']]", columnName);
        By filesContainerLocator = By.cssSelector("[data-dojo-type='adbank.files.virtualScroll']");
        WebElement element = web.findElement(By.xpath(locator));
        if (!element.getAttribute("class").contains(order)) {
            WebElement filesContainer = web.findElement(filesContainerLocator);
            element.click();
            web.waitUntilElementChanged(filesContainer);
            element = web.findElement(By.xpath(locator));
            if (!element.getAttribute("class").contains(order)) {
                filesContainer = web.findElement(filesContainerLocator);
                element.click();
                web.waitUntilElementChanged(filesContainer);
            }
        }
    }

    public void openLoadedFile(String fileName) {
        web.findElement(getLinkUploadedFileLocatorByLinkText(fileName)).click();
        web.sleep(1000);
    }

    private By getLinkUploadedFileLocatorByLinkText(String fileName) {
        return By.linkText(fileName);
    }

    private By getSelectedSortingTypeByXpath() {
        return By.xpath("//table[contains(@id,'adbank_files_files_sort')]");
    }

    private By getSelectedSortingTypeTrashBinByCss() {
        return By.cssSelector("table[id*='adbank_files_sort_by']");
    }

    private By getUploadedElementsByCssSelector() {
        return By.cssSelector("[data-role='fileCard'] .ptxs a");
    }

    private By getDeletedElementsTrashBinByCssSelector() {
        return By.cssSelector(".sizeof1.overflow-hidden.ptxs > span");
    }

    public JumpLoaderPage clickUploadButton() {
        throw new RuntimeException("Jumploader was replaced with pluploader. Do not click 'Upload' button.");
//        web.click(By.xpath("//*[text()='Upload']"));
//        return new JumpLoaderPage(web);
    }

    public AddShareFolderForUserPopUpWindow clickShareFolderButton() {
        web.click(By.xpath("//span[text()='Share folder']"));
        Common.sleep(2000);
        return new AddShareFolderForUserPopUpWindow(this);
    }

    public ShareFilesPopup clickShareFilesButton() {
        web.click(By.cssSelector(".button[id*='share_file']:not(.disabled)"));
        return new ShareFilesPopup(this);
    }

    public NewEditFolderPopUpWindow clickNewFolderButton() {
        // web.click(By.xpath("//span[text()='New Folder']"));
        web.waitUntilElementAppear(By.xpath("//span[text()='New Folder']")).click();
        return new NewEditFolderPopUpWindow(this);
    }

    public boolean isNewFolderButtonVisible() {
        return web.isElementPresent(By.xpath("//span[text()='New Folder']")) && web.isElementVisible(By.xpath("//span[text()='New Folder']"));
    }

    public boolean isShareButtonVisible() {
        By buttonLocator = By.cssSelector(".button.share:not([id*='file'])");
        return web.isElementPresent(buttonLocator) && web.isElementVisible(buttonLocator);
    }

    public boolean isShareButtonEnable() {
        return web.findElement(By.cssSelector(".button.share:not([id*='file'])")).isEnabled();
    }

    public boolean isMoreButtonVisible() {
        By locator = getMoreButtonLocator();
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    private boolean isMoreBtnMenuVisible() {
        return web.isElementVisible(getMoreBtnMenuLocator());
    }

    public boolean isMoreMenuOptionVisible(String option) {
        return web.isElementVisible(getMoreMenuOptionLocator(option));
    }

    public boolean isActiveMoreMenuOption(String option) {
        return isMoreMenuOptionVisible(option) && web.findElement(getMoreMenuOptionLocator(option)).getAttribute("aria-disabled").equals("false");
    }

    public AdbankFilesPage clickMoreButton() {
        if (isMoreButtonVisible() && !isMoreBtnMenuVisible()) {
            web.click(getMoreButtonLocator());
            web.sleep(1000);
        }
        return this;
    }

    public void clickEditAllSelectedFromMoreDropDown(){
        By locator = By.xpath("//span[.='Edit all selected']");
        if (web.isElementPresent(locator) && web.isElementVisible(locator)) {
            web.click(locator);
            web.sleep(2000);
        }
    }

    public void clickEditOneByOneSelectedFromMoreDropDown(){
        By locator = By.xpath("//span[.='Edit selected one by one']");
        if (web.isElementPresent(locator) && web.isElementVisible(locator)) {
            web.click(locator);
            web.sleep(2000);
        }
    }

    public AdbankFilesPage clickMoreButtonforOtherLocale() {
        if ((web.findElement(By.xpath("//span[.='Mehr']")).isDisplayed())) {
            web.click(By.xpath("//span[.='Mehr']"));
            web.sleep(1000);
        }
        return this;
    }

    public void clickDownloadByProject()

    {
        web.click(getTopDownloadButtonLocator());
        web.sleep(1000);
        web.click(getDownloadByProjectLocator());
    }

    public void clickDownloadByFolder()

    {
        web.click(getTopDownloadButtonLocator());
        web.sleep(1000);
        web.click(getDownloadByFolderLocator());
    }

    public void clickEditUsageRightsButtonFromMoreDropDown() {
        By locator = By.xpath("//span[.='Edit Usage Rights']");
        if (web.isElementPresent(locator) && web.isElementVisible(locator)) {
            web.click(locator);
            web.sleep(2000);
        }
    }

    public boolean isEditUsageRightPopUpAvaiable() {
        return web.isElementPresent(By.xpath("//*[@class='windowHead'][descendant::span[text()[contains(.,'Edit Usage Rights for')]]]"));
    }

    public PopUpWindow clickRemoveButton() {
        By locator = By.xpath("//span[.='Remove']");
        if (web.isElementPresent(locator) && web.isElementVisible(locator)) {
            web.click(locator);
            web.sleep(2000);
        }
        return new PopUpWindow(this);
    }

    public void clickSendToLibrary() {
        web.click(By.xpath("//span[.='Send to Library']"));
        web.sleep(2000);
        //QA-344 Handle the new popup which appears when we send file to library and it already exists Code Change Starts by Geethanjali.K
        By locator = By.cssSelector(".popupWindow.dijitDialogFixed.dijitDialog");
        if (web.isElementPresent(locator) && web.isElementVisible(locator)) {
            ItemAlreadyExistInLibraryPopUp itemAlreadyExist = new ItemAlreadyExistInLibraryPopUp(this);
            if (itemAlreadyExist.isPopUpVisible()) {
                itemAlreadyExist.send.click();
            }
        }
        //QA-344 Handle the new popup which appears when we send file to library and it already exists Code Change Ends by Geethanjali.K
    }

    //QA-345 Handle the new popup which appears when we send file to library and it already exists Code Change Starts by Geethanjali.K
    public void clickSendToLibraryButton() {
        web.click(By.xpath("//span[.='Send to Library']"));
        web.sleep(2000);
    }
    //QA-345 Handle the new popup which appears when we send file to library and it already exists Code Change Starts by Geethanjali.K

    public void clickSendToDelivery() {
        web.click(getMoreMenuOptionLocator("Send to Delivery"));
    }

    public void clickSendToDeliveryForOtherLocale(String locale) {
        if (locale.equalsIgnoreCase("German"))
            web.click(getMoreMenuOptionLocator("Neuen Auftrag aus Datei(en)"));
    }

    public OrderItemPage sendToDelivery() {
        clickSendToDelivery();
        return new OrderItemPage(web);
    }

    public OrderItemPage sendToDeliveryForOtherLocale(String locale) {
        clickSendToDeliveryForOtherLocale(locale);
        return new OrderItemPage(web);
    }

    public void clickDeleteMenuItem() {
        By locator = By.xpath("//span[text()='Delete']");
        if (!web.isElementVisible(locator)) {
            clickMoreButton();
        }
        web.click(locator);
        web.sleep(1000);
    }

    public MoveCopyPopUpWindow clickMoveMenuItem() {
        web.click(By.xpath("//span[.='Move']"));
        return new MoveCopyPopUpWindow(this);
    }

    public MoveCopyPopUpWindow clickMoveMenuItemforOtherLocale(String localeMore) {
        if (localeMore.equalsIgnoreCase("German")) {
            web.click(By.xpath("//span[.='Verschieben']"));
        }
        return new MoveCopyPopUpWindow(this);
    }

    public SendForApprovalPopUp clickSendForApprovalItem() {
        web.click(By.xpath("//span[.='Send for approval']"));
        return new SendForApprovalPopUp(this);
    }

    public MoveCopyPopUpWindow clickCopyMenuItem() {
        web.click(By.xpath("//span[.='Copy']"));
        return new MoveCopyPopUpWindow(this);
    }

    public AdbankAddFileToLibraryPage clickSendToLibraryMenuItem() {
        web.click(By.xpath("//span[.='Send to Library']"));
        web.sleep(2000);
        return new AdbankAddFileToLibraryPage(web);
    }

    public void clickDeleteButtonOnPopupWindow() {
        web.click(By.name("Delete"));
    }

    public void clickCancelButtonOnPopupWindow() {
        web.click(By.cssSelector(".popupWindow .cancel"));
    }

    public void clickCrossButtonOnPopupWindow() {
        web.click(By.cssSelector("[title*='Are you sure to delete this file'] [dojoattachpoint='closeButtonNode']"));
    }

    public AdbankFilesPage selectFileByFileName(String fileName) {


//        String locatorFormat = isViewOfFilesIsTile()
//                ? "//a[@title='%s']/ancestor::node()[5]/../div[@class='wrapper relative']"
//                : "//*[@data-role='fileCard'][.//a[@title='%s']]//*[@data-dojo-type='common.imageResizer']";

        //1096 merge
        String locatorFormat = isViewOfFilesIsTile()
                ? "//a[@title='%s']/ancestor::node()[5]/../div[contains(@class,'wrapper')]"
                : "//*[@data-role='fileCard'][.//a[@title='%s']]";
        //1096 merge
        By locator = By.xpath(String.format(locatorFormat, fileName));
        if (!web.isElementPresent(locator)) {
            locator = By.xpath(String.format(locatorFormat, StringEscapeUtils.escapeXml10(fileName)));
        }
        web.clickThroughJavascript(locator);
        web.sleep(500);
        return this;
    }


    public boolean isFolderSelected(String folderName) {
        String locatorFormat = String.format("//*[contains(@class,'preview')][following-sibling::*[contains(@class,'file-info')]//a[normalize-space()='%s']]/../..", folderName);
        return web.findElement(By.xpath(locatorFormat)).getAttribute("class").contains("selected");
    }

    public void selectFileByFileId(String fileId) {
        String locatorFormat = "//div[following-sibling::div[@class='file-info' and descendant::a[contains(@href,'%s')]]]";
        web.clickThroughJavascript(By.xpath(String.format(locatorFormat, fileId)));
        web.sleep(500);
    }

    public SelectFolderRestorePopUpWindow clickRestoreButtonSelectedFileOnTrashBinPage(String fileName) {
        web.click(getRestoreButtonSelectedFileLocator(fileName));
        return new SelectFolderRestorePopUpWindow(this);
    }

    public SelectFolderRestorePopUpWindow clickRestoreButtonOnTrashBinPage() {
        web.click(getRestoreButtonLocator());
        return new SelectFolderRestorePopUpWindow(this);
    }

    public int getFilesCountByFileName(String fileName) {
        String locator = String.format("//*[@class='file-info']//*[.='%s']/ancestor::div[@class='wrapper']", fileName);
        if (!web.isElementPresent(By.xpath(locator))) return 0;
        return web.findElements(By.xpath(locator)).size();
    }

    public List<String> getAllSelectedFileNames() {
        return web.findElementsToStrings(By.cssSelector(".file-item.selected .file-info [title]"));
    }

    public boolean isAssetPresentsByFileId(String fileId) {
        By locator = By.cssSelector(String.format(".file-info a[href*='%s']", fileId));
        return web.isElementPresent(locator) && web.isElementVisible(locator);
    }

    public static class ConfirmRemovePopUp extends PopUpWindow {
        public ConfirmRemovePopUp(Page parentPage) {
            super(parentPage);
        }

        public boolean isPopUpVisible() {
            return parentPage.getDriver().isElementVisible(getPopUpLocator());
        }

        private By getPopUpLocator() {
            return By.cssSelector(getParentElement());
        }
    }

    public ConfirmRemovePopUp getConfirmRemoveAssetPopUp() {
        return new ConfirmRemovePopUp(this);
    }

    public boolean isConfirmationPopupPresented() {
        return getConfirmRemoveAssetPopUp().isPopUpVisible();
    }

    public List<WebElement> getAllChildrenOfTrashBin() {
        return web.findElements(By.xpath("//div[contains(@class,'trash-wrapper')]/child::*"));
    }

    public String getSelectedFolderName() {
        return web.findElement(By.cssSelector(".ui-content-pane.updated li span[class='valign-middle']")).getText();
    }

    public boolean isMediaTypeFilterEnabled(MediaType type) {
        String locator = String.format("//div[@class='controller mediaTypeControll %s on']", type);
        return web.isElementPresent(By.xpath(locator));
    }

    public void toggleMediaTypeFilter(MediaType type) {
        String locator = String.format("//div[starts-with(@class, 'controller mediaTypeControll %s')]", type);
        web.click(By.xpath(locator));
        Common.sleep(3000);
    }

    public void setMediaTypeFilterEnabled(MediaType type, boolean enabled) {
        if (isMediaTypeFilterEnabled(type) ^ enabled) toggleMediaTypeFilter(type);
    }

    public void selectMediaSubType(String subType) {
        DojoSelect subTypeSelect = new DojoSelect(this, By.className("mediaSubTypeControll"));
        subTypeSelect.selectByVisibleSubString(subType);
        Common.sleep(1000);
    }

    public boolean isUploadButtonVisible() {
        return web.isElementVisible(By.xpath("//span[.='Upload']"));
    }

    public int getAllFilesCountTrashBin() {
        return web.findElements(By.cssSelector(".file-info .blue")).size();
    }

    public int getAllFilesCount() {
        return web.findElements(By.cssSelector("[data-type='tableRow']")).size();
    }

    public boolean isSearchInputVisible() {
        return web.isElementVisible(By.cssSelector(".popupWindow input.ui-input"));
    }

    public void selectSomeFiles(int count) {
        int upperLimit = Math.min(count, web.findElements(By.cssSelector(".wrapper")).size());
        for (int i = 0; i < upperLimit; i++) {
            web.findElements(By.cssSelector(".wrapper")).get(i).click();
        }
    }

    public boolean isMediaSubTypeDisabled() {
        WebElement mediaSubType = web.findElement(getMediaSubTypeControllLocator());
        String attr = mediaSubType.getAttribute("aria-disabled");
        return attr.contains("disabled") || attr.contains("true");
    }

    public void openFile(String fileName) {
        String locator = String.format("//div[@class='preview' and following-sibling::div//a[text()='%s']]/a/div", fileName);
        web.clickThroughJavascript(By.xpath(locator));
        Common.sleep(1000);
    }

    public FileMetadata getFileMetadata(String fileName) {
        return new FileMetadata(web, fileName);
    }

    public DownloadFilePopUpWindow clickDownloadButton() {
        By downloadOptionLocator = By.xpath("//*[contains(@class, 'dijitMenuItemLabel')]/*[text()='Download']");
        web.waitUntilElementDisappear(getDownloadDisabledButtonLocator());
        long deadline = System.currentTimeMillis() + 15000;
        do {
            if (System.currentTimeMillis() > deadline) {
                throw new RuntimeException("Could not find download option within 15 seconds");
            }
            web.click(getDownloadButtonLocator());
            Common.sleep(1000);
        } while (!web.isElementVisible(downloadOptionLocator));
        web.click(downloadOptionLocator);
        Common.sleep(1000);
        return new DownloadFilePopUpWindow(this);
    }

    public int getCountOfAdbankedIcon() {
        if (!web.isElementPresent(By.cssSelector("a .adbanked"))) return 0;
        return web.findElements(By.cssSelector("a .adbanked")).size();
    }

    public String getSystemInfoByFileName(String name) {
        return web.findElement(By.xpath("//a[normalize-space(@title)='" + name + "']/parent::div/following-sibling::div")).getText();
    }

    public boolean isPreviewForFileAvailable(String name) {
        By locator = By.xpath(
                String.format("//a[normalize-space(.)='%s']/ancestor::div[contains(@class,'file-info')]/preceding-sibling::div//img[@data-dojo-type='common.imageResizer']", name));
        return web.isElementPresent(locator);
    }

    public boolean isAssetNameWrapped(String name) {
        By locator = By.xpath(String.format("//*[contains(@class,'file-parameters')]/*[normalize-space()='%s']", name));
        return web.findElement(locator).getCssValue("text-overflow").contains("ellipsis");
    }

    public void clickTileView() {
        web.click(By.cssSelector("[data-switch-mode='tile']"));
        Common.sleep(1000);
    }

    public void clickListView() {
        web.click(By.cssSelector("[data-switch-mode='list']"));
        Common.sleep(1000);
    }

    public boolean isViewOfFilesIsList() {
        return web.isElementPresent(By.cssSelector("[data-switch-mode='list'].active"))            // list view icon active
                && web.isElementVisible(By.cssSelector("[data-dojo-type='common.table.header']"))  // files list header is present
                && !web.isElementPresent(By.cssSelector(".file-item"));                            // there is no files in tile view
    }

    public boolean isViewOfFilesIsTile() {
        return web.isElementPresent(By.cssSelector("[data-switch-mode='tile'].active"))            // tile view icon active
                && !web.isElementVisible(By.cssSelector("[data-dojo-type='common.table.header']")) // files list header isn't visible
                && !web.isElementPresent(By.cssSelector(".row"));                                  // there is no files in list view
    }

    public void scrollDownToFooter(int filesCount) {
        long startTime = System.currentTimeMillis();
        boolean isNeedRefresh = true;
        while (web.findElements(By.cssSelector("[data-type='tableRow']")).size() < filesCount) {
            web.scrollToElement(web.findElement(By.cssSelector(".footer.clearfix")));
            web.sleep(2000);
            if (System.currentTimeMillis() - startTime > 60000 && isNeedRefresh) {
                web.navigate().refresh();
                isNeedRefresh = false;
            }
            if (System.currentTimeMillis() - startTime > 120000) {
                throw new Error("Timeout while waiting for scroll to page footer");
            }
        }
    }

    public AddAssetsFromLibraryPopup openAddAssetsFromLibraryPopup() {
        web.click(By.cssSelector("[data-dojo-type='adbank.files.addFromLibraryButton']"));
        return new AddAssetsFromLibraryPopup(this);
    }

    protected By getDownloadDisabledButtonLocator() {
        return By.cssSelector(".disabled[data-dojo-type='common.downloadDialog']");
    }

    protected By getDownloadButtonLocator() {
        return By.xpath("//*[@data-dojo-type='adbank.files.file_list_control_panel']//*[text()='Download']");
    }

    private By getRestoreButtonLocator() {
        return By.cssSelector("[id*='adbank_files_restore_file']");
    }

    private By getRestoreButtonSelectedFileLocator(String fileName) {
        return By.xpath("//*[@class='file-info']//*[.='" + fileName + "']/ancestor::div[@class='wrapper']//button[.='Restore']");
    }

    private By getMediaSubTypeControllLocator() {
        return By.cssSelector(".mediaSubTypeControll");
    }

    private By getMoreButtonLocator() {
        return By.xpath("//span[text()='More']");
    }
    private By getDownloadByProjectLocator() {
        return By.xpath("//span[text()='Download Project by SendPlus']");
    }

    private By getDownloadByFolderLocator() {
        return By.xpath("//span[text()='Download Folder(s) by SendPlus']");
    }

    private By getTopDownloadButtonLocator() {
        return By.xpath("//span[text()='Download']");
    }

    private By getMoreBtnMenuLocator() {
        return By.cssSelector(".dijitPopup:last-child .dijitMenu");
    }

    private By getMoreMenuOptionLocator(String option) {
        return By.xpath("//tr[contains(@aria-label,'" + option + "')]");
    }

    public AddColumnsProjectWindow clickByAddColumnProjectListButton() {
        if(!web.isElementVisible(By.cssSelector("[data-dojo-type='common.table.tableControlDropdown']")))
            web.click(By.cssSelector("[data-role=\"dropButton\"]"));
        return new AddColumnsProjectWindow(this);
    }

    public List<String> getProjectsFields() {
        List<String> fields = new ArrayList<>();
        List<WebElement> headerLoc = web.findElements(getHeaderColumnsLocator());
        for(WebElement element:headerLoc){
            fields.add(element.getText().trim());
        }
        return fields;
    }

    private By getHeaderColumnsLocator() {
        return By.cssSelector("[data-dojo-type='common.table.header'] [fieldname]:not(.none-display)");
    }
}