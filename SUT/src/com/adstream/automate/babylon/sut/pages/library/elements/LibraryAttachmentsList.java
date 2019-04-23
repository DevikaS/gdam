package com.adstream.automate.babylon.sut.pages.library.elements;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.List;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/*
 * Created by demidovskiy-r on 10.10.2014.
 */
public class LibraryAttachmentsList extends AdbankLibraryAssetAttachmentsPage {
    public static final String ROOT_NODE = ".itemsList";

    public LibraryAttachmentsList(ExtendedWebDriver web) {
        super(web);
    }

    @Override
    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(getListLocator());
    }

    @Override
    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementPresent(getListLocator()));
    }

    public static class Attachment {
        private LibraryAttachmentsList parent;
        private ExtendedWebDriver web;
        private List<WebElement> cells;
        private String fileName;
        private String size;
        private String description;
        private String uploadedBy;
        private Button downloadBtn;
        private Button editBtn;
        private Button deleteBtn;

        public Attachment(LibraryAttachmentsList parent, ExtendedWebDriver web, WebElement row) {
            this.parent = parent;
            this.web = web;
            cells = row.findElements(By.className("cell-content"));
            fileName = getElementTitle(cells.get(0));
            size = getElementText(cells.get(1));
            description = getElementTitle(cells.get(2));
            uploadedBy = getElementText(cells.get(3)).replaceAll("\n", " ");
            downloadBtn = new Button(parent, generateButtonElement("i16x16_download-grey"));
            editBtn = new Button(parent, generateButtonElement("i16x16_pencil"));
            deleteBtn = new Button(parent, generateButtonElement("i16x16_trash"));
        }

        public String getFileName() {
            return fileName;
        }

        public String getSize() {
            return size;
        }

        public String getDescription() {
            return description;
        }

        public String getUploadedBy() {
            return uploadedBy;
        }

        public AdbankDeleteAssetsAttachmentPopUp getDeleteAttachmentPopUp() {
            if (!web.isElementVisible(By.xpath(AdbankDeleteAssetsAttachmentPopUp.TITLE_NODE)))
                clickDeleteBtn();
            return new AdbankDeleteAssetsAttachmentPopUp(parent, AdbankDeleteAssetsAttachmentPopUp.TITLE);
        }

        public AdbankEditAssetsAttachmentPopUp getEditAttachmentPopUp() {
            if (!web.isElementVisible(By.xpath(AdbankEditAssetsAttachmentPopUp.TITLE_NODE)))
                clickEditBtn();
            return new AdbankEditAssetsAttachmentPopUp(parent, AdbankEditAssetsAttachmentPopUp.TITLE);
        }

        private String getElementTitle(WebElement element) {
            return element.getAttribute("title");
        }

        private String getElementText(WebElement element) {
            return element.getText().trim();
        }

        private WebElement generateButtonElement(String partialLocator) {
            return cells.get(4).findElement(By.className(partialLocator));
        }

        private void clickDeleteBtn() {
            deleteBtn.click();
        }

        private void clickEditBtn() {
            editBtn.click();
        }
    }

    public Attachment getAttachmentByName(String fileName) {
        for (Attachment attachment: getAttachments())
            if (attachment.getFileName().equals(fileName))
                return attachment;
        return null;
    }

    public List<String> getVisibleAttachmentNames() {
        List<String> attachedFileNames = new ArrayList<>();
        List<Attachment> attachments = getAttachments();
        if (attachments == null) return attachedFileNames;
        for (Attachment attachment: attachments)
            attachedFileNames.add(attachment.getFileName());
        return attachedFileNames;
    }

    private List<Attachment> getAttachments() {
        if (!web.isElementPresent(getItemListLocator())) return null;
        List<WebElement> rows = web.findElements(getItemListLocator());
        List<Attachment> attachments = new ArrayList<>();
        for (WebElement row: rows)
            attachments.add(new Attachment(this, web, row));
        return attachments;
    }

    private By getItemListLocator() {
        return By.cssSelector(String.format("%s %s", ROOT_NODE, ".row"));
    }

    private By getListLocator() {
        return By.cssSelector(ROOT_NODE);
    }
}