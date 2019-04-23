package com.adstream.automate.babylon.sut.pages.ordering.elements;

import com.adstream.automate.babylon.sut.pages.ordering.BaseOrderingPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import java.util.ArrayList;
import java.util.List;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 22.08.13
 * Time: 13:13
 */
public class OrderSlider extends BaseOrderingPage<OrderSlider> {
    private List<Tab> tabs;
    private final String ROOT_NOTE = ".slider";

    public OrderSlider(ExtendedWebDriver web) {
        super(web);
        tabs = getTabs();
    }

    public void load() {
        super.load();
        web.waitUntilElementAppearVisible(getOrderSliderLocator());
    }

    public void isLoaded() throws Error {
        super.isLoaded();
        assertTrue(web.isElementVisible(getOrderSliderLocator()));
    }

    public static class Tab {
        private WebElement tab;
        private String count;
        private String type;
        private String title;
        private ExtendedWebDriver web;

        public Tab(ExtendedWebDriver web, WebElement tab) {
            this.web = web;
            this.tab = tab;
            count = tab.findElement(By.className("count")).getText();
            type = tab.findElement(By.className("type")).getText();
            title = tab.findElement(By.className("title")).getText();
        }

        public String getCount() {
            return count;
        }

        public String getType() {
            return type;
        }

        public String getTitle() {
            return title;
        }

        public void selectTab() {
            if (!isSelected())
                tab.click();
            web.waitUntil(ExpectedConditions.stalenessOf(tab));
        }

        public boolean isSelected() {
            return tab.getAttribute("class").contains("selected");
        }
    }

    private List<Tab> getTabs(){
        if (!web.isElementPresent(By.cssSelector(ROOT_NOTE + " .item"))) return null;
        List<WebElement> tabs = web.findElements(By.cssSelector(ROOT_NOTE + " .item"));
        List<Tab> orderTabs = new ArrayList<Tab>();
        for (WebElement tab : tabs)
            orderTabs.add(new Tab(web, tab));
        return orderTabs;
    }

    private Tab getTabByTitle(List<Tab> tabs, String title){
        if (tabs == null) throw new NullPointerException("Tabs is not present in orders slider!");
        for (Tab tab : tabs)
            if (tab.getTitle().equalsIgnoreCase(title))
                return tab;
        return null;
    }

    public Tab getViewLiveOrdersTab() {
        return getTabByTitle(tabs, OrderStatus.VIEW_LIVE_ORDERS.getTitle());
    }

    public Tab getViewDraftOrdersTab() {
        return getTabByTitle(tabs, OrderStatus.VIEW_DRAFT_ORDERS.getTitle());
    }

    public Tab getViewHeldOrdersTab() {
        return getTabByTitle(tabs, OrderStatus.VIEW_HELD_ORDERS.getTitle());
    }

    public Tab getViewCompletedOrdersTab() {
        return getTabByTitle(tabs, OrderStatus.VIEW_COMPLETED_ORDERS.getTitle());
    }

    private By getOrderSliderLocator() {
        return By.cssSelector(ROOT_NOTE);
    }
}