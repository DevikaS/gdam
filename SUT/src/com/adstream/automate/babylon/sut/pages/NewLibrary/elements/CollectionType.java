package com.adstream.automate.babylon.sut.pages.NewLibrary.elements;

import com.adstream.automate.babylon.sut.pages.NewLibrary.pages.NewAdbankLibraryAssetAttachmentsPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.utils.Common;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

public enum CollectionType {
    NEW("new"),
    SUB("sub");

    private String type;

    private CollectionType(String collectionType) {
        this.type = collectionType;
    }

    public String getType(){
        return this.type;
    }

    public String toString() {
        return this.type;
    }

    public static CollectionType findByType(String type){
        for (CollectionType collectionType : values()) {
            if(collectionType.getType().equals(type))
                return collectionType;
        }
        throw new IllegalArgumentException("Unknown Collection type: " + type);
    }

    /**
     * Created by Janaki.Kamat on 25/09/2017.
     */
    public static class AttachmentsList extends NewAdbankLibraryAssetAttachmentsPage {
           public static final String ROOT_NODE = ".attachments-list";

           public AttachmentsList(ExtendedWebDriver web) {
                super(web);
            }

            @Override
            public void load() {
                super.load();
                web.waitUntilElementAppearVisible(By.cssSelector("asset-tab-attachments"));
            }

            @Override
            public void isLoaded() throws Error {
                super.isLoaded();
                assertTrue(web.isElementPresent(By.cssSelector("asset-tab-attachments")));
            }

        public static class Attachment {
            private AttachmentsList parent;
            private ExtendedWebDriver web;
            private WebElement cells;
            private String fileName;
            private String size;

            public String getDescription() {
                return description;
            }

            private String description;
            private static final String openPopupAttachmentsSelector = "following-sibling::ads-md-menu//*[@ng-click=\"$mdOpenMenu($event)\"]";

            public WebElement getCells() {
                return cells;
            }

            public Attachment(AttachmentsList parent, ExtendedWebDriver web, WebElement row) {
                this.parent = parent;
                this.web = web;
                cells = row.findElement(By.cssSelector(".attachment-description"));
                fileName = cells.findElement(By.cssSelector(".h6.margin-0-0.ng-binding")).getText();
                description=web.isElementPresent(By.xpath("//*[contains(@class,\"attachment-file-description-text\")]"))?cells.findElement(By.xpath("following-sibling::div//*[contains(@class,\"attachment-file-description-text\")]")).getText():"";
                size = cells.findElement(By.xpath("div[2]")).getText();
            }

            public String getFileName() {
                return fileName;
            }

            public String getSize() {
                return size;
            }


            public LibDeleteAssetsAttachmentPopUp openDeleteAttachmentPopUp() {
                getCells().findElement(By.xpath(openPopupAttachmentsSelector)).click();
                Common.sleep(1000);
                List<WebElement> popupElement=web.findElements(By.cssSelector("[click=\"$ctrl.removeAttachment($event, attachment)\"] button"));
                for(WebElement elem:popupElement){
                    if(elem.isDisplayed())
                        elem.click();
                }
                return new LibDeleteAssetsAttachmentPopUp(parent);
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
            return By.cssSelector(String.format("%s %s", ROOT_NODE, ".attachment-row"));
        }

        private By getListLocator() {
            return By.cssSelector(ROOT_NODE);
        }

        }
}
