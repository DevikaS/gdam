package com.adstream.automate.babylon.sut.pages.ordering.elements.popup;

import com.adstream.automate.babylon.sut.pages.BasePage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import java.util.ArrayList;
import java.util.List;

/*
 * Created by demidovskiy-r on 09.07.2014.
 */
public class SelectFromExistingFormatsPopUp extends AbstractPopUp {
    public final static String TITLE = "Select from existing formats";
    public final static String TITLE_NODE = generateTitleNode(TITLE);

    public SelectFromExistingFormatsPopUp(BasePage parentPage, String title) {
        super(parentPage, title);
    }

    @Override
    protected void loadPopUp() {
        web.waitUntilElementAppearVisible(getPopUpLocator());
    }

    @Override
    protected void unloadPopUp() {
        web.waitUntilElementDisappear(getPopUpLocator());
    }

    public static class AdCode {
        private ExtendedWebDriver web;
        private WebElement row;
        private String name;
        private WebElement selectIcon;

        public AdCode(ExtendedWebDriver web, WebElement row) {
            this.web = web;
            this.row = row;
            List<WebElement> units = row.findElements(By.className("unit"));
            name = units.get(0).getAttribute("value");
            selectIcon = units.get(1).findElement(By.className("spriteicon"));
        }

        public String getName() {
            return name;
        }

        public void selectAdCode() {
            if (!isSelectIconVisible()) {
                selectRow();
                web.waitUntil(ExpectedConditions.visibilityOf(selectIcon));
            }
        }

        private boolean isSelectIconVisible() {
            return selectIcon.isDisplayed();
        }

        private void selectRow() {
            row.click();
        }
    }

    public AdCode getAdCodeByName(String name) {
        for (AdCode adCode: getAdCodes())
            if (adCode.getName().equals(name))
                return adCode;
        return null;
    }

    public List<String> getVisibleAdCodeNames() {
        List<String> adCodeNames = new ArrayList<>();
        List<AdCode> adCodes = getAdCodes();
        if (adCodes == null) return adCodeNames;
        for (AdCode adCode: adCodes)
            adCodeNames.add(adCode.getName());
        return adCodeNames;
    }

    private List<AdCode> getAdCodes() {
        if (!web.isElementPresent(getAdCodeRowLocator())) return null;
        List<WebElement> rows = web.findElements(getAdCodeRowLocator());
        List<AdCode> adCodes = new ArrayList<>();
        for (WebElement row: rows)
            adCodes.add(new AdCode(web, row));
        return adCodes;
    }

    private By getAdCodeRowLocator() {
        return By.cssSelector(generatePopUpElement(".adCodePopupItem", false));
    }
}