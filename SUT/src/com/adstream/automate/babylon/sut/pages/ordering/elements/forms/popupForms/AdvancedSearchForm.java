package com.adstream.automate.babylon.sut.pages.ordering.elements.forms.popupForms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderingPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AbstractForm;
import com.adstream.automate.babylon.sut.pages.ordering.elements.popup.AbstractPopUpLayer;
import com.adstream.automate.page.AbstractControl;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.DojoCombo;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
 * Created by demidovskiy-r on 01.09.2014.
 */
public class AdvancedSearchForm extends AbstractPopUpLayer {
    public final static String ROOT_NODE = POPUP_ROOT_NODE + " .b-advanced-search";
    private DojoCombo from;
    private DojoCombo to;
    private DojoCombo quickSelection;

    public AdvancedSearchForm(OrderingPage parent) {
        super(parent);
        action = new Button(parent, generatePopUpElementLocator("+ * [name='Ok']"));
    }

    @Override
    protected void initControls() {
        controls.put(Control.FROM.toString(), from = new DojoCombo(parent, generateFormElementLocator(".rangeFrom")));
        controls.put(Control.TO.toString(), to = new DojoCombo(parent, generateFormElementLocator(".rangeTo")));
        controls.put(Control.QUICK_SELECTION.toString(), quickSelection = new DojoCombo(parent, generateFormElementLocator(".rangeSelect")));
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

    @Override
    public void fill(Map<String, String> fields) {
        List<Map<String, String>> searchByKeys = new ArrayList<>();
        List<Map<String, String>> searchByValues = new ArrayList<>();
        if (fields.containsKey("Search By")) {
            for (String searchBy: fields.get("Search By").split(",")) {
                String[] searchByCriteria = searchBy.split("=");
                Map<String, String> searchByKey = new HashMap<>();
                Map<String, String> searchByValue = new HashMap<>();
                searchByKey.put(Control.SEARCH_BY_KEY.toString(), searchByCriteria[0]);
                searchByValue.put(Control.SEARCH_BY_VALUE.toString(), searchByCriteria[1]);
                searchByKeys.add(searchByKey);
                searchByValues.add(searchByValue);
            }
            fields.remove("Search By");
        }
        if (!searchByKeys.isEmpty() && !searchByValues.isEmpty()) {
            if (searchByKeys.size() != searchByValues.size()) throw new IllegalArgumentException("Search by keys count should be equals search by values count!");
            for (int i = 0; i < searchByKeys.size(); i++) {
                SearchBy searchBy = getSearchByList().get(i);
                searchBy.fill(searchByKeys.get(i));
                searchBy.initActiveSearchByValueControl();
                searchBy.fill(searchByValues.get(i));
                searchBy.addSearchBy();
            }
        }
        super.fill(fields);
    }

    public static class SearchBy extends AbstractForm {
        private WebElement searchBy;
        private DojoCombo searchByKey;
        private AbstractControl searchByValue;
        private Button addButton;
        private Button removeButton;

        public SearchBy(OrderingPage parent, WebElement searchBy) {
            super(parent);
            this.searchBy = searchBy;
        }

        @Override
        protected void initControls() {
            controls.put(Control.SEARCH_BY_KEY.toString(), searchByKey = new DojoCombo(parent, searchBy.findElement(By.cssSelector(".display-table-cell:first-child > .dijitComboBox"))));
        }

        @Override
        protected void loadForm() {
        }

        @Override
        protected void unloadForm() {
        }

        @Override
        protected String getRootNode() {
            return ROOT_NODE;
        }

        public void addSearchBy() {
            int searchByCount = getDriver().findElements(getSearchByRowLocator()).size();
            clickAddBtn();
            waitUntilSearchByWillBeAdded(searchByCount);
        }

        public void removeSearchBy() {
            int searchByCount = getDriver().findElements(getSearchByRowLocator()).size();
            clickRemoveBtn();
            waitUntilSearchByWillBeRemoved(searchByCount);
        }

        public void initActiveSearchByValueControl() {
            getDriver().waitUntilElementAppearVisible(getActiveCommonSearchByValueControlLocator());
            if (getDriver().isElementPresent(generateFormElementLocator(getActiveSearchByValueComboBox())))
                controls.put(Control.SEARCH_BY_VALUE.toString(), searchByValue = new DojoCombo(parent, searchBy.findElement(generateSearchByValueControlLocator(".dijitComboBox"))));
            else if (getDriver().isElementPresent(generateFormElementLocator(getActiveSearchByValueInput())))
                controls.put(Control.SEARCH_BY_VALUE.toString(), searchByValue = new Edit(parent, searchBy.findElement(generateSearchByValueControlLocator(".value"))));
            else
                throw new NoSuchElementException("There are no any active Search by value controls on the page!");
        }

        private void waitUntilSearchByWillBeAdded(final int searchByCount) {
            getDriver().waitUntil(new ExpectedCondition<Boolean>() {
                public Boolean apply(WebDriver webDriver) {
                    return webDriver.findElements(getSearchByRowLocator()).size() == (searchByCount + 1);
                }
            });
        }

        private void waitUntilSearchByWillBeRemoved(final int searchByCount) {
            getDriver().waitUntil(new ExpectedCondition<Boolean>() {
                public Boolean apply(WebDriver webDriver) {
                    return webDriver.findElements(getSearchByRowLocator()).size() == (searchByCount - 1);
                }
            });
        }

        private void clickAddBtn() {
            if (addButton == null)
                addButton = new Button(parent, searchBy.findElement(By.className("addBtn")));
            addButton.click();
        }

        private void clickRemoveBtn() {
            if (removeButton == null)
                removeButton = new Button(parent, searchBy.findElement(By.className("removeBtn")));
            removeButton.click();
        }

        private By getActiveCommonSearchByValueControlLocator() {
            String activeCommonSearchByValueControlLocator = String.format("%s %s,%s %s", getRootNode(), getActiveSearchByValueComboBox(), getRootNode(), getActiveSearchByValueInput());
            return By.cssSelector(activeCommonSearchByValueControlLocator);
        }

        private String getActiveSearchByValueComboBox() {
            return generateActiveSearchByValueControl(".dijitComboBox:not([class*='dijitDisabled'])");
        }

        private String getActiveSearchByValueInput() {
            return generateActiveSearchByValueControl(".value:not([disabled*='disabled'])");
        }

        private String generateActiveSearchByValueControl(String partialLocator) {
            return String.format("%s %s", "[id*='ordering_main_advancedSearchForm'] .display-table-cell:last-child", partialLocator);
        }

        private By generateSearchByValueControlLocator(String partialLocator) {
            return By.cssSelector(String.format("%s %s", ".display-table-cell:last-child", partialLocator));
        }
    }

    public SearchBy getSearchByByFilterName(String filterName) {
        for (SearchBy searchBy: getSearchByList())
            if (searchBy.getFieldValue(Control.SEARCH_BY_KEY.toString()).equals(filterName))
                return searchBy;
        return null;
    }

    public int getSearchByFiltersCount() {
        return getDriver().findElements(getSearchByFilterLocator()).size();
    }

    private List<SearchBy> getSearchByList() {
        if (!getDriver().isElementVisible(getSearchByRowLocator()))
            throw new NoSuchElementException("There are no any Search by controls on Advanced Search form!");
        List<WebElement> rows = getDriver().findElements(getSearchByRowLocator());
        List<SearchBy> searchByList = new ArrayList<>();
        for (WebElement row: rows)
            searchByList.add(new SearchBy((OrderingPage)parent, row));
        return searchByList;
    }

    private enum Control {
        SEARCH_BY_KEY("Search By Key"),
        SEARCH_BY_VALUE("Search By Value"),
        FROM("From"),
        TO("To"),
        QUICK_SELECTION("Quick Selection");

        private String name;

        private Control(String name) {
            this.name = name;
        }

        @Override
        public String toString() {
            return name;
        }
    }

    // filter is added Search by criteria
    private By getSearchByFilterLocator() {
        return generateFormElementLocator(".formRow");
    }

    private static By getSearchByRowLocator() {
        return By.cssSelector(String.format("%s %s", ROOT_NODE, "[id*='ordering_main_advancedSearchForm']"));
    }

    private By getFormLocator() {
        return By.cssSelector(getRootNode());
    }
}