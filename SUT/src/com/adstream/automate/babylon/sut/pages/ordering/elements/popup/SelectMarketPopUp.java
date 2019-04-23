package com.adstream.automate.babylon.sut.pages.ordering.elements.popup;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.page.controls.DojoCombo;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 28.08.13
 * Time: 14:18
 */
public class SelectMarketPopUp extends AbstractPopUp {
    public final static String TITLE = "Select market";
    public final static String TITLE_NODE = generateTitleNode(TITLE);
    private DojoCombo market;

    public SelectMarketPopUp(OrderItemPage parentPage, String title) {
        super(parentPage, title);
        market = new DojoCombo(parentPage, generateLocator("+ * [data-dojo-type='ordering.form.MarketSelector'] .dijitComboBox"));
    }

    public void loadPopUp() {
        web.waitUntilElementAppearVisible(getPopUpLocator());
    }

    public void unloadPopUp() {
        web.waitUntilElementDisappear(getPopUpLocator());
    }

    public void selectMarketByName(String marketName) {
        market.selectByVisibleText(marketName);
    }

    public List<String> getAvailableMarkets() {
        return market.getValues();
    }
}