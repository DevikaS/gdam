package com.adstream.automate.babylon.sut.pages.ordering.elements.forms;

import com.adstream.automate.babylon.sut.data.UsageRule;
import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.extendedwebdriver.ExtendedWebDriver;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.DojoCombo;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;
import java.util.ArrayList;
import java.util.List;

/*
 * Created by demidovskiy-r on 26.12.13.
 */
public class UsageRightSelectorForm extends AbstractForm {
    public static final String ROOT_NODE = "usageRightsForm";
    private static final String ADDED_USAGE_RIGHT_FORM = "[data-dojo-type='adbank.usageRights.usage_rights']";
    private DojoCombo usageType;
    private Button addUsageRule;

    public UsageRightSelectorForm(OrderItemPage parent) {
        super(parent);
        addUsageRule = new Button(parent, By.cssSelector("[data-role='add-usage-rule']"));
    }

    @Override
    protected void initControls() {
        controls.put("Usage Type", usageType = new DojoCombo(parent, By.className("usage-rights-selector")));
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

    public static class UsageRight {
        private String usageType;
        private String startDate;
        private String expireDate;
        private String country;
        private String artist;
        private String trackTitle;

        public UsageRight(ExtendedWebDriver web, WebElement usageRight) {
            usageType = usageRight.getAttribute("data-usagetype");
            composeUsageRight(usageType, usageRight);
        }

        public String getUsageType() {
            return usageType;
        }

        public String getStartDate() {
            return startDate;
        }

        public String getExpireDate() {
            return expireDate;
        }

        public String getCountry() {
            return country;
        }

        public String getArtist() {
            return artist;
        }

        public String getTrackTitle() {
            return trackTitle;
        }

        private void composeUsageRight(String usageType, WebElement usageRight) {
            switch (usageType) {
                case UsageRule.GENERAL : {
                    startDate = usageRight.findElement(generateDateLocator("Start Date")).getText();
                    expireDate = usageRight.findElement(generateDateLocator("Expiry Date")).getText();
                    break;
                }
                case UsageRule.COUNTRIES: {
                    List<WebElement> rows = usageRight.findElements(getItemListRowLocator());
                    List<WebElement> cells = rows.get(0).findElements(getRowsCellLocator()); // there is possibility to create separated object if need
                    country = cells.get(0).getText();
                    startDate = cells.get(1).getText();
                    expireDate = cells.get(2).getText();
                    break;
                }
                case UsageRule.MUSIC: {
                    List<WebElement> rows = usageRight.findElements(getItemListRowLocator());
                    List<WebElement> cells = rows.get(0).findElements(getRowsCellLocator()); // there is possibility to create separated object if need
                    WebElement expander = cells.get(0).findElement(By.className("expand-indicator"));
                    artist = cells.get(1).getText().trim();
                    trackTitle = cells.get(2).getText().trim();
                    startDate = cells.get(3).getText();
                    expireDate = cells.get(4).getText();
                    break;
                }
                default: throw new IllegalArgumentException("Unknown usage right type: " + usageType);
            }
        }

        private By generateDateLocator(String partialLocator) {
            return By.xpath("//*[contains(.,'" + partialLocator + "') and contains(@class,'unit')]/following-sibling::div");
        }

        private By getItemListRowLocator() {
            return By.cssSelector(".itemsList .row");
        }

        private By getRowsCellLocator() {
            return By.cssSelector(".unit .vmiddle");
        }
    }

    public List<UsageRight> getAddedUsageRights(){
        if (!getDriver().isElementVisible(getAddedUsageRightFormLocator()))
            throw new NoSuchElementException("There is no added usage right form on order item page!");
        if (!getDriver().isElementVisible(getUsageContainerLocator())) return null;
        List<WebElement> usageRightsElements = getDriver().findElements(getUsageContainerLocator());
        List<UsageRight> usageRights = new ArrayList<>();
        for (WebElement usageRightElement : usageRightsElements)
            usageRights.add(new UsageRight(getDriver(), usageRightElement));
        return usageRights;
    }

    public UsageRight getAddedUsageRightByUsageType(String usageType) {
        for (UsageRight usageRight : getAddedUsageRights())
            if (usageRight.getUsageType().equals(usageType))
                return usageRight;
        return null;
    }

    public List<String> getVisibleUsageRightTypes() {
        List<String> usageTypes = new ArrayList<>();
        List<UsageRight> usageRights = getAddedUsageRights();
        if (usageRights == null) return usageTypes;
        for (UsageRight usageRight : usageRights)
            usageTypes.add(usageRight.getUsageType());
        return usageTypes;
    }

    public AddUsageRightForm getAddUsageRightForm() {
        if (usageType.getDisplayedValue().isEmpty())
            throw new IllegalArgumentException("To need select usage right before add it!");
        if (!getDriver().isElementVisible(By.cssSelector(AddUsageRightForm.ROOT_NODE)))
            addUsageRule();
        return new AddUsageRightForm((OrderItemPage)parent);
    }

    private void addUsageRule() {
        addUsageRule.click();
    }

    private By getUsageContainerLocator() {
        return By.cssSelector(ADDED_USAGE_RIGHT_FORM + " [data-role='usageContainer']");
    }

    private By getAddedUsageRightFormLocator() {
        return By.cssSelector(ADDED_USAGE_RIGHT_FORM);
    }

    private By getFormLocator() {
        return By.className(getRootNode());
    }
}