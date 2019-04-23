package com.adstream.automate.babylon.sut.pages.ordering.elements.forms.subForms;

import com.adstream.automate.babylon.sut.pages.ordering.OrderItemPage;
import com.adstream.automate.babylon.sut.pages.ordering.elements.StepsOrderType;
import com.adstream.automate.babylon.sut.pages.ordering.elements.forms.AddMediaToOrderForm;
import com.adstream.automate.page.controls.Button;
import com.adstream.automate.page.controls.DojoSelect;
import com.adstream.automate.page.controls.Edit;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedCondition;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: demidovskiy-r
 * Date: 17.09.13
 * Time: 15:06
 */
public class AssetContainer extends AddMediaToOrderForm {
    public static final String ROOT_NODE = "#assetsContainer";
    private Edit search;
    private DojoSelect sortBy;
    private Button cancel;
    private Button addToOrder;
    private final long timeOfPaging = 2 * 60 * 1000; // 2 min;

    public AssetContainer(OrderItemPage parent) {
        super(parent);
        search = new Edit(parent, generateFormElementLocator(".b-search input"));
        sortBy = new DojoSelect(parent, generateFormElementLocator(".b-sort-control"));
        cancel = new Button(parent, generateFormElementLocator("[data-role='cancelBtn']"));
        addToOrder = new Button(parent, generateFormElementLocator("[data-role='addBtn']"));
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

    public static class Metadata {
        private String title;
        private String advertiser;
        private String product;
        private String clockNumber;
        private String clockNumberLabel;
        private String format;
        private String aspectRatio;

        public Metadata(WebElement metadataInfo, StepsOrderType stepsOrderType) {
            initFieldsDependsOnOrderType(metadataInfo, stepsOrderType);
        }

        public String getTitle() {
            return title;
        }

        public String getAdvertiser() {
            return advertiser;
        }

        public String getProduct() {
            return product;
        }

        public String getCampaign() {
            return product; // light hack: campaign value is taken from product DOM element for music
        }

        public String getClockNumber() {
            return clockNumber;
        }

        public String getClockNumberLabel() {
            return clockNumberLabel;
        }

        public String getFormat() {
            return format;
        }

        public String getAspectRatio() {
            return aspectRatio;
        }

        private void initFieldsDependsOnOrderType(WebElement metadataInfo, StepsOrderType stepsOrderType) {
            List<WebElement> infoValues;
            List<WebElement> infoLabels;
            switch (stepsOrderType) {
                case TV: {
                    WebElement fileParameters = metadataInfo.findElement(By.className("file-parameters"));
                    infoValues = fileParameters.findElements(By.cssSelector("[title]"));
                    infoLabels = fileParameters.findElements(By.className("bold"));
                    List<WebElement> infoDetails = fileParameters.findElements(By.className("file-detail"));
                    title = getElementValue(infoValues, 0);
                    clockNumber = getElementValue(infoValues, 1);
                    clockNumberLabel = getElementInfoType(infoLabels, 0);
                    format = infoDetails.get(0).getText();
                    aspectRatio = infoDetails.get(1).getText().trim();
                    break;
                }
                case MUSIC: {
                    infoValues = metadataInfo.findElements(By.cssSelector("span[title]"));
                    infoLabels = metadataInfo.findElements(By.className("info-type"));
                    title = getElementValue(infoValues, 0);
                    advertiser = getElementValue(infoValues, 1);
                    product = getElementValue(infoValues, 2);
                    clockNumber = getElementValue(infoValues, 3);
                    clockNumberLabel = getElementInfoType(infoLabels, 3);
                    aspectRatio = metadataInfo.findElement(By.className("info-hdmark")).getText();
                    break;
                }
                default: throw new IllegalArgumentException("Unknown order type: " + stepsOrderType.toString());
            }
        }

        private String getElementValue(List<WebElement> infoValues, int index) {
            return infoValues.get(index).getAttribute("title");
        }

        private String getElementInfoType(List<WebElement> infoTypes, int index) {
            return infoTypes.get(index).getText().trim().replaceAll(":", "");
        }
    }

    public void search(String name) {
        search.typeWithInterval(name, 10);
        waitUntilLoadSpinnerDisappears();
    }

    public Metadata getMetadataByContentName(String contentName, StepsOrderType stepsOrderType) {
        if (!isContentVisible(contentName)) return null;
        WebElement metadataInfo = getDriver().findElement(getMetadataInfoLocator(contentName));
        return new Metadata(metadataInfo, stepsOrderType);
    }

    public void scrollToPage(int pageNumber) {
        scrollToBegin();
        int i = 1;
        while (i < pageNumber && isScrollRightVisible()) {
            scrollToRight();
            i++;
        }
    }

    public boolean isContentVisibleOverPages(String contentName) {
        scrollToBegin();
        long start = System.currentTimeMillis();
        while (!isContentVisible(contentName) && isScrollRightVisible()) {
            scrollToRight();
            if (isContentVisible(contentName)) return true;
            if (System.currentTimeMillis() - start > timeOfPaging)
                throw new TimeoutException("Time out while scrolling over pages!");
        }
        return isContentVisible(contentName);
    }

    public boolean isContentVisible(String contentName) {
        return getDriver().isElementVisible(getContentTitleLocatorByName(escapeName(contentName)));
    }

    public OrderItemPage addMediaContentToOrder(String contentNames) {
        selectContent(contentNames);
        clickAddToOrderButton();
        unloadForm();
        return new OrderItemPage(getDriver());
    }

    public OrderItemPage addProjectsContentToOrder(String projectName, String path, String contentNames) {
        moveToProjectFolder(projectName, path);
        return addMediaContentToOrder(contentNames);
    }

    public void selectContent(String contentNames) {
        selectContentByName(contentNames);
        getDriver().waitUntil(ADD_TO_ORDER_BECOME_ENABLED);
        getDriver().sleep(500);
    }

    public void clickAddToOrderButton() {
        addToOrder.click();
        waitUntilLoadSpinnerDisappears();
    }

    public void openProjectFolder(String projectName, String path){
        if (!isInProjectsFolder(projectName, path))
            moveToProjectFolder(projectName, path);
    }

    public String getProjectsNavigationPath() {
        return getDriver().findElement(getProjectsNavigatorLocator()).getText();
    }

    public String getMediaCounters() {
        return getDriver().findElement(getMediaCountersLocator()).getText();
    }

    private void selectContentByName(String names) {
        for (String name : names.split(",")) {
            if (getDriver().isElementPresent(getContentPreviewLocator(name)))
                getDriver().clickThroughJavascript(getContentPreviewLocator(name));
            else
                throw new NoSuchElementException("No content with name: " + name);
        }
    }

    private void moveToProjectFolder(String projectName, String path) {
        scrollToBegin();
        long start = System.currentTimeMillis();
        while (!isContentVisible(projectName) && isScrollRightVisible()) {
            scrollToRight();
            if (isContentVisible(projectName)) break;
            if (!isContentVisible(projectName) && !isScrollRightVisible())
                throw new NullPointerException("No project with following name: " + projectName);
            if (System.currentTimeMillis() - start > timeOfPaging)
                throw new TimeoutException("Time out while scrolling over projects pages!");
        }
        getDriver().click(getContentTitleLocatorByName(projectName));
        if (!path.isEmpty()) {
            String[] pathParts = path.split("/");
            for (String pathPart : pathParts) {
                getDriver().waitUntilElementAppearVisible(getContentTitleLocatorByName(pathPart));
                getDriver().click(getContentTitleLocatorByName(pathPart));
                waitUntilLoadSpinnerDisappears();
            }
        }
    }

    private void scrollToBegin() {
        long start = System.currentTimeMillis();
        while (isScrollLeftVisible()) {
            getDriver().clickThroughJavascript(getScrollLeftLocator());
            getDriver().waitUntilElementAppearVisible(getScrollRightLocator());
            if (System.currentTimeMillis() - start > timeOfPaging)
                throw new TimeoutException("Time out while scrolling to begin!");
        }
    }

    private void scrollToRight() {
        getDriver().clickThroughJavascript(getScrollRightLocator());
        waitUntilLoadSpinnerDisappears();
        getDriver().waitUntilElementAppearVisible(getScrollLeftLocator());
    }

    private boolean isInProjectsFolder(String projectName, String path) {
        return getProjectsNavigationPath().equals(generateProjectsNavigatorPath(projectName, path));
    }

    private String generateProjectsNavigatorPath(String projectName, String path) {
        StringBuilder sb = new StringBuilder();
        sb.append("Projects > ").append(projectName);
        if (!path.isEmpty()) {
            sb.append(" > ");
            String[] pathParts = path.split("/");
            for (int i = 0; i < pathParts.length; i++) {
                sb.append(pathParts[i]);
                if (i != pathParts.length - 1) sb.append(" > ");
            }
        }
        return sb.toString();
    }

    private String escapeName(String name) {
        return name.contains("\"") ? name.replace("\"", "\\\"") : name;
    }

    private ExpectedCondition<Boolean> ADD_TO_ORDER_BECOME_ENABLED = new ExpectedCondition<Boolean>() {
        public Boolean apply(WebDriver webDriver) {
            return webDriver.findElement(generateFormElementLocator("[data-role='addBtn']")).isEnabled();
        }
    };

    private By getContentPreviewLocator(String contentName) {
        return By.xpath(String.format("//*[following-sibling::*[starts-with(@class,'info') and descendant::*[@title=\"%s\"]]]", contentName));
    }

    private By getMetadataInfoLocator(String contentName) {
        return By.xpath(String.format("//*[starts-with(@class,'info') and descendant::*[@title=\"%s\"]]", contentName));
    }

    private By getContentTitleLocatorByName(String contentName) {
        return generateFormElementLocator(String.format(".info [title=\"%s\"]", contentName));
    }

    private By getMediaCountersLocator() {
        return generateFormElementLocator("[data-role='counters']");
    }

    private By getProjectsNavigatorLocator() {
        return generateFormElementLocator("[data-dojo-type='ordering.form.assets.ProjectsNavigator']");
    }

    private boolean isScrollRightVisible() {
        return getDriver().isElementVisible(getScrollRightLocator());
    }

    private boolean isScrollLeftVisible() {
        return getDriver().isElementVisible(getScrollLeftLocator());
    }

    private By getScrollRightLocator() {
        return generateScrollLocator("scroll-right");
    }

    private By getScrollLeftLocator() {
        return generateScrollLocator("scroll-left");
    }

    private By generateScrollLocator(String partialLocator) {
        return generateFormElementLocator(String.format(".b-pointer[data-role='%s']", partialLocator));
    }

    private By getFormLocator() {
        return By.cssSelector(generateMediaContentLocator(MediaContent.LIBRARY.toString()) + "," + generateMediaContentLocator(MediaContent.PROJECTS.toString()));
    }
}