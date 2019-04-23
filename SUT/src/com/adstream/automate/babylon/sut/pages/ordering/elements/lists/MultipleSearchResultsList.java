package com.adstream.automate.babylon.sut.pages.ordering.elements.lists;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.List;

/*
 * Created by demidovskiy-r on 29.05.2014.
 */
public class MultipleSearchResultsList extends AbstractList {
    public final static String ROOT_NODE = ".b-advancedsearch-result .b-list";

    public MultipleSearchResultsList(ExtendedWebDriver web) {
        super(web);
    }

    public static class SearchResult {
        private String syscode;
        private String station = "";
        private String market = "";

        public SearchResult(ExtendedWebDriver web, WebElement rowElement, boolean isFoundResult) {
            if (isFoundResult) {
                List<WebElement> cells = rowElement.findElements(By.className("inline-display"));
                syscode = getValue(cells, 0);
                station = getValue(cells, 1);
                market = getValue(cells, 2);
            } else
                syscode = rowElement.getText();
        }

        public String getSyscode() {
            return syscode;
        }

        public String getStation() {
            return station;
        }

        public String getMarket() {
            return market;
        }

        private String getValue(List<WebElement> cells, int index) {
            return cells.get(index).getAttribute("title");
        }
    }

    public SearchResult getSearchResultBySysCode(String syscode, boolean isFoundResult) {
        for (SearchResult searchResult : getSearchResults(isFoundResult))
            if (searchResult.getSyscode().equals(syscode))
                return searchResult;
        return null;
    }

    public List<String> getVisibleSysCodes(boolean isFoundResult) {
        List<String> syscodes = new ArrayList<>();
        List<SearchResult> searchResults = getSearchResults(isFoundResult);
        if (searchResults == null) return syscodes;
        for (SearchResult searchResult : searchResults)
            syscodes.add(searchResult.getSyscode());
        return syscodes;
    }

    @Override
    protected String getRootNode() {
        return ROOT_NODE;
    }

    @Override
    protected By generateListLocator(String partialLocator) {
        return By.cssSelector(getRootNode() + partialLocator);
    }

    private List<SearchResult> getSearchResults(boolean isFoundResult) {
        if (!web.isElementPresent(getSearchResultRowLocator(isFoundResult))) return null;
        List<WebElement> rows = web.findElements(getSearchResultRowLocator(isFoundResult));
        List<SearchResult> searchResults = new ArrayList<>();
        for (WebElement row : rows)
            searchResults.add(new SearchResult(web, row, isFoundResult));
        return searchResults;
    }

    private By getSearchResultRowLocator(boolean isFoundResult) {
        return isFoundResult ? generateListLocator(".mbm .pbs") : generateListLocator(":last-child .pbs");
    }
}