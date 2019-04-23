package com.adstream.automate.babylon.sut.pages.admin.metadata;

import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.DojoCombo;
import org.openqa.selenium.By;
import java.util.List;

/*
 * Created by demidovskiy-r on 21.11.2014.
 */
public class GlobalCommonOrderingMetadataPage extends GlobalMetadataPage {
    private final String ROOT_NODE = "[data-dojo-type='admin.metadata.table_setup_ordering']";
    private DojoCombo market;

    public GlobalCommonOrderingMetadataPage(ExtendedWebDriver web) {
        super(web);
        market = new DojoCombo(this, generatePageElementLocator(".select"));
    }

    public void selectMarket(String marketName) {
        market.selectByVisibleText(marketName);
    }

    public String getMarket() {
        return market.getDisplayedValue();
    }

    public List<String> getAvailableMarkets() {
        return market.getValues();
    }

    public boolean isMarketEnabled() {
        return market.isEnabled();
    }

    private By generatePageElementLocator(String partialLocator) {
        return By.cssSelector(String.format("%s %s", getRootNode(), partialLocator));
    }

    protected String getRootNode() {
        return ROOT_NODE;
    }
}