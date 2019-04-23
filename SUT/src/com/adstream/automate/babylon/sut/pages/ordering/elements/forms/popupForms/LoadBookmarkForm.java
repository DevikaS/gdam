package com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.babylon.sut.pages.ordering.PageElement;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.AbstractPopUpLayer;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.DeleteBookmarkPopUp;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Link;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import java.util.ArrayList;
import java.util.List;

/*
 * Created by demidovskiy-r on 12.05.14.
 */
public class LoadBookmarkForm extends AbstractPopUpLayer {
    public final static String ROOT_NODE = POPUP_ROOT_NODE + " #loadBookmarksTable";

    public LoadBookmarkForm(OrderItemPage parent) {
        super(parent);
        this.action = new Button(parent, generatePopUpElementLocator("+ * [name='apply']"));
        this.cancel = new Link(parent, generatePopUpElementLocator("+ * [name='cancel']"));
    }

    @Override
    protected void initControls() {
    }

    @Override
    protected void loadForm() {
        getDriver().waitUntilElementAppearVisible(getFormLocator());
    }

    @Override
    protected void unloadForm() {
        getDriver().waitUntilElementDisappear(getFormLocator());
    }

    @Override
    protected String getRootNode() {
        return ROOT_NODE;
    }

    public static class Bookmark extends PageElement<OrderItemPage> {
        private WebElement row;
        private String name;
        private WebElement removeBtn;
        private WebElement selectIcon;

        public Bookmark(ExtendedWebDriver web, OrderItemPage parent, WebElement row) {
            super(web, parent);
            this.row = row;
            List<WebElement> cells = row.findElements(getElementLocatorByNode("inline-display"));
            name = cells.get(0).getText();
            removeBtn = cells.get(1).findElement(getElementLocatorByNode("removeBookmark"));
            selectIcon = cells.get(2).findElement(getElementLocatorByNode("selectedBookmark"));
        }

        public String getName() {
            return name;
        }

        public void selectBookmark() {
            if (!isSelectIconVisible()) {
                selectRow();
                web.waitUntil(ExpectedConditions.visibilityOf(selectIcon));
            }
        }

        public boolean isRemoveBookmarkIconVisible() {
            return removeBtn.isDisplayed();
        }

        public DeleteBookmarkPopUp getDeleteBookmarkPopUp() {
            if (!web.isElementVisible(By.xpath(DeleteBookmarkPopUp.TITLE_NODE)))
                clickRemoveBtn();
            return new DeleteBookmarkPopUp(parent, DeleteBookmarkPopUp.TITLE);
        }

        private boolean isSelectIconVisible() {
            return selectIcon.isDisplayed();
        }

        private void selectRow() {
            row.click();
        }

        private void clickRemoveBtn() {
            removeBtn.click();
        }

        private By getElementLocatorByNode(String rootNode) {
            return By.className(rootNode);
        }
    }

    public Bookmark getBookmarkByName(String name) {
        for (Bookmark bookmark : getBookmarks())
            if (bookmark.getName().equals(name))
                return bookmark;
        return null;
    }

    public List<String> getVisibleBookmarkNames() {
        List<String> bookmarksNames = new ArrayList<>();
        List<Bookmark> bookmarks = getBookmarks();
        if (bookmarks == null) return bookmarksNames;
        for (Bookmark bookmark : bookmarks)
            bookmarksNames.add(bookmark.getName());
        return bookmarksNames;
    }

    public void loadBookmark() {
        clickOkBtn();
    }

    private List<Bookmark> getBookmarks() {
        if (!getDriver().isElementPresent(getBookmarkRowLocator())) return null;
        List<WebElement> rows = getDriver().findElements(getBookmarkRowLocator());
        List<Bookmark> bookmarks = new ArrayList<>();
        for (WebElement row: rows)
            bookmarks.add(new Bookmark(getDriver(), (OrderItemPage)parent, row));
        return bookmarks;
    }

    private By getBookmarkRowLocator() {
        return generateFormElementLocator(".row-load-bookmark");
    }

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }
}