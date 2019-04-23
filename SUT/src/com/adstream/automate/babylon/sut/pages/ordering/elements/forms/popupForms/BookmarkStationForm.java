package com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.AbstractPopUpLayer;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.SaveBookmarkPopUp;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.Checkbox;
import com.adstream.automate.page.controls.Edit;
import com.adstream.automate.page.controls.Link;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.List;

/*
 * Created by demidovskiy-r on 07.05.14.
 */
public class BookmarkStationForm extends AbstractPopUpLayer {
    public final static String ROOT_NODE = POPUP_ROOT_NODE + " .b-bookmark";
    private Edit name;
    private Checkbox makeBookmarkAvailableToAllBuUsers;

    public BookmarkStationForm(OrderItemPage parent) {
        super(parent);
        this.action = new Button(parent, generatePopUpElementLocator("+ * [name='apply']"));
        this.cancel = new Link(parent, generatePopUpElementLocator("+ * [name='cancel']"));
    }

    @Override
    protected void initControls() {
        controls.put("Name", name = new Edit(parent, generateFormElementLocator("[data-role='bookmarkName']")));
        controls.put("Make Bookmark Available To All BU Users", makeBookmarkAvailableToAllBuUsers = new Checkbox(parent, generateFormElementLocator("[data-role='shared']")));
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

    public static class Station {
        private ExtendedWebDriver web;
        private String serviceLevel;
        private String destinationName;
        private WebElement removeBtn;

        public Station(ExtendedWebDriver web, WebElement row) {
            this.web = web;
            List<WebElement> cells = row.findElements(getElementLocatorByNode("inline-display"));
            serviceLevel = cells.get(0).getText();
            destinationName = cells.get(1).getText();
            removeBtn = cells.get(2).findElement(getElementLocatorByNode("removeFromBookmark"));
        }

        public String getServiceLevel() {
            return serviceLevel;
        }

        public String getDestinationName() {
            return destinationName;
        }

        public void delete() {
            web.clickThroughJavascript(removeBtn);
        }

        private By getElementLocatorByNode(String rootNode) {
            return By.className(rootNode);
        }
    }

    public Station getStationByName(String name) {
        for (Station station : getStations())
            if (station.getDestinationName().equals(name))
                return station;
        return null;
    }

    public SaveBookmarkPopUp getSaveBookmarkPopUp() {
        if (!getDriver().isElementVisible(By.xpath(SaveBookmarkPopUp.TITLE_NODE)))
            pushBookmark();
        return new SaveBookmarkPopUp((OrderItemPage)parent, SaveBookmarkPopUp.TITLE);
    }

    public int getCountAutoCompleteBookmarks() {
        if (getDriver().isElementVisible(getAutoCompleteItemLocator()))
            return getDriver().findElements(getAutoCompleteItemLocator()).size();
        return 0;
    }

    public boolean isBookmarkButtonActive() {
        return !action.getAttribute("class").contains("disabled");
    }

    public void bookmark() {
        clickOkBtn();
    }

    public void clickBookmarkBtn() {
        pushBookmark();
    }

    private void pushBookmark() {
        action.click();
        waitUntilLoadSpinnerDisappears();
    }

    private List<Station> getStations() {
        if (!getDriver().isElementPresent(getStationRowLocator())) return null;
        List<WebElement> rows = getDriver().findElements(getStationRowLocator());
        List<Station> stations = new ArrayList<>();
        for (WebElement row : rows)
            stations.add(new Station(getDriver(), row));
        return stations;
    }

    private By getStationRowLocator() {
        return generateFormElementLocator(".row-save-bookmark");
    }

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }
}