package com.adstream.automate.babylon.sut.pages.ordering;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.Control;
import org.openqa.selenium.By;
import java.util.List;
import static com.thoughtworks.selenium.SeleneseTestBase.assertTrue;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 20.08.13
 * Time: 18:29
 */
public class BaseOrderingPage<T> extends BasePage<T> {
    protected Control container;

    public BaseOrderingPage(ExtendedWebDriver web) {
        super(web);
    }

    public void load() {
        super.load();
        waitUntilLoadSpinnerDisappears();
        container.visible();
    }

    public void isLoaded() throws Error {
        super.isLoaded();
        getDriver().waitUntilElementDisappear(By.className("orders-spinner"));
        assertTrue(container.isVisible());
        assertTrue("Check js errors at the page: ", getJsErrorsAtPage().isEmpty());
    }

    @Override
    public void init() {
        container = new Control(this, By.className("ordering"));
    }

    public BaseOrderingPage switchOrdersTab(String orderType){
        web.waitUntilElementAppearVisible(getOrderSwitcherLocator());
        web.findElement(generateOrdersSwitcherLinkLocator(orderType)).click();
        return this;
    }

    public boolean isSwitcherSelected(String orderType) {
        return web.findElement(generateOrdersSwitcherLinkLocator(orderType)).getAttribute("class").contains("defaultLink");
    }

    protected void waitUntilLoadSpinnerDisappears() {
        getDriver().waitUntilElementDisappear(By.className("orders-spinner"));
        getDriver().sleep(1000);
    }

    protected By getAutoCompleteItemLocator() {
        return  By.className("ac-result-list-item");
    }

    private By generateOrdersSwitcherLinkLocator(String orderType) {
        return By.cssSelector("[href*='" + orderType + "']");
    }

    private By getOrderSwitcherLocator() {
        return By.className("b-order-switcher");
    }

    private List<String> getJsErrorsAtPage(){
        String script = "var jsErrors = [];\n" +
                "window.onerror = function(errorMsg, url, lineNumber){\n" +
                "jsErrors.push(\n" +
                "errorMsg + ' (found at ' + url + ', line ' + lineNumber + ')');\n" +
                "};\n" +
                "return jsErrors;";
        return (List<String>)web.getJavascriptExecutor().executeScript(script);
    }
}